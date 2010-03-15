Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EC9AB7D6F
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 17:29:23 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o2F6TMK2011374
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 17:29:22 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2F6TMdq1859654
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 17:29:22 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2F6TL0L002462
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 17:29:21 +1100
Date: Mon, 15 Mar 2010 11:59:09 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
Message-ID: <20100315062909.GA19279@in.ibm.com>
References: <20100308181232.GA3406@in.ibm.com>
	<20100308181448.GA5538@in.ibm.com>
	<1268374776.2209.74.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1268374776.2209.74.camel@pasglop>
Cc: Michael Neuling <mikey@neuling.org>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Alan Stern <stern@rowland.harvard.edu>,
	Roland McGrath <roland@redhat.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 12, 2010 at 05:19:36PM +1100, Benjamin Herrenschmidt wrote:
> 
> > Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
> > @@ -0,0 +1,54 @@
> > +#ifndef	_PPC64_HW_BREAKPOINT_H
> > +#define	_PPC64_HW_BREAKPOINT_H
> > +
> > +#ifdef	__KERNEL__
> > +#define	__ARCH_HW_BREAKPOINT_H
> > +#ifdef CONFIG_PPC64
> > +
> > +struct arch_hw_breakpoint {
> > +	u8		len; /* length of the target symbol */
> 
> I don't understand the usage of the word "symbol" above, can you
> explain ?
>

The word "symbol", here, carries a meaning similar to what is derived from
its usage in the word "kernel data symbols" - although it is
used to store lengths for both kernel and user-space breakpoints.

Since the desired length of the breakpoint is typically determined by the
size of the "symbol" (variable) being monitored (not exceeding 8-Bytes),
the comment was such. I shall change it to a more descriptive one, such as
"length of the target kernel/user data symbol" if you prefer that.
 
> > +	int		type;
> > +	unsigned long	address;
> > +};
> > +
> > +#include <linux/kdebug.h>
> > +#include <asm/reg.h>
> > +#include <asm/system.h>
> > +
> > +/* Total number of available HW breakpoint registers */
> > +#define HBP_NUM 1
> > +
> > +struct perf_event;
> > +struct pmu;
> > +struct perf_sample_data;
> > +
> > +#define HW_BREAKPOINT_ALIGN 0x7
> > +/* Maximum permissible length of any HW Breakpoint */
> > +#define HW_BREAKPOINT_LEN 0x8
> 
> That's a lot of server-only hard wired assumptions... I suppose the
> DABR emulation of BookE will catch but do you intend to provide
> proper BookE support at some stage ?
> 

