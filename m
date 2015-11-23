Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 673EB1A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 12:29:54 +1100 (AEDT)
Message-ID: <1448242193.3061.15.camel@neuling.org>
Subject: Re: [PATCH 5/8] powerpc: Restore FPU/VEC/VSX if previously used
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, anton@samba.org, linuxppc-dev@ozlabs.org
Date: Mon, 23 Nov 2015 12:29:53 +1100
In-Reply-To: <1447817215-15804-6-git-send-email-cyrilbur@gmail.com>
References: <1447817215-15804-1-git-send-email-cyrilbur@gmail.com>
 <1447817215-15804-6-git-send-email-cyrilbur@gmail.com>
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

On Wed, 2015-11-18 at 14:26 +1100, Cyril Bur wrote:
> Currently the FPU, VEC and VSX facilities are lazily loaded. This is
> not a
> problem unless a process is using these facilities.

I would prefer to say facilities are "enabled" and registers are
"loaded".  You're mixing the two here.

> Modern versions of GCC are very good at automatically vectorising
> code, new
> and modernised workloads make use of floating point and vector
> facilities,
> even the kernel makes use of vectorised memcpy.
>=20
> All this combined greatly increases the cost of a syscall since the
> kernel
> uses the facilities sometimes even in syscall fast-path making it
> increasingly common for a thread to take an *_unavailable exception
> soon
> after a syscall, not to mention potentially taking the trifecta.
>=20
> The obvious overcompensation to this problem is to simply always load
> all
> the facilities on every exit to userspace. Loading up all FPU, VEC
> and VSX
> registers every time can be expensive and if a workload does avoid
> using
> them, it should not be forced to incur this penalty.
>=20
> An 8bit counter is used to detect if the registers have been used in
> the
> past and the registers are always loaded until the value wraps to
> back to
> zero.
>=20
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  arch/powerpc/include/asm/processor.h |  2 ++
>  arch/powerpc/kernel/asm-offsets.c    |  2 ++
>  arch/powerpc/kernel/entry_64.S       | 55
> ++++++++++++++++++++++++++++--
>  arch/powerpc/kernel/fpu.S            |  4 +++
>  arch/powerpc/kernel/process.c        | 66
> ++++++++++++++++++++++++++++++------
>  arch/powerpc/kernel/vector.S         |  4 +++
>  6 files changed, 119 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/processor.h
> b/arch/powerpc/include/asm/processor.h
> index ac23308..dcab21f 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -236,11 +236,13 @@ struct thread_struct {
>  #endif
>  	struct arch_hw_breakpoint hw_brk; /* info on the hardware
> breakpoint */
>  	unsigned long	trap_nr;	/* last trap # on this
> thread */
> +	u8 load_fp;
>  #ifdef CONFIG_ALTIVEC
>  	struct thread_vr_state vr_state;
>  	struct thread_vr_state *vr_save_area;
>  	unsigned long	vrsave;
>  	int		used_vr;	/* set if process has
> used altivec */
> +	u8 load_vec;
>  #endif /* CONFIG_ALTIVEC */
>  #ifdef CONFIG_VSX
>  	/* VSR status */
> diff --git a/arch/powerpc/kernel/asm-offsets.c
> b/arch/powerpc/kernel/asm-offsets.c
> index 221d584..0f593d7 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -95,12 +95,14 @@ int main(void)
>  	DEFINE(THREAD_FPSTATE, offsetof(struct thread_struct,
> fp_state));
>  	DEFINE(THREAD_FPSAVEAREA, offsetof(struct thread_struct,
> fp_save_area));
>  	DEFINE(FPSTATE_FPSCR, offsetof(struct thread_fp_state,
> fpscr));
> +	DEFINE(THREAD_LOAD_FP, offsetof(struct thread_struct,
> load_fp));
>  #ifdef CONFIG_ALTIVEC
>  	DEFINE(THREAD_VRSTATE, offsetof(struct thread_struct,
> vr_state));
>  	DEFINE(THREAD_VRSAVEAREA, offsetof(struct thread_struct,
> vr_save_area));
>  	DEFINE(THREAD_VRSAVE, offsetof(struct thread_struct,
> vrsave));
>  	DEFINE(THREAD_USED_VR, offsetof(struct thread_struct,
> used_vr));
>  	DEFINE(VRSTATE_VSCR, offsetof(struct thread_vr_state,
> vscr));
> +	DEFINE(THREAD_LOAD_VEC, offsetof(struct thread_struct,
> load_vec));
>  #endif /* CONFIG_ALTIVEC */
>  #ifdef CONFIG_VSX
>  	DEFINE(THREAD_USED_VSR, offsetof(struct thread_struct,
> used_vsr));
> diff --git a/arch/powerpc/kernel/entry_64.S
> b/arch/powerpc/kernel/entry_64.S
> index c8b4225..46e9869 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -210,7 +210,54 @@ system_call:			/* label
> this so stack traces look sane */
>  	li	r11,-MAX_ERRNO
>  	andi.	r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TI
> F_USER_WORK_MASK|_TIF_PERSYSCALL_MASK)
>  	bne-	syscall_exit_work
> -	cmpld	r3,r11
> +
> +	/*
> +	 * This is an assembly version of checks performed in
> restore_math()
> +	 * to avoid calling C unless absolutely necessary.
> +	 * Note: In order to simplify the assembly, if the FP or VEC
> registers
> +	 * are hot (and therefore restore_math() isn't called) the
> +	 * LOAD_{FP,VEC} thread counter doesn't get incremented.
> +	 * This is likely the best thing to do anyway because hot
> regs indicate
> +	 * that the workload is doing a lot of syscalls that can be
> handled
> +	 * quickly and without the need to touch FP or VEC regs (by
> the kernel).
> +	 * a) If this workload is long running then this is exactly
> what the
> +	 * kernel should be doing.
> +	 * b) If this workload isn't long running then we'll soon
> fall back to
> +	 * calling into C and the counter will be incremented
> regularly again
> +	 * anyway.
> +	 */
> +	ld	r9,PACACURRENT(r13)
> +	andi.	r0,r8,MSR_FP
> +	addi	r9,r9,THREAD
> +	lbz	r5,THREAD_LOAD_FP(r9)

