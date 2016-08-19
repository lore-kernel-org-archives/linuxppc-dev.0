Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFtT15NHzzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 16:33:25 +1000 (AEST)
Message-ID: <1471588405.5780.116.camel@neuling.org>
Subject: Re: [PATCH v3 02/21] powerpc: Always restore FPU/VEC/VSX if
 hardware transactional memory in use
From: Michael Neuling <mikey@neuling.org>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 wei.guo.simon@gmail.com
Cc: anton@samba.org
Date: Fri, 19 Aug 2016 16:33:25 +1000
In-Reply-To: <20160817034323.23053-3-cyrilbur@gmail.com>
References: <20160817034323.23053-1-cyrilbur@gmail.com>
 <20160817034323.23053-3-cyrilbur@gmail.com>
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

On Wed, 2016-08-17 at 13:43 +1000, Cyril Bur wrote:
> Comment from arch/powerpc/kernel/process.c:967:
> =C2=A0If userspace is inside a transaction (whether active or
> =C2=A0suspended) and FP/VMX/VSX instructions have ever been enabled
> =C2=A0inside that transaction, then we have to keep them enabled
> =C2=A0and keep the FP/VMX/VSX state loaded while ever the transaction
> =C2=A0continues.=C2=A0=C2=A0The reason is that if we didn't, and subseque=
ntly
> =C2=A0got a FP/VMX/VSX unavailable interrupt inside a transaction,
> =C2=A0we don't know whether it's the same transaction, and thus we
> =C2=A0don't know which of the checkpointed state and the ransactional
> =C2=A0state to use.
>=20
> restore_math() restore_fp() and restore_altivec() currently may not
> restore the registers. It doesn't appear that this is more serious
> than a performance penalty. If the math registers aren't restored the
> userspace thread will still be run with the facility disabled.
> Userspace will not be able to read invalid values. On the first access
> it will take an facility unavailable exception and the kernel will
> detected an active transaction, at which point it will abort the
> transaction. There is the possibility for a pathological case
> preventing any progress by transactions, however, transactions
> are never guaranteed to make progress.
>=20
> Fixes: 70fe3d9 ("powerpc: Restore FPU/VEC/VSX if previously used")
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---
> =C2=A0arch/powerpc/kernel/process.c | 21 ++++++++++++++++++---
> =C2=A01 file changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c
> b/arch/powerpc/kernel/process.c
> index 58ccf86..cdf2d20 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -88,7 +88,13 @@ static void check_if_tm_restore_required(struct
> task_struct *tsk)
> =C2=A0		set_thread_flag(TIF_RESTORE_TM);
> =C2=A0	}
> =C2=A0}
> +
> +static inline bool msr_tm_active(unsigned long msr)
> +{
> +	return MSR_TM_ACTIVE(msr);
> +}

I'm not sure what value this function is adding. =C2=A0The=C2=A0MSR_TM_ACTI=
VE() is
used in a lot of other places and is well known so I'd prefer to just keep
using it, rather than adding some other abstraction that others have to
learn.

Other than that, the patch seems good. =C2=A0

Mikey

> =C2=A0#else
> +static inline bool msr_tm_active(unsigned long msr) { return false; }
> =C2=A0static inline void check_if_tm_restore_required(struct task_struct =
*tsk)
> { }
> =C2=A0#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
> =C2=A0
> @@ -208,7 +214,7 @@ void enable_kernel_fp(void)
> =C2=A0EXPORT_SYMBOL(enable_kernel_fp);
> =C2=A0
> =C2=A0static int restore_fp(struct task_struct *tsk) {
> -	if (tsk->thread.load_fp) {
> +	if (tsk->thread.load_fp || msr_tm_active(tsk->thread.regs->msr))=20
> {
> =C2=A0		load_fp_state(&current->thread.fp_state);
> =C2=A0		current->thread.load_fp++;
> =C2=A0		return 1;
> @@ -278,7 +284,8 @@ EXPORT_SYMBOL_GPL(flush_altivec_to_thread);
> =C2=A0
> =C2=A0static int restore_altivec(struct task_struct *tsk)
> =C2=A0{
> -	if (cpu_has_feature(CPU_FTR_ALTIVEC) && tsk->thread.load_vec) {
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
> +		(tsk->thread.load_vec || msr_tm_active(tsk->thread.regs-
> >msr))) {
> =C2=A0		load_vr_state(&tsk->thread.vr_state);
> =C2=A0		tsk->thread.used_vr =3D 1;
> =C2=A0		tsk->thread.load_vec++;
> @@ -464,7 +471,8 @@ void restore_math(struct pt_regs *regs)
> =C2=A0{
> =C2=A0	unsigned long msr;
> =C2=A0
> -	if (!current->thread.load_fp && !loadvec(current->thread))
> +	if (!msr_tm_active(regs->msr) &&
> +		!current->thread.load_fp && !loadvec(current->thread))
> =C2=A0		return;
> =C2=A0
> =C2=A0	msr =3D regs->msr;
> @@ -983,6 +991,13 @@ void restore_tm_state(struct pt_regs *regs)
> =C2=A0	msr_diff =3D current->thread.ckpt_regs.msr & ~regs->msr;
> =C2=A0	msr_diff &=3D MSR_FP | MSR_VEC | MSR_VSX;
> =C2=A0
> +	/* Ensure that restore_math() will restore */
> +	if (msr_diff & MSR_FP)
> +		current->thread.load_fp =3D 1;
> +#ifdef CONFIG_ALIVEC
> +	if (cpu_has_feature(CPU_FTR_ALTIVEC) && msr_diff & MSR_VEC)
> +		current->thread.load_vec =3D 1;
> +#endif
> =C2=A0	restore_math(regs);
> =C2=A0
> =C2=A0	regs->msr |=3D msr_diff;
