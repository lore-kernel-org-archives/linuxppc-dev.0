Subject: Re: XFree86-4.0.99.2
From: Guillaume Laures <guillaume.laures@noos.fr>
To: linuxppc <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <15056.55761.845494.317224@ipa.ne.mediaone.net>
References: <15056.36750.453557.759357@ipa.ne.mediaone.net>
	<3AD0AABE.1020605@vacuumgenesis.com>
	<15056.55761.845494.317224@ipa.ne.mediaone.net>
Content-Type: text/plain
Date: 09 Apr 2001 00:08:49 +0200
Message-Id: <986767730.17213.0.camel@pmg4.gom.net>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I discovered that since XF4.0.2 the support for Number Nine card is
back.

So I took my good old Tiket2Ride out of dust, I fired it in my G4.
I'm running 4.0.99.2-0a on the stock AGP Rage Pro really fine, exept for
this font problem on the top of all my windows in e, but this is going
to be fixed easily I guess.

Now on N9...
I added the following in my XF86Config file:

Section "Device"
    Identifier  "Number Nine Imagine 128 T2R"
#    VendorName "Unknown"
#    BoardName  "Unknown"
#   Chipset     "generic"
    Driver      "i128"
    BusID      "PCI:2:2:0"
#    Option     "UseFBDev"
#    VideoRam    8192
##   MemBase
##   IOBase
##   ChipID
##   Clocks     25.2 28.3
EndSection

Along with a screen section like this:

Section "Screen"
    Identifier  "Screen 2"
    Device      "Number Nine Imagine 128 T2R"
    Monitor     "Acer AcerView 33DL"
    DefaultDepth 24

    Subsection "Display"
        Depth       8
        Modes       "1024x768" "800x600" "640x480"
    EndSubsection
    Subsection "Display"
        Depth       16
        Modes       "1024x768" "800x600" "640x480"
    EndSubsection
    Subsection "Display"
        Depth       24
        Modes       "1024x768" "800x600" "640x480"
    EndSubsection
EndSection


(I have this somewhere too:
Section "Monitor"

    Identifier  "Acer AcerView 33DL"
    HorizSync   31-35.5
    VertRefresh 50-100

EndSection)

For now, it cores dump, here's he log:
---------------------------------------------------------

