Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 3119D1007F5
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jan 2010 03:31:06 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1NUje3-0006J9-Ed
	for linuxppc-dev@ozlabs.org; Tue, 12 Jan 2010 08:31:03 -0800
Message-ID: <27130293.post@talk.nabble.com>
Date: Tue, 12 Jan 2010 08:31:03 -0800 (PST)
From: Dario Presti <dario.pr@tiscali.it>
To: linuxppc-dev@ozlabs.org
Subject: Re: kernel panic on MPC8323 custom board
In-Reply-To: <27128312.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <27059752.post@talk.nabble.com> <4B46209D.5000605@freescale.com>
	<27073289.post@talk.nabble.com> <4B476ABA.7050000@freescale.com>
	<27128312.post@talk.nabble.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>




Dario Presti wrote:
> 
> 
> But still hte mapping is not showed on boot, it seems to not read yet the
> blob node. The boot-log is:
> 
> 

Ok now mapping woks fine. The error was in .dts file, changing

flash@fc000000 {
		device_type = "rom";
		compatible = "cfi-flash";

in 

flash@fc000000 { 		
		device_type = "rom";
		compatible = "direct-mapped";

The partitioning works fine, but there is still kernel panic.

The boot log is:

U-Boot 1.3.2 (Jan  8 2010 - 12:57:17) MPC83XX

Reset Status:

CPU:   e300c2, MPC8321E, Rev: 11 at 333.333 MHz, CSB:  133 MHz
Board: Freescale MPC8323ERDB
I2C:   ready
DRAM:  64 MB
FLASH: 64 MB
In:    serial
Out:   serial
Err:   serial
Net:   FSL UEC0, FSL UEC1
Hit any key to stop autoboot:  0
Scanning PCI devices on bus 0
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x1957     0x00a6     Processor               0x20
## Booting image at fc100000 ...
   Image Name:   Linux-2.6.20.6-rt8
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1507732 Bytes =  1.4 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0xfc080000
   Loading Device Tree to 00785000, end 007ff11f ... OK
Using MPC832x RDB machine description
Linux version 2.6.20.6-rt8 (cubit@cubit-laptop) (gcc version 4.2.3 (Sourcery
G++ Lite 4.2-171)) #13 PREEMPT Tue Jan 12 16:47:14 CET 2010
setup_arch: bootmem
mpc832x_rdb_setup_arch()
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number:
0->0
pio-handle not available
arch: exit
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists.  Total pages: 16256
Kernel command line: root=/dev/mtdblock4 rootfstype=jffs2 rw console=ttyS0,
38400
WARNING: experimental RCU implementation.
IPIC (128 IRQ sources) at fdefb700
QEIC (64 IRQ sources) at fdefa080
PID hash table entries: 256 (order: 8, 1024 bytes)

Using MPC832x RDB machine description
Linux version 2.6.20.6-rt8 (cubit@cubit-laptop) (gcc version 4.2.3 (Sourcery
G++ Lite 4.2-171)) #13 PREEMPT Tue Jan 12 16:47:14 CET 2010
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number:
0->0
pio-handle not available
Zone PFN ranges:
  DMA             0 ->    16384
  Normal      16384 ->    16384
early_node_map[1] active PFN ranges
    0:        0 ->    16384
Real-Time Preemption Support (C) 2004-2007 Ingo Molnar
Built 1 zonelists.  Total pages: 16256
Kernel command line: root=/dev/mtdblock4 rootfstype=jffs2 rw console=ttyS0,
38400
WARNING: experimental RCU implementation.
IPIC (128 IRQ sources) at fdefb700
QEIC (64 IRQ sources) at fdefa080
PID hash table entries: 256 (order: 8, 1024 bytes)
Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
Memory: 61176k/65536k available (2860k kernel code, 4292k reserved, 180k
data, 109k bss, 132k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 4, 65536 bytes)
TCP bind hash table entries: 1024 (order: 2, 28672 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
NTFS driver 2.1.28 [Flags: R/O].
JFFS2 version 2.2. (NAND) (SUMMARY)  (C) 2001-2006 Red Hat, Inc.
fuse init (API version 7.8)
JFS: nTxBlock = 478, nTxLock = 3827
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
WDT driver for MPC83xx initialized. mode:reset timeout=65535 (32 seconds)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
ucc_tdm: Freescale QE UCC TDM Driver
config_tdm Delay for Legerity!
tdm_start 16-bit linear pcm mode active with slots 0 & 2
tdm_start UCC based TDM enabled
ucc_tdm_probe UCC based tdm module installed
UCC Ethernet Controller MII Bus: probed
ucc_geth: QE UCC Gigabit Ethernet Controller
ucc_geth: UCC2 at 0xe0103000 (irq = 20)
eth0: MTU=1500 (frame
size=1518,rx_buffer_size=1536,truesize=1792,sk_buff=160)
ucc_geth: UCC3 at 0xe0102200 (irq = 34)
eth1: MTU=1500 (frame
size=1518,rx_buffer_size=1536,truesize=1792,sk_buff=160)
SKB Handler initialized(max=64)
ICPlus IP175C: Registered new driver
flash: Found 1 x16 devices at 0x0 in 16-bit bank
 Amd/Fujitsu Extended Query Table at 0x0040
flash: CFI does not contain boot bank location. Assuming top.
number of CFI chips: 1
cfi_cmdset_0002: Disabling erase-suspend-program due to code brokenness.
RedBoot partition parsing not available
physmap-flash flash: Using OF partition information
Creating 4 MTD partitions on "flash":
0x00000000-0x00080000 : "U-Boot"
0x00080000-0x00100000 : "dtb"
0x00100000-0x00300000 : "Kernel"
0x00300000-0x01000000 : "rootfs"
block2mtd: version $Revision: 1.30 $
e01004c0.spi: MPC83xx SPI Controller driver at 0xc50aa4c0 (irq = 21)
usbmon: debugfs is not available
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
i2c /dev entries driver
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
No filesystem could mount root, tried: <6>Time: timebase clocksource has
been installed.
 jffs2
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(0,0)
Call Trace:
[C03BBE70] [C000819C]  (unreliable)
[C03BBEB0] [C0026AB0]
[C03BBF00] [C02AAB98]
[C03BBF50] [C02AADEC]
[C03BBF70] [C0003B04]
[C03BBFF0] [C00102BC]
 <0>Rebooting in 180 seconds..

But still unable to mount root...any suggestion?

Thanks

Dario
-- 
View this message in context: http://old.nabble.com/kernel-panic-on-MPC8323-custom-board-tp27059752p27130293.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
