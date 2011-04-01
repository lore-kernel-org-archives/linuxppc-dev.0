Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id EE097B6F8A
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Apr 2011 03:27:26 +1100 (EST)
Received: from crust.elkhashab.com (localhost [127.0.0.1])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	p31GQJ9t020407
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 1 Apr 2011 11:26:19 -0500
Received: (from ayman@localhost)
	by crust.elkhashab.com (8.14.3/8.14.3/Submit) id p31GQJEL020406
	for linuxppc-dev@ozlabs.org; Fri, 1 Apr 2011 11:26:19 -0500
Date: Fri, 1 Apr 2011 11:26:19 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: problem PCIe LSI device detected at all 32 device addresses (ppc460ex)
Message-ID: <20110401162619.GA20132@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've got an LSI SAS2008 controller (w/ firmware v9) that works
fine in a Linux PC w/ a recent kernel.  It does NOT work on my
460EX board.  What I find is that the device shows up as every
device on the subordinate bus where it is really located.  (see
the dumps below).  With the LSI firmware v8 this didn't occur
and it showed up correctly as a single device.  I am not sure
how to debug this problem.  I've tried disabling the PCI quirks
but it did not make any difference.  Any insight or bold visions
are appreciated.

The design details of the minimal configuration is the following.
The PLX is a PCIe switch.  I've also tried other more complicated
setups, but they fail in the same way.  Everything I've tried 
works fine on the PC (cpu->switch->switch->lsi2008, etc).

460EX->PLX8612->LSI2008

Thanks you.

In the logs it is vendor id 0x1000 and it shows up as 
every device on bus 83.  Note that I disabled the mpt2/fusion
driver b/c otherwise the kernel will crash when it tries to 
access one of the devices that doesn't exist.


U-Boot 2008.10 (Mar 15 2011 - 18:44:08)

CPU:   AMCC PowerPC 460EX Rev. A at 800 MHz (PLB=200, OPB=100, EBC=100 MHz)
       Security/Kasumi support
       Bootstrap Option D - Boot ROM Location PCI
       Internal PCI arbiter disabled
       32 kB I-Cache 32 kB D-Cache
Board: tanosx-slave - Tanisys SX Platform, 2*PCIeToggling PLX reset
, Rev. 0
I2C:   ready
DRAM:  Auto calibration |*** --------------
*** best_result window size: 226
*** best_result WRDTR: 0x0003
*** best_result CLKTR: 0x0001
*** best_result RQFD: 0x002d
*** best_result RFFD: 0x022d
*** best_result RDCC: 0x40000000
*** --------------

512 MB (ECC enabled, 400 MHz, CL3)
*** Warning - bad CRC, using default environment

PCIE0: successfully set as endpoint
PCIE1: successfully set as root-complex
### Unknown PB ###
Net:   No ethernet found.

Type run flash_nfs to mount root filesystem over NFS

Hit any key to stop autoboot:  0
## Booting kernel from Legacy Image at ff000000 ...
   Image Name:   Linux-2.6.31.5
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1686951 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Loading init Ramdisk from Legacy Image at ff400000 ...
   Image Name:   Tanisys Ramdisk Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    3830562 Bytes =  3.7 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Flattened Device Tree blob at ff3e0000
   Booting using the fdt blob at 0xff3e0000
   Uncompressing Kernel Image ... OK
   Loading Device Tree to 007fa000, end 007ffe96 ... OK
   Loading Ramdisk to 1fabe000, end 1fe65322 ... OK
Using PowerPC 44x Platform machine description
Linux version 2.6.31.5 (aymane@lablinux) (gcc version 4.2.2) #5 Fri Apr 1 10:49:45 CDT 2011
Found initrd at 0xdfabe000:0xdfe65322
Zone PFN ranges:
  DMA      0x00000000 -> 0x00020000
  Normal   0x00020000 -> 0x00020000
  HighMem  0x00020000 -> 0x00020000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00020000
MMU: Allocated 1088 bytes of context maps for 255 contexts
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
Kernel command line: root=/dev/ram rw mem=512M ip=::::tanosx-slave:eth0:off panic=1 console=ttyS0,57
600
PID hash table entries: 2048 (order: 11, 8192 bytes)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 511872k/524288k available (3340k kernel code, 12048k reserved, 140k data, 245k bss, 160k ini
t)
Kernel virtual memory layout:
  * 0xfffef000..0xfffff000  : fixmap
  * 0xffc00000..0xffe00000  : highmem PTEs
  * 0xffa00000..0xffc00000  : consistent mem
  * 0xffa00000..0xffa00000  : early ioremap
  * 0xe1000000..0xffa00000  : vmalloc & ioremap
SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
NR_IRQS:512
UIC0 (32 IRQ sources) at DCR 0xc0
UIC1 (32 IRQ sources) at DCR 0xd0
UIC2 (32 IRQ sources) at DCR 0xe0
UIC3 (32 IRQ sources) at DCR 0xf0
clocksource: timebase mult[500000] shift[22] registered
Mount-cache hash table entries: 512
NET: Registered protocol family 16
256k L2-cache enabled
PCIE0: Checking link...
PCIE0: Device detected, waiting for link...
PCIE0: link is up !
PCI host bridge /plb/pciex@d00000000 (primary) ranges:
 MEM 0x0000000e00000000..0x0000000e7fffffff -> 0x0000000080000000
  IO 0x0000000f80000000..0x0000000f8000ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCIE0: successfully set as endpoint
