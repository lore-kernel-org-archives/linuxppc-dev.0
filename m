Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26E92DE07C
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 14:51:48 +1100 (EST)
Subject: Re: [PATCH 6/14] ps3: smp interrupt fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45B81883.2010508@am.sony.com>
References: <45B81883.2010508@am.sony.com>
Content-Type: text/plain
Date: Thu, 25 Jan 2007 14:51:37 +1100
Message-Id: <1169697098.24996.49.camel@localhost.localdomain>
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

On Wed, 2007-01-24 at 18:40 -0800, Geoff Levand wrote:
> PS3 fixups for interrups on SMP.
> 
> Fixes the alignment of the interrupt status bitmap, changes the hypervisor
> interrupt calls to the '_ext' versions that take an explicit processor
> thread ID, and sets the cpu_features flag CPU_FTR_SMT.
> 
> 
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

Looks good.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/ps3/interrupt.c |   64 +++++++++++++++------------------
>  arch/powerpc/platforms/ps3/setup.c     |    1 
>  2 files changed, 32 insertions(+), 33 deletions(-)
> 
> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/interrupt.c
> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/interrupt.c
> @@ -317,22 +317,23 @@ struct ps3_bmp {
>  		unsigned long unused_1[3];
>  		unsigned long mask;
>  		unsigned long unused_2[3];
> -	} __attribute__ ((packed));
> +	} __attribute__ ((aligned (64)));
> +
>  	spinlock_t lock;
>  	unsigned long ipi_debug_brk_mask;
>  };
>  
>  /**
>   * struct ps3_private - a per cpu data structure
> - * @node: HV node id
> - * @cpu: HV thread id
> - * @bmp: an HV ps3_bmp structure
> + * @bmp: ps3_bmp structure
> + * @node: HV logical_ppe_id
> + * @cpu: HV thread_id
>   */
>  
>  struct ps3_private {
> +	struct ps3_bmp bmp;
>  	unsigned long node;
>  	unsigned int cpu;
> -	struct ps3_bmp bmp;
>  };
>  
>  #if defined(DEBUG)
> @@ -389,9 +390,8 @@ static void ps3_chip_mask(unsigned int v
>  
>  	spin_lock_irqsave(&pd->bmp.lock, flags);
>  	pd->bmp.mask &= ~(0x8000000000000000UL >> virq);
> -	spin_unlock_irqrestore(&pd->bmp.lock, flags);
> -
>  	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
> +	spin_unlock_irqrestore(&pd->bmp.lock, flags);
>  }
>  
>  static void ps3_chip_unmask(unsigned int virq)
> @@ -406,14 +406,14 @@ static void ps3_chip_unmask(unsigned int
>  
>  	spin_lock_irqsave(&pd->bmp.lock, flags);
>  	pd->bmp.mask |= (0x8000000000000000UL >> virq);
> -	spin_unlock_irqrestore(&pd->bmp.lock, flags);
> -
>  	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
> +	spin_unlock_irqrestore(&pd->bmp.lock, flags);
>  }
>  
>  static void ps3_chip_eoi(unsigned int virq)
>  {
> -	lv1_end_of_interrupt(virq);
> +	const struct ps3_private *pd = get_irq_chip_data(virq);
> +	lv1_end_of_interrupt_ext(pd->node, pd->cpu, virq);
>  }
>  
>  static struct irq_chip irq_chip = {
> @@ -426,10 +426,12 @@ static struct irq_chip irq_chip = {
>  static void ps3_host_unmap(struct irq_host *h, unsigned int virq)
>  {
>  	int result;
> +	const struct ps3_private *pd = get_irq_chip_data(virq);
>  
> -	pr_debug("%s:%d: virq %d\n", __func__, __LINE__, virq);
> +	pr_debug("%s:%d: node %lu, cpu %d, virq %u\n", __func__, __LINE__,
> +		pd->node, pd->cpu, virq);
>  
> -	lv1_disconnect_irq_plug(virq);
> +	lv1_disconnect_irq_plug_ext(pd->node, pd->cpu, virq);
>  
>  	result = set_irq_chip_data(virq, NULL);
>  	BUG_ON(result);
> @@ -441,31 +443,26 @@ static int ps3_host_map(struct irq_host 
>  	irq_hw_number_t hwirq)
>  {
>  	int result;
> -	unsigned int cpu;
> +	struct ps3_private *pd = &__get_cpu_var(ps3_private);
> +
> +	pr_debug("%s:%d: node %lu, cpu %d, hwirq %lu => virq %u\n", __func__,
> +		__LINE__, pd->node, pd->cpu, hwirq, virq);
>  
> -	pr_debug(" -> %s:%d\n", __func__, __LINE__);
> -	pr_debug("%s:%d: hwirq %lu => virq %u\n", __func__, __LINE__, hwirq,
> -		virq);
> -
> -	/* bind this virq to a cpu */
> -
> -	preempt_disable();
> -	cpu = smp_processor_id();
> -	result = lv1_connect_irq_plug(virq, hwirq);
> -	preempt_enable();
> +	/* Binds this virq to pd->cpu (current cpu) */
> +
> +	result = lv1_connect_irq_plug_ext(pd->node, pd->cpu, virq, hwirq, 0);
>  
>  	if (result) {
> -		pr_info("%s:%d: lv1_connect_irq_plug failed:"
> +		pr_info("%s:%d: lv1_connect_irq_plug_ext failed:"
>  			" %s\n", __func__, __LINE__, ps3_result(result));
>  		return -EPERM;
>  	}
>  
> -	result = set_irq_chip_data(virq, &per_cpu(ps3_private, cpu));
> +	result = set_irq_chip_data(virq, pd);
>  	BUG_ON(result);
>  
>  	set_irq_chip_and_handler(virq, &irq_chip, handle_fasteoi_irq);
>  
> -	pr_debug(" <- %s:%d\n", __func__, __LINE__);
>  	return result;
>  }
>  
> @@ -544,12 +541,9 @@ unsigned int ps3_get_irq(void)
>  void __init ps3_init_IRQ(void)
>  {
>  	int result;
> -	unsigned long node;
>  	unsigned cpu;
>  	struct irq_host *host;
>  
> -	lv1_get_logical_ppe_id(&node);
> -
>  	host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, 0, &ps3_host_ops,
>  		PS3_INVALID_OUTLET);
>  	irq_set_default_host(host);
> @@ -558,12 +552,16 @@ void __init ps3_init_IRQ(void)
>  	for_each_possible_cpu(cpu) {
>  		struct ps3_private *pd = &per_cpu(ps3_private, cpu);
>  
> -		pd->node = node;
> -		pd->cpu = cpu;
> +		lv1_get_logical_ppe_id(&pd->node);
> +		pd->cpu = get_hard_smp_processor_id(cpu);
>  		spin_lock_init(&pd->bmp.lock);
>  
> -		result = lv1_configure_irq_state_bitmap(node, cpu,
> -			ps3_mm_phys_to_lpar(__pa(&pd->bmp.status)));
> +		pr_debug("%s:%d: node %lu, cpu %d, bmp %lxh\n", __func__,
> +			__LINE__, pd->node, pd->cpu,
> +			ps3_mm_phys_to_lpar(__pa(&pd->bmp)));
> +
> +		result = lv1_configure_irq_state_bitmap(pd->node, pd->cpu,
> +			ps3_mm_phys_to_lpar(__pa(&pd->bmp)));
>  
>  		if (result)
>  			pr_debug("%s:%d: lv1_configure_irq_state_bitmap failed:"
> --- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/setup.c
> +++ ps3-linux-dev/arch/powerpc/platforms/ps3/setup.c
> @@ -109,6 +109,7 @@ static int __init ps3_probe(void)
>  		return 0;
>  
>  	powerpc_firmware_features |= FW_FEATURE_PS3_POSSIBLE;
> +	cur_cpu_spec->cpu_features |= CPU_FTR_SMT;
>  
>  	ps3_os_area_init();
>  	ps3_mm_init();
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
