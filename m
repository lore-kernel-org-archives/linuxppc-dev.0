Message-ID: <008b01c13c12$0d452e00$0200a8c0@aiwa>
From: "qiuqingjun" <qiuqingjun@263.net>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <002a01c13b93$72b3c5a0$0200a8c0@aiwa> <200109121441.f8CEf1016518@hyper.wm.sps.mot.com>
Subject: Re: In initrd, init program is needed or not?
Date: Thu, 13 Sep 2001 13:07:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Peter Barada,
Thank your explaination of init program in detail, however , I have another question:
Where can I find the source code of the init program?
Thank you again!

Qiu Qingjun

>
> >BTW, if I want to access /proc/... , what files should I add in
> >ramdisk. Should I add a program called MOUNT in /bin? who exec rc and
> >fstab script , shell(bash , ash) or kernel? Thank you in advance.
>
> After the kernel mounts the root filesystem(via initrd, etc)
> it attempts to start the init process be createing a thread
> and trying to exec init from the following places(in this order):
>
> /sbin/init
> /etc/init
> /bin/init
>
> And if none of them can be found, then it tries to fire up a shell
> from:
>
> /bin/shell
>
> See init/main.c, init()
>
> Depending on the init executable you place in your root filesystem, it
> runs the /etc/rc script, and in there is where you'd a snippet the
> looks something like:
>
> /sbin/expand /etc/ramfs.img /dev/ram1
> /sbin/mount -n -t proc proc /proc
> /sbin/mount -n -t ext2 /dev/ram1 /var
>
> Where the first line decompresses a ramdisk ext filesystem image into
> /dev/ram1, the second line mounts the /proc filesystem, and the third
> line mounts the ramdisk(/dev/ram1) as a filesystem on /var
>
> Note that /sbin/expand and /sbin/mount can not be in the ramdisk.
> Neithere can /sbin/init or /etc/rc.
> They have to be in the root filesystem which is mounted before init
> starts up.
>
> YMMV,
>
> --
> Peter Barada                                   Peter.Barada@motorola.com
> Wizard                                         781-852-2768 (direct)
> WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
