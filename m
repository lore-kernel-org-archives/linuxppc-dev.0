Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FFDE1A0456
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 15:42:47 +1000 (AEST)
Message-ID: <1435902166.15310.12.camel@neuling.org>
Subject: Re: [RFC] powerpc, tm: Drop tm_orig_msr from thread_struct
From: Michael Neuling <mikey@neuling.org>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, paulus@samba.org
Date: Fri, 03 Jul 2015 15:42:46 +1000
In-Reply-To: <1429517754-7988-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1429517754-7988-1-git-send-email-khandual@linux.vnet.ibm.com>
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

On Mon, 2015-04-20 at 13:45 +0530, Anshuman Khandual wrote:
> Currently tm_orig_msr is getting used during process context switch only.
> Then there is ckpt_regs which saves the checkpointed userspace context
> The MSR slot contained in ckpt_regs structure can be used during process
> context switch instead of tm_orig_msr, thus allowing us to drop it from
> thread_struct structure. This patch does that change.
>=20
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

Acked-by: Michael Neuling <mikey@neuling.org>

Thanks!

> ---
> This issue came up in the discussion regarding ptrace interface for TM
> specific registers https://lkml.org/lkml/2015/4/20/100, so just wanted
> to give this a try. The basic TM tests still pass after this change.
>=20
>  arch/powerpc/include/asm/processor.h |  1 -
>  arch/powerpc/kernel/process.c        | 14 +++++++-------
>  2 files changed, 7 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/=
asm/processor.h
> index bf117d8..fc2a3135 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -264,7 +264,6 @@ struct thread_struct {
>  	u64		tm_tfhar;	/* Transaction fail handler addr */
>  	u64		tm_texasr;	/* Transaction exception & summary */
>  	u64		tm_tfiar;	/* Transaction fail instr address reg */
> -	unsigned long	tm_orig_msr;	/* Thread's MSR on ctx switch */
>  	struct pt_regs	ckpt_regs;	/* Checkpointed registers */
> =20
>  	unsigned long	tm_tar;
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index febb50d..654830a 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -86,7 +86,7 @@ void giveup_fpu_maybe_transactional(struct task_struct =
*tsk)
>  	if (tsk =3D=3D current && tsk->thread.regs &&
>  	    MSR_TM_ACTIVE(tsk->thread.regs->msr) &&
>  	    !test_thread_flag(TIF_RESTORE_TM)) {
> -		tsk->thread.tm_orig_msr =3D tsk->thread.regs->msr;
> +		tsk->thread.ckpt_regs.msr =3D tsk->thread.regs->msr;
>  		set_thread_flag(TIF_RESTORE_TM);
>  	}
> =20
> @@ -104,7 +104,7 @@ void giveup_altivec_maybe_transactional(struct task_s=
truct *tsk)
>  	if (tsk =3D=3D current && tsk->thread.regs &&
>  	    MSR_TM_ACTIVE(tsk->thread.regs->msr) &&
>  	    !test_thread_flag(TIF_RESTORE_TM)) {
> -		tsk->thread.tm_orig_msr =3D tsk->thread.regs->msr;
> +		tsk->thread.ckpt_regs.msr =3D tsk->thread.regs->msr;
>  		set_thread_flag(TIF_RESTORE_TM);
>  	}
> =20
> @@ -543,7 +543,7 @@ static void tm_reclaim_thread(struct thread_struct *t=
hr,
>  	 * the thread will no longer be transactional.
>  	 */
>  	if (test_ti_thread_flag(ti, TIF_RESTORE_TM)) {
> -		msr_diff =3D thr->tm_orig_msr & ~thr->regs->msr;
> +		msr_diff =3D thr->ckpt_regs.msr & ~thr->regs->msr;
>  		if (msr_diff & MSR_FP)
>  			memcpy(&thr->transact_fp, &thr->fp_state,
>  			       sizeof(struct thread_fp_state));
> @@ -594,10 +594,10 @@ static inline void tm_reclaim_task(struct task_stru=
ct *tsk)
>  	/* Stash the original thread MSR, as giveup_fpu et al will
>  	 * modify it.  We hold onto it to see whether the task used
>  	 * FP & vector regs.  If the TIF_RESTORE_TM flag is set,
> -	 * tm_orig_msr is already set.
> +	 * ckpt_regs.msr is already set.
>  	 */
>  	if (!test_ti_thread_flag(task_thread_info(tsk), TIF_RESTORE_TM))
> -		thr->tm_orig_msr =3D thr->regs->msr;
> +		thr->ckpt_regs.msr =3D thr->regs->msr;
> =20
>  	TM_DEBUG("--- tm_reclaim on pid %d (NIP=3D%lx, "
>  		 "ccr=3D%lx, msr=3D%lx, trap=3D%lx)\n",
> @@ -666,7 +666,7 @@ static inline void tm_recheckpoint_new_task(struct ta=
sk_struct *new)
>  		tm_restore_sprs(&new->thread);
>  		return;
>  	}
> -	msr =3D new->thread.tm_orig_msr;
> +	msr =3D new->thread.ckpt_regs.msr;
>  	/* Recheckpoint to restore original checkpointed register state. */
>  	TM_DEBUG("*** tm_recheckpoint of pid %d "
>  		 "(new->msr 0x%lx, new->origmsr 0x%lx)\n",
> @@ -726,7 +726,7 @@ void restore_tm_state(struct pt_regs *regs)
>  	if (!MSR_TM_ACTIVE(regs->msr))
>  		return;
> =20
> -	msr_diff =3D current->thread.tm_orig_msr & ~regs->msr;
> +	msr_diff =3D current->thread.ckpt_regs.msr & ~regs->msr;
>  	msr_diff &=3D MSR_FP | MSR_VEC | MSR_VSX;
>  	if (msr_diff & MSR_FP) {
>  		fp_enable();
