From: thomas graichen <list-linux.ppc.dev@spoiled.org>
Reply-To: thomas graichen <tgr@spoiled.org>
Subject: r128 imac with 800x600 as default resolution [was: XFree86 problem (800x600 on imac, xf86 4.1.0)]
Date: Mon, 10 Sep 2001 12:36:33 +0200
Message-ID: <news2mail-20010910103633.13BB87D8.NOFFLE@tecklenburg2.spm.de>
References: <news2mail-20010702063405.74EE42DE.NOFFLE@tecklenburg2.spm.de>
Reply-To: thomas graichen <tgr@spoiled.org>
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


over the weekend i looked again into the topic described in more
detail below (very short: at least for the first r128 imacs it is
not possible to run X in 800x600 mode with the r128 XFree86
driver) and came across a few things ...

what i tried was to make the default framebuffer mode in the r128
driver the supported 800x600 mode of the hardware (800x600@95hz)
and hoping that the xserver will use this as a fallback then not
supplied with a mode (i'm pretty shure that it will work this
way - because it does for the 1024x768 mode) ... to do this i
changed the following

--- linux/drivers/video/macmodes.c      Sun Sep  9 20:09:09 2001
+++ linux/drivers/video/macmodes.c.my   Sun Sep  9 20:08:40 2001
@@ -102,6 +102,10 @@
        /* 1600x1024, 60 Hz, Non-Interlaced (112.27 MHz dotclock) */
        "mac22", 60, 1600, 1024, 8908, 88, 104, 1, 10, 16, 1,
        FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT,
FB_VMODE_NONINTERLACED
+    }, {
+       /* 800x600, 95 Hz, Non-Interlaced (62.4 MHz dotclock) */
+       "mac23", 95, 800, 600, 16038, 143, 17, 28, 1, 80, 3,
+       FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT,
FB_VMODE_NONINTERLACED
     }

 #if 0
@@ -151,6 +155,7 @@
     { VMODE_640_480_67, &mac_modedb[1] },
     { VMODE_640_480_60, &mac_modedb[0] },
     /* 800x600 */
+    { VMODE_800_600_95, &mac_modedb[23] },
     { VMODE_800_600_75, &mac_modedb[5] },
     { VMODE_800_600_72, &mac_modedb[4] },
     { VMODE_800_600_60, &mac_modedb[3] },
--- linux/drivers/video/aty128fb.c      Sun Sep  9 20:09:15 2001
+++ linux/drivers/video/aty128fb.c.my   Sun Sep  9 20:08:31 2001
@@ -1860,13 +1860,17 @@
             if (default_vmode <= 0 || default_vmode > VMODE_MAX)
                 default_vmode = VMODE_1024_768_60;

-           /* iMacs need that resolution
+           /* some iMacs need that resolution
             * PowerMac2,1 first r128 iMacs
+            */
+           if (machine_is_compatible("PowerMac2,1"))
+               default_vmode = VMODE_800_600_95;
+
+           /* other iMacs need that resolution
             * PowerMac2,2 summer 2000 iMacs
             * PowerMac4,1 january 2001 iMacs "flower power"
             */