PCIE1: Checking link...
PCIE1: Device detected, waiting for link...
PCIE1: link is up !
PCI host bridge /plb/pciex@d20000000 (primary) ranges:
 MEM 0x0000000e80000000..0x0000000effffffff -> 0x0000000080000000
  IO 0x0000000f80010000..0x0000000f8001ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCIE1: successfully set as root-complex
PCI host bridge /plb/pci@c0ec00000 (primary) ranges:
 MEM 0x0000000d80000000..0x0000000dffffffff -> 0x0000000080000000
  IO 0x0000000c08000000..0x0000000c0800ffff -> 0x0000000000000000
4xx PCI DMA offset set to 0x00000000
PCI: Probing PCI hardware
pci 0001:81:00.0: PME# supported from D0 D3hot D3cold
pci 0001:81:00.0: PME# disabled
pci 0001:82:01.0: PME# supported from D0 D3hot D3cold
pci 0001:82:01.0: PME# disabled
pci 0001:82:04.0: PME# supported from D0 D3hot D3cold
pci 0001:82:04.0: PME# disabled
pci 0001:82:05.0: PME# supported from D0 D3hot D3cold
pci 0001:82:05.0: PME# disabled
pci 0001:80:00.0: BAR 0: can't allocate mem resource [0x80000000-0xffffffff]
pci 0001:83:08.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:09.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0a.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0b.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0c.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0d.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0e.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0f.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:10.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:11.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:12.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:13.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:14.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:15.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:16.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:17.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:18.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:19.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1a.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1b.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1c.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1d.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1e.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1f.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:82:01.0: PCI bridge, secondary bus 0001:83
pci 0001:82:01.0:   IO window: 0x1000-0x2fff
pci 0001:82:01.0:   MEM window: 0x80000000-0x808fffff
pci 0001:82:01.0:   PREFETCH window: 0x80a00000-0x819fffff
pci 0001:82:04.0: PCI bridge, secondary bus 0001:84
pci 0001:82:04.0:   IO window: disabled
pci 0001:82:04.0:   MEM window: disabled
pci 0001:82:04.0:   PREFETCH window: disabled
pci 0001:82:05.0: PCI bridge, secondary bus 0001:85
pci 0001:82:05.0:   IO window: disabled
pci 0001:82:05.0:   MEM window: disabled
pci 0001:82:05.0:   PREFETCH window: disabled
pci 0001:81:00.0: PCI bridge, secondary bus 0001:82
pci 0001:81:00.0:   IO window: 0x1000-0x2fff
pci 0001:81:00.0:   MEM window: 0x80000000-0x808fffff
pci 0001:81:00.0:   PREFETCH window: 0x80a00000-0x819fffff
pci 0001:80:00.0: PCI bridge, secondary bus 0001:81
pci 0001:80:00.0:   IO window: 0x1000-0x2fff
pci 0001:80:00.0:   MEM window: 0x80000000-0x809fffff
pci 0001:80:00.0:   PREFETCH window: 0x80a00000-0x819fffff
pci 0001:81:00.0: enabling device (0000 -> 0003)
pci 0001:82:01.0: enabling device (0000 -> 0003)
bio: create slab <bio-0> at 0
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 3740k freed
JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
msgmni has been set to 1007
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp 0001:82:01.0:pcie24: HPC vendor_id 10b5 device_id 8612 ss_vid 0 ss_did 0
pciehp 0001:82:05.0:pcie24: HPC vendor_id 10b5 device_id 8612 ss_vid 0 ss_did 0
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 21) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 22) is a 16550A
4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 21) is a 16550
4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 22) is a 16550
brd: module loaded
PPC 4xx OCP EMAC driver, version 3.54
MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
TAH /plb/opb/emac-tah@ef601350 initialized
TAH /plb/opb/emac-tah@ef601450 initialized
/plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
/plb/opb/ethernet@ef600e00: reset timeout
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:00:00:00:00:00
eth0: found Generic MII PHY (0x00)
/plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
/plb/opb/ethernet@ef600f00: reset timeout
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:00:00:00:00:00
eth1: found Generic MII PHY (0x01)
of-flash flash.5: Can't get IO address from device tree
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
I2O subsystem v1.325
i2o: max drivers = 8
i2c /dev entries driver
ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
TMP423 driver init
tmp423: probe address 4c
tmp423: detected mfr=55 dev=23
PowerPC Book-E Watchdog Timer Loaded
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RAMDISK: gzip image found at block 0
VFS: Mounted root (ext2 filesystem) on device 1:0.
Freeing unused kernel memory: 160k init
Hostname =  tanosx-slave
Skipping seutp of up PLX switch...
81:Machine check in kernel mode.
Data Read PLB Error
Machine Check exception is imprecise
00.0 vendor=10b5 device=8612 class=0604 irq=18 (pin 1  ) base0=80900000
Found PLX 8612 device
8612 Setup
Configuring port 1
Bus error
Done setting up PLX switch
Loading Master/Slave DMA driver...
insmod: module 'mapper' not found
Done loading mapper driver
Creating Master/Slave char device...
Done creating mapper char device
Loading Tanisys DMA helper driver...
insmod: module 'sil' not found
Done loading Tanisys sil dma driver
Creating sil char device...
Done creating sil char device
Settting overcommit_memory
Setting overcommit_ratio
Running monitor....
Monitor application started...


BusyBox v1.12.0 (2010-10-01 16:22:10 CDT) built-in shell (ash)
Enter 'help' for a list of built-in commands.

#
DiscoverSlaveNumber:: == 0

1ST SYSTEM ERROR 0x80000004: Error opening I2C file descriptor /sys/bus/i2c/devices/0-0055/eeprom: N
o such file or directory


