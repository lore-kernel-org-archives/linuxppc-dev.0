Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21E4F1A17FC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 17:02:42 +1100 (AEDT)
Message-ID: <1452837761.25634.36.camel@neuling.org>
Subject: Re: [PATCH V2 5/8] powerpc: Restore FPU/VEC/VSX if previously used
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
Date: Fri, 15 Jan 2016 17:02:41 +1100
In-Reply-To: <1452834254-22078-6-git-send-email-cyrilbur@gmail.com>
References: <1452834254-22078-1-git-send-email-cyrilbur@gmail.com>
 <1452834254-22078-6-git-send-email-cyrilbur@gmail.com>
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

> Currently the FPU, VEC and VSX facilities are lazily loaded. This is not =
a
> problem unless a process is using these facilities.

> Modern versions of GCC are very good at automatically vectorising code, n=
ew
> and modernised workloads make use of floating point and vector facilities=
,
> even the kernel makes use of vectorised memcpy.

> All this combined greatly increases the cost of a syscall since the kerne=
l
> uses the facilities sometimes even in syscall fast-path making it
> increasingly common for a thread to take an *_unavailable exception soon
> after a syscall, not to mention potentially taking all three.

> The obvious overcompensation to this problem is to simply always load all
> the facilities on every exit to userspace. Loading up all FPU, VEC and VS=
X
> registers every time can be expensive and if a workload does avoid using
> them, it should not be forced to incur this penalty.

> An 8bit counter is used to detect if the registers have been used in the
> past and the registers are always loaded until the value wraps to back to
> zero.

> Several versions of the assembly in entry_64.S. 1. Always calling C, 2.
> Performing a common case check and then calling C and 3. A complex check =
in
> asm. After some benchmarking it was determined that avoiding C in the
> common case is a performance benefit. The full check in asm greatly
> complicated that codepath for a negligible performance gain and the
> trade-off was deemed not worth it.

> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
>  arch/powerpc/include/asm/processor.h |  2 ++
>  arch/powerpc/kernel/asm-offsets.c    |  2 ++
>  arch/powerpc/kernel/entry_64.S       | 21 ++++++++++--
>  arch/powerpc/kernel/fpu.S            |  4 +++
>  arch/powerpc/kernel/process.c        | 66 ++++++++++++++++++++++++++++++=
------
>  arch/powerpc/kernel/vector.S         |  4 +++
>  6 files changed, 85 insertions(+), 14 deletions(-)

> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/=
asm/processor.h
> index ac23308..dcab21f 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -236,11 +236,13 @@ struct thread_struct {
>  #endif
>         struct arch_hw_breakpoint hw_brk; /* info on the hardware breakpo=
int */
>         unsigned long   trap_nr;        /* last trap # on this thread */
> +       u8 load_fp;
>  #ifdef CONFIG_ALTIVEC
>         struct thread_vr_state vr_state;
>         struct thread_vr_state *vr_save_area;
>         unsigned long   vrsave;
>         int             used_vr;        /* set if process has used altive=
c */
> +       u8 load_vec;
>  #endif /* CONFIG_ALTIVEC */
>  #ifdef CONFIG_VSX
>         /* VSR status */
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-=
offsets.c
> index 07cebc3..10d5eab 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -95,12 +95,14 @@ int main(void)
>         DEFINE(THREAD_FPSTATE, offsetof(struct thread_struct, fp_state));
>         DEFINE(THREAD_FPSAVEAREA, offsetof(struct thread_struct, fp_save_=
area));
>         DEFINE(FPSTATE_FPSCR, offsetof(struct thread_fp_state, fpscr));
> +       DEFINE(THREAD_LOAD_FP, offsetof(struct thread_struct, load_fp));
>  #ifdef CONFIG_ALTIVEC
>         DEFINE(THREAD_VRSTATE, offsetof(struct thread_struct, vr_state));
>         DEFINE(THREAD_VRSAVEAREA, offsetof(struct thread_struct, vr_save_=
area));
>         DEFINE(THREAD_VRSAVE, offsetof(struct thread_struct, vrsave));
>         DEFINE(THREAD_USED_VR, offsetof(struct thread_struct, used_vr));
>         DEFINE(VRSTATE_VSCR, offsetof(struct thread_vr_state, vscr));
> +       DEFINE(THREAD_LOAD_VEC, offsetof(struct thread_struct, load_vec))=
;
>  #endif /* CONFIG_ALTIVEC */
>  #ifdef CONFIG_VSX
>         DEFINE(THREAD_USED_VSR, offsetof(struct thread_struct, used_vsr))=
;
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_6=
4.S
> index 0d525ce..038e0a1 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -210,7 +210,20 @@ system_call:                       /* label this so =
stack traces look sane */
>         li      r11,-MAX_ERRNO
>         andi.   r0,r9,(_TIF_SYSCALL_DOTRACE|_TIF_SINGLESTEP|_TIF_USER_WOR=
K_MASK|_TIF_PERSYSCALL_MASK)
>         bne-    syscall_exit_work
> -       cmpld   r3,r11
> +
> +       andi.   r0,r8,MSR_FP
> +       beq 2f
> +#ifdef CONFIG_ALTIVEC
> +       andis.  r0,r8,MSR_VEC@h
> +       bne     3f
> +#endif
> +2:     addi    r3,r1,STACK_FRAME_OVERHEAD
> +       bl      restore_math
> +       ld      r8,_MSR(r1)
> +       ld      r3,RESULT(r1)
> +       li      r11,-MAX_ERRNO
> +
> +3:     cmpld   r3,r11
>         ld      r5,_CCR(r1)
>         bge-    syscall_error
>  .Lsyscall_error_cont:
> @@ -602,8 +615,8 @@ _GLOBAL(ret_from_except_lite)
=20
>         /* Check current_thread_info()->flags */
>         andi.   r0,r4,_TIF_USER_WORK_MASK
> -#ifdef CONFIG_PPC_BOOK3E
>         bne     1f
> +#ifdef CONFIG_PPC_BOOK3E
>         /*
>          * Check to see if the dbcr0 register is set up to debug.
>          * Use the internal debug mode bit to do this.
> @@ -618,7 +631,9 @@ _GLOBAL(ret_from_except_lite)
>         mtspr   SPRN_DBSR,r10
>         b       restore
>  #else
> -       beq     restore
> +       addi    r3,r1,STACK_FRAME_OVERHEAD
> +       bl      restore_math
> +       b       restore
>  #endif
>  1:     andi.   r0,r4,_TIF_NEED_RESCHED
>         beq     2f
> diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
> index 2117eac..b063524 100644
> --- a/arch/powerpc/kernel/fpu.S
> +++ b/arch/powerpc/kernel/fpu.S
> @@ -130,6 +130,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
>         or      r12,r12,r4
>         std     r12,_MSR(r1)
>  #endif
> +       /* Don't care if r4 overflows, this is desired behaviour */
> +       lbz     r4,THREAD_LOAD_FP(r5)
> +       addi    r4,r4,1
> +       stb     r4,THREAD_LOAD_FP(r5)
>         addi    r10,r5,THREAD_FPSTATE
>         lfd     fr0,FPSTATE_FPSCR(r10)
>         MTFSF_L(fr0)
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index e0c3d2d..ec53468 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -374,6 +374,53 @@ void giveup_all(struct task_struct *tsk)
>  }
>  EXPORT_SYMBOL(giveup_all);
=20
> +void restore_math(struct pt_regs *regs)
> +{
> +       unsigned long msr;
> +
> +       if (!current->thread.load_fp
> +#ifdef CONFIG_ALTIVEC
> +               && !current->thread.load_vec)
> +#else
> +               )
> +#endif
> +               return;

Can you make the inline code easier to read?  Something like

#ifdef CONFIG_ALTIVEC
#define loadvec(thr) ((thr).load_vec)
#else
#define loadvec(thr) 0
#endif

