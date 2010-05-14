Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B7E84B7E7F
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 16:55:41 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp01.au.ibm.com (8.14.3/8.13.1) with ESMTP id o4E6rIU0027584
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 16:53:18 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4E6maCQ1593388
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 16:48:36 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4E6teB9030789
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 16:55:41 +1000
Date: Fri, 14 May 2010 12:25:31 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100514065530.GA6195@in.ibm.com>
References: <20100414033555.746326035@pr> <20100414034827.GC6571@in.ibm.com>
	<20100503062330.GB19365@drongo> <20100504203302.GA3894@in.ibm.com>
	<20100512063247.GC3548@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100512063247.GC3548@drongo>
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

On Wed, May 12, 2010 at 04:32:47PM +1000, Paul Mackerras wrote:
> On Wed, May 05, 2010 at 02:03:03AM +0530, K.Prasad wrote:
> 
> > It is true that the breakpoint exceptions will go amiss following the
> > alignment exception, and be restored when the thread single-steps due
> > to other requests causing undesirable effects. (Borrowing from some of
> > the discussions I had with BenH, earlier) There can be two ways of
> > changing the implementation to counter it:
> > 
> > - To sense that the impending exception (alignment, page-fault,
> >   single-step) is a successor to a hw-breakpoint exception (and that
> >   restoration of debug register values is necessary), somewhere early in
> >   exceptions-64s.S and jump to a common handler, say
> >   do_single_step_dabr() which does a majority of
> >   single_step_dabr_instruction().
> > - To modify emulate_single_step() to also do a notify_die(DIE_SSTEP,...)
> >   in addition to its existing code. This would invoke
> >   single_step_dabr_instruction() where the breakpoints can be restored.
> 
> I thought you would change the explicit regs->msr modification in
> single_step_exception() to clear_single_step(), then just make
> emulate_single_step() call single_step_exception().
>

