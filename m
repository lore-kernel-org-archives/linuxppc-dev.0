Message-ID: <20020502115709.13873.qmail@web15005.mail.bjs.yahoo.com>
Date: Thu, 2 May 2002 19:57:09 +0800 (CST)
From: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Subject: RE: How to mount romfs in flash as root filesystem?
To: "K??ri" "Dav??esson" <kd@flaga.is>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <EADB10BAC266A14A85ECBF8686A73E31937F12@kolkrabbi.flaga.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have compiled it into kernel,not module,it is romfs.

> What file system do you have on your flash?
> Is it compiled into the kernel?
> It does not work to have the fs used on for the root
> fs compiled as a
> module.
>
> K.D.
>
> > -----Original Message-----
> > From: Dross Zhou [mailto:zjuzhou@yahoo.com.cn]
> > Sent: 1. ma¨ª 2002 04:35
> > To: Kári Davíðsson
> > Subject: RE: How to mount romfs in flash as root
> filesystem?
> >
> >
> >  --- Kári Davíðsson <kd@flaga.is> µÄÕýÎÄ£º> >
> > -----Original Message-----
> > > > From: Gunnar Larisch [mailto:la@softing.com]
> > > > Sent: 30. apríl 2002 08:41
> > > > To: Wolfgang Denk
> > > > Cc: Dross Zhou;
> > > linuxppc-embedded@lists.linuxppc.org
> > > > Subject: Re: How to mount romfs in flash as
> root
> > > filesystem?
> > > >
> > > >
> > > >
> > > > On Mon, Apr 29, 2002 at 04:35:24PM +0200,
> Wolfgang
> > > Denk wrote:
> > > > >
> > > > > In message
> > > >
> > >
> >
>
<20020429141408.33240.qmail@web15001.mail.bjs.yahoo.com>
> > > you wrote:
> > > > > >
> > > > > > 	Now my kernel has support ROMFS ,i can
> mount
> > > > > > /dev/mtdblock0 /mnt -t romfs and use
> chroot
> > > /mnt as
> > > > > > root filesystem.But i want to mount
> > > /dev/mtdblock0 as
> > > > > > root filesystem when system reboot,how
> to?I
> > > have try
> > > > > > many parameters into kernel such as
> > > "root=/dev/mtdblk0
> > > > > > romfs ro", but it is no use, it also mount
> NFS
> > > > >
> > > > > Probably because you mistyoed  the  device
> > > name?  There
> > > > is  an  'o'
> > > > > missing, it seems.
> > > > >
> > > > > > root,how can i mount /dev/mtdblock0
> (ROMFS) as
> > > root
> > > > > > filesystem?I used linux2.4.4 from denx .
> > > > >
> > > > > Just pass "root=/dev/mtdblock0", that's all.
> > > >
> > > > This will not work. You must use
> > > "root=/dev/mtdblock/0" and
> > >
> > > wrong! Wolfgang is correct just check how the
> root
> > > parameter is parsed
> > > in
> > > init/do_mounts.c function name_to_kdev_t().
> > >
> > > If you pass root=/dev/mtdblock/0 it will try to
> > > convert the third "/" to
> > > a number which it can not and the minor number
> > > becomes 0 which is
> > > accedentally correct but is very wrong if you
> plan
> > > to mount
> > > /dev/mtdblock/1
> > > as you root.
> > >
> > > > Linux must be
> > > > configured with devfs, devfs must be mounted
> > > before and boot support
> > >
> > > It can be either way. You can use devfs in which
> > > case you must make it
> > > mountable at boot. You can also get away without
> > > devfs but then you must
> > >
> > > suppply all the necessary device nodes in your
> > > filesystem.
> > >
> > > > from ramdisk must be disabled.
> > >
> > > Don't spread wrong information!
> > >
> > > Regards,
> > >
> > > K.D.
> > >
> > > >
> > > > Gunnar Larisch
> > > > --
> > > > Gunnar Larisch
> > > > Dipl.-Ing.
> > > > Entwicklung
> > > > Softing AG - Dep. Industrial Communication
> > > > Richard-Reitzner-Allee 6
> > > > 85540 Haar (near Munich)
> > > > Germany
> > > > Tel.: ++49 / (0) 89 / 4 56 56 - 183
> > > > Fax.: ++49 / (0) 89 / 4 56 56 - 399
> > > >
> > >
> >
> > 	I have try pass root=/dev/mtdblock0 to kernel,
> > but it always mount NFS as root filesystem.Here is
> my
> > output message:
> >
> > Video Network Server v1.1
>
> >
> > MPC850,32M RAM,4M FLASH,USB
>
> >
>
> >
> >
>
> >
> >
>
> >
> > loaded at:     00200000 0020B1F8
>
> >
> > relocated to:  00180000 0018B1F8
>
> >
> > board data at: 001801B8 001801D4
>
> >
> > relocated to:  00200100 0020011C
>
> >
> > zimage at:     00206000 00286ADE
>
> >
> > avail ram:     00287000 02000000
>
> >
> >
>
> >
> > Linux/PPC load: root=/dev/mtdblock0
>
> >
> > Uncompressing Linux...done.
>
> >
> > Now booting the kernel
> > Linux version 2.4.4 (root@localhost.localdomain)
> (gcc
> > version 2.95.2 19991030 (
> > On node 0 totalpages: 8192
>
> >
> > zone(0): 8192 pages.
>
> >
> > zone(1): 0 pages.
>
> >
> > zone(2): 0 pages.
>
> >
> > Kernel command line: root=/dev/mtdblock0
>
> >
> > Decrementer Frequency: 3000000
>
> >
> > Calibrating delay loop... 47.61 BogoMIPS
>
> >
> > Memory: 30732k available (988k kernel code, 380k
> data,
> > 52k init, 0k highmem)
> > Dentry-cache hash table entries: 4096 (order: 3,
> 32768
> > bytes)
>
=== message truncated ===


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
