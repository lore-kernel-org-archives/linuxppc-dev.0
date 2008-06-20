Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0F86DDF2F
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jun 2008 16:44:49 +1000 (EST)
Message-Id: <0905B4FD-91AA-4AD9-AB8E-119000CFE663@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <20080620041352.57E2270296@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 5/9] powerpc: Introduce VSX thread_struct and CONFIG_VSX
Date: Fri, 20 Jun 2008 01:44:38 -0500
References: <20080620041352.57E2270296@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Index: linux-2.6-ozlabs/include/asm-powerpc/processor.h
> ===================================================================
> --- linux-2.6-ozlabs.orig/include/asm-powerpc/processor.h
> +++ linux-2.6-ozlabs/include/asm-powerpc/processor.h
> @@ -78,6 +78,7 @@ extern long kernel_thread(int (*fn)(void
> /* Lazy FPU handling on uni-processor */
> extern struct task_struct *last_task_used_math;
> extern struct task_struct *last_task_used_altivec;
> +extern struct task_struct *last_task_used_vsx;
> extern struct task_struct *last_task_used_spe;
>
> #ifdef CONFIG_PPC32
> @@ -136,8 +137,13 @@ typedef struct {
> 	unsigned long seg;
> } mm_segment_t;
>
> +#ifdef CONFIG_VSX
> +#define TS_FPR(i) fpvsr[i].fpr.fp
> +#define TS_FPRSTART fpvsr
> +#else
> #define TS_FPR(i) fpr[i]
> #define TS_FPRSTART fpr
> +#endif
>
> struct thread_struct {
> 	unsigned long	ksp;		/* Kernel stack pointer */
> @@ -155,8 +161,19 @@ struct thread_struct {
> 	unsigned long	dbcr0;		/* debug control register values */
> 	unsigned long	dbcr1;
> #endif
> +#ifdef CONFIG_VSX
> +	/* First 32 VSX registers (overlap with fpr[32]) */
> +	union {
> +		struct {
> +			double fp;

s/fp/fpr

> +			double vsrlow;
> +		} fpr;
> +		vector128	vsr;
> +	} fpvsr[32];
> +#else
> 	double		fpr[32];	/* Complete floating point set */
> -	struct {			/* fpr ... fpscr must be contiguous */
> +#endif
> +	struct {
>
> 		unsigned int pad;
> 		unsigned int val;	/* Floating point status */

So if I search correctly I count 2 uses of .vsr.  Seems like we could  
easily make those two cases use .fp and drop the union.

- k
