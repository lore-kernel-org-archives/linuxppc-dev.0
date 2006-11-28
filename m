Return-Path: <abdul.rahaman@semindia.in>
Received: from almach.lunarpages.com (almach.lunarpages.com [209.200.240.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CEDAA679A6
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Nov 2006 16:25:54 +1100 (EST)
Message-ID: <002d01c712ad$2f1f2180$ab80a8c0@xaltedindia.net>
From: "Abdul Rahaman" <abdul.rahaman@semindia.in>
To: "Adrian Craine" <adrian.craine@nec.com.au>, <linuxppc-embedded@ozlabs.org>
References: <f4d44c7f0611262040y244f4042lc6c45ceb606a6d99@mail.gmail.com>
	<004501c7120b$ebca9190$ab80a8c0@xaltedindia.net>
	<456B523B.5090504@nec.com.au>
Subject: Re: fialing @ executing /sbin/int in main.c
Date: Tue, 28 Nov 2006 10:52:14 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Adrain,

I just cheked what you have told about ld.so.1 looks its there, here the
dump of 'init'
[chandrashekharp@linux sbin]$ pwd
/home/chandrashekharp/linux/new_fs8xx/ramdisk/sbin
[chandrashekharp@linux sbin]$ readelf -lh init
ELF Header:
  Magic:   7f 45 4c 46 01 02 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF32
  Data:                              2's complement, big endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              EXEC (Executable file)
  Machine:                           PowerPC
  Version:                           0x1
  Entry point address:               0x100034c4
  Start of program headers:          52 (bytes into file)
  Start of section headers:          1010184 (bytes into file)
  Flags:                             0x0
  Size of this header:               52 (bytes)
  Size of program headers:           32 (bytes)
  Number of program headers:         8
  Size of section headers:           40 (bytes)
  Number of section headers:         40
  Section header string table index: 37

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  PHDR           0x000034 0x10000034 0x10000034 0x00120 0x00120 R E 0x4
  INTERP         0x000154 0x10000154 0x10000154 0x0000d 0x0000d R   0x1
      [Requesting program interpreter: /lib/ld.so.1]
  LOAD           0x000000 0x10000000 0x10000000 0x6c184 0x6c184 R E 0x10000
  LOAD           0x06c184 0x1007c184 0x1007c184 0x0045c 0x07018 RWE 0x10000
  DYNAMIC        0x06c47c 0x1007c47c 0x1007c47c 0x000d0 0x000d0 RW  0x4
  NOTE           0x000164 0x10000164 0x10000164 0x00020 0x00020 R   0x4
  GNU_EH_FRAME   0x06c160 0x1006c160 0x1006c160 0x00024 0x00024 R   0x4
  STACK          0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x4

 Section to Segment mapping:
  Segment Sections...
   00
   01     .interp
   02     .interp .note.ABI-tag .hash .dynsym .dynstr .gnu.version
.gnu.version_
r .rela.dyn .rela.plt .init .text .fini .rodata .eh_frame_hdr
   03     .data .eh_frame .got2 .dynamic .ctors .dtors .jcr .got .sdata
.sbss .p
lt .bss
   04     .dynamic
   05     .note.ABI-tag
   06     .eh_frame_hdr
   07
[chandrashekharp@linux sbin]$

Regards,
Rahaman
----- Original Message ----- 
From: "Adrian Craine" <adrian.craine@nec.com.au>
To: "Abdul Rahaman" <abdul.rahaman@semindia.in>
Cc: <linuxppc-embedded@ozlabs.org>
Sent: Tuesday, November 28, 2006 2:31 AM
Subject: Re: fialing @ executing /sbin/int in main.c


Abdul Rahaman wrote:
> Hi All,
> Iam trying to port linux on an mpc8xx processor. Iam using 2.6.10
> kernel and busybox 1.0.0.The system is booting up but its failing at
> the “init”.For some reasons it says Kernel panic - not syncing: No
> init found. Try passing init= option to kernel.
> <0>Rebooting in 180 second
> Pls check below the entire text.
> Linux version 2.6.10 (gcc version 3.4.1) #83 Wed
> Nov
> 22 16:02:46 IST 2006
> On node 0 totalpages: 8192
> DMA zone: 8192 pages, LIFO batch:2
> Normal zone: 0 pages, LIFO batch:1
> HighMem zone: 0 pages, LIFO batch:1
> Built 1 zonelists
> Kernel command line: console=ttyCPM,38400=console=ttyCPM debug
> root=/dev/ram0 rw
> PID hash table entries: 256 (order: 8, 4096 bytes)
> Decrementer Frequency = 495000000/60
> m8xx_wdt: wdt disabled (SYPCR: 0xFFFFFF88)
> Warning: real time clock seems stuck!
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 8192 (order: 3, 32768 bytes)
> Inode-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Memory: 29592k available (1572k kernel code, 360k data, 92k init, 0k
> highmem)
> Calibrating delay loop... 261.12 BogoMIPS (lpj=130560)
> before dcache_init
> after dcache_init
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Before SysFs_init
> After SysFs_init
> After init_rootfs
> after init_mount_tree
> inside proc_root_init
> after proc_misc_init
> checking if image is initramfs...it isn't (no cpio magic); looks like
> an initrd
> Freeing initrd memory: 746k freed
> after SK_Init
> before register file system in sockets
> after register file system in sockets
> after kernel mount in sockets
> NET: Registered protocol family 16
> JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> Software Watchdog Timer: 0.07 initialized. soft_noboot=0
> soft_margin=60 sec (nowayout= 0)
> Serial: CPM driver $Revision: 0.01 $
> ttyCPM0 at MMIO 0xf000a80 (irq = 20) is a CPM UART
> io scheduler noop registered
> io scheduler anticipatory registered
> io scheduler deadline registered
> io scheduler cfq registered
> RAMDISK driver initialized: 4 RAM disks of 8192K size 1024 blocksize
> loop: loaded (max 8 devices)
> elevator: using anticipatory as default io scheduler
> mice: PS/2 mouse device common for all mice
> eth0: FEC ENET Version 0.2, FEC irq 3, MII irq 4, addr 00:a0:1e:a8:7b:cb
> u32 classifier
> OLD policer on
> NET: Registered protocol family 2
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 2048 bind 4096)
> NET: Registered protocol family 17
> RAMDISK: Compressed image found at block 0
> VFS: Mounted root (ext2 filesystem).
> Freeing unused kernel memory: 92k init
> Kernel panic - not syncing: No init found. Try passing init= option to
> kernel.
> <0>Rebooting in 180 second
> I have tried googling,but haven’t got any suitable answer to my
> problem.Please help,as Iam not able to figure out why the “init” is
> failing.
> Sunil
Are all the libraries present for init?
# readelf -lh sbin/init
should contain a line similar to the following: [Requesting program
interpreter: /lib/ld.so.1]
If this is missing the kernel will fail to run init with the above behavior.

Adrian.
