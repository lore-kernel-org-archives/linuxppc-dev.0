Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E469CDDEF5
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Apr 2009 16:27:06 +1100 (EST)
Subject: Re: [PATCH] powerpc ptrace block-step
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roland McGrath <roland@redhat.com>
In-Reply-To: <20090401215903.DE872FC3AB@magilla.sf.frob.com>
References: <20090401215903.DE872FC3AB@magilla.sf.frob.com>
Content-Type: text/plain
Date: Thu, 02 Apr 2009 16:26:56 +1100
Message-Id: <1238650016.17330.193.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, utrace-devel@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-04-01 at 14:59 -0700, Roland McGrath wrote:

> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index c9c678f..d7692b8 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -135,7 +135,9 @@ do {									      \
>   * These are defined as per linux/ptrace.h, which see.
>   */
>  #define arch_has_single_step()	(1)
> +#define arch_has_block_step()	(1)

The patch only implements it for "server/classic" processors, not BookE,
thus it should probably only advertise it for these :-)

Though it wouldn't be too hard to implement it for BookE using DBCR0:BRT
(Branch Taken debug event) though it might need some careful fixups such
as the one we have for single step regarding hitting exception entry
code.

Cheers,
Ben.

>  extern void user_enable_single_step(struct task_struct *);
> +extern void user_enable_block_step(struct task_struct *);
>  extern void user_disable_single_step(struct task_struct *);
>
>  #endif /* __ASSEMBLY__ */
> @@ -288,4 +290,6 @@ extern void user_disable_single_step(struct task_struct *);
>  #define PPC_PTRACE_PEEKUSR_3264  0x91
>  #define PPC_PTRACE_POKEUSR_3264  0x90
>  
> +#define PTRACE_SINGLEBLOCK	0x100	/* resume execution until next branch */
> +
>  #endif /* _ASM_POWERPC_PTRACE_H */
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 3635be6..656fea2 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -707,12 +707,29 @@ void user_enable_single_step(struct task_struct *task)
>  		task->thread.dbcr0 |= DBCR0_IDM | DBCR0_IC;
>  		regs->msr |= MSR_DE;
>  #else
> +		regs->msr &= ~MSR_BE;
>  		regs->msr |= MSR_SE;
>  #endif
>  	}
>  	set_tsk_thread_flag(task, TIF_SINGLESTEP);
>  }
>  
> +void user_enable_block_step(struct task_struct *task)
> +{
> +	struct pt_regs *regs = task->thread.regs;
> +
> +	if (regs != NULL) {
> +#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> +		task->thread.dbcr0 = DBCR0_IDM | DBCR0_BT;
> +		regs->msr |= MSR_DE;
> +#else
> +		regs->msr &= ~MSR_SE;
> +		regs->msr |= MSR_BE;
> +#endif
> +	}
> +	set_tsk_thread_flag(task, TIF_SINGLESTEP);
> +}
> +
>  void user_disable_single_step(struct task_struct *task)
>  {
>  	struct pt_regs *regs = task->thread.regs;
> @@ -729,7 +746,7 @@ void user_disable_single_step(struct task_struct *task)
>  		task->thread.dbcr0 &= ~(DBCR0_IC | DBCR0_IDM);
>  		regs->msr &= ~MSR_DE;
>  #else
> -		regs->msr &= ~MSR_SE;
> +		regs->msr &= ~(MSR_SE | MSR_BE);
>  #endif
>  	}
>  	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