Error: sending pass through data request, errno = 22 : Invalid argumentUnable to read eeprom, kernel
 driver returned 0x80000004.Slave client application (Oct 27 2010 12:05:48) started...
ERROR, no Silicon Images parts found from scan of PCI Bus!
Error occured while attempting to open /dev/mapper : No such device or addressError mapping slave me
mory: 80000185

DiscoverSlaveNumber:: == 0

1ST SYSTEM ERROR 0x80000004: Error opening I2C file descriptor /sys/bus/i2c/devices/0-0055/eeprom: N
o such file or directory


Error: sending pass through data request, errno = 22 : Invalid argumentUnable to read eeprom, kernel
 driver returned 0x80000004.Slave client application (Oct 27 2010 12:05:48) started...
ERROR, no Silicon Images parts found from scan of PCI Bus!
Error occured while attempting to open /dev/mapper : No such device or addressError mapping slave me
mory: 80000185

DiscoverSlaveNumber:: == 0

1ST SYSTEM ERROR 0x80000004: Error opening I2C file descriptor /sys/bus/i2c/devices/0-0055/eeprom: N
o such file or directory


Error: sending pass through data request, errno = 22 : Invalid argumentUnable to read eeprom, kernel
 driver returned 0x80000004.Slave client application (Oct 27 2010 12:05:48) started...
ERROR, no Silicon Images parts found from scan of PCI Bus!
Error occured while attempting to open /dev/mapper : No such device or addressError mapping slave me
mory: 80000185

#
DiscoverSlaveNumber:: == 0

1ST SYSTEM ERROR 0x80000004: Error opening I2C file descriptor /sys/bus/i2c/devices/0-0055/eeprom: N
o such file or directory


Error: sending pass through data request, errno = 22 : Invalid argumentUnable to read eeprom, kernel
 driver returned 0x80000004.Slave client application (Oct 27 2010 12:05:48) started...
kERROR, no Silicon Images parts found from scan of PCI Bus!
Error occured while attempting to open /dev/mapper : No such device or addressError mapping slave me
mory: 80000185
illall monitor
# ps
  PID USER       VSZ STAT COMMAND
    1 root      1868 S    init
    2 root         0 SW<  [kthreadd]
    3 root         0 SW<  [ksoftirqd/0]
    4 root         0 SW<  [watchdog/0]
    5 root         0 SW<  [events/0]
    6 root         0 SW<  [khelper]
    9 root         0 SW<  [async/mgr]
  134 root         0 SW<  [kblockd/0]
  139 root         0 SW<  [ata/0]
  140 root         0 SW<  [ata_aux]
  145 root         0 SW<  [khubd]
  148 root         0 SW<  [kmmcd]
  192 root         0 SW   [khungtaskd]
  193 root         0 SW   [pdflush]
  194 root         0 SW   [pdflush]
  195 root         0 SW<  [kswapd0]
  241 root         0 SW<  [aio/0]
  245 root         0 SW<  [nfsiod]
  266 root         0 SW<  [pciehpd]
  844 root         0 SW<  [mtdblockd]
  854 root         0 SW<  [exec-osm/0]
  898 root         0 SW<  [kmemstick]
  904 root         0 SW<  [rpciod/0]
  914 root      4744 S    /usr/sbin/xinetd -stayalive -reuse -pidfile /tmp/xine
  934 root      1872 R    -/bin/sh
  958 root      1872 R    ps
