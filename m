Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A366B7D1F
	for <linuxppc-dev@ozlabs.org>; Tue, 25 May 2010 01:49:18 +1000 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp03.in.ibm.com (8.14.3/8.13.1) with ESMTP id o4OFn8PA023246
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 21:19:08 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4OFn83s3440690
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 21:19:08 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4OFn70l018655
	for <linuxppc-dev@ozlabs.org>; Mon, 24 May 2010 21:19:08 +0530
Date: Mon, 24 May 2010 21:19:02 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100524154902.GA5382@in.ibm.com>
References: <20100414033555.746326035@pr> <20100414034827.GC6571@in.ibm.com>
	<20100503062330.GB19365@drongo> <20100504203302.GA3894@in.ibm.com>
	<20100512063247.GC3548@drongo> <20100514065530.GA6195@in.ibm.com>
	<20100517123241.GA5379@brick.ozlabs.ibm.com>
	<20100520040603.GA7448@in.ibm.com>
	<20100520131003.GB29903@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100520131003.GB29903@brick.ozlabs.ibm.com>
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

On Thu, May 20, 2010 at 11:10:03PM +1000, Paul Mackerras wrote:
> On Thu, May 20, 2010 at 09:36:03AM +0530, K.Prasad wrote:
> 
(Had this mail composed along with the patchset...but mail server issues
caused delay in sending this...)

Hi Paul,
	While we continue to discuss some of the design decisions, I
thought I'd ready up a patchset to capture the changes we agreed upon to
(lest we miss them). I have sent a new version of the patchset here:
linuxppc-dev message-id: 20100524040137.GA20873@in.ibm.com.

Please see more responses below.

> > > Right.  However, the thread is running the signal handler without the
> > > DABR being set, which is unfortunate.
> > > 
> > 
> > In order to keep the breakpoint active during signal handling, a
> > PowerPC specific signal handling code, say do_signal_pending() in
> > arch/powerpc/kernel/signal.c, must be tapped to check for/restore
> > the breakpoint for the process (if it exists).
> 
> What I would suggest is something slightly different: anything that
> causes the thread to change where it's executing -- signal delivery,
> modification of NIP with ptrace -- should cancel the single-step and
> reinstall the breakpoint in the DABR.  In other words we just forget
> that we hit the breakpoint, and rely on hitting it again if we ever
> get back to that instruction.  I think that is by far the most
> reliable approach.
> 
> That means that the hw-breakpoint code needs to export a function
> called, say, thread_change_pc(), which is called whenever we're
> changing a thread's userspace PC (NIP) value.  If the hw-breakpoint
> code has put that thread into single-step mode, we cancel the
> single-step and if the thread is current, set DABR.
> 

I have made changes to signal-handling code on the suggested lines (as
seen here: linuxppc-dev message-id:20100524040342.GE20873@in.ibm.com)
wherein the debug registers are populated before signal-delivery and
cleaned during signal-return.

However handling of nested interrupts, where second exception is taken
inside the signal handler is still flimsy and the system would experience
two hw-breakpoint exceptions. To overcome the same, we will need a flag in
'struct thread_struct' or perhaps in 'struct arch_hw_breakpoint' to
indicate a breakpoint previously taken in signal-handling context. Given
that the repurcussions of a double-hit are not dangerous, and unsure of
how an addition to thread_struct might be received, I've skipped those
changes for now.

> > I'm afraid if this is more complexity than we want to handle in the
> > first patchset. I agree that this will create a 'blind-spot' of code
> > which cannot not be monitored using breakpoints and may limit debugging
> > efforts (specially for memory corruption); however suspecting that signal
> > handlers (especially those that don't return to original instruction)
> > would be rare, I feel that this could be a 'feature' that can be brought
> > later-in. What do you think?
> 
> I think the thread_change_pc() approach is quite a bit simpler, and I
> think it's better to get this right at the outset rather than have it
> cause bugs later on, when we've all forgotten all the curly
> details. :)

Yes, the details are mostly captured in the latest patchset. Had to make
some 'bold' changes to overcome the issues though :-)

