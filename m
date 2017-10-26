Return-Path: <cyrilbur@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMvrj11G3zDqqK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 15:57:40 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 17so1640081pfn.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 21:57:40 -0700 (PDT)
Message-ID: <1508993853.4514.9.camel@gmail.com>
Subject: Re: [PATCH] powerpc/tm: fix live state of vs0/32 in tm_reclaim
From: Cyril Bur <cyrilbur@gmail.com>
To: Michael Neuling <mikey@neuling.org>, Gustavo Romero
 <gromero@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Date: Thu, 26 Oct 2017 15:57:33 +1100
In-Reply-To: <1499216561.7056.7.camel@neuling.org>
References: <1499127540.8033.3.camel@gmail.com>
 <1499201115-22967-1-git-send-email-gromero@linux.vnet.ibm.com>
 <1499216561.7056.7.camel@neuling.org>
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

On Wed, 2017-07-05 at 11:02 +1000, Michael Neuling wrote:
> On Tue, 2017-07-04 at 16:45 -0400, Gustavo Romero wrote:
> > Currently tm_reclaim() can return with a corrupted vs0 (fp0) or vs32 (v0)
> > due to the fact vs0 is used to save FPSCR and vs32 is used to save VSCR.
> 

Hi Mikey,

This completely fell off my radar, we do need something merged!

For what its worth I like the original patch.

> tm_reclaim() should have no state live in the registers once it returns.  It
> should all be saved in the thread struct. The above is not an issue in my book.
> 

Yeah, this is something I agree with, however, if that is the case then
why have tm_recheckpoint() do partial reloads?

A partial reload only makes sense if we can be sure that reclaim will
have left the state at least (partially) correct - not with (as is the
case today) one corrupted fp or Altivec reg.

> Having a quick look at the code, I think there's and issue but we need something
> more like this (completely untested).
> 
> When we recheckpoint inside an fp unavail, we need to recheckpoint vec if it was
> enabled.  Currently we only ever recheckpoint the FP which seems like a bug. 
> Visa versa for the other way around.
> 

In your example, we don't need to reload VEC if we can trust that
reclaim left the checkpointed regs on the CPU correctly - this patch
achieves this.

Of course I'm more than happy to reduce complexity and not have this
optimisation at all but then we should remove the entire parameter to
tm_recheckpoint(). Any in between feels dangerous.


Cyril


> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index d4e545d27e..d1184264e2 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1589,7 +1589,7 @@ void fp_unavailable_tm(struct pt_regs *regs)
>          * If VMX is in use, the VRs now hold checkpointed values,
>          * so we don't want to load the VRs from the thread_struct.
>          */
> -       tm_recheckpoint(&current->thread, MSR_FP);
> +       tm_recheckpoint(&current->thread, regs->msr);
>  
>         /* If VMX is in use, get the transactional values back */
>         if (regs->msr & MSR_VEC) {
> @@ -1611,7 +1611,7 @@ void altivec_unavailable_tm(struct pt_regs *regs)
>                  regs->nip, regs->msr);
>         tm_reclaim_current(TM_CAUSE_FAC_UNAV);
>         regs->msr |= MSR_VEC;
> -       tm_recheckpoint(&current->thread, MSR_VEC);
> +       tm_recheckpoint(&current->thread, regs->msr);
>         current->thread.used_vr = 1;
>  
>         if (regs->msr & MSR_FP) {
> 
> 
> > Later, we recheckpoint trusting that the live state of FP and VEC are ok
> > depending on the MSR.FP and MSR.VEC bits, i.e. if MSR.FP is enabled that
> > means the FP registers checkpointed when we entered in TM are correct and
> > after a treclaim. we can trust the FP live state. Similarly to VEC regs.
> > However if tm_reclaim() does not return a sane state then tm_recheckpoint()
> > will recheckpoint a corrupted state from live state back to the checkpoint
> > area.
> 
> 
> 
> 
> > That commit fixes the corruption by restoring vs0 and vs32 from the
> > ckfp_state and ckvr_state after they are used to save FPSCR and VSCR,
> > respectively.
> > 
> > The effect of the issue described above is observed, for instance, once a
> > VSX unavailable exception is caught in the middle of a transaction with
> > MSR.FP = 1 or MSR.VEC = 1. If MSR.FP = 1, then after getting back to user
> > space FP state is corrupted. If MSR.VEC = 1, then VEC state is corrupted.
> > 
> > The issue does not occur if MSR.FP = 0 and MSR.VEC = 0 because ckfp_state
> > and ckvr_state are both copied from fp_state and vr_state, respectively,
> > and on recheckpointing both states will be restored from these thread
> > structures and not from the live state.
> > 
> > The issue does not occur also if MSR.FP = 1 and MSR.VEC = 1 because it
> > implies MSR.VSX = 1 and in that case the VSX unavailable exception does not
> > happen in the middle of the transactional block.
> > 
> > Finally, that commit also fixes the MSR used to check if FP and VEC bits
> > are enabled once we are in tm_reclaim_thread(). ckpt_regs.msr is valid only
> > if giveup_all() is called *before* using ckpt_regs.msr for checks because
> > check_if_tm_restore_required() in giveup_all() will copy regs->msr to
> > ckpt_regs.msr and so ckpt_regs.msr reflects exactly the MSR that the thread
> > had when it came off the processor.
> > 
> > No regression was observed on powerpc/tm selftests after this fix.
> > 
> > Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  arch/powerpc/kernel/process.c |  9 +++++++--
> >  arch/powerpc/kernel/tm.S      | 14 ++++++++++++++
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> > index 2ad725e..ac1fc51 100644
> > --- a/arch/powerpc/kernel/process.c
> > +++ b/arch/powerpc/kernel/process.c
> > @@ -864,6 +864,13 @@ static void tm_reclaim_thread(struct thread_struct *thr,
> >  	if (!MSR_TM_SUSPENDED(mfmsr()))
> >  		return;
> >  
> > +	/* Copy regs->msr to ckpt_regs.msr making the last valid for
> > +	 * the checks below. check_if_tm_restore_required() in
> > +	 * giveup_all() will take care of it. Also update fp_state
> > +	 * and vr_state from live state if the live state is valid.
> > +	 */
> > +	giveup_all(container_of(thr, struct task_struct, thread));
> > +
> >  	/*
> >  	 * If we are in a transaction and FP is off then we can't have
> >  	 * used FP inside that transaction. Hence the checkpointed
> > @@ -883,8 +890,6 @@ static void tm_reclaim_thread(struct thread_struct *thr,
> >  		memcpy(&thr->ckvr_state, &thr->vr_state,
> >  		       sizeof(struct thread_vr_state));
> >  
> > -	giveup_all(container_of(thr, struct task_struct, thread));
> > -
> >  	tm_reclaim(thr, thr->ckpt_regs.msr, cause);
> >  }
> >  
> > diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
> > index 3a2d041..5dfbddb 100644
> > --- a/arch/powerpc/kernel/tm.S
> > +++ b/arch/powerpc/kernel/tm.S
> > @@ -259,9 +259,17 @@ _GLOBAL(tm_reclaim)
> >  
> >  	addi	r7, r3, THREAD_CKVRSTATE
> >  	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
> > +
> > +	/* Corrupting v0 (vs32). Should restore it later. */
> >  	mfvscr	v0
> >  	li	r6, VRSTATE_VSCR
> >  	stvx	v0, r7, r6
> > +
> > +	/* Restore v0 (vs32) from ckvr_state.vr[0], otherwise we might
> > +	 * recheckpoint the wrong live value.
> > +	 */
> > +	LXVD2X_ROT(32, R0, R7)
> > +
> >  dont_backup_vec:
> >  	mfspr	r0, SPRN_VRSAVE
> >  	std	r0, THREAD_CKVRSAVE(r3)
> > @@ -272,9 +280,15 @@ dont_backup_vec:
> >  	addi	r7, r3, THREAD_CKFPSTATE
> >  	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 transact fp
> > state */
> >  
> > +	/* Corrupting fr0 (vs0). Should restore it later. */
> >  	mffs    fr0
> >  	stfd    fr0,FPSTATE_FPSCR(r7)
> >  
> > +	/* Restore fr0 (vs0) from ckfp_state.fpr[0], otherwise we might
> > +	 * recheckpoint the wrong live value.
> > +	 */
> > +	LXVD2X_ROT(0, R0, R7)
> > +
> >  dont_backup_fp:
> >  
> >  	/* TM regs, incl TEXASR -- these live in thread_struct.  Note they've
