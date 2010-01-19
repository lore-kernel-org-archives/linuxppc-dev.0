Return-Path: <matthias@kaehlcke.net>
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
	[217.70.183.193]) by ozlabs.org (Postfix) with ESMTP id 68A9EB7CF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 21:25:05 +1100 (EST)
Date: Tue, 19 Jan 2010 11:20:26 +0100
From: Matthias Kaehlcke <matthias@kaehlcke.net>
To: Johnny Hung <johnny.hacking@gmail.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
Message-ID: <20100119102026.GF16182@darwin>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
	<20100119095024.GD16182@darwin>
	<cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cb9ecdfa1001190213u69469505k9c42142bdc17f750@mail.gmail.com>
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

El Tue, Jan 19, 2010 at 06:13:07PM +0800 Johnny Hung ha dit:

> 2010/1/19 Matthias Kaehlcke <matthias@kaehlcke.net>:
> > El Tue, Jan 19, 2010 at 05:20:53PM +0800 Johnny Hung ha dit:
> >
> >> I have build an embedded Linux system and rootfs is a ramdisk. Ramdisk
> >> rootfs resides in memory so modify files is non-effective after a
> >> reboot. Some directories in rootfs, like /etc, /usr, ... are contain
> >> many application configuration files and I want to mount it to jffs2
> >> flash filesysyem so it will take effect after a reboot. Is it
> >> possible?
> >
> How to do it? The ramdisk rootfs is ext2 filesystem and I try,
> mount /mnt/mtd/etc /etc
> 
> Try to modify /etc/ files is not works.

ok, i understood you want to substitute the ramdisk rootfs by jffs2
based one

mounting the ramdisk as writable with the flash as backing storage
isn't possible AFAIK. and even if it was possible it wouldn't be
recommended as ext2 doesn't care about flash wear out, in consequence
you would write the same blocks over and over again.

> > yes, this is possible
> >
> >> I know the flash has write times limited so the log files
> >> (syslogd/klogd) should not store in flash. In general, how to deploy
> >> root file system for embedded linux with flash storage?
> >
> > - add jffs2 support to your kernel
> > - create your image using mkfs.jffs2 from mtd-utils
> > - flash the image
> > - specify the rootfs partition and type in the bootargs of the kernel
> The above procedure is to create a jffs2 rootfs image but I  prefer to
> use ramdisk rootfs.
> I think the rootfs is build as ramdisk and some configurable file is
> store in jffs2 flash.

in this case follow the above steps, except the last one about the
bootargs and mount the jffs2 partition from your init script. you
could use symlinks from your ramdisk to the files on jffs2 to
integrate them in your rootfs

-- 
Matthias Kaehlcke
Embedded Linux Developer
Barcelona

      Anyone who has never made a mistake has never tried anything new
                            (Albert Einstein)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