> 
> > > Imagine this scenario: we get the DABR match, set MSR_SE and return to
> > > the task.  In the meantime another higher-priority task has become
> > > runnable and our need_resched flag is set, so we call schedule() on
> > > the way back out to usermode.  The other task runs and then blocks and
> > > our task gets scheduled again.  As part of the context switch,
> > > arch_install_hw_breakpoint() will get called and will set DABR.  So
> > > we'll return to usermode with both DABR and MSE_SE set.
> > > 
> > 
> > I didn't foresee such a possibility. I think this can be handled by
> > putting a check in arch_install_hw_breakpoint() as shown below:
> > 
> > int arch_install_hw_breakpoint(struct perf_event *bp)
> > {
> > 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > 	struct perf_event **slot = &__get_cpu_var(bp_per_reg);
> > 
> > 	*slot = bp;
> > 	if (!current->thread.last_hit_ubp)
> > 		set_dabr(info->address | info->type | DABR_TRANSLATION);
> > 	return 0;
> > }
> 
> Yes, basically, but don't we need to handle per-cpu breakpoints as
> well?  That is, we only want the extra check if this breakpoint is a
> per-task breakpoint.  Or am I not seeing enough context here?
>

Until version XVIII of the patchset, the antiquated notion of user- and
kernel-space still existed to some extent. Through changes made here
(reference: linuxppc-dev message-id: 20100524040418.GF20873@in.ibm.com)
per-task (whose pid > 0) and per-cpu breakpoints are suitably identified.

Now, per-task breakpoints can be one of the following
- User-space breakpoints bound to a process 'struct task_struct'.
- Kernel-space breakpoints bound to a process 'struct task_struct'.
- Kernel-thread breakpoint registered through
  register_user_hw_breakpoint() and still identified through 'struct
  task_struct' after cpu-migration.

The above type of breakpoints may be restricted to a given cpu, yet they
are identifiable through the 'task_struct'.

I am unable to think of a case where a cpu-bound breakpoint request
(essentially a kernel-space address request) without a process context
(i.e. no identifiable 'task_struct') could be scheduled and migrated
across CPUs.

Moving to version XX, the emulation of instructions during non-pertask
breakpoints does not provide a scope for pre-emption at all. Hence the
above check should suffice in either case.

> Also, I have just posted extensions to emulate_single_step() to handle
> loads and stores.  I think this should be enough to handle DABR
> interrupts that occur in kernel mode, so we should never need to
> actually single-step in that case -- if emulate_step fails we should
> just print a warning, uninstall the breakpoint, and continue.  That
> way we don't have to worry about all the interrupts and other
> eventualities that could occur while single-stepping in the kernel.
> 

It was beginning to respond to this section of the mail did I realise
that I failed to implement the suggestion to unregister breakpoint if
emulate_singlestep() failed; and hence the quick successive release of
version XX of the patchset :-)

It is true that if emulate_single_step() was powerful, it simplifies the
design to a large extent. However during my test (with the extensions to
emulate_single_step() applied), I found that the startup test for ftrace
(over ksym_tracer) failed as the breakpoint got unregistered (as a
consequence of emulate_single_step() failure).

I'm not sure if I missed something here...pasting the relevant disassembly
of code below.

0xc000000000138a2c <trace_selftest_startup_ksym+124>:	mr      r29,r3
0xc000000000138a30 <trace_selftest_startup_ksym+128>:	blt	cr7,0xc000000000138aac <trace_selftest_startup_ksym+252>
0xc000000000138a34 <trace_selftest_startup_ksym+132>:	lwz	r0,0(r28) <===== FAILED INSTRUCTION
0xc000000000138a38 <trace_selftest_startup_ksym+136>:	cmpwi   cr7,r0,0
0xc000000000138a3c <trace_selftest_startup_ksym+140>:	bne	cr7,0xc000000000138a48 <trace_selftest_startup_ksym+152>

> For DABR interrupts that occur in user mode, I think the approach of
> single-stepping together with calls to thread_change_pc() in the
> signal delivery and ptrace code should handle all the cases, at least
> for per-task breakpoints.  Per-cpu breakpoints that get hit in user
> mode will be a bit trickier, but I assume we can restrict per-cpu
> breakpoints to kernel addresses for now.  If you want help adding the
> thread_change_pc() calls to signal delivery and ptrace, let me know.

The newer patchsets should be taking care of such combinations i.e.
kernel-space address for a per-task/per-cpu breakpoint and user-space
breakpoint which is per-cpu. Implementations found in version XIX and
XX, handle the constraints in their own way (although version XX is much
simpler if emulate_single_step() mostly works).

In the absence of any adverse comments and given a powerful
emulate_single_step() which works for most instructions, I'd prefer to
push the version XX of the patchset for upstream integration.

Thanking you again for your help/review comments. Let me know your
thoughts on the newer patchset.

Thanks,
K.Prasad
