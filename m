Date: Wed, 11 Oct 2000 14:17:22 -0400
From: Josh Huber <huber@mclx.com>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: dual head r128
Message-ID: <20001011141722.A1437@missioncriticallinux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--PmA2V3Z32TCmWXqI
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Anyone got dual head r128 up and running on ppc?  I've got a dual G4
system here (running a UP kernel for now), with the shipped AGP r128
card, and another PCI (pc, no fcode) r128 card.

The relevant information is attached, lspci -vv, XF86Config, and the
log of the failed X startup.  X works with just the AGP card, as
expected.

Of note is the:
c000:00b9: 63 ILLEGAL X86 OPCODE!

line in x.log, when trying to run int10 on the secondary card.

Thanks,
--=20
Josh
| huber@mclx.com |
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="XF86Config.new"

Section "ServerLayout"
	Identifier     "XFree86 Configured"
	Screen      0  "Screen0" 0 0
	Screen      1  "Screen1" RightOf "Screen0"
	InputDevice    "Mouse0" "CorePointer"
	InputDevice    "Keyboard0" "CoreKeyboard"
EndSection

Section "Files"
EndSection

Section "Module"
	Load  "extmod"
	Load  "xie"
	Load  "pex5"
	Load  "glx"
	Load  "dri"
	Load  "GLcore"
	Load  "dbe"
	Load  "record"
EndSection

Section "InputDevice"
	Identifier  "Keyboard0"
	Driver      "keyboard"
EndSection

Section "InputDevice"
	Identifier  "Mouse0"
	Driver      "mouse"
	Option      "Protocol" "IMPS/2"
	Option      "Device" "/dev/usbmouse"
EndSection

Section "Monitor"
	Identifier   "Monitor0"
	VendorName   "Monitor Vendor"
	ModelName    "Monitor Model"
EndSection

Section "Monitor"
	Identifier   "Monitor1"
	VendorName   "Monitor Vendor"
	ModelName    "Monitor Model"
EndSection

Section "Device"
	### Available Driver options are:-
        #Option     "NoAccel"
        #Option     "SWcursor"
        #Option     "HWcursor"
        #Option     "Dac6Bit"
        #Option     "Dac8Bit"
        #Option     "ForcePCIMode"
        #Option     "CCEPIOMode"
        #Option     "CCENoSecurity"
        #Option     "CCEusecTimeout"
        #Option     "AGPMode"
        #Option     "AGPSize"
        #Option     "RingSize"
        #Option     "VBListSize"
        #Option     "VBSize"
        #Option     "UseCCEfor2D"
        #Option     "EnableFP"
        #Option     "CRTOnly"
        #Option     "UseFBDev"
	Identifier  "Card0"
	Driver      "r128"
	VendorName  "ATI"
	BoardName   "Rage 128 Pro PF"
	BusID       "PCI:0:16:0"
EndSection

Section "Device"
	### Available Driver options are:-
        #Option     "NoAccel"
        #Option     "SWcursor"
        #Option     "HWcursor"
        #Option     "Dac6Bit"
        #Option     "Dac8Bit"
        #Option     "ForcePCIMode"
        #Option     "CCEPIOMode"
        #Option     "CCENoSecurity"
        #Option     "CCEusecTimeout"
        #Option     "AGPMode"
        #Option     "AGPSize"
        #Option     "RingSize"
        #Option     "VBListSize"
        #Option     "VBSize"
        #Option     "UseCCEfor2D"
        #Option     "EnableFP"
        #Option     "CRTOnly"
        #Option     "UseFBDev"
	VideoRam    8192
	Identifier  "Card1"
	Driver      "r128"
	VendorName  "ATI"
	BoardName   "Rage 128 RE"
	BusID       "PCI:1:2:0"
EndSection

Section "Screen"
	Identifier "Screen0"
	Device     "Card0"
	Monitor    "Monitor0"
	SubSection "Display"
		Depth     1
	EndSubSection
	SubSection "Display"
		Depth     4
	EndSubSection
	SubSection "Display"
		Depth     8
	EndSubSection
	SubSection "Display"
		Depth     15
	EndSubSection
	SubSection "Display"
		Depth     16
	EndSubSection
	SubSection "Display"
		Depth     24
	EndSubSection
EndSection

Section "Screen"
	Identifier "Screen1"
	Device     "Card1"
	Monitor    "Monitor1"
	SubSection "Display"
		Depth     1
	EndSubSection
	SubSection "Display"
		Depth     4
	EndSubSection
	SubSection "Display"
		Depth     8
	EndSubSection
	SubSection "Display"
		Depth     15
	EndSubSection
	SubSection "Display"
		Depth     16
	EndSubSection
	SubSection "Display"
		Depth     24
	EndSubSection