# lspci
0000:40:00.0 Class 0b20: Unknown device 0222:aeae (rev 01)
0001:80:00.0 Class 0604: Unknown device aaa1:bed1 (rev 01)
0001:81:00.0 Class 0604: Unknown device 10b5:8612 (rev bb)
0001:82:01.0 Class 0604: Unknown device 10b5:8612 (rev bb)
0001:82:04.0 Class 0604: Unknown device 10b5:8612 (rev bb)
0001:82:05.0 Class 0604: Unknown device 10b5:8612 (rev bb)
0001:83:00.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:01.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:02.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:03.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:04.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:05.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:06.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:07.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:08.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:09.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0a.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0b.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0c.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0d.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0e.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0f.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:10.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:11.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:12.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:13.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:14.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:15.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:16.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:17.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:18.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:19.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1a.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1b.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1c.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1d.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1e.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1f.0 Class 0107: Unknown device 1000:0072 (rev 02)
0002:00:02.0 Class 0680: Unknown device 10e8:a002
0002:00:03.0 Class 0680: Unknown device 10e8:a002
0002:00:04.0 Class 0680: Unknown device 10e8:a002
# dmesg
0x8077ffff] flags 0x120204
pci 0001:83:1e.0: BAR 3: got res [0xe80780000-0xe807bffff] bus [0x80780000-0x807bffff] flags 0x12020
4
pci 0001:83:1e.0: BAR 3: moved to bus [0x80780000-0x807bffff] flags 0x120204
pci 0001:83:1f.0: BAR 3: got res [0xe807c0000-0xe807fffff] bus [0x807c0000-0x807fffff] flags 0x12020
4
pci 0001:83:1f.0: BAR 3: moved to bus [0x807c0000-0x807fffff] flags 0x120204
pci 0001:83:00.0: BAR 1: got res [0xe80800000-0xe80803fff] bus [0x80800000-0x80803fff] flags 0x12020
4
pci 0001:83:00.0: BAR 1: moved to bus [0x80800000-0x80803fff] flags 0x120204
pci 0001:83:01.0: BAR 1: got res [0xe80804000-0xe80807fff] bus [0x80804000-0x80807fff] flags 0x12020
4
pci 0001:83:01.0: BAR 1: moved to bus [0x80804000-0x80807fff] flags 0x120204
pci 0001:83:02.0: BAR 1: got res [0xe80808000-0xe8080bfff] bus [0x80808000-0x8080bfff] flags 0x12020
4
pci 0001:83:02.0: BAR 1: moved to bus [0x80808000-0x8080bfff] flags 0x120204
pci 0001:83:03.0: BAR 1: got res [0xe8080c000-0xe8080ffff] bus [0x8080c000-0x8080ffff] flags 0x12020
4
pci 0001:83:03.0: BAR 1: moved to bus [0x8080c000-0x8080ffff] flags 0x120204
pci 0001:83:04.0: BAR 1: got res [0xe80810000-0xe80813fff] bus [0x80810000-0x80813fff] flags 0x12020
4
pci 0001:83:04.0: BAR 1: moved to bus [0x80810000-0x80813fff] flags 0x120204
pci 0001:83:05.0: BAR 1: got res [0xe80814000-0xe80817fff] bus [0x80814000-0x80817fff] flags 0x12020
4
pci 0001:83:05.0: BAR 1: moved to bus [0x80814000-0x80817fff] flags 0x120204
pci 0001:83:06.0: BAR 1: got res [0xe80818000-0xe8081bfff] bus [0x80818000-0x8081bfff] flags 0x12020
4
pci 0001:83:06.0: BAR 1: moved to bus [0x80818000-0x8081bfff] flags 0x120204
pci 0001:83:07.0: BAR 1: got res [0xe8081c000-0xe8081ffff] bus [0x8081c000-0x8081ffff] flags 0x12020
4
pci 0001:83:07.0: BAR 1: moved to bus [0x8081c000-0x8081ffff] flags 0x120204
pci 0001:83:08.0: BAR 1: got res [0xe80820000-0xe80823fff] bus [0x80820000-0x80823fff] flags 0x12020
4
pci 0001:83:08.0: BAR 1: moved to bus [0x80820000-0x80823fff] flags 0x120204
pci 0001:83:09.0: BAR 1: got res [0xe80824000-0xe80827fff] bus [0x80824000-0x80827fff] flags 0x12020
4
pci 0001:83:09.0: BAR 1: moved to bus [0x80824000-0x80827fff] flags 0x120204
pci 0001:83:0a.0: BAR 1: got res [0xe80828000-0xe8082bfff] bus [0x80828000-0x8082bfff] flags 0x12020
4
pci 0001:83:0a.0: BAR 1: moved to bus [0x80828000-0x8082bfff] flags 0x120204
pci 0001:83:0b.0: BAR 1: got res [0xe8082c000-0xe8082ffff] bus [0x8082c000-0x8082ffff] flags 0x12020
4
pci 0001:83:0b.0: BAR 1: moved to bus [0x8082c000-0x8082ffff] flags 0x120204
pci 0001:83:0c.0: BAR 1: got res [0xe80830000-0xe80833fff] bus [0x80830000-0x80833fff] flags 0x12020
4
pci 0001:83:0c.0: BAR 1: moved to bus [0x80830000-0x80833fff] flags 0x120204
pci 0001:83:0d.0: BAR 1: got res [0xe80834000-0xe80837fff] bus [0x80834000-0x80837fff] flags 0x12020
4
pci 0001:83:0d.0: BAR 1: moved to bus [0x80834000-0x80837fff] flags 0x120204
pci 0001:83:0e.0: BAR 1: got res [0xe80838000-0xe8083bfff] bus [0x80838000-0x8083bfff] flags 0x12020
4
pci 0001:83:0e.0: BAR 1: moved to bus [0x80838000-0x8083bfff] flags 0x120204
pci 0001:83:0f.0: BAR 1: got res [0xe8083c000-0xe8083ffff] bus [0x8083c000-0x8083ffff] flags 0x12020
4
pci 0001:83:0f.0: BAR 1: moved to bus [0x8083c000-0x8083ffff] flags 0x120204
pci 0001:83:10.0: BAR 1: got res [0xe80840000-0xe80843fff] bus [0x80840000-0x80843fff] flags 0x12020
4
pci 0001:83:10.0: BAR 1: moved to bus [0x80840000-0x80843fff] flags 0x120204
pci 0001:83:11.0: BAR 1: got res [0xe80844000-0xe80847fff] bus [0x80844000-0x80847fff] flags 0x12020
4
pci 0001:83:11.0: BAR 1: moved to bus [0x80844000-0x80847fff] flags 0x120204
pci 0001:83:12.0: BAR 1: got res [0xe80848000-0xe8084bfff] bus [0x80848000-0x8084bfff] flags 0x12020
4
pci 0001:83:12.0: BAR 1: moved to bus [0x80848000-0x8084bfff] flags 0x120204
pci 0001:83:13.0: BAR 1: got res [0xe8084c000-0xe8084ffff] bus [0x8084c000-0x8084ffff] flags 0x12020
4
pci 0001:83:13.0: BAR 1: moved to bus [0x8084c000-0x8084ffff] flags 0x120204
pci 0001:83:14.0: BAR 1: got res [0xe80850000-0xe80853fff] bus [0x80850000-0x80853fff] flags 0x12020
4
pci 0001:83:14.0: BAR 1: moved to bus [0x80850000-0x80853fff] flags 0x120204
pci 0001:83:15.0: BAR 1: got res [0xe80854000-0xe80857fff] bus [0x80854000-0x80857fff] flags 0x12020
4
pci 0001:83:15.0: BAR 1: moved to bus [0x80854000-0x80857fff] flags 0x120204
pci 0001:83:16.0: BAR 1: got res [0xe80858000-0xe8085bfff] bus [0x80858000-0x8085bfff] flags 0x12020
4
pci 0001:83:16.0: BAR 1: moved to bus [0x80858000-0x8085bfff] flags 0x120204
pci 0001:83:17.0: BAR 1: got res [0xe8085c000-0xe8085ffff] bus [0x8085c000-0x8085ffff] flags 0x12020
4
pci 0001:83:17.0: BAR 1: moved to bus [0x8085c000-0x8085ffff] flags 0x120204
pci 0001:83:18.0: BAR 1: got res [0xe80860000-0xe80863fff] bus [0x80860000-0x80863fff] flags 0x12020
4
pci 0001:83:18.0: BAR 1: moved to bus [0x80860000-0x80863fff] flags 0x120204
pci 0001:83:19.0: BAR 1: got res [0xe80864000-0xe80867fff] bus [0x80864000-0x80867fff] flags 0x12020
4
pci 0001:83:19.0: BAR 1: moved to bus [0x80864000-0x80867fff] flags 0x120204
pci 0001:83:1a.0: BAR 1: got res [0xe80868000-0xe8086bfff] bus [0x80868000-0x8086bfff] flags 0x12020
4
pci 0001:83:1a.0: BAR 1: moved to bus [0x80868000-0x8086bfff] flags 0x120204
pci 0001:83:1b.0: BAR 1: got res [0xe8086c000-0xe8086ffff] bus [0x8086c000-0x8086ffff] flags 0x12020
4
pci 0001:83:1b.0: BAR 1: moved to bus [0x8086c000-0x8086ffff] flags 0x120204
pci 0001:83:1c.0: BAR 1: got res [0xe80870000-0xe80873fff] bus [0x80870000-0x80873fff] flags 0x12020
4
pci 0001:83:1c.0: BAR 1: moved to bus [0x80870000-0x80873fff] flags 0x120204
pci 0001:83:1d.0: BAR 1: got res [0xe80874000-0xe80877fff] bus [0x80874000-0x80877fff] flags 0x12020
4
pci 0001:83:1d.0: BAR 1: moved to bus [0x80874000-0x80877fff] flags 0x120204
pci 0001:83:1e.0: BAR 1: got res [0xe80878000-0xe8087bfff] bus [0x80878000-0x8087bfff] flags 0x12020
4
pci 0001:83:1e.0: BAR 1: moved to bus [0x80878000-0x8087bfff] flags 0x120204
pci 0001:83:1f.0: BAR 1: got res [0xe8087c000-0xe8087ffff] bus [0x8087c000-0x8087ffff] flags 0x12020
4
pci 0001:83:1f.0: BAR 1: moved to bus [0x8087c000-0x8087ffff] flags 0x120204
pci 0001:83:00.0: BAR 0: got res [0xfffe1000-0xfffe10ff] bus [0x1000-0x10ff] flags 0x20101
pci 0001:83:00.0: BAR 0: moved to bus [0x1000-0x10ff] flags 0x20101
pci 0001:83:01.0: BAR 0: got res [0xfffe1400-0xfffe14ff] bus [0x1400-0x14ff] flags 0x20101
pci 0001:83:01.0: BAR 0: moved to bus [0x1400-0x14ff] flags 0x20101
pci 0001:83:02.0: BAR 0: got res [0xfffe1800-0xfffe18ff] bus [0x1800-0x18ff] flags 0x20101
pci 0001:83:02.0: BAR 0: moved to bus [0x1800-0x18ff] flags 0x20101
pci 0001:83:03.0: BAR 0: got res [0xfffe1c00-0xfffe1cff] bus [0x1c00-0x1cff] flags 0x20101
pci 0001:83:03.0: BAR 0: moved to bus [0x1c00-0x1cff] flags 0x20101
pci 0001:83:04.0: BAR 0: got res [0xfffe2000-0xfffe20ff] bus [0x2000-0x20ff] flags 0x20101
pci 0001:83:04.0: BAR 0: moved to bus [0x2000-0x20ff] flags 0x20101
pci 0001:83:05.0: BAR 0: got res [0xfffe2400-0xfffe24ff] bus [0x2400-0x24ff] flags 0x20101
pci 0001:83:05.0: BAR 0: moved to bus [0x2400-0x24ff] flags 0x20101
pci 0001:83:06.0: BAR 0: got res [0xfffe2800-0xfffe28ff] bus [0x2800-0x28ff] flags 0x20101
pci 0001:83:06.0: BAR 0: moved to bus [0x2800-0x28ff] flags 0x20101
pci 0001:83:07.0: BAR 0: got res [0xfffe2c00-0xfffe2cff] bus [0x2c00-0x2cff] flags 0x20101
pci 0001:83:07.0: BAR 0: moved to bus [0x2c00-0x2cff] flags 0x20101
pci 0001:83:08.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:09.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0a.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0b.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0c.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0d.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0e.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:0f.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:10.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:11.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:12.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:13.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:14.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:15.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:16.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:17.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:18.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:19.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1a.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1b.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1c.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1d.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1e.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:83:1f.0: BAR 0: can't allocate I/O resource [0xfffe3000-0xfffe2fff]
pci 0001:82:01.0: PCI bridge, secondary bus 0001:83
pci 0001:82:01.0:   IO window: 0x1000-0x2fff
pci 0001:82:01.0:   MEM window: 0x80000000-0x808fffff
pci 0001:82:01.0:   PREFETCH window: 0x80a00000-0x819fffff
pci 0001:82:04.0: PCI bridge, secondary bus 0001:84
pci 0001:82:04.0:   IO window: disabled
pci 0001:82:04.0:   MEM window: disabled
pci 0001:82:04.0:   PREFETCH window: disabled
pci 0001:82:05.0: PCI bridge, secondary bus 0001:85
pci 0001:82:05.0:   IO window: disabled
pci 0001:82:05.0:   MEM window: disabled
pci 0001:82:05.0:   PREFETCH window: disabled
pci 0001:81:00.0: PCI bridge, secondary bus 0001:82
pci 0001:81:00.0:   IO window: 0x1000-0x2fff
pci 0001:81:00.0:   MEM window: 0x80000000-0x808fffff
pci 0001:81:00.0:   PREFETCH window: 0x80a00000-0x819fffff
pci 0001:80:00.0: PCI bridge, secondary bus 0001:81
pci 0001:80:00.0:   IO window: 0x1000-0x2fff
pci 0001:80:00.0:   MEM window: 0x80000000-0x809fffff
pci 0001:80:00.0:   PREFETCH window: 0x80a00000-0x819fffff
pci 0001:81:00.0: enabling device (0000 -> 0003)
pci 0001:81:00.0: enabling bus mastering
pci 0001:82:01.0: enabling device (0000 -> 0003)
pci 0001:82:01.0: enabling bus mastering
pci 0001:82:04.0: enabling bus mastering
pci 0001:82:05.0: enabling bus mastering
pci_bus 0000:40: resource 0 io:  [0xfffc0000-0xfffcffff]
pci_bus 0000:40: resource 1 mem: [0xe00000000-0xe7fffffff]
pci_bus 0001:80: resource 0 io:  [0xfffe0000-0xfffeffff]
pci_bus 0001:80: resource 1 mem: [0xe80000000-0xeffffffff]
pci_bus 0001:81: resource 0 io:  [0xfffe1000-0xfffe2fff]
pci_bus 0001:81: resource 1 mem: [0xe80000000-0xe809fffff]
pci_bus 0001:81: resource 2 pref mem [0xe80a00000-0xe819fffff]
pci_bus 0001:82: resource 0 io:  [0xfffe1000-0xfffe2fff]
pci_bus 0001:82: resource 1 mem: [0xe80000000-0xe808fffff]
pci_bus 0001:82: resource 2 pref mem [0xe80a00000-0xe819fffff]
pci_bus 0001:83: resource 0 io:  [0xfffe1000-0xfffe2fff]
pci_bus 0001:83: resource 1 mem: [0xe80000000-0xe808fffff]
pci_bus 0001:83: resource 2 pref mem [0xe80a00000-0xe819fffff]
pci_bus 0002:00: resource 0 io:  [0x00-0xffff]
pci_bus 0002:00: resource 1 mem: [0xd80000000-0xdffffffff]
bio: create slab <bio-0> at 0
SCSI subsystem initialized
libata version 3.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
Switched to high resolution mode on CPU 0
NET: Registered protocol family 2
IP route cache hash table entries: 16384 (order: 4, 65536 bytes)
TCP established hash table entries: 65536 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Trying to unpack rootfs image as initramfs...
rootfs image is not initramfs (no cpio magic); looks like an initrd
Freeing initrd memory: 3740k freed
irq: irq 1 on host /interrupt-controller1 mapped to virtual irq 21
irq: irq 1 on host /interrupt-controller0 mapped to virtual irq 22
JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
msgmni has been set to 1007
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
aer 0001:81:00.0:pcie12: service driver aer loaded
aer 0001:82:01.0:pcie22: service driver aer loaded
aer 0001:82:04.0:pcie22: service driver aer loaded
aer 0001:82:05.0:pcie22: service driver aer loaded
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
pciehp 0001:82:01.0:pcie24: HPC vendor_id 10b5 device_id 8612 ss_vid 0 ss_did 0
pci_bus 0001:83: dev 00, created physical slot 113
pciehp 0001:82:01.0:pcie24: service driver pciehp loaded
pciehp 0001:82:05.0:pcie24: HPC vendor_id 10b5 device_id 8612 ss_vid 0 ss_did 0
pci_bus 0001:85: dev 00, created physical slot 117
pciehp 0001:82:05.0:pcie24: service driver pciehp loaded
pciehp: PCI Express Hot Plug Controller Driver version: 0.4
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
serial8250.0: ttyS0 at MMIO 0x4ef600300 (irq = 21) is a 16550A
console [ttyS0] enabled
serial8250.0: ttyS1 at MMIO 0x4ef600400 (irq = 22) is a 16550A
4ef600300.serial: ttyS0 at MMIO 0x4ef600300 (irq = 21) is a 16550
4ef600400.serial: ttyS1 at MMIO 0x4ef600400 (irq = 22) is a 16550
brd: module loaded
PPC 4xx OCP EMAC driver, version 3.54
irq: irq 6 on host /interrupt-controller2 mapped to virtual irq 24
irq: irq 7 on host /interrupt-controller2 mapped to virtual irq 25
irq: irq 3 on host /interrupt-controller2 mapped to virtual irq 26
irq: irq 4 on host /interrupt-controller2 mapped to virtual irq 27
irq: irq 5 on host /interrupt-controller2 mapped to virtual irq 28
MAL v2 /plb/mcmal, 2 TX channels, 16 RX channels
ZMII /plb/opb/emac-zmii@ef600d00 initialized
RGMII /plb/opb/emac-rgmii@ef601500 initialized with MDIO support
TAH /plb/opb/emac-tah@ef601350 initialized
TAH /plb/opb/emac-tah@ef601450 initialized
irq: irq 16 on host /interrupt-controller2 mapped to virtual irq 29
irq: irq 20 on host /interrupt-controller2 mapped to virtual irq 31
/plb/opb/emac-rgmii@ef601500: input 0 in RGMII mode
/plb/opb/ethernet@ef600e00: reset timeout
eth0: EMAC-0 /plb/opb/ethernet@ef600e00, MAC 00:00:00:00:00:00
eth0: found Generic MII PHY (0x00)
irq: irq 17 on host /interrupt-controller2 mapped to virtual irq 32
irq: irq 21 on host /interrupt-controller2 mapped to virtual irq 33
/plb/opb/emac-rgmii@ef601500: input 1 in RGMII mode
/plb/opb/ethernet@ef600f00: reset timeout
eth1: EMAC-1 /plb/opb/ethernet@ef600f00, MAC 00:00:00:00:00:00
eth1: found Generic MII PHY (0x01)
of-flash flash.5: Can't get IO address from device tree
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
I2O subsystem v1.325
i2o: max drivers = 8
i2c /dev entries driver
irq: irq 2 on host /interrupt-controller0 mapped to virtual irq 34
ibm-iic 4ef600700.i2c: using standard (100 kHz) mode
TMP423 driver init
tmp423: probe address 4c
tmp423: detected mfr=55 dev=23
PowerPC Book-E Watchdog Timer Loaded
TCP cubic registered
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module.
RAMDISK: gzip image found at block 0
VFS: Mounted root (ext2 filesystem) on device 1:0.
Freeing unused kernel memory: 160k init
Machine check in kernel mode.
Data Read PLB Error
Machine Check exception is imprecise
#

