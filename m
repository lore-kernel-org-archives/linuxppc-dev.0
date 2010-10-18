Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] ppc: lazy flush_tlb_mm for nohash architectures
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1287017539.2205.48.camel@pasglop>
References: <1285351297-9999-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1285351297-9999-3-git-send-email-shaggy@linux.vnet.ibm.com>
	<1287017539.2205.48.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Mon, 18 Oct 2010 16:57:01 -0500
Message-ID: <1287439021.3700.22.camel@shaggy-w500>
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

On Thu, 2010-10-14 at 11:52 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2010-09-24 at 13:01 -0500, Dave Kleikamp wrote:
> > On PPC_MMU_NOHASH processors that support a large number of contexts,
> > implement a lazy flush_tlb_mm() that switches to a free context, marking
> > the old one stale.  The tlb is only flushed when no free contexts are
> > available.
> > 
> > The lazy tlb flushing is controlled by the global variable tlb_lazy_flush
> > which is set during init, dependent upon MMU_FTR_TYPE_47x.
> 
> Unless I'm mistaken, there are some issues with that patch... sorry for
> the late review, I've been away for a couple of weeks.
> 
> > +int tlb_lazy_flush;
> > +static int tlb_needs_flush[NR_CPUS];
> > +static unsigned long *context_available_map;
> > +static unsigned int nr_stale_contexts;
> 
> Now I understand what you're doing here, but wouldn't it have been
> possible to re-use the existing stale map concept or do you reckon it
> would have been too messy ?

I didn't like the implementation of a per-core stale map.  The existing
implementation flushes the core's tlb, but only clears a specific entry
from the stale map.  It's dealing with the stale contexts one at a time,
where the new function is accumulating many stale contexts, with the
intent to do a single tlb flush per core.

Since I originally intended the new function only to be enabled on the
47x, I left the context-stealing code as untouched as possible thinking
it wouldn't be exercised in 47x-land.  This was probably narrow-minded,
and I should look at either 1) aligning the context-stealing code closer
to the new lazy flush code, or 2) dropping this code on the floor and
picking back up the new design that we worked on last year.


> At the very least, the "old style" stale map code and "new style" stale
> TLB code should be more in sync, you may end up flushing the TLB
> twice...

yeah.  if we enable this for 440, it is more likely to be an issue than
on 476.

