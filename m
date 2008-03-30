Return-Path: <liuxs226@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 7B10ADDE01
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Mar 2008 23:14:36 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c37so281442anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 30 Mar 2008 06:14:26 -0700 (PDT)
Message-ID: <e81b2fb40803300614y5dbadaafue8d80ddeaf0fc763@mail.gmail.com>
Date: Sun, 30 Mar 2008 21:14:26 +0800
From: "=?GB2312?B?wfXQocur?=" <liuxs226@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: black screen problem
In-Reply-To: <e81b2fb40803292139u3f59c64fv9c04612c56d45500@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7825_31958225.1206882866741"
References: <e81b2fb40803292139u3f59c64fv9c04612c56d45500@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_7825_31958225.1206882866741
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 hi,all

I  compiled linux-2.6.12 for mpc8540 with DENX eldk4.0, my plabtform is
custom mpc8540 board, mb86296 video card, eldk4.0 ppc_85xx file sysytem.
Accelerated  driver is x11_mb86290 offered by DENX .  I compiled XFree86
4.3.0, then I ran startx, the screen was black for a few seconds and it
turned to text mode.

there are some hints in XFree86.0.log:


fbdevHW: MapVidmem 0
 fbdevHW: LinearOffset 0
 fbdevHW: Save 0
 fbdevHW: ModeInit 0
 xfree init mode: 50000   1024 1024 1024 1024   768 768 768 768
 fbdev init mode: 20000   1024 0 0 0   768 0 0 0   16 5:5:5
 fbdevHW: AdjustFrame 0
 (==) MB86290(0): Backing store disabled
 (II) MB86290(0): Using XFree86 Acceleration Architecture (XAA)
  Screen to screen bit blits
  Solid filled rectangles
  8x8 mono pattern filled rectangles
  Indirect CPU to Screen color expansion
  Solid Lines
  Dashed Lines
 (II) MB86290(0): Acceleration enabled
 fbdevHW: ModeInit 0

 Fatal server error:
 AddScreen/ScreenInit failed for driver 0


 When reporting a problem related to a server crash, please send
 the full server output, not just the last messages.
 This can be found in the log file "/var/log/XFree86.0.log".
 Please report problems to xfree86@xfree86.org.

 fbdevHW: LeaveVT 0
 fbdevHW: Restore 0

then I changed configuration file as follows:

Section "Device"


  Identifier "CoralP"
  Driver  "mb86290"
  Option "Video" "no"  --forbid I2c bus

EndSection

then I run startx, the screen was black forever and there was no
MousePointer, and  here is output of XFree86.0.log:

XFree86 Version 4.3.0
Release Date: 27 February 2003
X Protocol Version 11, Revision 0, Release 6.6
Build Operating System: Linux 2.6.12.6 ppc [ELF]
Build Date: 17 March 2008
 Before reporting problems, check
http://www.XFree86.Org/<http://www.xfree86.org/>
 to make sure that you have the latest version.
Module Loader present
Markers: (--) probed, (**) from config file, (==) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (NI) not implemented, (??) unknown.
(==) Log file: "/var/log/XFree86.0.log", Time: Wed Mar 19 17:24:36 2008
(==) Using config file: "/etc/X11/XF86Config-4"
(==) ServerLayout "Default Layout"
(**) |-->Screen "Default Screen" (0)
(**) |   |-->Monitor "Generic Monitor"
(**) |   |-->Device "CoralP"
(**) |-->Input Device "Generic Keyboard"
(**) Option "XkbRules" "xfree86"
(**) XKB: rules: "xfree86"
(**) Option "XkbModel" "macintosh"
(**) XKB: model: "macintosh"
(**) Option "XkbLayout" "us"
(**) XKB: layout: "us"
(==) Keyboard: CustomKeycode disabled
(**) |-->Input Device "Configured Mouse"
(WW) The directory "/usr/lib/X11/fonts/misc" does not exist.
 Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/cyrillic" does not exist.
 Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/100dpi/" does not exist.
 Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/75dpi/" does not exist.
 Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/Type1" does not exist.
 Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/CID" does not exist.
 Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/Speedo" does not exist.
 Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/100dpi" does not exist.
 Entry deleted from font path.
(WW) The directory "/usr/lib/X11/fonts/75dpi" does not exist.
 Entry deleted from font path.
(WW) FontPath is completely invalid.  Using compiled-in default.
(==) FontPath set to
"/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/CID/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(==) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(==) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 2

(WW) Open APM failed (/dev/apm_bios) (No such file or directory)
(II) Module ABI versions:
 XFree86 ANSI C Emulation: 0.2
 XFree86 Video Driver: 0.6
 XFree86 XInput driver : 0.4
 XFree86 Server Extension : 0.2
 XFree86 Font Renderer : 0.4