EndSection

Section "DRI"
EndSection

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci.out"

00:0b.0 Host bridge: Apple Computer Inc.: Unknown device 0020
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 set, cache line size 08
	Capabilities: [80] AGP version 1.0
		Status: RQ=7 SBA+ 64bit- FW- Rate=21
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=

00:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 00001000-00001fff
	Memory behind bridge: 80000000-87ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1- D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 00 [VGA])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 255 set, cache line size 08
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at 94000000 (32-bit, prefetchable)
	Region 1: I/O ports at 0400 [disabled]
	Region 2: Memory at 90000000 (32-bit, non-prefetchable)
	Expansion ROM at 90020000 [disabled]
	Capabilities: [50] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=421
		Command: RQ=0 SBA+ AGP- 64bit- FW- Rate=
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- AuxPwr- DSI- D1+ D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:02.0 VGA compatible controller: ATI Technologies Inc Rage 128 RE (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0008
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 8 min, 16 set, cache line size 08
	Interrupt: pin A routed to IRQ 52
	Region 0: Memory at 84000000 (32-bit, prefetchable) [disabled]
	Region 1: I/O ports at 1000 [disabled]
	Region 2: Memory at 8008c000 (32-bit, non-prefetchable) [disabled]
	Expansion ROM at 800a0000 [disabled]
	Capabilities: [5c] Power Management version 1
		Flags: PMEClk- AuxPwr- DSI- D1+ D2- PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:03.0 Ethernet controller: Alteon Networks Inc. AceNIC Gigabit Ethernet (rev 01)
	Subsystem: Alteon Networks Inc.: Unknown device 0001
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 min, 16 set, cache line size 08
	Interrupt: pin A routed to IRQ 53
	Region 0: Memory at 80088000 (32-bit, non-prefetchable) [disabled]

01:07.0 Class ff00: Apple Computer Inc.: Unknown device 0022 (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 set, cache line size 08
	Region 0: Memory at 80000000 (32-bit, non-prefetchable)

01:08.0 USB Controller: Apple Computer Inc.: Unknown device 0019 (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 3 min, 86 max, 16 set
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at 80082000 (32-bit, non-prefetchable)

01:09.0 USB Controller: Apple Computer Inc.: Unknown device 0019 (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 3 min, 86 max, 16 set
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at 80081000 (32-bit, non-prefetchable)

01:0a.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 10 [OHCI])
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 63
	Region 0: Memory at 80080000 (32-bit, non-prefetchable) [disabled]
	Region 1: Memory at 80084000 (32-bit, non-prefetchable) [disabled]
	Capabilities: [44] Power Management version 1
		Flags: PMEClk- AuxPwr+ DSI- D1- D2+ PME-
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="x.log"
Content-Transfer-Encoding: quoted-printable


XFree86 Version 4.0.1c / X Window System
(protocol Version 11, revision 0, vendor release 6400)
Release Date: 28 August 2000
	If the server is older than 6-12 months, or if your card is newer
	than the above date, look for a newer version before reporting
	problems.  (see http://www.XFree86.Org/FAQ)
Operating System: Linux 2.2.15pre13 ppc [ELF]=20
Module Loader present
(=3D=3D) Log file: "/var/log/XFree86.0.log", Time: Wed Oct 11 07:08:35 2000
(++) Using config file: "./XF86Config.new"
Markers: (--) probed, (**) from config file, (=3D=3D) default setting,
         (++) from command line, (!!) notice, (II) informational,
         (WW) warning, (EE) error, (??) unknown.
(=3D=3D) ServerLayout "XFree86 Configured"
(**) |-->Screen "Screen0" (0)
(**) |   |-->Monitor "Monitor0"
(**) |   |-->Device "Card0"
(**) |-->Screen "Screen1" (1)
(**) |   |-->Monitor "Monitor1"
(**) |   |-->Device "Card1"
(**) |-->Input Device "Mouse0"
(**) |-->Input Device "Keyboard0"
(WW) The directory "/usr/X11R6/lib/X11/fonts/CID/" does not exist.
	Entry deleted from font path.
(=3D=3D) FontPath set to "/usr/X11R6/lib/X11/fonts/misc/,/usr/X11R6/lib/X11=
/fonts/Speedo/,/usr/X11R6/lib/X11/fonts/Type1/,/usr/X11R6/lib/X11/fonts/75d=
pi/,/usr/X11R6/lib/X11/fonts/100dpi/"
(=3D=3D) RgbPath set to "/usr/X11R6/lib/X11/rgb"
(=3D=3D) ModulePath set to "/usr/X11R6/lib/modules"
(--) using VT number 7

(II) Loading /usr/X11R6/lib/modules/fonts/libbitmap.a
(II) Module bitmap: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) Loading /usr/X11R6/lib/modules/libpcidata.a
(II) Module pcidata: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 0.1.0
(II) Loading /usr/X11R6/lib/modules/libscanpci.a
(II) Module scanpci: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 0.1.0
(II) Unloading /usr/X11R6/lib/modules/libscanpci.a
(--) PCI: (0:16:0) ATI Rage 128 Pro PF rev 0, Mem @ 0x94000000/26, 0x900000=
00/14, I/O @ 0x0400/8
(--) PCI: (1:2:0) ATI Rage 128 RE rev 0, Mem @ 0x84000000/26, 0x8008c000/14=
, I/O @ 0x1000/8
(II) Loading /usr/X11R6/lib/modules/extensions/libextmod.a
(II) Module extmod: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libxie.a
(II) Module xie: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libpex5.a
(II) Module pex5: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libglx.a
(II) Module glx: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libGLcore.a
(II) Module GLcore: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libdri.a
(II) Module dri: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) Loading /usr/X11R6/lib/modules/linux/libdrm.a
(II) Module drm: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/libdbe.a
(II) Module dbe: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) Loading /usr/X11R6/lib/modules/extensions/librecord.a
(II) Module record: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.13.0
(II) Loading /usr/X11R6/lib/modules/drivers/r128_drv.o
(II) Module r128: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 3.1.1
(II) Loading /usr/X11R6/lib/modules/input/mouse_drv.o
(II) Module mouse: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) r128: Driver for ATI Rage 128 chipset: ATI Rage 128 RE (PCI),
	ATI Rage 128 RF (AGP), ATI Rage 128 RK (PCI), ATI Rage 128 RL (AGP),
	ATI Rage 128 Pro PF (AGP), ATI Rage 128 PR,
	ATI Rage 128 Mobility LE (PCI), ATI Rage 128 Mobility LF (AGP)
