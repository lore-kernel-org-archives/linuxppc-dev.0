Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id AFFE267B77
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Sep 2006 06:17:12 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: asm/*.h files missing for ppc arch.
Date: Sat, 9 Sep 2006 22:17:04 +0200
References: <BAY110-F38603E88776B0F5A2D966FB2340@phx.gbl>
In-Reply-To: <BAY110-F38603E88776B0F5A2D966FB2340@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200609092217.04623.arnd@arndb.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Am Saturday 09 September 2006 21:28 schrieb Ming Liu:
> Dear Arnd,
>
> >It's usually easier if you add your module to your copy of the kernel
> >sources and build it along with all the other modules.
>
> How can I do that? I don't know how can I configure my driver and compile
> it as a module. Which option shall I choose to configure my driver as a
> module in menuconfig? Sorry that I am new to linux and I am anxious for
> your helpful telling...

You need to at least the following steps:

1. Add your module to an appropriate location in the source tree, e.g.
drivers/net/ or drivers/char/, or whereever it fits best depending on
what it does.

2. Edit the Makefile in that directory so your driver gets built, e.g.
by adding a line 'obj-m += your-driver.o'.

The optional but recommended steps are:

3. Add the driver to an appropriate Kconfig file, typically in the same
directory as your driver, and change your Makefile to 
use 'obj-$(CONFIG_YOUR_DRIVER) += your-driver.o'.

4. Learn to use 'quilt', or a similar tool, to manage your patch against
the kernel.

5. If you ask questions on the mailing list, make sure everyone has access
to your patch, e.g. by uploading it to a web site.

	Arnd <><