(II) Loader running on linux
(II) LoadModule: "bitmap"
(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 1.0.0
 Module class: XFree86 Font Renderer
 ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Bitmap
(II) LoadModule: "pcidata"
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 1.0.0
 ABI class: XFree86 Video Driver, version 0.6
(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:12:0: chip 10cf,201e card 0000,0000 rev 01 class 03,80,00 hdr
00
(II) PCI: 00:13:0: chip 1095,0680 card 1095,0680 rev 02 class 01,01,85 hdr
00
(II) PCI: 00:14:0: chip 10b5,6540 card 0000,0000 rev cb class 06,04,00 hdr
01
(II) PCI: End of PCI scan
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:20:0), (0,1,1), BCTRL: 0x0000 (VGA_EN is
cleared)
(II) Bus 1 I/O range:
 [0] -1 0 0x00ffe000 - 0x00ffefff (0x1000) IX[B]
(II) Bus 1 non-prefetchable memory range:
 [0] -1 0 0x9be00000 - 0x9befffff (0x100000) MX[B]
(II) Bus 1 prefetchable memory range:
 [0] -1 0 0x9bd00000 - 0x9bdfffff (0x100000) MX[B]
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (-1,0,0), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
 [0] -1 0 0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
 [0] -1 0 0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
 [0] -1 0 0x00000000 - 0xffffffff (0x0) MX[B]
(--) PCI:*(0:18:0) unknown vendor (0x10cf) unknown chipset (0x201e) rev 1,
Mem @ 0x9c000000/26
(II) Addressable bus resource ranges are
 [0] -1 0 0x00000000 - 0xffffffff (0x0) MX[B]
 [1] -1 0 0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
 [0] -1 0 0xffffffff - 0xffffffff (0x1) MX[B]
 [1] -1 0 0x00000000 - 0x00000000 (0x1) MX[B]
 [2] -1 0 0x0000ffff - 0x0000ffff (0x1) IX[B]
 [3] -1 0 0x00000000 - 0x00000000 (0x1) IX[B]
(II) Active PCI resource ranges:
 [0] -1 0 0x9bffff00 - 0x9bffffff (0x100) MX[B]
 [1] -1 0 0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)
 [2] -1 0 0x00ffffd0 - 0x00ffffdf (0x10) IX[B]
 [3] -1 0 0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]
 [4] -1 0 0x00ffffe8 - 0x00ffffef (0x8) IX[B]
 [5] -1 0 0x00fffff4 - 0x00fffff7 (0x4) IX[B]
 [6] -1 0 0x00fffff8 - 0x00ffffff (0x8) IX[B]
(II) Active PCI resource ranges after removing overlaps:
 [0] -1 0 0x9bffff00 - 0x9bffffff (0x100) MX[B]
 [1] -1 0 0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)
 [2] -1 0 0x00ffffd0 - 0x00ffffdf (0x10) IX[B]
 [3] -1 0 0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]
 [4] -1 0 0x00ffffe8 - 0x00ffffef (0x8) IX[B]
 [5] -1 0 0x00fffff4 - 0x00fffff7 (0x4) IX[B]
 [6] -1 0 0x00fffff8 - 0x00ffffff (0x8) IX[B]
(II) OS-reported resource ranges after removing overlaps with PCI:
 [0] -1 0 0xffffffff - 0xffffffff (0x1) MX[B]
 [1] -1 0 0x00000000 - 0x00000000 (0x1) MX[B]
 [2] -1 0 0x0000ffff - 0x0000ffff (0x1) IX[B]
 [3] -1 0 0x00000000 - 0x00000000 (0x1) IX[B]
(II) All system resource ranges:
 [0] -1 0 0xffffffff - 0xffffffff (0x1) MX[B]
 [1] -1 0 0x00000000 - 0x00000000 (0x1) MX[B]
 [2] -1 0 0x9bffff00 - 0x9bffffff (0x100) MX[B]
 [3] -1 0 0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)
 [4] -1 0 0x0000ffff - 0x0000ffff (0x1) IX[B]
 [5] -1 0 0x00000000 - 0x00000000 (0x1) IX[B]
 [6] -1 0 0x00ffffd0 - 0x00ffffdf (0x10) IX[B]
 [7] -1 0 0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]
 [8] -1 0 0x00ffffe8 - 0x00ffffef (0x8) IX[B]
 [9] -1 0 0x00fffff4 - 0x00fffff7 (0x4) IX[B]
 [10] -1 0 0x00fffff8 - 0x00ffffff (0x8) IX[B]
