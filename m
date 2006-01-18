Return-Path: <olh@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E18FC681BD
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jan 2006 02:18:45 +1100 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 5699CEBF6
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2006 16:18:41 +0100 (CET)
Date: Wed, 18 Jan 2006 16:18:40 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: Badness in kref_get at lib/kref.c:32, of_get_parent broken
Message-ID: <20060118151840.GA24381@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2.6.16-rc1-git1 gives these warnings in early boot:


Total memory = 512MB; using 1024kB for hash table (at cfe00000)
Linux version 2.6.16-rc1-git1-pegasos2 (olaf@pomegranate) (gcc version 3.3.3 (SuSE Linux)) #21 Wed Jan 18 15:15:25 CET 2006
Found initrd at 0xc2711000:0xc293d578
Found legacy serial port 0 for /pci@80000000/isa@C/serial@i2F8
  port=2f8, taddr=ffffffff, irq=ffffffff, clk=1843200, speed=0
chrp type = 6
Pegasos l2cr : L2 cache was not active, activating
PCI bus 0 controlled by pci at 80000000
Badness in kref_get at /home/olaf/kernel/olh/ppc64/linux-2.6.16-rc1-olh/lib/kref.c:32
Call Trace:
[C0379D00] [C0007A20] show_stack+0x5c/0x184 (unreliable)
[C0379D30] [C000E150] program_check_exception+0x184/0x584
[C0379D90] [C000F6D8] ret_from_except_full+0x0/0x4c
--- Exception: 700 at kref_get+0xc/0x24
    LR = of_node_get+0x24/0x3c
[C0379E50] [C004FD20] __pte_alloc_kernel+0x64/0x80 (unreliable)
[C0379E70] [C000CB04] of_get_parent+0x34/0x58
[C0379E90] [C0009C04] of_get_address+0x24/0x174
[C0379ED0] [C000A1F4] of_address_to_resource+0x24/0x68
[C0379F00] [C038917C] chrp_find_bridges+0x114/0x470
[C0379F90] [C0388E38] chrp_setup_arch+0x1fc/0x32c
[C0379FB0] [C03829A0] setup_arch+0x144/0x188
[C0379FD0] [C037A45C] start_kernel+0x34/0x1a8
[C0379FF0] [000037A0] 0x37a0
Badness in kref_get at /home/olaf/kernel/olh/ppc64/linux-2.6.16-rc1-olh/lib/kref.c:32
Call Trace:
[C0379C90] [C0007A20] show_stack+0x5c/0x184 (unreliable)
[C0379CC0] [C000E150] program_check_exception+0x184/0x584
[C0379D20] [C000F6D8] ret_from_except_full+0x0/0x4c
--- Exception: 700 at kref_get+0xc/0x24
    LR = of_node_get+0x24/0x3c
[C0379DE0] [00002700] 0x2700 (unreliable)
[C0379E00] [C000CB04] of_get_parent+0x34/0x58
[C0379E20] [C0009DD4] of_translate_address+0x2c/0x2fc
[C0379EA0] [C000A0D4] __of_address_to_resource+0x30/0xc4
[C0379ED0] [C000A21C] of_address_to_resource+0x4c/0x68
[C0379F00] [C038917C] chrp_find_bridges+0x114/0x470
[C0379F90] [C0388E38] chrp_setup_arch+0x1fc/0x32c
[C0379FB0] [C03829A0] setup_arch+0x144/0x188
[C0379FD0] [C037A45C] start_kernel+0x34/0x1a8
[C0379FF0] [000037A0] 0x37a0
PCI bus 0 controlled by pci at c0000000
Top of RAM: 0x20000000, Total RAM: 0x20000000
Memory hole size: 0MB
On node 0 totalpages: 131072
  DMA zone: 131072 pages, LIFO batch:31
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 0 pages, LIFO batch:0
  HighMem zone: 0 pages, LIFO batch:0
