Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE51EB7D52
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 17:25:04 +1100 (EST)
Subject: Re: [Patch 1/1] PPC64-HWBKPT: Implement hw-breakpoints for PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: prasad@linux.vnet.ibm.com
In-Reply-To: <20100308181448.GA5538@in.ibm.com>
References: <20100308181232.GA3406@in.ibm.com>
	<20100308181448.GA5538@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 12 Mar 2010 17:19:36 +1100
Message-ID: <1268374776.2209.74.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, shaggy@linux.vnet.ibm.com,
	Frederic Weisbecker <fweisbec@gmail.com>,
	David Gibson <dwg@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Alan Stern <stern@rowland.harvard.edu>,
	Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
> ===================================================================
> --- /dev/null
> +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/hw_breakpoint.h
> @@ -0,0 +1,54 @@
> +#ifndef	_PPC64_HW_BREAKPOINT_H
> +#define	_PPC64_HW_BREAKPOINT_H
> +
> +#ifdef	__KERNEL__
> +#define	__ARCH_HW_BREAKPOINT_H
> +#ifdef CONFIG_PPC64
> +
> +struct arch_hw_breakpoint {
> +	u8		len; /* length of the target symbol */

I don't understand the usage of the word "symbol" above, can you
explain ?

> +	int		type;
> +	unsigned long	address;
> +};
> +
> +#include <linux/kdebug.h>
> +#include <asm/reg.h>
> +#include <asm/system.h>
> +
> +/* Total number of available HW breakpoint registers */
> +#define HBP_NUM 1
> +
> +struct perf_event;
> +struct pmu;
> +struct perf_sample_data;
> +
> +#define HW_BREAKPOINT_ALIGN 0x7
> +/* Maximum permissible length of any HW Breakpoint */
> +#define HW_BREAKPOINT_LEN 0x8

That's a lot of server-only hard wired assumptions... I suppose the
DABR emulation of BookE will catch but do you intend to provide
proper BookE support at some stage ?

> +static inline void hw_breakpoint_disable(void)
> +{
> +	set_dabr(0);
> +}

How much of these set_dabr() I see here are going to interact with
ptrace ? Is there some exclusion going on between ptrace and perf
event use of the DABR or none at all ? Or are you replacing the ptrace
bits ?

> +/*
> + * Install a perf counter breakpoint.
> + *
> + * We seek a free debug address register and use it for this
> + * breakpoint.
> + *
> + * Atomic: we hold the counter->ctx->lock and we only handle variables
> + * and registers local to this cpu.
> + */
> +int arch_install_hw_breakpoint(struct perf_event *bp)
> +{
> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +	struct perf_event **slot = &__get_cpu_var(bp_per_reg);
> +
> +	if (!*slot)
> +		*slot = bp;
> +	else {
> +		WARN_ONCE(1, "Can't find any breakpoint slot");
> +		return -EBUSY;
> +	}
> +
> +	set_dabr(info->address | info->type | DABR_TRANSLATION);
> +	return 0;
> +}

Under which circumstances will the upper layer call that more than
once ? If it's a legit thing to do, then the WARN_ONCE() is a heavy
hammer here. I wouldn't even printk.... or only pr_debug() if it's
really worth it.

Or is that something that should just not happen ?

I would also use this coding style which is more compact and avoids
the horrible (!*slot) :

	/* Check if the slot is busy */
	if (*slot)
		return -EBUSY;
	set_dabr(...);

> +/*
> + * Uninstall the breakpoint contained in the given counter.
> + *
> + * First we search the debug address register it uses and then we disable
> + * it.
> + *
> + * Atomic: we hold the counter->ctx->lock and we only handle variables
> + * and registers local to this cpu.
> + */
> +void arch_uninstall_hw_breakpoint(struct perf_event *bp)
> +{
> +	struct perf_event **slot = &__get_cpu_var(bp_per_reg);
> +
> +	if (*slot == bp)
> +		*slot = NULL;
> +	else {
> +		WARN_ONCE(1, "Can't find the breakpoint slot");
> +		return;
> +	}
> +	set_dabr(0);
> +}

