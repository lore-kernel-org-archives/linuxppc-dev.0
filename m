Return-Path: <olaf@ibook.aepfle.de>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 125D667BC7
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Oct 2006 19:41:13 +1000 (EST)
Date: Mon, 2 Oct 2006 11:38:53 +0200
From: Olaf Hering <olaf@aepfle.de>
To: David Woodhouse <dwmw2@infradead.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Use check_legacy_ioport() for ISAPnP
Message-ID: <20061002093853.GA13880@aepfle.de>
References: <1159341535.3309.108.camel@pmac.infradead.org>
	<20060927081838.GA5984@aepfle.de>
	<1159361385.3309.118.camel@pmac.infradead.org>
	<20060927130525.GA7550@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
In-Reply-To: <20060927130525.GA7550@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Wed, Sep 27, Olaf Hering wrote:

> On Wed, Sep 27, David Woodhouse wrote:
> 
> > And did you fix the case of PCI parallel ports? We only want to do the
> > check_legacy_ioport() thing for the 'default' built-in ports, not for
> > all ports.
> 
> I have to check if my multiport IO card still works, but I'm sure it
> will.

The new check in parport_pc_init() will prevent the probing of PCI
devices. I guess the correct fix would be a sophisticated
pmac_check_legacy_ioport() that checks if baseport is available on some
PCI device:

0001:10:13.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550 UART) (rev 01) (prog-if 02 [16550])
        Subsystem: Timedia Technology Co Ltd Unknown device 5079
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 53
        Region 0: I/O ports at f2000800 [size=32]
        Region 2: I/O ports at f2000870 [size=8]
        Region 3: I/O ports at f2000860 [size=8]

PCI: Enabling device 0001:10:13.0 (0080 -> 0081)
PCI parallel port detected: 1409:7168, I/O at 0x870(0x860)
parport0: PC-style at 0x870 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (polling).


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="date-2.6.18-date-serial.txt"

Using PowerMac machine description
Total memory = 256MB; using 512kB for hash table (at cff80000)
Linux version 2.6.18-date-serial (olaf@pomegranate) (gcc version 4.1.0 (SUSE Linux)) #20 Mon Oct 2 11:30:24 CEST 2006
Found UniNorth memory controller & host bridge @ 0xf8000000 revision: 0x11
Mapped at 0xfdfc0000
Found a Keylargo mac-io controller, rev: 3, mapped at 0xfdf40000
Processor NAP mode on idle enabled.
PowerMac motherboard: PowerMac G4 Silver
Found UniNorth PCI host bridge at 0x00000000f0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0x00000000f4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver v2 initialized for Core99, firmware: 0c
nvram: Checking bank 0...
nvram: gen0=356, gen1=355
nvram: Active bank is: 0
nvram: OF partition at 0x210
nvram: XP partition at 0x1220
nvram: NR partition at 0x1320
Top of RAM: 0x10000000, Total RAM: 0x10000000
Memory hole size: 0MB
On node 0 totalpages: 65536
  DMA zone: 65536 pages, LIFO batch:15
Built 1 zonelists.  Total pages: 65536
Kernel command line: root=/dev/hda13 quiet sysrq=1 video=aty128fb:1024x768@75 debug video=aty128fb:1024x768@85 
mpic: Setting up MPIC " MPIC 1   " version 1.2 at 80040000, max 4 CPUs
mpic: ISU size: 64, shift: 6, mask: 3f
mpic: Initializing for 64 sources
PID hash table entries: 2048 (order: 11, 8192 bytes)
GMT Delta read from XPRAM: 120 minutes, DST: on
time_init: decrementer frequency = 33.290001 MHz
time_init: processor frequency   = 466.666665 MHz
Console: colour dummy device 80x25
pmac_zilog: i2c-modem detected, id: 1
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 252416k/262144k available (3844k kernel code, 9460k reserved, 368k data, 2205k bss, 156k init)
Calibrating delay loop... 66.56 BogoMIPS (lpj=332800)
Mount-cache hash table entries: 512
device-tree: Duplicate name in /cpus/PowerPC,G4@0, renamed to "l2-cache#1"
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
KeyWest i2c @0xf8001003 irq 42 /uni-n@f8000000/i2c@f8001000
 channel 0 bus <multibus>
 channel 1 bus <multibus>
KeyWest i2c @0x80018000 irq 26 /pci@f2000000/mac-io@17/i2c@18000
 channel 0 bus <multibus>
PMU i2c /pci@f2000000/mac-io@17/via-pmu@16000
 channel 1 bus <multibus>
 channel 2 bus <multibus>
