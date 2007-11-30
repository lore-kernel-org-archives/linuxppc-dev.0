Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 2CF1EDDE25
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 01:12:33 +1100 (EST)
Message-ID: <47501A4F.8050400@anagramm.de>
Date: Fri, 30 Nov 2007 15:12:31 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [rtc-linux] Re: DS1337 RTC on I2C broken.
References: <474DB27C.7020909@anagramm.de>	<20071128194321.0804b3aa@i1501.lan.towertech.it>	<474F1B25.8080508@anagramm.de>	<20071129211912.46da8f5b@i1501.lan.towertech.it>	<474FEE20.6070606@anagramm.de>
	<20071130122055.729dd3f8@i1501.lan.towertech.it>
In-Reply-To: <20071130122055.729dd3f8@i1501.lan.towertech.it>
Content-Type: multipart/mixed; boundary="------------000308090603050603060400"
Cc: rtc-linux@googlegroups.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------000308090603050603060400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello, Alessandro!

Alessandro Zummo schrieb:
 >  It's just to see if there's any timing issue like module-coming-up-before-bus-and/or-rtc.
 >  it should work anyway, but who knows...

Here comes more debugging output:

Please note that I have now _two_ almost identical systems up and running with the
latest kernel. One machine (ecam) with an pcf8563 RTC on I2C and another one (fox_1)
with an DS1337. Both RTCs work, but the kernel doesn't get the time right.
I have now the SENSORS_*=n as you said and the (new) RTC configured.
The kernel configuration (attached) is identical for both machines. Can you please
check that again?!
Which CONFIG do I have to enable that I get /dev/rtc and/or /dev/rtc0 devices?
Note that I don't get any /dev/rtc* entry right now despite RTC_INTF_DRV=Y

Here are the outputs of the two hosts:
====================================================
HOST ECAM

root@ecam:~$ dmesg
Using MPC85xx ADS machine description
Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.24-rc3-g09f345da (clemens@ecam) (gcc version 4.2.2 (ckcore)) #2 Fri Nov 30 13:06:38 CET 2007
Found legacy serial port 0 for /soc8540@e0000000/serial@4500
   mem=e0004500, taddr=e0004500, irq=0, clk=330000000, speed=0
Found legacy serial port 1 for /soc8540@e0000000/serial@4600
   mem=e0004600, taddr=e0004600, irq=0, clk=330000000, speed=0
Entering add_active_range(0, 0, 65536) 0 entries of 256 used
Found FSL PCI host bridge at 0x00000000e0008000.Firmware bus number: 0->0
Top of RAM: 0x10000000, Total RAM: 0x10000000
Memory hole size: 0MB
Zone PFN ranges:
   DMA             0 ->    65536
   Normal      65536 ->    65536
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
     0:        0 ->    65536
On node 0 totalpages: 65536
   DMA zone: 512 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 65024 pages, LIFO batch:15
   Normal zone: 0 pages used for memmap
   Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/sdb3 ro console=ttyS0,115200
