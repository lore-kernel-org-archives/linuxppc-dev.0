Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id D9DED67E8D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 02:14:19 +1000 (EST)
Date: Sun, 14 Aug 2005 09:14:16 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050814091416.B20320@cox.net>
References: <c3d0340b0508121811e7b6fc2@mail.gmail.com>
	<20050812203335.K30033@cox.net>
	<c3d0340b0508132056651e8c97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b0508132056651e8c97@mail.gmail.com>;
	from shawnxjin@gmail.com on Sat, Aug 13, 2005 at 08:56:50PM -0700
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: writel(), readl() in <asm-ppc/io.h>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Aug 13, 2005 at 08:56:50PM -0700, Shawn Jin wrote:
> > read*()/write*() are accessors for PCI and PCI only.  PCI is little
> 
> If read*()/write*() are designed for PCI access only as you claimed,
> that explains why they call in/out_leXX() funcitons.
> 
> The problem is that read*()/write*() are misused in some places, e.g.,
> serial drivers such as serial8250. The serial_in() and serial_out()
> call read*() and write*() respectively. So what's your recommendation
> in such a case?

Keep misusing them. There's no generic accessors for memory mapped
I/O.  People just started using them in generic drivers because they
are convenient. I use the the __raw_read*() for non byte swapped access
(or in/outbe32() depending on my memory barrier requirements.

Also, portions of the 8250 serial driver using readl/writel are
assuming that the serial port in on PCI or other little endian bus.
readb/writeb usage doesn't matter in that driver.

-Matt
