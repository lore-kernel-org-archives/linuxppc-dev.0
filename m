Return-Path: <johnny.hacking@gmail.com>
Received: from mail-px0-f198.google.com (mail-px0-f198.google.com
	[209.85.216.198]) by ozlabs.org (Postfix) with ESMTP id ABC4AB7CE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 21:13:09 +1100 (EST)
Received: by pxi36 with SMTP id 36so2703919pxi.26
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 02:13:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100119095024.GD16182@darwin>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
	<20100119095024.GD16182@darwin>
Date: Tue, 19 Jan 2010 18:13:07 +0800
Message-ID: <cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
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
> El Tue, Jan 19, 2010 at 05:20:53PM +0800 Johnny Hung ha dit:
>
>> I have build an embedded Linux system and rootfs is a ramdisk. Ramdisk
>> rootfs resides in memory so modify files is non-effective after a
>> reboot. Some directories in rootfs, like /etc, /usr, ... are contain
>> many application configuration files and I want to mount it to jffs2
>> flash filesysyem so it will take effect after a reboot. Is it
>> possible?
>
How to do it? The ramdisk rootfs is ext2 filesystem and I try,
mount /mnt/mtd/etc /etc

Try to modify /etc/ files is not works.

> yes, this is possible
>
>> I know the flash has write times limited so the log files
>> (syslogd/klogd) should not store in flash. In general, how to deploy
>> root file system for embedded linux with flash storage?
>
> - add jffs2 support to your kernel
> - create your image using mkfs.jffs2 from mtd-utils
> - flash the image
> - specify the rootfs partition and type in the bootargs of the kernel
The above procedure is to create a jffs2 rootfs image but I  prefer to
use ramdisk rootfs.
I think the rootfs is build as ramdisk and some configurable file is
store in jffs2 flash.

Thank your reply.
BRs, H. Johnny

>
> for further information i recommend the lecture of
> http://free-electrons.com/doc/flash-filesystems.pdf
>
> depending on your requirements/size of the rootfs partitions UBIFS
> might be an option to consider
>
> --
> Matthias Kaehlcke
> Embedded Linux Developer
> Barcelona
>
> =A0 =A0 =A0El trabajo es el refugio de los que no tienen nada que hacer
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(Oscar Wilde)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .''`.
> =A0 =A0using free software / Debian GNU/Linux | http://debian.org =A0: :'=
 =A0:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0`. `'`
> gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0`-
>
