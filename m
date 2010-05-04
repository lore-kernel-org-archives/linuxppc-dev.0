Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 473F6B7D28
	for <linuxppc-dev@ozlabs.org>; Wed,  5 May 2010 06:33:14 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id o44KTrm7002864
	for <linuxppc-dev@ozlabs.org>; Wed, 5 May 2010 06:29:53 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o44KQKsU1749140
	for <linuxppc-dev@ozlabs.org>; Wed, 5 May 2010 06:26:20 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o44KXC2Z020793
	for <linuxppc-dev@ozlabs.org>; Wed, 5 May 2010 06:33:13 +1000
Date: Wed, 5 May 2010 02:03:03 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100504203302.GA3894@in.ibm.com>
References: <20100414033555.746326035@pr> <20100414034827.GC6571@in.ibm.com>
	<20100503062330.GB19365@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100503062330.GB19365@drongo>
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

On Mon, May 03, 2010 at 04:23:30PM +1000, Paul Mackerras wrote:
> On Wed, Apr 14, 2010 at 09:18:27AM +0530, K.Prasad wrote:
> 
> > Implement perf-events based hw-breakpoint interfaces for PPC64 processors.
> > These interfaces help arbitrate requests from various users and schedules
> > them as appropriate.
> 
> [snip]
> 

Hi Paul,
	Thanks for the detailed review. Please find my replies inline.

> > --- /dev/null
> > +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
> > @@ -0,0 +1,45 @@
> > +#ifndef _PPC_BOOK3S_64_HW_BREAKPOINT_H
> > +#define _PPC_BOOK3S_64_HW_BREAKPOINT_H
> > +
> > +#ifdef	__KERNEL__
> > +#define	__ARCH_HW_BREAKPOINT_H
> 
> This symbol doesn't seem to be referenced anywhere.  Is it really
> necessary to define it?  I know x86 and sh do, but maybe it's a
> leftover there.
> 

Yes, either I use _PPC_BOOK3S_64_HW_BREAKPOINT_H or
__ARCH_HW_BREAKPOINT_H to prevent recursive definitions, not both. I will
remove __ARCH_HW_BREAKPOINT_H.

> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c
> 
> > +	switch (bp->attr.bp_type) {
> > +	case HW_BREAKPOINT_R:
> > +		info->type = DABR_DATA_READ;
> > +		break;
> > +	case HW_BREAKPOINT_W:
> > +		info->type = DABR_DATA_WRITE;
> > +		break;
> > +	case HW_BREAKPOINT_R | HW_BREAKPOINT_W:
> > +		info->type = (DABR_DATA_READ | DABR_DATA_WRITE);
> > +		break;
> > +	default:
> > +		return ret;
> > +	}
> 
> You have code like this in several places -- maybe this should be
> encapsulated in a helper function.  Also, I think it could be written
> more compactly.
> 

Actually this particular code-snippet differs slightly from two such
'similar' switch-cases found in ptrace_set_debugreg() - which I will
replace with a helper function. The above-cited switch-case statement
which maps the generic breakpoint types to arch-specific bit-encodings
are used only once (as above) and will not help code-reduction if moved
to a separate function.

> > +	/*
> > +	 * Return early after invoking user-callback function without restoring
> > +	 * DABR if the breakpoint is from ptrace which always operates in
> > +	 * one-shot mode
> > +	 */
> > +	if (is_ptrace_bp == true) {
> > +		perf_bp_event(bp, regs);
> > +		rc = NOTIFY_DONE;
> > +		goto out;
> > +	}
> 
> As far as I can see, returning NOTIFY_DONE won't tell do_dabr() that
> you have handled the exception, and it will go on to do the
> debugger_dabr_match() call and generate a signal to the current
> process.  Is that what you want?  If so a comment would be useful.
> 

Yes, the debugger_dabr_match() will return early without doing much and
the signal is generated for the ptrace-ed process. I will append the
comment to appear as below:

	/*
	 * Return early after invoking user-callback function without restoring
	 * DABR if the breakpoint is from ptrace which always operates in
	 * one-shot mode. The ptrace-ed process will receive the SIGTRAP signal
	 * generated in do_dabr().
	 */