# lspci
0000:40:00.0 Class 0b20: Unknown device 0222:aeae (rev 01)
0001:80:00.0 Class 0604: Unknown device aaa1:bed1 (rev 01)
0001:81:00.0 Class 0604: Unknown device 10b5:8612 (rev bb)
0001:82:01.0 Class 0604: Unknown device 10b5:8612 (rev bb)
0001:82:04.0 Class 0604: Unknown device 10b5:8612 (rev bb)
0001:82:05.0 Class 0604: Unknown device 10b5:8612 (rev bb)
0001:83:00.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:01.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:02.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:03.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:04.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:05.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:06.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:07.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:08.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:09.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0a.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0b.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0c.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0d.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0e.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:0f.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:10.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:11.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:12.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:13.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:14.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:15.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:16.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:17.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:18.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:19.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1a.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1b.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1c.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1d.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1e.0 Class 0107: Unknown device 1000:0072 (rev 02)
0001:83:1f.0 Class 0107: Unknown device 1000:0072 (rev 02)
0002:00:02.0 Class 0680: Unknown device 10e8:a002
0002:00:03.0 Class 0680: Unknown device 10e8:a002
0002:00:04.0 Class 0680: Unknown device 10e8:a002
#



# lspci -v
0000:40:00.0 Class 0b20: Unknown device 0222:aeae (rev 01)
        Flags: bus master, fast devsel, latency 0
        Memory at e00000000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [7c] Vital Product Data
        Capabilities: [40] Power Management version 3
        Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable-
        Capabilities: [58] Express Legacy Endpoint IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [1f8] Unknown (11)

