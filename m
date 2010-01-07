Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 9E5D5B6EF3
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jan 2010 00:11:39 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1NSs9I-0007Yb-Ec
	for linuxppc-dev@ozlabs.org; Thu, 07 Jan 2010 05:11:36 -0800
Message-ID: <27059752.post@talk.nabble.com>
Date: Thu, 7 Jan 2010 05:11:36 -0800 (PST)
From: Dario Presti <dario.pr@tiscali.it>
To: linuxppc-dev@ozlabs.org
Subject: kernel panic on MPC8323 custom board
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hello,
I'm working on MPC8323_rdb board whit 1 new flash device S29GL512P instead
of original flash devices.
the bootloader is u-boot 1.1.6 (I know is too old and I'm going to upgrade
it) and the kernel is 2.6.20.
I did this modification to the bootloader to support new flash:

1)I modified the board/mpc8323rdb/config.mk file to set TEXT_BASE from
0xFE000000 TO  0xFC000000
2)I modified the file /include/configs/MPC8323RDB.h: 

#define CFG_FLASH_BASE		0xFC000000	/* FLASH base address */ 
#define CFG_FLASH_SIZE		64	/* FLASH size is 64M */ 
#define CFG_LBLAWBAR0_PRELIM	CFG_FLASH_BASE	/* Window base at flash base */
#define CFG_LBLAWAR0_PRELIM	0x80000019	/* 64MB window size */ 
#define CFG_OR0_PRELIM		0xfc006ff7	/* 64MB Flash size */ 
#define CFG_MAX_FLASH_BANKS	1		/* number of banks */
#define CFG_MAX_FLASH_SECT	512		/* sectors per device */ 

3)I modify and recompiled .dts file 

flash@fc000000 {
		device_type = "jedec-flash";
		compatible = "direct-mapped";
		probe-type = "CFI";
		reg = <0xfc000000 0x1000000>;
		bank-width = <0x2>;
		partitions = <0x0 0x80001 0x80000 0x20000 0xa0000 0x180000 0x220000
0xde0000>;
		partition-names = "U-Boot", "dtb", "Kernel", "rootfs";
	};

but the kernel find the flash at 0xFE000000 and the boot stop because kernel
panic. The log is:

U-Boot 1.1.6 (Dec 16 2009 - 18:24:26) MPC83XX

Clock configuration:
  Coherent System Bus:  133 MHz
  Core:                 333 MHz
  QE:                   200 MHz
  BRG:                  100 MHz
  Local Bus Controller: 133 MHz
  Local Bus:             66 MHz
  DDR:                  266 MHz
  SEC:                  133 MHz
  I2C1:                 133 MHz
CPU: MPC8321E, Rev: 11 at 333.333 MHz
Board: Freescale MPC8323ERDB
I2C:   ready
DRAM:
   DDR RAM: 64 MB
FLASH: 64 MB
PCI clock is 66MHz
In:    serial
Out:   serial
Err:   serial
Net:   UEC: PHY is Generic MII (2430d80)
UEC: PHY is Generic MII (2430d80)
FSL UEC0, FSL UEC1
Hit any key to stop autoboot:  0
Scanning PCI devices on bus 0
BusDevFun  VendorId   DeviceId   Device Class       Sub-Class
_____________________________________________________________
00.00.00   0x1957     0x00a6     Processor               0x20
## Booting image at fc100000 ...
   Image Name:   Linux-2.6.20.6-rt8
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1872707 Bytes =  1.8 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using flat device tree at 0xfc080000
   Loading Device Tree to 00783000, end 007fd11f ... Using MPC832x RDB
machine description
Linux version 2.6.20.6-rt8 (design@telsa024) (gcc version 4.0.2 20060628
(Wasabi)) #4 PREEMPT Fri Mar 28 10:31:51 CET 2008
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
Linux version 2.6.20.6-rt8 (design@telsa024) (gcc version 4.0.2 20060628
(Wasabi)) #4 PREEMPT Fri Mar 28 10:31:51 CET 2008
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
Memory: 60408k/65536k available (3552k kernel code, 5064k reserved, 224k
data, 145k bss, 156k init)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
PCI: Probing PCI hardware
Generic PHY: Registered new driver
Sangoma WANPIPE Router v1.1 (c) 1995-2000 Sangoma Technologies Inc.
NET: Registered protocol family 8
NET: Registered protocol family 20
NET: Registered protocol family 2
IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
TCP established hash table entries: 2048 (order: 4, 65536 bytes)
TCP bind hash table entries: 1024 (order: 2, 28672 bytes)
TCP: Hash tables configured (established 2048 bind 1024)
TCP reno registered
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
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
size=1518,rx_buffer_size=1536,truesize=1800,sk_buff=168)
ucc_geth: UCC3 at 0xe0102200 (irq = 34)
eth1: MTU=1500 (frame
size=1518,rx_buffer_size=1536,truesize=1800,sk_buff=168)
SKB Handler initialized(max=64)
ICPlus IP175C: Registered new driver
hostap_plx: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
hostap_pci: 0.4.4-kernel (Jouni Malinen <jkmaline@cc.hut.fi>)
dmfe: Davicom DM9xxx net driver, version 1.36.4 (2002-01-17)
winbond-840.c:v1.01-e (2.4 port) Sep-11-2006  Donald Becker
<becker@scyld.com>
  http://www.scyld.com/network/drivers.html
uli526x: ULi M5261/M5263 net driver, version 0.9.3 (2005-7-29)
MPC8323RDB Flash Bank 1 device: 2000000 at fe000000 Partition number 6
MPC8323RDB Flash Bank 1 Map Info: Found 1 x16 devices at 0x0 in 16-bit bank
NOR chip too large to fit in mapping. Attempting to cope...
Support for command set 0002 not present
gen_probe: No supported Vendor Command Set found
e01004c0.spi: MPC83xx SPI Controller driver at 0xc505c4c0 (irq = 21)
i2c /dev entries driver
Driver for 1-wire Dallas network protocol.
nf_conntrack version 0.5.0 (512 buckets, 4096 max)
ip_tables: (C) 2000-2006 Netfilter Core Team
arp_tables: (C) 2002 David S. Miller
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Bridge firewalling registered
Ebtables v2.0 registered
lec.c: Mar 25 2008 16:38:30 initialized
mpc.c: Mar 25 2008 16:38:27 initialized
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation
<jketreno@linux.intel.com>
Time: timebase clocksource has been installed.
Root-NFS: No NFS server available, giving up.
VFS: Unable to mount root fs via NFS, trying floppy.
No filesystem could mount root, tried:  jffs2
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(2,0)
Call Trace:
[C047BE60] [C00088AC] show_stack+0x50/0x190 (unreliable)
[C047BE90] [C0027014] panic+0x9c/0x188
[C047BF20] [C0351AD4] mount_block_root+0x198/0x238
[C047BF70] [C0351E88] prepare_namespace+0xc4/0x1b4
[C047BF90] [C0003B68] init+0x28c/0x2b0
[C047BFF0] [C00102EC] kernel_thread+0x44/0x60
 <0>Rebooting in 180 seconds..

I think there is problem whit device tree, but I don't know what is,
could someone help me?

Thanks
Best Regards

Dario
-- 
View this message in context: http://old.nabble.com/kernel-panic-on-MPC8323-custom-board-tp27059752p27059752.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
