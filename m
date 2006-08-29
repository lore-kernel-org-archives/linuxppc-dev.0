Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23A5967A5E
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 08:36:41 +1000 (EST)
Subject: Re: powerpc virq: new routine virq_to_hw
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <44F305AA.5020101@am.sony.com>
References: <44EF818B.9080301@am.sony.com>
	<1156728139.8433.413.camel@localhost.localdomain>
	<44F305AA.5020101@am.sony.com>
Content-Type: text/plain
Date: Wed, 30 Aug 2006 08:36:12 +1000
Message-Id: <1156890972.8433.576.camel@localhost.localdomain>
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

On Mon, 2006-08-28 at 08:03 -0700, Geoff Levand wrote:
> Benjamin Herrenschmidt wrote:
> > I'd much prefer:
> > 
> > static inline irq_hw_number_t virq_to_hw (unsigned int virq)
> > {
> > 	return irq_map[virq].hwirq;
> > }
> 
> Here is an updated version.
> 
> -Geoff
> 
> 
> This adds an accessor routine virq_to_hw() to the
> virq routines which hides the implementation details
> of the virq to hwirq map.
> 
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> Index: cell--common--4/include/asm-powerpc/irq.h
> ===================================================================
> --- cell--common--4.orig/include/asm-powerpc/irq.h
> +++ cell--common--4/include/asm-powerpc/irq.h
> @@ -136,6 +136,10 @@
>  
>  extern struct irq_map_entry irq_map[NR_IRQS];
>  
> +static inline irq_hw_number_t virq_to_hw(unsigned int virq)
> +{
> +	return irq_map[virq].hwirq;
> +}
>  
>  /**
>   * irq_alloc_host - Allocate a new irq_host data structure
