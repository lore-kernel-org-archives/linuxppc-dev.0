Date: Mon, 16 Apr 2001 16:15:22 +0100
Subject: XF4 (mach64) help please
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="utf-8"
Message-Id: <20010416151514.E88D02F0B6@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
I'm having problems with XF4.0.99.02-0b .. and don't really know where to
start with debugging.  This is the first version of Xf4 I've tried -
installed as per HOW to from 3.3.6/Xpmac.

I've read (and acted upon, AFAICT) the readmes, and Franz's comments in
Kaoru's ftp directory.

1/  Key-mappings are screwed (big time) with any combination of "Option
XkbModel" I've tried - this is very unfortunate because I can't do SysRq or
VT switches - too much time spent watching fsck...

2/  The Mach64 driver is not loading.

3/  The fbdev driver loads & runs but usually crashes on X restart (which
occurs on log-out) - leaving me with a locked machine and another fsck...

uname -a:
Linux minerva 2.4.4-pre3 #1 Mon Apr 16 13:56:10 BST 2001 ppc unknown

rpm -qa|grep XFree
XFree86-twm-4.0.99.2-0b
XFree86-Xnest-4.0.99.2-0b
XFree86-Xvfb-4.0.99.2-0b
XFree86-xf86cfg-4.0.99.2-0b
XFree86-drivers-4.0.99.2-0b
XFree86-cyrillic-fonts-4.0.99.2-0b
XFree86-xdm-4.0.99.2-0b
XFree86-libs-4.0.99.2-0b
XFree86-tools-4.0.99.2-0b
XFree86-xfs-4.0.99.2-0b
XFree86-4.0.99.2-0b
XFree86-100dpi-fonts-4.0.99.2-0b
XFree86-75dpi-fonts-4.0.99.2-0b
XFree86-devel-4.0.99.2-0b
XFree86-doc-4.0.99.2-0b

tail of XFree86.0.log:

(II) ATI: ATI driver (version 6.2.3) for chipsets: ati
(II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
 ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK (PCI),
 ATI Rage 128 RL (AGP), ATI Rage 128 Pro PD (PCI),
 ATI Rage 128 Pro PF (AGP), ATI Rage 128 Mobility LE (PCI),
 ATI Rage 128 Mobility LF (AGP), ATI Rage 128 Mobility MF (AGP),
 ATI Rage 128 Mobility ML (AGP)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
 ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP)
(II) ATI:  Candidate "Device" section "Card0".
(WW) xf86UnMapVidMem: cannot find region for [0x30014c00,0x1c00]
(II) ATI:  Shared PCI/AGP Mach64 in slot 0:18:0 detected.
(II) ATI:  Shared PCI/AGP Mach64 in slot 0:18:0 assigned to active "Device"
section "Card0".
(II) Loading sub module "atimisc"
(II) LoadModule: "atimisc"
(II) Loading /usr/X11R6/lib/modules/drivers/atimisc_drv.o
(II) Module ati: vendor="The XFree86 Project"
 compiled for 4.0.99.2, module version = 6.2.3
 Module class: XFree86 Video Driver
 ABI class: XFree86 Video Driver, version 0.4
(II) resource ranges after probing:
 [0] -1 0xffffffff - 0xffffffff (0x1) MX[B]
 [1] -1 0x00000000 - 0x00000000 (0x1) MX[B]
 [2] -1 0xf3000000 - 0xf307ffff (0x80000) MX[B]
 [3] -1 0x80801000 - 0x80801fff (0x1000) MX[B]
 [4] -1 0x80804000 - 0x80804fff (0x1000) MX[B]
 [5] -1 0x80800000 - 0x808000ff (0x100) MX[B]
 [6] -1 0x80802000 - 0x80802fff (0x1000) MX[B](B)
 [7] -1 0x81000000 - 0x81ffffff (0x1000000) MX[B](B)
 [8] -1 0x0000ffff - 0x0000ffff (0x1) IX[B]
 [9] -1 0x00000000 - 0x00000000 (0x1) IX[B]
 [10] -1 0x00010000 - 0x000100ff (0x100) IX[B]
 [11] -1 0x00000c00 - 0x00000cff (0x100) IX[B](B)
(==) ATI(0): Chipset:  "ati".
(**) ATI(0): Depth 24, (**) framebuffer bpp 32
(--) ATI(0): ATI 3D Rage Pro graphics controller detected.
(--) ATI(0): Chip type 4750 "GP", version 4, foundry UMC, class 0, revision
0x01.
(--) ATI(0): PCI bus interface detected;  block I/O base is 0x0000.
(--) ATI(0): ATI Mach64 adapter detected.
(--) ATI(0): Internal RAMDAC (subtype 1) detected.
(==) ATI(0): RGB weight 888
(==) ATI(0): Default visual is TrueColor
(==) ATI(0): Using gamma correction (1.0, 1.0, 1.0)
(II) ATI(0): Using Mach64 accelerator CRTC.
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
 compiled for 4.0.99.2, module version = 0.0.2
 ABI class: XFree86 Video Driver, version 0.4
fbdevHWInit failed
crapping out here
(WW) ATI(0): xf86UnMapVidMem: cannot find region for [0x30016c00,0x1c00]
(II) UnloadModule: "ati"
(II) UnloadModule: "fbdevhw"
(II) Unloading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) UnloadModule: "atimisc"
(II) Unloading /usr/X11R6/lib/modules/drivers/atimisc_drv.o
(EE) Screen(s) found, but none have a usable configuration.

Fatal server error:
no screens found

====
Is there anything I can do to find out what's going on?

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
