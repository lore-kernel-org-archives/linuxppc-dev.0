Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4E7CC67C11
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 15:58:43 +1100 (EST)
Subject: Re: [PATCH 5/19] powerpc: add IRQ remapping hook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200612140227.kBE2R3jR012071@toshiba.co.jp>
References: <200612140227.kBE2R3jR012071@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 15:58:36 +1100
Message-Id: <1166072316.11914.284.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-12-14 at 11:27 +0900, Ishizaki Kou wrote:
> This patch adds irq remapping hook. On interrupt mechanism on Beat,
> when an irq outlet who has an id which is formerly used is created,
> remapping the irq is required.

Today paulus asked me what that was for and I must admit that despite
your earlier explanations, I was a bit at a loss justifying it.

Can you explain us again the exact cicrumstances in which this is
necessary ? It seems to us that if an interrupt outlet<->plug linkage is
removed in the hypervisor itself, it should be also removed in linux
using irq_dispose_mapping().

What are the cases where the HV might require a linkage to be
re-established by that remap function that the kernel couldn't have done
the cleanup itself beforehand ?

Regards,
Ben. 

> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Index: linux-powerpc-git/include/asm-powerpc/irq.h
> diff -u linux-powerpc-git/include/asm-powerpc/irq.h:1.1.1.1 linux-powerpc-git/include/asm-powerpc/irq.h:1.2
> --- linux-powerpc-git/include/asm-powerpc/irq.h:1.1.1.1	Wed Dec  6 08:24:04 2006
> +++ linux-powerpc-git/include/asm-powerpc/irq.h	Wed Dec  6 08:43:16 2006
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
> Index: linux-powerpc-git/arch/powerpc/kernel/irq.c
> diff -u linux-powerpc-git/arch/powerpc/kernel/irq.c:1.1.1.1 linux-powerpc-git/arch/powerpc/kernel/irq.c:1.2
> --- linux-powerpc-git/arch/powerpc/kernel/irq.c:1.1.1.1	Wed Dec  6 08:25:43 2006
> +++ linux-powerpc-git/arch/powerpc/kernel/irq.c	Wed Dec  6 08:43:14 2006
> @@ -604,6 +604,8 @@
>  	 */
>  	virq = irq_find_mapping(host, hwirq);
>  	if (virq != IRQ_NONE) {
> +		if (host->ops->remap)
> +			host->ops->remap(host, virq, hwirq);
>  		pr_debug("irq: -> existing mapping on virq %d\n", virq);
>  		return virq;
>  	}
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
