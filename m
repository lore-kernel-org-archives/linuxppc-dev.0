Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zllV20vvgzF0cg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 13:50:34 +1100 (AEDT)
Message-ID: <1519095033.7360.52.camel@neuling.org>
Subject: Re: [RFC PATCH 05/12] [WIP] powerpc/tm: Reclaim/recheckpoint on
 entry/exit
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Date: Tue, 20 Feb 2018 13:50:33 +1100
In-Reply-To: <20180220002241.29648-6-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
 <20180220002241.29648-6-cyrilbur@gmail.com>
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

On Tue, 2018-02-20 at 11:22 +1100, Cyril Bur wrote:


The comment from the cover sheet should be here

> ---
>  arch/powerpc/include/asm/exception-64s.h | 25 +++++++++++++++++++++
>  arch/powerpc/kernel/entry_64.S           |  5 +++++
>  arch/powerpc/kernel/process.c            | 37 ++++++++++++++++++++++++++=
++----
>  3 files changed, 63 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/incl=
ude/asm/exception-64s.h
> index 471b2274fbeb..f904f19a9ec2 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -35,6 +35,7 @@
>   * implementations as possible.
>   */
>  #include <asm/head-64.h>
> +#include <asm/tm.h>
> =20
>  /* PACA save area offsets (exgen, exmc, etc) */
>  #define EX_R9		0
> @@ -127,6 +128,26 @@
>  	hrfid;								\
>  	b	hrfi_flush_fallback
> =20
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +#define TM_KERNEL_ENTRY		                                        \
> +	ld	r3,_MSR(r1);			                        \
> +	/* Probably don't need to check if coming from user/kernel */	\
> +	/* If TM is suspended or active then we must have come from*/	\
> +	/* userspace */							\
> +	andi.	r0,r3,MSR_PR;						\
> +	beq	1f;							\
> +	rldicl. r3,r3,(64-MSR_TS_LG),(64-2); /* SUSPENDED or ACTIVE*/   \
> +	beql+	1f;                   	/* Not SUSPENDED or ACTIVE */   \
> +	bl	save_nvgprs;						\
> +	RECONCILE_IRQ_STATE(r10,r11);					\
> +	li	r3,TM_CAUSE_MISC;					\
> +	bl	tm_reclaim_current;	/* uint8 cause		   */	\
> +1:
> +
> +#else /* CONFIG_PPC_TRANSACTIONAL_MEM */
> +#define TM_KERNEL_ENTRY
> +#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> +
>  #ifdef CONFIG_RELOCATABLE
>  #define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
>  	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
> @@ -675,6 +696,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
>  	EXCEPTION_PROLOG_COMMON(trap, area);			\
>  	/* Volatile regs are potentially clobbered here */	\
>  	additions;						\
> +	/* This is going to need to go somewhere else as well */\
> +	/* See comment in tm_recheckpoint()		      */\
> +	TM_KERNEL_ENTRY;					\
>  	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
>  	bl	hdlr;						\
>  	b	ret
> @@ -689,6 +713,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
>  	EXCEPTION_PROLOG_COMMON_3(trap);			\
>  	/* Volatile regs are potentially clobbered here */	\
>  	additions;						\
> +	TM_KERNEL_ENTRY;					\
>  	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
>  	bl	hdlr
> =20
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_6=
4.S
> index 2cb5109a7ea3..107c15c6f48b 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -126,6 +126,11 @@ BEGIN_FW_FTR_SECTION
>  33:
>  END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
>  #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE && CONFIG_PPC_SPLPAR */
> +	TM_KERNEL_ENTRY
> +	REST_GPR(0,r1)
> +	REST_4GPRS(3,r1)
> +	REST_2GPRS(7,r1)
> +	addi	r9,r1,STACK_FRAME_OVERHEAD

Why are we doing these restores here now?

> =20
>  	/*
>  	 * A syscall should always be called with interrupts enabled
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 77dc6d8288eb..ea75da0fd506 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -951,6 +951,23 @@ void tm_recheckpoint(struct thread_struct *thread)
>  	if (!(thread->regs->msr & MSR_TM))
>  		return;
> =20
> +	/*
> +	 * This is 'that' comment.

I think I'm in the loop here but I don't actually know what this means.=20

Senior Mikey moment or Crazy Cyril comments? I'll let the peanut gallery de=
cide.

> +	 *
> +	 * If we get where with tm suspended or active then something

s/where/here/

> +	 * has gone wrong. I've added this now as a proof of concept.
> +	 *
> +	 * The problem I'm seeing without it is an attempt to
> +	 * recheckpoint a CPU without a previous reclaim.
> +	 *
> +	 * I'm probably missed an exception entry with the
> +	 * TM_KERNEL_ENTRY macro. Should be easy enough to find.
> +	 */
> +	if (MSR_TM_ACTIVE(mfmsr()))
> +		return;

I don't really get this.  Wouldn't this test apply now?

> +
> +	tm_enable();

Why did we add this?

> +
>  	/* We really can't be interrupted here as the TEXASR registers can't
>  	 * change and later in the trecheckpoint code, we have a userspace R1.
>  	 * So let's hard disable over this region.
> @@ -1009,6 +1026,13 @@ static inline void tm_recheckpoint_new_task(struct=
 task_struct *new)
>  static inline void __switch_to_tm(struct task_struct *prev,
>  		struct task_struct *new)
>  {
> +	/*
> +	 * So, with the rework none of this code should not be needed.
> +	 * I've left in the reclaim for now. This *should* save us
> +	 * from any mistake in the new code. Also the
> +	 * enabling/disabling logic of MSR_TM really should be
> +	 * refactored into a common way with MSR_{FP,VEC,VSX}
> +	 */
>  	if (cpu_has_feature(CPU_FTR_TM)) {
>  		if (tm_enabled(prev) || tm_enabled(new))
>  			tm_enable();
> @@ -1016,11 +1040,14 @@ static inline void __switch_to_tm(struct task_str=
uct *prev,
>  		if (tm_enabled(prev)) {
>  			prev->thread.load_tm++;
>  			tm_reclaim_task(prev);
> -			if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm =
=3D=3D 0)
> -				prev->thread.regs->msr &=3D ~MSR_TM;
> +			/*
> +			 * The disabling logic may be confused don't
> +			 * disable for now
> +			 *
> +			 * if (!MSR_TM_ACTIVE(prev->thread.regs->msr) && prev->thread.load_tm=
 =3D=3D 0)
> +			 *	prev->thread.regs->msr &=3D ~MSR_TM;
> +			 */

Why are you doing this when you just remove all this code in the next patch=
?
>  		}
> -
> -		tm_recheckpoint_new_task(new);
>  	}
>  }
> =20
> @@ -1055,6 +1082,8 @@ void restore_tm_state(struct pt_regs *regs)
>  	msr_diff =3D current->thread.ckpt_regs.msr & ~regs->msr;
>  	msr_diff &=3D MSR_FP | MSR_VEC | MSR_VSX;
> =20
> +	tm_recheckpoint(&current->thread);
> +

So why do we do tm_recheckpoint at all? Shouldn't most of the tm_blah code =
go
away in process.c after all this?

>  	/* Ensure that restore_math() will restore */
>  	if (msr_diff & MSR_FP)
>  		current->thread.load_fp =3D 1;
