Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net
	[151.189.21.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2CFF667C04
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 09:50:14 +1100 (EST)
In-Reply-To: <1162627290.28571.22.camel@localhost.localdomain>
References: <1162627290.28571.22.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E9A7749A-2DDE-4F33-8ACC-5A4496A3054E@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH/RFC] Hookable IO operations #2
Date: Sat, 4 Nov 2006 23:50:02 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Much nicer, great.  I said I'd comment though, so some
trivial nits :-)

> + * * __ioremap_explicit (and it's pending __iounmap_explicit) are  
> low level

s/it's/its/ .  Or "the", even.

> + * When CONFIG_PPC_INDIRECT_IO is set, we use the generic iomap  
> implementation
> + * which needs some additional definitions here. They basically  
> allow PIO
> + * space overall to be 1Gb. This will work as long as we never try  
> to use
> + * iomap to map MMIO below 1Gb which should be fine on ppc64
> + */

1GB, not 1Gb.

> +#define HAVE_ARCH_PIO_SIZE	1
> +#define PIO_OFFSET		0x00000000UL
> +#define PIO_MASK		0x3fffffffUL
> +#define PIO_RESERVED		0x40000000UL


Segher
