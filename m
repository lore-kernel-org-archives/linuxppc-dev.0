Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1B117DE368
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 01:37:17 +1000 (EST)
Message-Id: <D0181479-D675-4DDB-B97B-A9C25B0301D0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: luisgpm@linux.vnet.ibm.com
In-Reply-To: <1216829442.5727.97.camel@gargoyle>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC] 4xx hardware watchpoint support
Date: Fri, 25 Jul 2008 10:22:51 -0500
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
	<20080719093752.5aada45c@zod.rchland.ibm.com>
	<1216658194.5727.36.camel@gargoyle>
	<20080721130551.23a06006@zod.rchland.ibm.com>
	<1216777678.5727.82.camel@gargoyle>
	<20080723115321.53aa655b@zod.rchland.ibm.com>
	<1216829442.5727.97.camel@gargoyle>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Christoph Hellwig <hch@lst.de>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 23, 2008, at 11:10 AM, Luis Machado wrote:

> On Wed, 2008-07-23 at 11:53 -0400, Josh Boyer wrote:
>> Shouldn't this (and other places) be:
>>
>> #if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
>>
>> if you are going to exclude 40x for now?  Otherwise this is still
>> enabled on 405 and setting the wrong register.
>>
>> josh
>
> Yes, sorry. I wasn't aware of this specific define value. It makes
> things easier to support 405's later.
>
> Like so?
>
> This addresses Christoph's comments as well.
>
>
> Signed-off-by: Luis Machado <luisgpm@br.ibm.com>
>
> Index: linux-2.6.26/arch/powerpc/kernel/entry_32.S
> ===================================================================
> --- linux-2.6.26.orig/arch/powerpc/kernel/entry_32.S	2008-07-23  
> 07:44:57.000000000 -0700
> +++ linux-2.6.26/arch/powerpc/kernel/entry_32.S	2008-07-23  
> 07:50:31.000000000 -0700
> @@ -148,7 +148,7 @@
> 	/* Check to see if the dbcr0 register is set up to debug.  Use the
> 	   internal debug mode bit to do this. */
> 	lwz	r12,THREAD_DBCR0(r12)
> -	andis.	r12,r12,DBCR0_IDM@h
> +	andis.	r12,r12,(DBCR0_IDM  | DBSR_DAC1R | DBSR_DAC1W)@h

why the change here?  Is IDM not always on in this case for 44x?
>
> 	beq+	3f
> 	/* From user and task is ptraced - load up global dbcr0 */
> 	li	r12,-1			/* clear all pending debug events */
> @@ -292,7 +292,7 @@
> 	/* If the process has its own DBCR0 value, load it up.  The internal
> 	   debug mode bit tells us that dbcr0 should be loaded. */
> 	lwz	r0,THREAD+THREAD_DBCR0(r2)
> -	andis.	r10,r0,DBCR0_IDM@h
> +	andis.	r10,r0,(DBCR0_IDM  | DBSR_DAC1R | DBSR_DAC1W)@h
> 	bnel-	load_dbcr0
> #endif
> #ifdef CONFIG_44x
> @@ -720,7 +720,7 @@
> 	/* Check whether this process has its own DBCR0 value.  The internal
> 	   debug mode bit tells us that dbcr0 should be loaded. */
> 	lwz	r0,THREAD+THREAD_DBCR0(r2)
> -	andis.	r10,r0,DBCR0_IDM@h
> +	andis.	r10,r0,(DBCR0_IDM  | DBSR_DAC1R | DBSR_DAC1W)@h
> 	bnel-	load_dbcr0
> #endif
>
> Index: linux-2.6.26/arch/powerpc/kernel/process.c
> ===================================================================
> --- linux-2.6.26.orig/arch/powerpc/kernel/process.c	2008-07-23  
> 07:44:57.000000000 -0700
> +++ linux-2.6.26/arch/powerpc/kernel/process.c	2008-07-23  
> 07:50:31.000000000 -0700
> @@ -47,6 +47,8 @@
> #ifdef CONFIG_PPC64
> #include <asm/firmware.h>
> #endif
> +#include <linux/kprobes.h>
> +#include <linux/kdebug.h>
>
> extern unsigned long _get_SP(void);
>
> @@ -239,6 +241,35 @@
> }
> #endif /* CONFIG_SMP */
>
> +void do_dabr(struct pt_regs *regs, unsigned long address,
> +		    unsigned long error_code)
> +{
> +	siginfo_t info;
> +
> +	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
> +			11, SIGSEGV) == NOTIFY_STOP)
> +		return;
> +
> +	if (debugger_dabr_match(regs))
> +		return;
> +
> +	/* Clear the DAC and struct entries.  One shot trigger */
> +#if (defined(CONFIG_44x) || defined(CONFIG_BOOKE))

this is redundant.  CONFIG_BOOKE is sufficient.