Similar coding style issues... That one might be worth the warning
as I suppose the core should -really- not try to uninstall a bp that
hasn't been installed in the first place.

> +/*
> + * Validate the arch-specific HW Breakpoint register settings
> + */
> +int arch_validate_hwbkpt_settings(struct perf_event *bp,
> +						struct task_struct *tsk)
> +{
> +	int is_kernel, ret = -EINVAL;
> +	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
> +
> +	if (!bp)
> +		return ret;
> +
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

I'm not -too- fan of the above, I suppose I would have written it a bit
differently using if's but that's not a big deal... however:

> +	/* TODO: Check for a valid triggered function */
> +	/* if (!bp->triggered)
> +		return -EINVAL; */

What is that ? Is the patch incomplete ? Don't leave commented out code
in there. If you think there's a worthwhile improvement, then add a
comment with maybe a bit more explanations, and make it clear that the
patch is still useful without the code, but don't just leave commented
out code like that without a good reason. A good reason would be some
optional debug stuff for example, but then an ifdef is preferrable to
comments.

> +	is_kernel = is_kernel_addr(bp->attr.bp_addr);
> +	if ((tsk && is_kernel) || (!tsk && !is_kernel))
> +		return -EINVAL;
> +
> +	info->address = bp->attr.bp_addr;
> +	info->len = bp->attr.bp_len;
> +
> +	/*
> +	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
> +	 * and breakpoint addresses are aligned to nearest double-word
> +	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address, the
> +	 * 'symbolsize' should satisfy the check below.
> +	 */
> +	if (info->len >
> +	    (HW_BREAKPOINT_LEN - (info->address & HW_BREAKPOINT_ALIGN)))
> +		return -EINVAL;
> +	return 0;
> +}
> +
> +/*
> + * Handle debug exception notifications.
> + */
> +int __kprobes hw_breakpoint_handler(struct die_args *args)
> +{
> +	int rc = NOTIFY_STOP;
> +	struct perf_event *bp;
> +	struct pt_regs *regs = args->regs;
> +	unsigned long dar = regs->dar;
> +	int cpu, is_kernel, stepped = 1;
> +	struct arch_hw_breakpoint *info;
> +
> +	/* Disable breakpoints during exception handling */
> +	set_dabr(0);
> +	cpu = get_cpu();

So there's something a bit weird here. set_dabr() will clear the DABR on
the local CPU, and you do that before you disable preempt. So you may
have preempted and be on another CPU, is that allright ? IE. Are you
dealing with that original CPU still having the DABR active and you now
clearing a different one ?
 
> +	/*
> +	 * The counter may be concurrently released but that can only
> +	 * occur from a call_rcu() path. We can then safely fetch
> +	 * the breakpoint, use its callback, touch its counter
> +	 * while we are in an rcu_read_lock() path.
> +	 */
> +	rcu_read_lock();
> +
> +	bp = per_cpu(bp_per_reg, cpu);
> +	if (!bp)
> +		goto out;

So this is the bp_per_reg of a different CPU if you had migrated
earlier. So you -did- hit the BP on, let's say CPU 0, but since you are
now on CPU 1 you won't handle it ? Weird...

> +	info = counter_arch_bp(bp);
> +	is_kernel = is_kernel_addr(bp->attr.bp_addr);
> +
> +	/*
> +	 * Verify if dar lies within the address range occupied by the symbol
> +	 * being watched to filter extraneous exceptions.
> +	 */
> +	if (!((bp->attr.bp_addr <= dar) &&
> +	    (dar <= (bp->attr.bp_addr + bp->attr.bp_len))))
> +		/*
> +		 * This exception is triggered not because of a memory access on
> +		 * the monitored variable but in the double-word address range
> +		 * in which it is contained. We will consume this exception,
> +		 * considering it as 'noise'.
> +		 */
> +		goto restore_bp;
> +
> +	/*
> +	 * Return early after invoking user-callback function without restoring
> +	 * DABR if the breakpoint is from ptrace which always operates in
> +	 * one-shot mode
> +	 */
> +	if (bp->overflow_handler == ptrace_triggered) {
> +		perf_bp_event(bp, regs);
> +		rc = NOTIFY_DONE;
> +		goto out;
> +	}
> +
> +	/*
> +	 * Do not emulate user-space instructions from kernel-space,
> +	 * instead single-step them.
> +	 */
> +	if (!is_kernel) {
> +		current->thread.last_hit_ubp = bp;
> +		regs->msr |= MSR_SE;
> +		goto out;
> +	}

So what is this ? When you hit a bp, you switch to single step ? Out of
curiosity, why ?

> +	stepped = emulate_step(regs, regs->nip);
> +	/* emulate_step() could not execute it, single-step them */
> +	if (stepped == 0) {
> +		regs->msr |= MSR_SE;
> +		per_cpu(last_hit_bp, cpu) = bp;
> +		goto out;
> +	}
> +	/*
> +	 * As a policy, the callback is invoked in a 'trigger-after-execute'
> +	 * fashion
> +	 */
> +	perf_bp_event(bp, regs);
> +
> +restore_bp:
> +	set_dabr(info->address | info->type | DABR_TRANSLATION);

So in my preempt case, you hit the DABR on CPU 0, migrated to CPU 1
before you get into this function, and now you are modifying CPU 1
DABR... 

I think we need to change the asm so that you are called with interrupts
off from handle_page_fault() or so.

Basicallym in do_hash_page, make the andis 0xa450 go out of line, check
for DSISR_DABRMATCH specifically, and in this case go to an entirely
different function than handle_page_fault->do_page_fault(), something
like handle_dabr_fault->do_dabr() which uses DISABLE_INTS instead
of ENABLE_INTS :-)

