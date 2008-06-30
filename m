Return-Path: <luisgpm@linux.vnet.ibm.com>
Received: from igw3.br.ibm.com (igw3.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "igw3.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A2AEEDDFE7
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 05:16:40 +1000 (EST)
Received: from mailhub1.br.ibm.com (unknown [9.18.232.109])
	by igw3.br.ibm.com (Postfix) with ESMTP id 6D8C0390153
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 15:59:18 -0300 (BRST)
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.18.232.46])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5UJGbej2114034
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 16:16:37 -0300
Received: from d24av01.br.ibm.com (loopback [127.0.0.1])
	by d24av01.br.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5UJGWJx019542
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 16:16:33 -0300
Subject: Re: [RFC] 4xx hardware watchpoint support
From: Luis Machado <luisgpm@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1213992894.6635.41.camel@gargoyle>
References: <1211391577.6232.15.camel@gargoyle>
	<18484.60888.981390.893747@cargo.ozlabs.ibm.com>
	<1213992894.6635.41.camel@gargoyle>
Content-Type: text/plain
Date: Mon, 30 Jun 2008 16:16:35 -0300
Message-Id: <1214853396.21286.68.camel@gargoyle>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: luisgpm@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi guys,

Did anyone have a chance to go over this patch? Looking forward to
receive feedbacks on it.

Thanks!

Regards,
Luis

