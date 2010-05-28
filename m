Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA8ADB7D51
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 17:40:02 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4S7e0oj016521
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 17:40:00 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4S7e16r1585230
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 17:40:01 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4S7e12A028524
	for <linuxppc-dev@ozlabs.org>; Fri, 28 May 2010 17:40:01 +1000
Date: Fri, 28 May 2010 13:09:55 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 2/4] PPC64-HWBKPT: Implement hw-breakpoints for PowerPC
	BookIII S
Message-ID: <20100528073955.GA10509@in.ibm.com>
References: <20100525083055.342788418@linux.vnet.ibm.com>
	<20100525091420.GC29003@in.ibm.com> <20100527061940.GA4105@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100527061940.GA4105@drongo>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 27, 2010 at 04:19:40PM +1000, Paul Mackerras wrote:
> On Tue, May 25, 2010 at 02:44:20PM +0530, K.Prasad wrote:
> 
> > Implement perf-events based hw-breakpoint interfaces for PowerPC Book III S
> > processors. These interfaces help arbitrate requests from various users and
> > schedules them as appropriate.
> 
> A few comments on the code below...
> 

I've posted a new patchset that addresses almost all of your comments.
Please find them here: linuxppc-dev message-id:
20100528063924.GA8679@in.ibm.com

> > +int __kprobes hw_breakpoint_handler(struct die_args *args)
> > +{
> > +	bool is_ptrace_bp = false;
> > +	int rc = NOTIFY_STOP;
> > +	struct perf_event *bp;
> > +	struct pt_regs *regs = args->regs;
> > +	unsigned long dar = regs->dar;
> > +	int stepped = 1;
> > +	struct arch_hw_breakpoint *info;
> > +
> > +	/* Disable breakpoints during exception handling */
> > +	set_dabr(0);
> > +	/*
> > +	 * The counter may be concurrently released but that can only
> > +	 * occur from a call_rcu() path. We can then safely fetch
> > +	 * the breakpoint, use its callback, touch its counter
> > +	 * while we are in an rcu_read_lock() path.
> > +	 */
> > +	rcu_read_lock();
> > +
> > +	bp = __get_cpu_var(bp_per_reg);
> > +	if (!bp)
> > +		goto out;
> > +	info = counter_arch_bp(bp);
> > +	is_ptrace_bp = (bp->overflow_handler == ptrace_triggered) ?
> > +			true : false;
> > +
> > +	/*
> > +	 * Verify if dar lies within the address range occupied by the symbol
> > +	 * being watched to filter extraneous exceptions.
> > +	 */
> > +	if (!((bp->attr.bp_addr <= dar) &&
> > +	    (dar <= (bp->attr.bp_addr + bp->attr.bp_len))) &&
> > +	    (!is_ptrace_bp))
> > +		/*
> > +		 * This exception is triggered not because of a memory access on
> > +		 * the monitored variable but in the double-word address range
> > +		 * in which it is contained. We will consume this exception,
> > +		 * considering it as 'noise'.
> > +		 */
> > +		goto restore_bp;
> 
> At this point we have to do the single-stepping, because the NIP is
> still pointing at the instruction that caused the exception, and if we
> just return to it with DABR set we won't make any progress, we'll just
> take the same exception again immediately.
> 

I don't know how I convinced myself earlier that this would work :-)

Given that the instructions needs to be emulated in the same manner as
others, I've re-used the ptrace_bps[] member in 'thread_struct' as a
flag to indicate such breakpoints. This will be later checked in
single_step_dabr_instruction() to prevent invocation of
perf_event_bp().

> > +/*
> > + * Handle single-step exceptions following a DABR hit.
> > + */
> > +int __kprobes single_step_dabr_instruction(struct die_args *args)
> > +{
> > +	struct pt_regs *regs = args->regs;
> > +	struct perf_event *bp = NULL;
> > +	struct arch_hw_breakpoint *bp_info;
> > +
> > +	bp = current->thread.last_hit_ubp;
> > +	/*
> > +	 * Check if we are single-stepping as a result of a
> > +	 * previous HW Breakpoint exception
> > +	 */
> > +	if (!bp)
> > +		return NOTIFY_DONE;
> > +
> > +	bp_info = counter_arch_bp(bp);
> > +
> > +	/*
> > +	 * We shall invoke the user-defined callback function in the single
> > +	 * stepping handler to confirm to 'trigger-after-execute' semantics
> > +	 */
> > +	perf_bp_event(bp, regs);
> > +
> > +	/*
> > +	 * Do not disable MSR_SE if the process was already in
> > +	 * single-stepping mode.
> > +	 */
> > +	if (!test_thread_flag(TIF_SINGLESTEP))
> > +		regs->msr &= ~MSR_SE;
> > +
> > +	set_dabr(bp_info->address | bp_info->type | DABR_TRANSLATION);
> > +	return NOTIFY_STOP;
> > +}
> 
> Nowhere in here do we reset current->thread.last_hit_ubp, yet other
> parts of the code assume that .last_hit_ubp != NULL means that we are
> currently single-stepping.  I think we need to clear .last_hit_ubp
> here.
> 

True, made the change.

> > Index: linux-2.6.ppc64_test/arch/powerpc/kernel/process.c
> > ===================================================================
> > --- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/process.c
> > +++ linux-2.6.ppc64_test/arch/powerpc/kernel/process.c
> > @@ -462,8 +462,14 @@ struct task_struct *__switch_to(struct t
> >  #ifdef CONFIG_PPC_ADV_DEBUG_REGS
> >  	switch_booke_debug_regs(&new->thread);
> >  #else
> > +/*
> > + * For PPC_BOOK3S_64, we use the hw-breakpoint interfaces that would
> > + * schedule DABR
> > + */
> > +#ifndef CONFIG_HAVE_HW_BREAKPOINT
> >  	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
> >  		set_dabr(new->thread.dabr);
> > +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> >  #endif
> 
> Have you checked all the places that set_dabr is called to see whether
> they are still needed with CONFIG_HAVE_HW_BREAKPOINT?
> 

Yes. All invocations of set_dabr() or their caller functions are enclosed
within #ifdef CONFIG_HAVE_HW_BREAKPOINT.

> > Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
> > ===================================================================
> > --- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/cputable.h
> > +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/cputable.h
> > @@ -516,6 +516,10 @@ static inline int cpu_has_feature(unsign
> >  		& feature);
> >  }
> >  
> > +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> > +#define HBP_NUM 1
> > +#endif /* CONFIG_HAVE_HW_BREAKPOINT */
> 
> Why is this defined here, not in <asm/hw_breakpoint.h> ?
> 

We need HBP_NUM value for arch/powerpc/include/asm/processor.h
and if asm/hw_breakpoint.h is included there, it caused recursive
dependancies. After more discussions with the community (as in
linuxppc-dev: message-id: 20100330101234.GA14734@in.ibm.com) we finally
decided to put it in cputable.h

We will have more related definitions to accompany this when support for
BookIII E is brought in.

Thanks,
K.Prasad
