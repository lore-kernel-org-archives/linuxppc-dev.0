Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B530C67C47
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 11:04:31 +1100 (EST)
Subject: Re: [PATCH] of_irq_to_resource now returns the virq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andy Fleming <afleming@freescale.com>
In-Reply-To: <Pine.LNX.4.61.0611061711510.10818@ld0175-tx32.am.freescale.net>
References: <Pine.LNX.4.61.0611061711510.10818@ld0175-tx32.am.freescale.net>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 11:04:22 +1100
Message-Id: <1162857862.28571.376.camel@localhost.localdomain>
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

On Mon, 2006-11-06 at 17:13 -0600, Andy Fleming wrote:
> Mostly this is to allow for error checking (check the return for NO_IRQ)
> 
> Signed-off-by: Andrew Fleming <afleming@freescale.com>
> ---
> For 2.6.20
> 
>  include/asm-powerpc/prom.h |   13 ++++++++++---
>  1 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
> index 933ba27..e9226e3 100644
> --- a/include/asm-powerpc/prom.h
> +++ b/include/asm-powerpc/prom.h
> @@ -334,10 +334,17 @@ extern int of_irq_map_one(struct device_
>  struct pci_dev;
>  extern int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq);
>  
> -static inline void of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
> +static inline int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
>  {
> -	r->start = r->end = irq_of_parse_and_map(dev, index);
> -	r->flags = IORESOURCE_IRQ;
> +	int irq = irq_of_parse_and_map(dev, index);
> +
> +	/* Only dereference the resource if the irq is valid. */
> +	if (irq != NO_IRQ) {

What about if (irq != NO_IRQ && r) ?
 
> +		r->start = r->end = irq;
> +		r->flags = IORESOURCE_IRQ;
> +	}
> +
> +	return irq;
>  }

That way, if somebody doesn't care about the resource, just pass NULL,
though I suppose we should then also change the name of the function to
something like of_map_one_irq() ..

Ben.