Would this work as a minor simplification?

	ld	r9,PACACURRENT(r13)
	andi.	r0,r8,MSR_FP
	lbz	r5,THREAD+THREAD_LOAD_FP(r9)

> +> 	> /*
> +> 	>  * Goto 2 if !r0 && r5
> +> 	>  * The cmpb works because r5 can only have bits set in the lowest b=
yte
> +> 	>  * and r0 may or may not have bit 13 set (different byte) but will =
have
> +> 	>  * a zero low byte therefore the low bytes must differ if r5 =3D=3D=
 true
> +> 	>  * and the bit 13 byte must be the same if !r0
> +> 	>  */
> +	cmpb	r7,r0,r5
> +	cmpldi	r7,0xff0
> +#ifdef CONFIG_ALTIVEC
> +	beq	2f
> +
> +	lbz	r9,THREAD_LOAD_VEC(r9)
> +	andis.	r0,r8,MSR_VEC@h
> +	/* Skip (goto 3) if r0 || !r9 */
> +	bne	3f
> +	cmpldi	r9,0
> +	beq 3f
> +#else
> +	bne 3f
> +#endif
> +2:	addi    r3,r1,STACK_FRAME_OVERHEAD
> +	bl	restore_math
> +	ld	r8,_MSR(r1)
> +	ld	r3,RESULT(r1)
> +	li	r11,-MAX_ERRNO
> +
> +3:	cmpld	r3,r11
>  	ld	r5,_CCR(r1)
>  	bge-	syscall_error
>  .Lsyscall_error_cont:
> @@ -592,8 +639,8 @@ _GLOBAL(ret_from_except_lite)
> =20
>  	/* Check current_thread_info()->flags */
>  	andi.	r0,r4,_TIF_USER_WORK_MASK
> -#ifdef CONFIG_PPC_BOOK3E
>  	bne	1f
> +#ifdef CONFIG_PPC_BOOK3E

why this change?

>  	/*
>  	 * Check to see if the dbcr0 register is set up to debug.
>  	 * Use the internal debug mode bit to do this.
> @@ -608,7 +655,9 @@ _GLOBAL(ret_from_except_lite)
>  	mtspr	SPRN_DBSR,r10
>  	b	restore
>  #else
> -	beq	restore
> +	addi	r3,r1,STACK_FRAME_OVERHEAD
> +	bl	restore_math
> +	b	restore
>  #endif
>  1:	andi.	r0,r4,_TIF_NEED_RESCHED
>  	beq	2f
> diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
> index 2117eac..b063524 100644
> --- a/arch/powerpc/kernel/fpu.S
> +++ b/arch/powerpc/kernel/fpu.S
> @@ -130,6 +130,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>  	or	r12,r12,r4
>  	std	r12,_MSR(r1)
>  #endif
> +	/* Don't care if r4 overflows, this is desired behaviour */
> +	lbz	r4,THREAD_LOAD_FP(r5)
> +	addi	r4,r4,1
> +	stb	r4,THREAD_LOAD_FP(r5)
>  	addi	r10,r5,THREAD_FPSTATE
>  	lfd	fr0,FPSTATE_FPSCR(r10)
>  	MTFSF_L(fr0)
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c
> index 441d9e5..c602b67 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -366,6 +366,53 @@ void giveup_all(struct task_struct *tsk)
>  	msr_check_and_clear(msr_all_available);
>  }
> =20
> +void restore_math(struct pt_regs *regs)
> +{
> +	unsigned long msr;
> +
> +	if (!current->thread.load_fp
> +#ifdef CONFIG_ALTIVEC
> +		&& !current->thread.load_vec)
> +#else
> +		)
> +#endif

