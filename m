Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 01C8DDE202
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Jul 2008 18:51:04 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: how to allocate 9MB of memory in kernel ?
Date: Fri, 25 Jul 2008 10:50:51 +0200
References: <18503022.post@talk.nabble.com> <200807241131.12669.arnd@arndb.de>
	<18647614.post@talk.nabble.com>
In-Reply-To: <18647614.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200807251050.52034.arnd@arndb.de>
Cc: Misbah khan <misbah_khan@engineer.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 25 July 2008, Misbah khan wrote:
> 
> I am really unaware of how can we get this physical address from the device
> tree which you have mentioned can you please explain this to me ???

With current Linux versions, all powerpc machines come with an open-firmware
like device tree, which describes all devices that are part of the
system. If your machine doesn't run an actual open firmware implementation,
you most likely have the device tree source in arch/powerpc/boot/dts/,
and that needs to describe your device.

Your init function should then not assume that the device is there, but
register an of_platform_driver for that device.
When the driver is loaded, it is then bound to your hardware, and a
struct of_device gets passed to a probe() function that does the
actual initialization.
That is the device you pass to of_iomap in order to mmap the I/O range.

	Arnd <><