0001:80:00.0 Class 0604: Unknown device aaa1:bed1 (rev 01)
        Flags: bus master, fast devsel, latency 0
        Memory at <unassigned> (32-bit, prefetchable)
        Bus: primary=80, secondary=81, subordinate=bf, sec-latency=0
        I/O behind bridge: 00001000-00002fff
        Memory behind bridge: 80000000-809fffff
        Prefetchable memory behind bridge: 0000000080a00000-00000000819fffff
        Capabilities: [7c] Vital Product Data
        Capabilities: [40] Power Management version 3
        Capabilities: [48] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable-
        Capabilities: [58] Express Root Port (Slot-) IRQ 0
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [1f8] Unknown (11)

0001:81:00.0 Class 0604: Unknown device 10b5:8612 (rev bb)
        Flags: bus master, fast devsel, latency 0
        Memory at e80900000 (32-bit, non-prefetchable) [size=128K]
        Bus: primary=81, secondary=82, subordinate=85, sec-latency=0
        I/O behind bridge: 00001000-00002fff
        Memory behind bridge: 80000000-808fffff
        Prefetchable memory behind bridge: 0000000080a00000-00000000819fffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/2 Enable-
        Capabilities: [68] Express Upstream Port IRQ 0
        Capabilities: [a4] Subsystem: Unknown device 10b5:8612
        Capabilities: [100] Device Serial Number 00-0e-df-b5-10-00-86-aa
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [148] Virtual Channel
        Capabilities: [448] Unknown (11)
        Capabilities: [950] Unknown (11)

