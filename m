Return-Path: <lorenz@missinglinkelectronics.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 411A4B7165
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 06:05:41 +1000 (EST)
Received: from smtp.esic-solutions.com (h1371364.stratoserver.net
	[85.214.87.145]) by ozlabs.org (Postfix) with ESMTP id C6649DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 06:05:40 +1000 (EST)
Message-ID: <4A316386.4020404@missinglinkelectronics.com>
Date: Thu, 11 Jun 2009 22:05:26 +0200
From: Lorenz Kolb <lorenz@missinglinkelectronics.com>
MIME-Version: 1.0
To: Ricardo Ribalda Delgado <ricardo.ribalda@uam.es>
Subject: Re: SD card over (xilinx_)SPI, timeout error while CID
References: <1244216069.21470.12.camel@localhost>	<1244568361.25223.16.camel@localhost>
	<aa76a2be0906111215j15933053rf128f1985a982ca0__26561.0047536486$1244748319$gmane$org@mail.gmail.com>
In-Reply-To: <aa76a2be0906111215j15933053rf128f1985a982ca0__26561.0047536486$1244748319$gmane$org@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: joachim@missinglinkelectronics.com, dbrownell@users.sourceforge.net,
	Joachim Foerster <JOFT@gmx.de>, hp@axis.com,
	lorenz@missinglinkelectronics.com, linuxppc-dev@ozlabs.org,
	mike@steroidmicros.com, pierre@ossman.eu,
	jan.nikitenko@gmail.com, john.linn@xilinx.com, linuxkernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Ricardo Ribalda Delgado wrote:
> Hello,
> 
>    It seems that I am facing the same problem!. I attach another trace
> that also shows the sd I/O.

Is the I/O logged from within the Xilinx-SPI-Driver or from within the 
mmc-spi-layer?

The response to CMD10 seems quite strange to me. The R1 answer to that 
command says that everything is OK, so what is done next is that the 
0xfe token will be expected by the mmc-spi-layer. Obviously that one is 
not received within the proper time (assuming your data-logging was done 
from within xilinx-spi-driver). Also be aware of printk() taking 
milliseconds for printing to console, within time critical routines that 
might not be the best choice for debugging.

What frequency does Your SPI-Bus use?


Also double check to completely disable the whole

   if (spi->master->dev.parent->dma_mask) {
     ...
   }

block within mmc_spi_probe(). That worked for us (as we already said as 
an ugly workaround).

Regards,
   Lorenz
