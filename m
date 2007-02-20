Return-Path: <Glenn.G.Hart@us.westinghouse.com>
Received: from swec9607.wecnq.com (swec9607.wecnq.com [147.72.234.65])
	by ozlabs.org (Postfix) with ESMTP id F32E1DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 06:53:38 +1100 (EST)
Subject: V4FX12 Console Hangs
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF97129A82.CDA81B10-ON05257288.006C7800-85257288.006D48A7@ct.wec.com>
From: Glenn.G.Hart@us.westinghouse.com
Date: Tue, 20 Feb 2007 14:53:38 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have Linux 2.6.19 running on an ML403 board.  Everything seems to be
working OK (except the network throughput is 1/6 the CPU speed).  I am now
trying to get Linux working on my Memec/Avnet Mini-Module.  Both evaluation
boards have the V4FX12 FPGA running on them.  I believe the only difference
is the package size so you I/O is decreased (and therefore no TEMAC, just
EMAC).  I took my Linux kernel source and followed the same procedure as
the ML403 board.  After the kernel boots the console hangs.

I have tried changing the IRQ trigger from Level to Edge, using a 16450
instead of the 16550, and putting the RS232 port on the PLB instead of the
OPB.  All have the same result.  I have tested my serial cable using the
design references from Avnet using the Xilkernel.

I am using BusyBox 1.2.1 with out inittab.  I was using /sbin/init, but
changed in the example below to just calling /bin/lash (both had the
console hang).

Has anybody every seen this problem before?  Any suggestions?

Attached below is the output from the kernel.

Thanks,
Glenn

loaded at:     00400000 0054C13C
board data at: 0054A124 0054A13C
relocated to:  004040B4 004040CC
zimage at:     00404E41 004D72F0
initrd at:     004D8000 005498CF
avail ram:     0054D000 04000000

Linux/PPC load: console=ttyS0,9600 root=/dev/ram rw init=/bin/lash
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.19 (root@AFedora3) (gcc version 3.4.5) #12
Mon Feb 19 23:10:12 EST 2007
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->    16384
[    0.000000]   Normal      16384 ->    16384
[    0.000000] early_node_map[1] active PFN ranges
[    0.000000]     0:        0 ->    16384
[    0.000000] Built 1 zonelists.  Total pages: 16256
[    0.000000] Kernel command line: console=ttyS0,9600 root=/dev/ram rw
init=/bin/lash
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
[    0.000000] PID hash table entries: 256 (order: 8, 1024 bytes)
[    0.000425] Console: colour dummy device 80x25
[    0.001539] Dentry cache hash table entries: 8192 (order: 3, 32768
bytes)
[    0.003492] Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.036536] Memory: 62576k available (1336k kernel code, 440k data, 92k
init, 0k highmem)
[    0.121247] Mount-cache hash table entries: 512
[    0.127676] checking if image is initramfs...it isn't (no cpio magic);
looks like an initrd
[    1.426229] Freeing initrd memory: 454k freed
[    1.433856] NET: Registered protocol family 16
[    1.466534] NET: Registered protocol family 2
[    1.505111] IP route cache hash table entries: 512 (order: -1, 2048
bytes)
[    1.507226] TCP established hash table entries: 2048 (order: 1, 8192
bytes)
[    1.507700] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    1.507966] TCP: Hash tables configured (established 2048 bind 1024)
[    1.508176] TCP reno registered
[    1.516425] io scheduler noop registered
[    1.516533] io scheduler anticipatory registered (default)
[    1.516621] io scheduler deadline registered
[    1.516908] io scheduler cfq registered
[    1.619560] Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ
sharing disabled
[    1.626094] serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 1) is a 16550A
[    4.824964] RAMDISK driver initialized: 1 RAM disks of 4096K size 1024
blocksize
[    4.919006] xemac 0: using fifo mode.
[    4.966016] eth0: Xilinx EMAC #0 at 0x80400000 mapped to 0xC5000000,
irq=0
[    5.050331] mice: PS/2 mouse device common for all mice
[    5.113796] TCP cubic registered
[    5.152903] NET: Registered protocol family 1
[    5.205396] NET: Registered protocol family 17
[    5.261941] RAMDISK: Compressed image found at block 0
[    6.937724] VFS: Mounted root (ext2 filesystem).
[    6.994168] Freeing unused kernel memory: 92k init


BusyBox v1.2.1 (2007.02.14-05:38+0000) Built-in shell (lash)
Enter 'help' for a list of built-in commands.

/ #
