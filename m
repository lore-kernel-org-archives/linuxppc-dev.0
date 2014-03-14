Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AD3452C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 22:18:20 +1100 (EST)
Date: Fri, 14 Mar 2014 12:18:25 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/2 v2] irqdomain: add support for creating a continous
 mapping
In-Reply-To: <20140221085736.GA11411@linutronix.de>
Message-ID: <alpine.DEB.2.02.1403141210370.18573@ionos.tec.linutronix.de>
References: <1392929590-12888-1-git-send-email-bigeasy@linutronix.de>
 <1392929590-12888-2-git-send-email-bigeasy@linutronix.de>
 <1392930384.6733.842.camel@snotra.buserror.net>
 <20140221085736.GA11411@linutronix.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-169614043-1394795906=:18573"
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-169614043-1394795906=:18573
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 21 Feb 2014, Sebastian Andrzej Siewior wrote:

> A MSI device may have multiple interrupts. That means that the
> interrupts numbers should be continuos so that pdev->irq refers to the
> first interrupt, pdev->irq + 1 to the second and so on.
> This patch adds support for continuous allocation of virqs for a range
> of hwirqs. The function is based on irq_create_mapping() but due to the
> number argument there is very little in common now.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> Scott, this is what you suggested. I must admit, it does not look that
> bad. It is just compile tested.

Is it tested for real as well?
 
> +static int irq_check_continuous_mapping(struct irq_domain *domain,
> +		irq_hw_number_t hwirq, unsigned int num)
> +{
> +	int virq;
> +	int i;
> +
> +	virq = irq_find_mapping(domain, hwirq);
> +
> +	for (i = 1; i < num; i++) {
> +		unsigned int next;
> +
> +		next = irq_find_mapping(domain, hwirq + i);
> +		if (next == virq + i)
> +			continue;
> +
> +		pr_err("irq: invalid partial mapping. First hwirq %lu maps to "
> +				"%d and \n", hwirq, virq);
> +		pr_err("irq: +%d hwirq (%lu) maps to %d but should be %d.\n",
> +				i, hwirq + i, next, virq + i);
> +		return -EINVAL;
> +	}
> +
> +	pr_debug("-> existing mapping on virq %d\n", virq);
> +	return virq;
> +}
> +
>  /**
> - * irq_create_mapping() - Map a hardware interrupt into linux irq space
> + * irq_create_mapping_block() - Map multiple hardware interrupts
>   * @domain: domain owning this hardware interrupt or NULL for default domain
>   * @hwirq: hardware irq number in that domain space
> + * @num: number of interrupts
> + *
> + * Maps a hwirq to a newly allocated virq. If num is greater than 1 then num
> + * hwirqs (hwirq … hwirq + num - 1) will be mapped and virq will be  continuous.
> + * Returns the first linux virq number.
>   *
> - * Only one mapping per hardware interrupt is permitted. Returns a linux
> - * irq number.
>   * If the sense/trigger is to be specified, set_irq_type() should be called
>   * on the number returned from that call.
>   */
> -unsigned int irq_create_mapping(struct irq_domain *domain,
> -				irq_hw_number_t hwirq)
> +unsigned int irq_create_mapping_block(struct irq_domain *domain,
> +		irq_hw_number_t hwirq, unsigned int num)
>  {
> -	unsigned int hint;
>  	int virq;
> +	int i;
> +	int node;
> +	unsigned int hint;

What's wrong with

	unsigned int hint;
  	int virq, i, node;

?
  
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
>  	}
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
> +			if (i == 0)
> +				return irq_check_continuous_mapping(domain,
> +						hwirq, num);

So what is the loop for? If i == 0 and virq != NO_IRQ you return. That
does not make sense at all.
  
> +			pr_err("irq: hwirq %ld has no mapping but hwirq %ld "
> +				"maps to virq %d. This can't be a block\n",
> +				hwirq, hwirq + i, virq);
> +			return -EINVAL;
> +		}
>  	}
>  
> +	node = of_node_to_nid(domain->of_node);
>  	/* Allocate a virtual interrupt number */
>  	hint = hwirq % nr_irqs;
>  	if (hint == 0)
>  		hint++;
> -	virq = irq_alloc_desc_from(hint, of_node_to_nid(domain->of_node));
> -	if (virq <= 0)
> -		virq = irq_alloc_desc_from(1, of_node_to_nid(domain->of_node));
> +	virq = irq_alloc_descs_from(hint, num, node);
> +	if (virq <= 0 && hint != 1)
> +		virq = irq_alloc_descs_from(1, num, node);
>  	if (virq <= 0) {
>  		pr_debug("-> virq allocation failed\n");
>  		return 0;
>  	}
>  
> -	if (irq_domain_associate(domain, virq, hwirq)) {
> -		irq_free_desc(virq);
> -		return 0;
> +	irq_domain_associate_many(domain, virq, hwirq, num);

So irq_domain_associate can fail, but irq_domain_associate_many cannot ?

> +	if (num == 1) {
> +		pr_debug("irq %lu on domain %s mapped to virtual irq %u\n",
> +			hwirq, of_node_full_name(domain->of_node), virq);
> +		return virq;
>  	}
> -
> -	pr_debug("irq %lu on domain %s mapped to virtual irq %u\n",
> -		hwirq, of_node_full_name(domain->of_node), virq);
> -
> +	pr_debug("irqs %lu…%lu on domain %s mapped to virtual irqs %u…%u\n",
> +		hwirq, hwirq + num - 1, of_node_full_name(domain->of_node),
> +			virq, virq + num - 1);

A single pr_debug is sufficient, hmm?

Thanks,

	tglx
--8323329-169614043-1394795906=:18573--
