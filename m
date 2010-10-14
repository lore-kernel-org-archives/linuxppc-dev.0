Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] ppc: lazy flush_tlb_mm for nohash architectures
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
In-Reply-To: <1285351297-9999-3-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1285351297-9999-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1285351297-9999-3-git-send-email-shaggy@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Oct 2010 11:52:19 +1100
Message-ID: <1287017539.2205.48.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-09-24 at 13:01 -0500, Dave Kleikamp wrote:
> On PPC_MMU_NOHASH processors that support a large number of contexts,
> implement a lazy flush_tlb_mm() that switches to a free context, marking
> the old one stale.  The tlb is only flushed when no free contexts are
> available.
> 
> The lazy tlb flushing is controlled by the global variable tlb_lazy_flush
> which is set during init, dependent upon MMU_FTR_TYPE_47x.

Unless I'm mistaken, there are some issues with that patch... sorry for
the late review, I've been away for a couple of weeks.

> +int tlb_lazy_flush;
> +static int tlb_needs_flush[NR_CPUS];
> +static unsigned long *context_available_map;
> +static unsigned int nr_stale_contexts;

Now I understand what you're doing here, but wouldn't it have been
possible to re-use the existing stale map concept or do you reckon it
would have been too messy ?

At the very least, the "old style" stale map code and "new style" stale
TLB code should be more in sync, you may end up flushing the TLB
twice...

>  #define CTX_MAP_SIZE	\
>  	(sizeof(unsigned long) * (last_context / BITS_PER_LONG + 1))
>  
> +/*
> + * if another cpu recycled the stale contexts, we need to flush
> + * the local TLB, so that we may re-use those contexts
> + */
> +void flush_recycled_contexts(int cpu)
> +{
> +	int i;
> +
> +	if (tlb_needs_flush[cpu]) {
> +		pr_hard("[%d] flushing tlb\n", cpu);
> +		_tlbil_all();
> +		for (i = cpu_first_thread_in_core(cpu);
> +		     i <= cpu_last_thread_in_core(cpu); i++) {
> +			tlb_needs_flush[i] = 0;
> +		}
> +	}
> +}

So far so good :-)

>  /* Steal a context from a task that has one at the moment.
>   *
> @@ -147,7 +167,7 @@ static unsigned int steal_context_up(unsigned int id)
>  	pr_hardcont(" | steal %d from 0x%p", id, mm);
>  
>  	/* Flush the TLB for that context */
> -	local_flush_tlb_mm(mm);
> +	__local_flush_tlb_mm(mm);
>  
>  	/* Mark this mm has having no context anymore */
>  	mm->context.id = MMU_NO_CONTEXT;

Ok.

> @@ -161,13 +181,19 @@ static unsigned int steal_context_up(unsigned int id)
>  #ifdef DEBUG_MAP_CONSISTENCY
>  static void context_check_map(void)
>  {
> -	unsigned int id, nrf, nact;
> +	unsigned int id, nrf, nact, nstale;
>  
> -	nrf = nact = 0;
> +	nrf = nact = nstale = 0;
>  	for (id = first_context; id <= last_context; id++) {
>  		int used = test_bit(id, context_map);
> -		if (!used)
> -			nrf++;
> +		int allocated = tlb_lazy_flush &&
> +				test_bit(id, context_available_map);
> +		if (!used) {
> +			if (allocated)
> +				nstale++;
> +			else
> +				nrf++;
> +		}
>  		if (used != (context_mm[id] != NULL))
>  			pr_err("MMU: Context %d is %s and MM is %p !\n",
>  			       id, used ? "used" : "free", context_mm[id]);
> @@ -179,6 +205,11 @@ static void context_check_map(void)
>  		       nr_free_contexts, nrf);
>  		nr_free_contexts = nrf;
>  	}
> +	if (nstale != nr_stale_contexts) {
> +		pr_err("MMU: Stale context count out of sync ! (%d vs %d)\n",
> +		       nr_stale_contexts, nstale);
> +		nr_stale_contexts = nstale;
> +	}
>  	if (nact > num_online_cpus())
>  		pr_err("MMU: More active contexts than CPUs ! (%d vs %d)\n",
>  		       nact, num_online_cpus());

