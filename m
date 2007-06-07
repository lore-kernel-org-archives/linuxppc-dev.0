Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 77820DDEF7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jun 2007 00:09:21 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Ming Liu" <eemingliu@hotmail.com>
Subject: Re: a question on "iowrite32()"
Date: Thu, 7 Jun 2007 16:09:18 +0200
References: <BAY138-F35699348E26C40AED449B3B2260@phx.gbl>
In-Reply-To: <BAY138-F35699348E26C40AED449B3B2260@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Message-Id: <200706071609.19399.arnd@arndb.de>
Cc: domen.puncer@telargo.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 07 June 2007, Ming Liu wrote:
> >Since of_iomap() is rather new and hardly used by any drivers, we
> >could still redefine it so that you would use iowrite32{,be}() instead
> >of out_{be,le}32, but currently that doesn't work.
> 
> So if I am correct, your suggestion is to use iowrite32be() in my device 
> driver, right? 

What I was saying is that iowrite32be is broken for other reasons, as it
is only defined for PCI and ISA devices and you should _not_ use it, 
even if it solves the endianess problem.

What you should use is out_be32().

> However, I cannot find such a function defined in my 2.6.10 kernel.
> Isn't iowrite32be() a standard IO function like iowrite32(), or there is
> a patch to export this function? 

It's a standard function, is was added less than two years ago.
You should really consider upgrading to a recent kernel version for
a number of reasons, but they are all unrelated to your current problem ;-)

	Arnd <><