PCI: Probing PCI hardware
PM: Adding info for No Bus:pci0000:00
PM: Adding info for pci:0000:00:0b.0
PM: Adding info for pci:0000:00:10.0
PM: Adding info for No Bus:pci0001:10
PM: Adding info for pci:0001:10:0b.0
PM: Adding info for pci:0001:10:12.0
PM: Adding info for pci:0001:10:12.1
PM: Adding info for pci:0001:10:12.2
PM: Adding info for pci:0001:10:12.3
PM: Adding info for pci:0001:10:13.0
PM: Adding info for pci:0001:10:14.0
PM: Adding info for pci:0001:10:17.0
PM: Adding info for pci:0001:10:18.0
PM: Adding info for pci:0001:10:19.0
PM: Adding info for No Bus:pci0002:20
PM: Adding info for pci:0002:20:0b.0
PM: Adding info for pci:0002:20:0e.0
PM: Adding info for pci:0002:20:0f.0
PM: Adding info for platform:i2c-powermac.0
PM: Adding info for platform:i2c-powermac.1
PM: Adding info for platform:i2c-powermac.2
PM: Adding info for platform:i2c-powermac.3
PM: Adding info for platform:i2c-powermac.4
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
aty128fb: Invalid ROM signature 1111 should  be 0xaa55
aty128fb: BIOS not located, guessing timings.
aty128fb: Rage128 PF PRO AGP [chip rev 0x1] 16M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 128x48
fb0: ATY Rage128 frame buffer device on Rage128 PF PRO AGP
lp: driver loaded but no devices found
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
ppdev: user-space parallel port driver
pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
ttyS0 at MMIO 0x80013020 (irq = 22) is a Z85c30 ESCC - Internal modem
ttyS1 at MMIO 0x80013000 (irq = 50) is a Z85c30 ESCC - Serial port
parport_default_proc_register(485)
parport_pc_init(3377)
IN from bad port 3f1 at c01dd058
IN from bad port 3f1 at c01dd07c
IN from bad port 3f1 at c01dd0a0
IN from bad port 3f1 at c01dd0dc
IN from bad port 3f1 at c01dd100
IN from bad port 3f1 at c01dd124
IN from bad port 371 at c01dd058
IN from bad port 371 at c01dd07c
IN from bad port 371 at c01dd0a0
IN from bad port 371 at c01dd0dc
IN from bad port 371 at c01dd100
IN from bad port 371 at c01dd124
IN from bad port 2f at c01dd058
IN from bad port 2f at c01dd07c
IN from bad port 2f at c01dd0a0
IN from bad port 2f at c01dd0dc
IN from bad port 2f at c01dd100
IN from bad port 2f at c01dd124
IN from bad port 4f at c01dd058
IN from bad port 4f at c01dd07c
IN from bad port 4f at c01dd0a0
IN from bad port 4f at c01dd0dc
IN from bad port 4f at c01dd100
IN from bad port 4f at c01dd124
IN from bad port 3f1 at c01dd058
IN from bad port 3f1 at c01dd07c
IN from bad port 3f1 at c01dd0a0
IN from bad port 3f1 at c01dd0dc
IN from bad port 3f1 at c01dd100
IN from bad port 3f1 at c01dd124
IN from bad port 252 at c01dceb8
IN from bad port 252 at c01dcee4
IN from bad port 252 at c01dcf08
IN from bad port 252 at c01dcf3c
IN from bad port 252 at c01dcf60
IN from bad port 252 at c01dcf84
IN from bad port 252 at c01dceb8
IN from bad port 252 at c01dcee4
IN from bad port 252 at c01dcf08
IN from bad port 252 at c01dcf3c
IN from bad port 252 at c01dcf60
IN from bad port 252 at c01dcf84
IN from bad port 3f1 at c01dcc28
IN from bad port 3f1 at c01dcc4c
IN from bad port 3f1 at c01dcc70
IN from bad port 3f1 at c01dcc94
IN from bad port 3f1 at c01dccd0
IN from bad port 3f1 at c01dccf4
IN from bad port 3f1 at c01dcd18
IN from bad port 3f1 at c01dcd3c
IN from bad port 371 at c01dcc28
IN from bad port 371 at c01dcc4c
IN from bad port 371 at c01dcc70
IN from bad port 371 at c01dcc94
IN from bad port 371 at c01dccd0
IN from bad port 371 at c01dccf4
IN from bad port 371 at c01dcd18
IN from bad port 371 at c01dcd3c
IN from bad port 3f1 at c01dcc28
IN from bad port 3f1 at c01dcc4c
IN from bad port 3f1 at c01dcc70
IN from bad port 3f1 at c01dcc94
IN from bad port 3f1 at c01dccd0
IN from bad port 3f1 at c01dccf4
IN from bad port 3f1 at c01dcd18
IN from bad port 3f1 at c01dcd3c
IN from bad port 371 at c01dcc28
IN from bad port 371 at c01dcc4c
IN from bad port 371 at c01dcc70
IN from bad port 371 at c01dcc94
IN from bad port 371 at c01dccd0
IN from bad port 371 at c01dccf4
IN from bad port 371 at c01dcd18
IN from bad port 371 at c01dcd3c
PCI: Enabling device 0001:10:13.0 (0080 -> 0081)
PCI parallel port detected: 1409:7168, I/O at 0x870(0x860)
parport0: PC-style at 0x870 [PCSPP,TRISTATE,EPP]
lp0: using parport0 (polling).
loop: loaded (max 8 devices)
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
PHY ID: 206053, addr: 0
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:30:65:f3:4c:ae 
eth0: Found BCM5401 PHY
MacIO PCI driver attached to Keylargo chipset
PM: Adding info for macio:0.80000000:mac-io
PM: Adding info for macio:0.00040000:interrup
PM: Adding info for macio:0.00000050:gpio
PM: Adding info for macio:0.00013000:escc
PM: Adding info for macio:0.00010000:i2s
PM: Adding info for macio:0.00015000:timer
PM: Adding info for macio:0.00016000:via-pmu
PM: Adding info for macio:0.00018000:i2c
PM: Adding info for macio:0.0001f000:ata-4
PM: Adding info for macio:0.00020000:ata-3
PM: Adding info for macio:0.00021000:ata-3
PM: Adding info for macio:0.00013020:ch-a
PM: Adding info for macio:0.00013000:ch-b
input: Macintosh mouse button emulation as /class/input/input0
apm_emu: APM Emulation 0.5 initialized.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
adb: starting probe task...
adb: finished probe task...
ide0: Found Apple KeyLargo ATA-4 controller, bus ID 2, irq 19
Probing IDE interface ide0...
hda: Maxtor 33073H3 B, ATA DISK drive
PM: Adding info for No Bus:ide0
hda: Enabling Ultra DMA 4
ide0 at 0xd101e000-0xd101e007,0xd101e160 on irq 19
PM: Adding info for ide:0.0
eth0: Link is up at 100 Mbps, full-duplex.
ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 20
Probing IDE interface ide1...
hdc: SONY CD-RW CRX140E, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
hdc: Enabling MultiWord DMA 2
ide1 at 0xd1026000-0xd1026007,0xd1026160 on irq 20
PM: Adding info for ide:1.0
PM: Adding info for ide:1.1
ide2: Found Apple KeyLargo ATA-3 controller, bus ID 1, irq 21
Probing IDE interface ide2...
hda: max request size: 128KiB
hda: 60032448 sectors (30736 MB) w/2048KiB Cache, CHS=59556/16/63, UDMA(66)
hda: cache flushes not supported
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12 hda13 hda14 hda15
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.20
mesh: configured for synchronous 5 MB/s
ieee1394: Initialized config rom entry `ip1394'
PCI: Enabling device 0001:10:12.3 (0090 -> 0093)
PM: Adding info for ieee1394:fw-host0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[52]  MMIO=[80084000-800847ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
PM: Adding info for ieee1394:fw-host1
ohci1394: fw-host1: OHCI-1394 1.0 (PCI): IRQ=[40]  MMIO=[f5000000-f50007ff]  Max Packet=[2048]  IR/IT contexts=[8/8]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
eth1394: eth1: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host1)
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0001:10:18.0 (0000 -> 0002)
ohci_hcd 0001:10:18.0: OHCI Host Controller
ohci_hcd 0001:10:18.0: new USB bus registered, assigned bus number 1
ohci_hcd 0001:10:18.0: irq 27, io mem 0x80083000
PM: Adding info for usb:usb1
PM: Adding info for No Bus:usbdev1.1_ep00
usb usb1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-0:1.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev1.1_ep81
PCI: Enabling device 0001:10:19.0 (0000 -> 0002)
ohci_hcd 0001:10:19.0: OHCI Host Controller
ohci_hcd 0001:10:19.0: new USB bus registered, assigned bus number 2
ohci_hcd 0001:10:19.0: irq 28, io mem 0x80082000
PM: Adding info for usb:usb2
PM: Adding info for No Bus:usbdev2.1_ep00
usb usb2: configuration #1 chosen from 1 choice
PM: Adding info for usb:2-0:1.0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PM: Adding info for No Bus:usbdev2.1_ep81
usb 1-1: new full speed USB device using ohci_hcd and address 2
PM: Adding info for usb:1-1
PM: Adding info for No Bus:usbdev1.2_ep00
usb 1-1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-1:1.0
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 3 ports detected
PM: Adding info for No Bus:usbdev1.2_ep81
usb 1-1.1: new low speed USB device using ohci_hcd and address 3
PM: Adding info for ieee1394:0011060000006685
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011060000006685]
PM: Adding info for ieee1394:0011060000006685-0
PM: Adding info for usb:1-1.1
PM: Adding info for No Bus:usbdev1.3_ep00
usb 1-1.1: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-1.1:1.0
PM: Adding info for No Bus:usbdev1.3_ep81
usb 1-1.2: new low speed USB device using ohci_hcd and address 4
PM: Adding info for ieee1394:003065fffef34cae
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[003065fffef34cae]
PM: Adding info for ieee1394:003065fffef34cae-0
PM: Adding info for usb:1-1.2
PM: Adding info for No Bus:usbdev1.4_ep00
usb 1-1.2: configuration #1 chosen from 1 choice
PM: Adding info for usb:1-1.2:1.0
PM: Adding info for No Bus:usbdev1.4_ep81
input: Alps Electric Apple USB Keyboard as /class/input/input1
input: USB HID v1.00 Keyboard [Alps Electric Apple USB Keyboard] on usb-0001:10:18.0-1.1
input: Logitech Apple Optical USB Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Logitech Apple Optical USB Mouse] on usb-0001:10:18.0-1.2
usbcore: registered new driver usbhid
/home/olaf/kernel/olh/mainline-porting/linux-2.6.18/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver appletouch
mice: PS/2 mouse device common for all mice
PM: Adding info for No Bus:i2c-0
PowerMac i2c bus pmu 2 registered
PM: Adding info for No Bus:i2c-1
PowerMac i2c bus pmu 1 registered
PM: Adding info for No Bus:i2c-2
PowerMac i2c bus mac-io 0 registered
PM: Adding info for No Bus:i2c-3
PowerMac i2c bus uni-n 1 registered
PM: Adding info for No Bus:i2c-4
PowerMac i2c bus uni-n 0 registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
input: PMU as /class/input/input3
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 156k init
Adding 131064k swap on /dev/hda12.  Priority:-1 extents:1 across:131064k
EXT3 FS on hda13, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
eth1: Link is up at 100 Mbps, full-duplex.
eth1: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
hub 2-0:1.0: resuming
hub 2-0:1.0: resuming
00:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 AGP
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 16, Cache Line Size 08
	Capabilities: [80] AGP version 1.0
		Status: RQ=8 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
00: 6b 10 2d 00 16 00 b0 22 00 00 00 06 08 10 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00

00:10.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), Cache Line Size 08
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at 94000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at f0000400 [size=256]
	Region 2: Memory at 90000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at f1000000 [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 02 10 46 50 87 00 b0 02 00 00 00 03 08 ff 00 00
10: 08 00 00 94 01 04 00 00 00 00 00 90 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 f1 50 00 00 00 00 00 00 00 30 01 08 00

0001:10:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 PCI
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 16, Cache Line Size 08
00: 6b 10 2e 00 16 00 a0 22 00 00 00 06 08 10 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0001:10:12.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, Cache Line Size 08
	Interrupt: pin A routed to IRQ 52
	Region 4: I/O ports at f2000840 [disabled] [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 14 00 10 02 61 00 03 0c 08 10 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 41 08 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 34 01 00 00

0001:10:12.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 61) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, Cache Line Size 08
	Interrupt: pin B routed to IRQ 52
	Region 4: I/O ports at f2000820 [disabled] [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 38 30 14 00 10 02 61 00 03 0c 08 10 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 21 08 00 00 00 00 00 00 00 00 00 00 06 11 38 30
30: 00 00 00 00 80 00 00 00 00 00 00 00 34 02 00 00

0001:10:12.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 62) (prog-if 20 [EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, Cache Line Size 08
	Interrupt: pin C routed to IRQ 52
	Region 0: Memory at 80081000 (32-bit, non-prefetchable) [disabled] [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 04 31 14 00 10 02 62 20 03 0c 08 10 80 00
10: 00 10 08 80 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 04 31
30: 00 00 00 00 80 00 00 00 00 00 00 00 34 03 00 00

0001:10:12.3 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. Unknown device e8e9
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (8000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 52
	Region 0: Memory at 80084000 (32-bit, non-prefetchable) [size=2K]
	Region 1: I/O ports at f2000000 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 06 11 44 30 97 00 10 02 46 10 00 0c 08 10 00 00
10: 00 40 08 80 01 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 06 11 e9 e8
30: 00 00 00 00 50 00 00 00 00 00 00 00 34 01 00 20

0001:10:13.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550 UART) (rev 01) (prog-if 02 [16550])
	Subsystem: Timedia Technology Co Ltd Unknown device 5079
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 53
	Region 0: I/O ports at f2000800 [size=32]
	Region 2: I/O ports at f2000870 [size=8]
	Region 3: I/O ports at f2000860 [size=8]
00: 09 14 68 71 81 00 80 02 01 02 00 07 00 00 00 00
10: 01 08 00 00 00 00 00 00 71 08 00 00 61 08 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 09 14 79 50
30: 00 00 00 00 00 00 00 00 00 00 00 00 35 01 00 00

0001:10:14.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 54
	Region 0: I/O ports at f2000400 [disabled] [size=256]
	Region 1: Memory at 80080000 (32-bit, non-prefetchable) [disabled] [size=256]
	Expansion ROM at 80090000 [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 04 00 90 02 10 00 00 02 00 10 00 00
10: 01 04 00 00 00 00 08 80 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 09 80 50 00 00 00 00 00 00 00 36 01 20 40

0001:10:17.0 Class ff00: Apple Computer Inc. KeyLargo Mac I/O (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, Cache Line Size 08
	Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=512K]
00: 6b 10 22 00 16 00 00 02 03 00 00 ff 08 10 00 00
10: 00 00 00 80 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0001:10:18.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at 80083000 (32-bit, non-prefetchable) [size=4K]
00: 6b 10 19 00 06 00 00 02 00 10 03 0c 00 10 00 00
10: 00 30 08 80 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 1b 01 03 56

0001:10:19.0 USB Controller: Apple Computer Inc. KeyLargo USB (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at 80082000 (32-bit, non-prefetchable) [size=4K]
00: 6b 10 19 00 06 00 00 02 00 10 03 0c 00 10 00 00
10: 00 20 08 80 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 1c 01 03 56

0002:20:0b.0 Host bridge: Apple Computer Inc. UniNorth 1.5 Internal PCI
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 16, Cache Line Size 08
00: 6b 10 2f 00 16 00 a0 22 00 00 00 06 08 10 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

0002:20:0e.0 FireWire (IEEE 1394): Agere Systems FW323 (prog-if 10 [OHCI])
	Subsystem: Agere Systems FW323
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (3000ns min, 6000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 40
	Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+
00: c1 11 11 58 16 00 90 02 00 10 00 0c 08 10 00 00
10: 00 00 00 f5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 c1 11 11 58
30: 00 00 00 00 44 00 00 00 00 00 00 00 28 01 0c 18

0002:20:0f.0 Ethernet controller: Apple Computer Inc. UniNorth GMAC (Sun GEM) (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 16 (16000ns min, 16000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 41
	Region 0: Memory at f5200000 (32-bit, non-prefetchable) [size=2M]
	Expansion ROM at f5100000 [disabled] [size=1M]
00: 6b 10 21 00 16 00 a0 84 01 00 00 02 08 10 00 00
10: 00 00 20 f5 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 10 f5 00 00 00 00 00 00 00 00 29 01 40 40

name             ""
linux,phandle    ff83c1c8
AAPL,add-fcode-file ff81f498
clock-frequency  07efdc44 (133160004)
#size-cells      00000001
#address-cells   00000001
system-id        "0000000000000"
device_type      "bootrom"
copyright        "Copyright 1983-2001 Apple Computer, Inc. All Rights Reserved"
scb#             00000000
color-code       ff 06                                          ..
customer-sw-config "           "
serial-number    "JQF"
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 "CK113H2Q"
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
		 ""
compatible       "PowerMac3,4"
		 "MacRISC2"
		 "MacRISC"
		 "Power Macintosh"
model            "PowerMac3,4"

/proc/device-tree/pci@f4000000:
name             "pci"
linux,phandle    ff90a950
interrupt-map-mask 0000f800 00000000 00000000 00000000
interrupt-map    00007000 00000000 00000000 00000000
		 ff90fa80 00000028 00000001 00007800
		 00000000 00000000 00000000 ff90fa80
		 00000029 00000001
interrupt-parent ff90fa80
interrupts       0000002b 00000001
bus-range        00000000 00000000
ranges           02000000 00000000 f5000000 f5000000 00000000 01000000
		 01000000 00000000 00000000 f4000000 00000000 00800000
write-combining 
built-in-names   00 00 c0 00 46 69 72 65 57 69 72 65 00 45 74 68....FireWire.Eth
		 65 72 6e 65 74 00                              ernet.
clock-frequency  03f940aa (66666666)
#interrupt-cells 00000001
#size-cells      00000002
#address-cells   00000003
reg              f4000000 02000000
compatible       "uni-north"
model            "AAPL,UniNorth"
device_type      "pci"

/proc/device-tree/pci@f4000000/ethernet@f:
name             "ethernet"
linux,phandle    ff9497b8
gbit-phy        
assigned-addresses 82007810 00000000 f5200000 00000000 00200000
		 82007830 00000000 f5100000 00000000 00100000
local-mac-address 00 30 65 f3 4c ae                              .0e.L.
stats            00000001 00000001 00000ff4 00000000 00000000
reg              00007800 00000000 00000000 00000000 00000000
		 02007810 00000000 00000000 00000000 00020000
		 02007830 00000000 00000000 00000000 00010000
max-frame-size   000005ee (1518)
address-bits     00000030 (48)
built-in        
compatible       "gmac"
category         "net"
removable        "network"
network-type     "ethernet"
device_type      "network"
fast-back-to-back
devsel-speed     00000002
max-latency      00000040 (64)
min-grant        00000040 (64)
interrupts       00000001
class-code       00020000 (131072)
revision-id      00000001
device-id        00000021 (33)
vendor-id        0000106b (4203)

/proc/device-tree/pci@f4000000/ethernet@f/ethernet-phy:
name             "ethernet-phy"
linux,phandle    ff971830
gpio-parent      ff90fcd0
gpio-value       00000001
gpio-mask        00000001
gpio-reg         00000010 (16)
interrupt-parent ff90fa80
interrupts       00000033 00000000
compatible       "B5401"
phy-id           00006053 (24659)
device_type      "ethernet-phy"

/proc/device-tree/pci@f4000000/firewire@e:
name             "firewire"
linux,phandle    ff940e40
assigned-addresses 82007010 00000000 f5000000 00000000 00001000
local-guid       003065ff fef34cae
#size-cells      00000002
#address-cells   00000004
compatible       "pci11c1,5811"
		 "pci11c1,5811"
		 "pciclass,0c0010"
reg              00007000 00000000 00000000 00000000 00000000
		 02007010 00000000 00000000 00000000 00001000
device_type      "ieee1394"
fast-back-to-back
devsel-speed     00000001
subsystem-id     00005811 (22545)
subsystem-vendor-id 000011c1 (4545)
max-latency      00000018 (24)
min-grant        0000000c (12)
interrupts       00000001
class-code       000c0010 (786448)
revision-id      00000000
device-id        00005811 (22545)
vendor-id        000011c1 (4545)

/proc/device-tree/pci@f2000000:
name             "pci"
linux,phandle    ff909798
interrupt-map-mask 0000f800 00000000 00000000 00000000
interrupt-map    00009000 00000000 00000000 00000000
		 ff90fa80 00000034 00000001 00009800
		 00000000 00000000 00000000 ff90fa80
		 00000035 00000001 0000a000 00000000
		 00000000 00000000 ff90fa80 00000036
		 00000001 0000a800 00000000 00000000
		 00000000 ff90fa80 0000003a 00000001
		 0000d000 00000000 00000000 00000000
		 ff90fa80 0000003f 00000001 0000c000
		 00000000 00000000 00000000 ff90fa80
		 0000001b 00000001 0000c800 00000000
		 00000000 00000000 ff90fa80 0000001c
		 00000001
interrupt-parent ff90fa80
interrupts       0000002c 00000001
bus-range        00000000 00000000
ranges           02000000 00000000 f3000000 f3000000 00000000 01000000
		 01000000 00000000 00000000 f2000000 00000000 00800000
		 02000000 00000000 80000000 80000000 00000000 10000000
write-combining 
slot-names       003c0000 534c4f54 2d330053 4c4f542d
		 3400534c 4f542d35 00534c4f 542d3200
built-in-names   03 80 00 00 4d 41 43 2d 49 4f 00 55 53 42 30 00....MAC-IO.USB0.
		 55 53 42 31 00                                 USB1.
clock-frequency  01fca055 (33333333)
#interrupt-cells 00000001
#size-cells      00000002
#address-cells   00000003
reg              f2000000 02000000
compatible       "uni-north"
model            "AAPL,UniNorth"
device_type      "pci"

/proc/device-tree/pci@f2000000/usb@19:
name             "usb"
linux,phandle    ff938ea8
AAPL,bus-id      00000002
AAPL,clock-data  02dc6c00 00000038 01000000 00000038 00400000 00000000
		 00000000 00000044 00000008 6e756c6c 6e756c6c 01e84800
AAPL,clock-aux-data 00000002 00000048 0f0f0000 00000001
		 00000008 00000038 10000000 00000000
AAPL,clock-id    75736231 75313438
assigned-addresses 8200c810 00000000 80082000 00000000 00001000
compatible       "pci106b,19"
		 "pciclass,0c0310"
#size-cells      00000000
#address-cells   00000001
reg              0000c800 00000000 00000000 00000000 00000000
		 0200c810 00000000 00000000 00000000 00001000
device_type      "usb"
devsel-speed     00000001
max-latency      00000056 (86)
min-grant        00000003
interrupts       00000001
class-code       000c0310 (787216)
revision-id      00000001
device-id        00000019 (25)
vendor-id        0000106b (4203)

/proc/device-tree/pci@f2000000/usb@18:
name             "usb"
linux,phandle    ff931220
AAPL,bus-id      00000001
AAPL,clock-data  02dc6c00 00000038 00100000 00000038 00040000 00000000
		 00000000 00000044 00000008 6e756c6c 6e756c6c 01e84800
AAPL,clock-aux-data 00000002 00000048 00000f0f 00000001
		 00000008 00000038 10000000 00000000
AAPL,clock-id    75736230 75303438
assigned-addresses 8200c010 00000000 80083000 00000000 00001000
compatible       "pci106b,19"
		 "pciclass,0c0310"
#size-cells      00000000
#address-cells   00000001
reg              0000c000 00000000 00000000 00000000 00000000
		 0200c010 00000000 00000000 00000000 00001000
device_type      "usb"
devsel-speed     00000001
max-latency      00000056 (86)
min-grant        00000003
interrupts       00000001
class-code       000c0310 (787216)
revision-id      00000001
device-id        00000019 (25)
vendor-id        0000106b (4203)

/proc/device-tree/pci@f2000000/usb@18/hub@1:
name             "hub"
linux,phandle    ff970090
#size-cells      00000000
#address-cells   00000001
device_type      "hub"
assigned-address 00000001
reg              00000001

/proc/device-tree/pci@f2000000/usb@18/hub@1/mouse@2:
name             "mouse"
linux,phandle    ff970650
endpoints        00040381 (263041)
#buttons         00000001
device_type      "mouse"
assigned-address 00000003
reg              00000002

/proc/device-tree/pci@f2000000/usb@18/hub@1/keyboard@1:
name             "keyboard"
linux,phandle    ff970298
endpoints        00080381 (525185)
device_type      "keyboard"
assigned-address 00000002
reg              00000001

/proc/device-tree/pci@f2000000/pci10ec,8139@14:
name             "pci10ec,8139"
linux,phandle    ff930ec8
assigned-addresses 8100a010 00000000 00000400 00000000 00000100
		 8200a030 00000000 80090000 00000000 00010000
		 8200a014 00000000 80080000 00000000 00000100
reg              0000a000 00000000 00000000 00000000 00000000
		 0100a010 00000000 00000000 00000000 00000100
		 0200a014 00000000 00000000 00000000 00000100
		 0200a030 00000000 00000000 00000000 00010000
compatible       "pci10ec,8139"
		 "pci10ec,8139"
		 "pciclass,020000"
fast-back-to-back
devsel-speed     00000001
subsystem-id     00008139 (33081)
subsystem-vendor-id 000010ec (4332)
max-latency      00000040 (64)
min-grant        00000020 (32)
interrupts       00000001
class-code       00020000 (131072)
revision-id      00000010 (16)
device-id        00008139 (33081)
vendor-id        000010ec (4332)

/proc/device-tree/pci@f2000000/pci1409,5079@13:
name             "pci1409,5079"
linux,phandle    ff930b70
assigned-addresses 81009818 00000000 00000870 00000000 00000010
		 8100981c 00000000 00000860 00000000 00000010
		 81009810 00000000 00000800 00000000 00000020
reg              00009800 00000000 00000000 00000000 00000000
		 01009810 00000000 00000000 00000000 00000020
		 01009818 00000000 00000000 00000000 00000010
		 0100981c 00000000 00000000 00000000 00000010
compatible       "pci1409,5079"
		 "pci1409,7168"
		 "pciclass,070002"
fast-back-to-back
devsel-speed     00000001
subsystem-id     00005079 (20601)
subsystem-vendor-id 00001409 (5129)
max-latency      00000000
min-grant        00000000
interrupts       00000001
class-code       00070002 (458754)
revision-id      00000001
device-id        00007168 (29032)
vendor-id        00001409 (5129)

/proc/device-tree/pci@f2000000/firewire@12,3:
name             "firewire"
linux,phandle    ff928220
assigned-addresses 82009310 00000000 80084000 00000000 00001000
local-guid       00110600 00006685
#size-cells      00000002
#address-cells   00000004
compatible       "pci1106,e8e9"
		 "pci1106,3044"
		 "pciclass,0c0010"
reg              00009300 00000000 00000000 00000000 00000000
		 02009310 00000000 00000000 00000000 00001000
device_type      "ieee1394"
devsel-speed     00000001
subsystem-id     0000e8e9 (59625)
subsystem-vendor-id 00001106 (4358)
max-latency      00000020 (32)
min-grant        00000000
interrupts       00000001
class-code       000c0010 (786448)
revision-id      00000046 (70)
device-id        00003044 (12356)
vendor-id        00001106 (4358)

/proc/device-tree/pci@f2000000/pci1106,3104@12,2:
name             "pci1106,3104"
linux,phandle    ff927f18
assigned-addresses 82009210 00000000 80081000 00000000 00000100
reg              00009200 00000000 00000000 00000000 00000000
		 02009210 00000000 00000000 00000000 00000100
compatible       "pci1106,3104"
		 "pci1106,3104"
		 "pciclass,0c0320"
devsel-speed     00000001
subsystem-id     00003104 (12548)
subsystem-vendor-id 00001106 (4358)
max-latency      00000000
min-grant        00000000
interrupts       00000003
class-code       000c0320 (787232)
revision-id      00000062 (98)
device-id        00003104 (12548)
vendor-id        00001106 (4358)

/proc/device-tree/pci@f2000000/pci1106,3038@12,1:
name             "pci1106,3038"
linux,phandle    ff927c10
assigned-addresses 81009120 00000000 00000820 00000000 00000020
reg              00009100 00000000 00000000 00000000 00000000
		 01009120 00000000 00000000 00000000 00000020
compatible       "pci1106,3038"
		 "pci1106,3038"
		 "pciclass,0c0300"
devsel-speed     00000001
subsystem-id     00003038 (12344)
subsystem-vendor-id 00001106 (4358)
max-latency      00000000
min-grant        00000000
interrupts       00000002
class-code       000c0300 (787200)
revision-id      00000061 (97)
device-id        00003038 (12344)
vendor-id        00001106 (4358)

/proc/device-tree/pci@f2000000/pci1106,3038@12:
name             "pci1106,3038"
linux,phandle    ff927908
assigned-addresses 81009020 00000000 00000840 00000000 00000020
reg              00009000 00000000 00000000 00000000 00000000
		 01009020 00000000 00000000 00000000 00000020
compatible       "pci1106,3038"
		 "pci1106,3038"
		 "pciclass,0c0300"
devsel-speed     00000001
subsystem-id     00003038 (12344)
subsystem-vendor-id 00001106 (4358)
max-latency      00000000
min-grant        00000000
interrupts       00000001
class-code       000c0300 (787200)
revision-id      00000061 (97)
device-id        00003038 (12344)
vendor-id        00001106 (4358)

/proc/device-tree/pci@f2000000/mac-io@17:
linux,device     c08f1008
name             "mac-io"
linux,phandle    ff90bac8
ranges           00000000 8200b810 00000000 80000000 00080000
#interrupt-cells 00000002
#size-cells      00000001
#address-cells   00000001
assigned-addresses 8200b810 00000000 80000000 00000000 00080000
devsel-speed     00000001
max-latency      00000000
min-grant        00000000
class-code       00ff0000 (16711680)
revision-id      00000003
device-id        00000022 (34)
vendor-id        0000106b (4203)
reg              0000b800 00000000 00000000 00000000 00000000
		 0200b810 00000000 00000000 00000000 00080000
compatible       "Keylargo"
model            "AAPL,Keylargo"
device_type      "mac-io"

/proc/device-tree/pci@f2000000/mac-io@17/ata-3@21000:
linux,device     cfeb4808
name             "ata-3"
linux,phandle    ff91e5d0
interrupt-parent ff90fa80
interrupts       00000015 00000001 0000000d 00000000
built-in        
model            "ata-3"
AAPL,pio-timing  00000526 00000085 00000025 00000025
		 00000025 00000000 00000000 00000000
#size-cells      00000000
#address-cells   00000001
reg              00021000 00001000 00008c00 00000100
AAPL,bus-id      00000001
compatible       "keylargo-ata"
AAPL,connector   "ata"
device_type      "ata"

/proc/device-tree/pci@f2000000/mac-io@17/ata-3@21000/disk:
name             "disk"
linux,phandle    ff920cc0
device_type      "block"

/proc/device-tree/pci@f2000000/mac-io@17/ata-3@20000:
linux,device     cfeb4c08
name             "ata-3"
linux,phandle    ff91b780
AAPL,clock-aux-data 00000010 0000003c 00800000 00000000
		 00000010 00000040 00000002 00000000
AAPL,clock-data  03ef1480 00000000 00000000 00000000 00000000 00000044
		 00000100 00000044 00000080 6e756c6c 6e756c6c 00000000
AAPL,clock-id    61746161 61613636
interrupt-parent ff90fa80
interrupts       00000014 00000001 0000000c 00000000
built-in        
model            "ata-3"
AAPL,pio-timing  00000526 00000085 00000025 00000025
		 00000025 00000000 00000000 00000000
#size-cells      00000000
#address-cells   00000001
reg              00020000 00001000 00008b00 00000100
AAPL,bus-id      00000000
compatible       "keylargo-ata"
AAPL,connector   "ata"
device_type      "ata"

/proc/device-tree/pci@f2000000/mac-io@17/ata-3@20000/disk:
name             "disk"
linux,phandle    ff91de70
device_type      "block"

/proc/device-tree/pci@f2000000/mac-io@17/ata-4@1f000:
linux,device     cfebc008
name             "ata-4"
linux,phandle    ff918930
AAPL,clock-aux-data 00000010 0000003c 20000000 00000000
AAPL,clock-data  03ef1480 00000000 00000000 00000000 00000000 00000044
		 00000100 00000044 00000080 6e756c6c 6e756c6c 00000000
AAPL,clock-id    75617461 61743636
cable-type       "80-conductor"
interrupt-parent ff90fa80
interrupts       00000013 00000001 0000000b 00000000
model            "ata-4"
AAPL,pio-timing  00000526 00000085 00000025 00000025
		 00000025 00000000 00000000 00000000
#size-cells      00000000
#address-cells   00000001
reg              0001f000 00001000 00008a00 00000100
AAPL,bus-id      00000002
compatible       "keylargo-ata"
AAPL,connector   "ata"
device_type      "ata"

/proc/device-tree/pci@f2000000/mac-io@17/ata-4@1f000/disk:
name             "disk"
linux,phandle    ff91b020
category         "hd"
device_type      "block"

/proc/device-tree/pci@f2000000/mac-io@17/i2c@18000:
linux,device     cfebc408
name             "i2c"
linux,phandle    ff9177b8
AAPL,driver-name ".i2c-mac-io"
AAPL,i2c-rate    00000064 (100)
AAPL,address-step 00000010 (16)
AAPL,address     80018000
interrupt-parent ff90fa80
interrupts       0000001a 00000001
reg              00018000 00001000
built-in        
compatible       "keywest-i2c"
device_type      "i2c"

/proc/device-tree/pci@f2000000/mac-io@17/i2c@18000/i2c-modem:
name             "i2c-modem"
linux,phandle    ff9713b0
slot-names       00 00 00 01 4d 6f 64 65 6d 00                  ....Modem.
compatible       "spring"
modem-id         01010201 342e3046 31372e30 46310301 03000000 00000000
device_type      "i2c-modem"

/proc/device-tree/pci@f2000000/mac-io@17/i2c@18000/deq:
name             "deq"
linux,phandle    ff9187f0
i2c-address      00000068 (104)
device_type      "deq"

/proc/device-tree/pci@f2000000/mac-io@17/i2c@18000/cereal:
name             "cereal"
linux,phandle    ff9180c0
device_type      "serial"

/proc/device-tree/pci@f2000000/mac-io@17/via-pmu@16000:
linux,device     cfebc808
name             "via-pmu"
linux,phandle    ff913788
AAPL,clock-data  01de2000 00000044 00008000 00000000 00000000 00000044
		 00008000 00000044 00000010 6e756c6c 6e756c6c 012ad400
AAPL,clock-id    73706920 73703331
pmu-version      00d04a0c (13650444)
interrupt-parent ff90fa80
interrupts       00000019 00000001
reg              00016000 00002000
compatible       "pmu"
device_type      "via-pmu"

/proc/device-tree/pci@f2000000/mac-io@17/via-pmu@16000/power-mgt:
name             "power-mgt"
linux,phandle    ff9174d0
prim-info        00 00 00 ff 00 00 00 2c 00 03 0d 40 00 01 e7 05.......,...@....
		 00 00 34 00 00 00 00 00 00 00 26 0d 46 00 02 78..4.......&.F..x
		 78 3c 00                                       x<.
registry-name    "extint-gpio1"
max-aux-power    000000da (218)
compatible       "via-pmu-99"
device_type      "power-mgt"

/proc/device-tree/pci@f2000000/mac-io@17/via-pmu@16000/power-mgt/usb-power-mgt:
name             "usb-power-mgt"
linux,phandle    ff971630
interrupt-parent ff90fa80
interrupts       0000001d 00000001
compatible       "usb-power-mgt"
device_type      "usb-power-mgt"

/proc/device-tree/pci@f2000000/mac-io@17/via-pmu@16000/rtc:
name             "rtc"
linux,phandle    ff916d60
compatible       "rtc,via-pmu"
device_type      "rtc"

/proc/device-tree/pci@f2000000/mac-io@17/timer@15000:
linux,device     cfebcc08
name             "timer"
linux,phandle    ff913578
clock-frequency  01194000 (18432000)
interrupt-parent ff90fa80
interrupts       00000020 00000001
compatible       "keylargo-timer"
reg              00015000 00001000
built-in        
device_type      "timer"

/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000:
linux,device     cfec3008
name             "i2s"
linux,phandle    ff912920
ranges          
#address-cells   00000001
reg              00010000 00001000 00008000 00000100 00008100
		 00000100 00008200 00000100 00008300 00000100
built-in        
device_type      "i2s"

/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000:
name             "i2s-a"
linux,phandle    ff912b50
AAPL,clock-data  02b11000 0000003c 00003400 00000044 00004000 00000044
		 00000400 00000044 00000004 69303439 6e756c6c 00000000
		 02ee0000 0000003c 00003400 00000044 00004000 00000044
		 00000200 00000044 00000002 69303435 6e756c6c 00000000
		 01194000 0000003c 00003000 0000003c 00000400 00000044
		 00004000 00000000 00000000 6e756c6c 6e756c6c 00000000
AAPL,clock-id    69327330 69303435 69303439 69303138
AAPL,requested-priorities 00000002 00000004 00000004
interrupt-parent ff90fa80
interrupts       0000001e 00000001 00000001 00000000 00000002 00000000
reg              00010000 00001000 00008000 00000100 00008100 00000100
built-in        
compatible       "i2sbus"
device_type      "soundbus"

/proc/device-tree/pci@f2000000/mac-io@17/i2s@10000/i2s-a@10000/sound:
name             "sound"
linux,phandle    ff912e80
sound-objects    "feature index 0 model Proj14PowerControl"
		 "feature index 1 model USBSubwoofer"
		 "feature index 2 model Equalizer"
		 "detect index 0 bit-mask 2 bit-match 0 device 2 registry-name extint-gpio15 model GPIOGenericDetect"
		 "detect index 1 bit-mask 2 bit-match 0 device 4 registry-name extint-gpio16 model GPIOGenericDetect"
		 "output index 0 device-mask 6 device-match 0 icon-id -16563 name-id -20525 port-connection 2 port-type 0x6973706B model OutputEQPort"
		 "output index 1 device-mask 6 device-match 4 icon-id -16563 name-id -20523 port-connection 3 port-type 0x6573706B model OutputDallasEQPort"
		 "output index 2 device-mask 2 device-match 2 icon-id -16563 name-id -20524 port-connection 1 port-type 0x6864706E model OutputEQPort"
		 ""
sub-frame        00000000
mclk-sample-rate-ratio 00000100 (256)
i2s-serial-format 00000002
sample-rates     00000002 ac440000 bb800000
object-model-version 00000001
name-id          ffffbf4d (-16563)
model            "355S0056"
info-id          ffffbf44 (-16572)
icon-id          ffffbf4d (-16563)
hardware-types   00000002
equalizer-id     33353553 30303537
device-id        0000000e (14)
default-monitor  "none"
#-outputs        00000003
#-features       00000003
#-inputs         00000000
#-detects        00000002
vendor-id        0000106b (4203)
compatible       "tumbler"
device_type      "soundchip"

/proc/device-tree/pci@f2000000/mac-io@17/escc@13000:
linux,device     cfec3408
name             "escc"
linux,phandle    ff9112d8
ranges          
#address-cells   00000001
reg              00013000 00001000 00008400 00000100 00008500
		 00000100 00008600 00000100 00008700 00000100
built-in        
compatible       "chrp,es0"
device_type      "escc"

/proc/device-tree/pci@f2000000/mac-io@17/escc@13000/ch-b@13000:
linux,device     cfeb4008
name             "ch-b"
linux,phandle    ff911f88
slot-names       00000000
interrupt-parent ff90fa80
interrupts       00000032 00000001 00000007 00000000 00000008 00000000
reg              00013000 00000001 00013010 00000001 00013040
		 00000001 00008600 00000100 00008700 00000100
built-in        
compatible       "chrp,es3"
device_type      "serial"

/proc/device-tree/pci@f2000000/mac-io@17/escc@13000/ch-a@13020:
linux,device     cfeb4408
name             "ch-a"
linux,phandle    ff911560
slot-names       00 00 00 01 4d 6f 64 65 6d 00                  ....Modem.
modem-id         01010201 342e3046 31372e30 46310301 03000000 00000000
AAPL,clock-data  01de2000 00000038 00000054 00000000 00000000 00000044
		 00000800 00000044 00000010 73613435 73623331 012ad400
		 02b11000 00000038 00000050 00000038 00000004 00000044
		 00000400 00000044 00000004 73613331 73623435 00000000
AAPL,clock-id    73636361 73613331 73613435
interrupt-parent ff90fa80
interrupts       00000016 00000001 00000005 00000000 00000006 00000000
reg              00013020 00000001 00013030 00000001 00013050
		 00000001 00008400 00000100 00008500 00000100
built-in        
compatible       "chrp,es2"
		 "cobalt"
device_type      "serial"

/proc/device-tree/pci@f2000000/mac-io@17/escc-legacy@12000:
name             "escc-legacy"
linux,phandle    ff910c68
ranges          
#address-cells   00000001
reg              00012000 00001000 00008400 00000100 00008500
		 00000100 00008600 00000100 00008700 00000100
built-in        
compatible       "chrp,es1"
device_type      "escc-legacy"

/proc/device-tree/pci@f2000000/mac-io@17/escc-legacy@12000/ch-b@12000:
name             "ch-b"
linux,phandle    ff9110d8
interrupt-parent ff90fa80
interrupts       00000032 00000001 00000007 00000000 00000008 00000000
reg              00012000 00000001 00012002 00000001 00012008
		 00000001 00008600 00000100 00008700 00000100
built-in        
compatible       "chrp,es5"
device_type      "serial"

/proc/device-tree/pci@f2000000/mac-io@17/escc-legacy@12000/ch-a@12004:
name             "ch-a"
linux,phandle    ff910ed8
interrupt-parent ff90fa80
interrupts       00000016 00000001 00000005 00000000 00000006 00000000
reg              00012004 00000001 00012006 00000001 0001200a
		 00000001 00008400 00000100 00008500 00000100
built-in        
compatible       "chrp,es4"
device_type      "serial"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50:
linux,device     cfec3808
name             "gpio"
linux,phandle    ff90fcd0
reg              00000050 00000030
built-in        
device_type      "gpio"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/extint-gpio16:
name             "extint-gpio16"
linux,phandle    ff910a00
interrupt-parent ff90fa80
interrupts       0000003e 00000000
AAPL,address     80000068
built-in        
one-wire-bus     "speaker-id"
AAPL,driver-name ".DallasDriver"
compatible       "keywest-gpio16"
device_type      "extint-gpio16"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/extint-gpio15:
name             "extint-gpio15"
linux,phandle    ff9107f8
interrupt-parent ff90fa80
interrupts       0000003d 00000000
AAPL,address     80000067
built-in        
compatible       "keywest-gpio15"
device_type      "extint-gpio15"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/gpio11:
name             "gpio11"
linux,phandle    ff9105f8
AAPL,address     80000075
built-in        
audio-gpio-active-state 00000000
audio-gpio       "audio-hw-reset"
compatible       "keywest-11"
device_type      "gpio11"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/gpio6:
name             "gpio6"
linux,phandle    ff910400
AAPL,address     80000070
built-in        
audio-gpio-active-state 00000000
audio-gpio       "amp-mute"
compatible       "keywest-6"
device_type      "gpio6"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/gpio5:
name             "gpio5"
linux,phandle    ff910208
AAPL,address     8000006f
built-in        
audio-gpio-active-state 00000000
audio-gpio       "headphone-mute"
compatible       "keywest-5"
device_type      "gpio5"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/programmer-switch:
name             "programmer-switch"
linux,phandle    ff910058
interrupt-parent ff90fa80
interrupts       00000037 00000000
built-in        
device_type      "programmer-switch"

/proc/device-tree/pci@f2000000/mac-io@17/gpio@50/extint-gpio1:
name             "extint-gpio1"
linux,phandle    ff90fe38
AAPL,interrupt-priorities 00000001
interrupt-parent ff90fa80
interrupts       0000002f 00000001
built-in        
compatible       "keywest-gpio1"
device_type      "extint-gpio1"

/proc/device-tree/pci@f2000000/mac-io@17/interrupt-controller@40000:
linux,device     cfec3c08
name             "interrupt-controller"
linux,phandle    ff90fa80
clock-frequency  003f940a (4166666)
interrupt-controller
#address-cells   00000000
#interrupt-cells 00000002
reg              00040000 00040000
built-in        
compatible       "chrp,open-pic"
device_type      "open-pic"

/proc/device-tree/pci@f0000000:
name             "pci"
linux,phandle    ff9085f0
interrupt-map-mask 0000f800 00000000 00000000 00000000
interrupt-map    00008000 00000000 00000000 00000000
		 ff90fa80 00000030 00000001
interrupt-parent ff90fa80
interrupts       0000002d 00000001
bus-range        00000000 00000000
ranges           02000000 00000000 f1000000 f1000000 00000000 01000000
		 01000000 00000000 00000000 f0000000 00000000 00800000
		 02000000 00000000 90000000 90000000 00000000 10000000
write-combining 
slot-names       00 03 00 00 53 4c 4f 54 2d 31 00 53 4c 4f 54 2d....SLOT-1.SLOT-
		 31 41 00                                       1A.
built-in-names   00 00 08 00 55 4e 49 2d 4e 00                  ....UNI-N.
clock-frequency  03f940aa (66666666)
#interrupt-cells 00000001
#size-cells      00000002
#address-cells   00000003
reg              f0000000 02000000
compatible       "uni-north"
model            "AAPL,UniNorth"
device_type      "pci"

/proc/device-tree/pci@f0000000/ATY,Rage128Pd@10:
name             "ATY,Rage128Pd"
linux,phandle    ff94e4f0
linux,opened    
linux,boot-display
iso6429-1983-colors
AAPL,gray-page   00000001
address          96008000
ATYN             002a0717 00820b4c 00000000 00000000
		 00000000 00000000 00000000 00000000
AGP_Master      
assigned-addresses c2008010 00000000 94000000 00000000 04000000
		 82008030 00000000 90020000 00000000 00020000
		 82008018 00000000 90000000 00000000 00004000
driver,AAPL,MacOS,PowerPC 4a6f7921 70656666 70777063 00000001
		 b6246498 00000000 00000000 00000000
		 00030002 00000000 ffffffff 00000000
		 00013b1c 00013b1c 00013b1c 00000710
		 00040400 ffffffff 00000000 00004c4c
		 000043a4 00003349 00014230 02010400
		 ffffffff 00000000 00000000 00000000
		 0000068c 00000080 04040400 00000000
		 ffffffff 00000000 ffffffff 00000000
		 ffffffff 00000000 00000005 0000002e
		 00000001 00000174 000001f0 00000628
		 00000002 00000006 00000000 00000000
		 00000000 00000015 00000000 00000000
		 00000012 00000000 00000000 00000001
		 00000015 00000000 0000001f 00000000
		 00000000 0000000e 00000016 00000000
		 0000002f 00000000 00000000 00000005
		 00000024 00000000 00000036 00000000
		 00000001 00000005 00000029 40000000
		 02000047 0200005a 0200006d 02000076
		 0200008b 0200009c 020000aa 020000c4
		 020000dc 020000e4 020000f8 020000ff
		 02000107 0200011a 02000130 02000146
		 0200014e 0200015d 02000173 0200017d
		 02000193 020001a6 020001b8 020001cf
		 020001e7 020001fe 02000215 0200022d
		 02000241 02000255 02000269 0200027d
		 02000295 020002b4 020002cb 020002e9
		 02000301 02000316 02000326 02000336
		 0200034c 82000361 82000378 82000393
		 820003ae 820003c4 00010000 0000003d
		 00000000 4a2d42bd 03c480c7 465380ff
		 400aa000 1bac4200 855f420d 16d5807b
		 4020868b 42030783 00c20102 01020103
		 00c20102 01020102 01020102 01020102
		 01020102 01020102 01020102 01020102
		 01020102 01020102 01020102 01020102
		 01020102 01020102 01020102 01020102
		 0102866f 420489db 42bd0343 11950000
		 44726976 65725365 72766963 65734c69
		 6200496e 74657266 6163654c 6962004e
		 616d6552 65676973 7472794c 69620050
		 43494c69 62005669 64656f53 65727669
		 6365734c 69620047 65745061 6765496e
		 666f726d 6174696f 6e004475 72617469
		 6f6e546f 4162736f 6c757465 00435374
		 72436f70 7900506f 6f6c416c 6c6f6361
		 74655265 73696465 6e740044 656c6179
		 466f7248 61726477 61726500 53796e63
		 68726f6e 697a6549 4f00496e 7374616c
		 6c496e74 65727275 70744675 6e637469
		 6f6e7300 4162736f 6c757465 44656c74
		 61546f44 75726174 696f6e00 43537472
		 43617400 494f436f 6d6d616e 64497343
		 6f6d706c 65746500 55705469 6d650043
		 5374724c 656e0044 656c6574 65496e74
		 65727275 70745365 74004164 64447572
		 6174696f 6e546f41 62736f6c 75746500
		 53657450 726f6365 73736f72 43616368
		 654d6f64 65004353 7472436d 7000506f
		 6f6c4465 616c6c6f 63617465 00447572
		 6174696f 6e546f4e 616e6f73 65636f6e
		 64730042 6c6f636b 436f7079 00476574
		 496e7465 72727570 7446756e 6374696f
		 6e730043 72656174 65496e74 65727275
		 70745365 74004361 6c6c556e 69766572
		 73616c50 726f6300 52656769 73747279
		 50726f70 65727479 43726561 74650052
		 65676973 74727943 53747245 6e747279
		 43726561 74650052 65676973 74727950
		 726f7065 72747953 65744d6f 64005265
		 67697374 72795072 6f706572 74794765
		 744d6f64 00526567 69737472 79435374
		 72456e74 72794c6f 6f6b7570 00526567
		 69737472 79456e74 72794465 6c657465
		 00526567 69737472 79456e74 72794944
		 496e6974 00526567 69737472 7950726f
		 70657274 79536574 00526567 69737472
		 7950726f 70657274 79476574 00526567
		 69737472 7950726f 70657274 79497465
		 72617465 00526567 69737472 7950726f
		 70657274 79497465 72617465 44697370
		 6f736500 52656769 73747279 50726f70
		 65727479 44656c65 74650052 65676973
		 74727950 726f7065 72747949 74657261
		 74654372 65617465 00526567 69737472
		 7950726f 70657274 79476574 53697a65
		 00457870 4d677243 6f6e6669 67526561
		 64427974 6500456e 6469616e 53776170
		 33324269 7400456e 6469616e 53776170
		 31364269 74004578 704d6772 436f6e66
		 69675772 6974654c 6f6e6700 4578704d
		 6772436f 6e666967 52656164 4c6f6e67
		 0056534c 4e657749 6e746572 72757074
		 53657276 69636500 56534c44 6973706f
		 7365496e 74657272 75707453 65727669
		 63650056 534c5365 74446973 706c6179
		 436f6e66 69677572 6174696f 6e005653
		 4c446f49 6e746572 72757074 53657276
		 69636500 56534c50 72657061 72654375
		 72736f72 466f7248 61726477 61726543
		 7572736f 72006465 62756753 65746465
		 62756747 65745468 65447269 76657244
		 65736372 69707469 6f6e446f 44726976
		 6572494f 54686544 72697665 72506f77
		 65724361 70616269 6c697469 65736465
		 62756749 4f000000 000c0000 00000003
		 00080003 00040005 0008229a 000822ca
		 0014bde0 000ad1fd 001accfd 00071169
		 010003e6 00004c44 00010100 03ee0000
		 4c400001 010003f6 00000764 00010200
		 040a0000 04c40001 01000414 000007e4
		 00010100 042e0000 4c3c0001 00000000
		 7c0802a6 bf61ffec 90010008 9421ffb0
		 7c7b1b78 7c9c2378 7cbd2b78 7cde3378
		 387b0038 7f84e378 7fa5eb78 7fc6f378
		 48012989 80410014 7c7f0734 7fe00734
		 2c000000 4182001c 387b0038 7f84e378
		 7fa5eb78 7fc6f378 48012979 80410014
		 7fe3fb78 80010058 38210050 7c0803a6
		 bb61ffec 4e800020 7c0802a6 93e1fffc
		 90010008 9421ffb0 90610068 9081006c
		 90a10070 90c10074 80010074 90010038
		 80610068 38630038 8081006c 80a10070
		 38c10038 480128bd 80410014 7c7f0734
		 7fe3fb78 80010058 38210050 7c0803a6
		 83e1fffc 4e800020 7c0802a6 bf61ffec
		 90010008 9421ffb0 7c7b1b78 7c9c2378
		 7cbd2b78 7cde3378 7f63db78 7f84e378
		 7fa5eb78 7fc6f378 480128b1 80410014
		 7c7f0734 7fe00734 2c000000 4182001c
		 7f63db78 7f84e378 7fa5eb78 7fc6f378
		 480128a1 80410014 7fe3fb78 80010058
		 38210050 7c0803a6 bb61ffec 4e800020
		 7c0802a6 93e1fffc 90010008 9421ffb0
		 90610068 9081006c 90a10070 90c10074
		 80010074 90010038 80610068 8081006c
		 80a10070 38c10038 480127e9 80410014
		 7c7f0734 7fe3fb78 80010058 38210050
		 7c0803a6 83e1fffc 4e800020 7c0802a6
		 bf41ffe8 90010008 9421feb0 7c7a1b78
		 7c9b2378 98a10173 90c10174 38000000
		 901b0000 3ba00000 380000c8 90010038
		 7f43d378 388207f4 38a10064 38c10038
		 48012781 80410014 7c7f1b78 80610038
		 38000014 7c030396 2800000a 4081000c
		 3860ffed 480000fc 2c1f0000 408200ec
		 80010038 28000000 418200e0 80610038
		 38000014 7f830396 38000028 90010038
		 7f43d378 38820807 38a1003c 38c10038
		 48012721 80410014 7c7f1b78 2c1f0000
		 408200a0 80010038 28000000 41820094
		 3bc00000 48000060 88010173 5405063e
		 57c0043e 1c800014 38610064 38040003
		 7c0300ae 7c050040 40820038 57c0043e
		 1c800014 38610064 38040010 7c03002e
		 80610174 90030000 57c0043e 5400103a
		 3861003c 7c03002e 901b0000 3ba00001
		 3bde0001 57c0043e 7c00e040 40800010
		 57a0063e 28000000 4182ff90 57a0063e
		 28000000 40820018 3be0ffed 48000010
		 3be0ffed 48000008 3be0ffed 7fe3fb78
		 80010158 38210150 7c0803a6 bb41ffe8
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421ffb0 7c7e1b78 3be0ffed 7fc3f378
		 3881003c 38a00010 38c10038 4bfffe61
		 7c7f0734 7fe00734 2c000000 4182001c
		 7fc3f378 38800010 38a1003c 4801261d
		 80410014 7c7f1b78 8061003c 80010058
		 38210050 7c0803a6 bbc1fff8 4e800020
		 7c0802a6 bfc1fff8 90010008 9421ffb0
		 7c7e1b78 3be0ffed 7fc3f378 3881003c
		 38a00018 38c10038 4bfffdf5 7c7f0734
		 7fe00734 2c000000 41820028 7fc3f378
		 38800018 38a1003c 480125b1 80410014
		 7c7f1b78 8001003c 54000022 9001003c
		 8061003c 80010058 38210050 7c0803a6
		 bbc1fff8 4e800020 7c0802a6 93e1fffc
		 90010008 9421ffc0 7c7f1b78 807f00e0
		 38030001 901f00e0 801f00d4 28000000
		 41820010 807f00d4 48012701 80410014
		 80010048 38210040 7c0803a6 83e1fffc
		 4e800020 7c0802a6 90010008 9421ffc0
		 386243a4 80630000 4bffffa1 38600000
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 bfc1fff8 90010008 9421ffb0
		 7c7f1b78 38000004 90010038 387f0038
		 38820814 38bf00dc 38c10038 480124c5
		 80410014 7c7e0734 38000018 90010038
		 387f0038 3882081f 38bf00ac 38c10038
		 480124a1 80410014 7c7e0734 7fc3f378
		 80010058 38210050 7c0803a6 bbc1fff8
		 4e800020 7c0802a6 bfa1fff4 90010008
		 9421ffb0 7c7f1b78 7c9d2378 3c600072
		 386370e0 907f00e8 3c600072 386370e0
		 907f00ec 38000010 9001003c 7fa3eb78
		 3882082a 38bf00e8 38c1003c 48012435
		 80410014 7c7e0734 38000004 9001003c
		 7fa3eb78 3882083c 38a10038 38c1003c
		 48012411 80410014 7c7e0734 7fc00734
		 2c000000 40820068 80010038 540007fe
		 28000000 4182001c 80010038 54000738
		 28000000 4182000c 38000001 981f0154
		 80010038 54000420 28000000 4182000c
		 38000001 981f0160 80010038 540005ee
		 28000000 4182000c 38000001 981f05c9
		 80010038 540006f6 981f0153 7fc3f378
		 80010058 38210050 7c0803a6 bba1fff4
		 4e800020 7c0802a6 90010008 9421ffc0
		 90610058 388243a4 80640000 80630000
		 38030001 80640000 90030000 386243a4
		 80630000 80030000 2c000001 40820020
		 38000001 386243a8 98030000 80610058
		 48000845 60000000 48000008 38600000
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 388243a4 80640000 80630000 3803ffff
		 80640000 90030000 386243a4 80630000
		 80030000 2c000000 40820014 80610058
		 480010e9 60000000 48000008 38600000
		 80010048 38210040 7c0803a6 4e800020
		 38600000 4e800020 7c0802a6 bfa1fff4
		 90010008 9421ff90 b061008a 9081008c
		 90a10090 90c10094 90e10098 9901009f
		 3be243a4 3bc00000 38600688 38800001
		 48012259 80410014 907f0000 801f0000
		 28000000 4082000c 3860ffa3 480002cc
		 809f0000 8061008c 80010090 90640038
		 9004003c 80610094 80010098 90640040
		 90040044 a801008a 807f0000 b0030048
		 8801009f 807f0000 98030004 807f0000
		 38630038 4bfffbc1 809f0000 90640090
		 807f0000 80030090 807f0000 9003008c
		 807f0000 38630038 4bfffc09 809f0000
		 90640094 80bf0000 809f0000 80650038
		 8005003c 90640644 90040648 80650040
		 80050044 9064064c 90040650 38000001
		 807f0000 9803062c 807f0000 809f0000
		 38840038 4bfffd21 38610050 4800e4e5
		 60000000 809f0000 986405c8 807f0000
		 38820846 38a10050 38c00004 4bfff805
		 38610048 480121e5 80410014 807f0000
		 38800000 48005585 60000000 38610040
		 480121c9 80410014 80610040 80810044
		 80a10048 80c1004c 480122b9 80410014
		 7c7d1b78 38610038 7fa4eb78 480122bd
		 80410014 807f0000 3882084e 38a10038
		 38c00008 4bfff79d 3c805344 38845344
		 807f0000 9083004c 807f0000 480026f1
		 60000000 809f0000 90640140 807f0000
		 80030140 280000ff 40810020 807f0000
		 48012281 80410014 38000000 901f0000
		 3860ffff 48000134 807f0000 4bfffbc5
		 7c7e1b78 807f0000 800300dc 28000000
		 40820008 3bc0ffff 7fc00734 2c000000
		 40820014 3861008c 4800a531 60000000
		 7c7e0734 7fc00734 2c000000 40820040
		 807f0000 806300ac 809f0000 808400b0
		 80bf0000 38a500d0 80df0000 38c600c4
		 80ff0000 38e700c8 811f0000 390800cc
		 48012251 80410014 7c7e0734 7fc00734
		 2c000000 408200a0 807f0000 38630038
		 3c807662 38846c20 80bf0000 38a500d4
		 48012299 80410014 7c7e1b78 7fc00734
		 2c000000 41820010 38000000 807f0000
		 900300d4 809f0000 806400ac 808400b0
		 80bf0000 80a500d0 80df0000 818600c8
		 48012409 80410014 38000001 807f0000
		 980300d8 809f0000 806400ac 808400b0
		 80bf0000 48008b4d 60000000 809f0000
		 806400ac 808400b0 80bf0000 48008fb5
		 60000000 7fc3f378 80010078 38210070
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ff80 9081009c
		 90a100a0 90c100a4 90e100a8 990100af
		 3be243a4 3bc00000 801f0000 28000000
		 41820184 880100af 28000001 40820084
		 807f0000 80030104 5400043e b0010040
		 807f0000 80030100 5400043e b001003c
		 807f0000 88030063 98010043 807f0000
		 80030140 5400063e 98010042 807f0000
		 800300a0 9001005c 807f0000 88030153
		 98010060 38610044 3881003c 80bf0000
		 80a50100 48003a85 60000000 807f0000
		 3881003c 38a00001 48001739 60000000
		 807f0000 880300d8 28000000 41820070
		 809f0000 806400ac 808400b0 80bf0000
		 48008a71 60000000 809f0000 806400ac
		 808400b0 80bf0000 80a500d0 80df0000
		 818600cc 480122a5 80410014 807f0000
		 806300ac 809f0000 808400b0 80bf0000
		 80a500d0 80df0000 80c600c4 38e00000
		 39000000 48012065 80410014 807f0000
		 800300d4 28000000 41820014 807f0000
		 806300d4 480120ed 80410014 807f0000
		 880300d8 28000000 41820010 3861009c
		 4800aa25 60000000 3ba00018 807f0000
		 38630038 38820858 80bf0000 38a500ac
		 7fa6eb78 48011e25 80410014 7c7e0734
		 807f0000 48011f7d 80410014 38000000
		 901f0000 7fc3f378 80010088 38210080
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 93e1fffc 90010008 9421ffc0 7c7f1b78
		 a87f0000 809f0002 80bf0006 80df000a
		 80ff000e 39000000 4bfffad1 80010048
		 38210040 7c0803a6 83e1fffc 4e800020
		 7c0802a6 93e1fffc 90010008 9421ffc0
		 7c7f1b78 a87f0000 809f0002 80bf0006
		 80df000a 80ff000e 39000001 4bfffa8d
		 80010048 38210040 7c0803a6 83e1fffc
		 4e800020 7c0802a6 93e1fffc 90010008
		 9421ffc0 7c7f1b78 a87f0000 809f0002
		 80bf0006 80df000a 80ff000e 39000000
		 4bfffd7d 80010048 38210040 7c0803a6
		 83e1fffc 4e800020 7c0802a6 93e1fffc
		 90010008 9421ffc0 7c7f1b78 a87f0000
		 809f0002 80bf0006 80df000a 80ff000e
		 39000001 4bfffd39 80010048 38210040
		 7c0803a6 83e1fffc 4e800020 38600000
		 4e800020 38600000 4e800020 7c0802a6
		 90010008 9421ffc0 90610058 80610058
		 48000af9 60000000 80010048 38210040
		 7c0803a6 4e800020 7c0802a6 90010008
		 9421ffc0 90610058 80610058 48000de5
		 60000000 80010048 38210040 7c0803a6
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421ffc0 90610058 9081005c 90a10060
		 90c10064 90e10068 83c10060 3be00000
		 386243a4 80030000 28000000 41820014
		 80010058 386243a4 80630000 90030034
		 80010064 2800000a 418100a8 38620864
		 5400103a 7c63002e 7c6903a6 4e800420
		 80610060 4bfffe19 480000b8 80610060
		 4bfffe95 480000ac 80610060 4bfffe45
		 480000a0 80610060 4bfffec1 48000094
		 7fc3f378 4bfff811 48000088 7fc3f378
		 4bfff871 4800007c 7fc3f378 4bfff8c5
		 48000070 7fc3f378 4bfffed5 7c7f1b78
		 48000030 7fc3f378 4bfffecd 7c7f1b78
		 48000020 7fc3f378 4bfffec5 7c7f1b78
		 48000010 7fc3f378 4bfffee1 7c7f1b78
		 80010068 5400077a 28000000 4182000c
		 7fe3fb78 4800001c 8061005c 7fe4fb78
		 48011f31 80410014 7c7f1b78 7fe3fb78
		 80010048 38210040 7c0803a6 bbc1fff8
		 4e800020 7c0802a6 bf81fff0 90010008
		 9421ff60 3be243a4 3bc00000 807f0000
		 809f0000 38840144 80bf0000 38a50148
		 80df0000 38c6014c 80ff0000 38e70168
		 4800221d 60000000 807f0000 809f0000
		 3884014c 4800247d 60000000 807f0000
		 38820890 80df0000 80a6014c 48011511
		 60000000 807f0000 388208a0 80bf0000
		 80a50140 48011625 60000000 809f0000
		 80640144 546007bc 28000000 4182001c
		 38800001 807f0000 98830150 38000001
		 807f0000 98030114 807f0000 88030004
		 28000001 408200e0 807f0000 38810064
		 38a00000 4800129d 60000000 7c7e1b78
		 7fc00734 2c000000 4182003c 38000000
		 807f0000 98030004 807f0000 4800139d
		 60000000 807f0000 809f0000 3884005c
		 38a00000 48000f89 60000000 7c7e1b78
		 480000a0 a0010068 807f0000 b0030060
		 a0010064 807f0000 b003005c 8801006b
		 807f0000 98030063 8801006a 807f0000
		 98030062 88010066 807f0000 9803005e
		 88010067 807f0000 9803005f 807f0000
		 38a3005c 38810064 38000003 7c0903a6
		 84640008 80040004 94650008 90050004
		 4200fff0 80010084 807f0000 900300a0
		 48000020 807f0000 809f0000 3884005c
		 38a00000 48000ee9 60000000 7c7e1b78
		 7fc00734 2c000000 40820050 807f0000
		 a063005c 48002591 60000000 5460063e
		 28000000 41820034 807f0000 a0030064
		 28000000 41820024 807f0000 809f0000
		 a084005c 80bf0000 38a50064 48003079
		 60000000 7c7e1b78 807f0000 388208af
		 38a1003e 38c00020 4bffefd1 60000000
		 b061003c a801003c 2c000000 4182001c
		 807f0000 388208b4 38a1003c 38c00002
		 4bffef31 60000000 807f0000 388208c2
		 38a1003e 38c00020 4bffef19 60000000
		 807f0000 388208cc 38a1003e 38c00020
		 4bffef79 60000000 b061003c a801003c
		 2c000000 4182001c 807f0000 388208d1
		 38a1003c 38c00002 4bffeed9 60000000
		 807f0000 388208df 38a1003e 38c00020
		 4bffeec1 60000000 807f0000 388208e9
		 80bf0000 a0a5005c 480112a5 60000000
		 807f0000 388208f4 a0a10064 48011291
		 60000000 807f0000 88030629 28000001
		 40820044 807f0000 38820904 38a10038
		 4800f6ad 60000000 b061003a a801003a
		 2c000000 4182005c 807f0000 3882090d
		 38a10038 4800f769 60000000 b061003a
		 48000040 807f0000 38820917 38a10038
		 4800f66d 60000000 b061003a a801003a
		 2c000000 4182001c 807f0000 3882091c
		 38a10038 4800f729 60000000 b061003a
		 a801003a 2c000000 4182001c 807f0000
		 38820922 38a1003a 38c00002 4bffede5
		 60000000 807f0000 809f0000 a084005c
		 80bf0000 a0a50060 480018ad 60000000
		 7c7d1b78 a801003a 2c000000 408200b0
		 807f0000 3882092a 38a10038 38c00001
		 4bffeda1 60000000 281d0000 40820054
		 807f0000 88030150 28000000 41820014
		 38000080 807f0000 b0030060 48000010
		 38000081 807f0000 b0030060 807f0000
		 8003014c 5400043e 807f0000 b003005c
		 88010038 807f0000 98030063 48000070
		 807f0000 88030063 5403063e 88010038
		 7c030040 41820058 807f0000 8003014c
		 5400043e 807f0000 b003005c 88010038
		 807f0000 98030063 48000034 807f0000
		 88030063 28000000 41820024 807f0000
		 8003014c 5400043e 807f0000 b003005c
		 38000000 807f0000 98030063 807f0000
		 38820937 80bf0000 a0a5005c 480110c1
		 60000000 7fc00734 2c000000 408200ac
		 807f0000 809f0000 a084005c 80bf0000
		 a0a50060 48001781 60000000 7c7d1b78
		 807f0000 809f0000 a084005c 4800ee41
		 60000000 7c7c1b78 807f0000 88030154
		 28000000 41820008 639c0001 807f0000
		 a063005c 48002241 60000000 5460063e
		 28000000 41820008 639c0001 281d0000
		 41820034 578007fe 28000000 41820028
		 807f0000 a0030060 807f0000 90030104
		 807f0000 a003005c 807f0000 90030100
		 48000008 3bc0ffff 807f0000 38820946
		 80bf0000 80a50100 48010ff5 60000000
		 807f0000 80030140 28000001 40820038
		 807f0000 88030154 28000000 41820028
		 807f0000 a0030060 807f0000 90030104
		 807f0000 a003005c 807f0000 90030100
		 3bc00000 7fc00734 2c000000 40820040
		 807f0000 80630100 4800217d 60000000
		 5460063e 28000000 41820024 3800fffb
		 807f0000 90030100 807f0000 88030626
		 28000000 40820008 3bc0ffff 7fc00734
		 2c000000 4182005c 807f0000 8003014c
		 807f0000 90030100 807f0000 88030150
		 28000000 41820014 38000080 807f0000
		 90030104 48000010 38000081 807f0000
		 90030104 807f0000 88030004 28000000
		 41820010 807f0000 48000e21 60000000
		 807f0000 880305c8 28000000 41820048
		 38000006 807f0000 90030100 38000081
		 807f0000 90030104 807f0000 88030004
		 28000000 41820010 807f0000 48000ddd
		 60000000 38000000 807f0000 98030004
		 3bc00000 807f0000 3882095a 80bf0000
		 80a50100 48010e99 60000000 807f0000
		 80030104 5400043e 807f0000 b0030060
		 807f0000 80030100 5400043e 807f0000
		 b003005c 807f0000 80030140 5400063e
		 807f0000 98030062 38000001 807f0000
		 980305ca 807f0000 88030151 807f0000
		 980305cb 807f0000 88030152 807f0000
		 980305cc 807f0000 80030100 5400c63e
		 807f0000 980305cd 807f0000 80030100
		 5400063e 807f0000 980305ce 807f0000
		 88030063 807f0000 980305cf 807f0000
		 809f0000 388405ca 48000b3d 60000000
		 807f0000 809f0000 80840104 4800147d
		 60000000 809f0000 90640108 807f0000
		 80030108 28000008 40810010 38000001
		 807f0000 98030115 38000000 807f0000
		 9003016c 38000000 807f0000 90030110
		 3860030a 38800001 480112e1 80410014
		 809f0000 9064016c 807f0000 8003016c
		 28000000 41820024 807f0000 48006c71
		 60000000 809f0000 8084016c 38a0030a
		 48011681 80410014 807f0000 48001dc5
		 60000000 7c7e1b78 7fc00734 2c000000
		 41820020 807f0000 38800053 38a00000
		 48003e8d 60000000 7fc3f378 48000088
		 807f0000 88030004 28000000 40820028
		 809f0000 88a40115 28050000 41820018
		 807f0000 80df0000 8086016c 4800128d
		 60000000 80ff0000 888700d8 28040000
		 41820028 807f0000 3c807662 38846c20
		 38a00001 4800365d 60000000 38c00001
		 80bf0000 98c500e4 38800000 807f0000
		 98830004 38000000 809f0000 980405c9
		 7fc3f378 800100a8 382100a0 7c0803a6
		 bb81fff0 4e800020 7c0802a6 93e1fffc
		 90010008 9421ffc0 3be243a4 807f0000
		 8003016c 28000000 41820020 807f0000
		 8063016c 4801136d 80410014 38000000
		 807f0000 9003016c 807f0000 38800000
		 38a00000 38c00000 48003451 60000000
		 38600000 80010048 38210040 7c0803a6
		 83e1fffc 4e800020 7c0802a6 bf81fff0
		 90010008 9421ffb0 7c7e1b78 3ba243a4
		 3be00000 ab9e001a 7f800734 2c000016
		 418201fc 4080006c 2c000007 41820160
		 40800038 2c000003 418200f4 4080001c
		 2c000001 418202b0 408000cc 2c000000
		 408000ac 480002a0 2c000005 41820100
		 40800114 480000e0 2c00000b 41820180
		 40800014 2c000009 41820144 40800158
		 48000124 2c000010 4182017c 48000268
		 2c000020 41820260 40800034 2c00001d
		 418201dc 4080001c 2c000019 418201a0
		 40800244 2c000018 4080023c 48000178
		 2c00001f 408001a0 4800022c 2c000084
		 418201dc 4080001c 2c000080 418201b8
		 40800214 2c000022 4080020c 480001f0
		 2c000086 40800200 480001cc 807e001c
		 809d0000 480048e5 60000000 7c7f1b78
		 480001e8 807e001c 809d0000 48004b1d
		 60000000 7c7f1b78 480001d0 807e001c
		 809d0000 48004bd5 60000000 7c7f1b78
		 480001b8 807e001c 809d0000 48004dcd
		 60000000 7c7f1b78 480001a0 807e001c
		 809d0000 48004f69 60000000 7c7f1b78
		 48000188 807e001c 809d0000 48004fe1
		 60000000 7c7f1b78 48000170 807e001c
		 809d0000 48005019 60000000 7c7f1b78
		 48000158 807e001c 809d0000 48005071
		 60000000 7c7f1b78 48000140 807e001c
		 809d0000 48005165 60000000 7c7f1b78
		 48000128 807e001c 809d0000 48004ac1
		 60000000 7c7f1b78 48000110 807e001c
		 809d0000 48005571 60000000 7c7f1b78
		 480000f8 807e001c 809d0000 48005425
		 60000000 7c7f1b78 480000e0 807e001c
		 809d0000 480055e9 60000000 7c7f1b78
		 480000c8 807e001c 809d0000 48005609
		 60000000 7c7f1b78 480000b0 807e001c
		 809d0000 48005789 60000000 7c7f1b78
		 48000098 807e001c 809d0000 480057d1
		 60000000 7c7f1b78 48000080 807e001c
		 809d0000 48005635 60000000 7c7f1b78
		 48000068 807e001c 809d0000 48005675
		 60000000 7c7f1b78 48000050 807e001c
		 809d0000 48005675 60000000 7c7f1b78
		 48000038 807e001c 809d0000 480056b1
		 60000000 7c7f1b78 48000020 807e001c
		 809d0000 48005af5 60000000 7c7f1b78
		 48000008 3be0ffef 7fe3fb78 80010058
		 38210050 7c0803a6 bb81fff0 4e800020
		 7c0802a6 bf81fff0 90010008 9421ffb0
		 7c7e1b78 3ba243a4 3be00000 ab9e001a
		 7f800734 2c000015 41820290 40800088
		 2c00000a 418201c4 40800040 2c000005
		 41820140 4080001c 2c000003 41820104
		 40800118 2c000002 408000e0 48000394
		 2c000008 41820164 40800178 2c000007
		 40800140 48000124 2c000010 4182020c
		 4080001c 2c00000d 418201b8 40800364
		 2c00000c 40800194 48000178 2c000013
		 41820350 408001fc 2c000012 408001c4
		 480001a8 2c00001f 41820290 40800040
		 2c00001a 4182032c 4080001c 2c000018
		 41820320 40800244 2c000017 40800224
		 48000208 2c00001d 41820278 40800244
		 2c00001c 408002fc 480001d8 2c0000a1
		 418202a8 4080001c 2c000080 4182026c
		 408002e0 2c000021 408002d8 480002a4
		 2c0000d0 418202b4 408002c8 2c0000a3
		 408002c0 4800025c 807e001c 809d0000
		 48005add 60000000 7c7f1b78 480002a8
		 807e001c 809d0000 48005af5 60000000
		 7c7f1b78 48000290 807e001c 809d0000
		 48005a9d 60000000 7c7f1b78 48000278
		 807e001c 809d0000 48005be1 60000000
		 7c7f1b78 48000260 807e001c 809d0000
		 48005bfd 60000000 7c7f1b78 48000248
		 807e001c 809d0000 48005c0d 60000000
		 7c7f1b78 48000230 807e001c 809d0000
		 48005c1d 60000000 7c7f1b78 48000218
		 807e001c 809d0000 48005c29 60000000
		 7c7f1b78 48000200 807e001c 809d0000
		 48005c25 60000000 7c7f1b78 480001e8
		 807e001c 809d0000 480067c9 60000000
		 7c7f1b78 480001d0 807e001c 809d0000
		 480060e5 60000000 7c7f1b78 480001b8
		 807e001c 809d0000 4800644d 60000000
		 7c7f1b78 480001a0 807e001c 809d0000
		 48005c21 60000000 7c7f1b78 48000188
		 807e001c 809d0000 48005e79 60000000
		 7c7f1b78 48000170 807e001c 809d0000
		 48005bd1 60000000 7c7f1b78 48000158
		 807e001c 809d0000 48006579 60000000
		 7c7f1b78 48000140 807e001c 809d0000
		 4800668d 60000000 7c7f1b78 48000128
		 807e001c 809d0000 480067ad 60000000
		 7c7f1b78 48000110 807e001c 809d0000
		 48006729 60000000 7c7f1b78 480000f8
		 807e001c 809d0000 48006721 60000000
		 7c7f1b78 480000e0 807e001c 809d0000
		 48006e0d 60000000 7c7f1b78 480000c8
		 807e001c 809d0000 48006f59 60000000
		 7c7f1b78 480000b0 807e001c 809d0000
		 48006ef9 60000000 7c7f1b78 48000098
		 807e001c 809d0000 480066f5 60000000
		 7c7f1b78 48000080 807e001c 809d0000
		 48006cd5 60000000 7c7f1b78 48000068
		 807e001c 809d0000 48006d29 60000000
		 7c7f1b78 48000050 807e001c 809d0000
		 48006dc5 60000000 7c7f1b78 48000038
		 807e001c 809d0000 48006f45 60000000
		 7c7f1b78 48000020 807e001c 809d0000
		 48006ef9 60000000 7c7f1b78 48000008
		 3be0ffee 7fe3fb78 80010058 38210050
		 7c0803a6 bb81fff0 4e800020 7c0802a6
		 bf81fff0 90010008 9421ff80 7c7e1b78
		 7c9c2378 98a100a3 3ba2096a 38000020
		 90010064 880100a3 28000000 4182008c
		 387e0038 7fa4eb78 7f85e378 80c10064
		 48010a59 80410014 7c7f0734 7fe00734
		 2c000000 41820020 387e0038 7fa4eb78
		 7f85e378 80c10064 48010a49 80410014
		 7c7f0734 387e0038 7fa4eb78 38a10060
		 48010c71 80410014 7c7f0734 7fe00734
		 2c000000 4082012c 387e0038 7fa4eb78
		 80010060 60050020 48010c61 80410014
		 7c7f0734 4800010c 387e0038 3881005c
		 48010c91 80410014 7c7f0734 7fe00734
		 2c000000 4182000c 7fe3fb78 480000e8
		 3861005c 38810039 38a10038 48010c7d
		 80410014 7c7f0734 7fe00734 2c000000
		 408200b4 7fa3eb78 38810039 48010ca5
		 80410014 7c600734 2c000000 40820040
		 387e0038 7fa4eb78 7f85e378 38c10064
		 48010921 80410014 7c7f0734 7fe00734
		 2c000000 40820070 80010064 28000020
		 40810064 3be0ffce 4800005c 387e0038
		 38810039 38a10060 48010b89 80410014
		 7c7f0734 7fe00734 2c000000 4082002c
		 80010060 540006b4 28000000 4182001c
		 387e0038 38810039 48010a09 80410014
		 3be0ffce 48000010 88010038 28000000
		 4182ff30 3861005c 48010bc9 80410014
		 7fe3fb78 80010088 38210080 7c0803a6
		 bb81fff0 4e800020 93e1fffc 3be00000
		 48000038 88030000 7c000774 54000636
		 7c062670 38060030 7c04f9ae 88030000
		 5406073e 38060030 7cdf2214 98060001
		 38630001 3bff0002 54a0083c 7c1f0000
		 4180ffc4 38000000 7c04f9ae 83e1fffc
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421ff90 90610088 9081008c 3bc2096f
		 8061008c 38810038 38a00006 4bffff7d
		 38610054 48010b65 80410014 38600000
		 38820974 38a10054 48010b69 80410014
		 7c7f0734 7fe00734 2c000000 4082002c
		 800200ac 28000000 41820020 80610088
		 38630038 7fc4f378 38a10038 38c0000d
		 48010b49 80410014 7fe3fb78 80010078
		 38210070 7c0803a6 bbc1fff8 4e800020
		 7c0802a6 bf81fff0 90010008 9421ffa0
		 7c7d1b78 7c9c2378 98a10083 3bc20990
		 3be00000 38000028 90010040 88010083
		 28000000 41820088 387d0038 7fc4f378
		 7f85e378 80c10040 48010781 80410014
		 7c7f0734 7fe00734 2c000000 41820020
		 387d0038 7fc4f378 7f85e378 80c10040
		 48010771 80410014 7c7f0734 387d0038
		 7fc4f378 38a10038 48010999 80410014
		 7c7f0734 7fe00734 2c000000 40820074
		 387d0038 7fc4f378 80a10038 4801098d
		 80410014 7c7f0734 48000058 387d0038
		 7fc4f378 38a1003c 48010899 80410014
		 7c7f0734 8061003c 80010040 7c030040
		 41820008 3be0ffce 7fe00734 2c000000
		 40820020 387d0038 7fc4f378 7f85e378
		 38c10040 4801067d 80410014 7c7f0734
		 7fe3fb78 80010068 38210060 7c0803a6
		 bb81fff0 4e800020 7c0802a6 bfa1fff4
		 90010008 9421ffb0 7c7d1b78 3bc2099f
		 38000001 90010038 387d0038 7fc4f378
		 38a10038 38c00004 48010689 80410014
		 7c7f0734 7fe00734 2c000000 4082001c
		 387d0038 7fc4f378 38a1003c 480108a5
		 80410014 7c7f0734 7fe00734 2c000000
		 4082001c 387d0038 7fc4f378 80a1003c
		 48010899 80410014 7c7f0734 7fe3fb78
		 80010058 38210050 7c0803a6 bba1fff4
		 4e800020 7c0802a6 bf81fff0 90010008
		 9421ffb0 7c7d1b78 7c9c2378 7cbe2b78
		 386209ac 80030000 90010038 a0030004
		 b001003c 3c1c0001 2800ffff 41820010
		 38610038 7c63e0ae 48000098 7fa3eb78
		 38800054 48003375 60000000 547f0626
		 57c007fe 28000000 41820008 63ff0500
		 57c007bc 28000000 41820008 63ff0600
		 57c00630 28000000 41820008 63ff0c00
		 7fa3eb78 38800054 7fe5fb78 480032f1
		 60000000 7fa3eb78 38800058 4800331d
		 60000000 547f045e 57c00630 28000000
		 41820008 63ff8000 7fa3eb78 38800058
		 7fe5fb78 480032b9 60000000 38600000
		 80010058 38210050 7c0803a6 bb81fff0
		 4e800020 7c0802a6 93e1fffc 90010008
		 9421ffa0 90610078 38610040 4801052d
		 80410014 38610048 38800015 80a10040
		 80c10044 48010875 80410014 80610078
		 38800044 480030cd 60000000 5460063e
		 540007fe 2c000000 40820034 38610038
		 480104e9 80410014 80610038 8081003c
		 80a10048 80c1004c 480105d9 80410014
		 7c7f1b78 2c1f0000 4182ffb4 80010068
		 38210060 7c0803a6 83e1fffc 4e800020
		 7c0802a6 bf21ffe4 90010008 9421ffa0
		 7c7c1b78 7c9a2378 7cb92b78 7cde3378
		 3ba00001 386243a4 80630000 80030108
		 28000010 4082000c 3ba00008 48000008
		 3ba00001 7f400734 2c00ffff 40820078
		 3be00000 48000060 7f83e378 7fe00734
		 54001838 7c1e02ae 7c9d01d6 480028ad
		 60000000 7f83e378 7fe00734 54041838
		 38840002 7c9e2214 7fe00734 54051838
		 38a50004 7cbe2a14 7fe00734 54061838
		 38c60006 7cde3214 4800294d 60000000
		 3bff0001 7fe30734 7f200734 7c030000
		 4180ff98 7f400734 2c000000 41800084
		 7f83e378 7f44d378 48002841 60000000
		 3be00000 4800005c 3b600000 48000044
		 7f83e378 7fe00734 54041838 38840002
		 7c9e2214 7fe00734 54051838 38a50004
		 7cbe2a14 7fe00734 54061838 38c60006
		 7cde3214 480028d1 60000000 3b7b0001
		 7f600734 7c00e840 4180ffb8 3bff0001
		 7fe30734 7f200734 7c030000 4180ff9c
		 38600000 80010068 38210060 7c0803a6
		 bb21ffe4 4e800020 7c0802a6 bfc1fff8
		 90010008 9421ffc0 7c7e1b78 386243a4
		 80630000 880305c1 28000000 40820010
		 7fc3f378 38800001 4bfffdcd 7fc3f378
		 38800000 480027b1 60000000 3be00000
		 48000020 7fc3f378 38807fff 38a07fff
		 38c07fff 480027cd 60000000 3bff0001
		 7fe00734 2c000100 4180ffdc 80010048
		 38210040 7c0803a6 bbc1fff8 4e800020
		 7c0802a6 bf41ffe8 90010008 9421ffb0
		 7c7a1b78 3b800001 386243a4 80630000
		 80030108 28000010 40820010 3ba00020
		 3b800008 4800000c 3ba00100 3b800001
		 386243a4 80630000 880305c1 28000000
		 40820010 7f43d378 38800001 4bfffd19
		 7f43d378 38800000 480026fd 60000000
		 3be00000 48000048 3c600001 3863ffff
		 7c7f19d6 381dffff 7fc30396 3b600000
		 48000020 7f43d378 57c4043e 57c5043e
		 57c6043e 480026fd 60000000 3b7b0001
		 7c1be040 4180ffe0 3bff0001 7c1fe840
		 4180ffb8 80010058 38210050 7c0803a6
		 bb41ffe8 4e800020 7c0802a6 bf21ffe4
		 90010008 9421ffa0 7c7b1b78 7c9a2378
		 7cb92b78 7cdd3378 3bc00001 386243a4
		 80630000 880305c1 28000000 40820010
		 7f63db78 38800001 4bfffc5d 386243a4
		 80630000 80030108 28000010 4082000c
		 3bc00008 48000008 3bc00001 7f400734
		 2c000000 41800088 7f63db78 7f400734
		 7c80f1d6 48002611 60000000 3be00000
		 4800005c 3b800000 48000044 7f63db78
		 7fe00734 54041838 38040002 7c9d022e
		 7fe00734 54051838 38050004 7cbd022e
		 7fe00734 54061838 38060006 7cdd022e
		 48002601 60000000 3b9c0001 7f800734
		 7c00f040 4180ffb8 3bff0001 7fe30734
		 7f200734 7c030000 4180ff9c 7f400734
		 2c00ffff 40820090 3be00000 48000078
		 7f63db78 7fe00734 54001838 7c1d02ae
		 7c9e01d6 48002571 60000000 3b800000
		 48000044 7f63db78 7fe00734 54041838
		 38040002 7c9d022e 7fe00734 54051838
		 38050004 7cbd022e 7fe00734 54061838
		 38060006 7cdd022e 48002569 60000000
		 3b9c0001 7f800734 7c00f040 4180ffb8
		 3bff0001 7fe30734 7f200734 7c030000
		 4180ff80 80010068 38210060 7c0803a6
		 bb21ffe4 4e800020 7c0802a6 bf21ffe4
		 90010008 9421ffa0 7c791b78 7c9d2378
		 281d0000 418200c4 3bfd000c a81d0004
		 7fff0214 a37d0008 a81d0006 2c000003
		 40820018 5760043e 7f9f0214 5760043e
		 7f5c0214 4800000c 7ffcfb78 7ffafb78
		 386243a4 80630000 880305c1 28000000
		 40820010 7f23cb78 38800001 4bfffa89
		 7f23cb78 38800000 4800246d 60000000
		 3bc00000 48000044 7f23cb78 7c1ff0ae
		 7c000774 5400402e 5404043e 7c1cf0ae
		 7c000774 5400402e 5405043e 7c1af0ae
		 7c000774 5400402e 5406043e 48002465
		 60000000 3bde0001 5760043e 7c1e0040
		 4180ffb8 48000010 386243a4 80630000
		 4bfffca1 80010068 38210060 7c0803a6
		 bb21ffe4 4e800020 28040080 4180000c
		 28040085 4081000c 38600000 48000014
		 38621a78 3804ff80 5400103a 7c63002e
		 4e800020 3864ff83 4e800020 386209b4
		 4e800020 7c0802a6 bf41ffe8 90010008
		 9421ffb0 7c7e1b78 7c9c2378 7cba2b78
		 3ba00000 281a0080 4080000c 38600000
		 480000d4 7fc3f378 4bffffc5 7c7f1b78
		 7f83e378 48000ac1 60000000 5460063e
		 28000000 41820014 7fc3f378 48000109
		 60000000 48000008 7fe3fb78 7c7f1b78
		 7f83e378 48000ab1 60000000 5460063e
		 28000000 41820014 7fc3f378 48000135
		 60000000 48000008 7fe3fb78 7c7f1b78
		 48000044 837f0000 7c1be040 40820024
		 7fc3f378 7fe4fb78 4800b2c9 60000000
		 7c1a1840 41810028 3ba00001 48000020
		 7fc3f378 7fe4fb78 48000095 60000000
		 7c7f1b78 281f0000 4082ffbc 57a0063e
		 28000000 4182000c 7fe3fb78 48000008
		 38600000 80010058 38210050 7c0803a6
		 bb41ffe8 4e800020 386209b4 4e800020
		 386209b4 38030900 7c040040 4082000c
		 38600000 4800000c 38840024 7c832378
		 4e800020 80640000 3c038001 2800ffff
		 4082000c 38600001 48000008 38600000
		 4e800020 38621368 4e800020 386209b4
		 38030900 7c040040 4082000c 38600000
		 4800003c 38621368 3803006c 7c040040
		 4082000c 38600000 48000024 386212d8
		 3803006c 7c040040 4082000c 38600000
		 4800000c 38840024 7c832378 4e800020
		 386212d8 4e800020 88630160 4e800020
		 7c0802a6 bfa1fff4 90010008 9421ffb0
		 7c7f1b78 7c9d2378 7fe3fb78 38800038
		 4800bc7d 60000000 7fe3fb78 3880fffd
		 480022f1 60000000 7fe3fb78 388203b0
		 7c84e8ae 4800bc59 60000000 7fe3fb78
		 3880fff4 480022cd 60000000 7fe3fb78
		 4800bd39 60000000 5460063e 5404077e
		 38621a90 57a01838 7c002214 7fc300ae
		 7fe3fb78 3880fffd 48002299 60000000
		 7fe3fb78 38800007 4800bc05 60000000
		 57c3063e 80010058 38210050 7c0803a6
		 bba1fff4 4e800020 bfc1fff8 5480063e
		 5403402e 54a0063e 7c7e0378 3be00000
		 48000028 57c6043e 38621438 57e0083c
		 7c03022e 7c060040 4082000c 38600001
		 48000020 3bff0001 38621438 57e0083c
		 7c03022e 2800ff00 4082ffcc 38600000
		 bbc1fff8 4e800020 38000088 98040000
		 380000ff 98050000 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ffb0 7c7d1b78
		 9081006c 90a10070 3bc00007 3be0003f
		 7fa3eb78 4bfffea5 5460063e 28000000
		 41820044 7fa3eb78 38800000 4bfffe95
		 547e063e 7fa3eb78 38800001 4bfffe85
		 547f063e 7fa3eb78 38800002 4bfffe75
		 7fff1a14 7fa3eb78 38800003 4bfffe65
		 7fff1a14 7fa3eb78 7fc4f378 7fe5fb78
		 4bffff09 5460063e 28000000 4182001c
		 57c0063e 28000007 40820050 57e0063e
		 2800003f 40820044 881d0154 28000000
		 4182000c 3bc00007 3be00017 57c0063e
		 28000007 40820024 57e0063e 2800003f
		 40820018 881d0153 28000000 4182000c
		 3bc00007 3be00017 881d05c8 28000000
		 4182000c 3bc00007 3be00017 8061006c
		 9bc30000 80610070 9be30000 80010058
		 38210050 7c0803a6 bba1fff4 4e800020
		 88030151 98040000 88030152 98050000
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421ffc0 7c7f1b78 7c9e2378 57c0063e
		 280000ff 4082001c 7fe3fb78 4800d581
		 60000000 881f0629 901f0164 4800000c
		 57c0063e 901f0164 80010048 38210040
		 7c0803a6 bbc1fff8 4e800020 7c0802a6
		 bf81fff0 90010008 9421ffb0 7c7e1b78
		 801e0164 2c000002 41820050 40800014
		 2c000000 41820058 40800014 48000050
		 2c000004 40800048 4800001c 7fc3f378
		 38810039 38a10038 4800d865 60000000
		 4800003c 7fc3f378 38810039 38a10038
		 4bfffdf9 48000028 7fc3f378 38810039
		 38a10038 4bffff1d 48000014 38000007
		 98010039 3800003f 98010038 3ba00001
		 88010039 5403402e 88010038 7f830214
		 3be00000 48000028 5784043e 38621438
		 57e0083c 7c03022e 7c040040 4082000c
		 7ffdfb78 48000010 3bff0001 281f0013
		 4081ffd8 7fa3eb78 80010058 38210050
		 7c0803a6 bb81fff0 4e800020 7c0802a6
		 bf61ffec 90010008 9421ffb0 3ba243a4
		 807d0000 4bfffef9 7c7b1b78 3be21464
		 3bc00000 807d0000 93630140 48000020
		 3bff000c 839f0000 5783083c 38030001
		 5400103a 7fff0214 3bde0001 807d0000
		 80030140 7c1e0040 4182000c 281e0013
		 4081ffd0 7fe3fb78 80010058 38210050
		 7c0803a6 bb61ffec 4e800020 7c0802a6
		 bf21ffe4 90010008 9421ffa0 7c992378
		 7cba2b78 7cdb3378 7cfc3b78 4bffff61
		 7c7f1b78 28190000 4182000c 801f0000
		 90190000 281a0000 4182000c 801f0004
		 901a0000 281c0000 4182000c 801f0008
		 901c0000 281b0000 41820038 3bdf0010
		 83bf000c 48000018 801e0004 5400077a
		 28000000 40820014 3bde0008 281d0000
		 3bbdffff 4082ffe4 801e0000 901b0000
		 80010068 38210060 7c0803a6 bb21ffe4
		 4e800020 7c0802a6 bfa1fff4 90010008
		 9421ffb0 90610068 9081006c 4bfffec1
		 7c7e1b78 3bfe0010 80610068 80030140
		 2800000f 4082000c 38600023 48000038
		 83be000c 48000020 807f0000 8001006c
		 7c030040 4082000c 807f0004 48000018
		 3bff0008 281d0000 3bbdffff 4082ffdc
		 38600000 80010058 38210050 7c0803a6
		 bba1fff4 4e800020 bfa1fff4 3be21464
		 3bc00000 48000020 3bff000c 83bf0000
		 57a4083c 38040001 5400103a 7fff0214
		 3bde0001 7c1e1840 4182000c 281e0013
		 4081ffd8 7fe3fb78 bba1fff4 4e800020
		 7c0802a6 bfa1fff4 90010008 9421ffb0
		 90610068 7c9f2378 3bc00000 281f0000
		 4082000c 3860ffce 480000c4 881f0000
		 28000014 4180000c 3860ffee 480000b0
		 887f0000 4bffff75 7c7e1b78 887f0001
		 801e000c 7c030040 41800038 887f0000
		 38030001 981f0000 38000000 981f0001
		 881f0000 28000014 4180000c 3860ffee
		 4800006c 887f0000 4bffff31 7c7e1b78
		 38621438 881f0000 5400083c 7c03022e
		 901f0004 881f0001 54031838 38030010
		 7fbe002e 80610068 7fa4eb78 38a00080
		 4bfff7d5 907f0008 881f0001 54031838
		 38030014 7c1e002e 901f000c 887f0001
		 38030001 981f0001 38600000 80010058
		 38210050 7c0803a6 bba1fff4 4e800020
		 7c0802a6 bfa1fff4 90010008 9421fe80
		 7c7d1b78 9081019c 3bc00000 38621ab0
		 38a10030 3883fff8 38000007 7c0903a6
		 84640008 80040004 94650008 90050004
		 4200fff0 7fa3eb78 38821ae8 38a10070
		 38c00100 4bffccd5 60000000 7c7e1b78
		 7fc00734 2c000000 40820078 881d0629
		 28000002 4082006c 3be00000 4800005c
		 57e0103a 38610038 7c0300ae 38610070
		 7cc300ae 38a00001 57e4103a 38610038
		 38040001 7c0300ae 7ca00030 7cc00038
		 2c000000 41820020 57e4103a 38610038
		 38040002 7c03022e 8061019c 90030000
		 48000010 3bff0001 281f000e 4180ffa4
		 7fc3f378 80010188 38210180 7c0803a6
		 bba1fff4 4e800020 80030000 28000001
		 40820018 38000000 388243a4 80840000
		 980405c1 48000014 38000001 388243a4
		 80840000 980405c1 38600000 4e800020
		 7c0802a6 bfc1fff8 90010008 9421ffb0
		 7c7f1b78 7fe3fb78 809f0100 80bf0104
		 4bfff645 7c7e1b78 281e0000 4082000c
		 3860ffef 4800011c 881f0004 28000000
		 4082001c 801f0104 28000080 41820010
		 7fe3fb78 4bfff1d5 60000000 7fe3fb78
		 7fc4f378 38a00000 80df0104 38e00001
		 48001f55 60000000 881f0004 28000000
		 40820030 7fe3fb78 809f008c 801f0138
		 7c840214 80bf011c a8a50014 80df0108
		 80ff011c a8e7001c 480011ad 60000000
		 881f0115 28000000 41820018 7fe3fb78
		 809f016c 4bfff465 60000000 48000080
		 38000000 b0010038 3c600001 3863ffff
		 b061003a 3c600001 3863ffff b061003c
		 3c600001 3863ffff b061003e 7fe3fb78
		 3880ffff 38a00001 38c10038 4bfff27d
		 60000000 380000ff b0010038 38000000
		 b001003a 38000000 b001003c 38000000
		 b001003e 7fe3fb78 3880ffff 38a00001
		 38c10038 4bfff245 60000000 38600000
		 80010058 38210050 7c0803a6 bbc1fff8
		 4e800020 28030072 40810014 28030077
		 4080000c 38600001 48000008 38600000
		 4e800020 3c008000 7c030040 41800018
		 3800fffb 7c030040 4181000c 38600001
		 48000008 38600000 4e800020 7c0802a6
		 bf41ffe8 90010008 9421ffb0 7c7e1b78
		 7c9f2378 7c1ef840 4082000c 38600001
		 4800031c 83be0000 839f0000 a01e0008
		 5403043e a01f0008 7c030040 4182000c
		 38600000 480002f8 a01e000a 5403043e
		 a01f000a 7c030040 4182000c 38600000
		 480002dc a01e000c 5403043e a01f000c
		 7c030040 4182000c 38600000 480002c0
		 807e0010 801f0010 7c030040 4182000c
		 38600000 480002a8 a01e0014 5403043e
		 a01f0014 7c030040 4182000c 38600000
		 4800028c a01e0016 5403043e a01f0016
		 7c030040 4182000c 38600000 48000270
		 a01e0018 5403043e a01f0018 7c030040
		 4182000c 38600000 48000254 a01e001a
		 5403043e a01f001a 7c030040 4182000c
		 38600000 48000238 a01e001c 5403043e
		 a01f001c 7c030040 4182000c 38600000
		 4800021c a01e001e 5403043e a01f001e
		 7c030040 4182000c 38600000 48000200
		 a01e0020 5403043e a01f0020 7c030040
		 4182000c 38600000 480001e4 a01e0022
		 5403043e a01f0022 7c030040 4182000c
		 38600000 480001c8 7f83e378 4800e601
		 60000000 547a063e 7fa3eb78 4800e5f1
		 60000000 5460063e 7c00d040 4182000c
		 38600000 48000198 7f83e378 4800e5f1
		 60000000 547a063e 7fa3eb78 4800e5e1
		 60000000 5460063e 7c00d040 4182000c
		 38600000 48000168 7f83e378 4800e601
		 60000000 547a063e 7fa3eb78 4800e5f1
		 60000000 5460063e 7c00d040 4182000c
		 38600000 48000138 7f83e378 4800e611
		 60000000 547a063e 7fa3eb78 4800e601
		 60000000 5460063e 7c00d040 4182000c
		 38600000 48000108 7f83e378 4800e521
		 60000000 547a063e 7fa3eb78 4800e511
		 60000000 5460063e 7c00d040 4182000c
		 38600000 480000d8 7f83e378 4800e4d9
		 60000000 547a063e 7fa3eb78 4800e4c9
		 60000000 5460063e 7c00d040 4182000c
		 38600000 480000a8 3b600000 7f83e378
		 4800e51d 60000000 5460063e 28000000
		 4082002c 7f83e378 4bfffcfd 5460063e
		 28000000 40820018 7f83e378 4bfffd09
		 5460063e 28000000 41820008 3b600001
		 3b400000 7fa3eb78 4800e4d5 60000000
		 5460063e 28000000 4082002c 7fa3eb78
		 4bfffcb5 5460063e 28000000 40820018
		 7fa3eb78 4bfffcc1 5460063e 28000000
		 41820008 3b400001 7c1ad800 4182000c
		 38600000 48000008 38600001 80010058
		 38210050 7c0803a6 bb41ffe8 4e800020
		 7c0802a6 bfa1fff4 90010008 9421ffb0
		 90610068 7c9f2378 7cbe2b78 3ba243a4
		 807d0000 4bfff2fd 907e0000 807d0000
		 4bfff295 907f0000 48000024 807d0000
		 809f0000 4bfff289 907f0000 807d0000
		 809e0000 4bfff279 907e0000 801f0000
		 28000000 41820024 801e0000 28000000
		 41820018 807f0000 80630000 80010068
		 7c030040 4082ffb8 801e0000 28000000
		 4082000c 3860ffce 4800001c 801f0000
		 28000000 4082000c 3860ffce 48000008
		 38600000 80010058 38210050 7c0803a6
		 bba1fff4 4e800020 7c0802a6 dbe1fff8
		 bfc1ffe8 90010008 9421ff80 7c9f2378
		 3bc00000 807f0010 38810038 480005fd
		 60000000 7c600734 2c000000 4182000c
		 3860ffef 480002dc 809f0014 80610038
		 80030004 7c040040 4182000c 3860ffce
		 480002c0 80810038 80640004 38030001
		 90040004 901f0014 807f0010 38810040
		 38a1003c 4bfffebd 7c600734 2c000000
		 4182000c 3860ffef 48000288 807f0028
		 809f002c 48007dc9 ffe00890 807f0040
		 801f0044 7c030214 c82203b8 9001005c
		 3c004330 90010058 c8010058 fc000828
		 ffff0024 807f0050 801f0054 7c030214
		 c82203b8 90010054 3c004330 90010050
		 c8010050 fc000828 ffff0024 c80203c0
		 ffff002a fc00f81e d8010048 8001004c
		 80610040 b0030008 38c02710 38a00000
		 807f0028 809f002c 48007c55 80610040
		 90830010 801f0040 5400043e 80610040
		 b0030014 807f0040 801f0044 7c030214
		 80610040 b0030016 801f0048 5400043e
		 80610040 b0030018 801f004c 5400043e
		 80610040 b003001a 801f0050 5400043e
		 80610040 b003001c 807f0050 801f0054
		 7c030214 80610040 b003001e 801f0058
		 5400043e 80610040 b0030020 801f005c
		 5400043e 80610040 b0030022 801f0020
		 540006f6 28000000 4182000c 38000001
		 48000008 38000000 5400043e 80610040
		 b003000a 80810040 a064000a 801f0020
		 54000630 28000000 4182000c 38000002
		 48000008 38000000 7c600378 b004000a
		 801f0070 540007fe 28000000 4182000c
		 38000001 48000008 38000000 5400043e
		 80610040 b003000c 80810040 a064000c
		 801f0078 540007fe 28000000 4182000c
		 38000002 48000008 38000000 7c600378
		 b004000c 801f0018 80610038 90030008
		 3c808000 3884ffff 8061003c 90830000
		 38000000 8061003c 90030010 38000000
		 8061003c b0030016 38000000 8061003c
		 b003001e 38000000 80610038 9003000c
		 801f0018 28000000 40820064 807f001c
		 4bfff905 5460063e 28000000 41820050
		 80810040 8061003c 38a3fff8 3884fff8
		 38000004 7c0903a6 84640008 80040004
		 94650008 90050004 4200fff0 80040008
		 90050008 801f001c 8061003c 90030000
		 801f001c 80610038 9003000c 7fc3f378
		 80010088 38210080 cbe1fff8 7c0803a6
		 bbc1ffe8 4e800020 7c0802a6 bf41ffe8
		 90010008 9421ffa0 7c7c1b78 7c9f2378
		 3b400000 807f0010 4bfff84d 7c7b1b78
		 5760063e 28000000 41820038 807f0010
		 38810040 480002b5 60000000 7c600734
		 2c000000 4182000c 3860ffee 48000288
		 7f83e378 4bffee71 7c7e1b78 48000044
		 7f83e378 4bffecf9 7c7e1b78 807f0010
		 4bfff815 5460063e 28000000 41820024
		 7f83e378 4bffee9d 7c7e1b78 48000014
		 7f83e378 7fc4f378 4bffee35 7c7e1b78
		 281e0000 41820014 807e0000 801f0010
		 7c030040 4082ffdc 281e0000 4082000c
		 3860ffee 48000210 801e0010 1c602710
		 38000000 907f002c 901f0028 801e0010
		 28000000 4182001c 807e0010 3881003c
		 38a10038 48008ded 60000000 48000008
		 38600000 7c7d1b78 801e0010 7c1d0040
		 4181000c 7fa0eb78 48000008 801e0010
		 1c602710 38000000 907f0034 901f0030
		 801e0010 7c1d0040 41800008 48000008
		 83be0010 1c7d2710 38000000 907f003c
		 901f0038 a01e0014 901f0040 a07e0014
		 a01e0016 7c030050 901f0044 a01e0018
		 901f0048 a01e001a 901f004c a01e001c
		 901f0050 a07e001c a01e001e 7c030050
		 901f0054 a01e0020 901f0058 a01e0022
		 901f005c a01e000c 540007fe 2c000000
		 4182000c 38000001 48000008 38000000
		 901f0070 a01e000c 540007bc 2c000000
		 4182000c 38000001 48000008 38000000
		 901f0078 38000000 901f0060 38000000
		 901f0064 38000000 901f0068 38000000
		 901f006c 380000a0 901f0000 38000000
		 901f0004 38000000 901f0008 38000000
		 901f000c 38000000 901f0024 38000000
		 901f0020 38000000 901f0074 38000000
		 901f007c 38000000 901f0080 38000000
		 901f0084 38000000 901f0088 38000000
		 901f008c 38000000 901f0090 38000000
		 901f0094 38000000 901f0098 38000000
		 901f009c 5760063e 28000000 4182002c
		 80610040 80030008 901f0018 80610040
		 80030004 901f0014 80610040 8003000c
		 901f001c 4800001c 38000000 901f0018
		 38000000 901f0014 801f0010 901f001c
		 7f43d378 80010068 38210060 7c0803a6
		 bb41ffe8 4e800020 bfa1fff4 3bc0ffce
		 3be213f8 3ba00000 48000024 801f0000
		 7c001840 40820010 93e40000 3bc00000
		 48000014 3bff0010 3bbd0001 281d0004
		 4180ffdc 7fc3f378 bba1fff4 4e800020
		 bfa1fff4 3bc0ffce 3be213f8 38000000
		 90040000 3ba00000 48000028 801f000c
		 7c001840 40820014 801f0000 90040000
		 3bc00000 48000014 3bff0010 3bbd0001
		 281d0004 4180ffd8 7fc3f378 bba1fff4
		 4e800020 7c0802a6 bf61ffec 90010008
		 9421ffa0 7c7b1b78 7c9d2378 7cbf2b78
		 3b800000 7f63db78 4bffeb79 9061003c
		 7f63db78 4bffeb11 90610040 7fa3eb78
		 4bfff4a5 5460063e 28000000 41820050
		 7fa3eb78 38810040 38a1003c 4bfff825
		 7c600734 2c000000 4182000c 3860ffef
		 48000280 7fa3eb78 38810038 4bfffeed
		 7c600734 2c000000 4182000c 3860ffef
		 48000260 3bc0fffb 4800000c 3860ffef
		 48000250 881f0012 280000cd 4081000c
		 3860ffce 4800023c 881f0012 2800000a
		 4080000c 3860ffce 48000228 a01f0000
		 28007530 4081000c 3860ffce 48000214
		 a01f0000 280007d0 4080000c 3860ffce
		 48000200 a01f0002 280007f8 4081000c
		 3860ffce 480001ec a01f0002 28000008
		 4080000c 3860ffce 480001d8 a01f0004
		 28000ff8 4081000c 3860ffce 480001c4
		 a01f0006 280001f8 4081000c 3860ffce
		 480001b0 a01f0006 28000001 4080000c
		 3860ffce 4800019c a01f0008 280001f8
		 4081000c 3860ffce 48000188 a01f0008
		 28000008 4080000c 3860ffce 48000174
		 a01f000a 280007ff 4081000c 3860ffce
		 48000160 a01f000a 28000001 4080000c
		 3860ffce 4800014c a01f000c 280007ff
		 4081000c 3860ffce 48000138 a01f000e
		 2800001f 4081000c 3860ffce 48000124
		 a01f000e 28000001 4080000c 3860ffce
		 48000110 a01f0010 2800001f 4081000c
		 3860ffce 480000fc a01f0010 28000001
		 4080000c 3860ffce 480000e8 881f0012
		 80610040 b0030008 881f0013 80610040
		 b003000a 881f0014 80610040 b003000c
		 a01f0000 80610040 90030010 a01f0002
		 80610040 b0030014 a01f0004 80610040
		 b0030016 a01f0006 80610040 b0030018
		 a01f0008 80610040 b003001a a01f000a
		 80610040 b003001c a01f000c 80610040
		 b003001e a01f000e 80610040 b0030020
		 a01f0010 80610040 b0030022 38000000
		 80610038 90030008 80610038 93c3000c
		 80810040 8061003c 38a3fff8 3884fff8
		 38000004 7c0903a6 84640008 80040004
		 94650008 90050004 4200fff0 80040008
		 90050008 8061003c 93c30000 7f83e378
		 80010068 38210060 7c0803a6 bb61ffec
		 4e800020 28030000 4082000c 3860ffce
		 48000114 28040000 40820080 38000000
		 98030012 38000000 98030013 38000000
		 98030014 38000000 b0030000 38000000
		 b0030002 38000000 b0030004 38000000
		 b0030006 38000000 b0030008 38000000
		 b003000a 38000000 b003000c 38000000
		 b003000e 38000000 b0030010 38000000
		 98030015 38000000 98030016 38000000
		 98030017 4800008c a0040008 5400063e
		 98030012 a004000a 5400063e 98030013
		 a004000c 5400063e 98030014 80040010
		 5400043e b0030000 a0040014 b0030002
		 a0040016 b0030004 a0040018 b0030006
		 a004001a b0030008 a004001c b003000a
		 a004001e b003000c a0040020 b003000e
		 a0040022 b0030010 38000000 98030015
		 38000000 98030016 38000000 98030017
		 38600000 4e800020 7c0802a6 bf61ffec
		 90010008 9421ffa0 7c7b1b78 7c9e2378
		 7cbd2b78 3be00000 7f63db78 38800000
		 4bfffeb5 7fa3eb78 4bfff08d 5460063e
		 28000000 40820020 7fa3eb78 4bfff099
		 5460063e 28000000 4082000c 3860ffce
		 480000dc 281b0000 4182000c 281e0000
		 4082000c 3860ffce 480000c4 38000000
		 b01e0000 7fa3eb78 4bfff05d 5460063e
		 28000000 41820038 7fa3eb78 38810038
		 4bfffaf1 7c7f1b78 7fe00734 2c000000
		 4182000c 38000000 48000008 80010038
		 5400043e b01e0000 4800000c 57a0043e
		 b01e0000 7fe00734 2c000000 4082005c
		 a07e0000 3881003c 4bfffa61 7c7f1b78
		 7fe00734 2c000000 40820040 8061003c
		 80030008 28000000 40820030 386243a4
		 80630000 a09e0000 38a00080 4bffe4a9
		 7c7c1b78 281c0000 41820010 7f63db78
		 7f84e378 4bfffdb1 7fe3fb78 80010068
		 38210060 7c0803a6 bb61ffec 4e800020
		 93e1fffc 3be00000 80040010 28000001
		 4180000c 3860ffce 48000044 38621988
		 80040010 1c0000f0 38c4fff8 7ca30214
		 38a5fff8 3800001e 7c0903a6 84650008
		 80050004 94660008 90060004 4200fff0
		 38000001 90040018 7fe3fb78 83e1fffc
		 4e800020 7c0802a6 be41ffc8 90010008
		 9421ff80 7c721b78 7c932378 7cb42b78
		 7cdc3378 b0e100aa 38000000 90010038
		 7e439378 38821b50 38a10038 38c00004
		 4bffb969 60000000 7c751b78 7ea00734
		 2c000000 4182000c 38000000 90010038
		 8012010c 7c180734 7e800734 7c00e1d6
		 5400e8fe 5417f0be 7e800734 7c00e1d6
		 5400e8fe 541607be 3be00000 48000064
		 80010038 28000000 4182002c 38621b20
		 57e01838 7c03002e 7c1c0040 40820040
		 38821b20 57e31838 38030004 7fa4002e
		 48000038 38621af0 57e01838 7c03002e
		 7c1c0040 40820018 38821af0 57e31838
		 38030004 7fa4002e 48000010 3bff0001
		 281f0006 4180ff9c 3b400000 48000088
		 7fbeeb78 7e7b9b78 3be00000 48000028
		 93db0000 3b7b0004 281c0020 40820014
		 80010038 28000000 40820008 7fdef0f8
		 3bff0001 7c1fb840 4180ffd8 7f79db78
		 3be00000 4800001c 57c0463e 5400063e
		 98190000 3b390001 57de402e 3bff0001
		 7c1fb040 4180ffe4 7f000734 7e730214
		 80010038 28000000 40820008 7fbde8f8
		 3b5a0001 a80100aa 7c1a0040 4180ff74
		 38600000 80010088 38210080 7c0803a6
		 ba41ffc8 4e800020 bf21ffe4 80830090
		 3bc40040 3b630195 3b400000 48000140
		 3b200000 48000128 3ba00000 3b800000
		 8bfb0000 3b7b0001 57e0063e 540007bc
		 7c060e70 57e0063e 54000738 7c051670
		 57e0063e 54000630 7c042670 57e0063e
		 540006b4 7c001e70 7c800378 7ca00378
		 7cc00378 54002036 7fbd0378 57e0063e
		 540607fe 57e0063e 5400077a 7c050e70
		 57e0063e 54000672 7c041e70 57e0063e
		 540006f6 7c001670 7c800378 7ca00378
		 7cc00378 54002036 7f9c0378 8bfb0000
		 3b7b0001 57e0063e 540007bc 7c060e70
		 57e0063e 54000738 7c051670 57e0063e
		 54000630 7c042670 57e0063e 540006b4
		 7c001e70 7c800378 7ca00378 7cc00378
		 7fbd0378 57e607fe 57e0063e 5400077a
		 7c050e70 57e0063e 54000672 7c041e70
		 57e0063e 540006f6 7c001670 7c800378
		 7ca00378 7cc00378 7f9c0378 9bbe0000
		 9b9e0008 3bde0001 3b390001 2c190008
		 4180fed8 3bde0008 3b5a0001 2c1a0040
		 4180fec0 bb21ffe4 4e800020 7c0802a6
		 bee1ffdc 90010008 9421fb90 7c7f1b78
		 9081048c 3bc21b60 3b400000 3ba00000
		 381f0598 901e000c 38010040 901e0010
		 8061048c 38821b94 7fc5f378 4800e35d
		 80410014 547d063e 57a0063e 981f05b0
		 281d0000 4182000c 3ba00002 3b0000aa
		 281d0000 41820094 3b3f0195 3ae10040
		 3b800000 4800005c 3b600000 48000048
		 801e0004 7c1c0040 40800018 801e0008
		 5400083c 5400e8fe 7c1b0040 41800014
		 5700063e 98190000 3b390001 48000014
		 88170000 3af70001 98190000 3b390001
		 3b7b0001 281b0010 4180ffb8 3b9c0001
		 281c0040 4180ffa4 7fe3fb78 4bfffdbd
		 38000001 981f0194 7fe3fb78 48000049
		 60000000 48000028 38000000 981f0194
		 7fe3fb78 38800000 38a00000 38c00000
		 48000139 60000000 3b40ffef 7f43d378
		 80010478 38210470 7c0803a6 bae1ffdc
		 4e800020 7c0802a6 93e1fffc 90010008
		 9421ffc0 7c7f1b78 7fe3fb78 3880026c
		 a01f05a6 7c004670 5405063e 48000a31
		 60000000 7fe3fb78 3880026d a01f05a4
		 7c004670 5405063e 48000a15 60000000
		 7fe3fb78 3880026e a01f05a2 7c004670
		 5405063e 480009f9 60000000 7fe3fb78
		 38800270 a01f05ae 7c004670 5405063e
		 480009dd 60000000 7fe3fb78 38800271
		 a01f05ac 7c004670 5405063e 480009c1
		 60000000 7fe3fb78 38800272 a01f05aa
		 7c004670 5405063e 480009a5 60000000
		 7fe3fb78 38800264 38a007ff 48000aed
		 60000000 7fe3fb78 38800266 38a007ff
		 48000ad9 60000000 7fe3fb78 38800260
		 38a00008 48000b39 60000000 38000000
		 981f0194 80010048 38210040 7c0803a6
		 83e1fffc 4e800020 7c0802a6 bf41ffe8
		 90010008 9421ffb0 7c7d1b78 7c9b2378
		 7cbc2b78 90c10074 3bc00000 3be00000
		 3b400000 2c1b0000 40800010 7c1b00d0
		 541e043e 3b600000 2c1c0000 40800010
		 7c1c00d0 541f043e 3b800000 57c0043e
		 28000040 41800008 3bc0003f 57e0043e
		 28000040 41800008 3be0003f 80010074
		 28000000 40820014 3b6007ff 3b8007ff
		 3bc00000 3be00000 7fa3eb78 38800266
		 5765057e 48000a05 60000000 7fa3eb78
		 38800264 5785057e 480009f1 60000000
		 7fa3eb78 3880026a 57c506be 480009dd
		 60000000 7fa3eb78 38800268 57e506be
		 480009c9 60000000 57e0043e 28000000
		 41820010 57e02036 541a063e 48000008
		 3b400000 7fa3eb78 38800260 5745043e
		 38a50040 48000a09 60000000 7fa3eb78
		 38800052 38a00009 48000825 60000000
		 80010058 38210050 7c0803a6 bb41ffe8
		 4e800020 7c0802a6 90010008 9421ffc0
		 90610058 9081005c 80610058 3880ffff
		 8001005c 70050087 4bffd62d 60000000
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 bfc1fff8 90010008 9421ffc0
		 7c7f1b78 9081005c b0a10062 8061005c
		 3c03899e 28006c20 4182000c 3860ffef
		 48000074 7fe3fb78 38800044 38a00001
		 4800095d 60000000 7fe3fb78 38800044
		 38a00000 48000949 60000000 7fe3fb78
		 38800040 48000975 60000000 547e003c
		 a8010062 2c000000 4182000c 38000001
		 48000008 38000000 7fde0378 7fe3fb78
		 38800040 7fc5f378 48000905 60000000
		 38600000 80010048 38210040 7c0803a6
		 bbc1fff8 4e800020 7c0802a6 90010008
		 9421ffc0 90610058 b081005e 80610058
		 388000b2 a001005e 5405063e 480006f1
		 60000000 80010048 38210040 7c0803a6
		 4e800020 7c0802a6 90010008 9421ffc0
		 90610058 b081005e 80610058 388000b0
		 a001005e 5405063e 480006b5 60000000
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 b081005e b0a10062 b0c10066 80610058
		 388000b4 a0010066 7c064670 a001005e
		 7c004670 5405801e a0010062 7c004670
		 5400402e 7ca00378 7cc50378 48000821
		 60000000 80010048 38210040 7c0803a6
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421ffc0 90610058 9081005c 90a10060
		 90c10064 80610058 388000b4 4800081d
		 60000000 7c7e1b78 57df863e 57e0063e
		 5403402e 57e0063e 7c030214 8061005c
		 b0030000 57dfc63e 57e0063e 5403402e
		 57e0063e 7c030214 80610060 b0030000
		 57df063e 57e0063e 5403402e 57e0063e
		 7c030214 80610064 b0030000 80010048
		 38210040 7c0803a6 bbc1fff8 4e800020
		 7c0802a6 bfc1fff8 90010008 9421ffb0
		 7c9e2378 2c1e0000 41820028 7fdff378
		 38610038 7fe4fb78 4800da81 80410014
		 80610038 8081003c 4800da89 80410014
		 80010058 38210050 7c0803a6 bbc1fff8
		 4e800020 93e1fffc 3be00000 3be00000
		 3fe00001 3bff8000 7fe3fb78 83e1fffc
		 4e800020 93e1fffc 380400ff 541f002e
		 7fe3fb78 83e1fffc 4e800020 7c0802a6
		 bf21ffe4 90010008 9421ffa0 7c7f1b78
		 7c9d2378 7cb92b78 7cda3378 98e1008b
		 38000000 901f05bc 28190000 4182000c
		 933f0118 48000014 801d0000 28000036
		 41820008 93bf0118 935f0120 93bf011c
		 7fe3fb78 7f44d378 4bffda1d 60000000
		 7c7c1b78 38621bf8 5780103a 7fc3002e
		 93df0124 281e0008 41810010 38000000
		 981f0115 4800000c 38000001 981f0115
		 7fe3fb78 a01d0014 7c00f1d6 5404e8fe
		 4bffff45 907f010c 801f010c 54001838
		 7c00f396 901f013c 93df0108 83bf0118
		 7fe3fb78 809f010c 4bfffefd 907f0138
		 7fe3fb78 7f84e378 38a00000 4bffd279
		 60000000 7c7b1b78 807d0000 4800cc29
		 60000000 5460063e 28000000 41820018
		 7fe3fb78 38800001 4800876d 60000000
		 4800002c 7fe3fb78 7fa4eb78 80bf0138
		 801f013c 5406043e 7fc70774 7f68db78
		 8921008b 480087c5 60000000 80010068
		 38210060 7c0803a6 bb21ffe4 4e800020
		 7c0802a6 bf41ffe8 90010008 9421ffa0
		 7c7f1b78 7c9b2378 83db0000 93c10038
		 38000000 981f0674 801f05f0 901f0678
		 801f05f0 901f067c 38000000 981f061c
		 38000000 981f061d 3ba00000 3b800000
		 3b400000 7fe3fb78 48009f95 60000000
		 7fc3f378 4800cb99 60000000 5460063e
		 28000000 4182001c 3ba00001 38000001
		 981f061c 801f05f0 901f0678 480001dc
		 7fc3f378 4800cbe9 60000000 5460063e
		 28000000 41820024 3ba00001 38000001
		 981f0674 38000001 981f061c 801f0620
		 901f0678 480001a4 7fc3f378 4800cb51
		 60000000 5460063e 28000000 4182001c
		 3ba00001 38000001 981f061c 801f0610
		 901f0678 48000174 7fc3f378 4800cb61
		 60000000 5460063e 28000000 41820018
		 3ba00001 38000001 981f061c 937f0678
		 48000148 7fc3f378 4800cb75 60000000
		 5460063e 28000000 4182001c 3ba00001
		 38000001 981f061c 801f0618 901f0678
		 48000118 7fc3f378 4800cb65 60000000
		 5460063e 28000000 4182001c 3ba00001
		 3b800001 937f0678 38000001 981f061c
		 480000e8 7fc3f378 4800cb55 60000000
		 5460063e 28000000 4182001c 3ba00001
		 3b800001 937f0678 38000001 981f061d
		 480000b8 7fc3f378 4800ca25 60000000
		 5460063e 28000000 41820024 3ba00001
		 3b800001 881f062c 28000001 4082008c
		 38000001 981f0607 48000080 7fc3f378
		 4800c9d5 60000000 5460063e 28000000
		 41820014 3ba00000 3b800000 3b400000
		 48000058 7fc3f378 4800ca25 60000000
		 5460063e 28000000 4182000c 3b800001
		 48000038 7fc3f378 4bffe1fd 60000000
		 5460063e 28000000 4082001c 7fc3f378
		 4bffe205 60000000 5460063e 28000000
		 41820008 3b800001 9b9f0682 9bbf0681
		 9b5f0683 7fe3fb78 48009d75 60000000
		 80010068 38210060 7c0803a6 bb41ffe8
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421ffc0 7c7f1b78 7c9e2378 90a10060
		 90c10064 98e1006b 7fe3fb78 38821c10
		 80be0000 4800cf89 60000000 7fe3fb78
		 7fc4f378 4bfffd2d 881f0004 28000000
		 40820020 881f05c9 28000000 40820014
		 7fe3fb78 38800000 48009ff9 60000000
		 881f0004 28000000 40820020 881f05c9
		 28000000 40820014 7fe3fb78 38800000
		 48009d3d 60000000 7fe3fb78 7fc4f378
		 80a10060 80c10064 88e1006b 4bfffb71
		 7fe3fb78 809f067c 80bf0678 7fc6f378
		 4800a6b9 60000000 7fe3fb78 809f05f0
		 7fc5f378 801f0124 5406063e 4800a539
		 60000000 7fe3fb78 809f05f0 7fc5f378
		 4800a5f1 60000000 7fe3fb78 889f0682
		 48009f61 60000000 7fe3fb78 889f0681
		 48009cbd 60000000 80010048 38210040
		 7c0803a6 bbc1fff8 4e800020 7c0802a6
		 90010008 9421ffc0 90610058 b081005e
		 98a10063 88810063 80610058 80630094
		 a001005e 7c8301ae 4800d4c9 80410014
		 80010048 38210040 7c0803a6 4e800020
		 80a30094 5480043e 7c6500ae 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 80010060 5403043e
		 4800d781 80410014 80810058 8001005c
		 7c64032e 4800d46d 80410014 80010048
		 38210040 7c0803a6 4e800020 7c0802a6
		 90010008 9421ffc0 90610058 9081005c
		 90a10060 80610060 4800d421 80410014
		 80810058 8001005c 7c64012e 4800d425
		 80410014 80010048 38210040 7c0803a6
		 4e800020 7c0802a6 90010008 9421ffc0
		 90610058 9081005c 80610058 8001005c
		 7c63022e 4800d6ed 80410014 5463043e
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 80610058 8001005c 7c63002e
		 4800d399 80410014 80010048 38210040
		 7c0803a6 4e800020 7c0802a6 90010008
		 9421ffc0 90610058 b081005e b0a10062
		 80610058 80630094 a081005e a0a10062
		 4bfffed1 80010048 38210040 7c0803a6
		 4e800020 7c0802a6 90010008 9421ffc0
		 90610058 b081005e 80610058 80630094
		 a081005e 4bffff31 5463043e 80010048
		 38210040 7c0803a6 4e800020 7c0802a6
		 90010008 9421ffc0 90610058 b081005e
		 90a10060 80610058 80630094 a081005e
		 80a10060 4bfffea9 80010048 38210040
		 7c0803a6 4e800020 7c0802a6 90010008
		 9421ffc0 90610058 b081005e 80610058
		 80630094 a081005e 4bfffef9 80010048
		 38210040 7c0803a6 4e800020 7c0802a6
		 bf41ffe8 90010008 9421ff90 7c7d1b78
		 7c9e2378 90a10090 90c10094 7cfa3b78
		 3b800000 3be00000 480001d4 38622308
		 38a10030 3883fff8 38000003 7c0903a6
		 84640008 80040004 94650008 90050004
		 4200fff0 80040008 90050008 80610038
		 1c1f001c 7c1e002e 7c030000 4082018c
		 8081003c 1c7f001c 38030004 7c1e002e
		 7c040000 40820174 80810040 1c7f001c
		 38030008 7c1e002e 7c040000 4082015c
		 80810044 1c7f001c 3803000c 7c1e002e
		 7c040000 40820144 80810048 1c7f001c
		 38030010 7c1e002e 7c040000 4082012c
		 8081004c 1c7f001c 38030014 7c1e002e
		 7c040000 40820114 80810050 1c7f001c
		 38030018 7c1e002e 7c040000 408200fc
		 1c1f001c 7c1e002e 5400a016 80610094
		 90030000 7fa3eb78 388000f8 1c1f001c
		 7c1e002e 5405a016 4bfffe65 60000000
		 1c7f001c 38030018 7c1e002e 5403a016
		 1c9f001c 38040014 7c1e002e 5400801e
		 1c9f001c 38840010 7c9e202e 5487402e
		 1c9f001c 3884000c 7c9e202e 54863830
		 1c9f001c 38840004 7cbe202e 1c9f001c
		 38840008 7c9e202e 54842036 7ca42378
		 7cc42378 7ce42378 7c002378 7c7b0378
		 7fa3eb78 38800148 7f65db78 4bfffde1
		 60000000 7fa3eb78 48006e49 60000000
		 3b800001 57e0103a 7c7a002e 4800d12d
		 80410014 7c661b78 7fa3eb78 38822324
		 57e0103a 7cba002e 38c60001 4bffa665
		 60000000 48000014 3bff0001 80010090
		 7c1f0000 4180fe28 7f83e378 80010078
		 38210070 7c0803a6 bb41ffe8 4e800020
		 7c0802a6 bf41ffe8 90010008 9421ff90
		 7c7f1b78 3882232c 80640000 80040004
		 90610042 90010046 a0040008 b001004a
		 38822336 80640000 80040004 90610038
		 9001003c a0040008 b0010040 3b800000
		 a8c10042 a8010044 5405801e a8010046
		 54049818 a801004a 5403f800 a8010048
		 5400a016 7c600378 7c800378 7ca00378
		 7cdb0378 a8c10038 a801003a 5405801e
		 a801003c 54049818 a8010040 5403f800
		 a801003e 5400a016 7c600378 7c800378
		 7ca00378 7cda0378 3bc21c1c 3ba0000e
		 7fe3fb78 38800158 7f65db78 4bfffca1
		 60000000 7fe3fb78 38800034 48006fb1
		 60000000 5460072e 60050080 7fe3fb78
		 38800034 48006e81 60000000 7fe3fb78
		 38800004 48006f89 60000000 60650040
		 7fe3fb78 38800004 48006e5d 60000000
		 7fe3fb78 7fc4f378 7fa5eb78 38c10050
		 38e22110 4bfffca9 7c7c1b78 5780063e
		 28000000 40820060 3bc21da4 3ba00015
		 7fe3fb78 38800158 7f45d378 4bfffc11
		 60000000 7fe3fb78 38800004 48006f21
		 60000000 546506b0 7fe3fb78 38800004
		 48006df5 60000000 7fe3fb78 7fc4f378
		 7fa5eb78 38c10050 38e222b4 4bfffc41
		 7c7c1b78 80610050 38038000 901f00a0
		 80010078 38210070 7c0803a6 bb41ffe8
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421feb0 7c7f1b78 3bc00000 38000001
		 90010040 38000001 90010038 38000000
		 9001003c 800200dc 901f015c 800200d8
		 901f0158 38610038 7fe4fb78 480069dd
		 60000000 7c7e1b78 7fc00734 2c000000
		 40820018 8801005c 54000630 2c000000
		 41820008 3bc0ffed 7fc00734 2c000000
		 40820010 38000001 981f0684 4800000c
		 38000000 981f0684 7fc00734 2c000000
		 41820028 800200d4 901f015c 800200d0
		 901f0158 38610038 7fe4fb78 4800696d
		 60000000 7c7e1b78 7fc00734 2c000000
		 40820020 7fe3fb78 38822340 38a10048
		 38c00080 4bffa38d 60000000 48000014
		 387f0038 38822345 4800ce39 80410014
		 7fc00734 2c000000 418200e8 38000001
		 90010040 38000001 90010038 38000001
		 9001003c 800200dc 901f015c 800200d8
		 901f0158 38610038 7fe4fb78 480068ed
		 60000000 7c7e1b78 7fc00734 2c000000
		 40820018 88010089 7c002670 2c000002
		 40810008 3bc0ffed 7fc00734 2c000000
		 40820010 38000001 981f0684 4800000c
		 38000000 981f0684 7fc00734 2c000000
		 41820028 800200d4 901f015c 800200d0
		 901f0158 38610038 7fe4fb78 4800687d
		 60000000 7c7e1b78 7fc00734 2c000000
		 40820020 7fe3fb78 3882234a 38a10048
		 38c00100 4bffa29d 60000000 48000014
		 387f0038 38822350 4800cd49 80410014
		 7fc3f378 80010158 38210150 7c0803a6
		 bbc1fff8 4e800020 7c0802a6 bfa1fff4
		 90010008 9421ff90 7c7f1b78 387f0038
		 38800000 38a10050 4800cbd1 80410014
		 7c7e1b78 387f0038 38800008 38a1004c
		 4800cc31 80410014 7c7e1b78 80010050
		 901f0054 387f0038 38800004 38a10050
		 4800cb99 80410014 7c7e1b78 80010050
		 60000002 90010050 387f0038 38800004
		 80a10050 4800cc05 80410014 7c7e1b78
		 801f0054 5403843e 8801004c 5400c00e
		 7c600378 901f0054 8801004c 981f0050
		 38000000 981f0058 38000001 981f0030
		 38000000 981f0059 38000000 981f005a
		 807f0034 809f0090 3ca00800 38a5ffff
		 38c00001 4800cbbd 80410014 807f0034
		 809f0094 38a03fff 38c00001 4800cba5
		 80410014 881f0030 28000000 41820018
		 7fe3fb78 38800104 4bfff8d1 60000000
		 907f008c 7fe3fb78 38800104 4bfff8bd
		 60000000 907f0098 7fe3fb78 3880010c
		 4bfff8a9 60000000 907f009c 7fe3fb78
		 388000e0 38a00000 4bfff855 60000000
		 7fe3fb78 48007849 60000000 881f0004
		 28000000 40820034 881f05c9 28000000
		 40820028 7fe3fb78 48007599 60000000
		 7fe3fb78 48007fed 60000000 7fe3fb78
		 4bfffaa1 48000010 7fe3fb78 480084cd
		 60000000 7fe3fb78 38822356 38bf00a0
		 38c00004 4bffa0ad 60000000 881f0004
		 28000000 40820020 881f05c9 28000000
		 40820014 7fe3fb78 48007669 60000000
		 987f0153 881f05c8 28000000 40820010
		 881f0160 28000000 4182000c 38000001
		 981f0153 7fe3fb78 388203c8 38bf0153
		 38c00001 4bffa04d 60000000 38000000
		 981f0684 7fe3fb78 4bfffbcd 7c630734
		 38000000 7c000734 7c030050 7c000034
		 5400d97e 5400063e 981f0154 881f0153
		 28000000 41820038 881f0154 28000000
		 4082002c 7fe3fb78 4bfffb8d 7c630734
		 38000000 7c000734 7c030050 7c000034
		 5400d97e 5400063e 981f0154 7fe3fb78
		 389f0151 38bf0152 4bffcda5 60000000
		 881f0151 5403402e 881f0152 7c600378
		 90010038 7fe3fb78 38822362 38a10038
		 38c00004 4bff9f9d 60000000 7fe3fb78
		 4800b9b9 60000000 38000001 981f0624
		 38000003 901f00f8 38000001 901f00fc
		 7fe3fb78 38800110 4bfff6e1 60000000
		 7c7d1b78 7fe3fb78 3880010c 4bfff6cd
		 60000000 90610050 80010050 901f007c
		 38000000 901f0080 80010050 28000000
		 418200b8 807f0034 80810050 7fa5eb78
		 38c00003 4800c94d 80410014 7c7e0734
		 7fc00734 2c000000 40820090 807f0034
		 80810050 38a00400 38c00000 38e10040
		 4800c9c9 80410014 7c7e0734 7fc00734
		 2c000000 40820020 80010048 540005ee
		 28000000 41820054 38000031 901f0080
		 48000048 807f0034 80810050 38a00400
		 38c00001 38e10040 4800c981 80410014
		 7c7e0734 7fc00734 2c000000 4082001c
		 80010048 540005ee 28000000 4182000c
		 38000031 901f0080 387f0038 38800030
		 38a10050 4800c7f5 80410014 7c7e1b78
		 80010050 901f0084 38000000 901f0088
		 80010050 28000000 4182001c 80010050
		 540007fe 28000001 4082000c 38000023
		 901f0088 80010078 38210070 7c0803a6
		 bba1fff4 4e800020 38600000 4e800020
		 7c0802a6 bf61ffec 90010008 9421ff50
		 7c7c1b78 7c9f2378 807f0100 4bffd3d9
		 60000000 5460063e 28000000 4082001c
		 807f0100 4bffd3e1 60000000 5460063e
		 28000000 41820070 801f0100 90010038
		 807f0100 4bffd3c1 60000000 5460063e
		 28000000 41820028 80610038 38810038
		 4bffde51 60000000 7c600734 2c000000
		 4182000c 3860ffef 480001ac 80610038
		 3881003c 4bffdde5 60000000 8061003c
		 80030008 28000000 4182000c 3860ffef
		 48000184 7fe3fb78 809f0100 7f85e378
		 4bffc835 60000000 7c7e1b78 281e0000
		 4082000c 3860ffef 4800015c 807f011c
		 7fc4f378 4bffd359 60000000 5460063e
		 28000000 41820010 93df011c 3ba00000
		 48000008 3ba00001 57a0063e 28000000
		 40820018 801f0120 7c00e040 4082000c
		 38600000 48000110 939f0104 7fe3fb78
		 4bffc389 60000000 7fe3fb78 7fc4f378
		 38a00000 80df0104 7fa7eb78 4bfff109
		 60000000 801f0170 28000000 41820030
		 38610040 7fe4fb78 48002745 60000000
		 38610040 809f0174 38a00000 819f0170
		 4800ca39 80410014 7c7b1b78 801f017c
		 28000000 41820030 38610040 7fe4fb78
		 4800270d 60000000 38610040 809f0180
		 38a00000 819f017c 4800ca01 80410014
		 7c7b1b78 801f0104 5400043e b01f0060
		 801f0100 5400043e b01f005c 801f0140
		 5400063e 981f0062 38000001 981f05ca
		 881f0151 981f05cb 881f0152 981f05cc
		 801f0100 5400c63e 981f05cd 801f0100
		 5400063e 981f05ce 881f0063 981f05cf
		 7fe3fb78 389f05ca 4bffbd3d 60000000
		 38600000 800100b8 382100b0 7c0803a6
		 bb61ffec 4e800020 7c0802a6 bfa1fff4
		 90010008 9421ffb0 7c7e1b78 7c9f2378
		 a81e0006 2c000000 4182000c 3860ffce
		 48000028 a87e0000 7fe4fb78 4bfffd85
		 7c7d1b78 807f008c 801f0138 7c030214
		 901e0008 7fa3eb78 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 bf81fff0 90010008 9421ffb0 7c7d1b78
		 7c9f2378 839f0100 801d0002 901f0100
		 a07d0000 7fe4fb78 4bfffd29 7c7e1b78
		 7fc00734 2c000000 41820008 939f0100
		 807f008c 801f0138 7c030214 901d0008
		 7fc3f378 80010058 38210050 7c0803a6
		 bb81fff0 4e800020 7c0802a6 bec1ffd8
		 90010008 9421f7a0 7c7a1b78 7c9c2378
		 881c0115 28000000 4182000c 3860ffef
		 480001d4 801a0000 28000000 4082000c
		 3860ffef 480001c0 ab3a0004 83da0000
		 a87a0006 3ba30001 7fa30734 7f200734
		 7c030214 2c000100 4081000c 3860ffef
		 48000194 881c0114 28000000 418200fc
		 3be00000 480000bc 7fe00734 54031838
		 38030002 7c1e022e 1f004ccc 7fe00734
		 54031838 38030004 7c1e022e 3c600001
		 3863970a 7ee019d6 7fe00734 54031838
		 38030006 7c1e022e 1ec01c29 7f77b214
		 7f78da14 577b843e 7fe00734 54001838
		 7c9e02ae 7fe00734 54001838 38610038
		 7c83032e 5765043e 7fe00734 54041838
		 38610038 38040002 7ca3032e 5765043e
		 7fe00734 54041838 38610038 38040004
		 7ca3032e 5765043e 7fe00734 54041838
		 38610038 38040006 7ca3032e 3bff0001
		 7fe30734 7fa00734 7c030000 4180ff3c
		 801c016c 28000000 41820090 7fa3eb78
		 38810038 38a10038 80dc016c 48000571
		 60000000 48000074 801c016c 28000000
		 41820020 7fa3eb78 7fc4f378 38a10038
		 80dc016c 48000549 60000000 4800004c
		 3be00000 48000034 7fe00734 54041838
		 7fe00734 54031838 38010038 7ca01a14
		 7c9e2214 80640000 80040004 90650000
		 90050004 3bff0001 7fe30734 7fa00734
		 7c030000 4180ffc4 7f83e378 7f24cb78
		 7fa5eb78 38c10038 4bffc111 60000000
		 38600000 80010868 38210860 7c0803a6
		 bac1ffd8 4e800020 7c0802a6 bf41ffe8
		 90010008 9421ffb0 7c7a1b78 7c9c2378
		 801a0000 28000000 40820078 801c016c
		 28000000 4082000c 3860ffef 4800016c
		 83fc016c 38000000 b01f0000 38000000
		 b01f0002 38000000 b01f0004 38000001
		 b01f0006 38000100 b01f0008 38000008
		 b01f000a 3ba00000 48000018 7fa40774
		 57a3043e 3803000c 7c9f01ae 3bbd0001
		 57a0043e 28000100 4180ffe4 480000ec
		 83da0000 a81e0000 2c000000 4182000c
		 3860ffef 480000f4 a81e0002 2c000000
		 4182000c 3860ffef 480000e0 a81e0006
		 2c000001 41820018 a81e0006 2c000003
		 4182000c 3860ffef 480000c0 a81e000a
		 2c000008 4182000c 3860ffef 480000ac
		 801c016c 28000000 4082000c 3860ffef
		 48000098 83fc016c a81e0000 b01f0000
		 a81e0002 b01f0002 a81e0004 b01f0004
		 a81e0006 b01f0006 a81e0008 b01f0008
		 a81e000a b01f000a a87e0008 a81e0006
		 7f6301d6 3ba00000 48000020 57a3043e
		 3803000c 7c9e00ae 57a3043e 3803000c
		 7c9f01ae 3bbd0001 57a3043e 5760043e
		 7c030040 4180ffd8 881c0115 28000000
		 41820014 7f83e378 7fe4fb78 4bffc0fd
		 60000000 38600000 80010058 38210050
		 7c0803a6 bb41ffe8 4e800020 7c0802a6
		 93e1fffc 90010008 9421ffc0 90610058
		 7c9f2378 80610058 a8030006 2c000000
		 4182000c 3860ffef 48000050 7fe3fb78
		 809f008c 801f0138 7c840214 80bf011c
		 a8a50014 80df0108 80ff011c a8e7001c
		 4bffddb5 60000000 881f0115 28000000
		 41820014 7fe3fb78 809f016c 4bffc06d
		 60000000 38600000 80010048 38210040
		 7c0803a6 83e1fffc 4e800020 88040115
		 28000000 41820014 38000001 98040114
		 38600000 48000034 88040150 28000000
		 40820024 88030000 28000001 40820010
		 38000001 98040114 4800000c 38000000
		 98040114 38600000 4e800020 7c0802a6
		 93e1fffc 90010008 9421ffc0 90610058
		 7c9f2378 80610058 a8030000 7c030734
		 38000000 7c000734 7c030050 7c000034
		 5400d97e 5400063e 981f00e4 7fe3fb78
		 3c807662 38846c20 88bf00e4 4bffe3a5
		 60000000 38600000 80010048 38210040
		 7c0803a6 83e1fffc 4e800020 7c0802a6
		 bf61ffec 90010008 9421f7b0 7c7d1b78
		 7c9c2378 881c0115 28000000 4082000c
		 3860ffef 480000d0 801d0000 28000000
		 4082000c 3860ffef 480000bc ab7d0004
		 a87d0006 3be30001 57e3043e 7f600734
		 7c030214 2c000100 4081000c 3860ffef
		 48000094 801c016c 28000000 41820020
		 7fe3fb78 809d0000 38a10038 80dc016c
		 4800013d 60000000 48000050 3bc00000
		 48000038 80dd0000 57c0043e 54041838
		 57c0043e 54031838 38010038 7ca01a14
		 7c862214 80640000 80040004 90650000
		 90050004 3bde0001 57c3043e 57e0043e
		 7c030040 4180ffc0 7f83e378 7f64db78
		 7fe5fb78 38c10038 4bffbd01 60000000
		 38600000 80010858 38210850 7c0803a6
		 bb61ffec 4e800020 7c0802a6 bfa1fff4
		 90010008 9421ffb0 7c7d1b78 7c9f2378
		 881d0000 b01f0060 7fe3fb78 389f005c
		 38a00001 4bffb3c9 60000000 7c7e1b78
		 7fe3fb78 3882236c 38bf005c 38c00020
		 4bff9491 60000000 881d0000 5400c63e
		 981f05cd 881d0000 5400063e 981f05ce
		 38000001 981f05ca 881f0151 981f05cb
		 881f0152 981f05cc 881f0063 981f05cf
		 7fe3fb78 389f05ca 4bffb59d 60000000
		 7c7e1b78 7fc3f378 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 bf21ffe4
		 3be00000 48000080 57e0043e 54001838
		 7ce402ae 57e0043e 54001838 7ce5032e
		 57e0043e 54071838 38070002 7d04022e
		 57e0043e 54071838 38070002 7d05032e
		 57e0043e 54071838 38070004 7d04022e
		 57e0043e 54071838 38070004 7d05032e
		 57e0043e 54071838 38070006 7d04022e
		 57e0043e 54071838 38070006 7d05032e
		 3bff0001 57e7043e 5460043e 7c070040
		 4180ff78 3bc6000c a8060004 7fde0214
		 a8060006 2c000001 4082000c 7fdaf378
		 7fd9f378 a8060006 2c000003 40820014
		 a8060008 7f5e0214 a8060008 7f3a0214
		 3be00000 48000164 57e0043e 54071838
		 38070002 7fa5022e 57a7043e 38000008
		 5400043e 7ce00630 541d043e 57e0043e
		 54071838 38070002 7c05022e 54000630
		 2c000000 41820014 57a0043e 280000ff
		 41820008 3bbd0001 57e0043e 54071838
		 38070004 7f85022e 5787043e 38000008
		 5400043e 7ce00630 541c043e 57e0043e
		 54071838 38070004 7c05022e 54000630
		 2c000000 41820014 5780043e 280000ff
		 41820008 3b9c0001 57e0043e 54071838
		 38070006 7f65022e 5767043e 38000008
		 5400043e 7ce00630 541b043e 57e0043e
		 54071838 38070006 7c05022e 54000630
		 2c000000 41820014 5760043e 280000ff
		 41820008 3b7b0001 57a0043e 7c1e00ae
		 7c000774 5400402e 5408043e 57e0043e
		 54071838 38070002 7d05032e 5780043e
		 7c1a00ae 7c000774 5400402e 5408043e
		 57e0043e 54071838 38070004 7d05032e
		 5760043e 7c1900ae 7c000774 5400402e
		 5408043e 57e0043e 54071838 38070006
		 7d05032e 3bff0001 57e7043e 5460043e
		 7c070040 4180fe94 bb21ffe4 4e800020
		 7c0802a6 bfc1fff8 90010008 9421ffb0
		 7c7e1b78 7c9f2378 38000000 b0010038
		 a01e0000 b01f0060 801e0002 5400043e
		 b01f005c 801f0140 5400063e 981f0062
		 38000001 981f05ca 881f0151 981f05cb
		 881f0152 981f05cc 801e0002 5400c63e
		 981f05cd 801e0002 5400063e 981f05ce
		 881f0063 981f05cf 881f0629 28000001
		 4082001c 881f0600 981f05cb 881f0601
		 981f05cc 881f0663 981f05cf 7fe3fb78
		 389f05ca 4bffb281 60000000 881f0151
		 981f005e 881f0152 981f005f 881f0629
		 28000001 4082001c 881f0600 981f005e
		 881f0601 981f005f 881f0663 981f0063
		 387f0064 389f005c 80be0002 4bffd60d
		 60000000 7fe3fb78 38822377 38bf005c
		 38c00020 4bff90cd 60000000 7fe3fb78
		 389f005c 38a00001 4bffafd5 60000000
		 80010058 38210050 7c0803a6 bbc1fff8
		 4e800020 7c0802a6 bfa1fff4 90010008
		 9421ffb0 7c7e1b78 7c9d2378 8bfe0001
		 57e0063e 28000000 40820008 3be00003
		 887e0000 3800ff78 7c600038 2c000000
		 40820018 887e0001 3800ff78 7c600038
		 2c000000 4182000c 3860ffce 4800003c
		 881d0134 7c03f878 881e0000 7c00f838
		 70000087 7c600378 981d0134 7fa3eb78
		 889d0134 4bffdd81 60000000 38000000
		 981e0001 38600000 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 90010008 9421ffc0 90610058 9081005c
		 8061005c 80810058 80840000 4bffd9b1
		 60000000 80010048 38210040 7c0803a6
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421ffc0 7c7f1b78 7c9e2378 881e05b0
		 28000000 4182003c 801f0000 901e05b4
		 801f0004 901e05b8 801f0008 901e05bc
		 7fc3f378 809f0000 80bf0004 80df0008
		 4bffdb99 60000000 38600000 48000008
		 3860ffef 80010048 38210040 7c0803a6
		 bbc1fff8 4e800020 7c0802a6 bfc1fff8
		 90010008 9421ffc0 7c7e1b78 3be0ffce
		 801e0000 28000000 41820010 801e0000
		 28000001 40820014 7fc3f378 4bffc35d
		 60000000 7c7f1b78 7fe3fb78 80010048
		 38210040 7c0803a6 bbc1fff8 4e800020
		 80a30000 80030004 90a40170 90040174
		 38600000 4e800020 93e1fffc 3be00000
		 80030000 28000014 40820034 38e40170
		 38c3fff8 38000002 7c0903a6 84a60008
		 80060004 94a70008 90070004 4200fff0
		 80060008 90070008 48000008 3be0ffce
		 7fe3fb78 83e1fffc 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ffb0 7c7d1b78
		 9081006c a81d0000 2c000000 4182000c
		 38000000 48000008 38000001 7c1f0734
		 83dd0002 8061006c 7fc4f378 7fe5fb78
		 4bffdbe1 60000000 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ffb0 7c7d1b78
		 7c9e2378 7fa3eb78 7fc4f378 48007b29
		 60000000 7c7f1b78 7fe00734 2c000000
		 40820014 801d0000 901e00f8 801e00fc
		 901d0004 7fe3fb78 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 dbe1fff8 bf61ffdc 90010008 9421ff90
		 7c7f1b78 7c9e2378 3ba00000 3b600000
		 281f0000 4082000c 3860ffce 48000354
		 881e0626 28000000 4082000c 3860ffef
		 48000340 839f0010 7f83e378 4bffc359
		 60000000 5460063e 28000000 4082000c
		 3860ffce 4800031c 807f0028 809f002c
		 480045fd ffe00890 c80203e0 ffff0024
		 c80203d8 fc1f0040 4081000c 3860ffce
		 480002f0 c80203d0 fc1f0040 4080000c
		 3860ffce 480002dc 807f0040 801f0044
		 7c030214 28000ff8 4081000c 3860ffce
		 480002c0 807f0040 801f0044 7c030214
		 28000008 4080000c 3860ffce 480002a4
		 801f0040 280007f8 4081000c 3860ffce
		 48000290 801f0040 28000008 4080000c
		 3860ffce 4800027c 801f0040 5400077e
		 28000000 4182000c 3860ffce 48000264
		 807f0048 801f0044 7c030040 4081000c
		 3860ffce 4800024c 801f0048 280001f8
		 4081000c 3860ffce 48000238 801f0048
		 28000001 4080000c 3860ffce 48000224
		 801f004c 280001f8 4081000c 3860ffce
		 48000210 801f004c 28000008 4080000c
		 3860ffce 480001fc 801f004c 5400077e
		 28000000 4182000c 3860ffce 480001e4
		 807f0050 801f0054 7c030214 280007ff
		 4081000c 3860ffce 480001c8 807f0050
		 801f0054 7c030214 28000001 4080000c
		 3860ffce 480001ac 801f0050 280007ff
		 4081000c 3860ffce 48000198 801f0050
		 28000001 4080000c 3860ffce 48000184
		 807f0058 801f0054 7c030040 4081000c
		 3860ffce 4800016c 801f0058 2800001f
		 4081000c 3860ffce 48000158 801f0058
		 28000001 4080000c 3860ffce 48000144
		 801f005c 2800001f 4081000c 3860ffce
		 48000130 801f005c 28000001 4080000c
		 3860ffce 4800011c 801f0020 54000630
		 28000000 4182000c 3860ffce 48000104
		 801f0020 540006f6 28000000 4182000c
		 3860ffce 480000ec 7f83e378 3881003c
		 38a10038 4bffc49d 60000000 801e0100
		 7c1c0040 41820018 80610038 80630000
		 801e0100 7c030040 4082005c 809f001c
		 80610038 80030000 7c040040 4182000c
		 3860d54e 4800009c 809f0040 8061003c
		 a0030014 7c040040 4182000c 3860d54e
		 48000080 809f0050 8061003c a003001c
		 7c040040 4182000c 3860d54e 48000064
		 3b600001 7fc3f378 7fe4fb78 4bffc4dd
		 60000000 7c7d1b78 7fa00734 2c000000
		 4082003c 5760063e 28000001 40820030
		 7fc3f378 38800000 4bffaf0d 60000000
		 7fc3f378 8081003c 38a00000 80de0104
		 38e00001 4bffde91 60000000 7fa3eb78
		 80010078 38210070 cbe1fff8 7c0803a6
		 bb61ffdc 4e800020 7c0802a6 bfa1fff4
		 90010008 9421ffb0 7c7f1b78 7c9d2378
		 3bc00000 801f0000 2c000000 4182000c
		 3860d54a 48000104 801f0014 28000001
		 40820044 801f0018 28000000 4082000c
		 3860ffce 480000e4 801f0010 5400063c
		 901f0010 801f0010 5403063e 809f0018
		 80bf001c 7fa6eb78 4800b0fd 60000000
		 7c7e1b78 801f0014 28000000 41820020
		 801f0024 28000000 41820014 7fa3eb78
		 38800028 4bffd95d 60000000 7fc00734
		 2c000000 40820080 801f0024 28000000
		 41820074 801f0028 28000000 4082000c
		 3860ffce 48000064 801f0020 60000001
		 901f0020 801f0024 28000001 40820028
		 801f0020 5403063e 809f0028 80bf002c
		 7fa6eb78 4800b071 60000000 7c7e1b78
		 48000024 801f0020 5403063e 809f0028
		 80bf002c 7fa6eb78 4800aeed 60000000
		 7c7e1b78 7fc3f378 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 38000001
		 b0030006 38600000 4e800020 80040110
		 7c000734 b0030006 80040104 7c000734
		 b0030000 80a4008c 80040138 7c050214
		 90030008 38600000 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ffb0 7c7f1b78
		 7c9d2378 801f0000 28000000 4082000c
		 3860ffee 480000e0 7fa3eb78 809d0104
		 4bffb319 60000000 2c030010 41820028
		 40800010 2c030008 41820014 48000028
		 2c030020 41820018 4800001c 3bc00100
		 4800001c 3bc00020 48000014 3bc00100
		 4800000c 3860ffee 4800008c a81f0004
		 2c000000 41800028 a89f0004 a87f0006
		 38030001 7c640214 7fc00734 7c030000
		 4081000c 3860ffee 4800005c a81f0004
		 2c00ffff 40820020 a87f0006 38630001
		 7fc00734 7c030000 4081000c 3860ffee
		 48000034 a81f0004 2c00ffff 4080000c
		 3860ffee 48000020 7fa3eb78 a89f0004
		 a8bf0006 38a50001 80df0000 4bfface5
		 60000000 80010058 38210050 7c0803a6
		 bba1fff4 4e800020 38000000 90030008
		 a8030006 2c000000 4082001c 80a4008c
		 80040138 7c050214 90030008 38600000
		 48000008 3860ffee 4e800020 88040114
		 28000000 41820010 38000001 98030000
		 4800000c 38000000 98030000 38600000
		 4e800020 880400e4 28000000 41820010
		 38000000 b0030000 4800000c 38000001
		 b0030000 38600000 4e800020 38000000
		 90030000 8004016c 28000000 4182000c
		 8004016c 90030000 38600000 4e800020
		 a0040060 5400063e 98030000 38600000
		 4e800020 80040104 5400043e b0030000
		 80040100 90030002 38000000 b0030006
		 80a4008c 80040138 7c050214 90030008
		 38000000 9003000c 38600000 4e800020
		 a0040060 b0030000 a004005c 90030002
		 38000000 90030008 38600000 4e800020
		 7c0802a6 bf21ffe4 90010008 9421ffa0
		 7c7d1b78 7c9e2378 38000000 b001003e
		 38000000 b001003c 3b800000 38000000
		 901d0004 38000000 901d0008 38000000
		 901d000c 38000000 901d0010 38000000
		 b01d0014 837d0000 3c1b0001 2800fffc
		 4082001c 7fc3f378 4bffb24d 60000000
		 7c7f1b78 3b800001 4800017c 281b0000
		 40820070 801e011c 28000000 41820020
		 807e011c 80630000 801e0100 7c030040
		 4082000c 83fe011c 4800001c 7fc3f378
		 809e0100 80be0104 4bffb09d 60000000
		 7c7f1b78 281f0000 4182012c 7fc3f378
		 7fe4fb78 480063fd 60000000 7c7a1b78
		 281a0000 41820110 3b800001 48000108
		 800203e8 28000000 4182001c 806203e8
		 80030000 7c1b0040 4082000c 83e203e8
		 480000c0 7fc3f378 4bffb035 60000000
		 7c7f1b78 7f63db78 4bffbb2d 60000000
		 5460063e 28000000 41820098 7fc3f378
		 4bffb175 60000000 7c7f1b78 48000084
		 833f0000 7fc3f378 7fe4fb78 4bffb139
		 60000000 5460063e 28000000 40820050
		 7fc3f378 7fe4fb78 48006359 60000000
		 7c7a1b78 281a0000 41820034 3c1b0001
		 2800fffe 4082000c 3b800001 4800003c
		 7c19d840 4082000c 3b800001 48000010
		 5780063e 28000000 40820020 7fc3f378
		 7fe4fb78 4bffb0f9 60000000 7c7f1b78
		 281f0000 4082ff7c 5780063e 28000000
		 4182000c 93e203e8 4800000c 38000000
		 900203e8 281f0000 40820020 5780063e
		 28000000 41820014 3800fffd 901d0004
		 38600000 48000048 5780063e 28000000
		 4082000c 3860ffce 48000034 801f0000
		 901d0004 a01f0014 901d0008 a01f001c
		 901d000c a01f0008 5400801e 901d0010
		 5740043e b01d0014 38600000 80010068
		 38210060 7c0803a6 bb21ffe4 4e800020
		 7c0802a6 bec1ffd8 90010008 9421ffa0
		 7c7f1b78 7c9d2378 3b400000 3bc00000
		 837f0000 281b0000 40820028 837d0100
		 801d011c 28000000 41820018 807d011c
		 80030000 7c00d840 40820008 83dd011c
		 281e0000 4082001c 7fa3eb78 7f64db78
		 38a00080 4bffae81 60000000 7c7e1b78
		 281e0000 4082000c 3860ffce 48000194
		 38000001 901f000a 38000000 807f0006
		 b0030006 38000000 807f0006 b0030008
		 38000000 807f0006 b003000e 38000000
		 807f0006 b0030010 38000000 807f0006
		 90030012 38000000 807f0006 90030026
		 3ae00002 3b000010 38000003 807f0006
		 b0030022 7fa3eb78 a09f0004 4bffadbd
		 60000000 28030020 41810068 38822384
		 5460103a 7c84002e 7c8903a6 4e800420
		 3ae00000 3b000000 3b800001 38000001
		 807f0006 b0030022 38000008 807f0006
		 b0030024 48000034 3b800002 38000005
		 807f0006 b0030024 48000020 3b800004
		 38000008 807f0006 b0030024 4800000c
		 3860ffce 480000ac 92ff000e 7f000734
		 807f0006 b003001e 57801838 807f0006
		 b0030020 a33e0014 a81e001c 807f0006
		 b003000a 3c800048 38840055 807f0006
		 90830016 3c800048 38840044 807f0006
		 9083001a 7f200734 807f0006 b003000c
		 7fa3eb78 7c9cc9d6 4bffd27d 60000000
		 7c761b78 7ec00734 807f0006 b0030004
		 38000000 807f0006 90030000 7fa3eb78
		 7fc4f378 4800606d 60000000 a01f0004
		 7c001840 40810008 3b40ffce 7f43d378
		 80010068 38210060 7c0803a6 bac1ffd8
		 4e800020 7c0802a6 bf61ffec 90010008
		 9421ffa0 7c7e1b78 7c9f2378 3ba00000
		 38000000 90010040 3b800000 38000000
		 901e0004 8b7f0160 38000001 981f0160
		 7fe3fb78 48008659 60000000 881f0629
		 2c000002 41820024 40800014 2c000000
		 418200dc 40800054 480000d4 2c000004
		 408000cc 48000088 7fe3fb78 38800002
		 4bffb075 60000000 7fe3fb78 38810045
		 38a10044 4bffaf29 60000000 881f0626
		 28000000 4182000c 3b800000 48000008
		 3b800200 480000dc 7fe3fb78 38800001
		 4bffb035 60000000 7fe3fb78 38810045
		 38a10044 48008929 60000000 881f0625
		 28000000 4182000c 3b800000 48000008
		 3b800200 639c0800 48000098 7fe3fb78
		 38800003 4bffaff1 60000000 7fe3fb78
		 38810045 38a10044 4bffae91 60000000
		 881f0627 28000000 4182000c 3b800000
		 48000008 3b800200 48000058 38000007
		 98010045 3800003f 98010044 3b800200
		 881f0654 5403063e 881f062c 7c030040
		 40820030 7fe3fb78 38800001 4bffaf89
		 60000000 7fe3fb78 38810045 38a10044
		 4800887d 60000000 3b800000 639c0800
		 7fe3fb78 38810038 38a1003c 38c00000
		 38e00000 4bffb119 60000000 9b7f0160
		 8001003c 5400043e b01e0000 801e0004
		 60000004 901e0004 88010044 280000ff
		 4182007c 801e0004 60000080 901e0004
		 387f0038 38822408 38a10040 4800ab45
		 80410014 7c7d0734 7fa00734 2c000000
		 40820010 801e0004 60000100 901e0004
		 7fa00734 2c000000 41820034 387f0038
		 3882240d 38a10040 4800ab09 80410014
		 7c7d0734 7fa00734 2c000000 40820010
		 801e0004 60000100 901e0004 881f0629
		 28000001 4082007c 801e0004 60000080
		 901e0004 387f0038 38822413 38a10040
		 4800aac1 80410014 7c7d0734 7fa00734
		 2c000000 40820010 801e0004 60000100
		 901e0004 7fa00734 2c000000 41820034
		 387f0038 3882241c 38a10040 4800aa85
		 80410014 7c7d0734 7fa00734 2c000000
		 40820010 801e0004 60000100 901e0004
		 88010044 280000ff 40820024 88010045
		 981e0002 38000000 981e0003 801e0004
		 60000040 901e0004 48000014 88010045
		 981e0002 88010044 981e0003 881f0629
		 28000002 4082003c 38000000 981f0150
		 801e0004 54000734 901e0004 80010038
		 540007bc 28000000 41820018 801e0004
		 60000010 901e0004 38000001 981f0150
		 801e0004 7c00e378 901e0004 38000000
		 901e0008 38000000 901e000c 38600000
		 80010068 38210060 7c0803a6 bb61ffec
		 4e800020 7c0802a6 bf81fff0 90010008
		 9421ffb0 7c7f1b78 7c9e2378 3c606465
		 3863636c 907f0008 807f0000 4bffb419
		 60000000 5460063e 28000000 4082001c
		 807f0000 4bffb421 60000000 5460063e
		 28000000 41820010 3c606172 38636261
		 907f0008 801e0148 28000001 40820034
		 881e05c8 28000000 40820028 881e0160
		 28000000 4082001c 38000000 901f000c
		 38000000 901f0010 38600000 480000bc
		 7fc3f378 809f0000 38a00080 4bffa899
		 60000000 7c7c1b78 281c0000 4082000c
		 3860ffce 48000094 7fc3f378 809f0000
		 48007f4d 60000000 7c7d1b78 881e05c8
		 28000000 41820020 57bd07b8 801f0000
		 28000006 4082000c 63bd0007 48000008
		 63bd0001 801c0004 901f000c 881e0626
		 28000000 4082003c 807f0000 48009b31
		 60000000 5460063e 28000000 4082001c
		 807f0000 48009ab9 60000000 5460063e
		 28000000 4182000c 38000000 901f000c
		 93bf0010 38600000 80010058 38210050
		 7c0803a6 bb81fff0 4e800020 38c22428
		 38a22aa4 a0830168 3804fc17 5400083c
		 7c05022e 5400103a 7c660214 4e800020
		 7c0802a6 bf81fff0 90010008 9421ffb0
		 7c7e1b78 7c9d2378 3b800000 83fe0000
		 2c1fffff 4182004c 40800010 2c1ffffe
		 40800038 4800003c 2c1f0001 40800034
		 48000004 83fe0004 a01d0168 7c1f0040
		 41800010 a01d016a 7c1f0040 4081004c
		 3b80ffce 48000044 a3fd0168 4800003c
		 a01d016a 7c1f0040 4082000c 3be0fffd
		 48000028 a01d0168 7c1f0040 41800018
		 a01d016a 7c1f0040 4080000c 3bff0001
		 48000008 3b80ffce 7f800734 2c000000
		 4082004c 93fe0004 3c1f0001 2800fffd
		 41820054 38622aac 381ffc17 5400083c
		 7c03022e 5400103a 901e0008 807e000c
		 38822a94 381ffc17 5400103a 7c84002e
		 4800a791 80410014 4800001c 38000000
		 901e0004 38000000 901e0008 38000000
		 901e000c 7f83e378 80010058 38210050
		 7c0803a6 bb81fff0 4e800020 7c0802a6
		 bf81fff0 90010008 9421ffb0 7c7c1b78
		 7c9d2378 3bc00000 83fc0000 a01d0168
		 7c1f0040 41800010 a01d016a 7c1f0040
		 4081000c 3bc0ffce 48000040 38822428
		 38622aa4 381ffc17 5400083c 7c03022e
		 5400103a 7c640214 809c0004 38a22aac
		 381ffc17 5400083c 7c05022e 5405103a
		 4800a861 80410014 7fc3f378 80010058
		 38210050 7c0803a6 bb81fff0 4e800020
		 88030000 2c0000ff 41820020 40800024
		 2c000000 41820008 48000018 88040134
		 98030000 4800000c 38000087 98030000
		 38600000 4e800020 38000001 90030000
		 38600000 4e800020 880405b0 9003000c
		 880405b0 28000000 4182001c 800405b4
		 90030000 800405b8 90030004 800405bc
		 90030008 38600000 4e800020 880405c1
		 28000000 41820010 38000000 90030000
		 4800000c 38000001 90030000 38600000
		 4e800020 7c0802a6 bf81fff0 90010008
		 9421ffb0 7c7f1b78 7c9d2378 3b800080
		 801f0000 28000001 4080000c 3860ffce
		 480003dc 801f0004 28000000 41820018
		 801f0004 28000001 4182000c 3860ffce
		 480003bc 801f0004 28000000 40820008
		 3b800080 801f0004 28000001 40820008
		 3b800100 801f0000 28000001 40810010
		 801f0008 60000001 901f0008 801f0008
		 540007fe 28000000 41820290 3bc0ffed
		 881d0629 2c000002 41820014 40800270
		 2c000001 4080015c 48000264 7fc00734
		 2c000000 41820074 800200dc 901d015c
		 800200d8 901d0158 7fe3fb78 7fa4eb78
		 48003f49 60000000 7c7e1b78 7fc00734
		 2c000000 40820044 801f0004 28000000
		 40820018 881f0024 54000630 2c000000
		 41820008 3bc0ffed 801f0004 28000001
		 40820018 881f0051 7c002670 2c000002
		 40810008 3bc0ffed 7fc00734 2c000000
		 41820028 800200d4 901d015c 800200d0
		 901d0158 7fe3fb78 7fa4eb78 48003ecd
		 60000000 7c7e1b78 801f0000 28000001
		 408201b0 801f0004 28000000 40820044
		 7fc00734 2c00ffed 40820014 387d0038
		 38822ab4 4800a39d 80410014 7fc00734
		 2c000000 4082001c 7fa3eb78 38822ab9
		 38bf0010 38c00080 4bff78b9 60000000
		 801f0004 28000001 40820158 7fc00734
		 2c00ffed 40820014 387d0038 38822abe
		 4800a351 80410014 7fc00734 2c000000
		 40820130 7fa3eb78 38822ac4 38bf0010
		 38c00100 4bff786d 60000000 48000114
		 800200dc 901d015c 800200d8 901d0158
		 7fe3fb78 7fa4eb78 48003e01 60000000
		 7c7e1b78 7fc00734 2c000000 40820038
		 807f0004 38000000 7c030050 7c000034
		 5400d97e 801f0004 28000001 40820018
		 881f0051 7c002670 2c000003 41820008
		 3bc0ffed 801f0000 28000001 408200a4
		 801f0004 28000000 40820044 7fc00734
		 2c00ffed 40820014 387d0038 38822aca
		 4800a291 80410014 7fc00734 2c000000
		 4082001c 7fa3eb78 38822ad3 38bf0010
		 38c00080 4bff77ad 60000000 801f0004
		 28000001 4082004c 7fc00734 2c00ffed
		 40820014 387d0038 38822adc 4800a245
		 80410014 7fc00734 2c000000 40820024
		 7fa3eb78 38822ae6 38bf0010 38c00100
		 4bff7761 60000000 48000008 3bc0ffee
		 7fc3f378 480000e8 3b800080 881d0629
		 2c000002 41820014 408000b8 2c000001
		 4080005c 480000ac 801f0004 28000000
		 40820020 7fa3eb78 38822af0 38bf0010
		 38c00080 4bff7785 60000000 7c7e1b78
		 801f0004 28000001 4082007c 7fa3eb78
		 38822af5 38bf0010 38c00100 4bff775d
		 60000000 7c7e1b78 4800005c 801f0004
		 28000000 40820020 7fa3eb78 38822afb
		 38bf0010 38c00080 4bff7731 60000000
		 7c7e1b78 801f0004 28000001 40820028
		 7fa3eb78 38822b04 38bf0010 38c00100
		 4bff7709 60000000 7c7e1b78 48000008
		 3bc0ffee 7fc00734 2c000000 4182000c
		 3860ffee 48000008 38600000 80010058
		 38210050 7c0803a6 bb81fff0 4e800020
		 7c0802a6 bfa1fff4 90010008 9421ffb0
		 7c7f1b78 7c9e2378 38000000 901f0004
		 38000005 901f0008 7fc3f378 480044f1
		 60000000 907f000c 7fc3f378 480045f9
		 60000000 907f0010 7fc3f378 38800000
		 4800443d 60000000 907f0014 7fc3f378
		 38800021 48004049 60000000 5460063e
		 540007be 901f0018 38000000 901f001c
		 3ba00000 48000020 57a3063e 380305d0
		 7c9e00ae 57a3063e 38030020 7c9f01ae
		 3bbd0001 57a0063e 28000010 4180ffdc
		 807e0038 801e003c 907f0030 901f0034
		 807e0040 801e0044 907f0038 901f003c
		 38000048 901f0000 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 38000001
		 90030004 80040090 90030008 800400a0
		 9003000c 38000000 90030010 80040090
		 90030014 38000000 90030018 88040030
		 28000000 4182000c 80040098 90030018
		 80040094 9003001c 38000000 90030020
		 80040138 90030024 80a4008c 80040138
		 7c050214 90030028 8004010c 9003002c
		 80040108 90030030 80a40118 a0050014
		 90030034 80a40118 a005001c 90030038
		 80a4011c a0050014 9003003c 80a4011c
		 a005001c 90030040 38000201 90030044
		 80040054 90030048 3800004c 90030000
		 4e800020 7c0802a6 bfa1fff4 90010008
		 9421ff60 7c7e1b78 908100bc 3ba00000
		 38610038 808100bc 4bffff15 3be0004c
		 801e0000 7c00f840 40800008 83fe0000
		 93e10038 38610038 7fc4f378 7fe5fb78
		 4800a181 80410014 7fa3eb78 800100a8
		 382100a0 7c0803a6 bba1fff4 4e800020
		 7c0802a6 bfa1fff4 90010008 9421ff70
		 7c7e1b78 908100ac 3ba00000 38610038
		 808100ac 4bfffdbd 3be00048 801e0000
		 7c00f840 40800008 83fe0000 93e10038
		 38610038 7fc4f378 7fe5fb78 4800a115
		 80410014 7fa3eb78 80010098 38210090
		 7c0803a6 bba1fff4 4e800020 800400f8
		 28000000 40820010 38000001 900400fc
		 4800000c 38000000 900400fc 800400f8
		 90030000 800400fc 90030004 800400fc
		 60000008 60000020 90030004 38600000
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421ffc0 7c7f1b78 7c9e2378 281f0000
		 4082000c 3860ffce 4800009c 38000038
		 901f0000 801e0034 901f0004 7fc3f378
		 38800100 4bffcab5 60000000 907f0008
		 38000023 901f000c 7fc3f378 38800104
		 4bffca99 60000000 907f0010 38000043
		 901f0014 7fc3f378 3880010c 4bffca7d
		 60000000 907f0018 801e0080 901f001c
		 801e0084 901f0020 801e0088 901f0024
		 38000000 901f0028 38000000 901f002c
		 38000000 901f0030 38000000 901f0034
		 38600000 80010048 38210040 7c0803a6
		 bbc1fff8 4e800020 7c0802a6 93e1fffc
		 90010008 9421ffc0 90610058 9081005c
		 3be00000 8061005c 80810058 4bffaffd
		 60000000 7c7f1b78 7fe3fb78 80010048
		 38210040 7c0803a6 83e1fffc 4e800020
		 7c0802a6 93e1fffc 90010008 9421ffc0
		 90610058 9081005c 3be00000 8061005c
		 80810058 4bffb8ad 60000000 7c7f1b78
		 7fe3fb78 80010048 38210040 7c0803a6
		 83e1fffc 4e800020 7c0802a6 90010008
		 9421ffc0 90610058 9081005c 8061005c
		 80810058 4bffa44d 60000000 80010048
		 38210040 7c0803a6 4e800020 38000000
		 90030000 38000001 90030004 38000000
		 90030008 38000000 9003000c 38000007
		 90030010 38600000 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ffb0 90610068
		 9081006c 3bc243a4 3ba22b10 3be00000
		 480000b0 8081006c 1c7f0018 38030008
		 7c1d002e 7c040040 40820094 807e0000
		 38800044 4bffc8e5 60000000 1c9f0018
		 38040004 7c1d002e 7c051b78 807e0000
		 38800044 4bffc889 60000000 807e0000
		 38800044 4bffc8b5 60000000 1c9f0018
		 38040004 7c1d002e 7c650078 807e0000
		 38800044 4bffc859 60000000 807e0000
		 38800040 4bffc885 60000000 1c1f0018
		 7c1d002e 7c051b78 807e0000 38800040
		 4bffc82d 60000000 48000010 3bff0001
		 281f000a 4180ff50 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 bf81fff0 90010008 9421ffb0 90610068
		 9081006c 3ba243a4 3bc22b10 3b800000
		 3be00000 48000078 8081006c 1c7f0018
		 38030008 7c1e002e 7c040040 4082005c
		 807d0000 38800040 4bffc7f1 60000000
		 1c1f0018 7c1e002e 7c001838 28000000
		 41820008 3b800001 807d0000 38800040
		 4bffc7c9 60000000 1c1f0018 7c1e002e
		 7c650078 807d0000 38800040 4bffc771
		 60000000 48000010 3bff0001 281f000a
		 4180ff88 7f83e378 80010058 38210050
		 7c0803a6 bb81fff0 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ffb0 90610068
		 9081006c 3ba22c00 3bc243a4 3be00000
		 480000b0 8081006c 1c7f0018 38030008
		 7c1d002e 7c040040 40820094 807e0000
		 3880090c 4bffc735 60000000 1c9f0018
		 38040004 7c1d002e 7c051b78 807e0000
		 3880090c 4bffc6d9 60000000 807e0000
		 3880090c 4bffc705 60000000 1c9f0018
		 38040004 7c1d002e 7c650078 807e0000
		 3880090c 4bffc6a9 60000000 807e0000
		 38800908 4bffc6d5 60000000 1c1f0018
		 7c1d002e 7c051b78 807e0000 38800908
		 4bffc67d 60000000 48000010 3bff0001
		 281f0012 4180ff50 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 bf81fff0 90010008 9421ffb0 90610068
		 9081006c 3ba22c00 3bc243a4 3b800000
		 3be00000 48000078 8081006c 1c7f0018
		 38030008 7c1d002e 7c040040 4082005c
		 807e0000 38800908 4bffc641 60000000
		 1c1f0018 7c1d002e 7c001838 28000000
		 41820008 3b800001 807e0000 38800908
		 4bffc619 60000000 1c1f0018 7c1d002e
		 7c650078 807e0000 38800908 4bffc5c1
		 60000000 48000010 3bff0001 281f0012
		 4180ff88 7f83e378 80010058 38210050
		 7c0803a6 bb81fff0 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ffb0 90610068
		 9081006c 3ba22db0 3bc243a4 3be00000
		 480000b0 8081006c 1c7f0018 38030008
		 7c1d002e 7c040040 40820094 807e0000
		 38800c4c 4bffc585 60000000 1c9f0018
		 38040004 7c1d002e 7c051b78 807e0000
		 38800c4c 4bffc529 60000000 807e0000
		 38800c4c 4bffc555 60000000 1c9f0018
		 38040004 7c1d002e 7c650078 807e0000
		 38800c4c 4bffc4f9 60000000 807e0000
		 38800c4c 4bffc525 60000000 1c1f0018
		 7c1d002e 7c051b78 807e0000 38800c4c
		 4bffc4cd 60000000 48000010 3bff0001
		 281f0004 4180ff50 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 bf81fff0 90010008 9421ffb0 90610068
		 9081006c 3ba22db0 3bc243a4 3b800000
		 3be00000 48000078 8081006c 1c7f0018
		 38030008 7c1d002e 7c040040 4082005c
		 807e0000 38800c4c 4bffc491 60000000
		 1c1f0018 7c1d002e 7c001838 28000000
		 41820008 3b800001 807e0000 38800c4c
		 4bffc469 60000000 1c1f0018 7c1d002e
		 7c650078 807e0000 38800c4c 4bffc411
		 60000000 48000010 3bff0001 281f0004
		 4180ff88 7f83e378 80010058 38210050
		 7c0803a6 bb81fff0 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ffb0 90610068
		 9081006c 3ba22e10 3bc243a4 3be00000
		 480000b4 80a1006c 38822c00 1c7f0018
		 38030008 7c04002e 7c050040 40820094
		 807e0000 38800c50 4bffc3d1 60000000
		 1c9f0018 38040004 7c1d002e 7c051b78
		 807e0000 38800c50 4bffc375 60000000
		 807e0000 38800c50 4bffc3a1 60000000
		 1c9f0018 38040004 7c1d002e 7c650078
		 807e0000 38800c50 4bffc345 60000000
		 807e0000 38800c50 4bffc371 60000000
		 1c1f0018 7c1d002e 7c051b78 807e0000
		 38800c50 4bffc319 60000000 48000010
		 3bff0001 281f0006 4180ff4c 80010058
		 38210050 7c0803a6 bba1fff4 4e800020
		 7c0802a6 bf81fff0 90010008 9421ffb0
		 90610068 9081006c 3ba22e10 3bc243a4
		 3b800000 3be00000 48000078 8081006c
		 1c7f0018 38030008 7c1d002e 7c040040
		 4082005c 807e0000 38800c50 4bffc2dd
		 60000000 1c1f0018 7c1d002e 7c001838
		 28000000 41820008 3b800001 807e0000
		 38800c50 4bffc2b5 60000000 1c1f0018
		 7c1d002e 7c650078 807e0000 38800c50
		 4bffc25d 60000000 48000010 3bff0001
		 281f0006 4180ff88 7f83e378 80010058
		 38210050 7c0803a6 bb81fff0 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000001 9001005c
		 80610058 8081005c 80a10060 4bfff911
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000001 9001005c
		 80610058 8081005c 80a10060 4bfff9c1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000002 9001005c
		 80610058 8081005c 80a10060 4bfff891
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000002 9001005c
		 80610058 8081005c 80a10060 4bfff941
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000009 9001005c
		 80610058 8081005c 80a10060 4bfff811
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000009 9001005c
		 80610058 8081005c 80a10060 4bfff8c1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000007 9001005c
		 80610058 8081005c 80a10060 4bfff791
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000007 9001005c
		 80610058 8081005c 80a10060 4bfff841
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000003 9001005c
		 80610058 8081005c 80a10060 4bfff711
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000003 9001005c
		 80610058 8081005c 80a10060 4bfff7c1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000a 9001005c
		 80610058 8081005c 80a10060 4bfff691
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000a 9001005c
		 80610058 8081005c 80a10060 4bfff741
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000b 9001005c
		 80610058 8081005c 80a10060 4bfff611
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000b 9001005c
		 80610058 8081005c 80a10060 4bfff6c1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000c 9001005c
		 80610058 8081005c 80a10060 4bfff591
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000c 9001005c
		 80610058 8081005c 80a10060 4bfff641
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000d 9001005c
		 80610058 8081005c 80a10060 4bfff511
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000d 9001005c
		 80610058 8081005c 80a10060 4bfff5c1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800002a 9001005c
		 80610058 8081005c 80a10060 4bfff491
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800002a 9001005c
		 80610058 8081005c 80a10060 4bfff541
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000e 9001005c
		 80610058 8081005c 80a10060 4bfff5c1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000f 9001005c
		 80610058 8081005c 80a10060 4bfff581
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000010 9001005c
		 80610058 8081005c 80a10060 4bfff541
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000011 9001005c
		 80610058 8081005c 80a10060 4bfff501
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000012 9001005c
		 80610058 8081005c 80a10060 4bfff4c1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000013 9001005c
		 80610058 8081005c 80a10060 4bfff481
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000014 9001005c
		 80610058 8081005c 80a10060 4bfff441
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000015 9001005c
		 80610058 8081005c 80a10060 4bfff401
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000016 9001005c
		 80610058 8081005c 80a10060 4bfff3c1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000017 9001005c
		 80610058 8081005c 80a10060 4bfff381
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000018 9001005c
		 80610058 8081005c 80a10060 4bfff341
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000019 9001005c
		 80610058 8081005c 80a10060 4bfff301
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001a 9001005c
		 80610058 8081005c 80a10060 4bfff2c1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001b 9001005c
		 80610058 8081005c 80a10060 4bfff281
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001c 9001005c
		 80610058 8081005c 80a10060 4bfff241
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001d 9001005c
		 80610058 8081005c 80a10060 4bfff201
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001e 9001005c
		 80610058 8081005c 80a10060 4bfff1c1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001f 9001005c
		 80610058 8081005c 80a10060 4bfff181
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000020 9001005c
		 80610058 8081005c 80a10060 4bfff2f1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000021 9001005c
		 80610058 8081005c 80a10060 4bfff2b1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000022 9001005c
		 80610058 8081005c 80a10060 4bfff271
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000023 9001005c
		 80610058 8081005c 80a10060 4bfff231
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000024 9001005c
		 80610058 8081005c 80a10060 4bfff3a1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000025 9001005c
		 80610058 8081005c 80a10060 4bfff361
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000026 9001005c
		 80610058 8081005c 80a10060 4bfff321
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000027 9001005c
		 80610058 8081005c 80a10060 4bfff2e1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000028 9001005c
		 80610058 8081005c 80a10060 4bfff2a1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000029 9001005c
		 80610058 8081005c 80a10060 4bfff261
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000e 9001005c
		 80610058 8081005c 80a10060 4bffefb1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800000f 9001005c
		 80610058 8081005c 80a10060 4bffef71
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000010 9001005c
		 80610058 8081005c 80a10060 4bffef31
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000011 9001005c
		 80610058 8081005c 80a10060 4bffeef1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000012 9001005c
		 80610058 8081005c 80a10060 4bffeeb1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000013 9001005c
		 80610058 8081005c 80a10060 4bffee71
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000014 9001005c
		 80610058 8081005c 80a10060 4bffee31
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000015 9001005c
		 80610058 8081005c 80a10060 4bffedf1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000016 9001005c
		 80610058 8081005c 80a10060 4bffedb1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000017 9001005c
		 80610058 8081005c 80a10060 4bffed71
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000018 9001005c
		 80610058 8081005c 80a10060 4bffed31
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000019 9001005c
		 80610058 8081005c 80a10060 4bffecf1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001a 9001005c
		 80610058 8081005c 80a10060 4bffecb1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001b 9001005c
		 80610058 8081005c 80a10060 4bffec71
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001c 9001005c
		 80610058 8081005c 80a10060 4bffec31
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001d 9001005c
		 80610058 8081005c 80a10060 4bffebf1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001e 9001005c
		 80610058 8081005c 80a10060 4bffebb1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 3800001f 9001005c
		 80610058 8081005c 80a10060 4bffeb71
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000020 9001005c
		 80610058 8081005c 80a10060 4bffece1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000021 9001005c
		 80610058 8081005c 80a10060 4bffeca1
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000022 9001005c
		 80610058 8081005c 80a10060 4bffec61
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000023 9001005c
		 80610058 8081005c 80a10060 4bffec21
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000024 9001005c
		 80610058 8081005c 80a10060 4bffed95
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000025 9001005c
		 80610058 8081005c 80a10060 4bffed55
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000026 9001005c
		 80610058 8081005c 80a10060 4bffed15
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000027 9001005c
		 80610058 8081005c 80a10060 4bffecd5
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000028 9001005c
		 80610058 8081005c 80a10060 4bffec95
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 90010008 9421ffc0 90610058
		 9081005c 90a10060 38000029 9001005c
		 80610058 8081005c 80a10060 4bffec55
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 bee1ffdc 90010008 9421ffa0
		 90610078 9081007c 3ae24434 3b024430
		 3b22442c 3b424428 3be243a4 88020420
		 28000000 408200dc 807f0000 38800044
		 4bffaf29 60000000 9062041c 807f0000
		 38800040 4bffaf15 60000000 90620418
		 3c60010f 3863040f 907a0000 807f0000
		 3880090c 4bffaef5 60000000 90620414
		 807f0000 38800908 4bffaee1 60000000
		 90620410 3c6001ff 386301ff 90790000
		 807f0000 38800c4c 4bffaec1 60000000
		 9062040c 8002040c 54002036 90020408
		 380000f0 90180000 807f0000 38800c50
		 4bffae99 60000000 90620404 80020404
		 5400c23e 90020400 3800003f 90170000
		 38022b10 900203ec 38022c00 900203f0
		 38022db0 900203f4 38022e10 900203f8
		 83c2041c 80620418 801a0000 7c600038
		 7fde0038 83a20414 80620410 80190000
		 7c600038 7fbd0038 8382040c 80620408
		 80180000 7c600038 7f9c0038 83620404
		 80620400 80170000 7c600038 7f7b0038
		 3c60010f 3863040f 7fc01838 28000000
		 41820064 48000048 806203ec 80030000
		 7fc00038 28000000 41820028 806203ec
		 80030008 9001007c 809a0000 806203ec
		 80030004 7c800078 901a0000 480001cc
		 806203ec 38030018 900203ec 808203ec
		 38622b10 380300f0 7c040040 4082ffac
		 480001a8 3c6001ff 386301ff 7fa01838
		 28000000 41820064 48000048 806203f0
		 80030000 7fa00038 28000000 41820028
		 806203f0 80030008 9001007c 80990000
		 806203f0 80030004 7c800078 90190000
		 48000158 806203f0 38030018 900203f0
		 808203f0 38622c00 380301b0 7c040040
		 4082ffac 48000134 57800636 28000000
		 41820064 48000048 806203f4 80030000
		 7f800038 28000000 41820028 806203f4
		 80030008 9001007c 80980000 806203f4
		 80030004 7c800078 90180000 480000ec
		 806203f4 38030018 900203f4 808203f4
		 38622db0 38030060 7c040040 4082ffac
		 480000c8 576006be 28000000 41820064
		 48000048 806203f8 80030000 7f600038
		 28000000 41820028 806203f8 80030008
		 9001007c 80970000 806203f8 80030004
		 7c800078 90170000 48000080 806203f8
		 38030018 900203f8 808203f8 38622e10
		 38030090 7c040040 4082ffac 4800005c
		 38000000 9001007c 807f0000 38800044
		 80a2041c 4bffabf9 60000000 807f0000
		 3880090c 80a20414 4bffabe5 60000000
		 807f0000 38800c4c 80a2040c 4bffabd1
		 60000000 807f0000 38800c50 80a20404
		 4bffabbd 60000000 8001007c 2c000000
		 41820010 38000001 98020420 4800000c
		 38000000 98020420 8061007c 80010068
		 38210060 7c0803a6 bae1ffdc 4e800020
		 7c0802a6 bf81fff0 90010008 9421ff90
		 9081008c 90a10090 90e10098 9101009c
		 7d3c4b78 914100a4 83a100ac 38610040
		 388203fc 48007fbd 80410014 38610040
		 8081009c 48007fc5 80410014 8061008c
		 38810040 7fa5eb78 48007fc9 80410014
		 7c7e1b78 2c1e0000 40820104 7f83e378
		 48007e79 80410014 3be30001 7fa3eb78
		 38822ea0 7f85e378 7fe6fb78 48007d85
		 80410014 7c7e1b78 2c1e0000 408200d0
		 80010090 28000000 40820024 3be00004
		 7fa3eb78 38822eac 38a10090 7fe6fb78
		 48007d51 80410014 7c7e1b78 3be00004
		 7fa3eb78 38822ebc 38a10098 7fe6fb78
		 48007d31 80410014 7c7e1b78 2c1e0000
		 4082007c 83e100a8 7fa3eb78 38822ec6
		 80a100a4 7fe6fb78 48007d09 80410014
		 7c7e1b78 2c1e0000 40820054 386243a4
		 80630000 80030094 90010038 386243a4
		 80630000 8003009c 9001003c 3be00008
		 7fa3eb78 38822ed1 38a10038 7fe6fb78
		 48007cc1 80410014 7c7e1b78 38000000
		 7c1e0050 7c000034 5400d97e 7fc3f378
		 80010078 38210070 7c0803a6 bb81fff0
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421ff90 7c7e1b78 7fc3f378 38810038
		 48007f11 80410014 7c7f1b78 2c1f0000
		 40820064 38000000 9801005c 48000044
		 38610038 3881003c 38a1005c 48007efd
		 80410014 7c7f1b78 2c1f0000 40820024
		 8801005c 28000000 40820018 7fc3f378
		 3881003c 48007d0d 80410014 7c7f1b78
		 2c1f0000 40820010 8801005c 28000000
		 4182ffb0 8801005c 28000000 41820008
		 3be00000 38610038 48007eb9 80410014
		 7fc3f378 48007ec5 80410014 7c7f1b78
		 7fe3fb78 80010078 38210070 7c0803a6
		 bbc1fff8 4e800020 7c0802a6 bec1ffd8
		 90010008 9421fe00 7c7d1b78 3b8243c4
		 3b6243bc 3ae22e10 3b022db0 3b222c00
		 3b422b10 38000004 90010198 7fa3eb78
		 38822ede 38a101d4 38c10198 48007b15
		 80410014 7c7f1b78 2c1f0000 4182000c
		 7fe3fb78 4800070c 38000004 90010198
		 7fa3eb78 38822eeb 38a101d0 38c10198
		 48007ae1 80410014 7c7f1b78 2c1f0000
		 4182000c 38000000 900101d0 7fa3eb78
		 38822efb 38a10198 48007c99 80410014
		 7fa3eb78 38822f0a 38a101a0 38c10198
		 48007aa1 80410014 7c7f1b78 2c1f0000
		 41820010 38000000 980101a0 4800004c
		 3ac00000 80010198 28000010 4081000c
		 80610198 3ac3fff0 7edeb378 48000020
		 386101a0 7c83f0ae 386243a4 80630000
		 381e05d0 7c8301ae 3bde0001 38160010
		 7c1e0000 4180ffdc 38000004 90010198
		 7fa3eb78 38822f19 38a1019c 38c10198
		 48007a21 80410014 7c7f1b78 2c1f0000
		 4182000c 7fe3fb78 48000618 38000008
		 90010198 7fa3eb78 38822f23 7f65db78
		 38c10198 480079ed 80410014 7c7f1b78
		 2c1f0000 4182000c 7fe3fb78 480005e4
		 807b0000 809b0004 38a0002a 7f86e378
		 38e00001 48007bb5 80410014 7c7f1b78
		 2c1f0000 4182000c 7fe3fb78 480005b4
		 807b0000 809b0004 38a243ac 38c243b0
		 38e243b4 390243b8 48007b99 80410014
		 7c7f1b78 2c1f0000 4182000c 7fe3fb78
		 48000580 807b0000 809b0004 38a00000
		 80c20108 38e00000 39000000 48007b7d
		 80410014 7c7f1b78 2c1f0000 4182000c
		 7fe3fb78 4800054c 3bc00000 48000094
		 809c0000 57c01838 38610040 7c83012e
		 1c7e0018 38030008 7cba002e 57c41838
		 38610040 38040004 7ca3012e 57c01838
		 38610040 7c63002e 57c51838 38810040
		 38050004 7c84002e 38a00000 1cde0018
		 38060014 7cda002e 1cfe0018 3807000c
		 7cfa002e 1d1e0018 38080010 7d1a002e
		 48007ae9 80410014 7c7f1b78 2c1f0000
		 4182000c 7fe3fb78 480004b8 3bde0001
		 281e000a 4180ff6c 38000050 90010198
		 80010198 90010038 380243e8 9001003c
		 806101d4 7fa4eb78 80a101d0 38c101a0
		 80e1019c 39022f2e 39222f35 39410040
		 4bfffab1 7c7f1b78 2c1f0000 4182000c
		 7fe3fb78 4800045c 3bc00000 48000094
		 809c0000 57c01838 38610040 7c83012e
		 1c7e0018 38030008 7cb9002e 57c41838
		 38610040 38040004 7ca3012e 57c01838
		 38610040 7c63002e 57c51838 38810040
		 38050004 7c84002e 38a00000 1cde0018
		 38060014 7cd9002e 1cfe0018 3807000c
		 7cf9002e 1d1e0018 38080010 7d19002e
		 480079f9 80410014 7c7f1b78 2c1f0000
		 4182000c 7fe3fb78 480003c8 3bde0001
		 281e0012 4180ff6c 38000090 90010198
		 80010198 90010038 380243f8 9001003c
		 806101d4 7fa4eb78 80a101d0 38c101a0
		 80e1019c 39022f3c 39222f43 39410040
		 4bfff9c1 7c7f1b78 2c1f0000 4182000c
		 7fe3fb78 4800036c 3bc00000 48000094
		 809c0000 57c01838 38610040 7c83012e
		 1c7e0018 38030008 7cb8002e 57c41838
		 38610040 38040004 7ca3012e 57c01838
		 38610040 7c63002e 57c51838 38810040
		 38050004 7c84002e 38a00000 1cde0018
		 38060014 7cd8002e 1cfe0018 3807000c
		 7cf8002e 1d1e0018 38080010 7d18002e
		 48007909 80410014 7c7f1b78 2c1f0000
		 4182000c 7fe3fb78 480002d8 3bde0001
		 281e0004 4180ff6c 38000020 90010198
		 80010198 90010038 38024408 9001003c
		 806101d4 7fa4eb78 80a101d0 38c101a0
		 80e1019c 39022f4a 39222f54 39410040
		 4bfff8d1 7c7f1b78 2c1f0000 4182000c
		 7fe3fb78 4800027c 3bc00000 48000094
		 809c0000 57c01838 38610040 7c83012e
		 1c7e0018 38030008 7cb7002e 57c41838
		 38610040 38040004 7ca3012e 57c01838
		 38610040 7c63002e 57c51838 38810040
		 38050004 7c84002e 38a00000 1cde0018
		 38060014 7cd7002e 1cfe0018 3807000c
		 7cf7002e 1d1e0018 38080010 7d17002e
		 48007819 80410014 7c7f1b78 2c1f0000
		 4182000c 7fe3fb78 480001e8 3bde0001
		 281e0006 4180ff6c 38000030 90010198
		 80010198 90010038 38024418 9001003c
		 806101d4 7fa4eb78 80a101d0 38c101a0
		 80e1019c 39022f5e 39222f6d 39410040
		 4bfff7e1 7c7f1b78 2c1f0000 4182000c
		 7fe3fb78 4800018c 801c0000 90010040
		 38000001 90010044 38000000 90010048
		 38000000 9001004c 38000000 90010050
		 38000000 90010054 801c0000 90010058
		 38000002 9001005c 38000000 90010060
		 38000000 90010064 38000028 90010198
		 7fa3eb78 38822f7c 38a10040 80c10198
		 48007559 80410014 7c7f1b78 2c1f0000
		 4182000c 7fe3fb78 48000108 801c0000
		 90010040 38000004 90010044 801c0000
		 90010048 38000005 9001004c 801c0000
		 90010050 38000003 90010054 801c0000
		 90010058 38000007 9001005c 38000020
		 90010198 80010198 90010038 380243c8
		 9001003c 806101d4 7fa4eb78 80a101d0
		 38c101a0 80e1019c 39022f87 39222f8c
		 39410040 4bfff6cd 7c7f1b78 2c1f0000
		 4182000c 7fe3fb78 48000078 38000000
		 90010040 38000000 90010044 801c0000
		 90010048 38000003 9001004c 38000010
		 90010198 80010198 90010038 380243d8
		 9001003c 806101d4 7fa4eb78 80a101d0
		 38c101a0 80e1019c 39022f91 39222f97
		 39410040 4bfff65d 7c7f1b78 2c1f0000
		 4182000c 7fe3fb78 48000008 7fe3fb78
		 80010208 38210200 7c0803a6 bac1ffd8
		 4e800020 7c0802a6 bfa1fff4 90010008
		 9421ffb0 90610068 3bc243bc 386243c4
		 80630000 480076a5 80410014 7c7f1b78
		 2c1f0000 4182000c 7fe3fb78 480000ec
		 386243c8 4bfff771 7c7f1b78 2c1f0000
		 408200d4 386243d8 4bfff75d 7c7f1b78
		 2c1f0000 408200c0 386243f8 4bfff749
		 7c7f1b78 2c1f0000 408200ac 386243e8
		 4bfff735 7c7f1b78 2c1f0000 40820098
		 38624408 4bfff721 7c7f1b78 2c1f0000
		 40820084 38624418 4bfff70d 7c7f1b78
		 2c1f0000 40820070 3ba00008 80610068
		 38822f9d 7fc5f378 7fa6eb78 4800735d
		 80410014 7c7f1b78 2c1f0000 40820048
		 807e0000 809e0004 38a243ac 80a50000
		 38c243b0 80c60000 38e243b4 80e70000
		 390243b8 81080000 48007501 80410014
		 7c7f1b78 2c1f0000 4182000c 7fe3fb78
		 48000008 7fe3fb78 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 38822fa8
		 38600000 c8040000 c8640008 c8840010
		 fc010000 ff011800 4d800020 3863ffff
		 4c980020 ff812000 fc400890 419c0008
		 fc412028 fc40101e d841fff8 8061fffc
		 4d9c0020 3c638000 4e800020 4e800020
		 d9c1ff70 d9e1ff78 da01ff80 da21ff88
		 da41ff90 da61ff98 da81ffa0 daa1ffa8
		 dac1ffb0 dae1ffb8 db01ffc0 db21ffc8
		 db41ffd0 db61ffd8 db81ffe0 dba1ffe8
		 dbc1fff0 dbe1fff8 4e800020 4e800020
		 c9c1ff70 c9e1ff78 ca01ff80 ca21ff88
		 ca41ff90 ca61ff98 ca81ffa0 caa1ffa8
		 cac1ffb0 cae1ffb8 cb01ffc0 cb21ffc8
		 cb41ffd0 cb61ffd8 cb81ffe0 cba1ffe8
		 cbc1fff0 cbe1fff8 4e800020 2c030000
		 7c600034 7c890034 40820008 38090020
		 2c050000 7ca90034 7cca0034 40820008
		 392a0020 7c004800 21400040 418100b0
		 39290001 21290040 7c004a14 7d295050
		 7d2903a6 2c090020 38e9ffe0 41800010
		 7c683c30 38e00000 48000018 7c884c30
		 20e90020 7c673830 7d083b78 7c674c30
		 2c000020 3120ffe0 41800010 7c834830
		 38800000 48000018 7c630030 21200020
		 7c894c30 7c634b78 7c840030 3940ffff
		 30e70000 7c842114 7c631914 7d084114
		 7ce73914 7c064010 7d253911 41800010
		 7c080378 7d274b78 300a0001 4200ffd8
		 7c842114 7c631914 4e800020 38800000
		 38600000 4e800020 4e800020 7c672379
		 38c00000 4182007c 7c670034 7c880034
		 54e9d008 7d29fe70 7d294038 7ce74a14
		 21070020 3127ffe0 7c633830 7c8a4430
		 7c635378 7c8a4830 7c635378 7c843830
		 7cc73050 5487057e 2c070400 38c6043e
		 4180001c 4181000c 54870529 41820010
		 30840800 7c630194 7cc60194 5484a83e
		 5064a814 5463ab3e 54c6a016 7cc31b78
		 90610018 9081001c c8210018 4e800020
		 4e800020 7c0802a6 93e1fffc 90010008
		 9421ffc0 7c7f1b78 7fe3fb78 819f015c
		 48007449 80410014 5460063e 540307bc
		 38000000 7c630050 3003ffff 7c001910
		 5403063e 80010048 38210040 7c0803a6
		 83e1fffc 4e800020 7c0802a6 93e1fffc
		 90010008 9421ffc0 7c7f1b78 7fe3fb78
		 819f015c 480073f5 80410014 5460063e
		 5403077a 38000000 7c630050 3003ffff
		 7c001910 5403063e 80010048 38210040
		 7c0803a6 83e1fffc 4e800020 7c0802a6
		 bfc1fff8 90010008 9421ffc0 7c7e1b78
		 38624438 8be30000 57ff0734 7fc3f378
		 7fe4fb78 819e0158 48007391 80410014
		 38624438 9be30000 80010048 38210040
		 7c0803a6 bbc1fff8 4e800020 7c0802a6
		 bfc1fff8 90010008 9421ffc0 7c7e1b78
		 9881005f 38624438 8be30000 63ff0010
		 8801005f 28000000 4182000c 63ff0002
		 48000008 57ff07fa 7fc3f378 7fe4fb78
		 819e0158 48007325 80410014 38624438
		 9be30000 80010048 38210040 7c0803a6
		 bbc1fff8 4e800020 7c0802a6 bfc1fff8
		 90010008 9421ffc0 7c7e1b78 38624438
		 8be30000 57ff06f2 7fc3f378 7fe4fb78
		 819e0158 480072d5 80410014 38624438
		 9be30000 80010048 38210040 7c0803a6
		 bbc1fff8 4e800020 7c0802a6 bfc1fff8
		 90010008 9421ffc0 7c7e1b78 9881005f
		 38624438 8be30000 63ff0020 8801005f
		 28000000 4182000c 63ff0004 48000008
		 57ff07b8 7fc3f378 7fe4fb78 819e0158
		 48007269 80410014 38624438 9be30000
		 80010048 38210040 7c0803a6 bbc1fff8
		 4e800020 7c0802a6 bfa1fff4 90010008
		 9421ffb0 7c7d1b78 3bc00000 3be00000
		 48000040 7fa3eb78 4bfffe11 5460063e
		 28000001 40820018 7fa3eb78 4bfffda9
		 5460063e 28000001 41820024 7fa3eb78
		 480001dd 60000000 7c7e1b78 3bff0001
		 57e0063e 28000009 4180ffbc 7fc3f378
		 80010058 38210050 7c0803a6 bba1fff4
		 4e800020 7c0802a6 93e1fffc 90010008
		 9421ffc0 7c7f1b78 7fe3fb78 38800001
		 4bfffe3d 7fe3fb78 38800001 4bfffeed
		 7fe3fb78 4bfffdd9 7fe3fb78 4bfffe8d
		 38000000 38624438 98030000 80010048
		 38210040 7c0803a6 83e1fffc 4e800020
		 7c0802a6 bfc1fff8 90010008 9421ffc0
		 7c7f1b78 7fe3fb78 38800001 4bfffde1
		 3bc00000 4800002c 7fe3fb78 4bfffcd9
		 5460063e 28000001 41820020 7fe3fb78
		 3880fffa 4bff934d 60000000 3bde0001
		 2c1e01f4 4180ffd4 7fe3fb78 4bfffca9
		 80010048 38210040 7c0803a6 bbc1fff8
		 4e800020 7c0802a6 93e1fffc 90010008
		 9421ffc0 7c7f1b78 7fe3fb78 38800001
		 4bfffe29 7fe3fb78 3880fffd 4bff92f5
		 60000000 7fe3fb78 4bfffcb1 5460063e
		 28000000 4082000c 3860d54b 4800007c
		 7fe3fb78 3880fffd 4bff92c9 60000000
		 7fe3fb78 4bffff2d 5460063e 28000000
		 4082000c 3860d54c 48000050 7fe3fb78
		 3880fffd 4bff929d 60000000 7fe3fb78
		 38800000 4bfffdb5 7fe3fb78 3880fff7
		 4bff9281 60000000 7fe3fb78 38800000
		 4bfffcdd 7fe3fb78 3880fffd 4bff9265
		 60000000 38600000 80010048 38210040
		 7c0803a6 83e1fffc 4e800020 7c0802a6
		 93e1fffc 90010008 9421ffc0 7c7f1b78
		 7fe3fb78 38800000 4bfffc95 7fe3fb78
		 3880fffd 4bff921d 60000000 7fe3fb78
		 38800000 4bfffd35 7fe3fb78 3880fffd
		 4bff9201 60000000 7fe3fb78 4bfffe65
		 5460063e 28000000 4082000c 3860d54c
		 48000044 7fe3fb78 3880fffd 4bff91d5
		 60000000 7fe3fb78 3880fffa 4bff91c5
		 60000000 7fe3fb78 38800001 4bfffcdd
		 7fe3fb78 3880fffa 4bff91a9 60000000
		 38600000 80010048 38210040 7c0803a6
		 83e1fffc 4e800020 7c0802a6 93e1fffc
		 90010008 9421ffc0 7c7f1b78 9881005f
		 7fe3fb78 38800000 4bfffbd5 7fe3fb78
		 3880fffd 4bff915d 60000000 7fe3fb78
		 8881005f 4bfffc75 7fe3fb78 3880fffd
		 4bff9141 60000000 7fe3fb78 4bfffda5
		 5460063e 28000000 4082000c 3860d54c
		 48000034 7fe3fb78 3880fffa 4bff9115
		 60000000 7fe3fb78 38800000 4bfffb71
		 7fe3fb78 3880fffd 4bff90f9 60000000
		 38600000 80010048 38210040 7c0803a6
		 83e1fffc 4e800020 7c0802a6 bfc1fff8
		 90010008 9421ffc0 7c7f1b78 7fe3fb78
		 38800000 4bfffb29 7fe3fb78 3880fffd
		 4bff90b1 60000000 7fe3fb78 38800001
		 4bfffbc9 7fe3fb78 3880fffd 4bff9095
		 60000000 7fe3fb78 4bfffcf9 7fe3fb78
		 3880fffa 4bff907d 60000000 7fe3fb78
		 4bfffa39 7c7e1b78 7fe3fb78 38800000
		 4bfffacd 7fe3fb78 3880fffd 4bff9055
		 60000000 7fc3f378 80010048 38210040
		 7c0803a6 bbc1fff8 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ffb0 7c7d1b78
		 9881006f 3be00000 3bc00000 48000054
		 7fa3eb78 88a1006f 38800001 57c0063e
		 20000007 7c800030 7ca40038 38000000
		 7c840050 3004ffff 7c002110 5404063e
		 4bfffe59 7c7f1b78 7fe00734 2c000000
		 4182000c 7fe3fb78 48000030 3bde0001
		 57c0063e 28000008 4180ffa8 7fa3eb78
		 4bfffed9 5460063e 28000000 41820008
		 3be0d54c 7fe3fb78 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 bf61ffec 90010008 9421ffb0 7c7b1b78
		 9081006c 98a10073 3bc00000 3ba00000
		 3be00000 48000034 7f63db78 4bfffe7d
		 7c7c1b78 5780063e 28000000 41820018
		 38600001 57e0063e 20000007 7c600030
		 7fde0378 3bff0001 57e0063e 28000008
		 4180ffc8 8061006c 9bc30000 7f63db78
		 88810073 4bfffd85 7c7d1b78 7fa3eb78
		 80010058 38210050 7c0803a6 bb61ffec
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421ffc0 7c7f1b78 3bc00009 7fe3fb78
		 4bfffbb5 7fe3fb78 88820421 4bfffe91
		 7c600734 2c000000 40820020 7fe3fb78
		 38800000 4bfffe79 7fe3fb78 4bfffc61
		 38600001 48000028 7fe3fb78 4bfffc51
		 57c0063e 28000000 3bdeffff 4082ffb0
		 7fe3fb78 4bfffc39 38600000 80010048
		 38210040 7c0803a6 bbc1fff8 4e800020
		 7c0802a6 93e1fffc 90010008 9421ffc0
		 7c7f1b78 9881005f 7fe3fb78 4bfffb29
		 7fe3fb78 8881005f 4bfffe05 7fe3fb78
		 38800000 4bfffdf9 7fe3fb78 4bfffbe1
		 7fe3fb78 3880fe0c 4bff8e19 60000000
		 80010048 38210040 7c0803a6 83e1fffc
		 4e800020 7c0802a6 bf61ffec 90010008
		 9421ffb0 7c7f1b78 7c9b2378 7cbc2b78
		 90c10074 3ba00000 7fe3fb78 7f64db78
		 4bffff71 7fe3fb78 4bfffaad 7fe3fb78
		 63640001 4bfffd89 7c600734 2c000000
		 40820048 3bc00000 48000018 7fe3fb78
		 7c9cf214 38a00000 4bfffe15 3bde0001
		 80610074 3803ffff 7c1e0040 4180ffe0
		 7fe3fb78 7c9cf214 38a00001 4bfffdf1
		 3ba00001 48000008 3ba00000 7fe3fb78
		 4bfffb1d 7fa3eb78 80010058 38210050
		 7c0803a6 bb61ffec 4e800020 7c0802a6
		 bf21ffe4 90010008 9421ffa0 7c7e1b78
		 7c992378 7cba2b78 90c10084 7cfc3b78
		 3ba00000 7fc3f378 7f24cb78 4bfffeb5
		 7fc3f378 4bfff9f1 7fc3f378 63240001
		 4bfffccd 7c600734 2c000000 40820098
		 5780063e 28000001 4081008c 5780063e
		 28000001 40800008 3b800001 80820424
		 5783063e 3803ffff 7f6401d6 3be00000
		 48000018 7fc3f378 38810038 38a00000
		 4bfffd2d 3bff0001 7c1fd840 4180ffe8
		 3be00000 48000018 7fc3f378 7c9afa14
		 38a00000 4bfffd09 3bff0001 80610084
		 3803ffff 7c1f0040 4180ffe0 7fc3f378
		 7c9afa14 38a00001 4bfffce5 3ba00001
		 48000008 3ba00000 7fc3f378 4bfffa11
		 7fa3eb78 80010068 38210060 7c0803a6
		 bb21ffe4 4e800020 7c0802a6 bf41ffe8
		 90010008 9421ffb0 7c7a1b78 7c9b2378
		 7cbe2b78 3be00001 7f43d378 88820421
		 7fc5f378 80c20424 4bfffe0d 7c7f1b78
		 57e0063e 28000000 418200ec 3ba00000
		 48000028 7c1ee8ae 5404063e 80620430
		 7c03e8ae 7c040040 4182000c 3be00000
		 48000014 3bbd0001 8002042c 7c1d0040
		 4180ffd4 80020424 28000080 40820010
		 88020428 7c7e00ae 3b830001 80020424
		 28000100 40820014 88020428 7c1e00ae
		 7c033e70 3b830001 5763063e 5780063e
		 7c030040 40810008 3be00000 57e0063e
		 28000000 41820060 5760063e 28000001
		 40810054 80020424 28000080 40820020
		 7f43d378 88820421 7fc5f378 80c20424
		 7f67db78 4bfffdf9 7c7f1b78 80020424
		 28000100 40820020 7f43d378 88820421
		 38840002 7fc5f378 80c20424 4bfffd19
		 7c7f1b78 7fe3fb78 80010058 38210050
		 7c0803a6 bb41ffe8 4e800020 7c0802a6
		 bf81fff0 90010008 9421ffb0 7c7c1b78
		 9881006f 7cbd2b78 3bc00000 48000054
		 7f83e378 4bfffbe1 3be00000 48000010
		 380000ff 7c1df9ae 3bff0001 80020424
		 7c1f0040 4180ffec 7f83e378 8881006f
		 7fa5eb78 4bfffe65 5460063e 28000000
		 4182000c 38600001 48000014 3bde0001
		 281e0003 4180ffac 38600000 80010058
		 38210050 7c0803a6 bb81fff0 4e800020
		 bfc1fff8 3bc00000 3be00000 48000010
		 7c03f8ae 7fde0214 3bff0001 80020424
		 7c1f0040 4180ffec 57c0063e 28000000
		 4082000c 38600001 48000008 38600000
		 bbc1fff8 4e800020 7c0802a6 bf81fff0
		 90010008 9421ffb0 7c7f1b78 7c9e2378
		 3ba00000 801f0008 540007fe 28000000
		 4082000c 3860ffce 48000164 801f0004
		 28000000 41820018 801f0004 28000001
		 4182000c 3860ffce 48000144 7fc3f378
		 4bfff5d5 801f0004 28000000 40820070
		 380000a0 98020421 38000080 90020424
		 38022fc0 90020430 38000008 9002042c
		 3800007e 98020428 7fc3f378 4bfffa99
		 5460063e 28000000 4082000c 3860ffed
		 480000ec 7fc3f378 801f0000 5404063e
		 38bf0010 4bfffe69 5460063e 28000001
		 4182000c 3860ffed 480000c4 801f0004
		 28000001 40820098 380000a2 98020421
		 38000100 90020424 38022fc8 90020430
		 38000001 9002042c 3800007e 98020428
		 3b800000 4800004c 7fc3f378 4bfffa19
		 5460063e 28000000 4182001c 7fc3f378
		 801f0000 5404063e 38bf0010 4bfffdf1
		 7c7d1b78 57a0063e 28000001 4182001c
		 88620421 38030004 98020421 3b9c0001
		 2c1c0002 4180ffb4 57a0063e 28000000
		 4082000c 3860ffed 48000024 387f0010
		 4bfffe41 5460063e 28000001 4182000c
		 3860ffed 48000008 38600000 80010058
		 38210050 7c0803a6 bb81fff0 4e800020
		 88030629 28000001 40820018 800200dc
		 9003015c 800200d8 90030158 48000030
		 800200d4 9003015c 800200d0 90030158
		 88030684 28000001 40820014 800200dc
		 9003015c 800200d8 90030158 4e800020
		 7c0802a6 bf81fff0 90010008 9421ffb0
		 7c7f1b78 7fe3fb78 38800158 4bff8fad
		 60000000 7c7e1b78 57de007e 7fe3fb78
		 38800050 4bff8f95 60000000 7c7d1b78
		 7fe3fb78 38800140 4bff8f81 60000000
		 7c7c1b78 7fe3fb78 38800050 67a50400
		 4bff8f2d 60000000 7fe3fb78 38800140
		 67850800 4bff8f19 60000000 7fe3fb78
		 38800014 4bff879d 60000000 7fe3fb78
		 38800158 7fc5f378 4bff8ef5 60000000
		 7fe3fb78 3880000f 4bff8779 60000000
		 7fe3fb78 38800158 67c58000 4bff8ed1
		 60000000 7fe3fb78 38800158 7fc5f378
		 4bff8ebd 60000000 7fe3fb78 3880000f
		 4bff8741 60000000 7fe3fb78 38800140
		 7f85e378 4bff8e99 60000000 7fe3fb78
		 38800050 7fa5eb78 4bff8e85 60000000
		 7fe3fb78 3880000f 4bff8709 60000000
		 80010058 38210050 7c0803a6 bb81fff0
		 4e800020 7c0802a6 93e1fffc 90010008
		 9421ffc0 7c7f1b78 b081005e 90a10060
		 7fe3fb78 38800008 a001005e 7c001670
		 60050080 4bff8c59 60000000 7fe3fb78
		 3880000c 80a10060 4bff8e15 60000000
		 80010048 38210040 7c0803a6 83e1fffc
		 4e800020 7c0802a6 bfc1fff8 90010008
		 9421ffc0 7c7e1b78 7c9f2378 98a10063
		 7fc3f378 38800008 57e0043e 7c001670
		 60050080 4bff8bf9 60000000 7fc3f378
		 57e407be 3884000c 88a10063 4bff8be1
		 60000000 80010048 38210040 7c0803a6
		 bbc1fff8 4e800020 7c0802a6 93e1fffc
		 90010008 9421ffc0 7c7f1b78 b081005e
		 7fe3fb78 38800008 a001005e 7c001670
		 5405063e 4bff8b99 60000000 7fe3fb78
		 3880000c 4bff8d95 60000000 80010048
		 38210040 7c0803a6 83e1fffc 4e800020
		 7c0802a6 bfc1fff8 90010008 9421ffc0
		 7c7e1b78 7c9f2378 7fc3f378 38800008
		 57e0043e 7c001670 5405063e 4bff8b41
		 60000000 7fc3f378 57e407bc 3884000c
		 4bff8cc5 60000000 80010048 38210040
		 7c0803a6 bbc1fff8 4e800020 7c0802a6
		 bfc1fff8 90010008 9421ffc0 7c7e1b78
		 7c9f2378 7fc3f378 38800008 57e0043e
		 7c001670 5405063e 4bff8ae5 60000000
		 7fc3f378 57e407be 3884000c 4bff8b15
		 60000000 80010048 38210040 7c0803a6
		 bbc1fff8 4e800020 93e1fffc 3be00000
		 48000028 5465063e 388231a8 57e0103a
		 7c04002e 7c050000 4082000c 57e3063e
		 48000020 3bff0001 388231a8 57e0103a
		 7c04002e 2c00ffff 4082ffcc 38600000
		 83e1fffc 4e800020 93e1fffc 3be00000
		 48000028 5465063e 388231cc 57e0103a
		 7c04002e 7c050000 4082000c 57e3063e
		 48000020 3bff0001 388231cc 57e0103a
		 7c04002e 2c00ffff 4082ffcc 38600000
		 83e1fffc 4e800020 dbe1fff8 dbc1fff0
		 dba1ffe8 7c0621d6 7c0501d6 c8220480
		 6c008000 9001ffdc 3c004330 9001ffd8
		 c801ffd8 ffc00828 7c0719d6 c8220480
		 6c008000 9001ffd4 3c004330 9001ffd0
		 c801ffd0 ffe00828 c8020488 fc00f800
		 4082000c 38600000 48000014 ffbef824
		 fc00e81e d801ffd0 8061ffd4 cbe1fff8
		 cbc1fff0 cba1ffe8 4e800020 dbe1fff8
		 dbc1fff0 dba1ffe8 7c0321d6 7c0701d6
		 c8220480 6c008000 9001ffdc 3c004330
		 9001ffd8 c801ffd8 ffc00828 7c0629d6
		 c8220480 6c008000 9001ffd4 3c004330
		 9001ffd0 c801ffd0 ffe00828 c8020488
		 fc00f800 4082000c 38600000 48000014
		 ffbef824 fc00e81e d801ffd0 8061ffd4
		 cbe1fff8 cbc1fff0 cba1ffe8 4e800020
		 7c0802a6 bf21ffe4 90010008 9421ff90
		 90610088 7c992378 7cba2b78 388231f0
		 80640000 80040004 90610038 9001003c
		 80640008 8004000c 90610040 90010044
		 386243a4 80630000 3880000c 4bfffd55
		 5460043e 541d05be 3b600001 3be00000
		 4800006c 80610088 57e0083c 38810038
		 7c8402ae 7f65db78 38c00b86 7fa7eb78
		 4bfffefd 7c7e1b78 2c1e007d 4180003c
		 2c1e0258 41810034 93da0000 57e0083c
		 38610038 7c0302ae 90190000 1c1e0b86
		 7c1b01d6 7f80ebd6 2c1c30d4 4081000c
		 2c1c61a8 4180001c 3bff0001 57e0083c
		 38610038 7c0302ae 2c000000 4082ff88
		 80790000 809a0000 38a00001 38c00b86
		 7fa7eb78 4bfffe05 80010078 38210070
		 7c0803a6 bb21ffe4 4e800020 7c0802a6
		 bf01ffe0 90010008 9421ffa0 90610078
		 7c982378 7cb92b78 3b623200 386243a4
		 80630000 38800028 4bfffcc5 547d063e
		 3b800002 3be00000 4800005c 80610078
		 7c9bf8ae 7f85e378 38c00b86 7fa7eb78
		 4bfffe1d 7c7e1b78 2c1e0000 40810034
		 2c1e00ff 4080002c 93d90000 7c1bf8ae
		 90180000 1c1e0b86 7c1c01d6 7f40ebd6
		 2c1a30d4 4081000c 2c1a61a8 41800014
		 3bff0001 7c1bf8ae 28000000 4082ffa0
		 80780000 80990000 7f85e378 38c00b86
		 7fa7eb78 4bfffd35 80010068 38210060
		 7c0803a6 bb01ffe0 4e800020 7c0802a6
		 bf41ffe8 90010008 9421ffa0 7c7a1b78
		 7c9b2378 7f43d378 3880000c 4bfffba5
		 5460043e 541c05be 7f601670 7c000194
		 5400103a 7c00d810 7c1b0378 7f43d378
		 5764103a 38840010 4bfffb21 7c7f1b78
		 57fe057e 57fd877e 386231a8 57a0103a
		 7c63002e 7fc4f378 38a00001 38c00b86
		 7f87e378 4bfffca5 80010068 38210060
		 7c0803a6 bb41ffe8 4e800020 7c0802a6
		 bf81fff0 90010008 9421ffb0 7c7e1b78
		 7fc3f378 38800028 4bfffb75 547c063e
		 7fc3f378 38800029 4bfffb65 547d063e
		 7fc3f378 38800034 4bfffb55 5460063e
		 541f077e 2c1f0000 4082000c 386019c8
		 480000b0 7fc3f378 38800125 4bff8685
		 60000000 5460063e 2800001b 40820074
		 2c1f0007 4182000c 2c1f0001 40820064
		 7fc3f378 38800f58 4bff8659 60000000
		 5460063e 5400077e 2c000003 4182003c
		 40800014 2c000001 41820018 4080001c
		 48000028 2c000005 40800020 48000014
		 386019c8 4800003c 386033f4 48000034
		 386067e8 4800002c 386019c8 48000024
		 386231cc 57e0103a 7c63002e 7fa4eb78
		 38a00002 38c00b86 7f87e378 4bfffb8d
		 80010058 38210050 7c0803a6 bb81fff0
		 4e800020 7c0802a6 bf81fff0 90010008
		 9421ffb0 7c7e1b78 7fc3f378 38800028
		 4bfffa5d 547c063e 7fc3f378 3880002a
		 4bfffa4d 547d063e 7fc3f378 3880003c
		 4bfffa3d 5460063e 541f077e 2c1f0000
		 4082000c 386019c8 48000038 2c1f0005
		 40820010 7fc3f378 4bfffe85 48000024
		 386231cc 57e0103a 7c63002e 7fa4eb78
		 38a00002 38c00b86 7f87e378 4bfffaed
		 80010058 38210050 7c0803a6 bb81fff0
		 4e800020 7c0802a6 93e1fffc 90010008
		 9421ffc0 7c7f1b78 7fe3fb78 38800030
		 38a23190 80050000 64050002 60a50002
		 4bfff835 7fe3fb78 3880000f 4bff7f15
		 60000000 7fe3fb78 38800030 38a23190
		 80a50000 4bfff811 7fe3fb78 3880000f
		 4bff7ef1 60000000 80010048 38210040
		 7c0803a6 83e1fffc 4e800020 7c0802a6
		 bf81fff0 90010008 9421ffb0 7c7f1b78
		 9081006c 8061006c 3881003c 38a10038
		 4bfffc4d 7c7c1b78 8001003c 5403063e
		 4bfff9d9 5460063e 541e077e 3bbeffff
		 7fe3fb78 38800029 80010038 5405063e
		 4bfff7f5 881f0680 28000000 40820060
		 7fe3fb78 3880002c 4bfff8f5 546507fa
		 7fe3fb78 3880002c 4bfff7cd 7fe3fb78
		 3880000f 4bff7e4d 60000000 7fe3fb78
		 3880002c 4bfff8c9 5465003a 7fe3fb78
		 3880002c 4bfff7a1 7fe3fb78 3880000f
		 4bff7e21 60000000 4800002c 7fe3fb78
		 38800034 38a00087 4bfff77d 3ba00008
		 3bc00007 7fe3fb78 3880002c 38a00003
		 4bfff765 7fe3fb78 38800034 38a2319c
		 80050000 5405002e 57a02036 7c00f378
		 7ca50378 4bfff6e1 7fe3fb78 3880000f
		 4bff7dc1 60000000 7fe3fb78 4bfffe69
		 7fe3fb78 4bfffca9 7c7c1b78 7f83e378
		 80010058 38210050 7c0803a6 bb81fff0
		 4e800020 7c0802a6 bfa1fff4 90010008
		 9421ffb0 7c7f1b78 9081006c 8061006c
		 3881003c 38a10038 4bfffb05 7c7d1b78
		 8001003c 5403063e 4bfff891 5460063e
		 541e077e 881f0680 28000000 40820094
		 7fe3fb78 3880002a 80010038 5405063e
		 4bfff6a5 7fe3fb78 38800038 4bfff7b1
		 5465003c 7fe3fb78 38800038 4bfff689
		 7fe3fb78 3880000f 4bff7d09 60000000
		 7fe3fb78 38800038 4bfff785 5465003a
		 7fe3fb78 38800038 4bfff65d 7fe3fb78
		 3880000f 4bff7cdd 60000000 7fe3fb78
		 3880003c 4bfff759 54600038 7fc50378
		 7fe3fb78 3880003c 4bfff62d 48000024
		 7fe3fb78 3880003c 38a00005 4bfff619
		 7fe3fb78 38800038 38a00003 4bfff609
		 7fe3fb78 3880000f 4bff7c89 60000000
		 7fa3eb78 80010058 38210050 7c0803a6
		 bba1fff4 4e800020 7c0802a6 bf61ffec
		 90010008 9421ffa0 7c7f1b78 7c9e2378
		 7cbb2b78 7fe3fb78 3880000c 38a0003b
		 4bfff555 7f63db78 38810040 38a1003c
		 4bfff8c1 7c7c1b78 80010040 5403063e
		 4bfff709 5460063e 541d077e 7fc01670
		 7c000194 5400103a 7c00f010 7c1e0378
		 7fe3fb78 38800009 57c5063e 4bff8191
		 60000000 7fe3fb78 57c4103a 38840010
		 57a0801e 60058000 8001003c 7ca50378
		 4bfff4e5 7fe3fb78 38800008 4bfff651
		 546507fa 7fe3fb78 38800008 4bfff529
		 7fe3fb78 3880000f 4bff7ba9 60000000
		 7fe3fb78 38800008 4bfff625 5465003a
		 7fe3fb78 38800008 4bfff4fd 7fe3fb78
		 3880000f 4bff7b7d 60000000 7fe3fb78
		 38800020 38a00003 4bfff4dd 38000000
		 901f05e0 2c1b36b0 4081000c 38000001
		 901f05e0 7fe3fb78 38800021 801f05e0
		 5405063e 4bfff4b1 7f83e378 80010068
		 38210060 7c0803a6 bb61ffec 4e800020
		 7c0802a6 93e1fffc 90010008 9421ffc0
		 7c7f1b78 7fe3fb78 38800004 38a2318c
		 88a50000 4bfff471 7fe3fb78 38800034
		 38a00000 4bfff461 7fe3fb78 3880003c
		 38a00000 4bfff451 7fe3fb78 38800020
		 38a00000 4bfff441 7fe3fb78 3880002c
		 38a00003 4bfff431 7fe3fb78 38800038
		 38a00003 4bfff421 7fe3fb78 38800030
		 38a23190 80050000 64050003 60a50003
		 4bfff3a5 7fe3fb78 38800009 38a0006d
		 4bfff3f5 7fe3fb78 3880002d 38a0008d
		 4bfff3e5 7fe3fb78 38800039 38a0008d
		 4bfff3d5 7fe3fb78 3880000a 38a00000
		 4bfff3c5 7fe3fb78 38800024 38a00000
		 4bfff355 7fe3fb78 38800028 38a0003b
		 4bfff3a5 7fe3fb78 388036b0 4bfffb51
		 7fe3fb78 38802e18 4bfffc8d 7fe3fb78
		 38800040 3ca04a47 4bfff31d 80010048
		 38210040 7c0803a6 83e1fffc 4e800020
		 7c0802a6 bfc1fff8 90010008 9421ffb0
		 7c7f1b78 7fe3fb78 38800053 4bff7fb5
		 60000000 7c7e1b78 7fe3fb78 38800053
		 38a00001 4bff7f59 60000000 7fe3fb78
		 38800058 4bff8155 60000000 60650008
		 7fe3fb78 38800058 4bff8105 60000000
		 7fe3fb78 38800230 3ca00046 38a54646
		 4bff80ed 60000000 7fe3fb78 38800032
		 4bff7971 60000000 7fe3fb78 38800058
		 4bff8109 60000000 54600630 90010038
		 7fe3fb78 38800230 38a00000 4bff80b1
		 60000000 7fe3fb78 38800053 7fc5f378
		 4bff7ecd 60000000 7fe3fb78 38800058
		 4bff80c9 60000000 54650776 7fe3fb78
		 38800058 4bff8079 60000000 7fe3fb78
		 38800000 4bff55dd 60000000 38000007
		 7c630050 3003ffff 7c601910 80010038
		 7c001b78 90010038 7fe3fb78 38820434
		 38a10038 38c00004 4bff28f9 60000000
		 80610038 38000000 7c630050 3003ffff
		 7c001910 5403063e 80010058 38210050
		 7c0803a6 bbc1fff8 4e800020 7c0802a6
		 93e1fffc 90010008 9421ffc0 7c7f1b78
		 7fe3fb78 38800030 3ca071b4 38a5a340
		 4bff7fdd 60000000 7fe3fb78 38800034
		 38a0001f 4bff7fc9 60000000 7fe3fb78
		 38800058 3ca0ff00 38a50102 4bff7fb1
		 60000000 7fe3fb78 388000f0 38a00000
		 4bff7f9d 60000000 7fe3fb78 38800130
		 38a02054 4bff7f89 60000000 7fe3fb78
		 38800128 3ca00069 38a50008 4bff7f71
		 60000000 7fe3fb78 388016a0 38a00000
		 4bff7f5d 60000000 7fe3fb78 38801720
		 38a00000 4bff7f49 60000000 7fe3fb78
		 388015a8 38a00000 4bff7f35 60000000
		 7fe3fb78 388015a4 38a00000 4bff7f21
		 60000000 7fe3fb78 38801744 38a00122
		 4bff7f0d 60000000 7fe3fb78 38800168
		 4bff7f39 60000000 5460041c 64050010
		 7fe3fb78 38800168 4bff7ee5 60000000
		 7fe3fb78 38800b44 38a02700 4bff7ed1
		 60000000 7fe3fb78 38800054 4bff7efd
		 60000000 64650010 7fe3fb78 38800054
		 4bff7ead 60000000 7fe3fb78 38800090
		 38a00000 4bff7e99 60000000 7fe3fb78
		 38800094 38a00000 4bff7e85 60000000
		 80010048 38210040 7c0803a6 83e1fffc
		 4e800020 7c0802a6 93e1fffc 90010008
		 9421ffc0 7c7f1b78 9881005f 8801005f
		 28000000 4182002c 7fe3fb78 38800054
		 4bff7cb1 60000000 60650400 7fe3fb78
		 38800054 4bff7c59 60000000 48000028
		 7fe3fb78 38800054 4bff7c89 60000000
		 546505a8 7fe3fb78 38800054 4bff7c31
		 60000000 80010048 38210040 7c0803a6
		 83e1fffc 4e800020 7c0802a6 be21ffc4
		 90010008 9421ff80 7c7f1b78 7c9e2378
		 7cb12b78 7cd23378 98e100ab 992100b3
		 3b200000 a2fe0016 a27e001e 880100b3
		 28000000 4182029c 7fe3fb78 38800053
		 38a00003 4bff7bc9 60000000 7fe3fb78
		 38800054 4bff7dc5 60000000 54650626
		 7fe3fb78 38800054 4bff7d75 60000000
		 7fe3fb78 38800200 56e5e8fe 38a5ffff
		 4bff7ce9 60000000 7fe3fb78 38800202
		 a01e0014 7c051e70 7ca50194 38a5ffff
		 4bff7cc9 60000000 7fe3fb78 38800024
		 56e0077e 5405063e 4bffef2d a01e001a
		 7c1d1e70 7fbd0194 a01e001a 7c1d1e70
		 7fbd0194 a01e000c 540007fe 2c000000
		 40820008 63bd0080 7fe3fb78 38800206
		 57a5043e 4bff7c75 60000000 7fe3fb78
		 38800208 38b3ffff 4bff7c61 60000000
		 7fe3fb78 3880020a a0be001c 38a5ffff
		 4bff7c49 60000000 a01e001c a07e0020
		 3ba3ffff 7fa0ea14 a01e0022 5400801e
		 7fbd0378 a01e001c a07e0020 3ba3ffff
		 7fa0ea14 a01e0022 5400801e 7fbd0378
		 a01e000c 540007bc 2c000000 40820008
		 67bd0080 7fe3fb78 3880020c 7fa5eb78
		 4bff7c5d 60000000 881f061c 28000000
		 41820024 7fe3fb78 809f05f0 80840010
		 38bf00a4 4800030d 60000000 5478063e
		 4800001c 7fe3fb78 809e0010 38bf00a4
		 480002f1 60000000 5478063e 7fe3fb78
		 38800009 7f05c378 4bff7a35 60000000
		 7fe3fb78 38800050 4bff7c31 60000000
		 547c002e a01e000a 540007bc 2c000000
		 4182000c 639c0002 48000008 579c07fa
		 a01e000a 540007fe 2c000000 41820034
		 801f0140 28000000 4182001c 801f0140
		 28000001 4082001c 881f0154 28000000
		 40820010 639c0010 3b200001 4800000c
		 579c0734 3b200000 5720063e 28000000
		 4182005c 7fe3fb78 38800204 4bff7bad
		 60000000 7c7d1b78 57bd024e 7fe3fb78
		 38800204 7fa5eb78 4bff7b55 60000000
		 7fe3fb78 3880020c 4bff7b81 60000000
		 7c7d1b78 57bd024e 7fe3fb78 3880020c
		 7fa5eb78 4bff7b29 60000000 7fe3fb78
		 38800050 7f85e378 4bff7b15 60000000
		 7fe3fb78 38800204 a0be0014 a01e0018
		 7ca50214 4bff7a85 60000000 5640043e
		 5400e8fe 5400b012 901f012c 5620e8fe
		 901f0130 7fe3fb78 38800224 562501fe
		 4bff7acd 60000000 7fe3fb78 38800228
		 38a00000 4bff7ab9 60000000 7fe3fb78
		 3880022c 5640043e 7c001e70 5405043e
		 4bff7a29 60000000 8a8100ab 7e940774
		 3b400000 3b600000 2c140010 4182002c
		 40800010 2c140008 41820014 48000030
		 2c140020 41820020 48000024 3b400000
		 3b600002 48000018 3b400001 3b600003
		 4800000c 3b400002 3b600006 7fe3fb78
		 3880028c 4bff7a75 60000000 7c761b78
		 7fe3fb78 38800290 4bff7a61 60000000
		 7c751b78 7fe3fb78 38800051 4bff7885
		 60000000 5460063e 5403077e 5760063e
		 7c001800 4182002c 7fe3fb78 3880028c
		 56c50188 4bff79e9 60000000 7fe3fb78
		 38800290 56a5020c 4bff79d5 60000000
		 7fe3fb78 38800051 4bff7839 60000000
		 54600038 7f650378 7fe3fb78 38800051
		 4bff77dd 60000000 7fe3fb78 3880028c
		 7ec5b378 4bff7999 60000000 7fe3fb78
		 38800290 7ea5ab78 4bff7985 60000000
		 881f0030 28000000 41820034 7fe3fb78
		 388000e0 4bff77dd 60000000 546307b6
		 5740063e 5400103a 7c051b78 7fe3fb78
		 388000e0 4bff7779 60000000 80010088
		 38210080 7c0803a6 ba21ffc4 4e800020
		 7c0802a6 93e1fffc 90010008 9421ffc0
		 90610058 9081005c 90a10060 3be00000
		 80610058 57e4043e 80a1005c 4bfff52d
		 80810060 90640000 57e3043e 80010048
		 38210040 7c0803a6 83e1fffc 4e800020
		 bfa1fff4 80040010 28000000 4182001c
		 a0040014 28000000 41820010 a004001c
		 28000000 4082000c 38600080 4800007c
		 3be00000 80a300a0 38c5f000 a0a40014
		 a004001c 7c0501d6 7fc60396 3ca00002
		 38a586a0 80040010 7fa50396 7c1ee840
		 40810008 7fbeeb78 281e0001 41800008
		 3be00080 281e0002 41800008 3be00081
		 281e0004 41800008 3be00082 88030150
		 28000000 41820010 281f0000 41820008
		 3be00080 7fe3fb78 bba1fff4 4e800020
		 7c0802a6 bda1ffb4 90010008 9421fec0
		 7c7e1b78 38622fca 38a100a6 3883fff8
		 38000004 7c0903a6 84640008 80040004
		 94650008 90050004 4200fff0 3862302a
		 38a10092 3883fff8 38000002 7c0903a6
		 84640008 80040004 94650008 90050004
		 4200fff0 80040008 90050008 38623066
		 38a10052 3883fff8 38000008 7c0903a6
		 84640008 80040004 94650008 90050004
		 4200fff0 38623126 38a1003a 3883fff8
		 38000003 7c0903a6 84640008 80040004
		 94650008 90050004 4200fff0 3882316e
		 80640000 80040004 90610038 9001003c
		 a0040008 b0010040 7fc3f378 4bffeee1
		 7c7c1b78 3ba00000 4800001c 38623208
		 57a0103a 7c03002e 7c1c0040 4180001c
		 3bbd0001 38623208 57a0103a 7c03002e
		 28000000 4082ffd8 a80100cc 5408d808
		 a80100ca 5407d00a a80100c8 5406c80c
		 a80100c6 5405c00e a80100c4 5404b810
		 a80100c2 5403b012 a80100c0 5400a814
		 a92100be 5536a016 a92100bc 5537801e
		 a92100ba 55387022 a92100b8 55396026
		 a92100b6 553a402e a92100b4 553b3032
		 a92100b2 552c2036 a92100b0 552b1838
		 57aae006 a92100ae 7d494b78 7d694b78
		 7d894b78 7f694b78 7f494b78 7f294b78
		 7f094b78 7ee94b78 7ec94b78 7c004b78
		 7c600378 7c800378 7ca00378 7cc00378
		 7ce00378 7d1f0378 7fc3f378 38800140
		 7fe5fb78 4bff7649 60000000 a921009a
		 a801009c 5408103a a801009e 54072036
		 a80100a0 5406402e a80100a2 5405502a
		 a80100a4 54046026 a80100a6 54037022
		 a80100a8 54007820 a94100ac 554be006
		 a94100aa 554a801e 7d6a5378 7c005378
		 7c600378 7c800378 7ca00378 7cc00378
		 7ce00378 7d000378 7d3f0378 7fc3f378
		 38800144 7fe5fb78 4bff75c5 60000000
		 a921005a a801005c 5408083c a801005e
		 5407103a a8010060 54061838 a8010062
		 54052036 a8010064 54042834 a8010066
		 54033032 a8010068 540c3830 a801006a
		 540d402e a801006c 540e482c a801006e
		 540f502a a8010070 54105828 a8010072
		 54116026 a8010074 54126824 a8010076
		 54137022 a8010078 54147820 a801007a
		 5415801e a801007c 541b881c a801007e
		 541a901a a8010080 54199818 a8010082
		 5418a016 a8010084 5417a814 a8010086
		 5416b012 a8010088 5400b810 900100d0
		 a801008a 5400c00e 900100d4 a801008c
		 5400c80c 900100d8 a801008e 5400d00a
		 900100dc a8010090 5400d808 900100e0
		 a8010092 5400e006 900100e4 a8010094
		 5400e804 a9410098 554bf800 a9410096
		 554af002 7d6a5378 7c0a5378 800100e4
		 7c0a5378 800100e0 7c0a5378 800100dc
		 7c0a5378 800100d8 7c0a5378 800100d4
		 7c0a5378 800100d0 7c005378 7ec00378
		 7ee00378 7f000378 7f200378 7f400378
		 7f600378 7ea00378 7e800378 7e600378
		 7e400378 7e200378 7e000378 7de00378
		 7dc00378 7da00378 7d800378 7c600378
		 7c800378 7ca00378 7cc00378 7ce00378
		 7d000378 7d3f0378 7fc3f378 3880014c
		 7fe5fb78 4bff7409 60000000 a9410042
		 a8010044 54092036 a8010046 5408402e
		 a8010048 54076026 a801004a 5406801e
		 a801004c 5405a016 a801004e 5404b810
		 a8010050 5403c00e a8010052 541be006
		 a8010054 540ce804 a8010058 5400f800
		 a9610056 556bf002 7c005b78 7d800378
		 7f600378 7c600378 7c800378 7ca00378
		 7cc00378 7ce00378 7d000378 7d200378
		 7d5f0378 7fc3f378 38800150 7fe5fb78
		 4bff736d 60000000 3fe01041 3bff8408
		 7fc3f378 38800154 7fe5fb78 4bff7351
		 60000000 80010148 38210140 7c0803a6
		 b9a1ffb4 4e800020 7c0802a6 93e1fffc
		 90010008 9421ffc0 7c7f1b78 7fe3fb78
		 388000f8 4bff7355 60000000 38038000
		 901f00a0 7fe3fb78 38800140 4bff733d
		 60000000 5460273e 5400063e 981f05e4
		 80010048 38210040 7c0803a6 83e1fffc
		 4e800020 93e1fffc 3be0001f 48000024
		 38000001 7c00f830 7c600038 28000000
		 4182000c 387f0001 48000014 3bffffff
		 2c1f0000 4080ffdc 38600001 83e1fffc
		 4e800020 7c0802a6 4bffd2ad be41ff98
		 90010008 9421ff00 7c7f1b78 801f00a4
		 2c000000 40820028 7fe3fb78 38800009
		 4bff70e1 60000000 5460063e 540407be
		 7fe3fb78 4bffe959 907f00a4 7fe3fb78
		 38800140 4bff7285 60000000 7c7e1b78
		 57c3c7be 3ac30001 7fe3fb78 38800144
		 4bff7269 60000000 7c7e1b78 57c307be
		 3ae30001 57c3f7be 3b630001 57c3a7be
		 3aa30001 57d4b7be c3c20478 7fe3fb78
		 3880028c 4bff7235 60000000 7c7e1b78
		 57c0014a 28000000 41820040 57c0018c
		 28000000 41820030 c8420470 57c0043e
		 c8220438 90010094 3c004330 90010090
		 c8010090 ec000828 ffc20024 ffc0f018
		 48000008 c3c20468 7fe3fb78 4bffe931
		 c8220480 6c608000 90010094 3c004330
		 90010090 c8010090 fc200828 c8020460
		 fc000072 fc000018 ec5e0032 807f00a4
		 801f0124 7c0301d6 c8220438 9001008c
		 3c004330 90010088 c8010088 ec000828
		 efe20024 fc20f890 4bffd0d5 4bfffe69
		 7c791b78 3b990001 3a600020 c8420458
		 3813fffc c8220480 6c008000 90010084
		 3c004330 90010080 c8010080 ec000828
		 ec1f0032 fc02002a fc00001e d8010078
		 8001007c c8220480 6c008000 90010074
		 3c004330 90010070 c8010070 ef800828
		 3bb6000c 3b400004 7fe3fb78 38800158
		 4bff7109 60000000 7c7e1b78 57d867be
		 7fe3fb78 38800148 4bff70f1 60000000
		 7c600034 5400d97e 540005ee 2c000000
		 4182000c 3bbd0001 3b400008 c0020478
		 fc1e0040 7c000026 540017fe 1c000005
		 c8220480 6c008000 90010074 3c004330
		 90010070 c8010070 fc000828 c8420480
		 6e808000 9001007c 3c004330 90010078
		 c8210078 fd411028 c8420480 6f008000
		 90010084 3c004330 90010080 c8210080
		 fd211028 c8420480 6ea08000 9001008c
		 3c004330 90010088 c8210088 fd011028
		 c8e20450 c8420480 6ee08000 90010094
		 3c004330 90010090 c8210090 fcc11028
		 c8a20448 c8420480 6f408000 9001006c
		 3c004330 90010068 c8210068 fc811028
		 c8620440 381bfffe 2c000000 4081000c
		 381bfffe 48000008 38000000 c8420480
		 6c008000 90010064 3c004330 90010060
		 c8210060 fc211028 fc230072 fc25093a
		 fc2709ba fc28082a fc29082a fc2a082a
		 fc3f082a ff60082a ff60d818 38600001
		 201c000b 7c600030 c8220480 6c008000
		 9001005c 3c004330 90010058 c8010058
		 efa00828 ec1f0772 fc00001e d8010050
		 83c10054 5780073e 5400801e 7fde0378
		 57a006fe 5400a016 7fde0378 7fe3fb78
		 388002e0 7fc5f378 4bff6f15 60000000
		 ec1b0772 fc00001e d8010048 8001004c
		 541e801e ec1c0772 fc00001e d8010040
		 80010044 7fde0378 7fe3fb78 388002e4
		 7fc5f378 4bff6ed9 60000000 7fe3fb78
		 38800009 4bff6d3d 60000000 5460063e
		 541207be 7fe3fb78 4bffe645 90610038
		 7fe3fb78 3882323c 38a10038 38c00004
		 4bff1761 60000000 7fe3fb78 4bffe739
		 90610038 7fe3fb78 38823244 38a10038
		 38c00004 4bff173d 60000000 7fe3fb78
		 7e449378 4bffe569 90610038 7fe3fb78
		 3882324c 38a10038 38c00004 4bff1715
		 60000000 38000b86 90010038 7fe3fb78
		 38823254 38a10038 38c00004 4bff16f5
		 60000000 801f00a4 90010038 7fe3fb78
		 3882325b 38a10038 38c00004 4bff16d5
		 60000000 80010108 38210100 4bffce69
		 7c0803a6 ba41ff98 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ffb0 7c7d1b78
		 7c9f2378 3bc00000 57e0063e 540006b4
		 2c000000 4182001c 57e0063e 5400077a
		 2c000000 4082000c 38000002 48000008
		 38000000 7fde0378 57e0063e 540006f6
		 2c000000 4182001c 57e0063e 540007bc
		 2c000000 4082000c 38000004 48000008
		 38000000 7fde0378 57e0063e 54000738
		 2c000000 4182001c 57e0063e 540007fe
		 2c000000 4082000c 38000001 48000008
		 38000000 7fde0378 7fa3eb78 38800068
		 38a00000 4bff6b69 60000000 7fa3eb78
		 3880006b 38a00007 4bff6b55 60000000
		 7fa3eb78 3880006a 7fc5f378 4bff6b41
		 60000000 80010058 38210050 7c0803a6
		 bba1fff4 4e800020 7c0802a6 bfc1fff8
		 90010008 9421ffc0 90610058 3be00000
		 80610058 38800069 4bff6b49 60000000
		 7c7e1b78 57c0063e 540007bc 2c000000
		 4182000c 38000004 48000008 38000000
		 7fff0378 57c0063e 5400077a 2c000000
		 4182000c 38000002 48000008 38000000
		 7fff0378 57c0063e 540007fe 2c000000
		 4182000c 38000001 48000008 38000000
		 7fff0378 7fe3fb78 80010048 38210040
		 7c0803a6 bbc1fff8 4e800020 7c0802a6
		 bfa1fff4 90010008 9421ffb0 7c7f1b78
		 7c9d2378 3bc00000 57a0063e 540006b4
		 2c000000 4182001c 57a0063e 5400077a
		 2c000000 4082000c 3c000040 48000008
		 38000000 7fde0378 57a0063e 540006f6
		 2c000000 4182001c 57a0063e 540007bc
		 2c000000 4082000c 3c000080 48000008
		 38000000 7fde0378 7fe3fb78 3880009c
		 4bff6c09 60000000 646500c0 7fe3fb78
		 3880009c 4bff6bb9 60000000 7fe3fb78
		 388000a0 4bff6be5 60000000 5465028e
		 7fe3fb78 388000a0 4bff6b95 60000000
		 7fe3fb78 388000a8 4bff6bc1 60000000
		 5460028e 7fc50378 7fe3fb78 388000a8
		 4bff6b6d 60000000 80010058 38210050
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 bfc1fff8 90010008 9421ffc0 90610058
		 3be00000 80610058 388000a4 4bff6b6d
		 60000000 7c7e1b78 57c00252 28000000
		 4182000c 38000004 48000008 38000000
		 7fff0378 57c00210 28000000 4182000c
		 38000002 48000008 38000000 7fff0378
		 7fe3fb78 80010048 38210040 7c0803a6
		 bbc1fff8 4e800020 7c0802a6 90010008
		 9421ffc0 90610058 b081005e b0a10062
		 80600544 3c800073 38843002 3ca00001
		 38a5a051 80c10058 a001005e 5407801e
		 a0010062 7ce70214 48003cf9 80410014
		 80010048 38210040 7c0803a6 4e800020
		 7c0802a6 93e1fffc 90010008 9421ffb0
		 7c7f1b78 38610038 38800004 38a000fc
		 4bffff89 281f0000 4182000c 80010038
		 901f0000 80610038 3c03adb2 2800494e
		 4082000c 38600001 48000008 38600000
		 80010058 38210050 7c0803a6 83e1fffc
		 4e800020 7c0802a6 bfa1fff4 90010008
		 9421ffa0 7c7d1b78 7c9f2378 3bc0ffef
		 801d0000 2c000080 41820268 4080002c
		 2c000002 41820104 40800014 2c000000
		 4182003c 408000b8 48000408 2c000004
		 40800400 48000120 2c000083 418202bc
		 40800010 2c000082 40800278 4800024c
		 2c000085 408003dc 48000334 7fe3fb78
		 38800000 48000469 60000000 7fe3fb78
		 38800059 4bff67fd 60000000 60650080
		 7fe3fb78 38800059 4bff67a5 60000000
		 7fe3fb78 3880002a 4bffdc85 60000000
		 98620490 7fe3fb78 3880002a 88020490
		 7c000e70 7c000194 5405063e 4bffdb49
		 60000000 7fe3fb78 3880000f 4bff61c5
		 60000000 3bc00000 4800035c 7fe3fb78
		 38800000 480003e9 60000000 7fe3fb78
		 38800059 4bff677d 60000000 60650080
		 7fe3fb78 38800059 4bff6725 60000000
		 3bc00000 48000320 7fe3fb78 38800000
		 480003ad 60000000 7fe3fb78 38800059
		 4bff6741 60000000 60650080 7fe3fb78
		 38800059 4bff66e9 60000000 3bc00000
		 480002e4 88020491 28000000 41820020
		 7fe3fb78 38800029 88a20491 4bffda99
		 60000000 38000000 98020491 88020492
		 28000000 4182002c 7fe3fb78 38800143
		 88a20492 4bff6699 60000000 7fe3fb78
		 4bffd8d1 60000000 38000000 98020492
		 88020490 28000000 41820020 7fe3fb78
		 3880002a 88a20490 4bffda3d 60000000
		 38000000 98020490 7fe3fb78 38800008
		 4bffdb3d 60000000 546507fa 7fe3fb78
		 38800008 4bffda11 60000000 7fe3fb78
		 38800059 4bff666d 60000000 5465066e
		 7fe3fb78 38800059 4bff6615 60000000
		 801f0100 90010048 881f0681 28000000
		 41820014 7fe3fb78 38800001 48000291
		 60000000 38000007 9801003d 38000000
		 9801003c 3861003c 7fe4fb78 4bff7fc9
		 60000000 7c7e1b78 3bc00000 480001c8
		 38000000 901d0000 38000000 98010040
		 38610040 7fe4fb78 48002f85 60000000
		 7c7e1b78 480001a0 38000003 901d0000
		 38000001 98010040 38610040 7fe4fb78
		 48002f5d 60000000 7c7e1b78 48000178
		 38000001 981f05c9 38000003 901d0000
		 38000001 98010040 38610040 7fe4fb78
		 48002f2d 60000000 7c7e1b78 38000000
		 981f05c9 48000140 38000003 901d0000
		 38000001 98010040 38610040 7fe4fb78
		 48002efd 60000000 7c7e1b78 7fc00734
		 2c000000 40820110 38000007 9801003b
		 38000007 9801003a 3861003a 7fe4fb78
		 4bff7ee5 60000000 7c7e1b78 7fe3fb78
		 38800000 48000179 60000000 7fe3fb78
		 38800059 4bff650d 60000000 60650080
		 7fe3fb78 38800059 4bff64b5 60000000
		 38000002 901d0000 480000ac 38000001
		 981f05c9 38000003 901d0000 38000001
		 98010040 38610040 7fe4fb78 48002e61
		 60000000 7c7e1b78 38000000 981f05c9
		 7fc00734 2c000000 4082006c 38000007
		 98010039 38000007 98010038 38610038
		 7fe4fb78 4bff7e41 60000000 7c7e1b78
		 7fe3fb78 38800000 480000d5 60000000
		 7fe3fb78 38800059 4bff6469 60000000
		 60650080 7fe3fb78 38800059 4bff6411
		 60000000 38000002 901d0000 48000008
		 3bc00000 801d0000 901f00f8 801f00fc
		 901d0004 7fc3f378 80010068 38210060
		 7c0803a6 bba1fff4 4e800020 7c0802a6
		 93e1fffc 90010008 9421ffc0 7c7f1b78
		 387f0644 38823394 38bf0659 38c00005
		 4bff0f91 60000000 387f0644 3882339e
		 38bf0654 38c00005 4bff0f79 60000000
		 881f0654 981f062d 881f0655 981f062e
		 881f0656 981f062f 80010048 38210040
		 7c0803a6 83e1fffc 4e800020 7c0802a6
		 93e1fffc 90010008 9421ffc0 7c7f1b78
		 9881005f 7fe3fb78 4bffff75 881f0654
		 5403063e 881f062c 7c030040 40820220
		 8801005f 2c000001 41820108 40800104
		 2c000000 40800008 480000f8 7fe3fb78
		 38800288 4bff6515 60000000 546507fa
		 7fe3fb78 38800288 4bff64c5 60000000
		 7fe3fb78 38800284 4bff64f1 60000000
		 5465003c 7fe3fb78 38800284 4bff64a1
		 60000000 7fe3fb78 38800284 4bff64cd
		 60000000 60650002 7fe3fb78 38800284
		 4bff647d 60000000 7fe3fb78 38800284
		 4bff64a9 60000000 546507b8 7fe3fb78
		 38800284 4bff6459 60000000 7fe3fb78
		 38800054 4bff6485 60000000 54650290
		 7fe3fb78 38800054 4bff6435 60000000
		 7fe3fb78 3880000a 4bff5cb9 60000000
		 7fe3fb78 38800288 4bff6451 60000000
		 5465003c 7fe3fb78 38800288 4bff6401
		 60000000 38000000 981f0659 480000f4
		 7fe3fb78 38800288 4bff6421 60000000
		 60650001 7fe3fb78 38800288 4bff63d1
		 60000000 7fe3fb78 3880000a 4bff5c55
		 60000000 7fe3fb78 38800284 4bff63ed
		 60000000 60650001 7fe3fb78 38800284
		 4bff639d 60000000 7fe3fb78 38800284
		 4bff63c9 60000000 546507fa 7fe3fb78
		 38800284 4bff6379 60000000 7fe3fb78
		 38800284 4bff63a5 60000000 60650004
		 7fe3fb78 38800284 4bff6355 60000000
		 7fe3fb78 38800054 4bff6381 60000000
		 64650040 7fe3fb78 38800054 4bff6331
		 60000000 7fe3fb78 38800288 4bff635d
		 60000000 60650002 7fe3fb78 38800288
		 4bff630d 60000000 881f062c 981f0659
		 7fe3fb78 388233a7 38a1005f 38c00001
		 4bff0bb1 60000000 4800000c 38000000
		 9801005f 387f0644 388233ae 38bf0659
		 38c00005 4bff0c65 60000000 7fe3fb78
		 4bfffd1d 8801005f 981f0603 80010048
		 38210040 7c0803a6 83e1fffc 4e800020
		 7c0802a6 93e1fffc 90010008 9421ffc0
		 7c7f1b78 9881005f 7fe3fb78 4bfffce1
		 881f0655 5403063e 881f062c 7c030040
		 408200e4 8801005f 2c000001 41820068
		 40800064 2c000000 40800008 48000058
		 7fe3fb78 38800054 4bff6281 60000000
		 60653300 7fe3fb78 38800054 4bff6231
		 60000000 7fe3fb78 38800058 4bff625d
		 60000000 60658000 7fe3fb78 38800058
		 4bff620d 60000000 38000000 981f065a
		 48000058 7fe3fb78 38800054 4bff622d
		 60000000 3800ccff 7c650038 7fe3fb78
		 38800054 4bff61d9 60000000 7fe3fb78
		 38800058 4bff6205 60000000 5465045e
		 7fe3fb78 38800058 4bff61b5 60000000
		 881f062c 981f065a 7fe3fb78 388233b8
		 38a1005f 38c00001 4bff0a59 60000000
		 4800000c 38000000 9801005f 387f0644
		 388233c0 38bf0659 38c00005 4bff0b0d
		 60000000 7fe3fb78 4bfffbc5 8801005f
		 981f0604 80010048 38210040 7c0803a6
		 83e1fffc 4e800020 7c0802a6 bfa1fff4
		 90010008 9421ffb0 7c7f1b78 7c9d2378
		 3bc00000 57a0063e 2c000002 41820178
		 40800014 2c000000 41820014 408000bc
		 48000210 2c000004 48000208 7fe3fb78
		 38800288 4bff6135 60000000 546007bc
		 28000000 41820038 7fe3fb78 38800288
		 4bff6119 60000000 546507fa 7fe3fb78
		 38800288 4bff60c9 60000000 7fe3fb78
		 38800032 4bff594d 60000000 7fe3fb78
		 38800f60 4bff5f1d 60000000 5460003a
		 60050003 7fe3fb78 38800f60 4bff5ec1
		 60000000 7fe3fb78 38800032 4bff5915
		 60000000 7fe3fb78 38800f60 4bff60ad
		 60000000 546007be 28000003 418201b8
		 3bc0ffef 480001b0 7fe3fb78 38800288
		 4bff6089 60000000 546007bc 28000000
		 41820038 7fe3fb78 38800288 4bff606d
		 60000000 546507fa 7fe3fb78 38800288
		 4bff601d 60000000 7fe3fb78 38800032
		 4bff58a1 60000000 7fe3fb78 38800f60
		 4bff5e71 60000000 5460003a 60050001
		 7fe3fb78 38800f60 4bff5e15 60000000
		 7fe3fb78 38800032 4bff5869 60000000
		 7fe3fb78 38800f60 4bff6001 60000000
		 546007be 28000001 4182010c 3bc0ffef
		 48000104 7fe3fb78 38800288 4bff5fdd
		 60000000 546007bc 28000000 41820038
		 7fe3fb78 38800288 4bff5fc1 60000000
		 546507fa 7fe3fb78 38800288 4bff5f71
		 60000000 7fe3fb78 38800032 4bff57f5
		 60000000 7fe3fb78 38800f60 4bff5dc5
		 60000000 5460003a 60050002 7fe3fb78
		 38800f60 4bff5d69 60000000 7fe3fb78
		 38800032 4bff57bd 60000000 7fe3fb78
		 38800f60 4bff5f55 60000000 546007be
		 28000002 41820060 3bc0ffef 48000058
		 7fe3fb78 38800f60 4bff5d69 60000000
		 5465003a 7fe3fb78 38800f60 4bff5d11
		 60000000 7fe3fb78 38800032 4bff5765
		 60000000 7fe3fb78 38800f60 4bff5efd
		 60000000 546007be 28000000 41820008
		 3bc0ffef 57a0063e 901f00f8 7fc3f378
		 80010058 38210050 7c0803a6 bba1fff4
		 4e800020 7c0802a6 93e1fffc 90010008
		 9421ffc0 7c7f1b78 9081005c 7fe3fb78
		 38800284 4bff5ea5 60000000 5463077e
		 8001005c 7c051b78 7fe3fb78 38800284
		 [95609 bytes total]
ATY,Fcode        "1.75"
ATY,Card#        "109-72700-00"
ATY,Rom#         "113-72701-130"
model            "ATY,Rage128Pro"
AGP_AllowOverlap 00000001
AGP_Alignment    02000000 (33554432)
AGP_Address_Block 02000000 (33554432)
AGP_Address_Range 00000000 ffffffff
reg              00008000 00000000 00000000 00000000 00000000
		 02008030 00000000 00000000 00000000 00020000
		 42008010 00000000 00000000 00000000 04000000
		 02008018 00000000 00000000 00000000 00004000
character-set    "ISO8859-1"
device_type      "display"
display-type     "CRT"
linebytes        00000300 (768)
depth            00000008
height           000001e0 (480)
width            00000280 (640)
ATY,SCLK         0001ccf0 (118000)
ATY,MCLK         000222e0 (140000)
ATY,RefCLK       0000733c (29500)
ATY,Flags        07170190 (118948240)
ATY,Status       00000000
fcode-rom-offset 00000000
fast-back-to-back
devsel-speed     00000001
max-latency      00000000
min-grant        00000008
interrupts       00000001
class-code       00030000 (196608)
revision-id      00000000
device-id        00005046 (20550)
vendor-id        00001002 (4098)

/proc/device-tree/pci@f0000000/uni-north-agp@b:
name             "uni-north-agp"
linux,phandle    ff94e1e0
assigned-addresses
reg              00005800 00000000 00000000 00000000 00000000
AGP_Target      
compatible       "uni-north-agp"
device_type      "uni-north-agp"
fast-back-to-back
devsel-speed     00000001
max-latency      00000000
min-grant        00000000
class-code       00060000 (393216)
revision-id      00000000
device-id        0000002d (45)
vendor-id        0000106b (4203)

/proc/device-tree/uni-n@f8000000:
name             "uni-n"
linux,phandle    ff907330
device-rev       00000011 (17)
#size-cells      00000001
#address-cells   00000001
reg              f8000000 01000000
compatible       "uni-north"
device_type      "memory-controller"
model            "AAPL,UniNorth"

/proc/device-tree/uni-n@f8000000/i2c@f8001000:
name             "i2c"
linux,phandle    ff9075f8
interrupt-parent ff90fa80
interrupts       0000002a 00000001
AAPL,driver-name ".i2c-uni-n"
AAPL,i2c-rate    00000064 (100)
AAPL,address-step 00000010 (16)
AAPL,address     f8001003
built-in        
compatible       "keywest-i2c"
reg              f8001000 00001000
device_type      "i2c"

/proc/device-tree/uni-n@f8000000/i2c@f8001000/cereal:
name             "cereal"
linux,phandle    ff907ec0
device_type      "serial"

/proc/device-tree/nvram@fff04000:
name             "nvram"
linux,phandle    ff906730
#bytes           00002000 (8192)
reg              fff04000 00004000
compatible       "nvram,flash"
device_type      "nvram"

/proc/device-tree/diagnostics:
name             "diagnostics"
linux,phandle    ff906650
post-results     00000000
post            

/proc/device-tree/multiboot:
name             "multiboot"
linux,phandle    ff8f3660

/proc/device-tree/pseudo-sound:
name             "pseudo-sound"
linux,phandle    ff8f3330

/proc/device-tree/pseudo-hid:
name             "pseudo-hid"
linux,phandle    ff8f20d0

/proc/device-tree/pseudo-hid/eject-key:
name             "eject-key"
linux,phandle    ff8f2e60
device_type      "eject-key"

/proc/device-tree/pseudo-hid/mouse:
name             "mouse"
linux,phandle    ff8f28c8
device_type      "mouse"

/proc/device-tree/pseudo-hid/keyboard:
name             "keyboard"
linux,phandle    ff8f21d0
device_type      "keyboard"

/proc/device-tree/firewire-disk-mode:
name             "firewire-disk-mode"
linux,phandle    ff8dd818

/proc/device-tree/packages:
name             "packages"
linux,phandle    ff8413c0

/proc/device-tree/packages/terminal-emulator:
name             "terminal-emulator"
linux,phandle    ff8dd708
iso6429-1983-colors

/proc/device-tree/packages/bootpath-search:
name             "bootpath-search"
linux,phandle    ff8d6d78

/proc/device-tree/packages/atapi-disk:
name             "atapi-disk"
linux,phandle    ff8d4e30

/proc/device-tree/packages/ata-disk:
name             "ata-disk"
linux,phandle    ff8d30c8

/proc/device-tree/packages/sbp2-disk:
name             "sbp2-disk"
linux,phandle    ff8d0728

/proc/device-tree/packages/usb-audio-class:
name             "usb-audio-class"
linux,phandle    ff862bb0

/proc/device-tree/packages/usb-ms-class:
name             "usb-ms-class"
linux,phandle    ff85ff60

/proc/device-tree/packages/usb-hid-class:
name             "usb-hid-class"
linux,phandle    ff85d420

/proc/device-tree/packages/elf-loader:
name             "elf-loader"
linux,phandle    ff85bd78

/proc/device-tree/packages/pe-loader:
name             "pe-loader"
linux,phandle    ff85b328

/proc/device-tree/packages/xcoff-loader:
name             "xcoff-loader"
linux,phandle    ff85a890

/proc/device-tree/packages/bootinfo-loader:
name             "bootinfo-loader"
linux,phandle    ff858bb8

/proc/device-tree/packages/iso-9660-files:
name             "iso-9660-files"
linux,phandle    ff857d58

/proc/device-tree/packages/fat-files:
name             "fat-files"
linux,phandle    ff855f60

/proc/device-tree/packages/hfs-plus-files:
name             "hfs-plus-files"
linux,phandle    ff851140

/proc/device-tree/packages/mac-files:
name             "mac-files"
linux,phandle    ff84e288

/proc/device-tree/packages/mac-parts:
name             "mac-parts"
linux,phandle    ff84cae0

/proc/device-tree/packages/telnet:
name             "telnet"
linux,phandle    ff84c1e0

/proc/device-tree/packages/obp-tftp:
name             "obp-tftp"
linux,phandle    ff842900
log              00007a4f 00000000 00000000 0000000d
		 ffbbc1c0 31302e31 302e312e 3135362c
		 64000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007a4f ffbbbc00 00000400 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007a4f 00000000 00000001 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007a50 00000000 00000052 00000022
		 ffbbbc00 003065f3 4cae0090 27ee9023
		 08004510 01480000 00001011 16bf0a0a
		 7d100a0a 01b30000 00000000 00000000
		 00007a50 00000000 00000053 00000134
		 ffbbbc2a 02010600 00007a50 00000000
		 00000000 0a0a01b3 0a0a7d10 00000000
		 003065f3 4cae0000 00000000 00000000
		 00007a50 00000000 00000054 0000003c
		 ffbbbd1a 35010236 040a0a7d 10330400
		 278d0001 04ffff00 0003040a 0a00083c
		 09414150 4c425344 5043ff00 00000000
		 00007a50 00000000 00000002 00000134
		 ffbbbc2a 02010600 00007a50 00000000
		 00000000 0a0a01b3 0a0a7d10 00000000
		 003065f3 4cae0000 00000000 00000000
		 00007a50 00000000 00000005 00000000
		 ffbbc180 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007a50 00000000 00000003 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007a50 ffbbc170 0000000a 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007a50 ffbbba00 0000012c 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007a50 ffbbb400 00000400 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007a52 00000000 00030352 00000022
		 ffbbb400 003065f3 4cae0090 27ee9023
		 08004510 01480000 00001011 16bf0a0a
		 7d100a0a 01b30000 00000000 00000000
		 00007a52 00000000 00030353 00000134
		 ffbbb42a 02010600 00007a50 00000000
		 00000000 0a0a01b3 0a0a7d10 00000000
		 003065f3 4cae0000 00000000 00000000
		 00007a52 00000000 00030354 0000003c
		 ffbbb51a 35010536 040a0a7d 10330400
		 278d0001 04ffff00 0003040a 0a00083c
		 09414150 4c425344 5043ff00 00000000
		 00007a52 00000000 00030302 00000134
		 ffbbb42a 02010600 00007a50 00000000
		 00000000 0a0a01b3 0a0a7d10 00000000
		 003065f3 4cae0000 00000000 00000000
		 00007a52 00000000 00030305 00000000
		 ffbbc180 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007a52 00000000 00030350 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007a52 ffbbb000 00000400 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007c47 ffbbb800 0000012c 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007c47 00000000 00050350 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007e3c ffbbc160 00000001 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00007e59 00000000 00050359 00000001
		 ffbbc160 64000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 000082cb 00000001 ffbbc160 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
stats            00000ff3 00000001 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 00000000

/proc/device-tree/packages/disk-label:
name             "disk-label"
linux,phandle    ff841e38

/proc/device-tree/packages/deblocker:
name             "deblocker"
linux,phandle    ff8414a0

/proc/device-tree/aliases:
name             "aliases"
linux,phandle    ff8408d8
screen           "/pci@f0000000/ATY,Rage128Pd@10"
last-boot        "/pci@f4000000/ethernet@f"
		 "/pci@f2000000/pci@d/ethernet@b"
		 "/pci@f2000000/ethernet@13"
eject-key        "/pseudo-hid/eject-key"
sound            "/pseudo-sound"
nvram            "/nvram"
mouse            "/pseudo-hid/mouse"
keyboard         "/pseudo-hid/keyboard"
fw               "/pci@f4000000/firewire"
enet             "/pci@f4000000/ethernet"
ui2c-serial      "/uni-n/i2c/cereal"
ui2c             "/uni-n/i2c"
wireless         "/pci@f2000000/mac-io@17/@30000"
adb-eject-key    "/pci@f2000000/mac-io@17/via-pmu/adb/eject-key"
adb-mouse        "/pci@f2000000/mac-io@17/via-pmu/adb/mouse"
adb-keyboard     "/pci@f2000000/mac-io@17/via-pmu/adb/keyboard"
adb              "/pci@f2000000/mac-io@17/via-pmu/adb"
rtc              "/pci@f2000000/mac-io@17/via-pmu/rtc"
via-pmu          "/pci@f2000000/mac-io@17/via-pmu"
ki2c-serial      "/pci@f2000000/mac-io@17/i2c/cereal"
ki2c             "/pci@f2000000/mac-io@17/i2c"
sccb             "/pci@f2000000/mac-io@17/escc/ch-b"
scca             "/pci@f2000000/mac-io@17/escc/ch-a"
ultra1           "/pci@f2000000/mac-io@17/ata-4@1f000/disk@1"
ultra0           "/pci@f2000000/mac-io@17/ata-4@1f000/disk@0"
zip              "/pci@f2000000/mac-io@17/ata-3@20000/disk@1"
cd               "/pci@f2000000/mac-io@17/ata-3@20000/disk@0"
hd               "/pci@f2000000/mac-io@17/ata-4@1f000/disk@0"
ide1             "/pci@f2000000/mac-io@17/ata-3@20000/disk@1"
ide0             "/pci@f2000000/mac-io@17/ata-3@20000/disk@0"
mpic             "/pci@f2000000/mac-io@17/interrupt-controller"
mac-io           "/pci@f2000000/mac-io@17"
usb1             "/pci@f2000000/usb@19"
usb0             "/pci@f2000000/usb@18"
cbx              "/pci@f2000000/cardbus@1a/pci-bridge/pci-bridge"
cb               "/pci@f2000000/cardbus@1a"
fw1              "/pci@f2000000/firewire"
enet1            "/pci@f2000000/ethernet"
enetx            "/pci@f2000000/ethernet@13"
fwx              "/pci@f2000000/firewire@12"
pci              "/pci@f2000000"
pci2             "/pci@f4000000"
pci1             "/pci@f2000000"
agp              "/pci@f0000000"
pci0             "/pci@f0000000"

/proc/device-tree/options:
name             "options"
linux,phandle    ff8407d0
boot-args       
snakebitecpu0    70 61 73 73 65 64                              passed
snakebitecpu1    66 61 69 6c 65 64                              failed
medusa           74727565 (1953658213)
ASVP             30313037 31373030 323a343c
aapl,pci         2f 6f 66 66 73 63 72 65 65 6e 2d 64 69 73 70 6c/offscreen-displ
		 61 79 ff 01 67 70 72 66 ff 01 ff 81 01 07 01 01ay..gprf........
		 ff 81 04 ff 01 2f 40 66 30 30 30 30 30 30 30 2f...../@f0000000/
		 40 31 30 ff 01 41 54 59 4e ff 01 ff 81 01 2a 07@10..ATYN.....*.
		 17 ff 81 01 82 0b 4c ff 81 18 ff 01 00         ......L......
boot-script      ""
default-router-ip ""
default-subnet-mask ""
default-gateway-ip ""
default-server-ip ""
default-client-ip ""
boot-command     "mac-boot"
nvramrc          ""
oem-logo         ""
oem-banner       ""
mouse-device     "mouse"
output-device-1  "scca"
input-device-1   "scca"
output-device    "screen"
input-device     "keyboard"
diag-file        ",diags"
diag-device      "enet"
console-screen   ""
boot-screen      ""
boot-file        ""
boot-device      "/pci@f2000000/mac-io@17/ata-4@1f000/disk@0:11,\\:tbxi"
selftest-#megs   "0"
screen-#rows     "40"
screen-#columns  "100"
pci-probe-mask   "-1"
virt-size        "-1"
virt-base        "-1"
load-base        "0x800000"
real-size        "-1"
real-base        "-1"
default-mac-address? "false"
use-generic?     "false"
use-nvramrc?     "false"
oem-logo?        "false"
oem-banner?      "false"
fcode-debug?     "false"
diag-switch?     "false"
auto-boot?       "true"
real-mode?       "false"
little-endian?   "false"

/proc/device-tree/rom@ff800000:
name             "rom"
linux,phandle    ff840298
#address-cells   00000001
ranges           ff800000 00800000 ff800000
reg              ff800000 00000000

/proc/device-tree/rom@ff800000/macos:
name             "macos"
linux,phandle    ff8406c8

/proc/device-tree/rom@ff800000/boot-rom@fff00000:
name             "boot-rom"
linux,phandle    ff840498
has-config-block
info             fff00000 00003f00 000418f5 20010321 b9456725 fff08000
		 00078001 000418f5 20010321 624ad24b fff80000 00080002
		 000418f5 20010321 a564aa82 fff03f00 00000083 000418f5
		 20010321 29ed3241 fff03f80 00000084 f34cae84 15a81001
		 ffffffff fff04000 00004005 6e767261 6d000000 00000000
security-modes   6e 6f 6e 65 2c 20 66 75 6c 6c 2c 20 63 6f 6d 6dnone,.full,.comm
		 61 6e 64                                       and
BootROM-build-date "03/21/01 at 11:49:53"
BootROM-version  "$0004.18f5"
model            "Apple PowerMac3,4 4.1.8f5 BootROM built on 03/21/01 at 11:49:53"
write-characteristic "flash"
reg              fff00000 00100000

/proc/device-tree/openprom:
name             "openprom"
linux,phandle    ff83ee00
boot-syntax      00000001
supports-bootinfo
relative-addressing
model            "OpenFirmware 3"
device_type      "BootROM"

/proc/device-tree/openprom/client-services:
name             "client-services"
linux,phandle    ff83efa8

/proc/device-tree/memory@0:
name             "memory"
linux,phandle    ff83eb60
dimm-speeds      "PC100-222S"
		 "PC100-222S"
		 ""
		 ""
dimm-types       "SDRAM"
		 "SDRAM"
		 ""
		 ""
dimm-info        8008040c 09024000 01755400 80080001
		 8f040601 01000ea0 60000014 0f142d10
		 15081508 00000000 00000000 00000000
		 00000000 00000000 00000000 0000129f
		 adffffff ffffffff 02373656 31363633
		 35484754 382d4820 20202041 410b6560
		 87612e00 00000000 00000000 00000000
		 00000000 00000000 00000000 000064ff
		 8008040c 0a014000 01755400 80080001
		 0f040601 010006a0 60000014 0f142d20
		 15081508 ffffffff ffffffff ffffffff
		 ffffffff ffffffff ffffffff ffff120d
		 7f7f6400 00000000 354d4454 3132384d
		 20504331 33332d33 33332032 310108c2
		 0a200457 57572e4d 44542e44 45204330
		 30313930 324c3141 2050324d 303464a7
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000
available        00003000 001fd000 0022c000 000d4000 00400000
		 01c00000 029647a0 00004860 02a69000 0d197000
slot-names       0000000f 44494d4d 302f4a32 31004449
		 4d4d312f 4a323200 44494d4d 322f4a32
		 33004449 4d4d332f 4a323400
reg              00000000 08000000 08000000 08000000
		 00000000 00000000 00000000 00000000
device_type      "memory"

/proc/device-tree/chosen:
name             "chosen"
linux,phandle    ff83e948
linux,stdout-path "/pci@f0000000/ATY,Rage128Pd@10"
linux,stdout-package ff94e4f0
yaboot,image     "enet:10.10.1.156,d"
dhcp-response    02010600 00007a50 00000000 00000000 0a0a01b3
		 0a0a7d10 00000000 003065f3 4cae0000 00000000
		 00000000 626f6574 74676572 2e737573 652e6465
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 6f732d63 686f6f73 65720000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 63825363
		 35010536 040a0a7d 10330400 278d0001 04ffff00
		 0003040a 0a00083c 09414150 4c425344 5043ff00
		 00000000 00000000 00000000 00000000 00000000
bsdp-response    02010600 00007a50 00000000 00000000 0a0a01b3
		 0a0a7d10 00000000 003065f3 4cae0000 00000000
		 00000000 626f6574 74676572 2e737573 652e6465
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 6f732d63 686f6f73 65720000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 00000000
		 00000000 00000000 00000000 00000000 63825363
		 35010236 040a0a7d 10330400 278d0001 04ffff00
		 0003040a 0a00083c 09414150 4c425344 5043ff00
		 00000000 00000000 00000000 00000000 00000000
mac-address      00 30 65 f3 4c ae                              .0e.L.
yaboot,bootpath  "/pci@f2000000/mac-io@17/ata-4@1f000/disk@0:11,\\yaboot"
interrupt-controller ff90fa80
cpu              ffbdd640
bootargs         "root=/dev/hda13 quiet sysrq=1 video=aty128fb:1024x768@75 debug video=aty128fb:1024x768@85 "
bootpath         "/pci@f2000000/mac-io@17/ata-4@1f000/disk@0:11,\\yaboot"
pmu              ffbd8c00
nvram            ffbd8d40
mmu              ffbdd640
memory           ffbdd5c0
stdout           ffbbc400
stdin            ffbc54c0

/proc/device-tree/cpus:
name             "cpus"
linux,phandle    ff83d620
#cpus            00000001
#size-cells      00000000
#address-cells   00000001

/proc/device-tree/cpus/PowerPC,G4@0:
name             "PowerPC,G4"
linux,phandle    ff83d8d0
translations     00000000 00003000 00000000 00000010
		 00200000 0002c000 00200000 00000002
		 00300000 00100000 00300000 00000010
		 02000000 00300000 02000000 00000010
		 02300000 00665000 02300000 00000010
		 02969000 00100000 02969000 00000010
		 80000000 00080000 80000000 00000028
		 80082000 00001000 80082000 00000028
		 80083000 00001000 80083000 00000028
		 80084000 00001000 80084000 00000028
		 90000000 00004000 90000000 00000028
		 94000000 04000000 94000000 00000028
		 f0000000 00010000 f0000000 00000028
		 f0800000 00001000 f0800000 00000028
		 f0c00000 00001000 f0c00000 00000028
		 f2000000 00010000 f2000000 00000028
		 f2800000 00001000 f2800000 00000028
		 f2c00000 00001000 f2c00000 00000028
		 f4000000 00010000 f4000000 00000028
		 f4800000 00001000 f4800000 00000028
		 f4c00000 00001000 f4c00000 00000028
		 f5000000 00001000 f5000000 00000028
		 f5200000 00200000 f5200000 00000028
		 f5200000 00200000 f5200000 00000028
		 f8000000 00003000 f8000000 00000028
		 ff800000 00400000 0fc00000 00000010
		 fff04000 00002000 fff04000 00000028
		 fff06000 00002000 fff06000 00000028
available        00003000 7fffd000 d0000000 20000000
existing         00000000 80000000 80000000 80000000
l2cr             b9000000
l2-cache#1       ff83dcc8
data-streams    
altivec         
performance-monitor
graphics        
d-cache-block-size 00000020 (32)
i-cache-block-size 00000020 (32)
i-cache-sets     00000080 (128)
d-cache-sets     00000080 (128)
i-cache-size     00008000 (32768)
d-cache-size     00008000 (32768)
tlb-size         00000080 (128)
tlb-sets         00000040 (64)
reservation-granule-size 00000020 (32)
timebase-frequency 01fbf711 (33290001)
bus-frequency    07efdc44 (133160004)
clock-frequency  1bd0c4a9 (466666665)
state            "running"
cpu-version      000c0209 (786953)
reg              00000000
device_type      "cpu"

/proc/device-tree/cpus/PowerPC,G4@0/l2-cache:
name             "l2-cache"
linux,phandle    ff83dcc8
clock-frequency  0de86254 (233333332)
cache-unified   
d-cache-line-size 00000040 (64)
i-cache-line-size 00000040 (64)
d-cache-sets     00002000 (8192)
i-cache-sets     00002000 (8192)
d-cache-size     00100000 (1048576)
i-cache-size     00100000 (1048576)
device_type      "cache"

--WIyZ46R2i8wDzkSu--
