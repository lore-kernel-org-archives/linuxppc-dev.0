Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: Why bridge disable VGA_EN?
Date: Sun, 18 Nov 2001 08:28:34 -0500
MIME-Version: 1.0
Message-Id: <20011118132547.LOZZ25459.tomts20-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Okay, I have upgraded to XFree86 CVS HEAD and rebuilt and made a few fixes
for radeon DFP support and now every time I try to use a vgaHW function I
get segfaults.

I have had to literally remove the vgaHW***   functions from the
radeon_driver.c and the X driver works flawlessly (as long as I don't set
useFBDev).

I can't figure out why these calls are causing such havoc when my other
card (a Rage128) on bus 0 works flawlessly with these functions.

The radeon is on Bus 1.  I noticed the following in the XFree86 log:

II) Bus 0: bridge is at (0:0:0), (-1,0,0), BCTRL: 0x08 (VGA_EN is set)
(II) Bus 0 I/O range:
        [0] -1  0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
        [0] -1  0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
        [0] -1  0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 1: bridge is at (0:13:0), (0,1,1), BCTRL: 0x06 (VGA_EN is cleared)
(II) Bus 1 I/O range:
        [0] -1  0x00001000 - 0x000010ff (0x100) IX[B]
        [1] -1  0x00001400 - 0x000014ff (0x100) IX[B]
        [2] -1  0x00001800 - 0x000018ff (0x100) IX[B]
        [3] -1  0x00001c00 - 0x00001cff (0x100) IX[B]



What is the VGA_EN bit and why is it cleared on Bus 1 but enabled on Bus 0?

Is this the cause of my vgaHW problems?

Any help or guidance here would be greatly appreciated.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