(II) LoadModule: "bitmap"
(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Loading font Bitmap
(II) LoadModule: "dbe"
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 1.0.0
 Module class: XFree86 Server Extension
 ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension DOUBLE-BUFFER
(II) LoadModule: "ddc"
(II) Loading /usr/X11R6/lib/modules/libddc.a
(II) Module ddc: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 1.0.0
 ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "extmod"
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 1.0.0
 Module class: XFree86 Server Extension
 ABI class: XFree86 Server Extension, version 0.2
(II) Loading extension SHAPE
(II) Loading extension MIT-SUNDRY-NONSTANDARD
(II) Loading extension BIG-REQUESTS
(II) Loading extension SYNC
(II) Loading extension MIT-SCREEN-SAVER
(II) Loading extension XC-MISC
(II) Loading extension XFree86-VidModeExtension
(II) Loading extension XFree86-Misc
(II) Loading extension XFree86-DGA
(II) Loading extension DPMS
(II) Loading extension FontCache
(II) Loading extension TOG-CUP
(II) Loading extension Extended-Visual-Information
(II) Loading extension XVideo
(II) Loading extension XVideo-MotionCompensation
(II) Loading extension X-Resource
(II) LoadModule: "freetype"
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a
(II) Module freetype: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 2.0.2
 Module class: XFree86 Font Renderer
 ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font FreeType
(II) LoadModule: "speedo"
(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a
(II) Module speedo: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 1.0.1
 Module class: XFree86 Font Renderer
 ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Speedo
(II) LoadModule: "type1"
(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a
(II) Module type1: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 1.0.2
 Module class: XFree86 Font Renderer
 ABI class: XFree86 Font Renderer, version 0.4
(II) Loading font Type1
(II) LoadModule: "vbe"
(II) Loading /usr/X11R6/lib/modules/libvbe.a
(II) Module vbe: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 1.1.0
 ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "mb86290"
(II) Loading /usr/X11R6/lib/modules/drivers/mb86290_drv.o
(II) Module mb86290: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 0.1.0
 Module class: XFree86 Video Driver
 ABI class: XFree86 Video Driver, version 0.6
(II) LoadModule: "mouse"
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 1.0.0
 Module class: XFree86 XInput Driver
 ABI class: XFree86 XInput driver, version 0.4
(II) MB86290: Fujitsu chip: mb86290
(II) Primary Device is: PCI 00:12:0
(II) Loading sub module "fbdevhw"
(II) LoadModule: "fbdevhw"
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 0.0.2
 ABI class: XFree86 Video Driver, version 0.6
(--) Assigning device section with no busID to primary device
(--) Chipset mb86290 found
(II) resource ranges after xf86ClaimFixedResources() call:
 [0] -1 0 0xffffffff - 0xffffffff (0x1) MX[B]
 [1] -1 0 0x00000000 - 0x00000000 (0x1) MX[B]
 [2] -1 0 0x9bffff00 - 0x9bffffff (0x100) MX[B]
 [3] -1 0 0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)
 [4] -1 0 0x0000ffff - 0x0000ffff (0x1) IX[B]
 [5] -1 0 0x00000000 - 0x00000000 (0x1) IX[B]
 [6] -1 0 0x00ffffd0 - 0x00ffffdf (0x10) IX[B]
 [7] -1 0 0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]
 [8] -1 0 0x00ffffe8 - 0x00ffffef (0x8) IX[B]
 [9] -1 0 0x00fffff4 - 0x00fffff7 (0x4) IX[B]
 [10] -1 0 0x00fffff8 - 0x00ffffff (0x8) IX[B]
(II) resource ranges after probing:
 [0] -1 0 0xffffffff - 0xffffffff (0x1) MX[B]
 [1] -1 0 0x00000000 - 0x00000000 (0x1) MX[B]
 [2] -1 0 0x9bffff00 - 0x9bffffff (0x100) MX[B]
 [3] -1 0 0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)
 [4] 0 0 0x000a0000 - 0x000affff (0x10000) MS[B]
 [5] 0 0 0x000b0000 - 0x000b7fff (0x8000) MS[B]
 [6] 0 0 0x000b8000 - 0x000bffff (0x8000) MS[B]
 [7] -1 0 0x0000ffff - 0x0000ffff (0x1) IX[B]
 [8] -1 0 0x00000000 - 0x00000000 (0x1) IX[B]
 [9] -1 0 0x00ffffd0 - 0x00ffffdf (0x10) IX[B]
 [10] -1 0 0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]
 [11] -1 0 0x00ffffe8 - 0x00ffffef (0x8) IX[B]
 [12] -1 0 0x00fffff4 - 0x00fffff7 (0x4) IX[B]
 [13] -1 0 0x00fffff8 - 0x00ffffff (0x8) IX[B]
 [14] 0 0 0x000003b0 - 0x000003bb (0xc) IS[B]
 [15] 0 0 0x000003c0 - 0x000003df (0x20) IS[B]
(II) Setting vga for screen 0.
fbdevHW: Init 0
(==) MB86290(0): Depth 15, (==) framebuffer bpp 16
(==) MB86290(0): RGB weight 555
(==) MB86290(0): Default visual is TrueColor
(==) MB86290(0): Using gamma correction (1.0, 1.0, 1.0)
(**) MB86290(0): Option "accel" "no"
(**) MB86290(0): Option "video" "no"
fbdevHW: UseBuildinMode 0
(--) MB86290(0): Virtual size is 1024x768 (pitch 1024)
(**) MB86290(0):  Built-in mode "current": 50.0 MHz, 48.8 kHz, 63.6 Hz
(II) MB86290(0): Modeline "current"   50.00  1024 1024 1024 1024  768 768
768 768 -hsync -vsync -csync
(==) MB86290(0): DPI set to (75, 75)
(II) Loading sub module "mb86290_fb"
(II) LoadModule: "mb86290_fb"
(II) Loading /usr/X11R6/lib/modules/libmb86290_fb.a
(II) Module mb86290_fb: vendor="The XFree86 Project"
 compiled for 4.3.0, module version = 1.0.0
 ABI class: XFree86 ANSI C Emulation, version 0.2
(II) do I need RAC?  No, I don't.
(II) resource ranges after preInit:
 [0] 0 0 0x9c000000 - 0x9fffffff (0x4000000) MX[B]
 [1] -1 0 0xffffffff - 0xffffffff (0x1) MX[B]
 [2] -1 0 0x00000000 - 0x00000000 (0x1) MX[B]
 [3] -1 0 0x9bffff00 - 0x9bffffff (0x100) MX[B]
 [4] -1 0 0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)
 [5] 0 0 0x000a0000 - 0x000affff (0x10000) MS[B]
 [6] 0 0 0x000b0000 - 0x000b7fff (0x8000) MS[B]
 [7] 0 0 0x000b8000 - 0x000bffff (0x8000) MS[B]
 [8] -1 0 0x0000ffff - 0x0000ffff (0x1) IX[B]
 [9] -1 0 0x00000000 - 0x00000000 (0x1) IX[B]
 [10] -1 0 0x00ffffd0 - 0x00ffffdf (0x10) IX[B]
 [11] -1 0 0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]
 [12] -1 0 0x00ffffe8 - 0x00ffffef (0x8) IX[B]
 [13] -1 0 0x00fffff4 - 0x00fffff7 (0x4) IX[B]
 [14] -1 0 0x00fffff8 - 0x00ffffff (0x8) IX[B]
 [15] 0 0 0x000003b0 - 0x000003bb (0xc) IS[B]
 [16] 0 0 0x000003c0 - 0x000003df (0x20) IS[B]
