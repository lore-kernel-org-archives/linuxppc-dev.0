Return-Path: <Glenn.G.Hart@us.westinghouse.com>
Received: from swec9607.wecnq.com (swec9607.wecnq.com [147.72.234.65])
	by ozlabs.org (Postfix) with ESMTP id B37B367EA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Oct 2006 02:55:34 +1000 (EST)
Subject: Problem with initrd
To: linuxppc-embedded@ozlabs.org
Message-ID: <OF1D5D325D.8937E77C-ON852571FD.005C0832-852571FD.005CF8D2@ct.wec.com>
From: Glenn.G.Hart@us.westinghouse.com
Date: Wed, 4 Oct 2006 12:55:29 -0400
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

I am trying to get Linux running on the PPC of a Xilinx V4-FX12 FPGA.  I am
using the Linux 2.6.17.9 kernel (I have also tried 2.6.17.1 with the same
results) and have gotten through the kernel initialization to the point
where it mounts the root file system.  At this point I can an Oops and a
kernel panic.  I traced the kernel and found it was happening on the gunzip
of the ramdisk image.  I tried without compressing the ramdisk image and I
got a slightly different error.  I have attached this output as well.  I am
not a kernel expert, but I am guessing it is having trouble accessing the
RAM for the ramdisk.  Can anybody offer some advice?

Thanks,
Glenn

With compress ramdisk image:

