Return-Path: <dhlii@dlasys.net>
Received: from xm.dlasys.net (unknown [24.152.213.223])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A68E068775
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Nov 2005 10:19:47 +1100 (EST)
Received: from [206.223.20.141] (port=1211 helo=[206.223.20.141])
	by xm.dlasys.net with esmtp (Exim 4.54 #1 (Debian))
	id 1EdbZS-0001xP-0N
	for <linuxppc-embedded@ozlabs.org>; Sat, 19 Nov 2005 17:52:34 -0500
Message-ID: <437E606D.20601@dlasys.net>
Date: Fri, 18 Nov 2005 18:14:53 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
References: <20051118024803.E2988687A1@ozlabs.org>
In-Reply-To: <20051118024803.E2988687A1@ozlabs.org>
Content-Type: text/plain; charset=GB2312
Subject: Re: Help ! 2.6.14 kernel can't bring up
Reply-To: dhlii@comcast.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

zjznliang wrote:
> Hi linuxppc-embedded£¡
>
> 	Hi , How to config the "early printk" in 2.6.14 linux configration???
>
>
>  	
Console and debugging I/O is available at all stages of The Linux
loading process - If the drivers for your board support it.
There is nearly free support for 8250 like serial ports, in virtually
all boards. Support for other debugging IO devices is fairly simple to
setup.

I used the arch/ppc/syslib/mv64x60_dbg.c and
arch/ppc/boot/simple/mv64x60_tty.c as templates to create trivial
drivers for debugging IO
on hardware that had no relation to a UART.

I think "early printk" refers to the early serial driver that can be
used after the kernel has uncompressed itself and relocated itself and
switched to
a virtual environment. For 8250 like serial ports that can enabled in
the linux .config file setup by make menuconfig or whatever variant of
make xxconfig
you prefer. For non-8250 like uarts you will again have to write an
early serial driver. All the early debug IO drivers are trivial - little
more is needed than
an implementation of putc, as opposed to the full conolse support
required for a tty on a booted system.
