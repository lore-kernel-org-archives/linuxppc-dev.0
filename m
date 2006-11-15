Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EDFC367E57
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 10:58:57 +1100 (EST)
Subject: Re: [PATCH 13/16] add IRQ remapping
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200611151018.kAFAIb3o028137@toshiba.co.jp>
References: <200611151018.kAFAIb3o028137@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 10:58:52 +1100
Message-Id: <1163635132.5940.297.camel@localhost.localdomain>
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

On Wed, 2006-11-15 at 19:18 +0900, Ishizaki Kou wrote:
> This patch adds irq remapping.
> On interrupt mechanism on Beat, when an irq outlet who has an id
> hich is formerly used is created, remapping the irq is required.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
> Index: linux-2.6.19/arch/powerpc/kernel/irq.c
> diff -u linux-2.6.19/arch/powerpc/kernel/irq.c:1.1.1.2 linux-2.6.19/arch/powerpc/kernel/irq.c:1.4
> --- linux-2.6.19/arch/powerpc/kernel/irq.c:1.1.1.2	Tue Oct 17 08:40:57 2006
> +++ linux-2.6.19/arch/powerpc/kernel/irq.c	Mon Nov  6 22:04:23 2006
> @@ -534,6 +534,8 @@
>  	 */
>  	virq = irq_find_mapping(host, hwirq);
>  	if (virq != IRQ_NONE) {
> +		if (host->ops->remap)
> +			host->ops->remap(host, virq, hwirq);
>  		pr_debug("irq: -> existing mapping on virq %d\n", virq);
>  		return virq;
>  	}
> Index: linux-2.6.19/include/asm-powerpc/irq.h
> diff -u linux-2.6.19/include/asm-powerpc/irq.h:1.1.1.2 linux-2.6.19/include/asm-powerpc/irq.h:1.3
> --- linux-2.6.19/include/asm-powerpc/irq.h:1.1.1.2	Tue Oct 17 08:44:31 2006
> +++ linux-2.6.19/include/asm-powerpc/irq.h	Tue Oct 17 13:22:53 2006
> @@ -89,6 +89,9 @@
>  	/* Dispose of such a mapping */
>  	void (*unmap)(struct irq_host *h, unsigned int virq);
>  
> +	/* Update of such a mapping  */
> +	void (*remap)(struct irq_host *h, unsigned int virq, irq_hw_number_t hw);
> +
>  	/* Translate device-tree interrupt specifier from raw format coming
>  	 * from the firmware to a irq_hw_number_t (interrupt line number) and
>  	 * type (sense) that can be passed to set_irq_type(). In the absence
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