Cursory glance on the above looks ok.

> @@ -189,6 +220,38 @@ static void context_check_map(void)
>  static void context_check_map(void) { }
>  #endif
>  
> +/*
> + * On architectures that support a large number of contexts, the tlb
> + * can be flushed lazily by picking a new context and making the stale
> + * context unusable until a lazy tlb flush has been issued.
> + *
> + * context_available_map keeps track of both active and stale contexts,
> + * while context_map continues to track only active contexts.  When the
> + * lazy tlb flush is triggered, context_map is copied to
> + * context_available_map, making the once-stale contexts available again
> + */
> +static void recycle_stale_contexts(void)
> +{
> +	if (nr_free_contexts == 0 && nr_stale_contexts > 0) {

Do an early return and avoid the indentation instead ?

> +		unsigned int cpu = smp_processor_id();
> +		unsigned int i;
> +
> +		pr_hard("[%d] recycling stale contexts\n", cpu);
> +		/* Time to flush the TLB's */
> +		memcpy(context_available_map, context_map, CTX_MAP_SIZE);
> +		nr_free_contexts = nr_stale_contexts;
> +		nr_stale_contexts = 0;
> +		for_each_online_cpu(i) {
> +			if ((i < cpu_first_thread_in_core(cpu)) ||
> +			    (i > cpu_last_thread_in_core(cpu)))
> +				tlb_needs_flush[i] = 1;
> +			else
> +				tlb_needs_flush[i] = 0;	/* This core */
> +		}
> +		_tlbil_all();
> +	}
> +}
> +
>  void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
>  {
>  	unsigned int i, id, cpu = smp_processor_id();
> @@ -197,6 +260,8 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
>  	/* No lockless fast path .. yet */
>  	raw_spin_lock(&context_lock);
>  
> +	flush_recycled_contexts(cpu);
> +

Ok so here's the nasty one I think. You need to make sure that whenever
you pick something off the context_available_map, you've done the above
first within the same context_lock section right ? At least before you
actually -use- said context.

So far so good ... but steal_context can drop the lock iirc. So you may
need to re-flush there. Not sure that can happen in practice but better
safe than sorry. I would have preferred seeing that flush near the end
of the function to avoid such problem.

Then, you can end up in cases where you flush the TLB, but your context
is marked stale due to stealing, and flush again. That's one of the
reason I wonder if we can consolidate a bit the two orthogonal
"staleness" concepts we have now.

Granted, stealing on 47x is unlikely, but I have reasons to think that
this lazy flushing will benefit 440 too.

>  	pr_hard("[%d] activating context for mm @%p, active=%d, id=%d",
>  		cpu, next, next->context.active, next->context.id);
>  
> @@ -227,7 +292,12 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
>  	id = next_context;
>  	if (id > last_context)
>  		id = first_context;
> -	map = context_map;
> +
> +	if (tlb_lazy_flush) {
> +		recycle_stale_contexts();
> +		map = context_available_map;
> +	} else
> +		map = context_map;
>  
>  	/* No more free contexts, let's try to steal one */
>  	if (nr_free_contexts == 0) {
> @@ -250,6 +320,13 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
>  		if (id > last_context)
>  			id = first_context;
>  	}
> +	if (tlb_lazy_flush)
> +		/*
> +		 * In the while loop above, we set the bit in
> +		 * context_available_map, it also needs to be set in
> +		 * context_map
> +		 */
> +		__set_bit(id, context_map);
>   stolen:
>  	next_context = id + 1;
>  	context_mm[id] = next;
> @@ -267,7 +344,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
>  			    id, cpu_first_thread_in_core(cpu),
>  			    cpu_last_thread_in_core(cpu));
>  
> -		local_flush_tlb_mm(next);
> +		__local_flush_tlb_mm(next);
>  
>  		/* XXX This clear should ultimately be part of local_flush_tlb_mm */
>  		for (i = cpu_first_thread_in_core(cpu);
> @@ -317,11 +394,61 @@ void destroy_context(struct mm_struct *mm)
>  		mm->context.active = 0;
>  #endif
>  		context_mm[id] = NULL;
> -		nr_free_contexts++;
> +
> +		if (tlb_lazy_flush)
> +			nr_stale_contexts++;
> +		else
> +			nr_free_contexts++;
>  	}
>  	raw_spin_unlock_irqrestore(&context_lock, flags);
>  }

