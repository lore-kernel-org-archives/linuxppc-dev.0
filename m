Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 39854B70B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 15:23:05 +1100 (EST)
Subject: Re: [PATCH 01/28] powerpc: mpic irq_data conversion.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
In-Reply-To: <20110307235902.GF16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110307235902.GF16649@mail.wantstofly.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 09 Mar 2011 14:22:55 +1100
Message-ID: <1299640975.22236.263.camel@pasglop>
Mime-Version: 1.0
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-03-08 at 00:59 +0100, Lennert Buytenhek wrote:

> -static void mpic_unmask_ht_irq(unsigned int irq)
> +static void mpic_unmask_ht_irq(struct irq_data *d)
>  {
> -	struct mpic *mpic = mpic_from_irq(irq);
> -	unsigned int src = mpic_irq_to_hw(irq);
> +	struct mpic *mpic = mpic_from_irq(d->irq);
> +	unsigned int src = mpic_irq_to_hw(d->irq);

It's a bit sad to have a pointerm turn it back to a irq number, look it
up just to get back the chip data in there :-)

Either we should create an mpic_from_irqdata() which itself uses
irq_data_get_irq_chip_data() or just change mpic_from_irq() if we decide
we can always call it with "data" instead of "irq"
 
> -	mpic_unmask_irq(irq);
> +	mpic_unmask_irq(d);
>  
> -	if (irq_to_desc(irq)->status & IRQ_LEVEL)
> +	if (irq_to_desc(d->irq)->status & IRQ_LEVEL)
>  		mpic_ht_end_irq(mpic, src);
>  }

Do we really need that gymnastic to get to desc->status from irq_data ?

Again, we're going back to a number and then looking it up again... bad.

I don't see off hand a data -> desc accessor, but it also looks like it
should be trivial to add. Thomas, what do you reckon ?

> -static unsigned int mpic_startup_ht_irq(unsigned int irq)
> +static unsigned int mpic_startup_ht_irq(struct irq_data *d)
>  {
> -	struct mpic *mpic = mpic_from_irq(irq);
> -	unsigned int src = mpic_irq_to_hw(irq);
> +	struct mpic *mpic = mpic_from_irq(d->irq);
> +	unsigned int src = mpic_irq_to_hw(d->irq);
>  
> -	mpic_unmask_irq(irq);
> -	mpic_startup_ht_interrupt(mpic, src, irq_to_desc(irq)->status);
> +	mpic_unmask_irq(d);
> +	mpic_startup_ht_interrupt(mpic, src, irq_to_desc(d->irq)->status);
>  
>  	return 0;
>  }

Similar.

Cheers,
Ben.
