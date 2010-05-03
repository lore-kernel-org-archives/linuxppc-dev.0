Return-Path: <paulus@ozlabs.org>
Date: Mon, 3 May 2010 16:23:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 2/2] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100503062330.GB19365@drongo>
References: <20100414033555.746326035@pr>
 <20100414034827.GC6571@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100414034827.GC6571@in.ibm.com>
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

On Wed, Apr 14, 2010 at 09:18:27AM +0530, K.Prasad wrote:

> Implement perf-events based hw-breakpoint interfaces for PPC64 processors.
> These interfaces help arbitrate requests from various users and schedules
> them as appropriate.

[snip]

> --- /dev/null
> +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -0,0 +1,45 @@
> +#ifndef _PPC_BOOK3S_64_HW_BREAKPOINT_H
> +#define _PPC_BOOK3S_64_HW_BREAKPOINT_H
> +
> +#ifdef	__KERNEL__
> +#define	__ARCH_HW_BREAKPOINT_H

This symbol doesn't seem to be referenced anywhere.  Is it really
necessary to define it?  I know x86 and sh do, but maybe it's a
leftover there.

> ===================================================================
> --- /dev/null
> +++ linux-2.6.ppc64_test/arch/powerpc/kernel/hw_breakpoint.c

> +	switch (bp->attr.bp_type) {
> +	case HW_BREAKPOINT_R:
> +		info->type = DABR_DATA_READ;
> +		break;
> +	case HW_BREAKPOINT_W:
> +		info->type = DABR_DATA_WRITE;
> +		break;
> +	case HW_BREAKPOINT_R | HW_BREAKPOINT_W:
> +		info->type = (DABR_DATA_READ | DABR_DATA_WRITE);
> +		break;
> +	default:
> +		return ret;
> +	}

You have code like this in several places -- maybe this should be
encapsulated in a helper function.  Also, I think it could be written
more compactly.

> +	/*
> +	 * Return early after invoking user-callback function without restoring
> +	 * DABR if the breakpoint is from ptrace which always operates in
> +	 * one-shot mode
> +	 */
> +	if (is_ptrace_bp == true) {
> +		perf_bp_event(bp, regs);
> +		rc = NOTIFY_DONE;
> +		goto out;
> +	}

As far as I can see, returning NOTIFY_DONE won't tell do_dabr() that
you have handled the exception, and it will go on to do the
debugger_dabr_match() call and generate a signal to the current
process.  Is that what you want?  If so a comment would be useful.

Also, the " == true" part is completely redundant.  Normal kernel
style would be if (is_ptrace_bp) { ..., and similarly the
(is_ptrace_bp == false) above should be !is_ptrace_bp.

> +
> +	/*
> +	 * Do not emulate user-space instructions from kernel-space,
> +	 * instead single-step them.
> +	 */
> +	if (is_kernel == false) {
> +		current->thread.last_hit_ubp = bp;
> +		regs->msr |= MSR_SE;
> +		goto out;
> +	}

I'm a bit worried about what could happen from here on.  We go back
out to userspace and try to execute the load or store.  Besides
executing successfully and taking the trace interrupt, there are
several other possibilities:

- we could get an alignment interrupt
- we could get a page fault (page not present or protection violation)
- we could get a MMU hash table miss (unlikely since the low-level
  code calls hash_page before do_dabr, but possible since the HPTE
  could in principle have been evicted in the meantime).
- we could even get an illegal or privileged instruction trap --
  if some other thread had changed the instruction in the meantime.

The alignment interrupt case is mostly OK, except that it will call
emulate_single_step after emulating the load or store, which doesn't
do quite what we want -- unlike single_step_exception(), it doesn't
call notify_die(), so we won't get back into
single_step_dabr_instruction(), but instead it just sends a SIGTRAP.
That needs to be fixed, but note that single_step_exception() only
applies to "classic"/server processors at present because it hits the
MSR SE and BE bits directly rather than using clear_single_step().

The MMU hash table miss case looks to be OK -- we'll just return to
userspace and re-execute the instruction, with MSR[SE] still set.

The page fault case should be OK if it just results in inserting a PTE
(possibly after some context switches) or in the process being
terminated.  If, however, it results in a signal we could end up with
a stale value in current->thread.last_hit_ubp if the signal handler
doesn't return to the instruction (and there is no requirement for it
to do so).  If the process later gets single-stepped for any reason it
could get misinterpreted, and we could end up accessing freed memory
if the perf_event associated with bp has been closed and freed in the
meantime.

Similarly, if the instruction has been changed underneath us, we would
end up with current->thread.last_hit_ubp being stale.  We do need to
handle this case if only to ensure that we don't create a
vulnerability that could be used to attack the kernel.

> +
> +	stepped = emulate_step(regs, regs->nip);
> +	/* emulate_step() could not execute it, single-step them */

Note that at present, emulate_step() will never emulate a load or
store, so this will always return 0 unless someone has changed the
instruction underneath us.

> +	if (stepped == 0) {
> +		regs->msr |= MSR_SE;
> +		per_cpu(last_hit_bp, cpu) = bp;
> +		goto out;
> +	}

This is subject to most of the same possibilities as the user address
case.  We need to make sure that if we ever get the situation where
the instruction is never going to be executed then we clear
last_hit_bp for this cpu.  By the way, __get_cpu_var(x) is more
efficient than per_cpu(x, cpu) and is equivalent if cpu ==
smp_processor_id().

> +	/*
> +	 * Do not disable MSR_SE if the process was already in
> +	 * single-stepping mode. We cannot reliable detect single-step mode
> +	 * for kernel-space breakpoints, so this cannot work along with other
> +	 * debuggers (like KGDB, xmon) which may be single-stepping kernel code.
> +	 */
> +	if (!(user_bp && test_thread_flag(TIF_SINGLESTEP)))
> +		regs->msr &= ~MSR_SE;
> +
> +	/* Deliver signal to user-space */
> +	if (user_bp) {
> +		info.si_signo = SIGTRAP;
> +		info.si_errno = 0;
> +		info.si_code = TRAP_HWBKPT;
> +		info.si_addr = (void __user *)bp_info->address;
> +		force_sig_info(SIGTRAP, &info, current);
> +	}

Why are we delivering a signal to userspace here?  This seems
unnecessary to me.

Ensuring that we get control back reliably after executing the
instruction, or when we get to the point where the instruction will
never be executed, seems to be difficult to get right in all corner
cases.  It may be better to just emulate the load or store
unconditionally.  We don't currently have code to do that, but
fix_alignment() is pretty close to what we would need (it would need
to handle lbz/stb and it would need to use 2, 4 or 8-byte loads/stores
rather than 1-byte loads/stores in the aligned case).

Paul.
