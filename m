Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2A41CDDF46
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Feb 2008 04:38:39 +1100 (EST)
Message-ID: <47A74D98.4020309@freescale.com>
Date: Mon, 04 Feb 2008 11:38:32 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 05/11] [POWERPC] qe_lib: support for gpio_set_dedicated
References: <20080203170820.GA18520@localhost.localdomain>
	<20080203171009.GE28024@localhost.localdomain>
In-Reply-To: <20080203171009.GE28024@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> +static int qe_gpio_set_dedicated(struct gpio_chip *gc, unsigned int gpio,
> +				 int func)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
> +	struct port_regs __iomem *regs = mm_gc->regs;
> +	struct port_regs *sregs = &qe_gc->saved_regs;
> +	unsigned long flags;
> +	u32 mask1 = 1 << (NUM_OF_PINS - (gpio + 1));
> +	u32 mask2 = 0x3 << (NUM_OF_PINS - (gpio % (NUM_OF_PINS / 2) + 1) * 2);
> +	bool second_reg = gpio > (NUM_OF_PINS / 2) - 1;
> +
> +	spin_lock_irqsave(&qe_gc->lock, flags);
> +
> +	if (second_reg)
> +		clrsetbits_be32(&regs->cpdir2, mask2, sregs->cpdir2 & mask2);
> +	else
> +		clrsetbits_be32(&regs->cpdir1, mask2, sregs->cpdir1 & mask2);
> +
> +	if (second_reg)
> +		clrsetbits_be32(&regs->cppar2, mask2, sregs->cppar2 & mask2);
> +	else
> +		clrsetbits_be32(&regs->cppar1, mask2, sregs->cppar1 & mask2);

You could combine these into one if-statement.

I took a quick look at all of your QE lib patches.  They generally look okay, 
but I haven't examined them thoroughly enough to formally ACK them.

-- 
Timur Tabi
Linux kernel developer at Freescale
