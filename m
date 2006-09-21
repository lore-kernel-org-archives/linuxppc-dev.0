Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id AF97367C4A
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 21:50:37 +1000 (EST)
Received: from ibook.aepfle.de (p5493FCEE.dip.t-dialin.net [84.147.252.238])
	by post.webmailer.de (8.13.6/8.13.6) with ESMTP id k8LBoTv1022796
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 13:50:29 +0200 (MEST)
Date: Thu, 21 Sep 2006 13:50:30 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linuxppc-dev@ozlabs.org
Subject: IDE not found on Performa due to interrupt breakage
Message-ID: <20060921115030.GA16732@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The IDE controller is not usable on a Performa 6400 with 2.6.18:

<6>hda: Enabling MultiWord DMA 2
<4>ide0: Disabled unable to get IRQ 13.
<6>ide0: failed to initialize IDE interface

inst-sys:~ # cat /proc/interrupts 
           CPU0       
 18:      21329   PMAC-PIC  Edge      MESH
 20:          0   PMAC-PIC  Level     NMI - XMON
 23:      77585   PMAC-PIC  Level     eth0
 27:       5733   PMAC-PIC  Edge      ADB
BAD:          0
inst-sys:~ # cat /proc/iomem 
80000000-8fffffff : /bandit
  80800000-808003ff : 0000:00:0d.0
    80800000-808003ff : tulip
f1000000-f10fffff : valkyriefb
f3000000-f3ffffff : /bandit
  f3000000-f307ffff : 0000:00:10.0
    f3008000-f30080ff : mesh
    f3008400-f30084ff : pmac_zilog
    f3008500-f30085ff : pmac_zilog
    f3008600-f30086ff : pmac_zilog
    f3008700-f30087ff : pmac_zilog
    f3008b00-f3008bff : ide-pmac (dma)
    f3010000-f30100ff : mesh
    f3013000-f301301f : pmac_zilog
    f3013020-f301303f : pmac_zilog
    f3020000-f3020fff : ide-pmac (ports)


