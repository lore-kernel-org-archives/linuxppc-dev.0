Date: Wed, 26 Jul 2000 09:24:49 -0400
From: Josh Huber <huber@mclx.com>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: xf4 hang on mach64
Message-ID: <20000726092449.A404@mclx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--GID0FwUMdk1T2AWN
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Has anyone had any luck with Ani's drivers for the Mach64 chipset?  If
you have, could you send me your XF86Config?  I'm getting the
following kind of output:

(II) ATI: ATI driver (version 5.3.5) for chipsets: ati, ativga
(--) Chipset ATI Mach64 3D Rage LT Pro (PCI) found
Found a Mach64 on a PowerPC
(WW) ****INVALID MEM ALLOCATION**** b: 0x82000000 e: 0x82ffffff correcting
own
        [0] -1  0x82fff000 - 0x82ffffff (0x1000) MXB
        [1] -1  0x00000400 - 0x000004ff (0x100) IXB
(II) Loading /usr/X11R6/lib/modules/linux/libfbdevhw.a
(II) Module fbdevhw: vendor=3D"The XFree86 Project"
        compiled for 4.0e, module version =3D 0.0.1
(**) ATI(0): Depth 15, (--) framebuffer bpp 16
(=3D=3D) ATI(0): RGB weight 555
(=3D=3D) ATI(0): Default visual is TrueColor
Mapping MMIO @ 0x17ff000 with size 0x1000
testing mmio w/ scratch regs...
SCRATCH_REG0 =3D 0x0
SCRATCH_REG0 =3D 0x12345678
SCRATCH_REG1 =3D 0x0
SCRATCH_REG1 =3D 0xdeadbeef
Chip Type =3D 0x0, Rev =3D 0x0
(--) ATI(0): VideoRam: 2048 kByte (OFF)
(=3D=3D) ATI(0): Using gamma correction (1.0, 1.0, 1.0)
(II) ATI(0): Apple 1024x768 LCD: Using hsync range of  31.00-190.00 kHz
(II) ATI(0): Apple 1024x768 LCD: Using vrefresh range of  58.00-190.00 Hz

****At this point, the machine hangs****

Once, believe it or not, syslogd was able to write a machine check
output to disk:

Machine check in kernel mode.  (regs at c8005a10)
Caused by (from srr1): Unknown values in srr1
NIP: C012D7F8 XER: 20000000 LR: C012D7E4 REGS: c8005a10 TRAP: 0200
MSR: 00009030 [EEIRDRME]
TASK =3D c8004000[640] 'XFree86' mm->pgd c85fe000 Last syscall: 54
last math c8004000
GPR00: 000000B0 C8005AC0 C8004000 00000034 0000001B C05AD000 C05AD52C 00000=
000
GPR08: 00000000 FFFFFFFF 003A0627 CC002C00 00000300 101CD010 00000010 00000=
001
GPR16: 101E0310 102F92F4 00000800 00000400 00009032 08005E80 00000010 00000=
000
GPR24: 00000300 00000006 00000400 00000300 C05AD000 00000400 C8005C48 C05AD=
000
Call backtrace:
C012D7E4 C012E28C C012834C C0041C70 C0003928 1003C7D0 10051F10
102FAEDC 10041988 1004260C 102EBF44 1002406C 10089300 0FE9A75C
00000000
Kernel panic: machine check

Of course, I don't have the corresponding System.map, which really
sucks...but perhaps someone knows what's going on here.

(my config file is attached)

Thanks,
--=20
Josh
6B21489A | GnuPG ID/Fingerprint | huber@mclx.com |
61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="XF86Config.test"

Section "Files"
    RgbPath	"/usr/X11R6/lib/X11/rgb"
    FontPath	"/usr/X11R6/lib/X11/fonts/local/"
    FontPath	"/usr/X11R6/lib/X11/fonts/misc/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/:unscaled"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/:unscaled"
    FontPath	"/usr/X11R6/lib/X11/fonts/Type1/"
    FontPath	"/usr/X11R6/lib/X11/fonts/CID/"
    FontPath	"/usr/X11R6/lib/X11/fonts/Speedo/"
    FontPath	"/usr/X11R6/lib/X11/fonts/75dpi/"
    FontPath	"/usr/X11R6/lib/X11/fonts/100dpi/"
EndSection

Section "Module"
    Load	"dbe"
    SubSection	"extmod"
	Option	"omit xfree86-dga"
    EndSubSection
    Load	"type1"
    Load	"freetype"
EndSection

Section "ServerFlags"
    Option	"standby time"	"20"
    Option	"suspend time"	"30"
    Option	"off time"	"60"
EndSection

Section "InputDevice"
    Identifier	"Keyboard1"
    Driver	"keyboard"
    Option	"AutoRepeat"	"500 5"
EndSection

Section "InputDevice"
    Identifier	"Mouse1"
    Driver	"mouse"
    Option	"Protocol"	"BusMouse"
    Option	"Device"	"/dev/mouse"
EndSection

Section "Monitor"
    Identifier	"Apple 1024x768 LCD"
    HorizSync 31-190
    VertRefresh 58-190
    Modeline "1024x768"    65    1024 1032 1176 1344   768  771  777  806 -hsync -vsync
EndSection

Section "Device"
    Identifier	"ATI Rage LT Pro"
    Driver	"ati"
    VideoRam	4096
    BusID	"PCI:0:17:0"
EndSection

Section "Screen"
    Identifier	"Screen 1"
    Device	"ATI Rage LT Pro"
    Monitor	"Apple 1024x768 LCD"
    DefaultDepth 15
    SubSection "Display"
        Depth		15
        Modes		"1024x768"
        ViewPort	0 0
        Virtual 	1024 768
    EndSubsection
EndSection

Section "ServerLayout"
    Identifier	"Powerbook G3"
    Screen	"Screen 1"
    InputDevice	"Mouse1" "CorePointer"
    InputDevice "Keyboard1" "CoreKeyboard"
EndSection

--xHFwDpU9dbj6ez1V--

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature
Content-Disposition: inline


--GID0FwUMdk1T2AWN--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
