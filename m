Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp05.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3D457DDFB7
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 14:31:11 +1000 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp05.au.ibm.com (8.13.1/8.13.1) with ESMTP id n4T4T2qB030193
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 14:29:02 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4T4V7jX573520
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 14:31:07 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4T4V69T022007
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 14:31:07 +1000
Date: Fri, 29 May 2009 14:29:40 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "K.Prasad" <prasad@linux.vnet.ibm.com>
Subject: Re: [Patch 4/6] Modify process and processor handling code to
	recognise hardware debug registers
Message-ID: <20090529042940.GE8621@yookeroo.seuss>
References: <20090525004730.944465878@prasadkr_t60p.in.ibm.com>
	<20090525011650.GE11078@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090525011650.GE11078@in.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	linuxppc-dev@ozlabs.org, Alan Stern <stern@rowland.harvard.edu>,
	paulus@samba.org, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 06:46:50AM +0530, K.Prasad wrote:
> Modify process handling code to recognise hardware debug registers during copy
> and flush operations. Introduce a new TIF_DEBUG task flag to indicate a
> process's use of debug register. Load the debug register values into a
> new CPU during initialisation.

[snip]
> Index: linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
> ===================================================================
> --- linux-2.6-tip.hbkpt.orig/arch/powerpc/kernel/process.c
> +++ linux-2.6-tip.hbkpt/arch/powerpc/kernel/process.c
> @@ -50,6 +50,7 @@
>  #include <asm/syscalls.h>
>  #ifdef CONFIG_PPC64
>  #include <asm/firmware.h>
> +#include <asm/hw_breakpoint.h>
>  #endif
>  #include <linux/kprobes.h>
>  #include <linux/kdebug.h>
> @@ -254,8 +255,10 @@ void do_dabr(struct pt_regs *regs, unsig
>  			11, SIGSEGV) == NOTIFY_STOP)
>  		return;
>  
> +#ifndef CONFIG_PPC64
>  	if (debugger_dabr_match(regs))
>  		return;
> +#endif
>  
>  	/* Clear the DAC and struct entries.  One shot trigger */
>  #if defined(CONFIG_BOOKE)
> @@ -372,8 +375,13 @@ struct task_struct *__switch_to(struct t
>  
>  #endif /* CONFIG_SMP */
>  
> +#ifdef CONFIG_PPC64
> +		if (unlikely(test_tsk_thread_flag(new, TIF_DEBUG)))
> +			arch_install_thread_hw_breakpoint(new);
> +#else
>  	if (unlikely(__get_cpu_var(current_dabr) != new->thread.dabr))
>  		set_dabr(new->thread.dabr);
> +#endif /* CONFIG_PPC64 */
>  
>  #if defined(CONFIG_BOOKE)
>  	/* If new thread DAC (HW breakpoint) is the same then leave it */
> @@ -550,6 +558,10 @@ void show_regs(struct pt_regs * regs)
>  void exit_thread(void)
>  {
>  	discard_lazy_cpu_state();
> +#ifdef CONFIG_PPC64
> +	if (unlikely(test_tsk_thread_flag(current, TIF_DEBUG)))
> +		flush_thread_hw_breakpoint(current);
> +#endif /* CONFIG_PPC64 */
>  }
>  
>  void flush_thread(void)
> @@ -605,6 +617,9 @@ int copy_thread(unsigned long clone_flag
>  	struct pt_regs *childregs, *kregs;
>  	extern void ret_from_fork(void);
>  	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
> +#ifdef CONFIG_PPC64
> +	struct task_struct *tsk = current;

I don't see any point to adding this variable, just reference current
directly  below.

> +#endif
>  
>  	CHECK_FULL_REGS(regs);
>  	/* Copy registers */
> @@ -672,6 +687,9 @@ int copy_thread(unsigned long clone_flag
>  	 * function.
>   	 */
>  	kregs->nip = *((unsigned long *)ret_from_fork);
> +
> +	if (unlikely(test_tsk_thread_flag(tsk, TIF_DEBUG)))
> +		copy_thread_hw_breakpoint(tsk, p, clone_flags);
>  #else
>  	kregs->nip = (unsigned long)ret_from_fork;
>  #endif

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
