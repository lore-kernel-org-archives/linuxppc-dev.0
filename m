Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] ppc: lazy flush_tlb_mm for nohash architectures
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
In-Reply-To: <1287439021.3700.22.camel@shaggy-w500>
References: <1285351297-9999-1-git-send-email-shaggy@linux.vnet.ibm.com>
	<1285351297-9999-3-git-send-email-shaggy@linux.vnet.ibm.com>
	<1287017539.2205.48.camel@pasglop>
	<1287439021.3700.22.camel@shaggy-w500>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Oct 2010 10:34:51 +1100
Message-ID: <1287444891.2341.42.camel@pasglop>
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

On Mon, 2010-10-18 at 16:57 -0500, Dave Kleikamp wrote:
> 
> I didn't like the implementation of a per-core stale map.  The existing
> implementation flushes the core's tlb, but only clears a specific entry
> from the stale map.  It's dealing with the stale contexts one at a time,
> where the new function is accumulating many stale contexts, with the
> intent to do a single tlb flush per core.

Right, because I wrote it with A2 in mind which has a TLB invalidate by
PID instruction :-) So I don't flush the whole TLB there... but then
this instruction can take hundreds (or more) of cycles so it might not
necessarily be that great anyways...

> Since I originally intended the new function only to be enabled on the
> 47x, I left the context-stealing code as untouched as possible thinking
> it wouldn't be exercised in 47x-land.  This was probably narrow-minded,
> and I should look at either 1) aligning the context-stealing code closer
> to the new lazy flush code, or 2) dropping this code on the floor and
> picking back up the new design that we worked on last year.

In any case, we can probably merge you current stuff upstream (with
appropriate bug fixes if necessary) for now and move from there.

> > At the very least, the "old style" stale map code and "new style" stale
> > TLB code should be more in sync, you may end up flushing the TLB
> > twice...
> 
> yeah.  if we enable this for 440, it is more likely to be an issue than
> on 476.

Right.

> > >  void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
> > >  {
> > >     unsigned int i, id, cpu = smp_processor_id();
> > > @@ -197,6 +260,8 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
> > >     /* No lockless fast path .. yet */
> > >     raw_spin_lock(&context_lock);
> > >  
> > > +   flush_recycled_contexts(cpu);
> > > +
> > 
> > Ok so here's the nasty one I think. You need to make sure that whenever
> > you pick something off the context_available_map, you've done the above
> > first within the same context_lock section right ? At least before you
> > actually -use- said context.
> 
> right.
> 
> > So far so good ... but steal_context can drop the lock iirc. So you may
> > need to re-flush there. Not sure that can happen in practice but better
> > safe than sorry. I would have preferred seeing that flush near the end
> > of the function to avoid such problem.
> 
> I can fix this.  For 476, I don't think that even if steal_context()
> could be called, it wouldn't drop the lock.  But then again, if we
> enable this for other architectures, it may be a possibility.

Yeah, it's a minor issue but I'd rather get the code right to avoid
surprises later.

 .../...

> > Now...
> > 
> > > +/*
> > > + * This is called from flush_tlb_mm().  Mark the current context as stale
> > > + * and grab an available one.  The tlb will be flushed when no more
> > > + * contexts are available
> > > + */
> > > +void lazy_flush_context(struct mm_struct *mm)
> > > +{
> > > +   unsigned int id;
> > > +   unsigned long flags;
> > > +   unsigned long *map;
> > > +
> > > +   raw_spin_lock_irqsave(&context_lock, flags);
> > > +
> > > +   id = mm->context.id;
> > > +   if (unlikely(id == MMU_NO_CONTEXT))
> > > +           goto no_context;
> > 
> > First thing is ... you reproduce quite a bit of logic from
> > switch_mmu_context() here. Shouldn't it be abstracted in a separate
> > function ?
> 
> I'm sure there's something I can do there.
> 
> > The other thing here is that another CPU might have done a
> > recycle_stale_contexts() before you get here. IE. Your TLB may be stale.
> > Shouln't you do a flush here ? Since you are picking up a new PID from
> > the context_available_map, it can potentially be stale if your tlb needs
> > flushing due to another CPU having just done a recycle.
> 
> It looks like I missed that.  It does seem that there should be a flush
> in here.

Ok, so It wasn't just shit in my eyes :-)

> I think I'm going to dust off the newer implementation based on your and
> Paul's design.  I can probably get that in good working order without
> too much more work, and it's something we need to look at eventually
> anyway.  If I find anything that really gets in my way, I might fix up
> this patch in the mean time.

As you like. As I said earlier, I'm happy to merge a fixed version of
this one first if you think it's going to take a while to get the other
one right. However, I believe this is too late for the next merge window
anyways so that gives you some time ahead to play and make a decision.

Cheers,
Ben.
