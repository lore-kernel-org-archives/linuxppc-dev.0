Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C707D67B22
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Aug 2006 11:20:51 +1000 (EST)
Subject: Re: powerpc virq: minor cleanups
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <44EF8182.2000401@am.sony.com>
References: <44EF8182.2000401@am.sony.com>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 11:20:38 +1000
Message-Id: <1156728038.8433.410.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-08-25 at 16:02 -0700, Geoff Levand wrote:
> Ben,
> 
> Please consider these cleanups.
> 
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> Index: cell--common--4/arch/powerpc/kernel/irq.c
> ===================================================================
> --- cell--common--4.orig/arch/powerpc/kernel/irq.c
> +++ cell--common--4/arch/powerpc/kernel/irq.c
> @@ -678,7 +680,7 @@
>  }
>  EXPORT_SYMBOL_GPL(irq_dispose_mapping);
>  
> -unsigned int irq_find_mapping(struct irq_host *host,
> +unsigned int irq_find_mapping(const struct irq_host *host,
>  			      irq_hw_number_t hwirq)
>  {
>  	unsigned int i;
> Index: cell--common--4/include/asm-powerpc/irq.h
> ===================================================================
> --- cell--common--4.orig/include/asm-powerpc/irq.h
> +++ cell--common--4/include/asm-powerpc/irq.h
> @@ -28,10 +28,10 @@
>  
>  #ifdef CONFIG_PPC_MERGE
>  
> -/* This number is used when no interrupt has been assigned */
> +/* This number is used when no virq has been assigned */
>  #define NO_IRQ			(0)
>  
> -/* This is a special irq number to return from get_irq() to tell that
> +/* This is a special virq number to return from get_irq() to tell that
>   * no interrupt happened _and_ ignore it (don't count it as bad). Some
>   * platforms like iSeries rely on that.
>   */
> @@ -217,7 +222,7 @@
>   * irq controller implementation directly calls the appropriate low level
>   * mapping function.
>   */
> -extern unsigned int irq_find_mapping(struct irq_host *host,
> +extern unsigned int irq_find_mapping(const struct irq_host *host,
>  				     irq_hw_number_t hwirq);
>  
> 
