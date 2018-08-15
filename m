Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41rlFp4lFzzDr42
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2018 21:57:50 +1000 (AEST)
Message-ID: <2f52b19a0dbd42c745dd9a3a65b95c5abb3264d8.camel@neuling.org>
Subject: Re: [PATCH v2 2/4] powerpc/tm: Fix HTM documentation
From: Michael Neuling <mikey@neuling.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Date: Thu, 16 Aug 2018 09:46:33 +1000
In-Reply-To: <1529362784-14194-2-git-send-email-leitao@debian.org>
References: <201806160346.lDndh49W%fengguang.wu@intel.com>
 <1529362784-14194-1-git-send-email-leitao@debian.org>
 <1529362784-14194-2-git-send-email-leitao@debian.org>
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

On Mon, 2018-06-18 at 19:59 -0300, Breno Leitao wrote:
> This patch simply fix part of the documentation on the HTM code.
>=20
> This fixes reference to old fields that were renamed in commit
> 000ec280e3dd ("powerpc: tm: Rename transct_(*) to ck(\1)_state")
>=20
> It also documents better the flow after commit eb5c3f1c8647 ("powerpc:
> Always save/restore checkpointed regs during treclaim/trecheckpoint"),
> where tm_recheckpoint can recheckpoint what is in ck{fp,vr}_state blindly=
.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-By: Michael Neuling <mikey@neuling.org>

Thanks

> ---
>  arch/powerpc/kernel/tm.S    | 10 +++++-----
>  arch/powerpc/kernel/traps.c | 15 +++++++++------
>  2 files changed, 14 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
> index ff12f47a96b6..019d73053cd3 100644
> --- a/arch/powerpc/kernel/tm.S
> +++ b/arch/powerpc/kernel/tm.S
> @@ -95,9 +95,9 @@ EXPORT_SYMBOL_GPL(tm_abort);
>   *		   uint8_t cause)
>   *
>   *	- Performs a full reclaim.  This destroys outstanding
> - *	  transactions and updates thread->regs.tm_ckpt_* with the
> - *	  original checkpointed state.  Note that thread->regs is
> - *	  unchanged.
> + *	  transactions and updates thread.ckpt_regs, thread.ckfp_state and
> + *	  thread.ckvr_state with the original checkpointed state.  Note that
> + *	  thread->regs is unchanged.
>   *
>   * Purpose is to both abort transactions of, and preserve the state of,
>   * a transactions at a context switch. We preserve/restore both sets of
> process
> @@ -260,7 +260,7 @@ _GLOBAL(tm_reclaim)
> =20
>  	/* Altivec (VEC/VMX/VR)*/
>  	addi	r7, r3, THREAD_CKVRSTATE
> -	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
> +	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 ckvr_state */
>  	mfvscr	v0
>  	li	r6, VRSTATE_VSCR
>  	stvx	v0, r7, r6
> @@ -271,7 +271,7 @@ _GLOBAL(tm_reclaim)
> =20
>  	/* Floating Point (FP) */
>  	addi	r7, r3, THREAD_CKFPSTATE
> -	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 transact fp state */
> +	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 ckfp_state */
>  	mffs    fr0
>  	stfd    fr0,FPSTATE_FPSCR(r7)
> =20
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 0e17dcb48720..6742b6b3eb37 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1719,16 +1719,19 @@ void fp_unavailable_tm(struct pt_regs *regs)
>           * checkpointed FP registers need to be loaded.
>  	 */
>  	tm_reclaim_current(TM_CAUSE_FAC_UNAV);
> -	/* Reclaim didn't save out any FPRs to transact_fprs. */
> +
> +	/* Reclaim initially saved out bogus (lazy) FPRs to ckfp_state, and
> +	 * then it was overwrite by the thr->fp_state by tm_reclaim_thread().
> +	 *
> +	 * At this point, ck{fp,vr}_state contains the exact values we want to
> +	 * recheckpoint.
> +	 */
> =20
>  	/* Enable FP for the task: */
>  	current->thread.load_fp =3D 1;
> =20
> -	/* This loads and recheckpoints the FP registers from
> -	 * thread.fpr[].  They will remain in registers after the
> -	 * checkpoint so we don't need to reload them after.
> -	 * If VMX is in use, the VRs now hold checkpointed values,
> -	 * so we don't want to load the VRs from the thread_struct.
> +	/*
> +	 * Recheckpoint all the checkpointed ckpt, ck{fp, vr}_state registers.
>  	 */
>  	tm_recheckpoint(&current->thread);
>  }