<6>Using PowerMac machine description
<5>Linux version 2.6.18-rc7-git1-2-default (geeko@buildhost) (gcc version 4.1.2 20060913 (prerelease) (SUSE Linux)) #1 Fri Sep 15 11:35:09 UTC 2006
<4>Found initrd at 0xc0494000:0xc0b8ca1a
<6>Found a OHare mac-io controller, rev: 1, mapped at 0xfdf00000
<6>PowerMac motherboard: Alchemy
<6>Cache coherency enabled for bandit/PSX
<6>Found Bandit PCI host bridge at 0x00000000f2000000. Firmware bus number: 0->0
<4>nvram: OF partition at 0x1800
<4>nvram: XP partition at 0x1300
<4>nvram: NR partition at 0x1400
<7>Top of RAM: 0x8800000, Total RAM: 0x8800000
<7>Memory hole size: 0MB
<7>On node 0 totalpages: 34816
<7>  DMA zone: 34816 pages, LIFO batch:7
<4>Built 1 zonelists.  Total pages: 34816
<5>Kernel command line: ramdisk_size=8192 minmemory=0 memyasttext=0 sysrq=1 quiet start_shell  install=slp
<6>irq: Found primary Apple PIC /bandit/ohare for 32 irqs
<6>irq: System has 32 possible interrupts
<4>PID hash table entries: 1024 (order: 10, 4096 bytes)
<4>GMT Delta read from XPRAM: 120 minutes, DST: on
<7>time_init: decrementer frequency = 9.999850 MHz
<7>time_init: processor frequency   = 200.000000 MHz
<4>Console: colour dummy device 80x25
<4>Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
<4>Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
<7>High memory: 0k
<6>Memory: 114188k/139264k available (3568k kernel code, 24932k reserved, 520k data, 452k bss, 192k init)
<7>Calibrating delay loop... 19.90 BogoMIPS (lpj=39808)
<6>Security Framework v1.0.0 initialized
<4>Mount-cache hash table entries: 512
<6>checking if image is initramfs... it is
<4>Freeing initrd memory: 7138k freed
<6>NET: Registered protocol family 16
<6>PCI: Probing PCI hardware
<7>Registering pmac pic with sysfs...
<6>usbcore: registered new driver usbfs
<6>usbcore: registered new driver hub
<6>NET: Registered protocol family 2
<4>IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
<4>TCP established hash table entries: 8192 (order: 3, 32768 bytes)
<4>TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
<6>TCP: Hash tables configured (established 8192 bind 4096)
<6>TCP reno registered
<4>Thermal assist unit not available
<6>audit: initializing netlink socket (disabled)
<5>audit(1158838343.315:1): initialized
<5>VFS: Disk quotas dquot_6.5.1
<4>Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
<6>Initializing Cryptographic API
<6>io scheduler noop registered
<6>io scheduler anticipatory registered
<6>io scheduler deadline registered
<6>io scheduler cfq registered (default)
<6>Monitor sense value = 0x60b
<6>using video mode 13 and color mode 0.
<4>Console: switching to colour frame buffer device 104x39
<6>fb0: valkyrie frame buffer device
<6>Generic RTC Driver v1.07
<6>Macintosh non-volatile memory driver v1.1
<6>pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
<6>ttyS0 at MMIO 0xf3013020 (irq = 16) is a Z85c30 ESCC - Serial port
<6>ttyS1 at MMIO 0xf3013000 (irq = 17) is a Z85c30 ESCC - Serial port
<4>RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
<6>MacIO PCI driver attached to OHare chipset
<4>Can't request resource 0 for MacIO device 0.f3000000:ohare
<6>input: Macintosh mouse button emulation as /class/input/input0
<4>Macintosh CUDA driver v0.5 for Unified ADB.
<6>apm_emu: Requires a machine with a PMU.
<6>adb: starting probe task...
<6>Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
<6>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>ide0: no intrs for device /bandit/ohare/ATA, using 13
<6>ide0: Found Apple OHare ATA controller, bus ID 0, irq 13
<7>Probing IDE interface ide0...
<4>hda: IBM-DJNA-371350, ATA DISK drive
<7>adb devices: [2]: 2 5 [3]: 3 1
<4>ADB keyboard at 2, handler set to 3
<6>Detected ADB keyboard, type ISO, swapping keys.
<6>input: ADB keyboard as /class/input/input1
<4>ADB mouse at 3, handler set to 2
<6>input: ADB mouse as /class/input/input2
<6>adb: finished probe task...
<6>hda: Enabling MultiWord DMA 2
<4>ide0: Disabled unable to get IRQ 13.
<6>ide0: failed to initialize IDE interface
<7>Probing IDE interface ide0...
<4>hda: IBM-DJNA-371350, ATA DISK drive
<4>hda: IRQ probe failed (0x0)
<4>kobject_add failed for ide0 with -EEXIST, don't try to register things with the same name in the same directory.
<4>Call Trace:
<4>[C1865EB0] [C00086FC] show_stack+0x50/0x184 (unreliable)
<4>[C1865ED0] [C015BD50] kobject_add+0x154/0x190
<4>[C1865EF0] [C01EBBD0] device_add+0x68/0x314
<4>[C1865F20] [C0209B0C] probe_hwif+0x618/0x804
<4>[C1865F50] [C020A530] ideprobe_init+0x84/0x164
<4>[C1865F90] [C037037C] ide_generic_init+0x10/0x28
<4>[C1865FA0] [C0003DA4] init+0x90/0x25c
<4>[C1865FF0] [C0013668] kernel_thread+0x44/0x60
<4>hdb: IRQ probe failed (0x0)
<4>hdb: IRQ probe failed (0x0)
<6>hda: Enabling MultiWord DMA 2
<4>ide0: DISABLED, NO IRQ
<7>ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
<6>usbcore: registered new driver hiddev
<6>usbcore: registered new driver usbhid
<6>drivers/usb/input/hid-core.c: v2.6:USB HID core driver
<6>usbcore: registered new driver appletouch
<6>mice: PS/2 mouse device common for all mice
<6>md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
<6>md: bitmap version 4.39
<6>NET: Registered protocol family 1
<6>NET: Registered protocol family 17
<4>Freeing unused kernel memory: 192k init
<5>SCSI subsystem initialized
<6>st: Version 20050830, fixed bufsize 32768, s/g segs 256
<6>loop: loaded (max 8 devices)
<6>mesh: configured for synchronous 5 MB/s
<6>mesh: performing initial bus reset...
<6>scsi0 : MESH
<6>mesh: target 3 synchronous at 5.0 MB/s
<5>  Vendor: MATSHITA  Model: CD-ROM CR-8008    Rev: 8.0e
<5>  Type:   CD-ROM                             ANSI SCSI revision: 02
<4>sr0: scsi-1 drive
<6>Uniform CD-ROM driver Revision: 3.20
<7>sr 0:0:3:0: Attached scsi CD-ROM sr0
<5>sr 0:0:3:0: Attached scsi generic sg0 type 5
<6>Linux Tulip driver version 1.1.13-NAPI (May 11, 2002)
<4>PCI: Enabling device 0000:00:0d.0 (0014 -> 0017)
<6>tulip0:  EEPROM default media type Autosense.
<6>tulip0:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
<6>tulip0:  MII transceiver #5 config 1000 status 782d advertising 01e1.
<6>eth0: Digital DS21143 Tulip rev 65 at c9188000, 00:00:1C:B5:A9:15, IRQ 23.
<6>eth0: Setting full-duplex based on MII#5 link partner capability of 45e1.
<5>lockd: failed to open /var/lib/nfs/state: err=-2
