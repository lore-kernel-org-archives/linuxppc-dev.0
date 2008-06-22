Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/9] powerpc: Add macros to access floating point
	registers in thread_struct.
In-reply-to: <7F82D2F6-6FB3-49F0-9512-D60AC2E9CBED@kernel.crashing.org> 
References: <20080620041352.4350D70293@localhost.localdomain>
	<7F82D2F6-6FB3-49F0-9512-D60AC2E9CBED@kernel.crashing.org>
Date: Sun, 22 Jun 2008 21:29:42 +1000
Message-ID: <15207.1214134182@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



In message <7F82D2F6-6FB3-49F0-9512-D60AC2E9CBED@kernel.crashing.org> you wrote
:
> 
> On Jun 19, 2008, at 11:13 PM, Michael Neuling wrote:
> 
> > Index: linux-2.6-ozlabs/include/asm-powerpc/processor.h
> > ===================================================================
> > --- linux-2.6-ozlabs.orig/include/asm-powerpc/processor.h
> > +++ linux-2.6-ozlabs/include/asm-powerpc/processor.h
> > @@ -136,6 +136,9 @@ typedef struct {
> > 	unsigned long seg;
> > } mm_segment_t;
> >
> > +#define TS_FPR(i) fpr[i]
> > +#define TS_FPRSTART fpr
> > +
> > struct thread_struct {
> > 	unsigned long	ksp;		/* Kernel stack pointer */
> > 	unsigned long	ksp_limit;	/* if ksp <= ksp_limit stack overflow *
/
> > @@ -197,12 +200,13 @@ struct thread_struct {
> > 	.fpexc_mode = MSR_FE0 | MSR_FE1, \
> > }
> > #else
> > +#define	FPVSR_INIT_THREAD .fpr = {0}
> 
> Being a bit nit picky, but doesn't seem like this patch should  
> introduce FPVSR.

Yep.. a bit early, thanks.

> 
> >
> > #define INIT_THREAD  { \
> > 	.ksp = INIT_SP, \
> > 	.ksp_limit = INIT_SP_LIMIT, \
> > 	.regs = (struct pt_regs *)INIT_SP - 1, /* XXX bogus, I think */ \
> > 	.fs = KERNEL_DS, \
> > -	.fpr = {0}, \
> > +	FPVSR_INIT_THREAD, \
> > 	.fpscr = { .val = 0, }, \
> > 	.fpexc_mode = 0, \
> > }
> > @@ -289,4 +293,5 @@ static inline void prefetchw(const void
> >
> > #endif /* __KERNEL__ */
> > #endif /* __ASSEMBLY__ */
> > +#define TS_FPRSPACING 1
> > #endif /* _ASM_POWERPC_PROCESSOR_H */
> 
