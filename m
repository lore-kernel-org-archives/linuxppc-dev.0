Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 3243CDDED7
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 05:50:47 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: ioctl32: Unknown cmd
Date: Tue, 16 Oct 2007 21:50:35 +0200
References: <Pine.LNX.4.62.0710161642200.20196@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0710161642200.20196@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200710162150.37636.arnd@arndb.de>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	Jens Axboe <jens.axboe@oracle.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 16 October 2007, Geert Uytterhoeven wrote:
> The recent (post 2.6.23) changes to compat_ioctl made the reporting of
> unsupported ioctls more verbose. E.g. on the PS3 I get:
> 
> | ioctl32(cdrom_id:608): Unknown cmd fd(3) cmd(00005331){t:'S';sz:0} arg(00000000) on /dev/.tmp-11-0
> | ioctl32(hdparm:1427): Unknown cmd fd(3) cmd(0000031f){t:03;sz:0} arg(00000000) on /dev/ps3da
> | ioctl32(hdparm:1427): Unknown cmd fd(3) cmd(0000031f){t:03;sz:0} arg(00000000) on /dev/ps3da
> 
> The first one is triggered by the detection of the CD/DVD/BD-ROM driver,
> The others are triggered by me running hdparm.
> 
> Was this intentional?
> 

No, it was certainly not intentional, and I can't figure out why it happens.
The ioctl numbers from your example are HDIO_DRIVE_CMD and CDROM_GET_CAPABILITY,
both of which should be handled through compat_blkdev_driver_ioctl by calling
the native ioctl method of the driver, and return -ENOTTY otherwise.

The one point where it is expected to have changed now is when you try
to do these ioctls on something that is not a block device. Are you sure that
the files you tried them on were created correctly?

	Arnd <><
