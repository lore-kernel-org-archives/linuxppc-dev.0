Date: Sat, 10 Aug 2002 03:33:50 -0400
From: Bill Fink <billfink@mindspring.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: SCSI (AIC7XXX) broken going from 2.4.19-pre8-ben0 to 2.4.19-ben0
Message-Id: <20020810033350.20df9364.billfink@mindspring.com>
In-Reply-To: <20020810063017.10770@smtp.wanadoo.fr>
References: <20020809230936.21a3928d.billfink@mindspring.com>
	<20020810063017.10770@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Ben,

On Sat, 10 Aug 2002, Benjamin Herrenschmidt wrote:

> >Aug  9 13:40:34 gwiz kernel: SCSI subsystem driver Revision: 1.00
> >Aug  9 13:40:34 gwiz kernel: PCI: Device 11:04.0 not available because of
> >resour
> >ce collisions
> >Aug  9 13:40:34 gwiz kernel: mesh: configured for synchronous 5 MB/s
> >Aug  9 13:40:34 gwiz kernel: kmod: failed to exec /sbin/modprobe -s -k
> >scsi_host
> >adapter, errno = 2
> >Aug  9 13:40:34 gwiz last message repeated 3 times
> >
> >And no SCSI devices are available.
> >
> >Any ideas about what might be wrong?
> >
> >						-Thanks
> >
> >						-Bill
> >
> >P.S.  I am running a UP kernel on a dual 500 MHz G4 desktop.
>
> Ah, interesting, you have a configuration that shows a problem I'm
> chasing. Please, go back to the working kernel, and send me
> the result of lspci -vv.
>
> Also, if you can boot at all with the new kernel, please send me
> the complete dmesg log as well.

That was a quick reply!  I'm attaching the two items you requested
(I normally boot from an internal IDE drive).

						-Thanks

						-Bill



lspci from working kernel:
--------------------------------------------------------------------------------
00:0b.0 Host bridge: Apple Computer Inc.: Unknown device 0020
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 16, cache line size 08
	Capabilities: <available only to root>

00:10.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 255 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 48
	Region 0: Memory at 94000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at 802400 [size=256]
	Region 2: Memory at 90000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at 90020000 [disabled] [size=128K]
	Capabilities: <available only to root>

01:0b.0 Host bridge: Apple Computer Inc.: Unknown device 001f
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 16, cache line size 08

01:0d.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
	Memory behind bridge: 80000000-800fffff
	BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

02:04.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 54
	Region 0: I/O ports at 1000 [disabled] [size=256]
	Region 1: Memory at 80083000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 80090000 [disabled] [size=64K]
	Capabilities: <available only to root>

02:07.0 Class ff00: Apple Computer Inc.: Unknown device 0022 (rev 03)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16, cache line size 08
	Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=512K]