This is a pre-release version of XFree86, and is not supported in any
way.  Bugs may be reported to XFree86@XFree86.Org and patches submitted
to fixes@XFree86.Org.  Before reporting bugs in pre-release versions,
please check the latest version in the XFree86 CVS repository
(http://www.XFree86.Org/cvs)

XFree86 Version 4.0.99.2 / X Window System
(protocol Version 11, revision 0, vendor release 6510)
Release Date: 6 April 2001
        If the server is older than 6-12 months, or if your card is
        newer than the above date, look for a newer version before
        reporting problems.  (See http://www.XFree86.Org/FAQ)
Operating System: Linux 2.4.3-0d ppc [ELF]
Module Loader present
(==) Log file: "/var/log/XFree86.0.log", Time: Sun Apr  8 23:39:08 2001
(==) Using config file: "/etc/X11/XF86Config"
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) ServerLayout "Simple Layout"
(**) |-->Screen "Screen 1" (0)
(**) |   |-->Monitor "Hitachi CM751ET"
(**) |   |-->Device "ATI Rage128 Pro"
(**) |-->Screen "Screen 2" (1)
(**) |   |-->Monitor "Acer AcerView 33DL"
(**) |   |-->Device "Number Nine Imagine 128 T2R"
(**) |-->Input Device "Mouse1"
(**) |-->Input Device "Keyboard1"
(**) XKB: symbols: "macintosh/fr_new"
(**) FontPath set to
"/usr/X11R6/lib/X11/fonts/local/,/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/75dpi/:unscaled,/usr/X11R6/lib/X11/fonts/100dpi/:unscaled,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/CID/,/usr/X11R6/lib/X11/fonts/PEX/,/usr/X11R6/lib/X11/fonts/encodings/,/usr/X11R6/lib/X11/fonts/latin2/,/usr/X11R6/lib/X11/fonts/ttf/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/,unix/:7100"
(**) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 7

(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 0.1.0
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 0.1.0
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(--) PCI:*(0:16:0) ATI Rage 128 Pro PF rev 0, Mem @ 0xa4000000/26,
0xa0000000/14, I/O @ 0x0400/8
(--) PCI: (2:2:0) Number Nine Imagine 128 Rev 3D T2R rev 0, Mem @
0x84000000/23, 0x90000000/23, 0x81000000/22, 0x80800000/22,
0x800b0000/16, I/O @ 0x1800/8
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 1.1.9
(II) Loading /usr/X11R6/lib/modules/drivers/ati_drv.o
(II) Module ati: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 6.3.1
(II) Loading /usr/X11R6/lib/modules/drivers/i128_drv.o
(II) Module i128: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 1.0.0
(II) ATI: ATI driver (version 6.3.1) for chipsets: ati
(II) R128: Driver for ATI Rage 128 chipsets: ATI Rage 128 RE (PCI),
        ATI Rage 128 RF (AGP), ATI Rage 128 RG (AGP), ATI Rage 128 RK
(PCI),
        ATI Rage 128 RL (AGP), ATI Rage 128 Pro PD (PCI),
        ATI Rage 128 Pro PF (AGP), ATI Rage 128 Mobility LE (PCI),
        ATI Rage 128 Mobility LF (AGP), ATI Rage 128 Mobility MF (AGP),
        ATI Rage 128 Mobility ML (AGP)
(II) RADEON: Driver for ATI Radeon chipsets: ATI Radeon QD (AGP),
        ATI Radeon QE (AGP), ATI Radeon QF (AGP), ATI Radeon QG (AGP)
(II) I128: driver for Number Nine I128 chipsets: i128, i128v2, i128t2r,
        i128t2r4
(--) Chipset ATI Rage 128 Pro PF (AGP) found
(II) Loading /usr/X11R6/lib/modules/drivers/r128_drv.o
(II) Module r128: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 4.0.1
(--) Chipset i128t2r found
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 0.1.0
(II) R128(0): PCI bus 0 card 16 func 0
(**) R128(0): Depth 24, (--) framebuffer bpp 32
(II) R128(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) R128(0): Default visual is TrueColor
(==) R128(0): RGB weight 888
(II) R128(0): Using 8 bits per RGB (8 bit DAC)
(**) R128(0): Using framebuffer device
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 0.0.2
(--) R128(0): Chipset: "ATI Rage 128 Pro PF (AGP)" (ChipID = 0x5046)
(--) R128(0): Linear framebuffer at 0xa4000000
(--) R128(0): MMIO registers at 0xa0000000
(--) R128(0): BIOS at 0xa0020000
(--) R128(0): VideoRAM: 16384 kByte (64-bit SDR SGRAM 1:1)
(WW) R128(0): Video BIOS not detected in PCI space!
(WW) R128(0): Attempting to read Video BIOS from legacy ISA space!
(WW) R128(0): Video BIOS not found!
(II) R128(0): PLL parameters: rf=2950 rd=50 min=12500 max=25000;
xclk=14038
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 1.0.0
(==) R128(0): Using gamma correction (1.0, 1.0, 1.0)
(II) R128(0): Hitachi CM751ET: Using hsync range of 31.00-93.00 kHz
(II) R128(0): Hitachi CM751ET: Using vrefresh range of 50.00-160.00 Hz
(II) R128(0): Clock range:  12.50 to 250.00 MHz
(II) R128(0): Not using default mode "1600x1200" (hsync out of range)
(II) R128(0): Not using default mode "1792x1344" (bad mode
clock/interlace/doublescan)
(II) R128(0): Not using default mode "1856x1392" (bad mode
clock/interlace/doublescan)
(II) R128(0): Not using default mode "1920x1440" (bad mode
clock/interlace/doublescan)
(--) R128(0): Virtual size is 1280x1024 (pitch 1280)
(**) R128(0): Default mode "1280x1024": 157.5 MHz, 91.1 kHz, 85.0 Hz
(**) R128(0): Default mode "1152x864": 108.0 MHz, 67.5 kHz, 75.0 Hz
(**) R128(0): Default mode "1024x768": 94.5 MHz, 68.7 kHz, 85.0 Hz
(**) R128(0): Default mode "800x600": 56.3 MHz, 53.7 kHz, 85.1 Hz
(**) R128(0): Default mode "640x480": 36.0 MHz, 43.3 kHz, 85.0 Hz
(==) R128(0): DPI set to (75, 75)
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 1.0.0
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 0.1.0
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor="The XFree86 Project"
        compiled for 4.0.99.2, module version = 1.0.0
Symbol xf86int10Addr from module
/usr/X11R6/lib/modules/drivers/r128_drv.o is unresolved!

Fatal server error:
Caught signal 11.  Server aborting


When reporting a problem related to a server crash, please send
the full server output, not just the last messages.
This can be found in the log file "/var/log/XFree86.0.log".
Please report problems to xfree86@xfree86.org.
---------------------------------------------------------

Here is what I could get from the core file:

[root@pmg4 root]# gdb /etc/X11/X core
GNU gdb 4.18
Copyright 1998 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you
are
welcome to change it and/or distribute copies of it under certain
conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for
details.
This GDB was configured as "ppc-redhat-linux"...(no debugging symbols
found)...
Core was generated by `/etc/X11/X'.
Program terminated with signal 6, Aborted.
Reading symbols from /usr/lib/libz.so.1...(no debugging symbols
found)...done.
Reading symbols from /lib/libm.so.6...done.
Reading symbols from /lib/libpam.so.0...done.
Reading symbols from /lib/libdl.so.2...done.
Reading symbols from /lib/libpam_misc.so.0...done.
Reading symbols from /lib/libc.so.6...done.
Reading symbols from /lib/ld.so.1...done.
#0  0xfe0bea8 in kill () at soinit.c:64
64      soinit.c: No such file or directory.
(gdb) bt
#0  0xfe0bea8 in kill () at soinit.c:64
#1  0xfe0bd24 in raise () at ../sysdeps/posix/raise.c:27
#2  0xfe0d3d4 in abort () at ../sysdeps/generic/abort.c:139
#3  0x10025bbc in ddxGiveUp ()
#4  0x10025cb0 in AbortDDX ()
#5  0x100a9ae0 in GiveUp ()
#6  0x100ab5d8 in FatalError ()
#7  0x1003c6ec in xf86SigHandler ()
#8  <signal handler called>
#9  0x1030aa04 in ?? ()
#10 0x0 in ?? ()

I got the same core dump with the Screen 1 option commented out, so
only:
(**) |-->Screen "Screen 2" (0)
(**) |   |-->Monitor "Acer AcerView 33DL"
(**) |   |-->Device "Number Nine Imagine 128 T2R"
(**) |-->Input Device "Mouse1"
(**) |-->Input Device "Keyboard1"


I tried looking for soinit.c in the i128 files but this didn't give any
result, and I cannot find it trhough the whole source; any idea on where
to head on ???


--
GoM


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
