To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
References: <A6E33C4E-FB6C-11D7-9C03-000393467F1A@arlut.utexas.edu>
	<1065823660.601.0.camel@gaston>
	<hhk77bv495.fsf@pygar.theorie.physik.uni-muenchen.de>
	<1065953260.992.11.camel@gaston>
Reply-To: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
From: Jens Schmalzing <jens.schmalzing@physik.uni-muenchen.de>
Date: 12 Oct 2003 14:18:43 +0200
Message-ID: <hhhe2ek5ss.fsf@pygar.theorie.physik.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Benjamin Herrenschmidt writes:

> > 1. The resulting kernel is more than 30MB in size.  Is this normal?
>
> That's not normal, something must be wrong in your kernel build

As Sam Ravnborg suggested, I removed CONFIG_DEBUG_INFO, which brought
the size down to normal (still around 4MB, but I guess that's just the
way it is in 2.6).  Also, startup appears a lot snappier.

> > 2. The accelerated framebuffer has the right size, but flickers a lot.

> What do you mean by "flickers" ? Can you send me the dmesg output ?

Text is readable and stays in place, but horizontal lines keep
flashing randomly.  Maybe a monitor detection issue?  I've copied the
portion of the dmesg output that appeared relevant to me below, please
let me know if you need everything.

> > 3. XFree86 from Debian/unstable doesn't work

> you need something more recent like Michel DRI snapshots

Ok, thanks.

Something else: pmud refuses to run, claiming there is "no sleep
support on this hardware".  Is this true, or does pmud need an update?

Regards, Jens.

Total memory = 512MB; using 1024kB for hash table (at c0400000)
Linux version 2.6.0-test7-alsvidh (root@alsvidh) (gcc version 3.3.2 20031005 (Debian prerelease)) #1 Sun Oct 12 04:59:12 CEST 2003
[...]
bus pci: add driver radeonfb
radeonfb_pci_register BEGIN
PCI: Enabling device 0000:00:10.0 (0006 -> 0007)
aper_base: b8000000 MC_FB_LOC to: bbffb800, MC_AGP_LOC to: ffffc000
radeonfb: probed SDR SGRAM 65536k videoram
radeonfb: Invalid ROM signature 303 should be 0xaa55
radeonfb: Retreived PLL infos from Open Firmware
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=200.00 Mhz, System=300.00 MHz
Starting monitor auto detection...
radeon_probe_OF_head
head: ATY,Jasper_A (letter: A, head_no: 0)
analyzing OF properties...
display-type: LCD
radeon_probe_OF_head
head: ATY,Jasper_A (letter: A, head_no: 1)
radeonfb: Monitor 1 type LCD found
radeonfb: EDID probed
========================================
Display Information (EDID)
========================================
   EDID Version 1.3
   Manufacturer: APP Model: 9c2c Serial#: 0
   Year: 2003 Week 1
   Display Characteristics:
      Digital Display Input      Sync:
      Max H-size in cm: 37
      Max V-size in cm: 23
      Gamma: 2.20
      DPMS: Active no, Suspend no, Standby no
      RGB Color Display
      Chromaticity: RedX:   0.609 RedY:   0.340
                    GreenX: 0.324 GreenY: 0.550
                    BlueX:  0.145 BlueY:  0.114
                    WhiteX: 0.319 WhiteY: 0.329
      First DETAILED Timing is preferred
   Standard Timings
   Supported VESA Modes
      Manufacturer's mask: 0
   Detailed Monitor Information
      96 MHz 1440 1504 1536 1760 900 903 906 912 -HSync -VSync

      LP171W01
      Monitor Name  : Color LCD
========================================
radeonfb: Monitor 2 type no found
Parsing EDID data for panel info
Setting up default mode based on panel info
radeonfb: Power Management enabled for Mobility chipsets
Registered "mnca" backlight controller, level: 15/15
radeonfb: ATI Radeon NP  SDR SGRAM 64 MB
radeonfb_pci_register END
bound device '0000:00:10.0' to driver 'radeonfb'
bus type 'pcmcia' registered
Thermal assist unit not available
bus of_platform: add device uni-n-i2c
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
SGI XFS for Linux with ACLs, no debug enabled
SGI XFS Quota Management subsystem
Initializing Cryptographic API
hStart = 1504, hEnd = 1536, hTotal = 1760
vStart = 903, vEnd = 906, vTotal = 912
h_total_disp = 0xb300db	   hsync_strt_wid = 0x8405da
v_total_disp = 0x383038f	   vsync_strt_wid = 0x830386
pixclock = 10393
freq = 9621
post div = 0x2
fb_div = 0x56
ppll_div_3 = 0x10056
lvds_gen_cntl: 00010026
Console: switching to colour frame buffer device 180x56
pty: 256 Unix98 ptys configured
Generic RTC Driver v1.07
Linux agpgart interface v0.100 (c) Dave Jones
bus pci: add driver agpgart-uninorth
agpgart: Detected Apple UniNorth 2 chipset
agpgart: Maximum main memory to use for agp memory: 440M
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
bound device '0000:00:0b.0' to driver 'agpgart-uninorth'
[drm] Initialized radeon 1.9.0 20020828 on minor 0
[...]

--
J'qbpbe, le m'en fquz pe j'qbpbe!
Le veux aimeb et mqubib panz je pézqbpbe je djuz tqtaj!

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
