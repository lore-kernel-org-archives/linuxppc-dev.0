Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by ozlabs.org (Postfix) with ESMTP id C8D8ADDEA3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 19:50:22 +1100 (EST)
Received: from [192.168.0.2] (sou45-1-82-229-118-71.fbx.proxad.net
	[82.229.118.71])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 63C2943860
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 09:50:20 +0100 (CET)
Subject: Kernel 2.6.17.1 starts hangs after Data machine check in kernel mode.
From: alayrac christophe <christophe.alayrac@cresitt.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Fri, 19 Jan 2007 10:50:22 +0100
Message-Id: <1169200222.22903.3.camel@localhost.localdomain>
Mime-Version: 1.0
Reply-To: christophe.alayrac@cresitt.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I work in parallel on Linux 2.6.17.1 and 2.6.18.1 on ML403.

I've compiled 2.6.17.1 Kernel with TEMAC (V3) and without sysace, the
kernel starts and hangs after 

loaded at:     00400000 0050513C
board data at: 00503124 0050313C
relocated to:  004050EC 00405104
zimage at:     00405801 00502547
avail ram:     00506000 10000000

Linux/PPC load: console=ttyS0,9600 root=/dev/xsa2 rw
Uncompressing Linux...done.
Now booting the kernel
[    0.000000] Linux version 2.6.17.1 (alayrac@debian-ca) (gcc version
3.4.4) #1 Fri Jan 19 10:38:21 CET 2007
[    0.000000] Xilinx ML403 Reference System (Virtex-4 FX)
[    0.000000] Built 1 zonelists
[    0.000000] Kernel command line: console=ttyS0,9600 root=/dev/xsa2 rw
[    0.000000] Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
[    0.000000] PID hash table entries: 2048 (order: 11, 8192 bytes)
[    0.000428] Console: colour dummy device 80x25
[    0.004712] Dentry cache hash table entries: 32768 (order: 5, 131072
bytes)
[    0.012290] Inode-cache hash table entries: 16384 (order: 4, 65536
bytes)
[    0.150054] Memory: 257536k available (1628k kernel code, 568k data,
88k init, 0k highmem)
[    0.233133] Mount-cache hash table entries: 512
[    0.247246] NET: Registered protocol family 16
[    0.268793] NET: Registered protocol family 2
[    0.309110] IP route cache hash table entries: 2048 (order: 1, 8192
bytes)
[    0.311373] TCP established hash table entries: 8192 (order: 3, 32768
bytes)
[    0.312988] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.313749] TCP: Hash tables configured (established 8192 bind 4096)
[    0.313845] TCP reno registered
[    0.335743] NTFS driver 2.1.27 [Flags: R/O].
[    0.336875] io scheduler noop registered
[    0.337131] io scheduler anticipatory registered (default)
[    0.337388] io scheduler deadline registered
[    0.337812] io scheduler cfq registered
[    1.831649] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
sharing disabled
[    1.852831] serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 3) is a
16550A
[    3.590081] RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
[    3.694226] loop: loaded (max 8 devices)
[    3.744225] nbd: registered device at major 43
[    3.834593] tun: Universal TUN/TAP device driver, 1.6
[    3.895562] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    3.972697] Data machine check in kernel mode.


Does some have any idea to solve the problem?

NOTE :
 Board ML403
 Processor : ppc405
 Xilinx toolchain : EDK 8.2.02
 Hard Design : from scratch UART16550, TEMAC (V3), Sysace, DDR 32M, BRAM
16k, GPIO

Chris
