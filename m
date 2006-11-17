Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C69DE67BD9
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 18:33:58 +1100 (EST)
Subject: Re: [PATCH 2/16] powerpc: add virq_to_hw accessor routine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <455D2F73.9090900@am.sony.com>
References: <455D2F73.9090900@am.sony.com>
Content-Type: text/plain
Date: Fri, 17 Nov 2006 18:34:16 +1100
Message-Id: <1163748856.5826.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-11-16 at 19:41 -0800, Geoff Levand wrote:
> Subject: powerpc: add virq_to_hw accessor routine
> 
> From: Geoff Levand <geoffrey.levand@am.sony.com>
> This adds an accessor routine virq_to_hw() to the
> virq routines which hides the implementation details
> of the virq to hwirq map.
> 
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  include/asm-powerpc/irq.h |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> Index: linux-2.6/include/asm-powerpc/irq.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/irq.h
> +++ linux-2.6/include/asm-powerpc/irq.h
> @@ -135,6 +135,10 @@ struct irq_map_entry {
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
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