Okay. I will re-use single_step_exception() after modifications; it
appearsto have no in-kernel users for it. (single_step_exception() clears
MSR more than what clear_single_step() does, it shouldn't matter though).

> > I must admit that it is not clear to me when you say "doesn't return to
> > the instruction" and "instruction has been changed underneath". Are you
> 
> Suppose the address at which the data breakpoint has been unmapped,
> and the process has a handler for the SIGSEGV signal.  When we try to
> single-step the load or store, we will get a DSI (0x300) interrupt,
> call into do_page_fault, and end up sending the process a SIGSEGV.
> That will invoke the signal handler, which can then do anything it
> likes.  It can do a blocking system call, it can longjmp() back into
> its main event, or it can return from the signal handler.  Only in the
> last case will it retry the load or store, and then only if the signal
> handler hasn't modified the NIP value in the signal frame.  That's
> what I mean by "doesn't return to the instruction".
> 

At the outset, this seemed to be a scary thing to happen; but turns out
to be harmful only to the extent of generating a false hw-breakpoint
exception in certain cases. A case-by-case basis analysis reveals thus:

Consider an instruction stream i1, i2, i3, ... iN, where i1 has
finished execution and i2 is about to be executed but has generated a
DSI interrupt with the above-mentioned conditions i.e. DSISR indicates a
DABR match + Page-Table entry not found. Now according to do_hash_page
in exception-64s.S (as pasted below), do_page_fault() and do_dabr() are
invoked one after the other.

_STATIC(do_hash_page)
	std	r3,_DAR(r1)
	std	r4,_DSISR(r1)

	andis.	r0,r4,0xa410		/* weird error? */
	bne-	handle_page_fault	/* if not, try to insert a HPTE */
	andis.  r0,r4,DSISR_DABRMATCH@h
	bne-    handle_dabr_fault

Thus, when control returns to user-space to instruction 'i2', the
hw_breakpoint_handler() has completed execution, and a SIGSEGV is pending
to be delivered and single-stepping enabled MSR_SE is set. Upon return to
user-space, the handler for SIGSEGV is executed and it may perform one of
the following (as you stated previously):
(a) Make a blocking syscall, eventually yielding the CPU to a new thread
(b) Jump to a different instruction in user-space, say iN, and not complete
the execution of instruction i2 at all.
(c) Return to instruction i2 and complete the execution.

In case of (a), the context-switches should not affect the ability to
single-step the instruction when the thread is eventually scheduled to
run. The thread, when scheduled onto the CPU will complete signal
handling, return to execute instruction i2, cause single-step exception,
restore breakpoints and run smoothly thereafter.

In case of (b), the new instruction iN is single-stepped, the breakpoint
values are restored and the hw-breakpoint exception callback is invoked
after iN is executed. The user of this breakpoint i.e. the caller of
register_user_hw_breakpoint() who had placed a breakpoint on addressed
accessed by instruction i2 will be confused to find that an unrelated
instruction (which may not be a load/store) has caused the breakpoint.

If so desired, we may adopt the 'trigger-before-execute' semantics for
user-space breakpoints wherein the hw-breakpoint callback (through
perf_bp_event()) is invoked in hw_breakpoint_handler() itself. This
would indicate to the user that the impending instruction causes a DABR
'hit' but it may or may not be executed due to the role of
signal-handler or due to self-modifying code (as mentioned below).

Kindly let me know what you think about it.

(c) is the normal execution path we desire. The instruction i2 will be
safely single-stepped and breakpoints are restored.

> The instruction could be changed underneath us if the program is
> multi-threaded and another thread writes another instruction to the
> instruction word where the load or store is.  Or it could use mmap()
> to map some other page at the address of the load or store.  Either
> way we could end up with a different instruction there.
> 

If the instruction that originally caused the DABR exception is changed,
the new instruction in its place would still single-step to restore
breakpoint values. However the user of breakpoint interface will be
confused to find that the callback is invoked for an irrelevant
instruction.

It could be circumvented, to an extent, through the use of
trigger-before-execute semantics (as described before).

> > referring to the fact that the thread which generated breakpoints hits
> > could have moved out of the CPU due to a scheduler induced context
> > switch (which is an apparent cause for current->thread.last_hit_ubp to
> > turn stale) or is there a different source for such a change that I
> > don't realise?
> > 
> > Given that 'last_hit_ubp' is safely ensconced inside 'thread_struct',
> > the ill-effects of a possible pre-emption during a page-fault will be
> > suitably handled i.e. the pending single-step exception will be
> > generated on the processor to which 'current' is migrated to, and the
> > breakpoint will be set on the new processor.
> 
> If we do get a context switch, e.g. as a result of a page fault, and
> then switch back to the task, it looks to me like we will end up with
> MSR_SE and DABR both set.  I don't suppose that will actually cause
> any real problem besides double-counting the hit.
> 

Page fault exception will be handled before hw_breakpoint_handler(),
hence MSR_SE would not have been set if a context-switch happened in
pange-fault handling itself. I don't see a case where both MSR_SE and
DABR will be set together.

> > However, the possibility that current->thread.last_hit_ubp points to a
> > perf_event structure that is unregistered and freed does exist, and I
> > did not foresee the risk. An arch-specific function that hooks onto
> > release_bp_slot() would be required to perform the cleanup. I will
> > submit modify the patch to that effect. Thanks for pointing it out.
> 
> Yes, I think we need that.
> 

The same is implemented through arch_unregister_hw_breakpoint()
in version XVIII of the patch here: linuxppc-dev message-id:
20100512033315.GC6384@in.ibm.com.

> > In conjunction with what you've stated below, do you suggest that
> > emulate_step() be replaced with fix_alignment() which appears to be more
> > powerful at emulation (or carve out a helper function for fix_alignment()
> > that does only emulation and which can be invoked here)?
> 
> Something like that eventually, but not for a first pass.
> 
> Paul.

Thanks for the comments. Let me know if the analysis above is incorrect
or if I've failed to recognise any important issue that you pointed out.
I will send out a patch with changes to emulate_single_step() in the
next version of the patchset, if I don't hear any further comments.

Thanks,
K.Prasad
