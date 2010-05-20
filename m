Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D783AB7D40
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 14:06:14 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp08.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4K46BIR032572
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 14:06:11 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4K3wtT71318972
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 13:58:56 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4K46BMi023482
	for <linuxppc-dev@ozlabs.org>; Thu, 20 May 2010 14:06:12 +1000
Date: Thu, 20 May 2010 09:36:03 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100520040603.GA7448@in.ibm.com>
References: <20100414033555.746326035@pr> <20100414034827.GC6571@in.ibm.com>
	<20100503062330.GB19365@drongo> <20100504203302.GA3894@in.ibm.com>
	<20100512063247.GC3548@drongo> <20100514065530.GA6195@in.ibm.com>
	<20100517123241.GA5379@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100517123241.GA5379@brick.ozlabs.ibm.com>
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

On Mon, May 17, 2010 at 10:32:41PM +1000, Paul Mackerras wrote:
> On Fri, May 14, 2010 at 12:25:31PM +0530, K.Prasad wrote:
> 
> > Okay. I will re-use single_step_exception() after modifications; it
> > appearsto have no in-kernel users for it.
> 
> It's called from exceptions-64s.S, head_32.S and head_8xx.S in
> arch/powerpc/kernel.
> 
> > > Suppose the address at which the data breakpoint has been unmapped,
> > > and the process has a handler for the SIGSEGV signal.  When we try to
> > > single-step the load or store, we will get a DSI (0x300) interrupt,
> > > call into do_page_fault, and end up sending the process a SIGSEGV.
> > > That will invoke the signal handler, which can then do anything it
> > > likes.  It can do a blocking system call, it can longjmp() back into
> > > its main event, or it can return from the signal handler.  Only in the
> > > last case will it retry the load or store, and then only if the signal
> > > handler hasn't modified the NIP value in the signal frame.  That's
> > > what I mean by "doesn't return to the instruction".
> > > 
> > 
> > At the outset, this seemed to be a scary thing to happen; but turns out
> > to be harmful only to the extent of generating a false hw-breakpoint
> > exception in certain cases. A case-by-case basis analysis reveals thus:
> > 
> > Consider an instruction stream i1, i2, i3, ... iN, where i1 has
> > finished execution and i2 is about to be executed but has generated a
> > DSI interrupt with the above-mentioned conditions i.e. DSISR indicates a
> > DABR match + Page-Table entry not found. Now according to do_hash_page
> > in exception-64s.S (as pasted below), do_page_fault() and do_dabr() are
> > invoked one after the other.
> > 
> > _STATIC(do_hash_page)
> > 	std	r3,_DAR(r1)
> > 	std	r4,_DSISR(r1)
> > 
> > 	andis.	r0,r4,0xa410		/* weird error? */
> > 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
> > 	andis.  r0,r4,DSISR_DABRMATCH@h
> > 	bne-    handle_dabr_fault
> 
> Note that bne is not a procedure call; we'll actually get two DSIs in
> this scenario.  But I don't think that matters.  Also note that the
> branch to handle_page_fault here is not for the HPTE-not-found case;
> it's for the unusual errors.  So we'll handle the HPTE insertion after
> handling the DABR match.
> 

Okay.

> > Thus, when control returns to user-space to instruction 'i2', the
> > hw_breakpoint_handler() has completed execution, and a SIGSEGV is pending
> > to be delivered and single-stepping enabled MSR_SE is set. Upon return to
> > user-space, the handler for SIGSEGV is executed and it may perform one of
> > the following (as you stated previously):
> > (a) Make a blocking syscall, eventually yielding the CPU to a new thread
> > (b) Jump to a different instruction in user-space, say iN, and not complete
> > the execution of instruction i2 at all.
> > (c) Return to instruction i2 and complete the execution.
> > 
> > In case of (a), the context-switches should not affect the ability to
> > single-step the instruction when the thread is eventually scheduled to
> > run. The thread, when scheduled onto the CPU will complete signal
> > handling, return to execute instruction i2, cause single-step exception,
> > restore breakpoints and run smoothly thereafter.
> 
> Right.  However, the thread is running the signal handler without the
> DABR being set, which is unfortunate.
> 

In order to keep the breakpoint active during signal handling, a
PowerPC specific signal handling code, say do_signal_pending() in
arch/powerpc/kernel/signal.c, must be tapped to check for/restore
the breakpoint for the process (if it exists).

Then, single_step_dabr_instruction() must be suitably modified to not
clear the current->thread.last_hit_ubp pointer if breakpoint has been
taken in a nested condition i.e. a breakpoint exception in signal-handler
which was preceded by a previous breakpoint exception in normal user-space
stack. A flag to denote such a condition would be required in
'struct thread_struct'.