> > @@ -189,6 +220,38 @@ static void context_check_map(void)
> >  static void context_check_map(void) { }
> >  #endif
> >  
> > +/*
> > + * On architectures that support a large number of contexts, the tlb
> > + * can be flushed lazily by picking a new context and making the stale
> > + * context unusable until a lazy tlb flush has been issued.
> > + *
> > + * context_available_map keeps track of both active and stale contexts,
> > + * while context_map continues to track only active contexts.  When the
> > + * lazy tlb flush is triggered, context_map is copied to
> > + * context_available_map, making the once-stale contexts available again
> > + */
> > +static void recycle_stale_contexts(void)
> > +{
> > +	if (nr_free_contexts == 0 && nr_stale_contexts > 0) {
> 
> Do an early return and avoid the indentation instead ?

Yeah, that makes sense.

> > +		unsigned int cpu = smp_processor_id();
> > +		unsigned int i;
> > +
> > +		pr_hard("[%d] recycling stale contexts\n", cpu);
> > +		/* Time to flush the TLB's */
> > +		memcpy(context_available_map, context_map, CTX_MAP_SIZE);
> > +		nr_free_contexts = nr_stale_contexts;
> > +		nr_stale_contexts = 0;
> > +		for_each_online_cpu(i) {
> > +			if ((i < cpu_first_thread_in_core(cpu)) ||
> > +			    (i > cpu_last_thread_in_core(cpu)))
> > +				tlb_needs_flush[i] = 1;
> > +			else
> > +				tlb_needs_flush[i] = 0;	/* This core */
> > +		}
> > +		_tlbil_all();
> > +	}
> > +}
> > +
> >  void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
> >  {
> >  	unsigned int i, id, cpu = smp_processor_id();
> > @@ -197,6 +260,8 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
> >  	/* No lockless fast path .. yet */
> >  	raw_spin_lock(&context_lock);
> >  
> > +	flush_recycled_contexts(cpu);
> > +
> 
> Ok so here's the nasty one I think. You need to make sure that whenever
> you pick something off the context_available_map, you've done the above
> first within the same context_lock section right ? At least before you
> actually -use- said context.

right.

> So far so good ... but steal_context can drop the lock iirc. So you may
> need to re-flush there. Not sure that can happen in practice but better
> safe than sorry. I would have preferred seeing that flush near the end
> of the function to avoid such problem.

I can fix this.  For 476, I don't think that even if steal_context()
could be called, it wouldn't drop the lock.  But then again, if we
enable this for other architectures, it may be a possibility.

> Then, you can end up in cases where you flush the TLB, but your context
> is marked stale due to stealing, and flush again. That's one of the
> reason I wonder if we can consolidate a bit the two orthogonal
> "staleness" concepts we have now.
> 
> Granted, stealing on 47x is unlikely, but I have reasons to think that
> this lazy flushing will benefit 440 too.
> 
> >  	pr_hard("[%d] activating context for mm @%p, active=%d, id=%d",
> >  		cpu, next, next->context.active, next->context.id);
> >  
> > @@ -227,7 +292,12 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
> >  	id = next_context;
> >  	if (id > last_context)
> >  		id = first_context;
> > -	map = context_map;
> > +
> > +	if (tlb_lazy_flush) {
> > +		recycle_stale_contexts();
> > +		map = context_available_map;
> > +	} else
> > +		map = context_map;
> >  
> >  	/* No more free contexts, let's try to steal one */
> >  	if (nr_free_contexts == 0) {
> > @@ -250,6 +320,13 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
> >  		if (id > last_context)
> >  			id = first_context;
> >  	}
> > +	if (tlb_lazy_flush)
> > +		/*
> > +		 * In the while loop above, we set the bit in
> > +		 * context_available_map, it also needs to be set in
> > +		 * context_map
> > +		 */
> > +		__set_bit(id, context_map);
> >   stolen:
> >  	next_context = id + 1;
> >  	context_mm[id] = next;
> > @@ -267,7 +344,7 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
> >  			    id, cpu_first_thread_in_core(cpu),
> >  			    cpu_last_thread_in_core(cpu));
> >  
> > -		local_flush_tlb_mm(next);
> > +		__local_flush_tlb_mm(next);
> >  
> >  		/* XXX This clear should ultimately be part of local_flush_tlb_mm */
> >  		for (i = cpu_first_thread_in_core(cpu);
> > @@ -317,11 +394,61 @@ void destroy_context(struct mm_struct *mm)
> >  		mm->context.active = 0;
> >  #endif
> >  		context_mm[id] = NULL;
> > -		nr_free_contexts++;
> > +
> > +		if (tlb_lazy_flush)
> > +			nr_stale_contexts++;
> > +		else
> > +			nr_free_contexts++;
> >  	}
> >  	raw_spin_unlock_irqrestore(&context_lock, flags);
> >  }
> 
> Now...
> 
> > +/*
> > + * This is called from flush_tlb_mm().  Mark the current context as stale
> > + * and grab an available one.  The tlb will be flushed when no more
> > + * contexts are available
> > + */
> > +void lazy_flush_context(struct mm_struct *mm)
> > +{
> > +	unsigned int id;
> > +	unsigned long flags;
> > +	unsigned long *map;
> > +
> > +	raw_spin_lock_irqsave(&context_lock, flags);
> > +
> > +	id = mm->context.id;
> > +	if (unlikely(id == MMU_NO_CONTEXT))
> > +		goto no_context;
> 
> First thing is ... you reproduce quite a bit of logic from
> switch_mmu_context() here. Shouldn't it be abstracted in a separate
> function ?

I'm sure there's something I can do there.

> The other thing here is that another CPU might have done a
> recycle_stale_contexts() before you get here. IE. Your TLB may be stale.
> Shouln't you do a flush here ? Since you are picking up a new PID from
> the context_available_map, it can potentially be stale if your tlb needs
> flushing due to another CPU having just done a recycle.

It looks like I missed that.  It does seem that there should be a flush
in here.

> > +	/*
> > +	 * Make the existing context stale.  It remains in
> > +	 * context_available_map as long as nr_free_contexts remains non-zero
> > +	 */
> > +	 __clear_bit(id, context_map);
> > +	 context_mm[id] = NULL;
> > +	 nr_stale_contexts++;
> > +
> > +	recycle_stale_contexts();
> > +	BUG_ON(nr_free_contexts == 0);
> > +
> > +	nr_free_contexts--;
> > +	id = last_context;
> > +	map = context_available_map;
> > +	while (__test_and_set_bit(id, map)) {
> > +		id = find_next_zero_bit(map, last_context+1, id);
> > +		if (id > last_context)
> > +			id = first_context;
> > +	}
> > +	set_bit(id, context_map);
> > +	next_context = id + 1;
> > +	context_mm[id] = mm;
> > +	mm->context.id = id;
> > +	if (current->active_mm == mm)
> > +		set_context(id, mm->pgd);
> > +no_context:
> > +	raw_spin_unlock_irqrestore(&context_lock, flags);
> > +}
> > +
> >  #ifdef CONFIG_SMP
> >  
> >  static int __cpuinit mmu_context_cpu_notify(struct notifier_block *self,
> > @@ -407,6 +534,7 @@ void __init mmu_context_init(void)
> >  	} else if (mmu_has_feature(MMU_FTR_TYPE_47x)) {
> >  		first_context = 1;
> >  		last_context = 65535;
> > +		tlb_lazy_flush = 1;
> >  	} else {
> >  		first_context = 1;
> >  		last_context = 255;
> 
> Somebody should measure on 440, might actually improve perfs. Something
> like a kernel compile sounds like a good test here.

I think I'm going to dust off the newer implementation based on your and
Paul's design.  I can probably get that in good working order without
too much more work, and it's something we need to look at eventually
anyway.  If I find anything that really gets in my way, I might fix up
this patch in the mean time.

Thanks,
Shaggy
-- 
Dave Kleikamp
IBM Linux Technology Center