That is possibly the most revolting use of #ifdef I have ever seen.=20
 And that's saying something with the crap state that process.c is
already in :-P

> +		return;
> +
> +	msr =3D regs->msr;
> +	msr_check_and_set(msr_all_available);
> +
> +	/*
> +	 * Only reload if the bit is not set in the user MSR, the
> bit BEING set
> +	 * indicates that the registers are hot
> +	 */
> +#ifdef CONFIG_PPC_FPU
> +	if (current->thread.load_fp && !(msr & MSR_FP)) {
> +		load_fp_state(&current->thread.fp_state);
> +		msr |=3D MSR_FP | current->thread.fpexc_mode;
> +		current->thread.load_fp++;
> +	}
> +#endif
> +#ifdef CONFIG_ALTIVEC
> +	if (current->thread.load_vec && !(msr & MSR_VEC) &&
> +			cpu_has_feature(CPU_FTR_ALTIVEC)) {
> +		load_vr_state(&current->thread.vr_state);
> +		current->thread.used_vr =3D 1;
> +		msr |=3D MSR_VEC;
> +		current->thread.load_vec++;
> +	}
> +#endif
> +#ifdef CONFIG_VSX
> +	if (!(msr & MSR_VSX) && (msr & (MSR_FP | MSR_VEC)) =3D=3D
> (MSR_FP | MSR_VEC)) {
> +		current->thread.used_vsr =3D 1;
> +		msr |=3D MSR_VSX;
> +	}
> +#endif
> +
> +	msr_check_and_clear(msr_all_available);
> +
> +	regs->msr =3D msr;
> +}
> +
>  void flush_all_to_thread(struct task_struct *tsk)
>  {
>  	if (tsk->thread.regs) {
> @@ -806,17 +853,9 @@ void restore_tm_state(struct pt_regs *regs)
> =20
>  	msr_diff =3D current->thread.ckpt_regs.msr & ~regs->msr;
>  	msr_diff &=3D MSR_FP | MSR_VEC | MSR_VSX;
> -	if (msr_diff & MSR_FP) {
> -		msr_check_and_set(MSR_FP);
> -		load_fp_state(&current->thread.fp_state);
> -		msr_check_and_clear(MSR_FP);
> -		regs->msr |=3D current->thread.fpexc_mode;
> -	}
> -	if (msr_diff & MSR_VEC) {
> -		msr_check_and_set(MSR_VEC);
> -		load_vr_state(&current->thread.vr_state);
> -		msr_check_and_clear(MSR_VEC);
> -	}
> +
> +	restore_math(regs);
> +
>  	regs->msr |=3D msr_diff;
>  }
> =20
> @@ -977,6 +1016,11 @@ struct task_struct *__switch_to(struct
> task_struct *prev,
>  		batch =3D this_cpu_ptr(&ppc64_tlb_batch);
>  		batch->active =3D 1;
>  	}
> +
> +	/* Don't do this on a kernel thread */
> +	if (current_thread_info()->task->thread.regs)
> +		restore_math(current_thread_info()->task
> ->thread.regs);
> +
>  #endif /* CONFIG_PPC_BOOK3S_64 */
> =20
>  	return last;
> diff --git a/arch/powerpc/kernel/vector.S
> b/arch/powerpc/kernel/vector.S
> index 162d0f7..038cff8 100644
> --- a/arch/powerpc/kernel/vector.S
> +++ b/arch/powerpc/kernel/vector.S
> @@ -91,6 +91,10 @@ _GLOBAL(load_up_altivec)
>  	oris	r12,r12,MSR_VEC@h
>  	std	r12,_MSR(r1)
>  #endif
> +	/* Don't care if r4 overflows, this is desired behaviour */
> +	lbz	r4,THREAD_LOAD_VEC(r5)
> +	addi	r4,r4,1
> +	stb	r4,THREAD_LOAD_VEC(r5)
>  	addi	r6,r5,THREAD_VRSTATE
>  	li	r4,1
>  	li	r10,VRSTATE_VSCR