> Also, the " == true" part is completely redundant.  Normal kernel
> style would be if (is_ptrace_bp) { ..., and similarly the
> (is_ptrace_bp == false) above should be !is_ptrace_bp.
>

It is an untidy habit that I've had, personally, for
increased readability! I will remove such redundancies from the code.

> > +
> > +	/*
> > +	 * Do not emulate user-space instructions from kernel-space,
> > +	 * instead single-step them.
> > +	 */
> > +	if (is_kernel == false) {
> > +		current->thread.last_hit_ubp = bp;
> > +		regs->msr |= MSR_SE;
> > +		goto out;
> > +	}
> 
> I'm a bit worried about what could happen from here on.  We go back
> out to userspace and try to execute the load or store.  Besides
> executing successfully and taking the trace interrupt, there are
> several other possibilities:
>

The aim, during design time, has been to reliably restore the breakpoint
values immediately after execution of the instruction or in the
worst-case, to cause loss of breakpoints rather than ignore the other
sources of exceptions. Please find more responses below.
 
> - we could get an alignment interrupt
> - we could get a page fault (page not present or protection violation)
> - we could get a MMU hash table miss (unlikely since the low-level
>   code calls hash_page before do_dabr, but possible since the HPTE
>   could in principle have been evicted in the meantime).
> - we could even get an illegal or privileged instruction trap --
>   if some other thread had changed the instruction in the meantime.
> 
> The alignment interrupt case is mostly OK, except that it will call
> emulate_single_step after emulating the load or store, which doesn't
> do quite what we want -- unlike single_step_exception(), it doesn't
> call notify_die(), so we won't get back into
> single_step_dabr_instruction(), but instead it just sends a SIGTRAP.
> That needs to be fixed, but note that single_step_exception() only
> applies to "classic"/server processors at present because it hits the
> MSR SE and BE bits directly rather than using clear_single_step().
> 

It is true that the breakpoint exceptions will go amiss following the
alignment exception, and be restored when the thread single-steps due
to other requests causing undesirable effects. (Borrowing from some of
the discussions I had with BenH, earlier) There can be two ways of
changing the implementation to counter it:

- To sense that the impending exception (alignment, page-fault,
  single-step) is a successor to a hw-breakpoint exception (and that
  restoration of debug register values is necessary), somewhere early in
  exceptions-64s.S and jump to a common handler, say
  do_single_step_dabr() which does a majority of
  single_step_dabr_instruction().
- To modify emulate_single_step() to also do a notify_die(DIE_SSTEP,...)
  in addition to its existing code. This would invoke
  single_step_dabr_instruction() where the breakpoints can be restored.

I would prefer the second method, given that it would be easier to implement.

> The MMU hash table miss case looks to be OK -- we'll just return to
> userspace and re-execute the instruction, with MSR[SE] still set.
> 
> The page fault case should be OK if it just results in inserting a PTE
> (possibly after some context switches) or in the process being
> terminated.  If, however, it results in a signal we could end up with
> a stale value in current->thread.last_hit_ubp if the signal handler
> doesn't return to the instruction (and there is no requirement for it
> to do so).  If the process later gets single-stepped for any reason it
> could get misinterpreted, and we could end up accessing freed memory
> if the perf_event associated with bp has been closed and freed in the
> meantime.
> 
> Similarly, if the instruction has been changed underneath us, we would
> end up with current->thread.last_hit_ubp being stale.  We do need to
> handle this case if only to ensure that we don't create a
> vulnerability that could be used to attack the kernel.
> 

I must admit that it is not clear to me when you say "doesn't return to
the instruction" and "instruction has been changed underneath". Are you
referring to the fact that the thread which generated breakpoints hits
could have moved out of the CPU due to a scheduler induced context
switch (which is an apparent cause for current->thread.last_hit_ubp to
turn stale) or is there a different source for such a change that I
don't realise?

Given that 'last_hit_ubp' is safely ensconced inside 'thread_struct',
the ill-effects of a possible pre-emption during a page-fault will be
suitably handled i.e. the pending single-step exception will be
generated on the processor to which 'current' is migrated to, and the
breakpoint will be set on the new processor.