loaded at:     00400000 0052B13C
board data at: 00529124 0052913C
relocated to:  004050F0 00405108
zimage at:     00405805 004D072E
initrd at:     004D1000 00528981
avail ram:     0052C000 10000000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/ram rw
Uncompressing Linux...done.
Now booting the kernel
initrd start c04d1000 end c0528981
Linux version 2.6.17.9 (root@AFedora3) (gcc version 3.4.5) #32 PREEMPT Tue
Oct 3 23:25:12 EDT 2006
Xilinx Virtex-II Pro port
Port by MontaVista Software, Inc. (source@mvista.com)
Built 1 zonelists
Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/ram rw
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 257408k available (1424k kernel code, 368k data, 80k init, 0k
highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (no cpio magic); looks like an
initrd
Freeing initrd memory: 350k freed
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
loop: loaded (max 2 devices)
nbd: registered device at major 43
eth0: using fifo mode.
eth0: Xilinx EMAC #0 at 0x80400000 mapped to 0xD1000000, irq=0
eth0: id 2.0a; block id 0, type 8
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: Compressed image found at block 0
allocated in buffer
allocated window buffer
make crc
gunzip
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C004115C LR: C0041148 CTR: C00FA29C
REGS: c0421610 TRAP: 0300   Not tainted  (2.6.17.9)
MSR: 00029030 <EE,ME,IR,DR>  CR: 35035093  XER: E0000000
DAR: 00001000, DSISR: 00800000
TASK = c0529b10[1] 'swapper' THREAD: c0420000
GPR00: C0041148 C04216C0 C0529B10 00000000 00000001 00000001 C04216A8
00000000
GPR08: 00000000 00001000 00000400 00000000 35035099 FFFF9620 00000001
C04216D0
GPR16: C018CD50 C04C88A0 C052FC08 00000000 00001000 00010000 C052FCA8
00000000
GPR24: 00140000 C0450000 00000000 00001000 C01E3F20 00001000 00001000
00000000
NIP [C004115C] generic_file_buffered_write+0x4ec/0x5bc
LR [C0041148] generic_file_buffered_write+0x4d8/0x5bc
Call Trace:
[C04216C0] [C0041148] generic_file_buffered_write+0x4d8/0x5bc (unreliable)
[C0421780] [C0041A10] __generic_file_aio_write_nolock+0x4d4/0x50c
[C0421810] [C0041DB8] generic_file_aio_write_nolock+0x28/0x98
[C0421830] [C0041EA0] generic_file_write_nolock+0x78/0xa8
[C04218D0] [C00657F8] blkdev_file_write+0x20/0x30
[C04218E0] [C005B400] vfs_write+0xc8/0x190
[C0421900] [C005B5A0] sys_write+0x4c/0x8c
[C0421930] [C01AD2D4] flush_window+0x34/0xe4
[C0421950] [C01AD8B8] inflate_codes+0x468/0x4b0
[C04219A0] [C01AE0E0] inflate_dynamic+0x64c/0x690
[C0421EE0] [C01AEA1C] rd_load_image+0x8f4/0x106c
[C0421F40] [C01AF33C] initrd_load+0x4c/0x304
[C0421F70] [C01ACCB8] prepare_namespace+0xa8/0x11c
[C0421F90] [C0002580] init+0x1b4/0x280
[C0421FF0] [C00051FC] kernel_thread+0x44/0x60
Instruction dump:
48006591 2f9d0000 419c001c 7ec3b378 38800001 4800441d 48120851 2f930000
409efbe8 8061005c 81210064 2f830000 <92e90000> 93090004 41be0008 48006555
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 180 seconds.


With uncompress ramdisk image:

loaded at:     00400000 008D313C
board data at: 008D1124 008D113C
relocated to:  004050F0 00405108
zimage at:     00405805 004D072C
initrd at:     004D1000 008D1000
avail ram:     008D4000 10000000

Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/ram rw
Uncompressing Linux...done.
Now booting the kernel
initrd start c04d1000 end c08d1000
Linux version 2.6.17.9 (root@AFedora3) (gcc version 3.4.5) #33 PREEMPT Wed
Oct 4 00:18:59 EDT 2006
Xilinx Virtex-II Pro port
Port by MontaVista Software, Inc. (source@mvista.com)
Built 1 zonelists
Kernel command line: console=ttyS0,9600 console=tty0 root=/dev/ram rw
Xilinx INTC #0 at 0x41200000 mapped to 0xFDFFE000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 253696k available (1424k kernel code, 368k data, 80k init, 0k
highmem)
Mount-cache hash table entries: 512
checking if image is initramfs...it isn't (bad gzip magic numbers); looks
like an initrd
Freeing initrd memory: 4096k freed
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
loop: loaded (max 2 devices)
nbd: registered device at major 43
eth0: using fifo mode.
eth0: Xilinx EMAC #0 at 0x80400000 mapped to 0xD1000000, irq=0
eth0: id 2.0a; block id 0, type 8
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
RAMDISK: ext2 filesystem found at block 0
found ramdisk # blocks = 4096 /initrd.image
RAMDISK: Loading 4096KiB [1 disk] into ram disk... Oops: Exception in
kernel mode, sig: 4 [#1]
PREEMPT
NIP: C0079058 LR: C0079018 CTR: 00000000
REGS: c08e1c20 TRAP: 0700   Not tainted  (2.6.17.9)
MSR: 00029030 <EE,ME,IR,DR>  CR: 35005093  XER: C0000000
TASK = c04c9b10[1] 'swapper' THREAD: c08e0000
GPR00: 11A49A00 C08E1CD0 C04C9B10 C08E1CD8 C08E1CB8 00000001 C08D4C00
00000003
GPR08: 11A49A00 11A49A00 11A49A00 C08D26AC 00000400 FFFF9620 00000002
C08D2664
GPR16: 00000002 00000001 C08E1EC0 C04C26C0 00000000 C08E1DA0 000003FF
C08D2704
GPR24: 00001000 00000000 00400000 00000400 00000001 00000400 00000000
C08D2664
NIP [C0079058] touch_atime+0xc4/0xd8
LR [C0079018] touch_atime+0x84/0xd8
Call Trace:
[C08E1CD0] [C0079018] touch_atime+0x84/0xd8 (unreliable)
[C08E1CF0] [C003FBF0] do_generic_mapping_read+0x490/0x4a4
[C08E1D90] [C00420BC] __generic_file_aio_read+0x1ec/0x238
[C08E1DE0] [C0042238] generic_file_read+0x88/0xb8
[C08E1E90] [C005B16C] vfs_read+0xc8/0x190
[C08E1EB0] [C005B514] sys_read+0x4c/0x8c
[C08E1EE0] [C01AF100] rd_load_image+0xfd8/0x106c
[C08E1F40] [C01AF33C] initrd_load+0x4c/0x304
[C08E1F70] [C01ACCB8] prepare_namespace+0xa8/0x11c
[C08E1F90] [C0002580] init+0x1b4/0x280
[C08E1FF0] [C00051FC] kernel_thread+0x44/0x60
Instruction dump:
409e0014 800b0004 8121000c 7f804800 419e0020 81210008 8141000c 7fe3fb78
913f0048 915f004c 38800001 4800b1a1 <00000000> 00000800 7c0803a6 38210020
Kernel panic - not syncing: Attempted to kill init!
 <0>Rebooting in 180 seconds..
