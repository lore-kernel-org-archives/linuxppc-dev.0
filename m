Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 9938BDDE41
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 00:22:12 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: ioctl32 unknown cmds with 2.6.24-rc1
Date: Thu, 25 Oct 2007 16:20:49 +0200
References: <1193229045.4510.35.camel@johannes.berg>
	<1193319517.14136.2.camel@johannes.berg>
	<Pine.LNX.4.62.0710251542500.3812@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0710251542500.3812@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200710251620.50218.arnd@arndb.de>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 25 October 2007, Geert Uytterhoeven wrote:
> If you want to look into this, the question is just why these messages are
> printed now, while they weren't printed before. I don't think any other
> behavior got changed.

I'm not so sure about that. The reason that the messages are printed now
is that there is no fallback handler for these ioctl numbers any more,
but they are instead expected to be handled by the compat_blkdev_ioctl()
function, which is only called for block devices.

My first idea was that the ioctl numbers are used on files that are
not block devices, in this case the warning message would be (somewhat)
appropriate.

Whenever we get one of these messages on a real block device, that is
supposed to mean that an ioctl that was actually valid could not be
executed, and compat_blkdev_ioctl() returned -ENOIOCTLCMD.

	Arnd <><