0001:82:01.0 Class 0604: Unknown device 10b5:8612 (rev bb)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=82, secondary=83, subordinate=83, sec-latency=0
        I/O behind bridge: 00001000-00002fff
        Memory behind bridge: 80000000-808fffff
        Prefetchable memory behind bridge: 0000000080a00000-00000000819fffff
        Capabilities: [40] Power Management version 3
        Capabilities: [48] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/2 Enable-
        Capabilities: [68] Express Downstream Port (Slot+) IRQ 0
        Capabilities: [a4] Subsystem: Unknown device 10b5:8612
        Capabilities: [100] Device Serial Number 00-0e-df-b5-10-00-86-aa
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Unknown (13)
        Capabilities: [950] Unknown (11)

0001:82:04.0 Class 0604: Unknown device 10b5:8612 (rev bb)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=82, secondary=84, subordinate=84, sec-latency=0
        Capabilities: [40] Power Management version 3
        Capabilities: [48] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/2 Enable-
        Capabilities: [68] Express Downstream Port (Slot+) IRQ 0
        Capabilities: [a4] Subsystem: Unknown device 10b5:8612
        Capabilities: [100] Device Serial Number 00-0e-df-b5-10-00-86-aa
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Unknown (13)
        Capabilities: [950] Unknown (11)

