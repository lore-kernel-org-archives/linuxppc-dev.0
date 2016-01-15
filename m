Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44D2E1A17FC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 17:08:56 +1100 (AEDT)
Message-ID: <1452838135.25634.39.camel@neuling.org>
Subject: Re: [PATCH V2 6/8] powerpc: Add the ability to save FPU without
 giving it up
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
Date: Fri, 15 Jan 2016 17:08:55 +1100
In-Reply-To: <1452834254-22078-7-git-send-email-cyrilbur@gmail.com>
References: <1452834254-22078-1-git-send-email-cyrilbur@gmail.com>
 <1452834254-22078-7-git-send-email-cyrilbur@gmail.com>
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

On Fri, 2016-01-15 at 16:04 +1100, Cyril Bur wrote:
> This patch adds the ability to be able to save the FPU registers to
> the
> thread struct without giving up (disabling the facility) next time
> the
> process returns to userspace.
>=20
> This patch optimises the thread copy path (as a result of a fork() or
> clone()) so that the parent thread can return to userspace with hot
> registers avoiding a possibly pointless reload of FPU register state.

This comment seems misleading.  The patch seems to touch the VSX, VMX
and SPE state as well. =20

Mikey

>=20
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  arch/powerpc/include/asm/switch_to.h |  2 +-
>  arch/powerpc/kernel/fpu.S            | 21 ++++------------
>  arch/powerpc/kernel/process.c        | 46
> +++++++++++++++++++++++++++++++++++-
>  3 files changed, 50 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/switch_to.h
> b/arch/powerpc/include/asm/switch_to.h
> index 5b268b6..c4d50e9 100644
> --- a/arch/powerpc/include/asm/switch_to.h
> +++ b/arch/powerpc/include/asm/switch_to.h
> @@ -28,7 +28,7 @@ extern void giveup_all(struct task_struct *);
>  extern void enable_kernel_fp(void);
>  extern void flush_fp_to_thread(struct task_struct *);
>  extern void giveup_fpu(struct task_struct *);
> -extern void __giveup_fpu(struct task_struct *);
> +extern void save_fpu(struct task_struct *);
>  static inline void disable_kernel_fp(void)
>  {
>  	msr_check_and_clear(MSR_FP);
> diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
> index b063524..15da2b5 100644
> --- a/arch/powerpc/kernel/fpu.S
> +++ b/arch/powerpc/kernel/fpu.S
> @@ -143,33 +143,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>  	blr
> =20
>  /*
> - * __giveup_fpu(tsk)
> - * Disable FP for the task given as the argument,
> - * and save the floating-point registers in its thread_struct.
> + * save_fpu(tsk)
> + * Save the floating-point registers in its thread_struct.
>   * Enables the FPU for use in the kernel on return.
>   */
> -_GLOBAL(__giveup_fpu)
> +_GLOBAL(save_fpu)
>  	addi	r3,r3,THREAD	        /* want THREAD of
> task */
>  	PPC_LL	r6,THREAD_FPSAVEAREA(r3)
>  	PPC_LL	r5,PT_REGS(r3)
>  	PPC_LCMPI	0,r6,0
>  	bne	2f
>  	addi	r6,r3,THREAD_FPSTATE
> -2:	PPC_LCMPI	0,r5,0
> -	SAVE_32FPVSRS(0, R4, R6)
> +2:	SAVE_32FPVSRS(0, R4, R6)
>  	mffs	fr0
>  	stfd	fr0,FPSTATE_FPSCR(r6)
> -	beq	1f
> -	PPC_LL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> -	li	r3,MSR_FP|MSR_FE0|MSR_FE1
> -#ifdef CONFIG_VSX
> -BEGIN_FTR_SECTION
> -	oris	r3,r3,MSR_VSX@h
> -END_FTR_SECTION_IFSET(CPU_FTR_VSX)
> -#endif
> -	andc	r4,r4,r3		/* disable FP for
> previous task */
> -	PPC_STL	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
> -1:
>  	blr
> =20
>  /*
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c
> index ec53468..8a96e4f 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -133,6 +133,16 @@ void __msr_check_and_clear(unsigned long bits)
>  EXPORT_SYMBOL(__msr_check_and_clear);
> =20
>  #ifdef CONFIG_PPC_FPU
> +void __giveup_fpu(struct task_struct *tsk)
> +{
> +	save_fpu(tsk);
> +	tsk->thread.regs->msr &=3D ~MSR_FP;
> +#ifdef CONFIG_VSX
> +	if (cpu_has_feature(CPU_FTR_VSX))
> +		tsk->thread.regs->msr &=3D ~MSR_VSX;
> +#endif
> +}
> +
>  void giveup_fpu(struct task_struct *tsk)
>  {
>  	check_if_tm_restore_required(tsk);
> @@ -421,12 +431,46 @@ void restore_math(struct pt_regs *regs)
>  	regs->msr =3D msr;
>  }
> =20
> +void save_all(struct task_struct *tsk)
> +{
> +	unsigned long usermsr;
> +
> +	if (!tsk->thread.regs)
> +		return;
> +
> +	usermsr =3D tsk->thread.regs->msr;
> +
> +	if ((usermsr & msr_all_available) =3D=3D 0)
> +		return;
> +
> +	msr_check_and_set(msr_all_available);
> +
> +#ifdef CONFIG_PPC_FPU
> +	if (usermsr & MSR_FP)
> +		save_fpu(tsk);
> +#endif
> +#ifdef CONFIG_ALTIVEC
> +	if (usermsr & MSR_VEC)
> +		__giveup_altivec(tsk);
> +#endif
> +#ifdef CONFIG_VSX
> +	if (usermsr & MSR_VSX)
> +		__giveup_vsx(tsk);
> +#endif
> +#ifdef CONFIG_SPE
> +	if (usermsr & MSR_SPE)
> +		__giveup_spe(tsk);
> +#endif
> +
> +	msr_check_and_clear(msr_all_available);
> +}
> +
>  void flush_all_to_thread(struct task_struct *tsk)
>  {
>  	if (tsk->thread.regs) {
>  		preempt_disable();
>  		BUG_ON(tsk !=3D current);
> -		giveup_all(tsk);
> +		save_all(tsk);
> =20
>  #ifdef CONFIG_SPE
>  		if (tsk->thread.regs->msr & MSR_SPE)