We also need the same fix in 32-bit I suppose.

Note while looking at it that it looks like we have a similar issue with
program checks. We fixed it on 32-bit but not on 64-bit. We should keep
interrupts masked basically when going progranm_check_exception(). It
will unmask them if/when needed.

> +out:
> +	rcu_read_unlock();
> +	put_cpu();
> +	return rc;
> +}
> +
> +/*
> + * Handle single-step exceptions following a DABR hit.
> + */
> +int __kprobes single_step_dabr_instruction(struct die_args *args)
> +{
> +	struct pt_regs *regs = args->regs;
> +	int cpu = get_cpu();
> +	int ret = NOTIFY_DONE;
> +	siginfo_t info;
> +	struct perf_event *bp = NULL, *kernel_bp, *user_bp;
> +	struct arch_hw_breakpoint *bp_info;
> +
> +	/*
> +	 * Identify the cause of single-stepping and find the corresponding
> +	 * breakpoint structure
> +	 */
> +	user_bp = current->thread.last_hit_ubp;
> +	kernel_bp = per_cpu(last_hit_bp, cpu);
> +	if (user_bp) {
> +		bp = user_bp;
> +		current->thread.last_hit_ubp = NULL;
> +	} else if (kernel_bp) {
> +		bp = kernel_bp;
> +		per_cpu(last_hit_bp, cpu) = NULL;
> +	}

Hopefully you don't have this problem here, so you probably don't need
get/put_cpu() but that won't hurt, since single_step should hopefully
always have interrupts off.

> +	/*
> +	 * Check if we are single-stepping as a result of a
> +	 * previous HW Breakpoint exception
> +	 */
> +	if (!bp)
> +		goto out;
> +
> +	bp_info = counter_arch_bp(bp);
> +
> +	/*
> +	 * We shall invoke the user-defined callback function in the single
> +	 * stepping handler to confirm to 'trigger-after-execute' semantics
> +	 */
> +	perf_bp_event(bp, regs);
> +
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
> +
> +	set_dabr(bp_info->address | bp_info->type | DABR_TRANSLATION);
> +	ret = NOTIFY_STOP;
> +out:
> +	put_cpu();
> +	return ret;
> +}
> +
> +/*
> + * Handle debug exception notifications.
> + */
> +int __kprobes hw_breakpoint_exceptions_notify(
> +		struct notifier_block *unused, unsigned long val, void *data)
> +{
> +	int ret = NOTIFY_DONE;
> +
> +	switch (val) {
> +	case DIE_DABR_MATCH:
> +		ret = hw_breakpoint_handler(data);
> +		break;
> +	case DIE_SSTEP:
> +		ret = single_step_dabr_instruction(data);
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +/*
> + * Release the user breakpoints used by ptrace
> + */
> +void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
> +{
> +	struct thread_struct *t = &tsk->thread;
> +
> +	unregister_hw_breakpoint(t->ptrace_bps[0]);
> +	t->ptrace_bps[0] = NULL;
> +}

Ok, so I see that you call that on context switch. But where do you
re-install the breakpoint for the "new" process ?

See below...

> +void hw_breakpoint_pmu_read(struct perf_event *bp)
> +{
> +	/* TODO */
> +}
> +
> +void hw_breakpoint_pmu_unthrottle(struct perf_event *bp)
> +{
> +	/* TODO */
> +}
> +
> +
> Index: linux-2.6.ppc64_test/arch/powerpc/Kconfig
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/Kconfig
> +++ linux-2.6.ppc64_test/arch/powerpc/Kconfig
> @@ -140,6 +140,7 @@ config PPC
>  	select HAVE_SYSCALL_WRAPPERS if PPC64
>  	select GENERIC_ATOMIC64 if PPC32
>  	select HAVE_PERF_EVENTS
> +	select HAVE_HW_BREAKPOINT if PPC64

Why 64-bit only ? ppc32 has DABR too. In fact BookE also provides DABR
emulation.

Also, all your PPC64 stuff are going to show up on BookE 64-bit which
might not be what you wanted...

>  config EARLY_PRINTK
>  	bool
> Index: linux-2.6.ppc64_test/arch/powerpc/kernel/Makefile
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/Makefile
> +++ linux-2.6.ppc64_test/arch/powerpc/kernel/Makefile
> @@ -33,7 +33,7 @@ obj-y				:= cputable.o ptrace.o syscalls
>  obj-y				+= vdso32/
>  obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
>  				   signal_64.o ptrace32.o \
> -				   paca.o nvram_64.o firmware.o
> +				   paca.o nvram_64.o firmware.o hw_breakpoint.o
>  obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
>  obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
>  obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o
> Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/reg.h
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/reg.h
> +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/reg.h
> @@ -180,6 +180,7 @@
>  #define   CTRL_TE	0x00c00000	/* thread enable */
>  #define   CTRL_RUNLATCH	0x1
>  #define SPRN_DABR	0x3F5	/* Data Address Breakpoint Register */
> +#define   HBP_NUM	1	/* Number of physical HW breakpoint registers */

The above is not quite right. First you already define that in
hw_breakpoint.h. Then, this is too short an identifier for such a
generic file. Finally, it should not be in reg.h since it can vary
from processor to processor. If you want to do things properly, then
add some kind of info about the debug capabilities to cputable.

Please sync with Shaggy so it makes sense on BookE as well.

>  #define   DABR_TRANSLATION	(1UL << 2)
>  #define   DABR_DATA_WRITE	(1UL << 1)
>  #define   DABR_DATA_READ	(1UL << 0)
> Index: linux-2.6.ppc64_test/arch/powerpc/mm/fault.c
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/mm/fault.c
> +++ linux-2.6.ppc64_test/arch/powerpc/mm/fault.c
> @@ -137,6 +137,12 @@ int __kprobes do_page_fault(struct pt_re
>  		error_code &= 0x48200000;
>  	else
>  		is_write = error_code & DSISR_ISSTORE;
> +
> +	if (error_code & DSISR_DABRMATCH) {
> +		/* DABR match */
> +		do_dabr(regs, address, error_code);
> +		return 0;
> +	}

Now that's interesting. I have the feeling that the moving up of this
might actually be a bug fix :-) But it's still wrong due to interrupts
being enabled as I explained earlier. We probably want to make it a
different path out of head_*.S

>  #else
>  	is_write = error_code & ESR_DST;
>  #endif /* CONFIG_4xx || CONFIG_BOOKE */
> @@ -151,14 +157,6 @@ int __kprobes do_page_fault(struct pt_re
>  	if (!user_mode(regs) && (address >= TASK_SIZE))
>  		return SIGSEGV;
>  
> -#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> -  	if (error_code & DSISR_DABRMATCH) {
> -		/* DABR match */
> -		do_dabr(regs, address, error_code);
> -		return 0;
> -	}
> -#endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
> -
>  	if (in_atomic() || mm == NULL) {
>  		if (!user_mode(regs))
>  			return SIGSEGV;
> Index: linux-2.6.ppc64_test/arch/powerpc/include/asm/processor.h
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/include/asm/processor.h
> +++ linux-2.6.ppc64_test/arch/powerpc/include/asm/processor.h
> @@ -209,6 +209,12 @@ struct thread_struct {
>  #ifdef CONFIG_PPC64
>  	unsigned long	start_tb;	/* Start purr when proc switched in */
>  	unsigned long	accum_tb;	/* Total accumilated purr for process */
> +	struct perf_event *ptrace_bps[HBP_NUM];

So you should probably call that MAX_HW_BREAKPOINTS and reflect the fact
that it can be bigger. Or you have a pointer to some optional ptrace
BP structure that handle what is needed, and can be allocated lazily
by ptrace only when needed rather than always carrying this around in
the thread_struct.

> +	/*
> +	 * Point to the hw-breakpoint last. Helps safe pre-emption and
> +	 * hw-breakpoint re-enablement.
> +	 */
> +	struct perf_event *last_hit_ubp;

The comment doesn't make much sense. Preemption doesn't seem quite right
to me unless I missed something and the comment is either too much or
not enough to understand what this is for.

>  #endif
>  	unsigned long	dabr;		/* Data address breakpoint register */
>  #ifdef CONFIG_ALTIVEC
> Index: linux-2.6.ppc64_test/arch/powerpc/kernel/ptrace.c
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/ptrace.c
> +++ linux-2.6.ppc64_test/arch/powerpc/kernel/ptrace.c
> @@ -32,6 +32,8 @@
>  #ifdef CONFIG_PPC32
>  #include <linux/module.h>
>  #endif
> +#include <linux/hw_breakpoint.h>
> +#include <linux/perf_event.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/page.h>
> @@ -763,9 +765,32 @@ void user_disable_single_step(struct tas
>  	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
>  
> +void ptrace_triggered(struct perf_event *bp, int nmi,
> +		      struct perf_sample_data *data, struct pt_regs *regs)
> +{
> +	struct perf_event_attr attr;
> +
> +	/*
> +	 * Disable the breakpoint request here since ptrace has defined a
> +	 * one-shot behaviour for breakpoint exceptions in PPC64.
> +	 * The SIGTRAP signal is generated automatically for us in do_dabr().
> +	 * We don't have to do anything about that here
> +	 */
> +	attr = bp->attr;
> +	attr.disabled = true;
> +	modify_user_hw_breakpoint(bp, &attr);
> +}
> +
>  int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
>  			       unsigned long data)
>  {
> +#ifdef CONFIG_PPC64
> +	int ret;
> +	struct thread_struct *thread = &(task->thread);
> +	struct perf_event *bp;
> +	struct perf_event_attr attr;
> +#endif /* CONFIG_PPC64 */
> +
>  	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
>  	 *  For embedded processors we support one DAC and no IAC's at the
>  	 *  moment.
> @@ -793,6 +818,60 @@ int ptrace_set_debugreg(struct task_stru
>  	/* Ensure breakpoint translation bit is set */
>  	if (data && !(data & DABR_TRANSLATION))
>  		return -EIO;
> +#ifdef CONFIG_PPC64
> +	bp = thread->ptrace_bps[0];
> +	if (data == 0) {
> +		if (bp) {
> +			unregister_hw_breakpoint(bp);
> +			thread->ptrace_bps[0] = NULL;
> +		}
> +		return 0;
> +	}
> +	if (bp) {
> +		attr = bp->attr;
> +		attr.bp_addr = data & ~HW_BREAKPOINT_ALIGN;
> +
> +		switch (data & (DABR_DATA_WRITE | DABR_DATA_READ)) {
> +		case DABR_DATA_READ:
> +			attr.bp_type = HW_BREAKPOINT_R;
> +			break;
> +		case DABR_DATA_WRITE:
> +			attr.bp_type = HW_BREAKPOINT_W;
> +			break;
> +		case (DABR_DATA_WRITE | DABR_DATA_READ):
> +			attr.bp_type = HW_BREAKPOINT_R | HW_BREAKPOINT_W;
> +			break;
> +		}
> +		ret =  modify_user_hw_breakpoint(bp, &attr);
> +		if (ret)
> +			return ret;
> +		thread->ptrace_bps[0] = bp;
> +		thread->dabr = data;
> +		return 0;
> +	}
> +
> +	/* Create a new breakpoint request if one doesn't exist already */
> +	hw_breakpoint_init(&attr);
> +	attr.bp_addr = data & ~HW_BREAKPOINT_ALIGN;
> +	switch (data & (DABR_DATA_WRITE | DABR_DATA_READ)) {
> +	case DABR_DATA_READ:
> +		attr.bp_type = HW_BREAKPOINT_R;
> +		break;
> +	case DABR_DATA_WRITE:
> +		attr.bp_type = HW_BREAKPOINT_W;
> +		break;
> +	case (DABR_DATA_WRITE | DABR_DATA_READ):
> +		attr.bp_type = HW_BREAKPOINT_R | HW_BREAKPOINT_W;
> +		break;
> +	}
> +	thread->ptrace_bps[0] = bp = register_user_hw_breakpoint(&attr,
> +							ptrace_triggered, task);
> +	if (IS_ERR(bp)) {
> +		thread->ptrace_bps[0] = NULL;
> +		return PTR_ERR(bp);
> +	}
> +
> +#endif /* CONFIG_PPC64 */
>  
>  	/* Move contents to the DABR register */
>  	task->thread.dabr = data;
> Index: linux-2.6.ppc64_test/arch/powerpc/kernel/process.c
> ===================================================================
> --- linux-2.6.ppc64_test.orig/arch/powerpc/kernel/process.c
> +++ linux-2.6.ppc64_test/arch/powerpc/kernel/process.c
> @@ -48,6 +48,7 @@
>  #include <asm/machdep.h>
>  #include <asm/time.h>
>  #include <asm/syscalls.h>
> +#include <asm/hw_breakpoint.h>
>  #ifdef CONFIG_PPC64
>  #include <asm/firmware.h>
>  #endif
> @@ -459,8 +460,11 @@ struct task_struct *__switch_to(struct t
>  #ifdef CONFIG_PPC_ADV_DEBUG_REGS
>  	switch_booke_debug_regs(&new->thread);
>  #else
> +/* For PPC64, we use the hw-breakpoint interfaces that would schedule DABR */
> +#ifndef CONFIG_PPC64
>  	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
>  		set_dabr(new->thread.dabr);
> +#endif /* CONFIG_PPC64 */
>  #endif
>  
> 
> @@ -479,6 +483,7 @@ struct task_struct *__switch_to(struct t
>  		old_thread->accum_tb += (current_tb - start_tb);
>  		new_thread->start_tb = current_tb;
>  	}
> +	flush_ptrace_hw_breakpoint(current);
>  #endif
>  
>  	local_irq_save(flags);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
