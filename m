Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 142F6DE1ED
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 15:25:28 +1000 (EST)
Subject: Re: [PATCH 2/2] powerpc - Make the irq reverse mapping radix tree
	lockless
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastien Dugue <sebastien.dugue@bull.net>
In-Reply-To: <1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
References: <1218029429-21114-1-git-send-email-sebastien.dugue@bull.net>
	<1218029429-21114-3-git-send-email-sebastien.dugue@bull.net>
Content-Type: text/plain
Date: Wed, 20 Aug 2008 15:22:06 +1000
Message-Id: <1219209726.21386.23.camel@pasglop>
Mime-Version: 1.0
Cc: dwalker@mvista.com, tinytim@us.ibm.com, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	jean-pierre.dion@bull.net, linuxppc-dev@ozlabs.org,
	paulus@samba.org, gilles.carry@ext.bull.net, tglx@linutronix.de
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-06 at 15:30 +0200, Sebastien Dugue wrote:
> The radix trees used by interrupt controllers for their irq reverse mapping
> (currently only the XICS found on pSeries) have a complex locking scheme
> dating back to before the advent of the lockless radix tree.
> 
>   Take advantage of this and of the fact that the items of the tree are
> pointers to a static array (irq_map) elements which can never go under us
> to simplify the locking.
> 
>   Concurrency between readers and writers is handled by the intrinsic
> properties of the lockless radix tree. Concurrency between writers is handled
> with a spinlock added to the irq_host structure.

No need for a spinlock in the irq_host. Make it one global lock, it's
not like scalability of irq_create_mapping() was a big deal and there's
usually only one of those type of hosts anyway.

