Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CBB2ADE002
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 08:43:43 +1000 (EST)
Subject: Re: [PATCH 1/4] Split virq setup logic out into irq_setup_virq()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 05 Jun 2007 08:43:32 +1000
Message-Id: <1180997012.31677.79.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 22:59 +1000, Michael Ellerman wrote:
> A future patch will need the logic at the end of irq_create_mapping()
> which setups a virq and installs it in the irq_map. So split it out
> into a new function irq_setup_virq().
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/irq.c |   32 +++++++++++++++++++++-----------
>  1 files changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 42c8ed6..9bafc88 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -591,6 +591,25 @@ static void irq_radix_rdunlock(unsigned long flags)
>  	local_irq_restore(flags);
>  }
>  
> +static int irq_setup_virq(struct irq_host *host, unsigned int virq,
> +			    irq_hw_number_t hwirq)
> +{
> +	/* Clear IRQ_NOREQUEST flag */
> +	get_irq_desc(virq)->status &= ~IRQ_NOREQUEST;
> +
> +	/* map it */
> +	smp_wmb();
> +	irq_map[virq].hwirq = hwirq;
> +	smp_mb();
> +
> +	if (host->ops->map(host, virq, hwirq)) {
> +		pr_debug("irq: -> mapping failed, freeing\n");
> +		irq_free_virt(virq, 1);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
>  
>  unsigned int irq_create_mapping(struct irq_host *host,
>  				irq_hw_number_t hwirq)
> @@ -639,18 +658,9 @@ unsigned int irq_create_mapping(struct irq_host *host,
>  	}
>  	pr_debug("irq: -> obtained virq %d\n", virq);
>  
> -	/* Clear IRQ_NOREQUEST flag */
> -	get_irq_desc(virq)->status &= ~IRQ_NOREQUEST;
> -
> -	/* map it */
> -	smp_wmb();
> -	irq_map[virq].hwirq = hwirq;
> -	smp_mb();
> -	if (host->ops->map(host, virq, hwirq)) {
> -		pr_debug("irq: -> mapping failed, freeing\n");
> -		irq_free_virt(virq, 1);
> +	if (irq_setup_virq(host, virq, hwirq))
>  		return NO_IRQ;
> -	}
> +
>  	return virq;
>  }
>  EXPORT_SYMBOL_GPL(irq_create_mapping);