However, the possibility that current->thread.last_hit_ubp points to a
perf_event structure that is unregistered and freed does exist, and I
did not foresee the risk. An arch-specific function that hooks onto
release_bp_slot() would be required to perform the cleanup. I will
submit modify the patch to that effect. Thanks for pointing it out.

> > +
> > +	stepped = emulate_step(regs, regs->nip);
> > +	/* emulate_step() could not execute it, single-step them */
> 
> Note that at present, emulate_step() will never emulate a load or
> store, so this will always return 0 unless someone has changed the
> instruction underneath us.
> 

In conjunction with what you've stated below, do you suggest that
emulate_step() be replaced with fix_alignment() which appears to be more
powerful at emulation (or carve out a helper function for fix_alignment()
that does only emulation and which can be invoked here)?

> > +	if (stepped == 0) {
> > +		regs->msr |= MSR_SE;
> > +		per_cpu(last_hit_bp, cpu) = bp;
> > +		goto out;
> > +	}
> 
> This is subject to most of the same possibilities as the user address
> case.  We need to make sure that if we ever get the situation where
> the instruction is never going to be executed then we clear
> last_hit_bp for this cpu.  By the way, __get_cpu_var(x) is more
> efficient than per_cpu(x, cpu) and is equivalent if cpu ==
> smp_processor_id().
> 

The possible kernel vulnerabilities (you mentioned above) can be
mitigated, by clearing 'last_hit_bp' upon unregistration of the
breakpoint request (through a hook in release_bp_slot()). However I'd
prefer to defer code that would increase the reliability of
hw-breakpoint restoration (upon a hit) to future patches.

Also since cpu == smp_processor_id() here, I'll use __get_cpu_var(x).

> > +	/*
> > +	 * Do not disable MSR_SE if the process was already in
> > +	 * single-stepping mode. We cannot reliable detect single-step mode
> > +	 * for kernel-space breakpoints, so this cannot work along with other
> > +	 * debuggers (like KGDB, xmon) which may be single-stepping kernel code.
> > +	 */
> > +	if (!(user_bp && test_thread_flag(TIF_SINGLESTEP)))
> > +		regs->msr &= ~MSR_SE;
> > +
> > +	/* Deliver signal to user-space */
> > +	if (user_bp) {
> > +		info.si_signo = SIGTRAP;
> > +		info.si_errno = 0;
> > +		info.si_code = TRAP_HWBKPT;
> > +		info.si_addr = (void __user *)bp_info->address;
> > +		force_sig_info(SIGTRAP, &info, current);
> > +	}
> 
> Why are we delivering a signal to userspace here?  This seems
> unnecessary to me.
>

I was under the wrong impression that such a behaviour existed in the
x86 version (which was true in some of its older versions), and hence
carried over here.

I will remove the signal delivery code. It is always possible for
the hw-breakpoint's callback to generate the signal, if desired.
 
> Ensuring that we get control back reliably after executing the
> instruction, or when we get to the point where the instruction will
> never be executed, seems to be difficult to get right in all corner
> cases.  It may be better to just emulate the load or store
> unconditionally.  We don't currently have code to do that, but
> fix_alignment() is pretty close to what we would need (it would need
> to handle lbz/stb and it would need to use 2, 4 or 8-byte loads/stores
> rather than 1-byte loads/stores in the aligned case).
> 

It has been pointed out to me before (Roland's mail Ref:linuxppc-dev
message-id: 20100119100335.3EB621DE@magilla.sf.frob.com) that there will
be too many corner cases that will be difficult to foresee, however your
above list appears to be exhaustive. While the alternatives to this being
a fallback to one-shot breakpoints (thereby leading to confusing
hw-breakpoint interface semantics), this is an attempt to generate
continuous and 'trigger-after-execute' (for non-ptrace requests)
breakpoint exceptions. I believe that, with the addressal of concerns
cited above, the resultant patchset would be one that achieves the
stated design goals with no loss to existing functionality.

I intend to send out another version of this patchset with fixes as
described in my replies above (unless I hear objections to it :-)).

Thanking you again for the very insightful comments!

-- K.Prasad