>
> +	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R | DBSR_DAC1W
> +							| DBCR0_IDM));
> +#endif
> +
> +	/* Clear the DABR */
> +	set_dabr(0);
> +
> +	/* Deliver the signal to userspace */
> +	info.si_signo = SIGTRAP;
> +	info.si_errno = 0;
> +	info.si_code = TRAP_HWBKPT;
> +	info.si_addr = (void __user *)address;
> +	force_sig_info(SIGTRAP, &info, current);
> +}
> +
> static DEFINE_PER_CPU(unsigned long, current_dabr);
>
> int set_dabr(unsigned long dabr)
> @@ -254,6 +285,11 @@
> #if defined(CONFIG_PPC64) || defined(CONFIG_6xx)
> 	mtspr(SPRN_DABR, dabr);
> #endif
> +
> +#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)

ditto.

>
> +	mtspr(SPRN_DAC1, dabr);
> +#endif
> +
> 	return 0;
> }
>
> @@ -337,6 +373,12 @@
> 	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
> 		set_dabr(new->thread.dabr);
>
> +#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
> +	/* If new thread DAC (HW breakpoint) is the same then leave it */
> +	if (new->thread.dabr)
> +		set_dabr(new->thread.dabr);
> +#endif
> +
> 	new_thread = &new->thread;
> 	old_thread = &current->thread;
>
> @@ -525,6 +567,10 @@
> 	if (current->thread.dabr) {
> 		current->thread.dabr = 0;
> 		set_dabr(0);
> +
> +#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
> +		current->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W);
> +#endif
> 	}
> }
>
> Index: linux-2.6.26/arch/powerpc/kernel/ptrace.c
> ===================================================================
> --- linux-2.6.26.orig/arch/powerpc/kernel/ptrace.c	2008-07-23  
> 07:44:57.000000000 -0700
> +++ linux-2.6.26/arch/powerpc/kernel/ptrace.c	2008-07-23  
> 07:53:45.000000000 -0700
> @@ -703,7 +703,7 @@
>
> 	if (regs != NULL) {
> #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> -		task->thread.dbcr0 = DBCR0_IDM | DBCR0_IC;
> +		task->thread.dbcr0 |= DBCR0_IDM | DBCR0_IC;
> 		regs->msr |= MSR_DE;
> #else
> 		regs->msr |= MSR_SE;
> @@ -716,9 +716,16 @@
> {
> 	struct pt_regs *regs = task->thread.regs;
>
> +
> +#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)
> +	/* If DAC then do not single step, skip */
> +	if (task->thread.dabr)
> +		return;
> +#endif
> +
> 	if (regs != NULL) {
> #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> -		task->thread.dbcr0 = 0;
> +		task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_IDM);
> 		regs->msr &= ~MSR_DE;
> #else
> 		regs->msr &= ~MSR_SE;
> @@ -727,22 +734,75 @@
> 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
> }
>
> -static int ptrace_set_debugreg(struct task_struct *task, unsigned  
> long addr,
> +int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
> 			       unsigned long data)
> {
> -	/* We only support one DABR and no IABRS at the moment */
> +	/* For ppc64 we support one DABR and no IABR's at the moment  
> (ppc64).
> +	 *  For embedded processors we support one DAC and no IAC's at the
> +	 *  moment.
> +	 */
> 	if (addr > 0)
> 		return -EINVAL;
>
> -	/* The bottom 3 bits are flags */

fix the comment, don't remove it.

>
> 	if ((data & ~0x7UL) >= TASK_SIZE)
> 		return -EIO;
>
> -	/* Ensure translation is on */
> +#ifdef CONFIG_PPC64

make this ifndef CONFIG_BOOKE, its not PPC64 specific.

>
> +
> +	/* For processors using DABR (i.e. 970), the bottom 3 bits are  
> flags.
> +	 *  It was assumed, on previous implementations, that 3 bits were
> +	 *  passed together with the data address, fitting the design of the
> +	 *  DABR register, as follows:
> +	 *
> +	 *  bit 0: Read flag
> +	 *  bit 1: Write flag
> +	 *  bit 2: Breakpoint translation
> +	 *
> +	 *  Thus, we use them here as so.
> +	 */
> +
> +	/* Ensure breakpoint translation bit is set */
> 	if (data && !(data & DABR_TRANSLATION))
> 		return -EIO;
>
> +	/* Move contents to the DABR register */
> 	task->thread.dabr = data;
> +
> +#endif
> +#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)

see comment above.
>
> +
> +	/* As described above, it was assumed 3 bits were passed with the  
> data
> +	 *  address, but we will assume only the mode bits will be passed
> +	 *  as to not cause alignment restrictions for DAC-based processors.
> +	 */
> +
> +	/* DAC's hold the whole address without any mode flags */
> +	task->thread.dabr = data & ~0x3UL;
> +
> +	if (task->thread.dabr == 0) {
> +		task->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W | DBCR0_IDM);
> +		task->thread.regs->msr &= ~MSR_DE;
> +		return 0;
> +	}
> +
> +	/* Read or Write bits must be set */
> +
> +	if (!(data & 0x3UL))
> +		return -EINVAL;
> +
> +	/* Set the Internal Debugging flag (IDM bit 1) for the DBCR0
> +	   register */
> +	task->thread.dbcr0 = DBCR0_IDM;
> +
> +	/* Check for write and read flags and set DBCR0
> +	   accordingly */
> +	if (data & 0x1UL)
> +		task->thread.dbcr0 |= DBSR_DAC1R;
> +	if (data & 0x2UL)
> +		task->thread.dbcr0 |= DBSR_DAC1W;
> +
> +	task->thread.regs->msr |= MSR_DE;
> +#endif
> 	return 0;
> }
>
> Index: linux-2.6.26/arch/powerpc/kernel/signal.c
> ===================================================================
> --- linux-2.6.26.orig/arch/powerpc/kernel/signal.c	2008-07-23  
> 07:44:57.000000000 -0700
> +++ linux-2.6.26/arch/powerpc/kernel/signal.c	2008-07-23  
> 07:50:31.000000000 -0700
> @@ -145,8 +145,12 @@
> 	 * user space. The DABR will have been cleared if it
> 	 * triggered inside the kernel.
> 	 */
> -	if (current->thread.dabr)
> +	if (current->thread.dabr) {
> 		set_dabr(current->thread.dabr);
> +#if defined(CONFIG_44x) || defined(CONFIG_BOOKE)

see comment above
>
> +		mtspr(SPRN_DBCR0, current->thread.dbcr0);
> +#endif
> +	}
>
> 	if (is32) {
>         	if (ka.sa.sa_flags & SA_SIGINFO)
> Index: linux-2.6.26/arch/powerpc/kernel/traps.c
> ===================================================================
> --- linux-2.6.26.orig/arch/powerpc/kernel/traps.c	2008-07-23  
> 07:44:57.000000000 -0700
> +++ linux-2.6.26/arch/powerpc/kernel/traps.c	2008-07-23  
> 07:50:31.000000000 -0700
> @@ -1067,6 +1067,22 @@
> 		}
>
> 		_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
> +	} else if (debug_status & (DBSR_DAC1R | DBSR_DAC1W)) {
> +		regs->msr &= ~MSR_DE;
> +
> +		if (user_mode(regs)) {
> +			current->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W |
> +								DBCR0_IDM);
> +		} else {
> +			/* Disable DAC interupts */
> +			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R |
> +						DBSR_DAC1W | DBCR0_IDM));
> +
> +			/* Clear the DAC event */
> +			mtspr(SPRN_DBSR, (DBSR_DAC1R | DBSR_DAC1W));
> +		}
> +		/* Setup and send the trap to the handler */
> +		do_dabr(regs, mfspr(SPRN_DAC1), debug_status);
> 	}
> }
> #endif /* CONFIG_4xx || CONFIG_BOOKE */
> Index: linux-2.6.26/arch/powerpc/mm/fault.c
> ===================================================================
> --- linux-2.6.26.orig/arch/powerpc/mm/fault.c	2008-07-23  
> 07:44:57.000000000 -0700
> +++ linux-2.6.26/arch/powerpc/mm/fault.c	2008-07-23  
> 07:50:31.000000000 -0700
> @@ -100,31 +100,6 @@
> 	return 0;
> }
>
> -#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> -static void do_dabr(struct pt_regs *regs, unsigned long address,
> -		    unsigned long error_code)
> -{
> -	siginfo_t info;
> -
> -	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
> -			11, SIGSEGV) == NOTIFY_STOP)
> -		return;
> -
> -	if (debugger_dabr_match(regs))
> -		return;
> -
> -	/* Clear the DABR */
> -	set_dabr(0);
> -
> -	/* Deliver the signal to userspace */
> -	info.si_signo = SIGTRAP;
> -	info.si_errno = 0;
> -	info.si_code = TRAP_HWBKPT;
> -	info.si_addr = (void __user *)address;
> -	force_sig_info(SIGTRAP, &info, current);
> -}
> -#endif /* !(CONFIG_4xx || CONFIG_BOOKE)*/
> -
> /*
>  * For 600- and 800-family processors, the error_code parameter is  
> DSISR
>  * for a data fault, SRR1 for an instruction fault. For 400-family  
> processors
> Index: linux-2.6.26/include/asm-powerpc/system.h
> ===================================================================
> --- linux-2.6.26.orig/include/asm-powerpc/system.h	2008-07-23  
> 07:44:57.000000000 -0700
> +++ linux-2.6.26/include/asm-powerpc/system.h	2008-07-23  
> 07:50:31.000000000 -0700
> @@ -110,6 +110,8 @@
> #endif
>
> extern int set_dabr(unsigned long dabr);
> +extern void do_dabr(struct pt_regs *regs, unsigned long address,
> +		    unsigned long error_code);
> extern void print_backtrace(unsigned long *);
> extern void show_regs(struct pt_regs * regs);
> extern void flush_instruction_cache(void);
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