(--) Chipset ATI Rage 128 Pro PF (AGP) found
(--) Chipset ATI Rage 128 RE (PCI) found
(WW) ****INVALID MEM ALLOCATION**** b: 0x8008c000 e: 0x8008ffff correcting=
=07
NonSys
	[0] -1	0x80084000 - 0x80087fff (0x4000) MX[B]
	[1] -1	0x80080000 - 0x800fffff (0x80000) MX[B]
	[2] -1	0x80081000 - 0x80081fff (0x1000) MX[B]
	[3] -1	0x80082000 - 0x80083fff (0x2000) MX[B]
	[4] -1	0x80000000 - 0x8007ffff (0x80000) MX[B]
	[5] -1	0x80088000 - 0x8008ffff (0x8000) MX[B]
New PCI res 2 base: 0x80100000, size: 0x4000, type Mem
(II) Loading /usr/X11R6/lib/modules/libvgahw.a
(II) Module vgahw: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 0.1.0
(II) r128(0): PCI bus 0 card 16 func 0
(=3D=3D) r128(0): Depth 8, (=3D=3D) framebuffer bpp 8
(II) r128(0): Pixel depth =3D 8 bits stored in 1 byte (8 bpp pixmaps)
(=3D=3D) r128(0): Default visual is PseudoColor
(II) r128(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading /usr/X11R6/lib/modules/libint10.a
(II) Module int10: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) r128(0): initializing int10
(EE) r128(0): Cannot read V_BIOS (4)
(--) r128(0): Chipset: "ATI Rage 128 Pro PF (AGP)" (ChipID =3D 0x5046)
(--) r128(0): Linear framebuffer at 0x94000000
(--) r128(0): MMIO registers at 0x90000000
(--) r128(0): BIOS at 0x90020000
(--) r128(0): VideoRAM: 16384 kByte (64-bit SDR SGRAM 1:1)
(II) r128(0): PLL parameters: rf=3D2950 rd=3D35 min=3D12500 max=3D25000; xc=
lk=3D14000
(=3D=3D) r128(0): Using gamma correction (1.0, 1.0, 1.0)
(WW) r128(0): Monitor0: Using default hsync range of 28-33kHz
(WW) r128(0): Monitor0: using default vrefresh range of 43-72Hz
(II) r128(0): Clock range:  12.50 to 250.00 MHz
(WW) r128(0): Mode "640x350" deleted (hsync out of range)
(WW) r128(0): Mode "640x400" deleted (hsync out of range)
(WW) r128(0): Mode "720x400" deleted (hsync out of range)
(WW) r128(0): Mode "640x480" deleted (hsync out of range)
(WW) r128(0): Mode "640x480" deleted (hsync out of range)
(WW) r128(0): Mode "640x480" deleted (hsync out of range)
(WW) r128(0): Mode "800x600" deleted (hsync out of range)
(WW) r128(0): Mode "800x600" deleted (hsync out of range)
(WW) r128(0): Mode "800x600" deleted (hsync out of range)
(WW) r128(0): Mode "800x600" deleted (hsync out of range)
(WW) r128(0): Mode "800x600" deleted (hsync out of range)
(WW) r128(0): Mode "1024x768" deleted (hsync out of range)
(WW) r128(0): Mode "1024x768" deleted (hsync out of range)
(WW) r128(0): Mode "1024x768" deleted (hsync out of range)
(WW) r128(0): Mode "1024x768" deleted (hsync out of range)
(WW) r128(0): Mode "1024x768" deleted (hsync out of range)
(WW) r128(0): Mode "1152x864" deleted (hsync out of range)
(WW) r128(0): Mode "1280x960" deleted (hsync out of range)
(WW) r128(0): Mode "1280x960" deleted (hsync out of range)
(WW) r128(0): Mode "1280x1024" deleted (hsync out of range)
(WW) r128(0): Mode "1280x1024" deleted (hsync out of range)
(WW) r128(0): Mode "1280x1024" deleted (hsync out of range)
(WW) r128(0): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(0): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(0): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(0): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(0): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(0): Mode "1792x1344" deleted (hsync out of range)
(WW) r128(0): Mode "1792x1344" deleted (bad mode clock/interlace/doublescan)
(WW) r128(0): Mode "1856x1392" deleted (hsync out of range)
(WW) r128(0): Mode "1856x1392" deleted (bad mode clock/interlace/doublescan)
(WW) r128(0): Mode "1920x1440" deleted (hsync out of range)
(WW) r128(0): Mode "1920x1440" deleted (bad mode clock/interlace/doublescan)
(--) r128(0): Virtual size is 640x480 (pitch 640)
(**) r128(0): Default mode "640x480": 25.2 MHz, 31.5 kHz, 60.0 Hz
(=3D=3D) r128(0): DPI set to (75, 75)
(II) Loading /usr/X11R6/lib/modules/libfb.a
(II) Module fb: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(II) Loading /usr/X11R6/lib/modules/libramdac.a
(II) Module ramdac: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 0.1.0
(II) Loading /usr/X11R6/lib/modules/libxaa.a
(II) Module xaa: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(**) r128(0): CCE in BM mode
(**) r128(0): Using 8 MB AGP aperture
(**) r128(0): Using 1 MB for the ring buffer
(**) r128(0): Using 1 MB for vertex buffers
(**) r128(0): Using 1 MB for indirect buffers
(**) r128(0): Using 5 MB for AGP textures
(**) r128(0): Using 16384 byte vertex buffers
(II) r128(1): PCI bus 1 card 2 func 0
(=3D=3D) r128(1): Depth 8, (=3D=3D) framebuffer bpp 8
(II) r128(1): Pixel depth =3D 8 bits stored in 1 byte (8 bpp pixmaps)
(=3D=3D) r128(1): Default visual is PseudoColor
(II) r128(1): Using 8 bits per RGB (8 bit DAC)
(II) r128(1): initializing int10
c000:00b9: 63 ILLEGAL X86 OPCODE!
(--) r128(1): Chipset: "ATI Rage 128 RE (PCI)" (ChipID =3D 0x5245)
(--) r128(1): Linear framebuffer at 0x84000000
(--) r128(1): MMIO registers at 0x80100000
(--) r128(1): BIOS at 0x800a0000
(II) r128(1): Video RAM override, using 8192 kB instead of 0 kB
(**) r128(1): VideoRAM: 8192 kByte (128-bit SDR SGRAM 1:1)
(II) r128(1): PLL parameters: rf=3D2950 rd=3D0 min=3D12500 max=3D25000; xcl=
k=3D0
(=3D=3D) r128(1): Using gamma correction (1.0, 1.0, 1.0)
(WW) r128(1): Monitor1: Using default hsync range of 28-33kHz
(WW) r128(1): Monitor1: using default vrefresh range of 43-72Hz
(II) r128(1): Clock range:  12.50 to 250.00 MHz
(WW) r128(1): Mode "640x350" deleted (hsync out of range)
(WW) r128(1): Mode "640x400" deleted (hsync out of range)
(WW) r128(1): Mode "720x400" deleted (hsync out of range)
(WW) r128(1): Mode "640x480" deleted (hsync out of range)
(WW) r128(1): Mode "640x480" deleted (hsync out of range)
(WW) r128(1): Mode "640x480" deleted (hsync out of range)
(WW) r128(1): Mode "800x600" deleted (hsync out of range)
(WW) r128(1): Mode "800x600" deleted (hsync out of range)
(WW) r128(1): Mode "800x600" deleted (hsync out of range)
(WW) r128(1): Mode "800x600" deleted (hsync out of range)
(WW) r128(1): Mode "800x600" deleted (hsync out of range)
(WW) r128(1): Mode "1024x768" deleted (hsync out of range)
(WW) r128(1): Mode "1024x768" deleted (hsync out of range)
(WW) r128(1): Mode "1024x768" deleted (hsync out of range)
(WW) r128(1): Mode "1024x768" deleted (hsync out of range)
(WW) r128(1): Mode "1024x768" deleted (hsync out of range)
(WW) r128(1): Mode "1152x864" deleted (hsync out of range)
(WW) r128(1): Mode "1280x960" deleted (hsync out of range)
(WW) r128(1): Mode "1280x960" deleted (hsync out of range)
(WW) r128(1): Mode "1280x1024" deleted (hsync out of range)
(WW) r128(1): Mode "1280x1024" deleted (hsync out of range)
(WW) r128(1): Mode "1280x1024" deleted (hsync out of range)
(WW) r128(1): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(1): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(1): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(1): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(1): Mode "1600x1200" deleted (hsync out of range)
(WW) r128(1): Mode "1792x1344" deleted (hsync out of range)
(WW) r128(1): Mode "1792x1344" deleted (bad mode clock/interlace/doublescan)
(WW) r128(1): Mode "1856x1392" deleted (hsync out of range)
(WW) r128(1): Mode "1856x1392" deleted (bad mode clock/interlace/doublescan)
(WW) r128(1): Mode "1920x1440" deleted (hsync out of range)
(WW) r128(1): Mode "1920x1440" deleted (bad mode clock/interlace/doublescan)
(--) r128(1): Virtual size is 640x480 (pitch 640)
(**) r128(1): Default mode "640x480": 25.2 MHz, 31.5 kHz, 60.0 Hz
(=3D=3D) r128(1): DPI set to (75, 75)
(**) r128(1): CCE in PIO mode
(II) Loading /usr/X11R6/lib/modules/librac.a
(II) Module rac: vendor=3D"The XFree86 Project"
	compiled for 4.0.1c, module version =3D 1.0.0