02:08.0 USB Controller: Apple Computer Inc.: Unknown device 0019 (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 27
	Region 0: Memory at 80082000 (32-bit, non-prefetchable) [size=4K]

02:09.0 USB Controller: Apple Computer Inc.: Unknown device 0019 (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (750ns min, 21500ns max)
	Interrupt: pin A routed to IRQ 28
	Region 0: Memory at 80081000 (32-bit, non-prefetchable) [size=4K]

02:0a.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020 (prog-if 10 [OHCI])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 63
	Region 0: Memory at 80080000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at 80084000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: <available only to root>

03:0b.0 Host bridge: Apple Computer Inc.: Unknown device 001e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 16, cache line size 08

03:0f.0 Ethernet controller: Apple Computer Inc.: Unknown device 0021 (rev 01)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 6 (16000ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 41
	Region 0: Memory at f5200000 (32-bit, non-prefetchable) [size=2M]
	Expansion ROM at f5000000 [disabled] [size=1M]
--------------------------------------------------------------------------------



dmesg from broken kernel:
--------------------------------------------------------------------------------
Memory BAT mapping: BAT2=256Mb, BAT3=256Mb, residual: 256Mb
Total memory = 768MB; using 2048kB for hash table (at c0400000)
Linux version 2.4.19-ben0-bill (root@gwiz) (gcc version 2.95.4 20010319 (prerelease/franzo/20011204)) #1 Fri Aug 9 13:03:54 EDT 2002
Found Uninorth memory controller & host bridge, revision: 8
Mapped at 0xfdf3c000
Found a Keylargo mac-io controller, rev: 3, mapped at 0xfdebc000
PowerMac motherboard: PowerMac G4 AGP Graphics
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
hose pci, pci_mem_offset: 00000000, start0: f1000000
  io_base_virt: fd6b8000, io_base_phys: f0000000, isa_mem_base: 00000000
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->1
hose pci, pci_mem_offset: 00000000, start0: f3000000
  io_base_virt: fceb6000, io_base_phys: f2000000, isa_mem_base: 00000000
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
hose pci, pci_mem_offset: 00000000, start0: f5000000
  io_base_virt: fc6b4000, io_base_phys: f4000000, isa_mem_base: 00000000
PMU driver 2 initialized for Core99, firmware: 0c
On node 0 totalpages: 196608
zone(0): 196608 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda14
PowerMac using OpenPIC irq controller
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc66d000
OpenPIC timer frequency is 4.166666 MHz
GMT Delta read from XPRAM: -240 minutes, DST: on
via_calibrate_decr: ticks per jiffy = 249085 (1494510 ticks)
Console: colour dummy device 80x25
Calibrating delay loop... 996.14 BogoMIPS
Memory: 770564k available (2440k kernel code, 1136k data, 160k init, 0k highmem)
AGP special page: 0xeffff000
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:58 [106b/0020] 000600 00
Found 00:80 [1002/5046] 000300 00
Fixup res 1 (101) of dev 00:10.0: 400 -> 802400
Fixups for bus 00
Bus scan for 00 returning with max=00
Scanning bus 10
Found 10:58 [106b/001f] 000600 00
Found 10:68 [1011/0026] 000604 01
Fixups for bus 10
Scanning behind PCI bridge 10:0d.0, config 010100, pass 0
Scanning behind PCI bridge 10:0d.0, config 010100, pass 1
Scanning bus 11
Found 11:20 [9004/5078] 000100 00
Found 11:38 [106b/0022] 00ff00 00
Found 11:40 [106b/0019] 000c03 00
Found 11:48 [106b/0019] 000c03 00
Found 11:50 [104c/8020] 000c00 00
Fixups for bus 11
bridge resource 0, base: 1000, limit: 0
Bridge 10:0d.0 resource 0 was deactivated by firmware
bridge resource 1, base: 80000000, limit: 80000000
bridge resource 2, base: 80000000, limit: 7ff00000
Bridge 10:0d.0 resource 2 was deactivated by firmware
Bus scan for 11 returning with max=11
Bus scan for 10 returning with max=11
Scanning bus 21
Found 21:58 [106b/001e] 000600 00
Found 21:78 [106b/0021] 000200 00
Fixups for bus 21
Bus scan for 21 returning with max=21
PCI->OF bus map:
0 -> 0
16 -> 0
17 -> 1
33 -> 0
PCI:00:10.0: Resource 0: 94000000-97ffffff (f=1208), vd: 1002, dev: 5046
PCI:00:10.0: Resource 2: 90000000-90003fff (f=200), vd: 1002, dev: 5046
PCI:11:07.0: Resource 0: 80000000-8007ffff (f=200), vd: 106b, dev: 0022
PCI:21:0f.0: Resource 0: f5200000-f53fffff (f=200), vd: 106b, dev: 0021
PCI:00:10.0: Resource 1: 00802400-008024ff (f=101), vd: 1002, dev: 5046
PCI:11:04.0: Resource 1: 80083000-80083fff (f=200), vd: 9004, dev: 5078
PCI:11:08.0: Resource 0: 80082000-80082fff (f=200), vd: 106b, dev: 0019
PCI:11:09.0: Resource 0: 80081000-80081fff (f=200), vd: 106b, dev: 0019
PCI:11:0a.0: Resource 0: 80080000-800807ff (f=200), vd: 104c, dev: 8020
PCI:11:0a.0: Resource 1: 80084000-80087fff (f=200), vd: 104c, dev: 8020
PCI: Failed to allocate resource 0(0-ff) for 11:04.0
PCI: Device 11:04.0 not available because of resource collisions
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
VFS: Diskquotas version dquot_6.4.0 initialized
Journalled Block Device driver loaded
devfs: v1.12a (20020514) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
i2c-core.o: i2c core module
PCI: Enabling device 00:10.0 (0086 -> 0087)
aty128fb: Rage128 Pro PF (AGP) [chip rev 0x1] 16M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 128x48
fb0: ATY Rage128 frame buffer device on PCI
input0: Macintosh mouse button emulation
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
pmac_ide: enabling IDE bus ID 2
pmac_ide: enabling IDE bus ID 0
pmac_ide: enabling IDE bus ID 1
hda: WDC WD800JB-00CRA1, ATA DISK drive
hdb: IBM-DTLA-307045, ATA DISK drive
hdc: MATSHITADVD-RAM LF-D211A, ATAPI CD/DVD-ROM drive
ide0 at 0xf520f000-0xf520f007,0xf520f160 on irq 19
ide1 at 0xf5213000-0xf5213007,0xf5213160 on irq 20
hda: Enabling Ultra DMA 4
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c50038c
hda: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=155061/16/63, UDMA(66)
hdb: Enabling Ultra DMA 4
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c50038c
hdb: 80041248 sectors (40981 MB) w/1916KiB Cache, CHS=79406/16/63, UDMA(66)
hdc: Enabling MultiWord DMA 2
ide_pmac: MDMA, cycleTime: 120, accessTime: 90, recTime: 30
ide_pmac: Set MDMA timing for mode 2, reg: 0x00011d26
hdc: ATAPI DVD-ROM DVD-RAM drive, 1024kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.99.newide
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [mac] p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18
 /dev/ide/host0/bus0/target1/lun0: [mac] p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 691M
agpgart: Detected Apple UniNorth chipset
agp: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
[drm] AGP 0.99 on Unknown @ 0x00000000 16MB
[drm] Initialized r128 2.2.0 20010917 on minor 0
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
PCI: Device 11:04.0 not available because of resource collisions
mesh: configured for synchronous 5 MB/s
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
dmasound_pmac: Awacs/Screamer Codec Mfct: 1 Rev 3
PowerMac Screamer  DMA sound driver rev 016 installed
Core driver edition 01.06 : PowerMac Built-in Sound driver edition 00.07
Write will use    4 fragments of   32768 bytes as default
Read  will use    4 fragments of   32768 bytes as default
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
macserial: i2c-modem detected, id: 1
PowerMac Z8530 serial driver version 2.0
tty00 at 0xf20e0020 (irq = 22) is a Z8530 ESCC (internal modem)
tty01 at 0xf20e7000 (irq = 50) is a Z8530 ESCC
Macintosh non-volatile memory driver v1.0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Enabling device 11:08.0 (0000 -> 0002)
PCI: Enabling bus mastering for device 11:08.0
usb-ohci.c: USB OHCI at membase 0xf20ed000, IRQ 27
usb-ohci.c: usb-11:08.0, Apple Computer Inc. KeyLargo USB
adb: starting probe task...
adb: finished probe task...
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 11:09.0 (0000 -> 0002)
PCI: Enabling bus mastering for device 11:09.0
usb-ohci.c: USB OHCI at membase 0xf20ef000, IRQ 28
usb-ohci.c: usb-11:09.0, Apple Computer Inc. KeyLargo USB (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver usblp
printer.c: v0.11: USB Printer Device Class driver
usb.c: registered new driver serial
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for Belkin F5U120-PC USB Serial Adapter
usbserial.c: USB Serial support registered for Belkin F5U103 USB Serial Adapter
usbserial.c: USB Serial support registered for Belkin USB Serial Adapter
usbserial.c: USB Serial support registered for Peracom single port USB Serial Adapter
usbserial.c: USB Serial support registered for GO-COM232 USB Serial Converter
belkin_sa.c: USB Belkin Serial converter driver v1.1
mice: PS/2 mouse device common for all mice
i2c-core.o: adapter uni-n 0 registered as adapter 0.
i2c-core.o: adapter uni-n 1 registered as adapter 1.
Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
i2c-core.o: adapter mac-io 0 registered as adapter 2.
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
NET4: AppleTalk 0.18a for Linux NET4.0
lec.c: Aug  9 2002 13:12:05 initialized
ds: no socket drivers loaded!
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k init 8k chrp 8k prep
hub.c: USB new device connect on bus1/1, assigned device number 2
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: USB new device connect on bus1/1/1, assigned device number 3
input1,hiddev0: USB HID v0.01 Keyboard [ALCOR macally Kbd Hub] on usb1:3.0
hub.c: USB new device connect on bus1/1/2, assigned device number 4
input2,hiddev0: USB HID v0.01 Mouse [Kensington MIAB Optical ] on usb1:4.0
hub.c: USB new device connect on bus1/1/3, assigned device number 5
printer.c: usblp0: USB Bidirectional printer dev 5 if 0 alt 1 proto 2 vid 0x1293 pid 0x0002
hub.c: USB new device connect on bus2/1, assigned device number 2
usbserial.c: Belkin F5U103 USB Serial Adapter converter detected
belkin_sa.c: bcdDevice: 0202, bfc: 1
usbserial.c: Belkin F5U103 USB Serial Adapter converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Adding Swap: 2097136k swap-space (priority -1)
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,14), internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,17), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
sungem.c:v0.97 3/20/02 David S. Miller (davem@redhat.com)
eth%d: MII PHY ID: 206040 BCM 5400
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:30:65:eb:32:4a
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
ohci1394: $Rev: 537 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 11:0a.0 (0010 -> 0012)
PCI: Enabling bus mastering for device 11:0a.0
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[63]  MMIO=[80080000-80080800]  Max Packet=[2048]
ieee1394: NodeMgr: hotplug policy returned -2
ieee1394: Device added: Node[00:1023]  GUID[00000000204027a1]  [LaCie Group SA  ]
ieee1394: Host added: Node[01:1023]  GUID[00000000feeb324a]  [Linux OHCI-1394]
raw1394: /dev/raw1394 device initialized
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
scsi0 : IEEE-1394 SBP-2 protocol driver (host: ohci1394)
$Rev: 542 $ James Goodwin <jamesg@filanet.com>
SBP-2 module load options:
- Max speed supported: S400
- Max sectors per I/O supported: 255
- Max outstanding commands supported: 8
- Max outstanding commands per lun supported: 1
- Serialized I/O (debug): no
- Exclusive login: yes
  Vendor: ST380021  Model: A                 Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 06
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
 /dev/scsi/host0/bus0/target0/lun0: [mac] p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
video1394: Installed video1394 module
ieee1394: sbp2: Reconnected to SBP-2 device
ieee1394: sbp2: sbp2_set_busy_timeout error
ieee1394: sbp2: hpsb_send_packet failed
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
ieee1394: ConfigROM quadlet transaction error for node 01:1023
ieee1394: Node 01:1023 changed to 02:1023
ieee1394: sbp2: Reconnected to SBP-2 device
ieee1394: sbp2: Node[00:1023]: Max speed [S400] - Max payload [2048]
ieee1394: NodeMgr: hotplug policy returned -2
ieee1394: Device added: Node[01:1023]  GUID[00000000004e90a4]  [Sony]

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