fbdevHW: MapVidmem 0
fbdevHW: LinearOffset 0
fbdevHW: Save 0
fbdevHW: ModeInit 0
xfree init mode: 50000   1024 1024 1024 1024   768 768 768 768
fbdev init mode: 20000   1024 0 0 0   768 0 0 0   16 5:5:5
fbdevHW: AdjustFrame 0
(==) MB86290(0): Backing store disabled
(II) MB86290(0): Acceleration disabled
fbdevHW: ModeInit 0

 Thanks,
liuxs

------=_Part_7825_31958225.1206882866741
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<span class="gmail_quote"></span>
<div>hi,all</div>
<div>&nbsp;</div>
<div>I&nbsp; compiled linux-2.6.12 for mpc8540 with DENX eldk4.0, my plabtform is custom mpc8540 board,&nbsp;mb86296 video card,&nbsp;eldk4.0 ppc_85xx file sysytem. Accelerated&nbsp; driver is x11_mb86290 <span>offered by DENX .</span>&nbsp; I compiled XFree86 4.3.0, then I ran&nbsp;startx, the screen was black for a few seconds and it turned to text mode.</div>

<div>&nbsp;</div>
<div>there are some hints in XFree86.0.log:</div>
<div>&nbsp;</div>
<div>
<p>fbdevHW: MapVidmem 0<br>&nbsp;fbdevHW: LinearOffset 0<br>&nbsp;fbdevHW: Save 0<br>&nbsp;fbdevHW: ModeInit 0<br>&nbsp;xfree init mode:&nbsp;50000&nbsp;&nbsp; 1024 1024 1024 1024&nbsp;&nbsp; 768 768 768 768<br>&nbsp;fbdev init mode:&nbsp;20000&nbsp;&nbsp; 1024 0 0 0&nbsp;&nbsp; 768 0 0 0&nbsp;&nbsp; 16 5:5:5<br>
&nbsp;fbdevHW: AdjustFrame 0<br>&nbsp;(==) MB86290(0): Backing store disabled<br>&nbsp;(II) MB86290(0): Using XFree86 Acceleration Architecture (XAA)<br>&nbsp;&nbsp;Screen to screen bit blits<br>&nbsp;&nbsp;Solid filled rectangles<br>&nbsp;&nbsp;8x8 mono pattern filled rectangles<br>
&nbsp;&nbsp;Indirect CPU to Screen color expansion<br>&nbsp;&nbsp;Solid Lines<br>&nbsp;&nbsp;Dashed Lines<br>&nbsp;(II) MB86290(0): Acceleration enabled<br>&nbsp;fbdevHW: ModeInit 0</p>
<p>&nbsp;Fatal server error:<br>&nbsp;AddScreen/ScreenInit failed for driver 0</p>
<p><br>&nbsp;When reporting a problem related to a server crash, please send<br>&nbsp;the full server output, not just the last messages.<br>&nbsp;This can be found in the log file &quot;/var/log/XFree86.0.log&quot;.<br>&nbsp;Please report problems to <a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:xfree86@xfree86.org" target="_blank">xfree86@xfree86.org</a>.</p>

