Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from mfep4.connect.com.au (fep4.mfe.bur.connect.com.au [203.63.86.4])
	by ozlabs.org (Postfix) with ESMTP id 6EC99684D1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 10:04:07 +1000 (EST)
Message-ID: <434B017D.5080201@rftechnology.com.au>
Date: Tue, 11 Oct 2005 10:04:13 +1000
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20051010234614.1FE2A353D84@atlas.denx.de>
In-Reply-To: <20051010234614.1FE2A353D84@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: boot-time partitions and bootargs for 2.6.14
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> ===>	Creating 3 MTD partitions on "PPChameleon":
> ===>	0x00000000-0x00180000 : "linux"
> ===>	0x00180000-0x003c0000 : "user"
> ===>	0x003c0000-0x00400000 : "u-boot"
> 	...
> 
> Can you see these messages on your system? Is the flash  name  really
> "0"? Are the partitions correct?

Yes, these partitions are correct (well, I think)
  Bank # 1: Sharp 28F016SC (16 Mbit, 32 x 64K)
   Size: 8 MB in 32 Sectors
   Sector Start Addresses:
     FF800000      FF840000      FF880000      FF8C0000      FF900000
     FF940000      FF980000      FF9C0000      FFA00000      FFA40000
     FFA80000      FFAC0000      FFB00000      FFB40000      FFB80000
     FFBC0000      FFC00000      FFC40000      FFC80000      FFCC0000
     FFD00000      FFD40000      FFD80000      FFDC0000      FFE00000
     FFE40000      FFE80000      FFEC0000      FFF00000 (RO) FFF40000 (RO)
     FFF80000      FFFC0000

  FF800000 - FF8C0000 - Linux (4 sect, 1024k)
  FF900000 - FFCC0000 - Root (16 sect, 4096k)
  FFD00000 - FFEC0000 - Unused (8 sect, 2048k)
  FFF00000 - FFF40000 - U-boot (2 sect, 512k)
  FFF80000 - FFFC0000 - Rest (2 sect, 512k)

No, I cannot see these messages. Here what I see
...
Kernel command line: console=ttyCPM0,115200 root=31:01 rw rootfstype=jffs2
PID hash table entries: 512 (order: 9, 8192 bytes)
Warning: real time clock seems stuck!
Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
Memory: 62848k available (1568k kernel code, 396k data, 88k init, 0k
highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16
JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
JFFS2: default compression mode: priority
fuse init (API version 7.2)
Initializing Cryptographic API
Generic RTC Driver v1.07
Serial: CPM driver $Revision: 0.01 $
ttyCPM0 at MMIO 0xf0011a00 (irq = 40) is a CPM UART
ttyCPM1 at MMIO 0xf0011a20 (irq = 41) is a CPM UART
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 32768K size 1024 blocksize
loop: loaded (max 8 devices)
...
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(31,1)
  <0>Rebooting in 180 seconds..

I am trying to debug right now using gdb and BDI and I found out that
error occurs when I try to

(gdb) c
Continuing.

Breakpoint 1, do_mount (dev_name=0xc03c1000 "/dev/root",
dir_name=0xc03c0000 "/root", type_page=0xc03bf000 "jffs2", flags=0x8000,
data_page=0x0) at fs/namespace.c:1022

long do_mount(char * dev_name, char * dir_name, char *type_page,
		  unsigned long flags, void *data_page)
{
	struct nameidata nd;
	int retval = 0;
	int mnt_flags = 0;

	/* Discard magic */
	if ((flags & MS_MGC_MSK) == MS_MGC_VAL)
		flags &= ~MS_MGC_MSK;

	/* Basic sanity checks */

	if (!dir_name || !*dir_name || !memchr(dir_name, 0, PAGE_SIZE))
		return -EINVAL;
	if (dev_name && !memchr(dev_name, 0, PAGE_SIZE))
            return -EINVAL; <---- ERROR
            ^^^^^^^^^^^^^^^^

Do you know what this might be?
