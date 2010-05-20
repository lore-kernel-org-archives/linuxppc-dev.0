Return-Path: <paulus@ozlabs.org>
Date: Thu, 20 May 2010 23:10:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100520131003.GB29903@brick.ozlabs.ibm.com>
References: <20100414033555.746326035@pr> <20100414034827.GC6571@in.ibm.com>
	<20100503062330.GB19365@drongo> <20100504203302.GA3894@in.ibm.com>
	<20100512063247.GC3548@drongo> <20100514065530.GA6195@in.ibm.com>
	<20100517123241.GA5379@brick.ozlabs.ibm.com>
	<20100520040603.GA7448@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100520040603.GA7448@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>, David Gibson <dwg@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 20, 2010 at 09:36:03AM +0530, K.Prasad wrote:

> > Right.  However, the thread is running the signal handler without the
> > DABR being set, which is unfortunate.
> > 
> 
> In order to keep the breakpoint active during signal handling, a
> PowerPC specific signal handling code, say do_signal_pending() in
> arch/powerpc/kernel/signal.c, must be tapped to check for/restore
> the breakpoint for the process (if it exists).

What I would suggest is something slightly different: anything that
causes the thread to change where it's executing -- signal delivery,
modification of NIP with ptrace -- should cancel the single-step and
reinstall the breakpoint in the DABR.  In other words we just forget
that we hit the breakpoint, and rely on hitting it again if we ever
get back to that instruction.  I think that is by far the most
reliable approach.

That means that the hw-breakpoint code needs to export a function
called, say, thread_change_pc(), which is called whenever we're
changing a thread's userspace PC (NIP) value.  If the hw-breakpoint
code has put that thread into single-step mode, we cancel the
single-step and if the thread is current, set DABR.

> I'm afraid if this is more complexity than we want to handle in the
> first patchset. I agree that this will create a 'blind-spot' of code
> which cannot not be monitored using breakpoints and may limit debugging
> efforts (specially for memory corruption); however suspecting that signal
> handlers (especially those that don't return to original instruction)
> would be rare, I feel that this could be a 'feature' that can be brought
> later-in. What do you think?

I think the thread_change_pc() approach is quite a bit simpler, and I
think it's better to get this right at the outset rather than have it
cause bugs later on, when we've all forgotten all the curly
details. :)

> > Imagine this scenario: we get the DABR match, set MSR_SE and return to
> > the task.  In the meantime another higher-priority task has become
> > runnable and our need_resched flag is set, so we call schedule() on
> > the way back out to usermode.  The other task runs and then blocks and
> > our task gets scheduled again.  As part of the context switch,
> > arch_install_hw_breakpoint() will get called and will set DABR.  So
> > we'll return to usermode with both DABR and MSE_SE set.
> > 
> 
> I didn't foresee such a possibility. I think this can be handled by
> putting a check in arch_install_hw_breakpoint() as shown below:
> 
> int arch_install_hw_breakpoint(struct perf_event *bp)
> {
> 	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> 	struct perf_event **slot = &__get_cpu_var(bp_per_reg);
> 
> 	*slot = bp;
> 	if (!current->thread.last_hit_ubp)
> 		set_dabr(info->address | info->type | DABR_TRANSLATION);
> 	return 0;
> }

Yes, basically, but don't we need to handle per-cpu breakpoints as
well?  That is, we only want the extra check if this breakpoint is a
per-task breakpoint.  Or am I not seeing enough context here?

Also, I have just posted extensions to emulate_single_step() to handle
loads and stores.  I think this should be enough to handle DABR
interrupts that occur in kernel mode, so we should never need to
actually single-step in that case -- if emulate_step fails we should
just print a warning, uninstall the breakpoint, and continue.  That
way we don't have to worry about all the interrupts and other
eventualities that could occur while single-stepping in the kernel.

For DABR interrupts that occur in user mode, I think the approach of
single-stepping together with calls to thread_change_pc() in the
signal delivery and ptrace code should handle all the cases, at least
for per-task breakpoints.  Per-cpu breakpoints that get hit in user
mode will be a bit trickier, but I assume we can restrict per-cpu
breakpoints to kernel addresses for now.  If you want help adding the
thread_change_pc() calls to signal delivery and ptrace, let me know.

Paul.
