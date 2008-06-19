Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 5/9] powerpc: Introduce VSX thread_struct and CONFIG_VSX 
In-reply-to: <5AEB0769-1394-4924-803D-C40CAF685519@kernel.crashing.org> 
References: <20080618004734.0B72E70296@localhost.localdomain>
	<5AEB0769-1394-4924-803D-C40CAF685519@kernel.crashing.org>
Date: Thu, 19 Jun 2008 14:35:20 +1000
Message-ID: <14228.1213850120@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <5AEB0769-1394-4924-803D-C40CAF685519@kernel.crashing.org> you wrote
:
> >
> >
> > Index: linux-2.6-ozlabs/include/asm-powerpc/processor.h
> > ===================================================================
> > --- linux-2.6-ozlabs.orig/include/asm-powerpc/processor.h
> > +++ linux-2.6-ozlabs/include/asm-powerpc/processor.h
> > @@ -78,6 +78,7 @@ extern long kernel_thread(int (*fn)(void
> > /* Lazy FPU handling on uni-processor */
> > extern struct task_struct *last_task_used_math;
> > extern struct task_struct *last_task_used_altivec;
> > +extern struct task_struct *last_task_used_vsx;
> > extern struct task_struct *last_task_used_spe;
> >
> > #ifdef CONFIG_PPC32
> > @@ -136,8 +137,13 @@ typedef struct {
> > 	unsigned long seg;
> > } mm_segment_t;
> >
> > +#ifdef CONFIG_VSX
> > +#define TS_FPR(i) fpvsr.fp[i].fpr
> > +#define TS_FPRSTART fpvsr.fp
> > +#else
> > #define TS_FPR(i) fpr[i]
> > #define TS_FPRSTART fpr
> > +#endif
> >
> > struct thread_struct {
> > 	unsigned long	ksp;		/* Kernel stack pointer */
> > @@ -155,8 +161,19 @@ struct thread_struct {
> > 	unsigned long	dbcr0;		/* debug control register values */
> > 	unsigned long	dbcr1;
> > #endif
> > +#ifdef CONFIG_VSX
> > +	/* First 32 VSX registers (overlap with fpr[32]) */
> > +	union {
> > +		struct {
> > +			double fpr;
> > +			double vsrlow;
> > +		} fp[32];
> > +		vector128	vsr[32];
> > +	} fpvsr __attribute__((aligned(16)));
> 
> Do we really need a union here?  what would happen if you just changed  
> the type of fpr[32] from double to vector if #CONFIG_VSX?
>
> I really dont like the union and think we can just make the storage  
> look opaque which is the key.  I doubt we every really care about  
> using fpr[] as a double in the kernel.

I did something similar to this for the first cut of this patch, but it
made the code accessing this structure much less readable.

Personally, I think the union is good as it represents the true
structure of what it's storing.

> Also, the attribute is redundant, vector is already aligned(16).

Ok, I'll remove.

Mikey

> 
> > +#else
> > 	double		fpr[32];	/* Complete floating point set */
> > -	struct {			/* fpr ... fpscr must be contiguous */
> > +#endif
> > +	struct {
> >
> > 		unsigned int pad;
> > 		unsigned int val;	/* Floating point status */
> > @@ -176,6 +193,10 @@ struct thread_struct {
> > 	unsigned long	vrsave;
> > 	int		used_vr;	/* set if process has used altivec */
> > #endif /* CONFIG_ALTIVEC */
> > +#ifdef CONFIG_VSX
> > +	/* VSR status */
> > +	int		used_vsr;	/* set if process has used altivec */
> > +#endif /* CONFIG_VSX */
> > #ifdef CONFIG_SPE
> > 	unsigned long	evr[32];	/* upper 32-bits of SPE regs */
> > 	u64		acc;		/* Accumulator */
> > @@ -200,7 +221,11 @@ struct thread_struct {
> > 	.fpexc_mode = MSR_FE0 | MSR_FE1, \
> > }
> > #else
> > +#ifdef CONFIG_VSX
> > +#define	FPVSR_INIT_THREAD .fpvsr = { .vsr = 0, }
> > +#else
> > #define	FPVSR_INIT_THREAD .fpr = {0}
> > +#endif
> > #define INIT_THREAD  { \
> > 	.ksp = INIT_SP, \
> > 	.ksp_limit = INIT_SP_LIMIT, \
> > @@ -293,5 +318,9 @@ static inline void prefetchw(const void
> >
> > #endif /* __KERNEL__ */
> > #endif /* __ASSEMBLY__ */
> > +#ifdef CONFIG_VSX
> > +#define TS_FPRSPACING 2
> > +#else
> > #define TS_FPRSPACING 1
> > +#endif
> > #endif /* _ASM_POWERPC_PROCESSOR_H */
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