Yes, I intend to extend support for Book-E sometime soon during which
the above code would have to be either a) enclosed inside #ifdef PPC64
or b) a new header file for BookE debug register definitions are used
(guess Shaggy's code would have many of them done already).

> > +static inline void hw_breakpoint_disable(void)
> > +{
> > +	set_dabr(0);
> > +}
> 
> How much of these set_dabr() I see here are going to interact with
> ptrace ? Is there some exclusion going on between ptrace and perf
> event use of the DABR or none at all ? Or are you replacing the ptrace
> bits ?
> 

This set_dabr() in hw_breakpoint_disable() is to be called only once during
machine_kexec() [which I realise is missing in the patch...will add that]
and will not conflict with ptrace.

The other set_dabr() in arch_<un>install_hw_breakpoint() will perform the
actual debug register write, while the ptrace_<get><set>_debugreg() requests
are routed through them (via the hw-breakpoint interfaces for arbitration as
shown below) and are designed to not conflict with each other.

ptrace_set_debugreg()-->register_user_hw_breakpoint()
...
(sched)-->perf_event_task_sched_<in><out>()--->arch_<un>install_hw_breakpoint()

In short, an existing ptrace request will not be overwritten/replaced to
accommodate a  new kernel/user-space request (which will fail because of DABR
unavailability).

> > +/*
> > + * Install a perf counter breakpoint.
> > + *
> > + * We seek a free debug address register and use it for this
> > + * breakpoint.
> > + *
> > + * Atomic: we hold the counter->ctx->lock and we only handle variables
> > + * and registers local to this cpu.
> > + */
> > +int arch_install_hw_breakpoint(struct perf_event *bp)
> > +{
> > +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > +	struct perf_event **slot = &__get_cpu_var(bp_per_reg);
> > +
> > +	if (!*slot)
> > +		*slot = bp;
> > +	else {
> > +		WARN_ONCE(1, "Can't find any breakpoint slot");
> > +		return -EBUSY;
> > +	}
> > +
> > +	set_dabr(info->address | info->type | DABR_TRANSLATION);
> > +	return 0;
> > +}
> 
> Under which circumstances will the upper layer call that more than
> once ? If it's a legit thing to do, then the WARN_ONCE() is a heavy
> hammer here. I wouldn't even printk.... or only pr_debug() if it's
> really worth it.
> 
> Or is that something that should just not happen ?
> 

I don't really see when this can happen in PPC64 with one DABR. The slot
reservation mechanism wouldn't allow this to happen and the code is here
since it got inherited from x86.

I shall remove the check and hence the WARN_ONCE.

> I would also use this coding style which is more compact and avoids
> the horrible (!*slot) :
> 
> 	/* Check if the slot is busy */
> 	if (*slot)
> 		return -EBUSY;
> 	set_dabr(...);
> 
> > +/*
> > + * Uninstall the breakpoint contained in the given counter.
> > + *
> > + * First we search the debug address register it uses and then we disable
> > + * it.
> > + *
> > + * Atomic: we hold the counter->ctx->lock and we only handle variables
> > + * and registers local to this cpu.
> > + */
> > +void arch_uninstall_hw_breakpoint(struct perf_event *bp)
> > +{
> > +	struct perf_event **slot = &__get_cpu_var(bp_per_reg);
> > +
> > +	if (*slot == bp)
> > +		*slot = NULL;
> > +	else {
> > +		WARN_ONCE(1, "Can't find the breakpoint slot");
> > +		return;
> > +	}
> > +	set_dabr(0);
> > +}
> 
> Similar coding style issues... That one might be worth the warning
> as I suppose the core should -really- not try to uninstall a bp that
> hasn't been installed in the first place.
>

Okay..will change the code style.
 
> > +/*
> > + * Validate the arch-specific HW Breakpoint register settings
> > + */
> > +int arch_validate_hwbkpt_settings(struct perf_event *bp,
> > +						struct task_struct *tsk)
> > +{
> > +	int is_kernel, ret = -EINVAL;
> > +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> > +
> > +	if (!bp)
> > +		return ret;
> > +
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
> I'm not -too- fan of the above, I suppose I would have written it a bit
> differently using if's but that's not a big deal... however:
> 
> > +	/* TODO: Check for a valid triggered function */
> > +	/* if (!bp->triggered)
> > +		return -EINVAL; */
> 
> What is that ? Is the patch incomplete ? Don't leave commented out code
> in there. If you think there's a worthwhile improvement, then add a
> comment with maybe a bit more explanations, and make it clear that the
> patch is still useful without the code, but don't just leave commented
> out code like that without a good reason. A good reason would be some
> optional debug stuff for example, but then an ifdef is preferrable to
> comments.
> 

Thanks for pointing that out....the TODO label here is obsolete..it will
be removed.

> > +	is_kernel = is_kernel_addr(bp->attr.bp_addr);
> > +	if ((tsk && is_kernel) || (!tsk && !is_kernel))
> > +		return -EINVAL;
> > +
> > +	info->address = bp->attr.bp_addr;
> > +	info->len = bp->attr.bp_len;
> > +
> > +	/*
> > +	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
> > +	 * and breakpoint addresses are aligned to nearest double-word
> > +	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address, the
> > +	 * 'symbolsize' should satisfy the check below.
> > +	 */
> > +	if (info->len >
> > +	    (HW_BREAKPOINT_LEN - (info->address & HW_BREAKPOINT_ALIGN)))
> > +		return -EINVAL;
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Handle debug exception notifications.
> > + */
> > +int __kprobes hw_breakpoint_handler(struct die_args *args)
> > +{
> > +	int rc = NOTIFY_STOP;
> > +	struct perf_event *bp;
> > +	struct pt_regs *regs = args->regs;
> > +	unsigned long dar = regs->dar;
> > +	int cpu, is_kernel, stepped = 1;
> > +	struct arch_hw_breakpoint *info;
> > +
> > +	/* Disable breakpoints during exception handling */
> > +	set_dabr(0);
> > +	cpu = get_cpu();
> 
> So there's something a bit weird here. set_dabr() will clear the DABR on
> the local CPU, and you do that before you disable preempt. So you may
> have preempted and be on another CPU, is that allright ? IE. Are you
> dealing with that original CPU still having the DABR active and you now
> clearing a different one ?
>

First, the code here is written with the assumption that pre-emption is
disabled during do_page_fault() and hence hw-breakpoint exception handling.
If it is not the case (as you've pointed out below) the exception handling
is bound to go wrong. I will fix it by patching do_hash_page in
exceptions-64s.S as suggested by you.

Since the comment here (and some of those below) point out the problems that
may arise when pre-emption occurs (which is not supposed to happen),
they are all valid but will disappear when do_hash_page is fixed.
 
> > +	/*
> > +	 * The counter may be concurrently released but that can only
> > +	 * occur from a call_rcu() path. We can then safely fetch
> > +	 * the breakpoint, use its callback, touch its counter
> > +	 * while we are in an rcu_read_lock() path.
> > +	 */
> > +	rcu_read_lock();
> > +
> > +	bp = per_cpu(bp_per_reg, cpu);
> > +	if (!bp)
> > +		goto out;
> 
> So this is the bp_per_reg of a different CPU if you had migrated
> earlier. So you -did- hit the BP on, let's say CPU 0, but since you are
> now on CPU 1 you won't handle it ? Weird...
> 

Correct...I will fix as stated above.

> > +	info = counter_arch_bp(bp);
> > +	is_kernel = is_kernel_addr(bp->attr.bp_addr);
> > +
> > +	/*
> > +	 * Verify if dar lies within the address range occupied by the symbol
> > +	 * being watched to filter extraneous exceptions.
> > +	 */
> > +	if (!((bp->attr.bp_addr <= dar) &&
> > +	    (dar <= (bp->attr.bp_addr + bp->attr.bp_len))))
> > +		/*
> > +		 * This exception is triggered not because of a memory access on
> > +		 * the monitored variable but in the double-word address range
> > +		 * in which it is contained. We will consume this exception,
> > +		 * considering it as 'noise'.
> > +		 */
> > +		goto restore_bp;
> > +
> > +	/*
> > +	 * Return early after invoking user-callback function without restoring
> > +	 * DABR if the breakpoint is from ptrace which always operates in
> > +	 * one-shot mode
> > +	 */
> > +	if (bp->overflow_handler == ptrace_triggered) {
> > +		perf_bp_event(bp, regs);
> > +		rc = NOTIFY_DONE;
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * Do not emulate user-space instructions from kernel-space,
> > +	 * instead single-step them.
> > +	 */
> > +	if (!is_kernel) {
> > +		current->thread.last_hit_ubp = bp;
> > +		regs->msr |= MSR_SE;
> > +		goto out;
> > +	}
> 
> So what is this ? When you hit a bp, you switch to single step ? Out of
> curiosity, why ?
> 

For a user-space breakpoint request (which is not from ptrace syscall),
the behaviour is thus:
- It operates in 'continuous-trigger' mode (unlike ptrace requests
  which are 'one-shot'.
- The causative instruction is not emulated in kernel-space using
  emulate_step() but is rather executed in user-space.
- The SIGTRAP signal is sent to user-space 'after' execution of the
  causative instruction.

Since breakpoint exceptions in ppc64 operate in 'trigger-before-execute'
fashion, they have to be disabled upon occurrence and then re-enabled
after single-stepping the causative instruction (inside the single-step
handler) to avoid being hit by the breakpoint infinitely. I'm not sure
if I'm missing something obviously wrong that you're trying to point me
to (in the comment above).

> > +	stepped = emulate_step(regs, regs->nip);
> > +	/* emulate_step() could not execute it, single-step them */
> > +	if (stepped == 0) {
> > +		regs->msr |= MSR_SE;
> > +		per_cpu(last_hit_bp, cpu) = bp;
> > +		goto out;
> > +	}
> > +	/*
> > +	 * As a policy, the callback is invoked in a 'trigger-after-execute'
> > +	 * fashion
> > +	 */
> > +	perf_bp_event(bp, regs);
> > +
> > +restore_bp:
> > +	set_dabr(info->address | info->type | DABR_TRANSLATION);
> 
> So in my preempt case, you hit the DABR on CPU 0, migrated to CPU 1
> before you get into this function, and now you are modifying CPU 1
> DABR... 
> 
> I think we need to change the asm so that you are called with interrupts
> off from handle_page_fault() or so.
> 
> Basicallym in do_hash_page, make the andis 0xa450 go out of line, check
> for DSISR_DABRMATCH specifically, and in this case go to an entirely
> different function than handle_page_fault->do_page_fault(), something
> like handle_dabr_fault->do_dabr() which uses DISABLE_INTS instead
> of ENABLE_INTS :-)
> 

Sure, will fix this (and other comments) in the subsequent patch that I send.


> We also need the same fix in 32-bit I suppose.
> 
> Note while looking at it that it looks like we have a similar issue with
> program checks. We fixed it on 32-bit but not on 64-bit. We should keep
> interrupts masked basically when going progranm_check_exception(). It
> will unmask them if/when needed.
> 
> > +out:
> > +	rcu_read_unlock();
> > +	put_cpu();
> > +	return rc;
> > +}
> > +
> > +/*
> > + * Handle single-step exceptions following a DABR hit.
> > + */
> > +int __kprobes single_step_dabr_instruction(struct die_args *args)
> > +{
> > +	struct pt_regs *regs = args->regs;
> > +	int cpu = get_cpu();
> > +	int ret = NOTIFY_DONE;
> > +	siginfo_t info;
> > +	struct perf_event *bp = NULL, *kernel_bp, *user_bp;
> > +	struct arch_hw_breakpoint *bp_info;
> > +
> > +	/*
> > +	 * Identify the cause of single-stepping and find the corresponding
> > +	 * breakpoint structure
> > +	 */
> > +	user_bp = current->thread.last_hit_ubp;
> > +	kernel_bp = per_cpu(last_hit_bp, cpu);
> > +	if (user_bp) {
> > +		bp = user_bp;
> > +		current->thread.last_hit_ubp = NULL;
> > +	} else if (kernel_bp) {
> > +		bp = kernel_bp;
> > +		per_cpu(last_hit_bp, cpu) = NULL;
> > +	}
> 
> Hopefully you don't have this problem here, so you probably don't need
> get/put_cpu() but that won't hurt, since single_step should hopefully
> always have interrupts off.
> 

Sure, I could have used smp_processor_id() instead....will use that.

> > +	/*
> > +	 * Check if we are single-stepping as a result of a
> > +	 * previous HW Breakpoint exception
> > +	 */
> > +	if (!bp)
> > +		goto out;
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
> > +
> > +	set_dabr(bp_info->address | bp_info->type | DABR_TRANSLATION);
> > +	ret = NOTIFY_STOP;
> > +out:
> > +	put_cpu();
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Handle debug exception notifications.
> > + */
> > +int __kprobes hw_breakpoint_exceptions_notify(
> > +		struct notifier_block *unused, unsigned long val, void *data)
> > +{
> > +	int ret = NOTIFY_DONE;
> > +
> > +	switch (val) {
> > +	case DIE_DABR_MATCH:
> > +		ret = hw_breakpoint_handler(data);
> > +		break;
> > +	case DIE_SSTEP:
> > +		ret = single_step_dabr_instruction(data);
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +/*
> > + * Release the user breakpoints used by ptrace
> > + */
> > +void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
> > +{
> > +	struct thread_struct *t = &tsk->thread;
> > +
> > +	unregister_hw_breakpoint(t->ptrace_bps[0]);
> > +	t->ptrace_bps[0] = NULL;
> > +}
> 
> Ok, so I see that you call that on context switch. But where do you
> re-install the breakpoint for the "new" process ?
> 
> See below...
> 

This is being unconditionally invoked inside __switch_to() which is
wrong. In addition, it also leads to a lockdep warning which I will fix
in my subsequent patch.

> > +void hw_breakpoint_pmu_read(struct perf_event *bp)
> > +{
> > +	/* TODO */
> > +}
> > +
> > +void hw_breakpoint_pmu_unthrottle(struct perf_event *bp)
> > +{
> > +	/* TODO */
> > +}
> > +
> > +
> > Index: linux-2.6.ppc64_test/arch/powerpc/Kconfig
> > ===================================================================
> > --- linux-2.6.ppc64_test.orig/arch/powerpc/Kconfig
> > +++ linux-2.6.ppc64_test/arch/powerpc/Kconfig
> > @@ -140,6 +140,7 @@ config PPC
> >  	select HAVE_SYSCALL_WRAPPERS if PPC64
> >  	select GENERIC_ATOMIC64 if PPC32
> >  	select HAVE_PERF_EVENTS
> > +	select HAVE_HW_BREAKPOINT if PPC64
> 
> Why 64-bit only ? ppc32 has DABR too. In fact BookE also provides DABR
> emulation.
>

HAVE_HW_BREAKPOINT would be too generic, so I guess this can be changed
to HAVE_HW_BREAKPOINT_DABR (or something similar?). I think you're
referring to BookE's ability to individually use DAC registers are two
debug registers - which cannot be handled by this patch and can be done
during BookE implementation.

> Also, all your PPC64 stuff are going to show up on BookE 64-bit which
> might not be what you wanted...
>

True...I thought PPC64 would refer to the server class of processors
(which has just one DABR)...is there a config flag to refer to such
processors? Or should this patch create one?
 
> >  config EARLY_PRINTK
> >  	bool
> > Index: linux-2.6.ppc64_test/arch/powerpc/kernel/Makefile
> > ===================================================================
> > --- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/Makefile
> > +++ linux-2.6.ppc64_test/arch/powerpc/kernel/Makefile
> > @@ -33,7 +33,7 @@ obj-y				:= cputable.o ptrace.o syscalls
> >  obj-y				+= vdso32/
> >  obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
> >  				   signal_64.o ptrace32.o \
> > -				   paca.o nvram_64.o firmware.o
> > +				   paca.o nvram_64.o firmware.o hw_breakpoint.o
> >  obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
> >  obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
> >  obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o
> > Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/reg.h
> > ===================================================================
> > --- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/reg.h
> > +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/reg.h
> > @@ -180,6 +180,7 @@
> >  #define   CTRL_TE	0x00c00000	/* thread enable */
> >  #define   CTRL_RUNLATCH	0x1
> >  #define SPRN_DABR	0x3F5	/* Data Address Breakpoint Register */
> > +#define   HBP_NUM	1	/* Number of physical HW breakpoint registers */
> 
> The above is not quite right. First you already define that in
> hw_breakpoint.h. Then, this is too short an identifier for such a
> generic file. Finally, it should not be in reg.h since it can vary
> from processor to processor. If you want to do things properly, then
> add some kind of info about the debug capabilities to cputable.
> 
> Please sync with Shaggy so it makes sense on BookE as well.
> 

I think cputable.h would be a fine place to define this...I will move
HBP_NUM there. However, renaming it would be difficult since the generic
code in kernel/hw_breakpoint.c (and references in x86) uses this
constant.

> >  #define   DABR_TRANSLATION	(1UL << 2)
> >  #define   DABR_DATA_WRITE	(1UL << 1)
> >  #define   DABR_DATA_READ	(1UL << 0)
> > Index: linux-2.6.ppc64_test/arch/powerpc/mm/fault.c
> > ===================================================================
> > --- linux-2.6.ppc64_test.orig/arch/powerpc/mm/fault.c
> > +++ linux-2.6.ppc64_test/arch/powerpc/mm/fault.c
> > @@ -137,6 +137,12 @@ int __kprobes do_page_fault(struct pt_re
> >  		error_code &= 0x48200000;
> >  	else
> >  		is_write = error_code & DSISR_ISSTORE;
> > +
> > +	if (error_code & DSISR_DABRMATCH) {
> > +		/* DABR match */
> > +		do_dabr(regs, address, error_code);
> > +		return 0;
> > +	}
> 
> Now that's interesting. I have the feeling that the moving up of this
> might actually be a bug fix :-) But it's still wrong due to interrupts
> being enabled as I explained earlier. We probably want to make it a
> different path out of head_*.S
> 

Agreed, this change would not be required after patching do_hash_page in
exceptions-64s.S.

> >  #else
> >  	is_write = error_code & ESR_DST;
> >  #endif /* CONFIG_4xx || CONFIG_BOOKE */
> > @@ -151,14 +157,6 @@ int __kprobes do_page_fault(struct pt_re
> >  	if (!user_mode(regs) && (address >= TASK_SIZE))
> >  		return SIGSEGV;
> >  
> > -#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> > -  	if (error_code & DSISR_DABRMATCH) {
> > -		/* DABR match */
> > -		do_dabr(regs, address, error_code);
> > -		return 0;
> > -	}
> > -#endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
> > -
> >  	if (in_atomic() || mm == NULL) {
> >  		if (!user_mode(regs))
> >  			return SIGSEGV;
> > Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/processor.h
> > ===================================================================
> > --- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/processor.h
> > +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/processor.h
> > @@ -209,6 +209,12 @@ struct thread_struct {
> >  #ifdef CONFIG_PPC64
> >  	unsigned long	start_tb;	/* Start purr when proc switched in */
> >  	unsigned long	accum_tb;	/* Total accumilated purr for process */
> > +	struct perf_event *ptrace_bps[HBP_NUM];
> 
> So you should probably call that MAX_HW_BREAKPOINTS and reflect the fact
> that it can be bigger. Or you have a pointer to some optional ptrace
> BP structure that handle what is needed, and can be allocated lazily
> by ptrace only when needed rather than always carrying this around in
> the thread_struct.
> 

Since ptrace's request for debug registers are thread-specific, they are
stored in 'struct thread_struct' (and is analogous to its implementation
in x86). In fact previous attempts to store such values outside
thread_struct were discouraged by the LKML community (refer Ingo's mail
on LKML here: 20090310143543.GE3850@elte.hu) citing potential locking
issues when stored outside.

> > +	/*
> > +	 * Point to the hw-breakpoint last. Helps safe pre-emption and
> > +	 * hw-breakpoint re-enablement.
> > +	 */
> > +	struct perf_event *last_hit_ubp;
> 
> The comment doesn't make much sense. Preemption doesn't seem quite right
> to me unless I missed something and the comment is either too much or
> not enough to understand what this is for.
>

The single-step exception may arise due to two reasons - (a) a legitimate
user (like kgdb in kernel-, or ptrace in user-space) decides to
single-step for debugging purposes or (b) single-stepping enabled by
hw_breakpoint_handler() to restore the debug register values.

'last_hit_ubp' along with 'per_cpu(last_hit_bp)' are used to distinguish
single-step exceptions that are triggered because of (b).

These data structures will not be required if pre-emption between
hw_breakpoint_handler() and single-step exception is disabled, since it
will be straight-forward to distinguish the source of exception i.e. (a)
from (b). In such a case, with pre-emption disabled on the CPU that hit
the breakpoint, single-step exceptions following a hw_breakpoint_handler()
will always be the result of (b) and vice-versa.

I will make the comment more descriptive as below:

/*
 * Helps identify source of single-step exception and subsequent
 * hw-breakpoint enablement
 */

Thank you for the detailed review - they have helped unearth certain
important issues with the patch.

As stated before, I will send a subsequent version of the patch with the
fixes as agreed above.

Thanks,
K.Prasad
