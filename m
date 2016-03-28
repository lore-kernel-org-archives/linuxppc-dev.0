Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qYrW743fhzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Mar 2016 11:00:03 +1100 (AEDT)
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3qYrW70dwFz9sBM
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Mar 2016 11:00:02 +1100 (AEDT)
Received: by mail-pa0-x22d.google.com with SMTP id tt10so109568761pab.3
 for <linuxppc-dev@ozlabs.org>; Mon, 28 Mar 2016 17:00:02 -0700 (PDT)
Subject: Re: [PATCH 5/6] powerpc/livepatch: Add livepatch stack to struct
 thread_info
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
 <1458817445-5855-5-git-send-email-mpe@ellerman.id.au>
Cc: duwe@lst.de, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com, pmladek@suse.com, jeyu@redhat.com,
 jkosina@suse.cz, live-patching@vger.kernel.org, mbenes@suse.cz
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <56F9C531.3090703@gmail.com>
Date: Tue, 29 Mar 2016 10:58:41 +1100
MIME-Version: 1.0
In-Reply-To: <1458817445-5855-5-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 24/03/16 22:04, Michael Ellerman wrote:
> In order to support live patching we need to maintain an alternate
> stack of TOC & LR values. We use the base of the stack for this, and
> store the "live patch stack pointer" in struct thread_info.
>
> Unlike the other fields of thread_info, we can not statically initialise
> that value, so it must be done at run time.
>
> This patch just adds the code to support that, it is not enabled until
> the next patch which actually adds live patch support.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/include/asm/livepatch.h   |  8 ++++++++
>  arch/powerpc/include/asm/thread_info.h |  4 +++-
>  arch/powerpc/kernel/irq.c              |  3 +++
>  arch/powerpc/kernel/process.c          |  6 +++++-
>  arch/powerpc/kernel/setup_64.c         | 17 ++++++++++-------
>  5 files changed, 29 insertions(+), 9 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
> index ad36e8e34fa1..a402f7f94896 100644
> --- a/arch/powerpc/include/asm/livepatch.h
> +++ b/arch/powerpc/include/asm/livepatch.h
> @@ -49,6 +49,14 @@ static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
>  	 */
>  	return ftrace_location_range(faddr, faddr + 16);
>  }
> +
> +static inline void klp_init_thread_info(struct thread_info *ti)
> +{
> +	/* + 1 to account for STACK_END_MAGIC */
> +	ti->livepatch_sp = (unsigned long *)(ti + 1) + 1;
> +}
> +#else
> +static void klp_init_thread_info(struct thread_info *ti) { }
>  #endif /* CONFIG_LIVEPATCH */
>  
>  #endif /* _ASM_POWERPC_LIVEPATCH_H */
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 7efee4a3240b..8febc3f66d53 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -43,7 +43,9 @@ struct thread_info {
>  	int		preempt_count;		/* 0 => preemptable,
>  						   <0 => BUG */
>  	unsigned long	local_flags;		/* private flags for thread */
> -
> +#ifdef CONFIG_LIVEPATCH
> +	unsigned long *livepatch_sp;
> +#endif
>  	/* low level flags - has atomic operations done on it */
>  	unsigned long	flags ____cacheline_aligned_in_smp;
>  };
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 290559df1e8b..3cb46a3b1de7 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -66,6 +66,7 @@
>  #include <asm/udbg.h>
>  #include <asm/smp.h>
>  #include <asm/debug.h>
> +#include <asm/livepatch.h>
>  
>  #ifdef CONFIG_PPC64
>  #include <asm/paca.h>
> @@ -607,10 +608,12 @@ void irq_ctx_init(void)
>  		memset((void *)softirq_ctx[i], 0, THREAD_SIZE);
>  		tp = softirq_ctx[i];
>  		tp->cpu = i;
> +		klp_init_thread_info(tp);
At this point ti->livepatch_sp points to the next CPUs thread_info for softirq_ctx?
>  
>  		memset((void *)hardirq_ctx[i], 0, THREAD_SIZE);
>  		tp = hardirq_ctx[i];
>  		tp->cpu = i;
> +		klp_init_thread_info(tp);
Same question here
>  	}
>  }
>  
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 612df305886b..c27215e6ef48 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -55,6 +55,8 @@
>  #include <asm/firmware.h>
>  #endif
>  #include <asm/code-patching.h>
> +#include <asm/livepatch.h>
> +
>  #include <linux/kprobes.h>
>  #include <linux/kdebug.h>
>  
> @@ -1400,13 +1402,15 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
>  	extern void ret_from_kernel_thread(void);
>  	void (*f)(void);
>  	unsigned long sp = (unsigned long)task_stack_page(p) + THREAD_SIZE;
> +	struct thread_info *ti = task_thread_info(p);
> +
> +	klp_init_thread_info(ti);
>  
>  	/* Copy registers */
>  	sp -= sizeof(struct pt_regs);
>  	childregs = (struct pt_regs *) sp;
>  	if (unlikely(p->flags & PF_KTHREAD)) {
>  		/* kernel thread */
> -		struct thread_info *ti = (void *)task_stack_page(p);
>  		memset(childregs, 0, sizeof(struct pt_regs));
>  		childregs->gpr[1] = sp + sizeof(struct pt_regs);
>  		/* function */
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 3807fb05b6de..1b6cabb8e715 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -69,6 +69,7 @@
>  #include <asm/kvm_ppc.h>
>  #include <asm/hugetlb.h>
>  #include <asm/epapr_hcalls.h>
> +#include <asm/livepatch.h>
>  
>  #ifdef DEBUG
>  #define DBG(fmt...) udbg_printf(fmt)
> @@ -667,16 +668,16 @@ static void __init emergency_stack_init(void)
>  	limit = min(safe_stack_limit(), ppc64_rma_size);
>  
>  	for_each_possible_cpu(i) {
> -		unsigned long sp;
> -		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
> -		sp += THREAD_SIZE;
> -		paca[i].emergency_sp = __va(sp);
> +		struct thread_info *ti;
> +		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
> +		klp_init_thread_info(ti);
> +		paca[i].emergency_sp = (void *)ti + THREAD_SIZE;
>  
Does emergency_sp still end up 128 byte aligned after this?
>  #ifdef CONFIG_PPC_BOOK3S_64
>  		/* emergency stack for machine check exception handling. */
> -		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
> -		sp += THREAD_SIZE;
> -		paca[i].mc_emergency_sp = __va(sp);
> +		ti = __va(memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit));
> +		klp_init_thread_info(ti);
Do we care about live-patching in this context? Are we mixing per-thread and per-cpu contexts?
> +		paca[i].mc_emergency_sp = (void *)ti + THREAD_SIZE;
>  #endif
>  	}
>  }
> @@ -700,6 +701,8 @@ void __init setup_arch(char **cmdline_p)
>  	if (ppc_md.panic)
>  		setup_panic();
>  
> +	klp_init_thread_info(&init_thread_info);
> +
>  	init_mm.start_code = (unsigned long)_stext;
>  	init_mm.end_code = (unsigned long) _etext;
>  	init_mm.end_data = (unsigned long) _edata;
