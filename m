From: thomas graichen <list-linux.ppc.dev@spoiled.org>
Reply-To: thomas graichen <tgr@spoiled.org>
Subject: XFree86 problem (800x600 on imac, xf86 4.1.0)
Date: Mon, 2 Jul 2001 08:34:05 +0200
Message-ID: <news2mail-20010702063405.74EE42DE.NOFFLE@tecklenburg2.spm.de>
Reply-To: thomas graichen <tgr@spoiled.org>
To: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i asked this on some other lists already and searched all resources
i was able to find but did not get an answer for it - maybe someone
here has an idea (the only answers i got the asking on the other
lists were "me too" - so i'm not the only one with that problem)
ok - here it is ...

i have a problem with XFree86 4.1.0 and an r128 imac (blueberry slot
loading) ... i would like to run it in 800x600 resolution but so far
fail to do so and it looks to me a bit like a bug in XFree86 - but
maybe someone here has an idea about it: (this is on a benh kernel
2.4.5-pre5 andi use the mandrake 4.1.0 XFree rpm's)

* i can run x fine in 1024x768 - no problem
* if i set a modeline for 800x600 in the XF86Config i get a somewhat
  distorted screen - which is most probably 32 pixels too wide i
  assume from the following output of the server

    (--) Chipset ATI Rage 128 RL (AGP) found
    ...
    (II) R128(0): PCI bus 0 card 16 func 0
    (**) R128(0): Depth 15, (--) framebuffer bpp 16
    (II) R128(0): Pixel depth = 15 bits stored in 2 bytes (16 bpp pixmaps)
    (==) R128(0): Default visual is TrueColor
    (**) R128(0): Option "UseFBDev"
    (==) R128(0): RGB weight 555
    (II) R128(0): Using 5 bits per RGB (8 bit DAC)
    (**) R128(0): Using framebuffer device
    ...
    (--) R128(0): Chipset: "ATI Rage 128 RL (AGP)" (ChipID = 0x524c)
    (--) R128(0): Linear framebuffer at 0x94000000
    (--) R128(0): MMIO registers at 0x90000000
    (--) R128(0): BIOS at 0x90020000
    (--) R128(0): VideoRAM: 8192 kByte (64-bit SDR SGRAM 2:1)
    (WW) R128(0): Video BIOS not detected in PCI space!
    (WW) R128(0): Attempting to read Video BIOS from legacy ISA space!
    (WW) R128(0): Video BIOS not found!
    (II) R128(0): PLL parameters: rf=2950 rd=56 min=12500 max=25000; xclk=5010
    ...
    (==) R128(0): Using gamma correction (1.0, 1.0, 1.0)
    (II) R128(0): MyMonitor: Using hsync range of 30.00-70.00 kHz
    (II) R128(0): MyMonitor: Using vrefresh range of 50.00-160.00 Hz
    (II) R128(0): Clock range:  12.50 to 250.00 MHz
    ...
    (II) R128(0): Not using default mode "1400x1050" (hsync out of range)
    (--) R128(0): Virtual size is 800x600 (pitch 832)
->->->->->->->->->->->->->->->->->->->->->->->->-/
    (**) R128(0): Mode "800x600": 62.4 MHz, 60.0 kHz, 94.9 Hz
    (II) R128(0): Modeline "800x600"   62.40  800 821 901 1040  600 601 604 632 +hsync +vsync
    (==) R128(0): DPI set to (75, 75)

* i can get rid of the screen problems by adding a virtual entry 832 600
  to the XF86Config-4 file (which proves the 832 theory) - in this case
  the picture is ok - but the mouse cursor acts 32 pixel next to its
  place :-)

    (**) R128(0): Virtual size is 832x600 (pitch 832)
    (**) R128(0): Mode "800x600": 62.4 MHz, 60.0 kHz, 94.9 Hz
    (II) R128(0): Modeline "800x600"   62.40  800 821 901 1040  600 601 604 632 +hsync +vsync
    (==) R128(0): DPI set to (75, 75)

* if i now (but only i once ran in the 62mhz, 60khz, 95hz before) remove
  the modeline so that no modeline is left and set the horizontal and
  refresh timings to some stupid values like 60k & 40hz so that the
  server itself determines its mode i end up with a working 800x600
  screen without any problems - but: thisonly works if the display was
  in one of the broken 800x600 modes before - otherwise it will end
  up in 1024x768 (i assume due to the fb setting timing being the one
  for 1024x768 on the imac)

    (II) R128(0): Not using default mode "1400x1050" (hsync out of range)
    (WW) R128(0): Mode pool is empty
    (--) R128(0): Virtual size is 800x600 (pitch 800)
->->->->->->->->->->->->->->->->->->->->->->->->-/
    (**) R128(0): Built-in mode "current": 62.4 MHz, 60.0 kHz, 94.9 Hz
    (II) R128(0): Modeline "current"   62.40  800 817 897 1040  600 601 604 632 +hsync +vsync -csync
    (==) R128(0): DPI set to (75, 75)

does anyonw have an idea what happens here? or where the 832 comes from
(which is nowhere in the config)? - a lot of thanks in advance - i would
really like to get this working (btw. does maybe someone else have
an r128 imac running in 800x600 with 4.1.0 without those problems?)

t

p.s.: is there any other list which might be a good place to ask this?

--
thomas graichen <tgr@spoiled.org> ... perfection is reached, not
when there is no longer anything to add, but when there is no
longer anything to take away. --- antoine de saint-exupery

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
