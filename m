Return-Path: <cyrilbur@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1l3w0ykdzDqRW
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 10:19:08 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id d193so6153366pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 17:19:08 -0700 (PDT)
Message-ID: <1499127540.8033.3.camel@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/tm: fix live state of vs0/32 in tm_reclaim
From: Cyril Bur <cyrilbur@gmail.com>
To: Gustavo Romero <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: leitao@debian.org
Date: Tue, 04 Jul 2017 10:19:00 +1000
In-Reply-To: <1498783490-23675-1-git-send-email-gromero@linux.vnet.ibm.com>
References: <1498783490-23675-1-git-send-email-gromero@linux.vnet.ibm.com>
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

On Thu, 2017-06-29 at 20:44 -0400, Gustavo Romero wrote:
> Currently tm_reclaim() can return with a corrupted vs0 (fp0) or vs32 (v0)
> due to the fact vs0 is used to save FPSCR and vs32 is used to save VSCR.
> 
> Later, we recheckpoint trusting that the live state of FP and VEC are ok
> depending on the MSR.FP and MSR.VEC bits, i.e. if MSR.FP is enabled that
> means the FP registers checkpointed before entering are correct and so
> after a treclaim. we can trust the FP live state, and similarly on VEC regs.
> However if tm_reclaim() does not return a sane state then tm_recheckpoint()
> will recheckpoint a corrupted instate back to the checkpoint area.
> 
> That commit fixes the corruption by restoring vs0 and vs32 from the
> ckfp_state and ckvr_state after they are used to save FPSCR and VSCR,
> respectively.
> 
> The effect of the issue described above is observed, for instance, once a
> VSX unavailable exception is caught in the middle of a transaction with
> MSR.FP = 1 or MSR.VEC = 1. If MSR.FP = 1, then after getting back to user
> space FP state is corrupted. If MSR.VEC = 1, then VEC state is corrupted.
> 
> The issue does occur if MSR.FP = 0 and MSR.VEC = 0 because ckfp_state and
> ckvr_state are both copied from fp_state and vr_state, respectively, and
> on recheckpointing both states will be restored from these thread
> structures and not from the live state.
> 
> The issue does no occur also if MSR.FP = 1 and MSR.VEC = 1 because it
> implies MSR.VSX = 1 and in that case the VSX unavailable exception does not
> happen in the middle of the transactional block.
> 
> Finally, that commit also fixes the MSR used to check if FP or VEC bit are
> enabled once we are in tm_reclaim_thread(). Checking ckpt_regs.msr is not
> correct because giveup_all(), which copies regs->msr to ckpt_regs.msr, was
> not called before and so the ckpt_regs.msr at that point is not valid, i.e.
> it does not reflect the MSR state in userspace.
> 
> No regression was observed on powerpc/tm selftests after this fix.
> 
> Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  arch/powerpc/kernel/process.c | 15 ++++++++-------
>  arch/powerpc/kernel/tm.S      | 16 ++++++++++++++++
>  2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 2ad725e..df8e348 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -870,21 +870,22 @@ static void tm_reclaim_thread(struct thread_struct *thr,
>  	 * state is the same as the live state. We need to copy the
>  	 * live state to the checkpointed state so that when the
>  	 * transaction is restored, the checkpointed state is correct
> -	 * and the aborted transaction sees the correct state. We use
> -	 * ckpt_regs.msr here as that's what tm_reclaim will use to
> -	 * determine if it's going to write the checkpointed state or
> -	 * not. So either this will write the checkpointed registers,
> -	 * or reclaim will. Similarly for VMX.
> +	 * and the aborted transaction sees the correct state. So
> +	 * either this will write the checkpointed registers, or
> +	 * reclaim will. Similarly for VMX.
>  	 */
> -	if ((thr->ckpt_regs.msr & MSR_FP) == 0)
> +	if ((thr->regs->msr & MSR_FP) == 0)
>  		memcpy(&thr->ckfp_state, &thr->fp_state,
>  		       sizeof(struct thread_fp_state));
> -	if ((thr->ckpt_regs.msr & MSR_VEC) == 0)
> +	if ((thr->regs->msr & MSR_VEC) == 0)
>  		memcpy(&thr->ckvr_state, &thr->vr_state,
>  		       sizeof(struct thread_vr_state));
>  

So the name of that variable is horrifying - I don't know why it is
called that I expect to save 'space' but its not helping anyone. Poor
variable names not withstanding I believe the original code is correct.

What the chkp_regs.msr means here is, the MSR that the thread had when
it when it came off the processor. The reason for this is that
giveup_fpu (and friends) will modify thread.regs->msr when doing the
giveup so when reclaiming we can't trust it to know what the live state
really was. check_if_tm_restore_required() copies the thread.regs->msr
into the checkpointed structure so we know if the thread was really
using FP/VMX/VSX or not. check_if_tm_restore_required() is called
before any giveup operation.

I do wonder if it would make more sense for the giveup_all() below to
be above. I don't think there are any code pathes that can get here
without having already done a giveup_all() but, perhaps it is possible.
I don't think it will hurt to move it up, it feels more correct

>  	giveup_all(container_of(thr, struct task_struct, thread));
>  
> +	/* After giveup_all(), ckpt_regs.msr contains the same value
> +	 * of regs->msr when we entered in kernel space.
> +	 */
>  	tm_reclaim(thr, thr->ckpt_regs.msr, cause);
>  }
>  
> diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
> index 3a2d041..67b56af 100644
> --- a/arch/powerpc/kernel/tm.S
> +++ b/arch/powerpc/kernel/tm.S
> @@ -259,9 +259,18 @@ _GLOBAL(tm_reclaim)
>  
>  	addi	r7, r3, THREAD_CKVRSTATE
>  	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
> +
> +	/* Corrupting v0 (vs32). Should restore it later. */
>  	mfvscr	v0
>  	li	r6, VRSTATE_VSCR
>  	stvx	v0, r7, r6
> +
> +	/* Restore v0 (vs32) from ckvr_state.vr[0], otherwise we might
> +	 * recheckpoint the wrong live value.
> +	 */
> +	lxvx	vs32, 0, r7
> +	xxswapd	vs32, vs32

Yes good find!

I feel like the crux of the problem is that we don't always
tm_recheckpoint() with the same msr as we tm_reclaimed() with, is THIS
the core of the problem? In the traps.c case it is an optimisation,
perhaps a pointless one, if I had spare time I would benchmark if it is
worth it.

This code absolutely can't hurt and does solve a real problem.

Perhaps use the macro, I think what you want is:

/* r0 evaluates to literal zero pp 489 ISA 3.0 */
LXVD2X_ROT(32, r0, r7)

> +
>  dont_backup_vec:
>  	mfspr	r0, SPRN_VRSAVE
>  	std	r0, THREAD_CKVRSAVE(r3)
> @@ -272,9 +281,16 @@ dont_backup_vec:
>  	addi	r7, r3, THREAD_CKFPSTATE
>  	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 transact fp state */
>  
> +	/* Corrupting fr0 (vs0). Should restore it later. */
>  	mffs    fr0
>  	stfd    fr0,FPSTATE_FPSCR(r7)
>  
> +	/* Restore fr0 (vs32) from ckfp_state.fpr[0], otherwise we might
> +	 * recheckpoint the wrong live value.
> +	 */
> +	lxvx	vs0, 0, r7
> +	xxswapd vs0, vs0

/* r0 evaluates to literal zero pp 489 ISA 3.0 */
LXVD2X_ROT(0, r0, r7)


> +
>  dont_backup_fp:
>  
>  	/* TM regs, incl TEXASR -- these live in thread_struct.  Note they've