0001:82:05.0 Class 0604: Unknown device 10b5:8612 (rev bb)
        Flags: bus master, fast devsel, latency 0
        Bus: primary=82, secondary=85, subordinate=85, sec-latency=0
        Capabilities: [40] Power Management version 3
        Capabilities: [48] Message Signalled Interrupts: Mask+ 64bit+ Queue=0/2 Enable-
        Capabilities: [68] Express Downstream Port (Slot+) IRQ 0
        Capabilities: [a4] Subsystem: Unknown device 10b5:8612
        Capabilities: [100] Device Serial Number 00-0e-df-b5-10-00-86-aa
        Capabilities: [fb4] Advanced Error Reporting
        Capabilities: [148] Virtual Channel
        Capabilities: [520] Unknown (13)
        Capabilities: [950] Unknown (11)

0001:83:00.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at 1000 [disabled] [size=256]
        Memory at e80800000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80000000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80a00000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:01.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at 1400 [disabled] [size=256]
        Memory at e80804000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80040000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80a80000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:02.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at 1800 [disabled] [size=256]
        Memory at e80808000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80080000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80b00000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:03.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at 1c00 [disabled] [size=256]
        Memory at e8080c000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e800c0000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80b80000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:04.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at 2000 [disabled] [size=256]
        Memory at e80810000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80100000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80c00000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:05.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at 2400 [disabled] [size=256]
        Memory at e80814000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80140000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80c80000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:06.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at 2800 [disabled] [size=256]
        Memory at e80818000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80180000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80d00000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:07.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at 2c00 [disabled] [size=256]
        Memory at e8081c000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e801c0000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80d80000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:08.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80820000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80200000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80e00000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:09.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80824000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80240000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80e80000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:0a.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80828000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80280000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80f00000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:0b.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e8082c000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e802c0000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e80f80000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:0c.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80830000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80300000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81000000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:0d.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80834000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80340000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81080000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:0e.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80838000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80380000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81100000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:0f.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e8083c000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e803c0000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81180000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:10.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80840000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80400000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81200000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:11.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80844000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80440000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81280000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:12.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80848000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80480000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81300000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:13.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e8084c000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e804c0000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81380000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:14.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80850000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80500000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81400000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:15.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80854000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80540000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81480000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:16.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80858000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80580000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81500000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:17.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e8085c000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e805c0000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81580000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:18.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80860000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80600000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81600000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:19.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80864000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80640000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81680000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:1a.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80868000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80680000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81700000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:1b.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e8086c000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e806c0000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81780000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:1c.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80870000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80700000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81800000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:1d.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80874000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80740000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81880000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:1e.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e80878000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e80780000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81900000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0001:83:1f.0 Class 0107: Unknown device 1000:0072 (rev 02)
        Subsystem: Unknown device 1000:0072
        Flags: fast devsel, IRQ 19
        I/O ports at <ignored> [disabled]
        Memory at e8087c000 (64-bit, non-prefetchable) [disabled] [size=16K]
        Memory at e807c0000 (64-bit, non-prefetchable) [disabled] [size=256K]
        [virtual] Expansion ROM at e81980000 [disabled] [size=512K]
        Capabilities: [50] Power Management version 3
        Capabilities: [68] Express Endpoint IRQ 0
        Capabilities: [d0] Vital Product Data
        Capabilities: [a8] Message Signalled Interrupts: Mask- 64bit+ Queue=0/0 Enable-
        Capabilities: [c0] MSI-X: Enable- Mask- TabSize=15
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [138] Power Budgeting
        Capabilities: [150] Unknown (16)
        Capabilities: [190] Unknown (14)

0002:00:02.0 Class 0680: Unknown device 10e8:a002
        Subsystem: Unknown device 1014:cafe
        Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 20
        Capabilities: [c0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable-
        Capabilities: [d0] Power Management version 2
        Capabilities: [dc] PCI-X non-bridge device
        Capabilities: [48] Vital Product Data

0002:00:03.0 Class 0680: Unknown device 10e8:a002
        Subsystem: Unknown device 1014:cafe
        Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 20
        Capabilities: [c0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable-
        Capabilities: [d0] Power Management version 2
        Capabilities: [dc] PCI-X non-bridge device
        Capabilities: [48] Vital Product Data

0002:00:04.0 Class 0680: Unknown device 10e8:a002
        Subsystem: Unknown device 1014:cafe
        Flags: bus master, 66MHz, medium devsel, latency 128, IRQ 20
        Capabilities: [c0] Message Signalled Interrupts: Mask- 64bit+ Queue=0/2 Enable-
        Capabilities: [d0] Power Management version 2
        Capabilities: [dc] PCI-X non-bridge device
        Capabilities: [48] Vital Product Data