void restore_math(struct pt_regs *regs)
{
       unsigned long msr;

       if (!current->thread.load_fp && !loadvec(current->thread)
		return;

> +
> +       msr =3D regs->msr;
> +       msr_check_and_set(msr_all_available);
> +
> +       /*
> +        * Only reload if the bit is not set in the user MSR, the bit BEI=
NG set
> +        * indicates that the registers are hot
> +        */
> +#ifdef CONFIG_PPC_FPU
> +       if (current->thread.load_fp && !(msr & MSR_FP)) {
> +               load_fp_state(&current->thread.fp_state);
> +               msr |=3D MSR_FP | current->thread.fpexc_mode;
> +               current->thread.load_fp++;
> +       }
> +#endif
> +#ifdef CONFIG_ALTIVEC
> +       if (current->thread.load_vec && !(msr & MSR_VEC) &&
> +                       cpu_has_feature(CPU_FTR_ALTIVEC)) {
> +               load_vr_state(&current->thread.vr_state);
> +               current->thread.used_vr =3D 1;
> +               msr |=3D MSR_VEC;
> +               current->thread.load_vec++;
> +       }
> +#endif
> +#ifdef CONFIG_VSX
> +       if (!(msr & MSR_VSX) && (msr & (MSR_FP | MSR_VEC)) =3D=3D (MSR_FP=
 | MSR_VEC)) {

What are you trying to hit with this if statement?

Seems you are turning on VSX if VSX is not already on but FP and VEC
is.  Why do you need the check MSR_VSX is not used?  That seems redundant.

> +               current->thread.used_vsr =3D 1;
> +               msr |=3D MSR_VSX;
> +       }
> +#endif
> +
> +       msr_check_and_clear(msr_all_available);

Why are you doing this?  Why all, and not just the ones you've enabled abov=
e?

> +
> +       regs->msr =3D msr;
> +}
> +
>  void flush_all_to_thread(struct task_struct *tsk)
>  {
>         if (tsk->thread.regs) {
> @@ -832,17 +879,9 @@ void restore_tm_state(struct pt_regs *regs)
=20
>         msr_diff =3D current->thread.ckpt_regs.msr & ~regs->msr;
>         msr_diff &=3D MSR_FP | MSR_VEC | MSR_VSX;
> -       if (msr_diff & MSR_FP) {
> -               msr_check_and_set(MSR_FP);
> -               load_fp_state(&current->thread.fp_state);
> -               msr_check_and_clear(MSR_FP);
> -               regs->msr |=3D current->thread.fpexc_mode;
> -       }
> -       if (msr_diff & MSR_VEC) {
> -               msr_check_and_set(MSR_VEC);
> -               load_vr_state(&current->thread.vr_state);
> -               msr_check_and_clear(MSR_VEC);
> -       }
> +
> +       restore_math(regs);
> +
>         regs->msr |=3D msr_diff;
>  }
=20
> @@ -1006,6 +1045,11 @@ struct task_struct *__switch_to(struct task_struct=
 *prev,
>                 batch =3D this_cpu_ptr(&ppc64_tlb_batch);
>                 batch->active =3D 1;
>         }
> +
> +       /* Don't do this on a kernel thread */

Why not?

> +       if (current_thread_info()->task->thread.regs)
> +               restore_math(current_thread_info()->task->thread.regs);
> +
>  #endif /* CONFIG_PPC_BOOK3S_64 */
=20
>         return last;
> diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
> index 162d0f7..038cff8 100644
> --- a/arch/powerpc/kernel/vector.S
> +++ b/arch/powerpc/kernel/vector.S
> @@ -91,6 +91,10 @@ _GLOBAL(load_up_altivec)
>         oris    r12,r12,MSR_VEC@h
>         std     r12,_MSR(r1)
>  #endif
> +       /* Don't care if r4 overflows, this is desired behaviour */
> +       lbz     r4,THREAD_LOAD_VEC(r5)
> +       addi    r4,r4,1
> +       stb     r4,THREAD_LOAD_VEC(r5)
>         addi    r6,r5,THREAD_VRSTATE
>         li      r4,1
>         li      r10,VRSTATE_VSCR
> --=20
> 2.7.0

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-devOn Fri, 2016-01-15 at 16:04=
 +1100, Cyril Bur wrote:
