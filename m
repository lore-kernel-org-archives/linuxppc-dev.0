Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0124.outbound.protection.outlook.com [65.55.169.124])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD9761A016E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 09:19:07 +1100 (AEDT)
Message-ID: <1415053131.23458.287.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2] irqdomain: add support for creating a continous
 mapping
From: Scott Wood <scottwood@freescale.com>
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Date: Mon, 3 Nov 2014 16:18:51 -0600
In-Reply-To: <1415031514-27284-2-git-send-email-johannes.thumshirn@men.de>
References: <1415031514-27284-1-git-send-email-johannes.thumshirn@men.de>
 <1415031514-27284-2-git-send-email-johannes.thumshirn@men.de>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-11-03 at 17:18 +0100, Johannes Thumshirn wrote:
> A MSI device may have multiple interrupts. That means that the
> interrupts numbers should be continuos so that pdev->irq refers to the
> first interrupt, pdev->irq + 1 to the second and so on.
> This patch adds support for continuous allocation of virqs for a range
> of hwirqs. The function is based on irq_create_mapping() but due to the
> number argument there is very little in common now.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@men.de>
> ---
>  include/linux/irqdomain.h | 10 ++++--
>  kernel/irq/irqdomain.c    | 85 ++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 73 insertions(+), 22 deletions(-)

This is changing core kernel code and thus LKML should be CCed, as well
as Ben Herrenschmidt who is the maintainer of kernel/irq/irqdomain.c.

Also please respond to feedback in
http://patchwork.ozlabs.org/patch/322497/

Is it really necessary for the virqs to be contiguous?  How is the
availability of multiple MSIs communicated to the driver?  Is there an
example of a driver that currently uses multiple MSIs?

>  /**
> - * irq_create_mapping() - Map a hardware interrupt into linux irq space
> + * irq_create_mapping_block() - Map multiple hardware interrupts
>   * @domain: domain owning this hardware interrupt or NULL for default domain
>   * @hwirq: hardware irq number in that domain space
> + * @num: number of interrupts
> + *
> + * Maps a hwirq to a newly allocated virq. If num is greater than 1 then num
> + * hwirqs (hwirq ... hwirq + num - 1) will be mapped and virq will be
> + * continuous.
> + * Returns the first linux virq number.
>   *
> - * Only one mapping per hardware interrupt is permitted. Returns a linux
> - * irq number.
>   * If the sense/trigger is to be specified, set_irq_type() should be called
>   * on the number returned from that call.
>   */
> -unsigned int irq_create_mapping(struct irq_domain *domain,
> +unsigned int irq_create_mapping_block(struct irq_domain *domain,
>  				irq_hw_number_t hwirq)
>  {

Where is the num parameter?  How does this even build?

>  	unsigned int hint;
>  	int virq;
> +	int node;
> +	int i;
>  
> -	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
> +	pr_debug("%s(0x%p, 0x%lx, %d)\n", __func__, domain, hwirq, num);
>  
>  	/* Look for default domain if nececssary */
> -	if (domain == NULL)
> +	if (!domain && num == 1)
>  		domain = irq_default_domain;
> +
>  	if (domain == NULL) {
>  		WARN(1, "%s(, %lx) called with NULL domain\n", __func__, hwirq);
>  		return 0;
> @@ -403,35 +437,46 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>  	pr_debug("-> using domain @%p\n", domain);
>  
>  	/* Check if mapping already exists */
> -	virq = irq_find_mapping(domain, hwirq);
> -	if (virq) {
> -		pr_debug("-> existing mapping on virq %d\n", virq);
> -		return virq;
> +	for (i = 0; i < num; i++) {
> +		virq = irq_find_mapping(domain, hwirq + i);
> +		if (virq != NO_IRQ) {

Please don't introduce new uses of NO_IRQ.  irq_find_mapping() returns
zero on failure.  Some architectures (e.g. ARM) define NO_IRQ as
something other than zero, which will cause this to break.

> +			if (i == 0)
> +				return irq_check_continuous_mapping(domain,
> +								hwirq, num);
> +			pr_err("irq: hwirq %ld has no mapping but hwirq %ld "
> +				"maps to virq %d. This can't be a block\n",
> +				hwirq, hwirq + i, virq);
> +			return -EINVAL;
> +		}
>  	}

Explain how you'd get into this error state, and how you'd avoid doing
so.

> +	node = of_node_to_nid(domain->of_node);
> +
>  	/* Allocate a virtual interrupt number */
>  	hint = hwirq % nr_irqs;
>  	if (hint == 0)
>  		hint++;
> -	virq = irq_alloc_desc_from(hint, of_node_to_nid(domain->of_node));
> -	if (virq <= 0)
> -		virq = irq_alloc_desc_from(1, of_node_to_nid(domain->of_node));
> +	virq = irq_alloc_desc_from(hint, node);
> +	if (virq <= 0 && hint != 1)
> +		virq = irq_alloc_desc_from(1, node);

Factoring out node seems irrelevant to, and obscures, what you're doing
which is adding a chcek for hint.  Why is a hint value of 1 special?

You're also still allocating only one virq, unlike in
http://patchwork.ozlabs.org/patch/322497/

-Scott