Now...

> +/*
> + * This is called from flush_tlb_mm().  Mark the current context as stale
> + * and grab an available one.  The tlb will be flushed when no more
> + * contexts are available
> + */
> +void lazy_flush_context(struct mm_struct *mm)
> +{
> +	unsigned int id;
> +	unsigned long flags;
> +	unsigned long *map;
> +
> +	raw_spin_lock_irqsave(&context_lock, flags);
> +
> +	id = mm->context.id;
> +	if (unlikely(id == MMU_NO_CONTEXT))
> +		goto no_context;

First thing is ... you reproduce quite a bit of logic from
switch_mmu_context() here. Shouldn't it be abstracted in a separate
function ?

The other thing here is that another CPU might have done a
recycle_stale_contexts() before you get here. IE. Your TLB may be stale.
Shouln't you do a flush here ? Since you are picking up a new PID from
the context_available_map, it can potentially be stale if your tlb needs
flushing due to another CPU having just done a recycle.

> +	/*
> +	 * Make the existing context stale.  It remains in
> +	 * context_available_map as long as nr_free_contexts remains non-zero
> +	 */
> +	 __clear_bit(id, context_map);
> +	 context_mm[id] = NULL;
> +	 nr_stale_contexts++;
> +
> +	recycle_stale_contexts();
> +	BUG_ON(nr_free_contexts == 0);
> +
> +	nr_free_contexts--;
> +	id = last_context;
> +	map = context_available_map;
> +	while (__test_and_set_bit(id, map)) {
> +		id = find_next_zero_bit(map, last_context+1, id);
> +		if (id > last_context)
> +			id = first_context;
> +	}
> +	set_bit(id, context_map);
> +	next_context = id + 1;
> +	context_mm[id] = mm;
> +	mm->context.id = id;
> +	if (current->active_mm == mm)
> +		set_context(id, mm->pgd);
> +no_context:
> +	raw_spin_unlock_irqrestore(&context_lock, flags);
> +}
> +
>  #ifdef CONFIG_SMP
>  
>  static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
> @@ -407,6 +534,7 @@ void __init mmu_context_init(void)
>  	} else if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
>  		first_context = 1;
>  		last_context = 65535;
> +		tlb_lazy_flush = 1;
>  	} else {
>  		first_context = 1;
>  		last_context = 255;

Somebody should measure on 440, might actually improve perfs. Something
like a kernel compile sounds like a good test here.

> @@ -419,6 +547,8 @@ void __init mmu_context_init(void)
>  	 * Allocate the maps used by context management
>  	 */
>  	context_map = alloc_bootmem(CTX_MAP_SIZE);
> +	if (tlb_lazy_flush)
> +		context_available_map = alloc_bootmem(CTX_MAP_SIZE);
>  	context_mm = alloc_bootmem(sizeof(void *) * (last_context + 1));
>  	stale_map[0] = alloc_bootmem(CTX_MAP_SIZE);
>  
> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index 63b84a0..64240f1 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -25,6 +25,14 @@
>  #ifdef CONFIG_PPC_MMU_NOHASH

Cheers,
Ben.
