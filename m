Mime-Version: 1.0
Message-Id: <v04220804b5d51c963eff@[10.0.0.42]>
In-Reply-To: <39AE8559.A4F12B6D@relog.ch>
References: 
 <Pine.A41.4.21.0008311751210.17008-100000@c2.hrz.uni-giessen.de>
 <39AE8559.A4F12B6D@relog.ch>
Date: Fri, 1 Sep 2000 03:22:37 -0700
To: daenzerm@student.ethz.ch
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: asm statement in include/asm not ansi conform
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hey Michel,

I have DRI working too, on a B&W G3 500 MHz with a 100 MHz R128.
Thanks for getting it to work!

I do have one non-DRI problem.  The r128 module for XF4 has some
problems initializing my variant of the Rage 128 correctly.  Here's
the relevant part of the startup log:

==================================================================
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/XF86-DRI/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
         compiled for 4.0.1, module version = 0.0.1
         ABI class: XFree86 Video Driver, version 0.2
(--) r128(0): Chipset: "ATI Rage 128 RE (PCI)" (ChipID = 0x5245)
(--) r128(0): Linear framebuffer at 0x84000000
(--) r128(0): MMIO registers at 0x80900000
(--) r128(0): BIOS at 0x80920000
(--) r128(0): VideoRAM: 16384 kByte (128-bit SDR SGRAM 1:1)
(**) r128(0): Forced into PCI-only mode
(II) r128(0): PLL parameters: rf=18432 rd=45949 min=-2143223788 max=2088639352;
xclk=0
(==) r128(0): Using gamma correction (1.0, 1.0, 1.0)
(II) r128(0): Monitor0: Using hsync range of  30.00- 95.00 kHz
(II) r128(0): Monitor0: Using vrefresh range of  48.00-160.00 Hz
(II) r128(0): Clock range: -2143223.79 to -588442.96 MHz
(WW) r128(0): Mode "640x350" deleted (bad mode clock/interlace/doublescan)
(WW) r128(0): Mode "640x400" deleted (bad mode clock/interlace/doublescan)
(WW) r128(0): Mode "720x400" deleted (bad mode clock/interlace/doublescan)

[lots of mode deletes snipped]

(WW) r128(0): Mode "1856x1392" deleted (bad mode clock/interlace/doublescan)
(WW) r128(0): Mode "1920x1440" deleted (bad mode clock/interlace/doublescan)
(WW) r128(0): Mode "1920x1440" deleted (bad mode clock/interlace/doublescan)
(WW) r128(0): Mode pool is empty
(--) r128(0): Virtual size is 1024x768 (pitch 1024)
(**) r128(0): Built-in mode "current": 78.7 MHz, 60.0 kHz, 75.0 Hz
(==) r128(0): DPI set to (75, 75)
==================================================================


I'm using fbdev instead of vga as you had set up the example config
file, but the misdetection of the clock and subsequent deletion of
all the modes happens either way.  The only difference is that with
fbdev it appears to default back to a built-in 1024x768 mode, so that
the X server can actually start; in vga mode it just aborts due to
not having any valid modes.

For comparison, this is what I get with a mainline 4.0.1 tree with
Ani Joshi's replacement drivers for PPC (no DRI support of course):

==================================================================
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
         compiled for 4.0.1, module version = 0.0.1
         ABI class: XFree86 Video Driver, version 0.2
(--) r128(0): Chipset: "ATI Rage 128 RE (PCI)" (ChipID = 0x5245)
(--) r128(0): Linear framebuffer at 0x84000000
(--) r128(0): MMIO registers at 0x80900000
(--) r128(0): BIOS at 0x80920000
(--) r128(0): VideoRAM: 16384 kByte (128-bit SDR SGRAM 1:1)
(II) r128(0): PLL parameters: rf=2950 rd=50 min=12500 max=25000; xclk=10001
(==) r128(0): Using gamma correction (1.0, 1.0, 1.0)
(II) r128(0): Monitor0: Using hsync range of  30.00- 95.00 kHz
(II) r128(0): Monitor0: Using vrefresh range of  48.00-160.00 Hz
(II) r128(0): Clock range:  12.50 to 250.00 MHz
(WW) r128(0): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(0): Mode "1792x1344" deleted (bad mode clock/interlace/doublescan)
(WW) r128(0): Mode "1856x1392" deleted (bad mode clock/interlace/doublescan)
(WW) r128(0): Mode "1920x1440" deleted (bad mode clock/interlace/doublescan)
(--) r128(0): Virtual size is 1280x960 (pitch 1280)
(**) r128(0): Default mode "1280x960": 148.5 MHz, 85.9 kHz, 85.0 Hz
(==) r128(0): DPI set to (75, 75)
==================================================================

This could be something as simple as an endianness problem, but I
don't have the time at the moment to track down where in the code
this probing is being done.

I have checked out a copy of the PPC branch of the DRI CVS tree, so
if you need me to test with different things just let me know.

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
