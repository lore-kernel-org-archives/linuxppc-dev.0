Date: Thu, 15 May 2003 08:13:42 -0400
From: Callebaut Benoit <callebaut@mailandnews.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re : Can't find ext2 filesystem on dev mtdblock
Message-ID: <3EC6FB62@mailandnews.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

>   I am getting following error while mounting the filesystem.
>I am using ppcboot and linux-2.4.18 . The same filesystem was earlier
>working for linux-2.2.14.
>
>=========================================================
>   VFS: Can't find ext2 filesystem on dev mtdblock(31,0)
>=========================================================
>
>What has gone wrong??

I don't know precisely what changed between the two kernels but I use ppcboot
and a 2.4.17 based kernel. So I will try to help you.
First it is strange that you use a ext2 filesystem on a flash. A better choice
would be CRAMFS (READ ONLY) or JFFS. And pay attention that the write support
to the flash is not full proof (experrimental status). So first check that
your filesystem valid is.
Second remarks : Do you try to mount this as root filesystem or not (I don't
think so). But such a line doesn't say a lot of the possible problem.

So first check the filesystem integrity (with fschk or a probe)
Two check that you can access your flash with a character driver(/dev/mtd0) in
case of a bad setting in the kernel (FLASH base address change)
Third give more informations like a full syslog or even better look directly
in the log_bu buffer in RAM (buffer where all the printk text is placed before
writing it to syslog).
Fourth : use a probe, GDB and debug your kernel.

Good luck,
Benoit Callebaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
