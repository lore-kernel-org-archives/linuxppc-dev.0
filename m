Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37845B7D1A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Apr 2010 17:29:06 +1000 (EST)
Date: Fri, 23 Apr 2010 09:28:59 +0200 (CEST)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: sylvain.lamontagne@novariant.com
Message-ID: <2011538478.344681272007739977.JavaMail.ngmail@webmail06.arcor-online.net>
Subject: Re: Boot hang when setting console=none with MPC5200B custom board
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Sylvain:

> Humm I see, here is the node I'm creating in the initial ramdisk, so
> they are there before mdev is launched in one of my init scripts.
[snip]

I additionally have "tty0 c 4 0" which might be important here, plus a lot of other crap (should clean up there...;-).  I don't use a ramdisk, but have the /dev folder in the flash jffs2 image.  In the init script, I say

/bin/mount -t tmpfs ramfs /dev
mdev -s
mkdir /dev/pts
mkdir /dev/shm
chmod 1777 /dev/shm

and then tty0 is gone.  So to be honest I'm not absolutely sure it's necessary.

My inittab contains

::sysinit:/etc/init.d/rcS
::respawn:-/bin/sh 
::shutdown:/etc/init.d/rcS stop
::restart:/sbin/init
::respawn:/sbin/dropbear -F

With this, I can access the board through ssh (dropbear).  The dmesg output lists "console=tty0" as expected.  All PSC's are in the device tree, btw, and available as serial ports.

Hth,
Albrecht.

Traumziele - von Beschreibung bis Buchung jetzt kompakt auf den Reise-Seiten von Arcor.de! http://www.arcor.de/rd/footer.reise