-           if (machine_is_compatible("PowerMac2,1") ||
-               machine_is_compatible("PowerMac2,2") ||
+           if (machine_is_compatible("PowerMac2,2") ||
                machine_is_compatible("PowerMac4,1"))
                default_vmode = VMODE_1024_768_75;

--- linux/include/video/macmodes.h      Sun Sep  9 20:09:01 2001
+++ linux/include/video/macmodes.h.my   Sun Sep  9 20:08:56 2001
@@ -40,7 +40,8 @@
 #define VMODE_1280_1024_75     20      /* 1280x1024, 75Hz */
 #define VMODE_1152_768_60      21      /* 1152x768, 60Hz     Titanium
PowerBook */
 #define VMODE_1600_1024_60     22      /* 1600x1024, 60Hz 22" Cinema
Display */-#define VMODE_MAX              22
+#define VMODE_800_600_95       23      /* 800x600, 95Hz */
+#define VMODE_MAX              23
 #define VMODE_CHOOSE           99

 #define CMODE_NVRAM            -1

so i added a new mode for this (which really works) and made
ist the default mode on this machine ... after this change it
booted fine into the corresponding textmode but on bootup i
get the folowing things which are confusing me

PCI: Enabling device 00:10.0 (0086 -> 0087)
aty128fb: Rage128 RL (AGP) [chip rev 0x2] 8M 64-bit SDR SGRAM
(2:1)
Sep  9 19:52:46 blueberry kernel: aty128fb: Cannot set default
mode.
Sep  9 19:52:46 blueberry kernel: Trying to free nonexistent
resource <00802400-008024ff>
Sep  9 19:52:46 blueberry kernel: Using unsupported 800x600
ATY,Rage128k at 94008000, depth=8, pitch=1024
Sep  9 19:52:46 blueberry kernel: Console: switching to colour
frame buffer device 100x37
Sep  9 19:52:46 blueberry kernel: fb0: Open Firmware frame buffer
device on /pci@f0000000/ATY,Rage128k@10

instead of the usual

PCI: Enabling device 00:10.0 (0086 -> 0087)
aty128fb: Rage128 RL (AGP) [chip rev 0x2] 8M 64-bit SDR SGRAM
(2:1)
Console: switching to colour frame buffer device 128x48
fb0: ATY Rage128 frame buffer device on PCI
thomas graichen <list-linux.ppc.dev@spoiled.org> wrote:

also i can't change anything with fbset anymore - instead i
get an error that it is not possible to change the fb mode
which is most probably also the reason that the xserver
will not start with this modification (gets the same error)

can anyone please explain me what goes wrong here? or is this
mode really not possible as default on this hardware (but i
checked - if i set the resultion in macos to 800x600 it also
boots macos in this resolution from the beginning)

a lot of thanks in advance ... if anything of all this should
be unclear - feel free to ask ...

t

p.s.: here is the old mail with some more details of the
      initail problem

> i asked this on some other lists already and searched all resources
> i was able to find but did not get an answer for it - maybe someone
> here has an idea (the only answers i got the asking on the other
> lists were "me too" - so i'm not the only one with that problem)
> ok - here it is ...

> i have a problem with XFree86 4.1.0 and an r128 imac (blueberry slot
> loading) ... i would like to run it in 800x600 resolution but so far
> fail to do so and it looks to me a bit like a bug in XFree86 - but
> maybe someone here has an idea about it: (this is on a benh kernel
> 2.4.5-pre5 andi use the mandrake 4.1.0 XFree rpm's)

> * i can run x fine in 1024x768 - no problem
> * if i set a modeline for 800x600 in the XF86Config i get a somewhat
>   distorted screen - which is most probably 32 pixels too wide i
>   assume from the following output of the server

>     (--) Chipset ATI Rage 128 RL (AGP) found
>     ...
>     (II) R128(0): PCI bus 0 card 16 func 0
>     (**) R128(0): Depth 15, (--) framebuffer bpp 16
>     (II) R128(0): Pixel depth = 15 bits stored in 2 bytes (16 bpp pixmaps)
>     (==) R128(0): Default visual is TrueColor
>     (**) R128(0): Option "UseFBDev"
>     (==) R128(0): RGB weight 555
>     (II) R128(0): Using 5 bits per RGB (8 bit DAC)
>     (**) R128(0): Using framebuffer device
>     ...
>     (--) R128(0): Chipset: "ATI Rage 128 RL (AGP)" (ChipID = 0x524c)
>     (--) R128(0): Linear framebuffer at 0x94000000
>     (--) R128(0): MMIO registers at 0x90000000
>     (--) R128(0): BIOS at 0x90020000
>     (--) R128(0): VideoRAM: 8192 kByte (64-bit SDR SGRAM 2:1)
>     (WW) R128(0): Video BIOS not detected in PCI space!
>     (WW) R128(0): Attempting to read Video BIOS from legacy ISA space!
>     (WW) R128(0): Video BIOS not found!
>     (II) R128(0): PLL parameters: rf=2950 rd=56 min=12500 max=25000; xclk=5010
>     ...
>     (==) R128(0): Using gamma correction (1.0, 1.0, 1.0)
>     (II) R128(0): MyMonitor: Using hsync range of 30.00-70.00 kHz
>     (II) R128(0): MyMonitor: Using vrefresh range of 50.00-160.00 Hz
>     (II) R128(0): Clock range:  12.50 to 250.00 MHz
>     ...
>     (II) R128(0): Not using default mode "1400x1050" (hsync out of range)
>     (--) R128(0): Virtual size is 800x600 (pitch 832)
> ->->->->->->->->->->->->->->->->->->->->->->->->-/
>     (**) R128(0): Mode "800x600": 62.4 MHz, 60.0 kHz, 94.9 Hz
>     (II) R128(0): Modeline "800x600"   62.40  800 821 901 1040  600 601 604 632 +hsync +vsync
>     (==) R128(0): DPI set to (75, 75)

> * i can get rid of the screen problems by adding a virtual entry 832 600
>   to the XF86Config-4 file (which proves the 832 theory) - in this case
>   the picture is ok - but the mouse cursor acts 32 pixel next to its
>   place :-)

>     (**) R128(0): Virtual size is 832x600 (pitch 832)
>     (**) R128(0): Mode "800x600": 62.4 MHz, 60.0 kHz, 94.9 Hz
>     (II) R128(0): Modeline "800x600"   62.40  800 821 901 1040  600 601 604 632 +hsync +vsync
>     (==) R128(0): DPI set to (75, 75)

> * if i now (but only i once ran in the 62mhz, 60khz, 95hz before) remove
>   the modeline so that no modeline is left and set the horizontal and
>   refresh timings to some stupid values like 60k & 40hz so that the
>   server itself determines its mode i end up with a working 800x600
>   screen without any problems - but: thisonly works if the display was
>   in one of the broken 800x600 modes before - otherwise it will end
>   up in 1024x768 (i assume due to the fb setting timing being the one
>   for 1024x768 on the imac)

>     (II) R128(0): Not using default mode "1400x1050" (hsync out of range)
>     (WW) R128(0): Mode pool is empty
>     (--) R128(0): Virtual size is 800x600 (pitch 800)
> ->->->->->->->->->->->->->->->->->->->->->->->->-/
>     (**) R128(0): Built-in mode "current": 62.4 MHz, 60.0 kHz, 94.9 Hz
>     (II) R128(0): Modeline "current"   62.40  800 817 897 1040  600 601 604 632 +hsync +vsync -csync
>     (==) R128(0): DPI set to (75, 75)

> does anyonw have an idea what happens here? or where the 832 comes from
> (which is nowhere in the config)? - a lot of thanks in advance - i would
> really like to get this working (btw. does maybe someone else have
> an r128 imac running in 800x600 with 4.1.0 without those problems?)

> t

> p.s.: is there any other list which might be a good place to ask this?

> --
> thomas graichen <tgr@spoiled.org> ... perfection is reached, not
> when there is no longer anything to add, but when there is no
> longer anything to take away. --- antoine de saint-exupery



--
thomas graichen <tgr@spoiled.org> ... perfection is reached, not
when there is no longer anything to add, but when there is no
longer anything to take away. --- antoine de saint-exupery

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