mpic: Setting up MPIC " OpenPIC  " version 1.2 at e0040000, max 1 CPUs
mpic: ISU size: 56, shift: 6, mask: 3f
mpic: Initializing for 56 sources
PID hash table entries: 1024 (order: 10, 4096 bytes)
time_init: decrementer frequency = 41.250000 MHz
time_init: processor frequency   = 825.000000 MHz
clocksource: timebase mult[60f83e1] shift[22] registered
clockevent: decrementer mult[a8f] shift[16] cpu[0]
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256000k/262144k available (3296k kernel code, 5840k reserved, 144k data, 92k bss, 124k init)
SLUB: Genslabs=11, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Calibrating delay loop... 82.43 BogoMIPS (lpj=164864)
Mount-cache hash table entries: 512
net_namespace: 64 bytes
NET: Registered protocol family 16
rstcr compatible register does not exist!
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:12.0
PCI: Cannot allocate resource region 1 of device 0000:00:12.0
PCI: Cannot allocate resource region 2 of device 0000:00:12.0
PCI: Cannot allocate resource region 3 of device 0000:00:12.0
PCI: Cannot allocate resource region 4 of device 0000:00:12.0
PCI: Cannot allocate resource region 0 of device 0000:00:14.0
PCI: Cannot allocate resource region 2 of device 0000:00:14.0
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
Time: timebase clocksource has been installed.
Switched to high resolution mode on CPU 0
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 42) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 42) is a 16550A
loop: module loaded
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:40:42:01:00:00
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:40:42:01:00:01
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
eth2: Gianfar Ethernet Controller Version 1.2, 00:40:42:01:00:02
eth2: Running with NAPI enabled
eth2: 256/256 RX/TX BD ring size
sata_promise 0000:00:14.0: version 2.11
scsi0 : sata_promise
scsi1 : sata_promise
scsi2 : sata_promise
ata1: SATA max UDMA/133 mmio m4096@0x80004000 port 0x80004200 irq 19
ata2: SATA max UDMA/133 mmio m4096@0x80004000 port 0x80004280 irq 19
ata3: PATA max UDMA/133 mmio m4096@0x80004000 port 0x80004300 irq 19
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: FUJITSU MHW2100BH, 00000012, max UDMA/100
ata1.00: 195371568 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHW2100B 0000 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
pata_pdc2027x 0000:00:12.0: version 1.0
pata_pdc2027x 0000:00:12.0: PLL input clock 32997 kHz
scsi3 : pata_pdc2027x
scsi4 : pata_pdc2027x
ata4: PATA max UDMA/133 mmio m16384@0x80000000 cmd 0x800017c0 irq 18
ata5: PATA max UDMA/133 mmio m16384@0x80000000 cmd 0x800015c0 irq 18
ata4.00: ATA-7: Maxtor 6B120P0, BAH41BM0, max UDMA/133
ata4.00: 240121728 sectors, multi 0: LBA
ata4.00: limited to UDMA/33 due to 40-wire cable
ata4.00: configured for UDMA/33
scsi 3:0:0:0: Direct-Access     ATA      Maxtor 6B120P0   BAH4 PQ: 0 ANSI: 5
sd 3:0:0:0: [sdb] 240121728 512-byte hardware sectors (122942 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 3:0:0:0: [sdb] 240121728 512-byte hardware sectors (122942 MB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sdb: sdb1 sdb2 sdb3 sdb4 < sdb5 sdb6 >
sd 3:0:0:0: [sdb] Attached SCSI disk
usbmon: debugfs is not available
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI USB Serial Device
usbcore: registered new interface driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
usbcore: registered new interface driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
mice: PS/2 mouse device common for all mice
usbcore: registered new interface driver usbtouchscreen
i2c-core: driver [rtc-ds1307] registered
i2c-core: driver [pcf8563] registered
i2c /dev entries driver
i2c-core: driver [dev_driver] registered
i2c-adapter i2c-0: adapter [MPC adapter] registered
i2c-dev: adapter [MPC adapter] registered as minor 0
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k init
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on sdb3, internal journal
ReiserFS: sdb6: found reiserfs format "3.6" with standard journal
ReiserFS: sdb6: using ordered data mode
ReiserFS: sdb6: journal params: device sdb6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: sdb6: checking transaction log (sdb6)
ReiserFS: sdb6: Using r5 hash to sort names
Adding 500432k swap on /dev/sdb5.  Priority:-1 extents:1 across:500432k
PHY: e0024520:00 - Link is Up - 100/Half
eth0: no IPv6 routers present

root@ecam:~$ i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
50: -- 51 -- -- -- -- -- -- 58 59 5a 5b 5c 5d 5e 5f
60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
root@ecam:~$ i2cdump 0 0x51 b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x51, mode byte
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b0 33 00    ..3@?05??w????3.
10: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b0 33 00    ..3@?05??w????3.
20: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b0 33 00    ..3@?05??w????3.
30: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b0 33 00    ..3@?05??w????3.
40: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b0 33 00    ..3@?05??w????3.
50: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b0 33 00    ..3@?05??w????3.
60: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b0 33 00    ..3@?05??w????3.
70: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b0 33 00    ..3@?05??w????3.
80: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b0 33 00    ..3@?05??w????3.
90: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b0 33 00    ..3@?05??w????3.
a0: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b0 33 00    ..3@?05??w????3.
b0: 00 00 33 40 13 30 35 b1 07 77 c0 c0 c0 b4 37 00    ..3@?05??w????7.
c0: 00 00 34 40 13 30 35 b1 07 77 c0 c0 c0 b4 37 00    ..4@?05??w????7.
d0: 00 00 34 40 13 30 35 b1 07 77 c0 c0 c0 b4 37 00    ..4@?05??w????7.
e0: 00 00 34 40 13 30 35 b1 07 77 c0 c0 c0 b4 37 00    ..4@?05??w????7.
f0: 00 00 34 40 13 30 35 b1 07 77 c0 c0 c0 b4 37 00    ..4@?05??w????7.
root@ecam:~$ i2cdump 0 0x51 b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x51, mode byte
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
10: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
20: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
30: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
40: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
50: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
60: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
70: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
80: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
90: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
a0: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
b0: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
c0: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
d0: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
e0: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
f0: 00 40 44 40 53 70 45 d1 07 77 c0 c0 c0 c4 47 00    .@D@SpE??w????G.
root@ecam:~$

PCF8563 is ticking...

====================================================
HOST FOX_1

root@fox_1:~$ dmesg
Using MPC85xx ADS machine description
Memory CAM mapping: CAM0=256Mb, CAM1=0Mb, CAM2=0Mb residual: 0Mb
Linux version 2.6.24-rc3-g09f345da (clemens@fox_1) (gcc version 4.2.2 (ckcore)) #2 Fri Nov 30 13:06:37 CET 2007
Found legacy serial port 0 for /soc8540@e0000000/serial@4500
   mem=e0004500, taddr=e0004500, irq=0, clk=333333330, speed=0
Found legacy serial port 1 for /soc8540@e0000000/serial@4600
   mem=e0004600, taddr=e0004600, irq=0, clk=333333330, speed=0
Entering add_active_range(0, 0, 65536) 0 entries of 256 used
Found FSL PCI host bridge at 0x00000000e0008000.Firmware bus number: 0->0
Top of RAM: 0x10000000, Total RAM: 0x10000000
Memory hole size: 0MB
Zone PFN ranges:
   DMA             0 ->    65536
   Normal      65536 ->    65536
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
     0:        0 ->    65536
On node 0 totalpages: 65536
   DMA zone: 512 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 65024 pages, LIFO batch:15
   Normal zone: 0 pages used for memmap
   Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line: root=/dev/sda1 ro console=ttyS0,115200
mpic: Setting up MPIC " OpenPIC  " version 1.2 at e0040000, max 1 CPUs
mpic: ISU size: 56, shift: 6, mask: 3f
mpic: Initializing for 56 sources
PID hash table entries: 1024 (order: 10, 4096 bytes)
time_init: decrementer frequency = 41.666666 MHz
time_init: processor frequency   = 833.333325 MHz
clocksource: timebase mult[6000002] shift[22] registered
clockevent: decrementer mult[aaa] shift[16] cpu[0]
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256000k/262144k available (3296k kernel code, 5840k reserved, 144k data, 92k bss, 124k init)
SLUB: Genslabs=11, HWalign=32, Order=0-1, MinObjects=4, CPUs=1, Nodes=1
Calibrating delay loop... 83.20 BogoMIPS (lpj=166400)
Mount-cache hash table entries: 512
net_namespace: 64 bytes
NET: Registered protocol family 16
rstcr compatible register does not exist!
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 0000:00:12.0
PCI: Cannot allocate resource region 2 of device 0000:00:12.0
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
Time: timebase clocksource has been installed.
Switched to high resolution mode on CPU 0
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 42) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 42) is a 16550A
loop: module loaded
Gianfar MII Bus: probed
eth0: Gianfar Ethernet Controller Version 1.2, 00:d0:93:0e:4e:c4
eth0: Running with NAPI enabled
eth0: 256/256 RX/TX BD ring size
eth1: Gianfar Ethernet Controller Version 1.2, 00:d0:93:0e:4e:c5
eth1: Running with NAPI enabled
eth1: 256/256 RX/TX BD ring size
eth2: Gianfar Ethernet Controller Version 1.2, 00:d0:93:0e:4e:c6
eth2: Running with NAPI enabled
eth2: 256/256 RX/TX BD ring size
sata_promise 0000:00:12.0: version 2.11
scsi0 : sata_promise
scsi1 : sata_promise
scsi2 : sata_promise
ata1: SATA max UDMA/133 mmio m4096@0x80000000 port 0x80000200 irq 18
ata2: SATA max UDMA/133 mmio m4096@0x80000000 port 0x80000280 irq 18
ata3: PATA max UDMA/133 mmio m4096@0x80000000 port 0x80000300 irq 18
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-8: FUJITSU MHW2100BH, 00000012, max UDMA/100
ata1.00: 195371568 sectors, multi 16: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/100
ata2: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      FUJITSU MHW2100B 0000 PQ: 0 ANSI: 5
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] 195371568 512-byte hardware sectors (100030 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
  sda: sda1 sda2 sda3
sd 0:0:0:0: [sda] Attached SCSI disk
usbmon: debugfs is not available
ehci_hcd 0000:00:14.2: EHCI Host Controller
ehci_hcd 0000:00:14.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:14.2: irq 20, io mem 0x81202000
ehci_hcd 0000:00:14.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver
ohci_hcd 0000:00:14.0: OHCI Host Controller
ohci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:14.0: irq 20, io mem 0x81200000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ohci_hcd 0000:00:14.1: OHCI Host Controller
ohci_hcd 0000:00:14.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:14.1: irq 20, io mem 0x81201000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 3-2: new low speed USB device using ohci_hcd and address 2
usb 3-2: configuration #1 chosen from 1 choice
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
usbcore: registered new interface driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new interface driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
drivers/usb/serial/usb-serial.c: USB Serial support registered for FTDI USB Serial Device
usbcore: registered new interface driver ftdi_sio
drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver
drivers/usb/serial/usb-serial.c: USB Serial support registered for pl2303
usbcore: registered new interface driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver
mice: PS/2 mouse device common for all mice
input: TSC-10 DM as /devices/pci0000:00/0000:00:14.1/usb3/3-2/3-2:1.0/input/input0
usbcore: registered new interface driver usbtouchscreen
i2c-core: driver [rtc-ds1307] registered
i2c-core: driver [pcf8563] registered
i2c /dev entries driver
i2c-core: driver [dev_driver] registered
i2c-adapter i2c-0: adapter [MPC adapter] registered
i2c-dev: adapter [MPC adapter] registered as minor 0
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k init
EXT3 FS on sda1, internal journal
Adding 2939884k swap on /dev/sda2.  Priority:-1 extents:1 across:2939884k
PHY: e0024520:00 - Link is Up - 100/Half
eth0: no IPv6 routers present

root@fox_1:~$ i2cdetect 0
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0.
I will probe address range 0x03-0x77.
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:          -- -- -- -- -- -- -- -- -- -- -- -- --
10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- --
50: 50 -- -- -- -- -- -- 57 -- -- -- -- -- -- -- --
60: -- -- -- -- -- -- -- -- 68 -- -- -- -- -- -- --
70: -- -- -- -- -- -- -- --
root@fox_1:~$ i2cdump 0 0x68 b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x68, mode byte
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 55 00 15 06 30 11 07 00 00 00 00 00 00 00 00 00    U.??0??.........
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
root@fox_1:~$ i2cdump 0 0x68 b
WARNING! This program can confuse your I2C bus, cause data loss and worse!
I will probe file /dev/i2c-0, address 0x68, mode byte
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 03 01 15 06 30 11 07 00 00 00 00 00 00 00 00 00    ????0??.........
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
50: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
60: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
80: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
90: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
a0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
b0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
c0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
d0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
e0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
f0: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX    XXXXXXXXXXXXXXXX
root@fox_1:~$

DS1337 is also working.

=====================================================

Alessandro, if you cannot help me here right now, can you please
give me some pointers to documentation and to the desired calling
tree of the kernel's new RTC stuff to get me started with
debugging?

My next step is to try it all modular... hence that won't be
a solution for me. (I don't wan't modules at all.)

Thank you a lot,
best regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com


--------------000308090603050603060400
Content-Type: application/gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
65pyBm4AAA==
--------------000308090603050603060400--