On Fri, 2008-06-20 at 17:14 -0300, Luis Machado wrote:
> On Thu, 2008-05-22 at 13:51 +1000, Paul Mackerras wrote:
> > Luis Machado writes:
> > 
> > > This is a patch that has been sitting idle for quite some time. I
> > > decided to move it further because it is something useful. It was
> > > originally written by Michel Darneille, based off of 2.6.16.
> > > 
> > > The original patch, though, was not compatible with the current DABR
> > > logic. DABR's are used to implement hardware watchpoint support for
> > > ppc64 processors (i.e. 970, Power5 etc). 4xx's have a different
> > > debugging register layout and needs to be handled differently (they two
> > > registers: DAC and DBCR0).
> > 
> > Yes, they are different, but they do essentially the same thing, so I
> > think we should try and unify the handling of the two.  Maybe you
> > could rename set_dabr() to set_hw_watchpoint() or something and make
> > it set DABR on 64-bit and "classic" 32-bit processors, and DAC on
> > 4xx/Book E processors.
> > 
> > Likewise, I don't think we need both a "dabr" field and a "dac" field
> > in the thread_struct - one should do.  Rename "dabr" to something else
> > if you feel that the "dabr" name is too ppc64-specific.  And I don't
> > think we need both __debugger_dabr_match and __debugger_dac_match.
> > 
> > > 5) This is something i'm worried about for future features. We currently
> > > have a way to support only Hardware Watchpoints, but not Hardware
> > > Breakpoints (on 64-bit processors that have a IABR register or 32-bit
> > > processors carrying the IAC register). Looking at the code, we don't
> > > differentiate a watchpoint from a breakpoint request. A ptrace call has
> > > currently 3 arguments: REQUEST, ADDR and DATA. We use REQUEST and DATA
> > > to set a hardware watchpoint. Maybe we could use the ADDR parameter to
> > > set a hardware breakpoint? Or use it to tell the kernel whether we want
> > > a hardware watchpoint or hardware breakpoint and then pass the address
> > > of the instruction/data through the DATA parameter? What do you think?
> > 
> > I would think there would be a different REQUEST value to mean "set a
> > hardware breakpoint".  Roland McGrath (cc'd) might be able to tell us
> > what other architectures do.
> > 
> > Paul.
> 
> Paul,
> 
> Follows a re-worked patch that unifies the handling of hardware
> watchpoint structures for DABR-based and DAC-based processors.
> 
> The flow is exactly the same for DABR-based processors.
> 
> As for the DAC-based code, i've eliminated the "dac" field from the
> thread structure, since now we use the "dabr" field to represent DAC1 of
> the DAC-based processors. As a consequence, i removed all the
> occurrences of "dac" throughout the code, using "dabr" in those cases.
> 
> The function "set_dabr" sets the correct register (DABR OR DAC) for each
> specific processor now, instead of only setting the value for DABR-based
> processors.
> 
> "do_dac" was merged with "do_dabr" as they were mostly equivalent pieces
> of code. I've moved "do_dabr" to "arch/powerpc/kernel/process.c" so it
> is visible for DAC-based code as well.
> 
> Tested on a Taishan 440GX with success.
> 
> Is it OK to leave it as "dabr" for both DABR and DAC? What do you think
> of the patch overall?
> 
> Thanks,
> 
> Best regards,
> Luis
> 
> 
> Index: linux-2.6.25-oldpatch/arch/powerpc/kernel/process.c
> ===================================================================
> --- linux-2.6.25-oldpatch.orig/arch/powerpc/kernel/process.c	2008-06-20 02:48:19.000000000 -0700
> +++ linux-2.6.25-oldpatch/arch/powerpc/kernel/process.c	2008-06-20 02:51:16.000000000 -0700
> @@ -241,6 +241,35 @@
>  }
>  #endif /* CONFIG_SMP */
> 
> +void do_dabr(struct pt_regs *regs, unsigned long address,
> +		    unsigned long error_code)
> +{
> +	siginfo_t info;
> +
> +#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
> +	if (notify_die(DIE_DABR_MATCH, "dabr_match", regs, error_code,
> +			11, SIGSEGV) == NOTIFY_STOP)
> +		return;
> +
> +	if (debugger_dabr_match(regs))
> +		return;
> +#else
> +        /* Clear the DAC and struct entries.  One shot trigger.  */
> +        mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R | DBSR_DAC1W
> +                                                        | DBCR0_IDM));
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
>  static DEFINE_PER_CPU(unsigned long, current_dabr);
> 
>  int set_dabr(unsigned long dabr)
> @@ -256,6 +285,11 @@
>  #if defined(CONFIG_PPC64) || defined(CONFIG_6xx)
>  	mtspr(SPRN_DABR, dabr);
>  #endif
> +
> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> +	mtspr(SPRN_DAC1, dabr);
> +#endif
> +
>  	return 0;
>  }
> 
> @@ -330,6 +364,12 @@
>  	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
>  		set_dabr(new->thread.dabr);
> 
> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> +	/* If new thread DAC (HW breakpoint) is the same then leave it.  */
> +	if (new->thread.dabr)
> +		set_dabr(new->thread.dabr);
> +#endif
> +
>  	new_thread = &new->thread;
>  	old_thread = &current->thread;
> 
> @@ -518,6 +558,10 @@
>  	if (current->thread.dabr) {
>  		current->thread.dabr = 0;
>  		set_dabr(0);
> +
> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> +		current->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W);
> +#endif
>  	}
>  }
> 
> Index: linux-2.6.25-oldpatch/arch/powerpc/kernel/ptrace.c
> ===================================================================
> --- linux-2.6.25-oldpatch.orig/arch/powerpc/kernel/ptrace.c	2008-06-20 02:48:19.000000000 -0700
> +++ linux-2.6.25-oldpatch/arch/powerpc/kernel/ptrace.c	2008-06-20 05:10:59.000000000 -0700
> @@ -616,7 +616,7 @@
> 
>  	if (regs != NULL) {
>  #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> -		task->thread.dbcr0 = DBCR0_IDM | DBCR0_IC;
> +		task->thread.dbcr0 |= DBCR0_IDM | DBCR0_IC;
>  		regs->msr |= MSR_DE;
>  #else
>  		regs->msr |= MSR_SE;
> @@ -629,9 +629,16 @@
>  {
>  	struct pt_regs *regs = task->thread.regs;
> 
> +
> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> +	/* If DAC then do not single step, skip.  */
> +	if (task->thread.dabr)
> +		return;
> +#endif
> +
>  	if (regs != NULL) {
>  #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> -		task->thread.dbcr0 = 0;
> +		task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_IDM);
>  		regs->msr &= ~MSR_DE;
>  #else
>  		regs->msr &= ~MSR_SE;
> @@ -640,22 +647,79 @@
>  	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
> 
> -static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
> +static int ptrace_get_debugreg(struct task_struct *task, unsigned long data)
> +{
> +	int ret;
> +
> +	ret = put_user(task->thread.dabr,
> +			(unsigned long __user *)data);
> +	return ret;
> +}
> +
> +int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
>  			       unsigned long data)
>  {
> -	/* We only support one DABR and no IABRS at the moment */
> +	/* For ppc64 we support one DABR and no IABR's at the moment (ppc64).
> +	   For embedded processors we support one DAC and no IAC's
> +	   at the moment.  */
>  	if (addr > 0)
>  		return -EINVAL;
> 
> -	/* The bottom 3 bits are flags */
>  	if ((data & ~0x7UL) >= TASK_SIZE)
>  		return -EIO;
> 
> -	/* Ensure translation is on */
> +#ifdef CONFIG_PPC64
> +
> +	/* For processors using DABR (i.e. 970), the bottom 3 bits are flags.
> +	   It was assumed, on previous implementations, that 3 bits were
> +	   passed together with the data address, fitting the design of the
> +	   DABR register, as follows:
> +
> +	   bit 0: Read flag
> +	   bit 1: Write flag
> +	   bit 2: Breakpoint translation
> +
> +	   Thus, we use them here as so.  */
> +
> +	/* Ensure breakpoint translation bit is set.  */
>  	if (data && !(data & DABR_TRANSLATION))
>  		return -EIO;
> 
> +	/* Move contents to the DABR register.  */
>  	task->thread.dabr = data;
> +
> +#endif
> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> +
> +	/* As described above, we assume 3 bits are passed with the data
> +	   address, so mask them so we can set the DAC register with the
> +	   correct address.  */
> +	/* DAC's hold the whole address without any mode flags.  */
> +	task->thread.dabr = data & ~0x3UL;
> +
> +	if (task->thread.dabr == 0) {
> +		task->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W | DBCR0_IDM);
> +		task->thread.regs->msr &= ~MSR_DE;
> +		return 0;
> +	}
> +
> +        /* Read or Write bits must be set.  */
> +
> +        if (!(data & 0x3UL))
> +                return -EINVAL;
> +
> +	/* Set the Internal Debugging flag (IDM bit 1) for the DBCR0
> +	   register.  */
> +	task->thread.dbcr0 = DBCR0_IDM;
> +
> +	/* Check for write and read flags and set DBCR0 accordingly.  */
> +	if (data & 0x1UL)
> +		task->thread.dbcr0 |= DBSR_DAC1R;
> +	if (data & 0x2UL)
> +		task->thread.dbcr0 |= DBSR_DAC1W;
> +
> +	task->thread.regs->msr |= MSR_DE;
> +#endif
>  	return 0;
>  }
> 
> Index: linux-2.6.25-oldpatch/arch/powerpc/kernel/signal.c
> ===================================================================
> --- linux-2.6.25-oldpatch.orig/arch/powerpc/kernel/signal.c	2008-06-20 02:48:19.000000000 -0700
> +++ linux-2.6.25-oldpatch/arch/powerpc/kernel/signal.c	2008-06-20 02:51:16.000000000 -0700
> @@ -144,8 +144,12 @@
>  	 * user space. The DABR will have been cleared if it
>  	 * triggered inside the kernel.
>  	 */
> -	if (current->thread.dabr)
> +	if (current->thread.dabr) {
>  		set_dabr(current->thread.dabr);
> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> +		mtspr(SPRN_DBCR0, current->thread.dbcr0);
> +#endif
> +	}
> 
>  	if (is32) {
>          	if (ka.sa.sa_flags & SA_SIGINFO)
> Index: linux-2.6.25-oldpatch/arch/powerpc/kernel/traps.c
> ===================================================================
> --- linux-2.6.25-oldpatch.orig/arch/powerpc/kernel/traps.c	2008-06-20 02:48:19.000000000 -0700
> +++ linux-2.6.25-oldpatch/arch/powerpc/kernel/traps.c	2008-06-20 02:54:37.000000000 -0700
> @@ -1045,6 +1045,21 @@
>  				return;
>  		}
>  		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
> +	} else if (debug_status & (DBSR_DAC1R | DBSR_DAC1W)) {
> +		regs->msr &= ~MSR_DE;
> +	        printk("\nWatchpoint Triggered\n");
> +		if (user_mode(regs)) {
> +			current->thread.dbcr0 &= ~(DBSR_DAC1R | DBSR_DAC1W |
> +								DBCR0_IDM);
> +		} else {
> +			/* Disable DAC interupts.  */
> +			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~(DBSR_DAC1R |
> +							DBSR_DAC1W | DBCR0_IDM));
> +			/* Clear the DAC event.  */
> +			mtspr(SPRN_DBSR, (DBSR_DAC1R | DBSR_DAC1W));
> +		}
> +		/* Setup and send the trap to the handler.  */
> +		do_dabr(regs, mfspr(SPRN_DAC1), debug_status);
>  	}
>  }
>  #endif /* CONFIG_4xx || CONFIG_BOOKE */
> Index: linux-2.6.25-oldpatch/arch/powerpc/kernel/entry_32.S
> ===================================================================
> --- linux-2.6.25-oldpatch.orig/arch/powerpc/kernel/entry_32.S	2008-06-20 02:48:19.000000000 -0700
> +++ linux-2.6.25-oldpatch/arch/powerpc/kernel/entry_32.S	2008-06-20 02:51:16.000000000 -0700
> @@ -112,7 +112,7 @@
>  	/* Check to see if the dbcr0 register is set up to debug.  Use the
>  	   internal debug mode bit to do this. */
>  	lwz	r12,THREAD_DBCR0(r12)
> -	andis.	r12,r12,DBCR0_IDM@h
> +	andis.	r12,r12,(DBCR0_IDM  | DBSR_DAC1R | DBSR_DAC1W)@h
>  	beq+	3f
>  	/* From user and task is ptraced - load up global dbcr0 */
>  	li	r12,-1			/* clear all pending debug events */
> @@ -248,7 +248,7 @@
>  	/* If the process has its own DBCR0 value, load it up.  The internal
>  	   debug mode bit tells us that dbcr0 should be loaded. */
>  	lwz	r0,THREAD+THREAD_DBCR0(r2)
> -	andis.	r10,r0,DBCR0_IDM@h
> +	andis.	r10,r0,(DBCR0_IDM  | DBSR_DAC1R | DBSR_DAC1W)@h
>  	bnel-	load_dbcr0
>  #endif
>  #ifdef CONFIG_44x
> @@ -676,7 +676,7 @@
>  	/* Check whether this process has its own DBCR0 value.  The internal
>  	   debug mode bit tells us that dbcr0 should be loaded. */
>  	lwz	r0,THREAD+THREAD_DBCR0(r2)
> -	andis.	r10,r0,DBCR0_IDM@h
> +	andis.	r10,r0,(DBCR0_IDM  | DBSR_DAC1R | DBSR_DAC1W)@h
>  	bnel-	load_dbcr0
>  #endif
> 
> Index: linux-2.6.25-oldpatch/arch/powerpc/mm/fault.c
> ===================================================================
> --- linux-2.6.25-oldpatch.orig/arch/powerpc/mm/fault.c	2008-06-20 02:48:19.000000000 -0700
> +++ linux-2.6.25-oldpatch/arch/powerpc/mm/fault.c	2008-06-20 02:51:16.000000000 -0700
> @@ -100,31 +100,6 @@
>  	return 0;
>  }
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
>  /*
>   * For 600- and 800-family processors, the error_code parameter is DSISR
>   * for a data fault, SRR1 for an instruction fault. For 400-family processors
> Index: linux-2.6.25-oldpatch/include/asm-powerpc/system.h
> ===================================================================
> --- linux-2.6.25-oldpatch.orig/include/asm-powerpc/system.h	2008-06-20 02:48:19.000000000 -0700
> +++ linux-2.6.25-oldpatch/include/asm-powerpc/system.h	2008-06-20 02:51:16.000000000 -0700
> @@ -103,6 +103,8 @@
>  #endif
> 
>  extern int set_dabr(unsigned long dabr);
> +extern void do_dabr(struct pt_regs *regs, unsigned long address,
> +                    unsigned long error_code);
>  extern void print_backtrace(unsigned long *);
>  extern void show_regs(struct pt_regs * regs);
>  extern void flush_instruction_cache(void);
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
