Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011702b2ba47551c9a@[209.86.156.161]>
Date: Thu, 7 Jan 1999 03:34:27 -0800
To: linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Hack to chipsfb to support external monitor
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I really, really needed external monitor support for use of my 2400 at
work, so I did a cheap hack to chipsfb to get it going.  Basically I added
a chipsfb_setup() routine to chipsfb.c (and the appropriate entry in
fbmem.c) which looks for a kernel command line parameter "mac1024".  If it
gets it, it sets a global variable named mac1024 to 1.  I then sprinkled
checks on mac1024 throughout chipsfb: basically, if it is 1, chipsfb
assumes that you booted through BootX and had MacOS configured for a
1024x768 8-bit display on the external monitor port.  It will not touch any
65550 registers except for palette.

The last is actually why I did this -- booting with "no video driver"
checked works, except that offb doesn't know where the palette registers
are and can't set them, so X is pretty miserable.  I looked at doing
something similar to the offb aty hacks, but it looked like it would not
have been as simple (I needed to find/map the PCI I/O space of the 65550 to
set up the pointer to the palette registers, and it turns out to be awkward
to do that in offb due to the way it is structured).

As hacks go it's fairly clean, but it's still a hack.  I plan to make an
attempt at doing this the right way later, but I thought I'd let people
know since there may be others who really need 1024x768 on the external
monitor port *now*.  If anybody is interested let me know and I'll get you
the diffs.

It does at least lay the groundwork for having chipsfb support command line
parameters, so it's not all bad.  :)

  Tim Seufert

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
