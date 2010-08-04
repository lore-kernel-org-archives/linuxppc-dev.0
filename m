Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9DD0EB70D6
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Aug 2010 07:45:49 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o74LcWjv030231
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 15:38:32 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o74Lje8X247476
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 15:45:41 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o74Ln0Tg014236
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Aug 2010 15:49:01 -0600
Subject: Re: [RT,RFC] Hacks allowing -rt to run on POWER7 / Powerpc.
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
In-Reply-To: <1278834594_17749@mail4.comsite.net>
References: <1278701701.24737.19.camel@lexx>
	<1278834594_17749@mail4.comsite.net>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 Aug 2010 16:45:34 -0500
Message-ID: <1280958334.4034.187.camel@lexx>
Mime-Version: 1.0
Cc: Darren Hart <dvhltc@us.ibm.com>, rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Thomas Gleixner <tglx@linutronix.de>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2010-07-11 at 02:49 -0500, Milton Miller wrote:
> On Fri, 09 Jul 2010 about 08:55:01 -0000, Will Schmidt wrote:
> > We've been seeing some issues with userspace randomly SIGSEGV'ing while
> > running the -RT kernels on POWER7 based systems.   After lots of
> > debugging, head scratching, and experimental changes to the code, the
> > problem has been narrowed down such that we can avoid the problems by
> > disabling the TLB batching.
> > 
> > After some input from Ben and further debug, we've found that the
> > restoration of the batch->active value near the end of __switch_to()
> > seems to be the key.    ( The -RT related  changes within
> > arch/powerpc/kernel/processor.c __switch_to()  do the equivalent of a
> > arch_leave_lazy_mmu_mode() before calling _switch, use a hadbatch flag
> > to indicate if batching was active, and then restore that batch->active
> > value on the way out after the call to _switch_to.    That particular
> > code is in the -RT branch, and not found in mainline  )
> > 
> > Deferring to Ben (or others in the know) for whether this is the proper
> > solution or if there is something deeper, but.. 

I believe this is still on Ben's list of things to look at.   Between
then and now, I'll see if I can get Thomas to pick this up for the -RT
tree to keep RT functional on P7 in the mean-time.  

A bit more debug info below.

> 
> 
> I looked at the patch and noticed 2 changes:
> 	1) the batch is checked and cleared after local_irq_save
> 	2) enabling the batch is skipped
> 
> I talked to Will and had him try moving the local_irq_save above the
> check for the active batch.  That alone did not seem to be enough.
> However, he confirmed that we are setting batch to active when it is
> already active in lazy_mmu_enter, meaning that batching is being turned
> on recursively.  I suggested debug to check that irqs are off after the
> restore when re-enabling when our debug session timed out.

Based on some of the debug suggestions from Milton:


A WARN_ON for (!irqs_disabled) after local_irq_restore() did not show
any hits.  (while otherwise continuing to suffer from the tlb batching
troubles). 

---><----

	hard_irq_disable();
	last = _switch(old_thread, new_thread);

	local_irq_restore(flags);

	WARN_ON(!irqs_disabled());        <<<<----------


#if defined(CONFIG_PPC64) && defined(CONFIG_PREEMPT_RT) && 1
	if (hadbatch) {
		batch = &__get_cpu_var(ppc64_tlb_batch);
		batch->active = 1;
	}
#endif

----><---- 


Another assortment of WARN_ONs in the arch_{enter,leave}_lazy_mmu_mode
functions.  As Milton stated above, the check for batch->active on the
way into the arch_enter_* function did generate lots of hits, the other
warn_ons did not.

-----><-------
static inline void arch_enter_lazy_mmu_mode(void)
{
	struct ppc64_tlb_batch *batch = &get_cpu_var(ppc64_tlb_batch);

//|-----WARN_ON(batch->active);     /* lots of hits if enabled */
|-------WARN_ON(irqs_disabled());     /* nothing.... */
|-------batch->active = 1;

....


static inline void arch_leave_lazy_mmu_mode(void)
{
|-------struct ppc64_tlb_batch *batch = &get_cpu_var(ppc64_tlb_batch);

|-------WARN_ON(!batch->active);    /* nothing.....*/
|-------WARN_ON(irqs_disabled());    /* nothing.... */

....



> 
> milton
> 
> > 
> > diff -aurp linux-2.6.33.5-rt23.orig/arch/powerpc/kernel/process.c linux-2.6.33.5-rt23.exp/arch/powerpc/kernel/process.c
> > --- linux-2.6.33.5-rt23.orig/arch/powerpc/kernel/process.c	2010-06-21 11:41:34.402513904 -0500
> > +++ linux-2.6.33.5-rt23.exp/arch/powerpc/kernel/process.c	2010-07-09 13:15:13.533269904 -0500
> > @@ -304,10 +304,6 @@ struct task_struct *__switch_to(struct t
> >  	struct thread_struct *new_thread, *old_thread;
> >  	unsigned long flags;
> >  	struct task_struct *last;
> > -#if defined(CONFIG_PPC64) && defined (CONFIG_PREEMPT_RT)
> > -	struct ppc64_tlb_batch *batch;
> > -	int hadbatch;
> > -#endif
> >  
> >  #ifdef CONFIG_SMP
> >  	/* avoid complexity of lazy save/restore of fpu
> > @@ -401,16 +397,6 @@ struct task_struct *__switch_to(struct t
> >  		new_thread->start_tb = current_tb;
> >  	}
> >  
> > -#ifdef CONFIG_PREEMPT_RT
> > -	batch = &__get_cpu_var(ppc64_tlb_batch);
> > -	if (batch->active) {
> > -		hadbatch = 1;
> > -		if (batch->index) {
> > -			__flush_tlb_pending(batch);
> > -		}
> > -		batch->active = 0;
> > -	}
> > -#endif /* #ifdef CONFIG_PREEMPT_RT */
> >  #endif
> >  
> >  	local_irq_save(flags);
> > @@ -425,16 +411,13 @@ struct task_struct *__switch_to(struct t
> >  	 * of sync. Hard disable here.
> >  	 */
> >  	hard_irq_disable();
> > -	last = _switch(old_thread, new_thread);
> > -
> > -	local_irq_restore(flags);
> >  
> >  #if defined(CONFIG_PPC64) && defined(CONFIG_PREEMPT_RT)
> > -	if (hadbatch) {
> > -		batch = &__get_cpu_var(ppc64_tlb_batch);
> > -		batch->active = 1;
> > -	}
> > +	arch_leave_lazy_mmu_mode();
> >  #endif
> > +	last = _switch(old_thread, new_thread);
> > +
> > +	local_irq_restore(flags);
> >  
> >  	return last;
> >  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