Built 1 zonelists
Kernel command line: debug sysrq=1 root=/dev/hda7 
PID hash table entries: 4096 (order: 12, 65536 bytes)
time_init: decrementer frequency = 33.333333 MHz
time_init: processor frequency   = 0.000000 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
High memory: 0k
Memory: 511232k/524288k available (3064k kernel code, 12564k reserved, 484k data, 457k bss, 144k init)
Calibrating delay loop... 66.56 BogoMIPS (lpj=133120)
Mount-cache hash table entries: 512
checking if image is initramfs... it is
Freeing initrd memory: 2225k freed
NET: Registered protocol family 16
PCI: Probing PCI hardware
usbcore: registered new driver usbfs
usbcore: registered new driver hub
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: Enabling device 0001:01:08.0 (0002 -> 0003)
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: No ATY,RefCLK property !
radeonfb: Retrieved PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=240.00 Mhz, System=200.25 MHz
radeonfb: PLL min 20000 max 40000
radeonfb: Monitor 1 type DFP found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
radeonfb: Assuming panel size 8x1
Console: switching to colour frame buffer device 80x25
radeonfb (0001:01:08.0): ATI Radeon Y` 
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0c.1
VP_IDE: chipset revision 6
VP_IDE: VIA vt8231 (rev 10) IDE UDMA100 controller on pci0000:00:0c.1
VP_IDE: 100% native mode on irq 14
    ide0: BM-DMA at 0x1020-0x1027, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1028-0x102f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP0802N, ATA DISK drive
ide0 at 0x1000-0x1007,0x100e on irq 14
Probing IDE interface ide1...
hdc: TSSTcorpCD/DVDW TS-H552U, ATAPI CD/DVD-ROM drive
ide1 at 0x1010-0x1017,0x101e on irq 15
hda: max request size: 512KiB
hda: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: RDSK (512) hda1 (LNX^@)(res 2 spb 1) hda2 (SWP^@)(res 2 spb 1) hda3 (LNX^@)(res 2 spb 1) hda4 (LNX^@)(res 2 spb 1) hda5 (LNX^@)(res 2 spb 1) hda6 (LNX^@)(res 2 spb 1) hda7 (LNX^@)(res 2 spb 1)
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
PCI: Enabling device 0000:00:05.0 (0000 -> 0002)
ohci_hcd 0000:00:05.0: OHCI Host Controller
ohci_hcd 0000:00:05.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:05.0: irq 9, io mem 0x80000000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
PCI: Enabling device 0000:00:05.1 (0000 -> 0002)
ohci_hcd 0000:00:05.1: OHCI Host Controller
ohci_hcd 0000:00:05.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:05.1: irq 9, io mem 0x80001000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
/home/olaf/kernel/olh/ppc64/linux-2.6.16-rc1-olh/drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
atkbd.c: keyboard reset failed on isa0060/serio1
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP westwood registered
TCP htcp registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Freeing unused kernel memory: 144k init
input: AT Translated Set 2 keyboard as /class/input/input0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1044216k swap on /dev/hda2.  Priority:-1 extents:1 across:1044216k
EXT3 FS on hda7, internal journal
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
PCI: Enabling device 0000:00:05.2 (0000 -> 0002)
ehci_hcd 0000:00:05.2: EHCI Host Controller
ehci_hcd 0000:00:05.2: new USB bus registered, assigned bus number 3
ehci_hcd 0000:00:05.2: irq 9, io mem 0x80002000
ehci_hcd 0000:00:05.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 5 ports detected
via-rhine.c:v1.10-LK1.2.0-2.6 June-10-2004 Written by Donald Becker
PCI: Enabling device 0000:00:0d.0 (0005 -> 0007)
eth0: VIA Rhine II at 0x80002100, 00:0b:2f:4b:f6:8f, IRQ 9.
eth0: MII PHY found at address 16, status 0x786d advertising 01e1 Link 45e1.
PCI: Enabling device 0000:00:0c.5 (0000 -> 0001)
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x3BC
parport0: PC-style at 0x3bc, irq 7 [PCSPP]
ieee1394: Initialized config rom entry `ip1394'
parport_pc: VIA parallel port: io=0x3BC, irq=7
PCI: Enabling device 0000:00:01.0 (0000 -> 0003)
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[80002800-80002fff]  Max Packet=[2048]  IR/IT contexts=[8/8]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011060000004b2f]
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
