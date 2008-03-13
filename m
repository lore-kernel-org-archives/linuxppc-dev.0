Return-Path: <guojin02@tsinghua.org.cn>
Received: from tsinghua.org.cn (mail.tsinghua.org.cn [210.77.143.232])
	by ozlabs.org (Postfix) with SMTP id BF6D8DDEF2
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Mar 2008 18:00:31 +1100 (EST)
Message-ID: <405390330.01503@tsinghua.org.cn>
From: "=?gb2312?B?ufm+og==?=" <guojin02@tsinghua.org.cn>
To: support.asia@freescale.com, linuxppc-embedded@ozlabs.org,
	u-boot-users@lists.sourceforge.net
Date: Thu, 13 Mar 2008 14:38:50 +0800
Subject: Hi, friends,
	the question about the core frequency on u-boot and device tree?
Content-Type: text/plain
Reply-To: =?gb2312?B?ufm+og==?= <guojin02@tsinghua.org.cn>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

HI,friends,

The core frequency and bus frequency and QE frequency on MPC8360 are configed
during the loading of HRCW and the CLKIN or PCI_CLKIN, in the u-boot-1.2.0, I can
use the "clocks" command to show all kind of frequecy,at this time the core
frequency is 528MHZ. please see follow:
 => clocks
Clock configuration Guo Jing:
  Core:                 528 MHz
  Coherent System Bus:  264 MHz
  QE:                   396 MHz
  BRG:                  198 MHz
  Local Bus Controller: 264 MHz
  Local Bus:             66 MHz
  DDR:                  264 MHz
  DDR Secondary:        264 MHz
  SEC:                   88 MHz
  I2C1:                 264 MHz
  I2C2:                 264 MHz

Then, I modified the device tree source code to make the core frequency is 660MHZ.
		
PowerPC,8360@0 {
			device_type = "cpu";
			reg = <0>;
			d-cache-line-size = <20>;	// 32 bytes
			i-cache-line-size = <20>;	// 32 bytes
			d-cache-size = <8000>;		// L1, 32K
			i-cache-size = <8000>;		// L1, 32K
			timebase-frequency = <3EF1480>; //66MHZ
			bus-frequency = <FBC5200>;    //264MHZ 
			clock-frequency = <2756CD00>; //660MHZ
			32-bit;
		};
The device tree will send the core frequency information to linux kernel. Then I
bootm the linux by above dtb blob. follow is the dmesg information. we can see
that:
time_init: decrementer frequency = 66.000000 MHz
time_init: processor frequency   = 660.000000 MHz

I am so confused with the core frequency. I think the dmesg show the wrong core
frequency because the actual core freqyency is decided by the power on of cpu. The
device tree just only send a false frequency to the linux kernel.
My question is which frequency, 660MHZ or the 528MHZ, is the actual core
frequency?  
Which one, the HRCW or the device tree, decide the actual frequency of core?
If we can use the device tree to re-assign the core frequency, how this process is
finished?



~ # dmesg
Using MPC836x MDS machine description
Linux version 2.6.22 (dpim@localhost.localdomain) (gcc version 4.0.2 20060628
(Wasabi)) #2 Mon Mar 10 01:02:46 EST 2008
Found initrd at 0xcfc39000:0xcffa4fa3
Found legacy serial port 0 for /soc8360@e0000000/serial@4500
  mem=e0004500, taddr=e0004500, irq=0, clk=264000000, speed=0
Found legacy serial port 1 for /soc8360@e0000000/serial@4600
  mem=e0004600, taddr=e0004600, irq=0, clk=264000000, speed=0
Entering add_active_range(0, 0, 524288) 0 entries of 256 used
Found MPC83xx PCI host bridge at 0x00000000e0008500. Firmware bus number: 0->0
Bad clock source for time stamp 1
Bad clock source for time stamp 2
pio-handle not available 
Top of RAM: 0x80000000, Total RAM: 0x80000000
Memory hole size: 0MB
Zone PFN ranges:
  DMA             0 ->   196608
  Normal     196608 ->   196608
  HighMem    196608 ->   524288
early_node_map[1] active PFN ranges
    0:        0 ->   524288
On node 0 totalpages: 524288
  DMA zone: 1536 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 195072 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
  HighMem zone: 2560 pages used for memmap
  HighMem zone: 325120 pages, LIFO batch:31
Built 1 zonelists.  Total pages: 520192
Kernel command line: console=ttyS0,115200 root=/dev/ram rw
IPIC (128 IRQ sources) at fddf3700
QEIC (64 IRQ sources) at fddf2080
PID hash table entries: 4096 (order: 12, 16384 bytes)
time_init: decrementer frequency = 66.000000 MHz
time_init: processor frequency   = 660.000000 MHz
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
High memory: 1310720k
Memory: 2072044k/2097152k available (2692k kernel code, 1334664k reserved, 112k
data, 122k bss, 144k init)
Calibrating delay loop... 131.58 BogoMIPS (lpj=263168)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
fsl_sec2_of_init: start
PCI: Probing PCI hardware
Registering qe_ic with sysfs...
Registering ipic with sysfs...
Generic PHY: Registered new driver
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Freeing initrd memory: 3503k freed
highmem bounce pool size: 64 pages
JFFS2 version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
cryptodev_init(c02921e8)
cryptosoft: registered as device: 0
talitos: des/3des aes md5 sha1
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
Generic RTC Driver v1.07
WDT driver for MPC83xx initialized. mode:reset timeout=65535 (16 seconds)
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
console handover: boot [udbg0] -> real [ttyS0]
serial8250.0: ttyS1 at MMIO 0xe0004600 (irq = 17) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: module loaded
UCC Ethernet Controller MII Bus: probed
ucc_geth: QE UCC Gigabit Ethernet Controller
ucc_geth: UCC1 at 0xe0102000 (irq = 23) 
eth0: MTU=1500 (frame size=1518,rx_buffer_size=1536,truesize=1792,sk_buff=160)
ucc_geth: UCC2 at 0xe0103000 (irq = 24) 
eth1: MTU=1500 (frame size=1518,rx_buffer_size=1536,truesize=1792,sk_buff=160)
SKB Handler initialized(max=64)
Marvell 88E1101: Registered new driver
Marvell 88E1111: Registered new driver
Marvell 88E1145: Registered new driver
MPC8360E MDS flash device: 2000000 at fe000000 Partition number 6
MPC8360E MDS Flash Map Info: Found 1 x16 devices at 0x0 in 16-bit bank
MPC8360E MDS Flash Map Info: Found an alias at 0x1000000 for the chip at 0x0
Support for command set 0001 not present
gen_probe: No supported Vendor Command Set found
i2c /dev entries driver
ds1374 0-0068: rtc core: registered ds1374 as rtc0
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ds1374 0-0068: setting the system clock to 1972-02-18 11:35:36 (67260936)
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 144k init
PHY: e0102120:00 - Link is Up - 1000/Full
