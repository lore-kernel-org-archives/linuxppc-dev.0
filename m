Return-Path: <johnny.hacking@gmail.com>
Received: from mail-pz0-f191.google.com (mail-pz0-f191.google.com
	[209.85.222.191]) by ozlabs.org (Postfix) with ESMTP id 9D40BB7CC1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 23:03:21 +1100 (EST)
Received: by pzk29 with SMTP id 29so3830478pzk.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 04:03:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100119102026.GF16182@darwin>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
	<20100119095024.GD16182@darwin>
	<cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
	<20100119102026.GF16182@darwin>
Date: Tue, 19 Jan 2010 20:03:19 +0800
Message-ID: <cb9ecdfa1001190403v433d839dy6ba2bc018024ce15@mail.gmail.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
From: Johnny Hung <johnny.hacking@gmail.com>
To: Matthias Kaehlcke <matthias@kaehlcke.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kernelnewbies <kernelnewbies@nl.linux.org>, linux-mtd@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2010/1/19 Matthias Kaehlcke <matthias@kaehlcke.net>:
> El Tue, Jan 19, 2010 at 06:13:07PM +0800 Johnny Hung ha dit:
>
>> 2010/1/19 Matthias Kaehlcke <matthias@kaehlcke.net>:
>> > El Tue, Jan 19, 2010 at 05:20:53PM +0800 Johnny Hung ha dit:
>> >
>> >> I have build an embedded Linux system and rootfs is a ramdisk. Ramdis=
k
>> >> rootfs resides in memory so modify files is non-effective after a
>> >> reboot. Some directories in rootfs, like /etc, /usr, ... are contain
>> >> many application configuration files and I want to mount it to jffs2
>> >> flash filesysyem so it will take effect after a reboot. Is it
>> >> possible?
>> >
>> How to do it? The ramdisk rootfs is ext2 filesystem and I try,
>> mount /mnt/mtd/etc /etc
>>
>> Try to modify /etc/ files is not works.
>
> ok, i understood you want to substitute the ramdisk rootfs by jffs2
> based one
>
> mounting the ramdisk as writable with the flash as backing storage
> isn't possible AFAIK. and even if it was possible it wouldn't be
> recommended as ext2 doesn't care about flash wear out, in consequence
> you would write the same blocks over and over again.
>
>> > yes, this is possible
>> >
>> >> I know the flash has write times limited so the log files
>> >> (syslogd/klogd) should not store in flash. In general, how to deploy
>> >> root file system for embedded linux with flash storage?
>> >
>> > - add jffs2 support to your kernel
>> > - create your image using mkfs.jffs2 from mtd-utils
>> > - flash the image
>> > - specify the rootfs partition and type in the bootargs of the kernel
>> The above procedure is to create a jffs2 rootfs image but I =A0prefer to
>> use ramdisk rootfs.
>> I think the rootfs is build as ramdisk and some configurable file is
>> store in jffs2 flash.
>

Okay, I think the steps is below if my rootfs is ramdisk and configure
files in jffs2,

1. cp /etc/* /mnt/mtd/etc/    (/mnt/mtd is my jffs2 fs)
2. rm -rf /etc/*
3. make symbolic links from all /etc/xx to /mnt/mtd/etc/xxx
4. remake ramdisk rootfs

It seems all files in ramdisk rootfs /etc all links to /mnt/mtd/etc/
and try to modify these files is effective after reboot.
But is this a common way in embedded linux ?

I also have another idea, keep ramdisk rootfs /etc files and add a shell sc=
ript.

1. The shell script execute when system boot up.
2. Check /mnt/mtd/etc/xxx if is exist. If yes, remove /etc/xxx file
and make a symbolic link to /mnt/mtd/etc/xxx. If no, keep /etc/xxx
file.
3. repeat 2 for all /etc files

Any suggestion?

Thank your help.
BRs, H. Johnny

> in this case follow the above steps, except the last one about the
> bootargs and mount the jffs2 partition from your init script. you
> could use symlinks from your ramdisk to the files on jffs2 to
> integrate them in your rootfs
>
> --
> Matthias Kaehlcke
> Embedded Linux Developer
> Barcelona
>
> =A0 =A0 =A0Anyone who has never made a mistake has never tried anything n=
ew
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(Albert Einstein)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .''`.
> =A0 =A0using free software / Debian GNU/Linux | http://debian.org =A0: :'=
 =A0:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0`. `'`
> gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0`-
>
