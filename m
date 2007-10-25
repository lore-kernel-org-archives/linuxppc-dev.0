Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 86C5FDDEC5
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 01:20:15 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: ioctl32 unknown cmds with 2.6.24-rc1
Date: Thu, 25 Oct 2007 17:19:52 +0200
References: <1193229045.4510.35.camel@johannes.berg>
	<200710251620.50218.arnd@arndb.de>
	<Pine.LNX.4.62.0710251649520.3812@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0710251649520.3812@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200710251719.53285.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 October 2007, Geert Uytterhoeven wrote:
> In many cases these ioctls can indeed not be handled.
> E.g. when using `hdparm -tT /dev/ps3da', hdparm issues an ioctl to flush the
> cache. But this ioctl is not supported, not before and not after 2.6.23.
> Before 2.6.23, it didn't print the message, in 2.6.23, it does.

What I would expect to happen here is:

compat_blkdev_ioctl gets into the BLKFLSBUF case and calls blkdev_ioctl,
which calls blkdev_driver_ioctl, which returns -ENOTTY because
ps3disk_fops does not contain an unlocked_ioctl() or ioctl() method.

compat_sys_ioctl then detects that BLKFLSBUF was already handled by
compat_blkdev_ioctl (it did not return -ENOIOCTLCMD) and propagates
the error code to user space, without printing the message.

Whatever is different from that description must be what goes wrong.

	Arnd <><