I'm afraid if this is more complexity than we want to handle in the
first patchset. I agree that this will create a 'blind-spot' of code
which cannot not be monitored using breakpoints and may limit debugging
efforts (specially for memory corruption); however suspecting that signal
handlers (especially those that don't return to original instruction)
would be rare, I feel that this could be a 'feature' that can be brought
later-in. What do you think?

> > In case of (b), the new instruction iN is single-stepped, the breakpoint
> > values are restored and the hw-breakpoint exception callback is invoked
> > after iN is executed. The user of this breakpoint i.e. the caller of
> > register_user_hw_breakpoint() who had placed a breakpoint on addressed
> > accessed by instruction i2 will be confused to find that an unrelated
> > instruction (which may not be a load/store) has caused the breakpoint.
> 
> That's the case if the signal handler modifies the NIP value in the
> register set saved on the stack and returns.  If the signal handler
> instead simply jumps to instruction iN (e.g. with longjmp or
> siglongjmp), we'll never get the single-step callback.
> 

True. As described above, this will lead to unreliable restoration of
breakpoints. I'm not sure if this is a common occurrence in user-space,
but if rare, I think we should be able to tolerate this behaviour for now.

> > If so desired, we may adopt the 'trigger-before-execute' semantics for
> > user-space breakpoints wherein the hw-breakpoint callback (through
> > perf_bp_event()) is invoked in hw_breakpoint_handler() itself. This
> > would indicate to the user that the impending instruction causes a DABR
> > 'hit' but it may or may not be executed due to the role of
> > signal-handler or due to self-modifying code (as mentioned below).
> > 
> > Kindly let me know what you think about it.
> > 
> > (c) is the normal execution path we desire. The instruction i2 will be
> > safely single-stepped and breakpoints are restored.
> > 
> > > The instruction could be changed underneath us if the program is
> > > multi-threaded and another thread writes another instruction to the
> > > instruction word where the load or store is.  Or it could use mmap()
> > > to map some other page at the address of the load or store.  Either
> > > way we could end up with a different instruction there.
> > > 
> > 
> > If the instruction that originally caused the DABR exception is changed,
> > the new instruction in its place would still single-step to restore
> > breakpoint values. However the user of breakpoint interface will be
> > confused to find that the callback is invoked for an irrelevant
> > instruction.
> > 
> > It could be circumvented, to an extent, through the use of
> > trigger-before-execute semantics (as described before).
> 
> I don't think we want to do trigger-before-execute.  Ideally what we
> want to ensure at all times is that either DABR is set (enabled) or
> MSR.SE is set, but not both.  To ensure that we'd have to modify the
> signal delivery code and possibly other places.
> 

The case where both DABR and MSR_SE are set is when a page-fault
resulting in context-switch occurs before single-stepping, right? I have
responded to that below. The problem with signal-handling, as I
understand, is unreliable restoration of/lost breakpoints and I wish to
deal them in future patchsets. Let me know if my understanding is incorrect.

> > > If we do get a context switch, e.g. as a result of a page fault, and
> > > then switch back to the task, it looks to me like we will end up with
> > > MSR_SE and DABR both set.  I don't suppose that will actually cause
> > > any real problem besides double-counting the hit.
> > > 
> > 
> > Page fault exception will be handled before hw_breakpoint_handler(),
> > hence MSR_SE would not have been set if a context-switch happened in
> > pange-fault handling itself. I don't see a case where both MSR_SE and
> > DABR will be set together.
> 
> Imagine this scenario: we get the DABR match, set MSR_SE and return to
> the task.  In the meantime another higher-priority task has become
> runnable and our need_resched flag is set, so we call schedule() on
> the way back out to usermode.  The other task runs and then blocks and
> our task gets scheduled again.  As part of the context switch,
> arch_install_hw_breakpoint() will get called and will set DABR.  So
> we'll return to usermode with both DABR and MSE_SE set.
> 

I didn't foresee such a possibility. I think this can be handled by
putting a check in arch_install_hw_breakpoint() as shown below:

int arch_install_hw_breakpoint(struct perf_event *bp)
{
	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
	struct perf_event **slot = &__get_cpu_var(bp_per_reg);

	*slot = bp;
	if (!current->thread.last_hit_ubp)
		set_dabr(info->address | info->type | DABR_TRANSLATION);
	return 0;
}

This should prevent DABR and MSR_SE from being enabled at the same time.

> > Thanks for the comments. Let me know if the analysis above is incorrect
> > or if I've failed to recognise any important issue that you pointed out.
> > I will send out a patch with changes to emulate_single_step() in the
> > next version of the patchset, if I don't hear any further comments.
> 
> We haven't discussed at all the case where the breakpoint is a per-cpu
> breakpoint or where it's a per-task breakpoint but the DABR match
> occurs within the kernel -- which can happen, even for a user address,
> in __get_user, __put_user, __copy_tofrom_user, etc.  If the access
> there is to a bad address, we'll invoke the exception case in
> bad_page_fault(), which looks to be another place where we need to
> recognize that single-stepping won't succeed and reinstall the DABR
> setting.  Do we count that as an event or not? - I'm not sure.
>

I'll respond to this part in the subsequent mail.

Thanks,
K.Prasad
