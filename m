Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgr5R1WVyzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 22:03:38 +1000 (AEST)
Message-ID: <1503921783.4850.5.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] cxl: Enable global TLBIs for cxl contexts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com
Cc: alistair@popple.id.au
Date: Mon, 28 Aug 2017 22:03:03 +1000
In-Reply-To: <20170828084731.14773-2-fbarrat@linux.vnet.ibm.com>
References: <20170828084731.14773-1-fbarrat@linux.vnet.ibm.com>
 <20170828084731.14773-2-fbarrat@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-08-28 at 10:47 +0200, Frederic Barrat wrote:
> 
>     
> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 309592589e30..6447c0df7ec4 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -77,6 +77,41 @@ extern void switch_cop(struct mm_struct *next);
>  extern int use_cop(unsigned long acop, struct mm_struct *mm);
>  extern void drop_cop(unsigned long acop, struct mm_struct *mm);
>  
> +#ifdef CONFIG_PPC_BOOK3S_64
> +static inline void inc_mm_active_cpus(struct mm_struct *mm)
> +{
> +	atomic_inc(&mm->context.active_cpus);
> +}
> +
> +static inline void dec_mm_active_cpus(struct mm_struct *mm)
> +{
> +	atomic_dec(&mm->context.active_cpus);
> +}
> +
> +static inline void mm_context_add_copro(struct mm_struct *mm)
> +{
> +	inc_mm_active_cpus(mm);
> +}
> +
> +static inline void mm_context_remove_copro(struct mm_struct *mm)
> +{
> +	/*
> +	 * Need to broadcast a global flush of the full mm before
> +	 * decrementing active_cpus count, as the next TLBI may be
> +	 * local and the nMMU and/or PSL need to be cleaned up.
> +	 * Should be rare enough so that it's acceptable.
> +	 */
> +	flush_tlb_mm(mm);
> +	dec_mm_active_cpus(mm);
> +}

You probably need to kill the pwc too. With my recent optimizations
flush_tlb_mm won't do that anymore. You need a bigger hammer (I don't
have the code at hand right now to tell you what exactly :-) Basically
something that does a RIC_FLUSH_ALL.

> +#else
> +static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
> +static inline void dec_mm_active_cpus(struct mm_struct *mm) { }
> +static inline void mm_context_add_copro(struct mm_struct *mm) { }
> +static inline void mm_context_remove_copro(struct mm_struct *mm) { }
> +#endif
> +
> +
>  extern void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  			       struct task_struct *tsk);
>  
> diff --git a/arch/powerpc/mm/mmu_context.c b/arch/powerpc/mm/mmu_context.c
> index 0f613bc63c50..d60a62bf4fc7 100644
> --- a/arch/powerpc/mm/mmu_context.c
> +++ b/arch/powerpc/mm/mmu_context.c
> @@ -34,15 +34,6 @@ static inline void switch_mm_pgdir(struct task_struct *tsk,
>  				   struct mm_struct *mm) { }
>  #endif
>  
> -#ifdef CONFIG_PPC_BOOK3S_64
> -static inline void inc_mm_active_cpus(struct mm_struct *mm)
> -{
> -	atomic_inc(&mm->context.active_cpus);
> -}
> -#else
> -static inline void inc_mm_active_cpus(struct mm_struct *mm) { }
> -#endif
> -
>  void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
>  			struct task_struct *tsk)
>  {
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index e0dfd1eadd70..33daf33e0e05 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/mount.h>
>  #include <linux/sched/mm.h>
> +#include <linux/mmu_context.h>
>  
>  #include "cxl.h"
>  
> @@ -332,8 +333,11 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
>  		cxl_context_mm_count_get(ctx);
>  
>  		/* decrement the use count */
> -		if (ctx->mm)
> +		if (ctx->mm) {
>  			mmput(ctx->mm);
> +			/* make TLBIs for this context global */
> +			mm_context_add_copro(ctx->mm);
> +		}
>  	}
>  
>  	/*
> @@ -342,13 +346,25 @@ int cxl_start_context(struct cxl_context *ctx, u64 wed,
>  	 */
>  	cxl_ctx_get();
>  
> +	/*
> +	 * Barrier is needed to make sure all TLBIs are global before
> +	 * we attach and the context starts being used by the adapter.
> +	 *
> +	 * Needed after mm_context_add_copro() for radix and
> +	 * cxl_ctx_get() for hash/p8
> +	 */
> +	smp_mb();
> +
>  	if ((rc = cxl_ops->attach_process(ctx, kernel, wed, 0))) {
>  		put_pid(ctx->pid);
>  		ctx->pid = NULL;
>  		cxl_adapter_context_put(ctx->afu->adapter);
>  		cxl_ctx_put();
> -		if (task)
> +		if (task) {
>  			cxl_context_mm_count_put(ctx);
> +			if (ctx->mm)
> +				mm_context_remove_copro(ctx->mm);
> +		}
>  		goto out;
>  	}
>  
> diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
> index 8c32040b9c09..12a41b2753f0 100644
> --- a/drivers/misc/cxl/context.c
> +++ b/drivers/misc/cxl/context.c
> @@ -18,6 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/idr.h>
>  #include <linux/sched/mm.h>
> +#include <linux/mmu_context.h>
>  #include <asm/cputable.h>
>  #include <asm/current.h>
>  #include <asm/copro.h>
> @@ -267,6 +268,8 @@ int __detach_context(struct cxl_context *ctx)
>  
>  	/* Decrease the mm count on the context */
>  	cxl_context_mm_count_put(ctx);
> +	if (ctx->mm)
> +		mm_context_remove_copro(ctx->mm);
>  	ctx->mm = NULL;
>  
>  	return 0;
> diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
> index b76a491a485d..411e83cbbd82 100644
> --- a/drivers/misc/cxl/file.c
> +++ b/drivers/misc/cxl/file.c
> @@ -19,6 +19,7 @@
>  #include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/sched/mm.h>
> +#include <linux/mmu_context.h>
>  #include <asm/cputable.h>
>  #include <asm/current.h>
>  #include <asm/copro.h>
> @@ -220,9 +221,12 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>  	/* ensure this mm_struct can't be freed */
>  	cxl_context_mm_count_get(ctx);
>  
> -	/* decrement the use count */
> -	if (ctx->mm)
> +	if (ctx->mm) {
> +		/* decrement the use count */
>  		mmput(ctx->mm);
> +		/* make TLBIs for this context global */
> +		mm_context_add_copro(ctx->mm);
> +	}
>  
>  	/*
>  	 * Increment driver use count. Enables global TLBIs for hash
> @@ -230,6 +234,15 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>  	 */
>  	cxl_ctx_get();
>  
> +	/*
> +	 * Barrier is needed to make sure all TLBIs are global before
> +	 * we attach and the context starts being used by the adapter.
> +	 *
> +	 * Needed after mm_context_add_copro() for radix and
> +	 * cxl_ctx_get() for hash/p8
> +	 */
> +	smp_mb();
> +
>  	trace_cxl_attach(ctx, work.work_element_descriptor, work.num_interrupts, amr);
>  
>  	if ((rc = cxl_ops->attach_process(ctx, false, work.work_element_descriptor,
> @@ -240,6 +253,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
>  		ctx->pid = NULL;
>  		cxl_ctx_put();
>  		cxl_context_mm_count_put(ctx);
> +		if (ctx->mm)
> +			mm_context_remove_copro(ctx->mm);
>  		goto out;
>  	}
>  
