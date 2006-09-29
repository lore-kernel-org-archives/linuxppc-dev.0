Return-Path: <Glenn.G.Hart@us.westinghouse.com>
Received: from swec9607.wecnq.com (swec9607.wecnq.com [147.72.234.65])
	by ozlabs.org (Postfix) with ESMTP id 8DDDA67BC0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 12:50:53 +1000 (EST)
Subject: Trouble with 2.6 Kernel
To: linuxppc-embedded@ozlabs.org
Message-ID: <OFDBFA9712.7CA8005E-ON852571F8.000DCDDF-852571F8.000E3C3D@ct.wec.com>
From: Glenn.G.Hart@us.westinghouse.com
Date: Thu, 28 Sep 2006 22:35:26 -0400
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

I am trying to get Linux PPC 2.6.17.1 up and running on a Xilinx Virtex-4
FX 12 FPGA.  Everything appears to proceed normally, but at the end of the
kernel initialization it gives me a scheduling while atomic error.  I have
found on the web others having this problem, but without a good solution.
Do I have something configured wrong or do I need a patch.  The output of
the kernel is shown below.

  Thanks,
  Glenn

loaded at:     00400000 004E113C
board data at: 004DF124 004DF13C
relocated to:  004050EC 00405104
zimage at:     00405801 004DEC72
avail ram:     004E2000 10000000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/sda2
Uncompressing Linux...done.
Now booting the kernel
Linux version 2.6.17.1 (root@AFedora3) (gcc version 3.4.5) #18 PREEMPT Thu
Sep 28 02:29:45 EDT 2006
Xilinx Virtex-II Pro port
Port by MontaVista Software, Inc. (source@mvista.com)
Built 1 zonelists
Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/sda2
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 257792k available (1528k kernel code, 400k data, 84k init, 0k
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
TCP: Hash tables configured (established 8192 bind 4096)
TCP reno registered
io scheduler noop registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 1) is a 16450
RAMDISK driver initialized: 1 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
eth0: using fifo mode.
eth0: Xilinx EMAC #0 at 0x80400000 mapped to 0xD1000000, irq=0
eth0: id 2.0a; block id 0, type 8
mice: PS/2 mouse device common for all mice
ip_conntrack version 2.4 (2048 buckets, 16384 max) - 188 bytes per
conntrack
BUG: scheduling while atomic: swapper/0xffffffff/1
Call Trace:
[C0451E50] [C0008F20] show_stack+0x58/0x180 (unreliable)
[C0451E80] [C017AAC0] schedule+0x48/0x6e4
[C0451EB0] [C017B340] wait_for_completion+0xbc/0x158
[C0451EF0] [C003400C] synchronize_rcu+0x38/0x48
[C0451F30] [C01140D4] synchronize_net+0x10/0x20
[C0451F40] [C0124760] nf_register_hook+0xac/0xc0
[C0451F50] [C0124860] nf_register_hooks+0x34/0x7c
[C0451F70] [C01DD3C0] ip_conntrack_standalone_init+0xb8/0x154
[C0451F90] [C0002470] init+0xa4/0x280
[C0451FF0] [C00051FC] kernel_thread+0x44/0x60
