use <vertex.scad>

$fs=1;
$fa=1;

module plate()
{
    hull()
    for (r=[0,1,2])
    rotate([0,0,120*r])
    translate([0,135])
    {
          circle(r=40.5, center=true);
    }
}

module top_plate()
{
    difference()
    {
        plate();
        for (r=[0,1,2])
        rotate([0,0,120*r])
        translate([0,150])
        hull()
        {
              circle(r=10, center=true);
              translate([0,11.5]) circle(d=6);
        }
    }
}

module base_plate()
{
    difference()
    {
        top_plate();
        circle(d=160);
    }
}

module electronics_plate(show_pcbs)
{
    difference()
    {
        intersection()
        {
            plate();
            difference()
            {
                for(r=[0,120,240]) rotate([0,0,r]) translate([0,-18]) square([90,180], center=true);
            }
        }
        for(r=[0,120,240]) rotate([0,0,r]) for(x=[35,-35]) translate([x,-97.5]) circle(d=6);
        translate([0,-50]) rotate([0,0,90]) mks_mini(show_pcbs);
        rotate([0,0,150]) translate([65,-17]) pi2(show_pcbs, true);
        rotate([0,0,30]) translate([65,0]) fetboard(show_pcbs);

        for (x=[-40:10:20])
            rotate([0,0,-60]) translate([x,-65]) ziptie();

        for (x=[-30:10:10])
            rotate([0,0,-60-120]) translate([x,-65]) ziptie();


        for (x=[-20:10:-10])
            rotate([0,0,-60-120]) translate([x,-20]) ziptie();

        for (x=[-20:10:20])
            rotate([0,0,-60-240]) translate([x,-65]) ziptie();

        rotate([0,0,30]) translate([65,0]) rotate([0,0,45]) 40mmfan();
        rotate([0,0,30-120]) translate([70,0]) rotate([0,0,45]) 40mmfan();

        rotate([0,0,150]) translate([60,20]) switcher(show_pcbs);

    }
}

module mks_mini(show_pcb)
{
    if (show_pcb)
    {
        color("red") square([115,66], center=true);
    }
    translate([115/2, 66/2])
    {
        translate([-115+15.2, -10.2]) circle(d=2.5);
        translate([-115+15.2, -66+7.5]) circle(d=2.5);

        translate([-49, -25.4]) circle(d=2.5);
        translate([-49, -66+12.6]) circle(d=2.5);

        translate([-24.8, -10.2]) circle(d=2.5);
        translate([-18.5, -66+7.5]) circle(d=2.5);
    }
}

module pi2(show_pcb, show_cutout)
{
    if (show_pcb)
    {
        color("red") square([85,49], center=true);
    }
    if (show_cutout)
    {
        difference()
        {
            union()
            {
                square([85,49], center=true);
                translate([-85/2,0]) circle(d=49-13-13);
            }
            union()
            {
                translate([-85/2, -(49/2)+49-13]) square([7,13]);
                translate([-85/2, -(49/2)]) square([7,13]);

                translate([-85/2+58, -(49/2)+49-10]) square([8,10]);
                translate([-85/2+58, -(49/2)]) square([8,10]);

                translate([(85/2)-22, -(49/2)]) square([3,49]);

                translate([(85/2)-3, -(49/2)]) square([3,49]);
            }
        }
    }
    translate([85/2, 49/2])
    {
        translate([-85+3.5, -3.5]) circle(d=2.5);
        translate([-85+3.5, -49+3.5]) circle(d=2.5);

        translate([-85+58+3.5, -3.5]) circle(d=2.5);
        translate([-85+58+3.5, -49+3.5]) circle(d=2.5);
    }
}

module fetboard(show_pcb)
{
    if (show_pcb)
    {
        color("red") square([50,50], center=true);
    }
    for(x=[-1,1])
    for(y=[-1,1])
    translate([x*(50-7)/2,y*(50-7)/2]) circle(d=2.5);
}

module switcher(show_pcb)
{
    if (show_pcb)
    {
        color("red") square([43,20], center=true);
    }

    translate([-30,0]) rotate([0,0,90]) ziptie();
    translate([30,0]) rotate([0,0,90]) ziptie();

    translate([43/2, 20/2])
    {
        translate([-6, -2.5]) circle(d=2.5);
        translate([-43+7, -20+2.5]) circle(d=2.5);
    }
}

module ziptie(width=4)
{
    for(x=[-1,1])
    translate([x*(width/2),0])
    square([2,4], center=true);
}

module 40mmfan()
{
    for(x=[-1,1])
    for(y=[-1,1])
    translate([x*32/2, y*32/2])
    circle(d=4.2);

    intersection()
    {
        circle(d=38);
        rotate([0,0,45]) union()
        {
            for(x=[-60:6:60])
                translate([x, 0])
                    square([4, 50], center=true);
        }
    }
}

//color("black") for (r=[0,120,240]) rotate([0,0,r]) translate([0,-98.5, 11]) cube([240, 20, 20], center=true);
//color("black") for (r=[60,180,300]) rotate([0,0,r]) translate([0,-161.5, 11]) cube([20, 20, 20], center=true);
//color("orange") for (r=[60,180,300]) rotate([0,0,r]) translate([0,-161.5, 11]) vertex(20,1,1);

electronics_plate();

//switcher(true);
