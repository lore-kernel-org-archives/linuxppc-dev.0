Return-Path: <matthias@kaehlcke.net>
Received: from slow3-v.mail.gandi.net (slow3-v.mail.gandi.net [217.70.178.89])
	by ozlabs.org (Postfix) with ESMTP id AC9AFB6EF4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jan 2010 02:04:34 +1100 (EST)
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
	[217.70.183.193])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 061FD39FB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jan 2010 10:55:05 +0100 (CET)
Date: Tue, 19 Jan 2010 10:50:24 +0100
From: Matthias Kaehlcke <matthias@kaehlcke.net>
To: Johnny Hung <johnny.hacking@gmail.com>
Subject: Re: mount ramdisk rootfs /etc directory to jffs2 filesystem.
Message-ID: <20100119095024.GD16182@darwin>
References: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cb9ecdfa1001190120r593f7799sf566df5a855b8a54@mail.gmail.com>
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

El Tue, Jan 19, 2010 at 05:20:53PM +0800 Johnny Hung ha dit:

> I have build an embedded Linux system and rootfs is a ramdisk. Ramdisk
> rootfs resides in memory so modify files is non-effective after a
> reboot. Some directories in rootfs, like /etc, /usr, ... are contain
> many application configuration files and I want to mount it to jffs2
> flash filesysyem so it will take effect after a reboot. Is it
> possible?

yes, this is possible

> I know the flash has write times limited so the log files
> (syslogd/klogd) should not store in flash. In general, how to deploy
> root file system for embedded linux with flash storage?

- add jffs2 support to your kernel
- create your image using mkfs.jffs2 from mtd-utils
- flash the image
- specify the rootfs partition and type in the bootargs of the kernel

for further information i recommend the lecture of
http://free-electrons.com/doc/flash-filesystems.pdf

depending on your requirements/size of the rootfs partitions UBIFS
might be an option to consider

-- 
Matthias Kaehlcke
Embedded Linux Developer
Barcelona

      El trabajo es el refugio de los que no tienen nada que hacer
                            (Oscar Wilde)
                                                                 .''`.
    using free software / Debian GNU/Linux | http://debian.org  : :'  :
                                                                `. `'`
gpg --keyserver pgp.mit.edu --recv-keys 47D8E5D4                  `-