<p>&nbsp;fbdevHW: LeaveVT 0<br>&nbsp;fbdevHW: Restore 0<br></p>
<p>then I changed configuration file as follows:</p>
<p>Section &quot;Device&quot;</p>
<p><br>&nbsp;&nbsp;Identifier&nbsp;&quot;CoralP&quot;<br>&nbsp;&nbsp;Driver&nbsp;&nbsp;&quot;mb86290&quot;<br>&nbsp;&nbsp;Option&nbsp;&quot;Video&quot; &quot;no&quot;&nbsp;&nbsp;--forbid I2c bus</p>
<p>EndSection</p>
<p>then I run startx, the screen was black forever and there was no MousePointer, and&nbsp; here is output of XFree86.0.log:</p>
<p>XFree86 Version 4.3.0<br>Release Date: 27 February 2003<br>X Protocol Version 11, Revision 0, Release 6.6<br>Build Operating System: Linux <a onclick="return top.js.OpenExtLink(window,event,this)" href="http://2.6.12.6/" target="_blank">2.6.12.6</a> ppc [ELF] <br>
Build Date: 17 March 2008<br>&nbsp;Before reporting problems, check <a onclick="return top.js.OpenExtLink(window,event,this)" href="http://www.xfree86.org/" target="_blank">http://www.XFree86.Org/</a><br>&nbsp;to make sure that you have the latest version.<br>
Module Loader present<br>Markers: (--) probed, (**) from config file, (==) default setting,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (++) from command line, (!!) notice, (II) informational,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (WW) warning, (EE) error, (NI) not implemented, (??) unknown.<br>
(==) Log file: &quot;/var/log/XFree86.0.log&quot;, Time: Wed Mar 19 17:24:36 2008<br>(==) Using config file: &quot;/etc/X11/XF86Config-4&quot;<br>(==) ServerLayout &quot;Default Layout&quot;<br>(**) |--&gt;Screen &quot;Default Screen&quot; (0)<br>
(**) |&nbsp;&nbsp; |--&gt;Monitor &quot;Generic Monitor&quot;<br>(**) |&nbsp;&nbsp; |--&gt;Device &quot;CoralP&quot;<br>(**) |--&gt;Input Device &quot;Generic Keyboard&quot;<br>(**) Option &quot;XkbRules&quot; &quot;xfree86&quot;<br>(**) XKB: rules: &quot;xfree86&quot;<br>
(**) Option &quot;XkbModel&quot; &quot;macintosh&quot;<br>(**) XKB: model: &quot;macintosh&quot;<br>(**) Option &quot;XkbLayout&quot; &quot;us&quot;<br>(**) XKB: layout: &quot;us&quot;<br>(==) Keyboard: CustomKeycode disabled<br>
(**) |--&gt;Input Device &quot;Configured Mouse&quot;<br>(WW) The directory &quot;/usr/lib/X11/fonts/misc&quot; does not exist.<br>&nbsp;Entry deleted from font path.<br>(WW) The directory &quot;/usr/lib/X11/fonts/cyrillic&quot; does not exist.<br>
&nbsp;Entry deleted from font path.<br>(WW) The directory &quot;/usr/lib/X11/fonts/100dpi/&quot; does not exist.<br>&nbsp;Entry deleted from font path.<br>(WW) The directory &quot;/usr/lib/X11/fonts/75dpi/&quot; does not exist.<br>
&nbsp;Entry deleted from font path.<br>(WW) The directory &quot;/usr/lib/X11/fonts/Type1&quot; does not exist.<br>&nbsp;Entry deleted from font path.<br>(WW) The directory &quot;/usr/lib/X11/fonts/CID&quot; does not exist.<br>&nbsp;Entry deleted from font path.<br>
(WW) The directory &quot;/usr/lib/X11/fonts/Speedo&quot; does not exist.<br>&nbsp;Entry deleted from font path.<br>(WW) The directory &quot;/usr/lib/X11/fonts/100dpi&quot; does not exist.<br>&nbsp;Entry deleted from font path.<br>(WW) The directory &quot;/usr/lib/X11/fonts/75dpi&quot; does not exist.<br>
&nbsp;Entry deleted from font path.<br>(WW) FontPath is completely invalid.&nbsp; Using compiled-in default.<br>(==) FontPath set to &quot;/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/CID/,/usr/X11R6/lib/X11/fonts/75dpi/,/usr/X11R6/lib/X11/fonts/100dpi/&quot;<br>
(==) RgbPath set to &quot;/usr/X11R6/lib/X11/rgb&quot;<br>(==) ModulePath set to &quot;/usr/X11R6/lib/modules&quot;<br>(--) using VT number 2</p>
<p>(WW) Open APM failed (/dev/apm_bios) (No such file or directory)<br>(II) Module ABI versions:<br>&nbsp;XFree86 ANSI C Emulation: 0.2<br>&nbsp;XFree86 Video Driver: 0.6<br>&nbsp;XFree86 XInput driver : 0.4<br>&nbsp;XFree86 Server Extension : 0.2<br>
&nbsp;XFree86 Font Renderer : 0.4<br>(II) Loader running on linux<br>(II) LoadModule: &quot;bitmap&quot;<br>(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a<br>(II) Module bitmap: vendor=&quot;The XFree86 Project&quot;<br>
&nbsp;compiled for 4.3.0, module version = 1.0.0<br>&nbsp;Module class: XFree86 Font Renderer<br>&nbsp;ABI class: XFree86 Font Renderer, version 0.4<br>(II) Loading font Bitmap<br>(II) LoadModule: &quot;pcidata&quot;<br>(II) Loading /usr/X11R6/lib/modules/libpcidata.a<br>
(II) Module pcidata: vendor=&quot;The XFree86 Project&quot;<br>&nbsp;compiled for 4.3.0, module version = 1.0.0<br>&nbsp;ABI class: XFree86 Video Driver, version 0.6<br>(II) PCI: PCI scan (all values are in hex)<br>(II) PCI: 00:12:0: chip 10cf,201e card 0000,0000 rev 01 class 03,80,00 hdr 00<br>
(II) PCI: 00:13:0: chip 1095,0680 card 1095,0680 rev 02 class 01,01,85 hdr 00<br>(II) PCI: 00:14:0: chip 10b5,6540 card 0000,0000 rev cb class 06,04,00 hdr 01<br>(II) PCI: End of PCI scan<br>(II) PCI-to-PCI bridge:<br>(II) Bus 1: bridge is at (0:20:0), (0,1,1), BCTRL: 0x0000 (VGA_EN is cleared)<br>
(II) Bus 1 I/O range:<br>&nbsp;[0] -1&nbsp;0&nbsp;0x00ffe000 - 0x00ffefff (0x1000) IX[B]<br>(II) Bus 1 non-prefetchable memory range:<br>&nbsp;[0] -1&nbsp;0&nbsp;0x9be00000 - 0x9befffff (0x100000) MX[B]<br>(II) Bus 1 prefetchable memory range:<br>&nbsp;[0] -1&nbsp;0&nbsp;0x9bd00000 - 0x9bdfffff (0x100000) MX[B]<br>
(II) Host-to-PCI bridge:<br>(II) Bus 0: bridge is at (0:0:0), (-1,0,0), BCTRL: 0x0008 (VGA_EN is set)<br>(II) Bus 0 I/O range:<br>&nbsp;[0] -1&nbsp;0&nbsp;0x00000000 - 0x0000ffff (0x10000) IX[B]<br>(II) Bus 0 non-prefetchable memory range:<br>
&nbsp;[0] -1&nbsp;0&nbsp;0x00000000 - 0xffffffff (0x0) MX[B]<br>(II) Bus 0 prefetchable memory range:<br>&nbsp;[0] -1&nbsp;0&nbsp;0x00000000 - 0xffffffff (0x0) MX[B]<br>(--) PCI:*(0:18:0) unknown vendor (0x10cf) unknown chipset (0x201e) rev 1, Mem @ 0x9c000000/26<br>
(II) Addressable bus resource ranges are<br>&nbsp;[0] -1&nbsp;0&nbsp;0x00000000 - 0xffffffff (0x0) MX[B]<br>&nbsp;[1] -1&nbsp;0&nbsp;0x00000000 - 0x0000ffff (0x10000) IX[B]<br>(II) OS-reported resource ranges:<br>&nbsp;[0] -1&nbsp;0&nbsp;0xffffffff - 0xffffffff (0x1) MX[B]<br>
&nbsp;[1] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) MX[B]<br>&nbsp;[2] -1&nbsp;0&nbsp;0x0000ffff - 0x0000ffff (0x1) IX[B]<br>&nbsp;[3] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) IX[B]<br>(II) Active PCI resource ranges:<br>&nbsp;[0] -1&nbsp;0&nbsp;0x9bffff00 - 0x9bffffff (0x100) MX[B]<br>
&nbsp;[1] -1&nbsp;0&nbsp;0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)<br>&nbsp;[2] -1&nbsp;0&nbsp;0x00ffffd0 - 0x00ffffdf (0x10) IX[B]<br>&nbsp;[3] -1&nbsp;0&nbsp;0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]<br>&nbsp;[4] -1&nbsp;0&nbsp;0x00ffffe8 - 0x00ffffef (0x8) IX[B]<br>&nbsp;[5] -1&nbsp;0&nbsp;0x00fffff4 - 0x00fffff7 (0x4) IX[B]<br>
&nbsp;[6] -1&nbsp;0&nbsp;0x00fffff8 - 0x00ffffff (0x8) IX[B]<br>(II) Active PCI resource ranges after removing overlaps:<br>&nbsp;[0] -1&nbsp;0&nbsp;0x9bffff00 - 0x9bffffff (0x100) MX[B]<br>&nbsp;[1] -1&nbsp;0&nbsp;0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)<br>&nbsp;[2] -1&nbsp;0&nbsp;0x00ffffd0 - 0x00ffffdf (0x10) IX[B]<br>
&nbsp;[3] -1&nbsp;0&nbsp;0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]<br>&nbsp;[4] -1&nbsp;0&nbsp;0x00ffffe8 - 0x00ffffef (0x8) IX[B]<br>&nbsp;[5] -1&nbsp;0&nbsp;0x00fffff4 - 0x00fffff7 (0x4) IX[B]<br>&nbsp;[6] -1&nbsp;0&nbsp;0x00fffff8 - 0x00ffffff (0x8) IX[B]<br>(II) OS-reported resource ranges after removing overlaps with PCI:<br>
&nbsp;[0] -1&nbsp;0&nbsp;0xffffffff - 0xffffffff (0x1) MX[B]<br>&nbsp;[1] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) MX[B]<br>&nbsp;[2] -1&nbsp;0&nbsp;0x0000ffff - 0x0000ffff (0x1) IX[B]<br>&nbsp;[3] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) IX[B]<br>(II) All system resource ranges:<br>
&nbsp;[0] -1&nbsp;0&nbsp;0xffffffff - 0xffffffff (0x1) MX[B]<br>&nbsp;[1] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) MX[B]<br>&nbsp;[2] -1&nbsp;0&nbsp;0x9bffff00 - 0x9bffffff (0x100) MX[B]<br>&nbsp;[3] -1&nbsp;0&nbsp;0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)<br>&nbsp;[4] -1&nbsp;0&nbsp;0x0000ffff - 0x0000ffff (0x1) IX[B]<br>
&nbsp;[5] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) IX[B]<br>&nbsp;[6] -1&nbsp;0&nbsp;0x00ffffd0 - 0x00ffffdf (0x10) IX[B]<br>&nbsp;[7] -1&nbsp;0&nbsp;0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]<br>&nbsp;[8] -1&nbsp;0&nbsp;0x00ffffe8 - 0x00ffffef (0x8) IX[B]<br>&nbsp;[9] -1&nbsp;0&nbsp;0x00fffff4 - 0x00fffff7 (0x4) IX[B]<br>
&nbsp;[10] -1&nbsp;0&nbsp;0x00fffff8 - 0x00ffffff (0x8) IX[B]<br>(II) LoadModule: &quot;bitmap&quot;<br>(II) Reloading /usr/X11R6/lib/modules/fonts/libbitmap.a<br>(II) Loading font Bitmap<br>(II) LoadModule: &quot;dbe&quot;<br>(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a<br>
(II) Module dbe: vendor=&quot;The XFree86 Project&quot;<br>&nbsp;compiled for 4.3.0, module version = 1.0.0<br>&nbsp;Module class: XFree86 Server Extension<br>&nbsp;ABI class: XFree86 Server Extension, version 0.2<br>(II) Loading extension DOUBLE-BUFFER<br>
(II) LoadModule: &quot;ddc&quot;<br>(II) Loading /usr/X11R6/lib/modules/libddc.a<br>(II) Module ddc: vendor=&quot;The XFree86 Project&quot;<br>&nbsp;compiled for 4.3.0, module version = 1.0.0<br>&nbsp;ABI class: XFree86 Video Driver, version 0.6<br>
(II) LoadModule: &quot;extmod&quot;<br>(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a<br>(II) Module extmod: vendor=&quot;The XFree86 Project&quot;<br>&nbsp;compiled for 4.3.0, module version = 1.0.0<br>&nbsp;Module class: XFree86 Server Extension<br>
&nbsp;ABI class: XFree86 Server Extension, version 0.2<br>(II) Loading extension SHAPE<br>(II) Loading extension MIT-SUNDRY-NONSTANDARD<br>(II) Loading extension BIG-REQUESTS<br>(II) Loading extension SYNC<br>(II) Loading extension MIT-SCREEN-SAVER<br>
(II) Loading extension XC-MISC<br>(II) Loading extension XFree86-VidModeExtension<br>(II) Loading extension XFree86-Misc<br>(II) Loading extension XFree86-DGA<br>(II) Loading extension DPMS<br>(II) Loading extension FontCache<br>
(II) Loading extension TOG-CUP<br>(II) Loading extension Extended-Visual-Information<br>(II) Loading extension XVideo<br>(II) Loading extension XVideo-MotionCompensation<br>(II) Loading extension X-Resource<br>(II) LoadModule: &quot;freetype&quot;<br>
(II) Loading /usr/X11R6/lib/modules/fonts/libfreetype.a<br>(II) Module freetype: vendor=&quot;The XFree86 Project&quot;<br>&nbsp;compiled for 4.3.0, module version = 2.0.2<br>&nbsp;Module class: XFree86 Font Renderer<br>&nbsp;ABI class: XFree86 Font Renderer, version 0.4<br>
(II) Loading font FreeType<br>(II) LoadModule: &quot;speedo&quot;<br>(II) Loading /usr/X11R6/lib/modules/fonts/libspeedo.a<br>(II) Module speedo: vendor=&quot;The XFree86 Project&quot;<br>&nbsp;compiled for 4.3.0, module version = 1.0.1<br>
&nbsp;Module class: XFree86 Font Renderer<br>&nbsp;ABI class: XFree86 Font Renderer, version 0.4<br>(II) Loading font Speedo<br>(II) LoadModule: &quot;type1&quot;<br>(II) Loading /usr/X11R6/lib/modules/fonts/libtype1.a<br>(II) Module type1: vendor=&quot;The XFree86 Project&quot;<br>
&nbsp;compiled for 4.3.0, module version = 1.0.2<br>&nbsp;Module class: XFree86 Font Renderer<br>&nbsp;ABI class: XFree86 Font Renderer, version 0.4<br>(II) Loading font Type1<br>(II) LoadModule: &quot;vbe&quot;<br>(II) Loading /usr/X11R6/lib/modules/libvbe.a<br>
(II) Module vbe: vendor=&quot;The XFree86 Project&quot;<br>&nbsp;compiled for 4.3.0, module version = 1.1.0<br>&nbsp;ABI class: XFree86 Video Driver, version 0.6<br>(II) LoadModule: &quot;mb86290&quot;<br>(II) Loading /usr/X11R6/lib/modules/drivers/mb86290_drv.o<br>
(II) Module mb86290: vendor=&quot;The XFree86 Project&quot;<br>&nbsp;compiled for 4.3.0, module version = 0.1.0<br>&nbsp;Module class: XFree86 Video Driver<br>&nbsp;ABI class: XFree86 Video Driver, version 0.6<br>(II) LoadModule: &quot;mouse&quot;<br>
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o<br>(II) Module mouse: vendor=&quot;The XFree86 Project&quot;<br>&nbsp;compiled for 4.3.0, module version = 1.0.0<br>&nbsp;Module class: XFree86 XInput Driver<br>&nbsp;ABI class: XFree86 XInput driver, version 0.4<br>
(II) MB86290: Fujitsu chip: mb86290<br>(II) Primary Device is: PCI 00:12:0<br>(II) Loading sub module &quot;fbdevhw&quot;<br>(II) LoadModule: &quot;fbdevhw&quot;<br>(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a<br>
(II) Module fbdevhw: vendor=&quot;The XFree86 Project&quot;<br>&nbsp;compiled for 4.3.0, module version = 0.0.2<br>&nbsp;ABI class: XFree86 Video Driver, version 0.6<br>(--) Assigning device section with no busID to primary device<br>
(--) Chipset mb86290 found<br>(II) resource ranges after xf86ClaimFixedResources() call:<br>&nbsp;[0] -1&nbsp;0&nbsp;0xffffffff - 0xffffffff (0x1) MX[B]<br>&nbsp;[1] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) MX[B]<br>&nbsp;[2] -1&nbsp;0&nbsp;0x9bffff00 - 0x9bffffff (0x100) MX[B]<br>
&nbsp;[3] -1&nbsp;0&nbsp;0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)<br>&nbsp;[4] -1&nbsp;0&nbsp;0x0000ffff - 0x0000ffff (0x1) IX[B]<br>&nbsp;[5] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) IX[B]<br>&nbsp;[6] -1&nbsp;0&nbsp;0x00ffffd0 - 0x00ffffdf (0x10) IX[B]<br>&nbsp;[7] -1&nbsp;0&nbsp;0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]<br>
&nbsp;[8] -1&nbsp;0&nbsp;0x00ffffe8 - 0x00ffffef (0x8) IX[B]<br>&nbsp;[9] -1&nbsp;0&nbsp;0x00fffff4 - 0x00fffff7 (0x4) IX[B]<br>&nbsp;[10] -1&nbsp;0&nbsp;0x00fffff8 - 0x00ffffff (0x8) IX[B]<br>(II) resource ranges after probing:<br>&nbsp;[0] -1&nbsp;0&nbsp;0xffffffff - 0xffffffff (0x1) MX[B]<br>
&nbsp;[1] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) MX[B]<br>&nbsp;[2] -1&nbsp;0&nbsp;0x9bffff00 - 0x9bffffff (0x100) MX[B]<br>&nbsp;[3] -1&nbsp;0&nbsp;0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)<br>&nbsp;[4] 0&nbsp;0&nbsp;0x000a0000 - 0x000affff (0x10000) MS[B]<br>&nbsp;[5] 0&nbsp;0&nbsp;0x000b0000 - 0x000b7fff (0x8000) MS[B]<br>
&nbsp;[6] 0&nbsp;0&nbsp;0x000b8000 - 0x000bffff (0x8000) MS[B]<br>&nbsp;[7] -1&nbsp;0&nbsp;0x0000ffff - 0x0000ffff (0x1) IX[B]<br>&nbsp;[8] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) IX[B]<br>&nbsp;[9] -1&nbsp;0&nbsp;0x00ffffd0 - 0x00ffffdf (0x10) IX[B]<br>&nbsp;[10] -1&nbsp;0&nbsp;0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]<br>
&nbsp;[11] -1&nbsp;0&nbsp;0x00ffffe8 - 0x00ffffef (0x8) IX[B]<br>&nbsp;[12] -1&nbsp;0&nbsp;0x00fffff4 - 0x00fffff7 (0x4) IX[B]<br>&nbsp;[13] -1&nbsp;0&nbsp;0x00fffff8 - 0x00ffffff (0x8) IX[B]<br>&nbsp;[14] 0&nbsp;0&nbsp;0x000003b0 - 0x000003bb (0xc) IS[B]<br>&nbsp;[15] 0&nbsp;0&nbsp;0x000003c0 - 0x000003df (0x20) IS[B]<br>
(II) Setting vga for screen 0.<br>fbdevHW: Init 0<br>(==) MB86290(0): Depth 15, (==) framebuffer bpp 16<br>(==) MB86290(0): RGB weight 555<br>(==) MB86290(0): Default visual is TrueColor<br>(==) MB86290(0): Using gamma correction (1.0, 1.0, 1.0)<br>
(**) MB86290(0): Option &quot;accel&quot; &quot;no&quot;<br>(**) MB86290(0): Option &quot;video&quot; &quot;no&quot;<br>fbdevHW: UseBuildinMode 0<br>(--) MB86290(0): Virtual size is 1024x768 (pitch 1024)<br>(**) MB86290(0):&nbsp; Built-in mode &quot;current&quot;: 50.0 MHz, 48.8 kHz, 63.6 Hz<br>
(II) MB86290(0): Modeline &quot;current&quot;&nbsp;&nbsp; 50.00&nbsp; 1024 1024 1024 1024&nbsp; 768 768 768 768 -hsync -vsync -csync<br>(==) MB86290(0): DPI set to (75, 75)<br>(II) Loading sub module &quot;mb86290_fb&quot;<br>(II) LoadModule: &quot;mb86290_fb&quot;<br>
(II) Loading /usr/X11R6/lib/modules/libmb86290_fb.a<br>(II) Module mb86290_fb: vendor=&quot;The XFree86 Project&quot;<br>&nbsp;compiled for 4.3.0, module version = 1.0.0<br>&nbsp;ABI class: XFree86 ANSI C Emulation, version 0.2<br>
(II) do I need RAC?&nbsp; No, I don&#39;t.<br>(II) resource ranges after preInit:<br>&nbsp;[0] 0&nbsp;0&nbsp;0x9c000000 - 0x9fffffff (0x4000000) MX[B]<br>&nbsp;[1] -1&nbsp;0&nbsp;0xffffffff - 0xffffffff (0x1) MX[B]<br>&nbsp;[2] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) MX[B]<br>
&nbsp;[3] -1&nbsp;0&nbsp;0x9bffff00 - 0x9bffffff (0x100) MX[B]<br>&nbsp;[4] -1&nbsp;0&nbsp;0x9c000000 - 0x9fffffff (0x4000000) MX[B](B)<br>&nbsp;[5] 0&nbsp;0&nbsp;0x000a0000 - 0x000affff (0x10000) MS[B]<br>&nbsp;[6] 0&nbsp;0&nbsp;0x000b0000 - 0x000b7fff (0x8000) MS[B]<br>&nbsp;[7] 0&nbsp;0&nbsp;0x000b8000 - 0x000bffff (0x8000) MS[B]<br>
&nbsp;[8] -1&nbsp;0&nbsp;0x0000ffff - 0x0000ffff (0x1) IX[B]<br>&nbsp;[9] -1&nbsp;0&nbsp;0x00000000 - 0x00000000 (0x1) IX[B]<br>&nbsp;[10] -1&nbsp;0&nbsp;0x00ffffd0 - 0x00ffffdf (0x10) IX[B]<br>&nbsp;[11] -1&nbsp;0&nbsp;0x00ffffe4 - 0x00ffffe7 (0x4) IX[B]<br>&nbsp;[12] -1&nbsp;0&nbsp;0x00ffffe8 - 0x00ffffef (0x8) IX[B]<br>
&nbsp;[13] -1&nbsp;0&nbsp;0x00fffff4 - 0x00fffff7 (0x4) IX[B]<br>&nbsp;[14] -1&nbsp;0&nbsp;0x00fffff8 - 0x00ffffff (0x8) IX[B]<br>&nbsp;[15] 0&nbsp;0&nbsp;0x000003b0 - 0x000003bb (0xc) IS[B]<br>&nbsp;[16] 0&nbsp;0&nbsp;0x000003c0 - 0x000003df (0x20) IS[B]<br>fbdevHW: MapVidmem 0<br>
fbdevHW: LinearOffset 0<br>fbdevHW: Save 0<br>fbdevHW: ModeInit 0<br>xfree init mode:&nbsp;50000&nbsp;&nbsp; 1024 1024 1024 1024&nbsp;&nbsp; 768 768 768 768<br>fbdev init mode:&nbsp;20000&nbsp;&nbsp; 1024 0 0 0&nbsp;&nbsp; 768 0 0 0&nbsp;&nbsp; 16 5:5:5<br>fbdevHW: AdjustFrame 0<br>
(==) MB86290(0): Backing store disabled<br>(II) MB86290(0): Acceleration disabled<br>fbdevHW: ModeInit 0<br></p></div>
<div>&nbsp;</div>
<div>&nbsp;Thanks,</div>
<div>liuxs</div>

------=_Part_7825_31958225.1206882866741--