(WW) r128(0): Cannot read colourmap from VGA.  Will restore with default
(II) r128(0): Memory manager initialized to (0,0) (640,8191)
(II) r128(0): Reserved area from (0,480) to (640,482)
(II) r128(0): Largest offscreen area available: 640 x 7709
(=3D=3D) r128(0): Backing store disabled
(II) r128(0): Using XFree86 Acceleration Architecture (XAA)
	Screen to screen bit blits
	Solid filled rectangles
	8x8 mono pattern filled rectangles
	Indirect CPU to Screen color expansion
	Solid Lines
	Dashed Lines
	Offscreen Pixmaps
	Setting up tile and stipple cache:
		32 128x128 slots
		24 256x256 slots
		9 512x512 slots
(II) r128(0): Acceleration enabled
(II) r128(0): Using hardware cursor (scanline 482)
(II) r128(0): Largest offscreen area available: 640 x 7705
(II) r128(0): Direct rendering disabled
(WW) r128(1): Cannot read colourmap from VGA.  Will restore with default
(EE) r128(1): (Ron =3D 15360) + (Rloop =3D 16) >=3D (Roff =3D 0)

Fatal server error:
AddScreen/ScreenInit failed for driver 1


When reporting a problem related to a server crash, please send
the full server output, not just the last messages.
This can be found in the log file "/var/log/XFree86.0.log".
Please report problems to debian-x@lists.debian.org.


--ZGiS0Q5IWpPtfppv--

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline


--PmA2V3Z32TCmWXqI--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
