Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s38.bay0.hotmail.com (bay0-omc3-s38.bay0.hotmail.com
	[65.54.246.238]) by ozlabs.org (Postfix) with ESMTP id 3601A67B54
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jul 2006 23:56:59 +1000 (EST)
Message-ID: <BAY110-F18E554AE914CDFB0EBDF6CB2740@phx.gbl>
In-Reply-To: <44AE56C2.9040601@gmail.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: ammubhai@gmail.com
Subject: Re: Xilinx BSP for linux 2.6
Date: Fri, 07 Jul 2006 13:56:52 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Ameet,
It Works now! By creating these character and block devices in /dev, the 
system go further now. But another problem appears. That is, there is no 
login prompt shown in hyper terminal. The information is listed as:

[    1.745076] loop: loaded (max 8 devices)
[    1.793385]  xsa: xsa1 xsa2 xsa3
[    1.839258] mice: PS/2 mouse device common for all mice
[    1.925011] VFS: Mounted root (ext2 filesystem) readonly.
[    1.990035] Freeing unused kernel memory: 76k init

Welcome to ML403 powerpc linux 2.6.16-rc5, E.I.S. edition

Starting system...
mounting /proc: done.
Mounting '/' read-write: mount: Cannot read /etc/mtab: No such file or 
directory

done.
brining up loopback interface: ifconfig: socket: Function not implemented
done.
Mounting /tmp: done.
Starting syslogd: done.
Starting klogd: syslogd: Couldn't get file descriptor for socket /dev/log: 
Funct
ion not implemented
done.
Starting inetd: done.
System started.

My inittab files looks like:
::sysinit:/etc/init.d/rcS
#::askfirst:-/bin/sh
::ctrlaltdel:/sbin/reboot
::shutdown:/sbin/swapoff -a
::shutdown:/bin/umount -a -r
::restart:/sbin/init
::respawn:/sbin/getty 9600 tts/0

Any suggestion about this problem? Thanks in advance.

Regards
Ming



>From: Ameet Patil <ammubhai@gmail.com>
>To: Ming Liu <eemingliu@hotmail.com>
>CC: linuxppc-embedded@ozlabs.org
>Subject: Re: Xilinx BSP for linux 2.6
>Date: Fri, 07 Jul 2006 13:42:42 +0100
>
>Hi Ming,
>
>Excellent News!
>
>Don't worry... the problem you are facing could be because of missing
>device files in your /dev folder.
>
>Do as follows:
>mount the CF card onto your PC and then goto the /dev folder on your
>root filesystem in the card. Here run the following commands as root:
># mknod -m 660 console c 5 1
># mknod -m 660 xsa b 254 0
># mknod -m 660 xsa1 b 254 1
># mknod -m 660 xsa2 b 254 2
># mknod -m 660 xsa3 b 254 3
>Now there should be a directory tts in your dev. If not create one
>"mkdir tts". Then do this in the dev/tts folder,
># mknod -m 660 0 b 4 64
>
> > Also, when I compile the kernel, there is a error. That's in adapter.c
> > file, undefined reference to "XAssert". I checked the source code and
>I think you have the old patch. If you download the new one, the
>compilation problem should not occur. But you resolved it yourself,...
>which is good.
>
>Let me know if this works. I shall add this stuff in PART II of the 
article.
>
>-Ameet
>
>Ming Liu wrote:
> > Dear Ameet,
> > A good news is that now my 2.6 kernel is running in my ML403 board!
> > According your guidance, first I made the kernel as simple as possible
> > and it works well. Then I included the patch for SystemACE and here is
> > the information shown on the hyper teminal:
> >
> >
> > Linux/PPC load: console=ttyS0,9600 root=/dev/xsa3 [    0.000148]
> > Console: colour dummy device 80x25
> > [    0.000919] Dentry cache hash table entries: 16384 (order: 4, 65536
> > bytes)
> > [    0.002277] Inode-cache hash table entries: 8192 (order: 3, 32768 
bytes)
> > [    0.012802] Memory: 63104k available (1340k kernel code, 384k data,
> > 76k init,
> > 0k highmem)
> > [    0.230310] Mount-cache hash table entries: 512
> > [    0.238305] VFS: Disk quotas dquot_6.5.1
> > [    0.238516] Dquot-cache hash table entries: 1024 (order 0, 4096 
bytes)
> > [    0.238817] JFFS2 version 2.2. (NAND) (C) 2001-2003 Red Hat, Inc.
> > [    0.239435] JFS: nTxBlock = 493, nTxLock = 3944
> > [    0.241883] Initializing Cryptographic API
> > [    0.241940] io scheduler noop registered (default)
> > [    0.322864] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ
> > sharing
> > disabled
> > [    0.324759] serial8250.0: ttyS0 at MMIO 0x40401003 (irq = 1) is a 
16550A
> > [    1.653644] RAMDISK driver initialized: 16 RAM disks of 65536K size
> > 1024 bloc
> > ksize
> > [    1.745079] loop: loaded (max 8 devices)
> > [    1.793392]  xsa: xsa1 xsa2 xsa3
> > [    1.839262] mice: PS/2 mouse device common for all mice
> > [    1.935059] VFS: Mounted root (ext2 filesystem) readonly.
> > [    2.000037] Freeing unused kernel memory: 76k init
> > [    2.075656] Warning: unable to open an initial console.
> >
> > I use xsa3 as the partition to store the file system. Now the file
> > system is the old one for my 2.4 kernel generated by busybox. Then I
> > think that's why the problem "unable to open an initial console" is
> > generated. Do you have some suggestion on how to solve it? Thanks for
> > your opinion.
> > Also, when I compile the kernel, there is a error. That's in adapter.c
> > file, undefined reference to "XAssert". I checked the source code and
> > found that the function of XAssert is defined in the file
> > xbasic_types.c, not the xbasic_types.h. So it cannot be included into
> > adapter.c. And also in the makefile there is no dependency on
> > xbasic_types.c. So I added the defination for this function in
> > adapter.c, copying it from xbasic_types.c. It then worked well.
> > Waiting for your guidance. You know, an expert's opinion is always
> > useful for a novice, like me. :)
> >
> > Regards
> > Ming
> >
> > _________________________________________________________________
> > 免费下载 MSN Explorer:   http://explorer.msn.com/lccn/
> >

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
