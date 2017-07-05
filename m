Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2Mzj74HYzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 11:02:41 +1000 (AEST)
Message-ID: <1499216561.7056.7.camel@neuling.org>
Subject: Re: [PATCH] powerpc/tm: fix live state of vs0/32 in tm_reclaim
From: Michael Neuling <mikey@neuling.org>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>, Cyril Bur <cyrilbur@gmail.com>
Date: Wed, 05 Jul 2017 11:02:41 +1000
In-Reply-To: <1499201115-22967-1-git-send-email-gromero@linux.vnet.ibm.com>
References: <1499127540.8033.3.camel@gmail.com>
 <1499201115-22967-1-git-send-email-gromero@linux.vnet.ibm.com>
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

On Tue, 2017-07-04 at 16:45 -0400, Gustavo Romero wrote:
> Currently tm_reclaim() can return with a corrupted vs0 (fp0) or vs32 (v0)
> due to the fact vs0 is used to save FPSCR and vs32 is used to save VSCR.

tm_reclaim() should have no state live in the registers once it returns.  I=
t
should all be saved in the thread struct. The above is not an issue in my b=
ook.

Having a quick look at the code, I think there's and issue but we need some=
thing
more like this (completely untested).

When we recheckpoint inside an fp unavail, we need to recheckpoint vec if i=
t was
enabled.  Currently we only ever recheckpoint the FP which seems like a bug=
.=20
Visa versa for the other way around.

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d4e545d27e..d1184264e2 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1589,7 +1589,7 @@ void fp_unavailable_tm(struct pt_regs *regs)
         * If VMX is in use, the VRs now hold checkpointed values,
         * so we don't want to load the VRs from the thread_struct.
         */
-       tm_recheckpoint(&current->thread, MSR_FP);
+       tm_recheckpoint(&current->thread, regs->msr);
=20
        /* If VMX is in use, get the transactional values back */
        if (regs->msr & MSR_VEC) {
@@ -1611,7 +1611,7 @@ void altivec_unavailable_tm(struct pt_regs *regs)
                 regs->nip, regs->msr);
        tm_reclaim_current(TM_CAUSE_FAC_UNAV);
        regs->msr |=3D MSR_VEC;
-       tm_recheckpoint(&current->thread, MSR_VEC);
+       tm_recheckpoint(&current->thread, regs->msr);
        current->thread.used_vr =3D 1;