> 
> Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/irq.h |    1 +
>  arch/powerpc/kernel/irq.c      |   74 ++++++----------------------------------
>  2 files changed, 12 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
> index 0a51376..72fd036 100644
> --- a/arch/powerpc/include/asm/irq.h
> +++ b/arch/powerpc/include/asm/irq.h
> @@ -119,6 +119,7 @@ struct irq_host {
>  		} linear;
>  		struct radix_tree_root tree;
>  	} revmap_data;
> +	spinlock_t		tree_lock;
>  	struct irq_host_ops	*ops;
>  	void			*host_data;
>  	irq_hw_number_t		inval_irq;
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index dc8663a..7a19103 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -439,8 +439,6 @@ void do_softirq(void)
>  
>  static LIST_HEAD(irq_hosts);
>  static DEFINE_SPINLOCK(irq_big_lock);
> -static DEFINE_PER_CPU(unsigned int, irq_radix_reader);
> -static unsigned int irq_radix_writer;
>  static atomic_t revmap_trees_allocated = ATOMIC_INIT(0);
>  struct irq_map_entry irq_map[NR_IRQS];
>  static unsigned int irq_virq_count = NR_IRQS;
> @@ -584,57 +582,6 @@ void irq_set_virq_count(unsigned int count)
>  		irq_virq_count = count;
>  }
>  
> -/* radix tree not lockless safe ! we use a brlock-type mecanism
> - * for now, until we can use a lockless radix tree
> - */
> -static void irq_radix_wrlock(unsigned long *flags)
> -{
> -	unsigned int cpu, ok;
> -
> -	spin_lock_irqsave(&irq_big_lock, *flags);
> -	irq_radix_writer = 1;
> -	smp_mb();
> -	do {
> -		barrier();
> -		ok = 1;
> -		for_each_possible_cpu(cpu) {
> -			if (per_cpu(irq_radix_reader, cpu)) {
> -				ok = 0;
> -				break;
> -			}
> -		}
> -		if (!ok)
> -			cpu_relax();
> -	} while(!ok);
> -}
> -
> -static void irq_radix_wrunlock(unsigned long flags)
> -{
> -	smp_wmb();
> -	irq_radix_writer = 0;
> -	spin_unlock_irqrestore(&irq_big_lock, flags);
> -}
> -
> -static void irq_radix_rdlock(unsigned long *flags)
> -{
> -	local_irq_save(*flags);
> -	__get_cpu_var(irq_radix_reader) = 1;
> -	smp_mb();
> -	if (likely(irq_radix_writer == 0))
> -		return;
> -	__get_cpu_var(irq_radix_reader) = 0;
> -	smp_wmb();
> -	spin_lock(&irq_big_lock);
> -	__get_cpu_var(irq_radix_reader) = 1;
> -	spin_unlock(&irq_big_lock);
> -}
> -
> -static void irq_radix_rdunlock(unsigned long flags)
> -{
> -	__get_cpu_var(irq_radix_reader) = 0;
> -	local_irq_restore(flags);
> -}
> -
>  static int irq_setup_virq(struct irq_host *host, unsigned int virq,
>  			    irq_hw_number_t hwirq)
>  {
> @@ -789,7 +736,6 @@ void irq_dispose_mapping(unsigned int virq)
>  {
>  	struct irq_host *host;
>  	irq_hw_number_t hwirq;
> -	unsigned long flags;
>  
>  	if (virq == NO_IRQ)
>  		return;
> @@ -825,9 +771,9 @@ void irq_dispose_mapping(unsigned int virq)
>  		/* Check if radix tree allocated yet */
>  		if (atomic_read(&revmap_trees_allocated) == 0)
>  			break;
> -		irq_radix_wrlock(&flags);
> +		spin_lock(&host->tree_lock);
>  		radix_tree_delete(&host->revmap_data.tree, hwirq);
> -		irq_radix_wrunlock(flags);
> +		spin_unlock(&host->tree_lock);
>  		break;
>  	}
>  
> @@ -881,7 +827,6 @@ unsigned int irq_radix_revmap_lookup(struct irq_host *host,
>  {
>  	struct irq_map_entry *ptr;
>  	unsigned int virq = NO_IRQ;
> -	unsigned long flags;
>  
>  	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
>  
> @@ -893,9 +838,11 @@ unsigned int irq_radix_revmap_lookup(struct irq_host *host,
>  		return irq_find_mapping(host, hwirq);
>  
>  	/* Now try to resolve */
> -	irq_radix_rdlock(&flags);
> +	/*
> +	 * No rcu_read_lock(ing) needed, the ptr returned can't go under us
> +	 * as it's referencing an entry in the static irq_map table.
> +	 */
>  	ptr = radix_tree_lookup(&host->revmap_data.tree, hwirq);
> -	irq_radix_rdunlock(flags);
>  
>  	/* Found it, return */
>  	if (ptr)
> @@ -907,7 +854,6 @@ unsigned int irq_radix_revmap_lookup(struct irq_host *host,
>  void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
>  			     irq_hw_number_t hwirq)
>  {
> -	unsigned long flags;
>  
>  	WARN_ON(host->revmap_type != IRQ_HOST_MAP_TREE);
>  
> @@ -920,10 +866,10 @@ void irq_radix_revmap_insert(struct irq_host *host, unsigned int virq,
>  		return;
>  
>  	if (virq != NO_IRQ) {
> -		irq_radix_wrlock(&flags);
> +		spin_lock(&host->tree_lock);
>  		radix_tree_insert(&host->revmap_data.tree, hwirq,
>  				  &irq_map[virq]);
> -		irq_radix_wrunlock(flags);
> +		spin_unlock(&host->tree_lock);
>  	}
>  }
>  
> @@ -1041,8 +987,10 @@ static int irq_late_init(void)
>  	 * revmap_trees_allocated.
>  	 */
>  	list_for_each_entry(h, &irq_hosts, link) {
> -		if (h->revmap_type == IRQ_HOST_MAP_TREE)
> +		if (h->revmap_type == IRQ_HOST_MAP_TREE) {
>  			INIT_RADIX_TREE(&h->revmap_data.tree, GFP_ATOMIC);
> +			spin_lock_init(&h->tree_lock);
> +		}
>  	}
>  
>  	/*
