Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04011702b2968b4fed72@[209.86.155.184]>
In-Reply-To: <Pine.LNX.3.95.981210151530.9578B-100000@pacific.pht.com>
Date: Fri, 11 Dec 1998 00:47:30 -0800
To: Brad Midgley <brad@pht.com>, linuxppc-dev@lists.linuxppc.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: framebuffer inconsistencies
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 3:42 PM -0700 12/10/98, Brad Midgley wrote:
>there are some inconsistencies and recent problems with having multiple
>video cards with recent kernels. some of the problems might actually be
>driver problems in the ati xclaim vr driver.
>
>1. i used to be able to put consoles on both my monitors using
>video=map:001 (i never tried the userland programs for setting up
>consoles) however now, the fb1 screen only shows the blinking underline
>cursor; no text appears although i can tell by the position of the cursor
>that it is successfully running login on that console
>
>2. the secondary monitor went spiralling into a bad video mode once when i
>changed from console 3 to 6. it never recovered.
>
>3. fbset -s -fb /dev/fb1 doesn't really get the settings for the second
>video/monitor. it returns the settings for fb0.
>
>i've been digging in the kernel to see why (3) is happening.
>
>fb0 is a control-driven nec xv17+
>fb1 is a ati xclaimvr-driven apple 14" fixed-frequency monitor
>
>any pointers?

With two ATI devices in the system, the kernel crashes during boot in
aty_init().  I've been meaning to look into this problem for a long time,
but haven't had a chance to do the things I need to (at this point, I
either need to gain better understanding of how fb works, or get the time
to sit down and trace through aty_init() with xmon to really figure out
what's going on).

Based on (3), perhaps some code reads/writes the wrong fb data structure
when there are multiple fb devices around.

  Tim Seufert

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
