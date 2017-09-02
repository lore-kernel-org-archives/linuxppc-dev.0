Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkhkl3PnhzDqj8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Sep 2017 13:42:23 +1000 (AEST)
Message-ID: <1504323726.4974.99.camel@kernel.crashing.org>
Subject: Re: [PATCH 03/19] powerpc: Create context switch helpers
 save_sprs() and restore_sprs()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Anton Blanchard <anton@samba.org>, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Date: Sat, 02 Sep 2017 13:42:06 +1000
In-Reply-To: <1446079451-8774-4-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
 <1446079451-8774-4-git-send-email-anton@samba.org>
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

On Thu, 2015-10-29 at 11:43 +1100, Anton Blanchard wrote:
> Move all our context switch SPR save and restore code into two
> helpers. We do a few optimisations:

To avoid confusion with other places where we might save and restore
SPRs for things like power management etc... can you name these
save_task_sprs and restore_task_sprs or something similar ? At least
for me it makes things a bit clearer :)

> - Group all mfsprs and all mtsprs. In many cases an mtspr sets a
> scoreboarding bit that an mfspr waits on, so the current practise of
> mfspr A; mtspr A; mfpsr B; mtspr B is the worst scheduling we can
> do.
> 
> - SPR writes are slow, so check that the value is changing before
> writing it.
> 
> A context switch microbenchmark using yield():
> 
> http://ozlabs.org/~anton/junkcode/context_switch2.c
> 
> ./context_switch2 --test=yield 0 0
> 
> shows an improvement of almost 10% on POWER8.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/include/asm/processor.h |  1 +
>  arch/powerpc/include/asm/switch_to.h | 11 -----
>  arch/powerpc/kernel/entry_64.S       | 60 +----------------------
>  arch/powerpc/kernel/process.c        | 92 +++++++++++++++++++++++++++++++-----
>  4 files changed, 82 insertions(+), 82 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 5afea36..c273f3e 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -294,6 +294,7 @@ struct thread_struct {
>  #endif
>  #ifdef CONFIG_PPC64
>  	unsigned long	dscr;
> +	unsigned long	fscr;
>  	/*
>  	 * This member element dscr_inherit indicates that the process
>  	 * has explicitly attempted and changed the DSCR register value
> diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
> index 15cca17..33a071d 100644
> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -15,17 +15,6 @@ extern struct task_struct *__switch_to(struct task_struct *,
>  struct thread_struct;
>  extern struct task_struct *_switch(struct thread_struct *prev,
>  				   struct thread_struct *next);
> -#ifdef CONFIG_PPC_BOOK3S_64
> -static inline void save_early_sprs(struct thread_struct *prev)
> -{
> -	if (cpu_has_feature(CPU_FTR_ARCH_207S))
> -		prev->tar = mfspr(SPRN_TAR);
> -	if (cpu_has_feature(CPU_FTR_DSCR))
> -		prev->dscr = mfspr(SPRN_DSCR);
> -}
> -#else
> -static inline void save_early_sprs(struct thread_struct *prev) {}
> -#endif
>  
>  extern void enable_kernel_fp(void);
>  extern void enable_kernel_altivec(void);
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index 93bb284..e84e5bc 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -453,29 +453,12 @@ _GLOBAL(_switch)
>  	SAVE_8GPRS(14, r1)
>  	SAVE_10GPRS(22, r1)
>  	mflr	r20		/* Return to switch caller */
> -#ifdef CONFIG_ALTIVEC
> -BEGIN_FTR_SECTION
> -	mfspr	r24,SPRN_VRSAVE	/* save vrsave register value */
> -	std	r24,THREAD_VRSAVE(r3)
> -END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
> -#endif /* CONFIG_ALTIVEC */
> +
>  	std	r20,_NIP(r1)
>  	mfcr	r23
>  	std	r23,_CCR(r1)
>  	std	r1,KSP(r3)	/* Set old stack pointer */
>  
> -#ifdef CONFIG_PPC_BOOK3S_64
> -BEGIN_FTR_SECTION
> -	/* Event based branch registers */
> -	mfspr	r0, SPRN_BESCR
> -	std	r0, THREAD_BESCR(r3)
> -	mfspr	r0, SPRN_EBBHR
> -	std	r0, THREAD_EBBHR(r3)
> -	mfspr	r0, SPRN_EBBRR
> -	std	r0, THREAD_EBBRR(r3)
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> -#endif
> -
>  #ifdef CONFIG_SMP
>  	/* We need a sync somewhere here to make sure that if the
>  	 * previous task gets rescheduled on another CPU, it sees all
> @@ -563,47 +546,6 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
>  	mr	r1,r8		/* start using new stack pointer */
>  	std	r7,PACAKSAVE(r13)
>  
> -#ifdef CONFIG_PPC_BOOK3S_64
> -BEGIN_FTR_SECTION
> -	/* Event based branch registers */
> -	ld	r0, THREAD_BESCR(r4)
> -	mtspr	SPRN_BESCR, r0
> -	ld	r0, THREAD_EBBHR(r4)
> -	mtspr	SPRN_EBBHR, r0
> -	ld	r0, THREAD_EBBRR(r4)
> -	mtspr	SPRN_EBBRR, r0
> -
> -	ld	r0,THREAD_TAR(r4)
> -	mtspr	SPRN_TAR,r0
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
> -#endif
> -
> -#ifdef CONFIG_ALTIVEC
> -BEGIN_FTR_SECTION
> -	ld	r0,THREAD_VRSAVE(r4)
> -	mtspr	SPRN_VRSAVE,r0		/* if G4, restore VRSAVE reg */
> -END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
> -#endif /* CONFIG_ALTIVEC */
> -#ifdef CONFIG_PPC64
> -BEGIN_FTR_SECTION
> -	lwz	r6,THREAD_DSCR_INHERIT(r4)
> -	ld	r0,THREAD_DSCR(r4)
> -	cmpwi	r6,0
> -	bne	1f
> -	ld	r0,PACA_DSCR_DEFAULT(r13)
> -1:
> -BEGIN_FTR_SECTION_NESTED(70)
> -	mfspr	r8, SPRN_FSCR
> -	rldimi	r8, r6, FSCR_DSCR_LG, (63 - FSCR_DSCR_LG)
> -	mtspr	SPRN_FSCR, r8
> -END_FTR_SECTION_NESTED(CPU_FTR_ARCH_207S, CPU_FTR_ARCH_207S, 70)
> -	cmpd	r0,r25
> -	beq	2f
> -	mtspr	SPRN_DSCR,r0
> -2:
> -END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
> -#endif
> -
>  	ld	r6,_CCR(r1)
>  	mtcrf	0xFF,r6
>  
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 75b6676..3aabed4 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -742,6 +742,73 @@ void restore_tm_state(struct pt_regs *regs)
>  #define __switch_to_tm(prev)
>  #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
>  
> +static inline void save_sprs(struct thread_struct *t)
> +{
> +#ifdef CONFIG_ALTIVEC
> +	if (cpu_has_feature(cpu_has_feature(CPU_FTR_ALTIVEC)))
> +		t->vrsave = mfspr(SPRN_VRSAVE);
> +#endif
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	if (cpu_has_feature(CPU_FTR_DSCR))
> +		t->dscr = mfspr(SPRN_DSCR);
> +
> +	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
> +		t->bescr = mfspr(SPRN_BESCR);
> +		t->ebbhr = mfspr(SPRN_EBBHR);
> +		t->ebbrr = mfspr(SPRN_EBBRR);
> +
> +		t->fscr = mfspr(SPRN_FSCR);
> +
> +		/*
> +		 * Note that the TAR is not available for use in the kernel.
> +		 * (To provide this, the TAR should be backed up/restored on
> +		 * exception entry/exit instead, and be in pt_regs.  FIXME,
> +		 * this should be in pt_regs anyway (for debug).)
> +		 */
> +		t->tar = mfspr(SPRN_TAR);
> +	}
> +#endif
> +}
> +
> +static inline void restore_sprs(struct thread_struct *old_thread,
> +				struct thread_struct *new_thread)
> +{
> +#ifdef CONFIG_ALTIVEC
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
> +	    old_thread->vrsave != new_thread->vrsave)
> +		mtspr(SPRN_VRSAVE, new_thread->vrsave);
> +#endif
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	if (cpu_has_feature(CPU_FTR_DSCR)) {
> +		u64 dscr = get_paca()->dscr_default;
> +		u64 fscr = old_thread->fscr & ~FSCR_DSCR;
> +
> +		if (new_thread->dscr_inherit) {
> +			dscr = new_thread->dscr;
> +			fscr |= FSCR_DSCR;
> +		}
> +
> +		if (old_thread->dscr != dscr)
> +			mtspr(SPRN_DSCR, dscr);
> +
> +		if (old_thread->fscr != fscr)
> +			mtspr(SPRN_FSCR, fscr);
> +	}
> +
> +	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
> +		if (old_thread->bescr != new_thread->bescr)
> +			mtspr(SPRN_BESCR, new_thread->bescr);
> +		if (old_thread->ebbhr != new_thread->ebbhr)
> +			mtspr(SPRN_EBBHR, new_thread->ebbhr);
> +		if (old_thread->ebbrr != new_thread->ebbrr)
> +			mtspr(SPRN_EBBRR, new_thread->ebbrr);
> +
> +		if (old_thread->tar != new_thread->tar)
> +			mtspr(SPRN_TAR, new_thread->tar);
> +	}
> +#endif
> +}
> +
>  struct task_struct *__switch_to(struct task_struct *prev,
>  	struct task_struct *new)
>  {
> @@ -751,17 +818,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	struct ppc64_tlb_batch *batch;
>  #endif
>  
> +	new_thread = &new->thread;
> +	old_thread = &current->thread;
> +
>  	WARN_ON(!irqs_disabled());
>  
> -	/* Back up the TAR and DSCR across context switches.
> -	 * Note that the TAR is not available for use in the kernel.  (To
> -	 * provide this, the TAR should be backed up/restored on exception
> -	 * entry/exit instead, and be in pt_regs.  FIXME, this should be in
> -	 * pt_regs anyway (for debug).)
> -	 * Save the TAR and DSCR here before we do treclaim/trecheckpoint as
> -	 * these will change them.
> +	/*
> +	 * We need to save SPRs before treclaim/trecheckpoint as these will
> +	 * change a number of them.
>  	 */
> -	save_early_sprs(&prev->thread);
> +	save_sprs(&prev->thread);
>  
>  	__switch_to_tm(prev);
>  
> @@ -844,10 +910,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  #endif /* CONFIG_HAVE_HW_BREAKPOINT */
>  #endif
>  
> -
> -	new_thread = &new->thread;
> -	old_thread = &current->thread;
> -
>  #ifdef CONFIG_PPC64
>  	/*
>  	 * Collect processor utilization data per process
> @@ -883,6 +945,10 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  
>  	last = _switch(old_thread, new_thread);
>  
> +	/* Need to recalculate these after calling _switch() */
> +	old_thread = &last->thread;
> +	new_thread = &current->thread;
> +
>  #ifdef CONFIG_PPC_BOOK3S_64
>  	if (current_thread_info()->local_flags & _TLF_LAZY_MMU) {
>  		current_thread_info()->local_flags &= ~_TLF_LAZY_MMU;
> @@ -891,6 +957,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	}
>  #endif /* CONFIG_PPC_BOOK3S_64 */
>  
> +	restore_sprs(old_thread, new_thread);
> +
>  	return last;
>  }
>  