=20
        if (regs->msr & MSR_FP) {


> Later, we recheckpoint trusting that the live state of FP and VEC are ok
> depending on the MSR.FP and MSR.VEC bits, i.e. if MSR.FP is enabled that
> means the FP registers checkpointed when we entered in TM are correct and
> after a treclaim. we can trust the FP live state. Similarly to VEC regs.
> However if tm_reclaim() does not return a sane state then tm_recheckpoint=
()
> will recheckpoint a corrupted state from live state back to the checkpoin=
t
> area.




> That commit fixes the corruption by restoring vs0 and vs32 from the
> ckfp_state and ckvr_state after they are used to save FPSCR and VSCR,
> respectively.
>=20
> The effect of the issue described above is observed, for instance, once a
> VSX unavailable exception is caught in the middle of a transaction with
> MSR.FP =3D 1 or MSR.VEC =3D 1. If MSR.FP =3D 1, then after getting back t=
o user
> space FP state is corrupted. If MSR.VEC =3D 1, then VEC state is corrupte=
d.
>=20
> The issue does not occur if MSR.FP =3D 0 and MSR.VEC =3D 0 because ckfp_s=
tate
> and ckvr_state are both copied from fp_state and vr_state, respectively,
> and on recheckpointing both states will be restored from these thread
> structures and not from the live state.
>=20
> The issue does not occur also if MSR.FP =3D 1 and MSR.VEC =3D 1 because i=
t
> implies MSR.VSX =3D 1 and in that case the VSX unavailable exception does=
 not
> happen in the middle of the transactional block.
>=20
> Finally, that commit also fixes the MSR used to check if FP and VEC bits
> are enabled once we are in tm_reclaim_thread(). ckpt_regs.msr is valid on=
ly
> if giveup_all() is called *before* using ckpt_regs.msr for checks because
> check_if_tm_restore_required() in giveup_all() will copy regs->msr to
> ckpt_regs.msr and so ckpt_regs.msr reflects exactly the MSR that the thre=
ad
> had when it came off the processor.
>=20
> No regression was observed on powerpc/tm selftests after this fix.
>=20
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> =C2=A0arch/powerpc/kernel/process.c |=C2=A0=C2=A09 +++++++--
> =C2=A0arch/powerpc/kernel/tm.S=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| 14 ++=
++++++++++++
> =C2=A02 files changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.=
c
> index 2ad725e..ac1fc51 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -864,6 +864,13 @@ static void tm_reclaim_thread(struct thread_struct *=
thr,
> =C2=A0	if (!MSR_TM_SUSPENDED(mfmsr()))
> =C2=A0		return;
> =C2=A0
> +	/* Copy regs->msr to ckpt_regs.msr making the last valid for
> +	=C2=A0* the checks below. check_if_tm_restore_required() in
> +	=C2=A0* giveup_all() will take care of it. Also update fp_state
> +	=C2=A0* and vr_state from live state if the live state is valid.
> +	=C2=A0*/
> +	giveup_all(container_of(thr, struct task_struct, thread));
> +
> =C2=A0	/*
> =C2=A0	=C2=A0* If we are in a transaction and FP is off then we can't hav=
e
> =C2=A0	=C2=A0* used FP inside that transaction. Hence the checkpointed
> @@ -883,8 +890,6 @@ static void tm_reclaim_thread(struct thread_struct *t=
hr,
> =C2=A0		memcpy(&thr->ckvr_state, &thr->vr_state,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sizeof(struct thread_vr=
_state));
> =C2=A0
> -	giveup_all(container_of(thr, struct task_struct, thread));
> -
> =C2=A0	tm_reclaim(thr, thr->ckpt_regs.msr, cause);
> =C2=A0}
> =C2=A0
> diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
> index 3a2d041..5dfbddb 100644
> --- a/arch/powerpc/kernel/tm.S
> +++ b/arch/powerpc/kernel/tm.S
> @@ -259,9 +259,17 @@ _GLOBAL(tm_reclaim)
> =C2=A0
> =C2=A0	addi	r7, r3, THREAD_CKVRSTATE
> =C2=A0	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
> +
> +	/* Corrupting v0 (vs32). Should restore it later. */
> =C2=A0	mfvscr	v0
> =C2=A0	li	r6, VRSTATE_VSCR
> =C2=A0	stvx	v0, r7, r6
> +
> +	/* Restore v0 (vs32) from ckvr_state.vr[0], otherwise we might
> +	=C2=A0* recheckpoint the wrong live value.
> +	=C2=A0*/
> +	LXVD2X_ROT(32, R0, R7)
> +
> =C2=A0dont_backup_vec:
> =C2=A0	mfspr	r0, SPRN_VRSAVE
> =C2=A0	std	r0, THREAD_CKVRSAVE(r3)
> @@ -272,9 +280,15 @@ dont_backup_vec:
> =C2=A0	addi	r7, r3, THREAD_CKFPSTATE
> =C2=A0	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 transact fp
> state */
> =C2=A0
> +	/* Corrupting fr0 (vs0). Should restore it later. */
> =C2=A0	mffs=C2=A0=C2=A0=C2=A0=C2=A0fr0
> =C2=A0	stfd=C2=A0=C2=A0=C2=A0=C2=A0fr0,FPSTATE_FPSCR(r7)
> =C2=A0
> +	/* Restore fr0 (vs0) from ckfp_state.fpr[0], otherwise we might
> +	=C2=A0* recheckpoint the wrong live value.
> +	=C2=A0*/
> +	LXVD2X_ROT(0, R0, R7)
> +
> =C2=A0dont_backup_fp:
> =C2=A0
> =C2=A0	/* TM regs, incl TEXASR -- these live in thread_struct.=C2=A0=C2=
=A0Note they've
