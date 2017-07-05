Return-Path: <breno.debian@gmail.com>
Received: from mail-qk0-f196.google.com (mail-qk0-f196.google.com
 [209.85.220.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2tV10T1xzDqj2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 06:57:13 +1000 (AEST)
Received: by mail-qk0-f196.google.com with SMTP id p21so126208qke.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 13:57:12 -0700 (PDT)
Date: Wed, 5 Jul 2017 17:57:04 -0300
From: Breno Leitao <leitao@debian.org>
To: Michael Neuling <mikey@neuling.org>
Cc: Gustavo Romero <gromero@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Cyril Bur <cyrilbur@gmail.com>
Subject: Re: [PATCH] powerpc/tm: fix live state of vs0/32 in tm_reclaim
Message-ID: <20170705205657.lsmt34u6fvp6lls4@gmail.com>
References: <1499127540.8033.3.camel@gmail.com>
 <1499201115-22967-1-git-send-email-gromero@linux.vnet.ibm.com>
 <1499216561.7056.7.camel@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1499216561.7056.7.camel@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Wed, Jul 05, 2017 at 11:02:41AM +1000, Michael Neuling wrote:
> On Tue, 2017-07-04 at 16:45 -0400, Gustavo Romero wrote:
> > Currently tm_reclaim() can return with a corrupted vs0 (fp0) or vs32 (v0)
> > due to the fact vs0 is used to save FPSCR and vs32 is used to save VSCR.
> 
> tm_reclaim() should have no state live in the registers once it returns.  It
> should all be saved in the thread struct. The above is not an issue in my book.

Right, but we will always recheckpoint from the live anyway, so, if we do not
force the MSR_VEC and/or MSR_FP in tm_recheckpoint(), then we will
inevitably put the live registers into the checkpoint area.

It might not be a problem for VEC/FP if they are disabled, since a later
VEC/FP touch will raise a fp/vec_unavailable() exception which will fill
out the registers properly, replacing the old state brought from the
checkpoint area.

> When we recheckpoint inside an fp unavail, we need to recheckpoint vec if it was
> enabled.  Currently we only ever recheckpoint the FP which seems like a bug. 
> Visa versa for the other way around.

This seems to be another problem that also exists in the code, but it is
essentially different from the one in this thread, which happens on the
VSX unavailable exception path. Although essentially different, the solution
might be similar. So, a fix that would resolve all the issues reported here
would sound like. What do you think?

---
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d4e545d..76a35ab 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1589,7 +1589,7 @@ void fp_unavailable_tm(struct pt_regs *regs)
         * If VMX is in use, the VRs now hold checkpointed values,
         * so we don't want to load the VRs from the thread_struct.
         */
-       tm_recheckpoint(&current->thread, MSR_FP);
+       tm_recheckpoint(&current->thread, regs->msr);
 
        /* If VMX is in use, get the transactional values back */
        if (regs->msr & MSR_VEC) {
@@ -1611,7 +1611,7 @@ void altivec_unavailable_tm(struct pt_regs *regs)
                 regs->nip, regs->msr);
        tm_reclaim_current(TM_CAUSE_FAC_UNAV);
        regs->msr |= MSR_VEC;
-       tm_recheckpoint(&current->thread, MSR_VEC);
+       tm_recheckpoint(&current->thread, regs->msr );
        current->thread.used_vr = 1;
 
        if (regs->msr & MSR_FP) {
@@ -1653,7 +1653,7 @@ void vsx_unavailable_tm(struct pt_regs *regs)
        /* This loads & recheckpoints FP and VRs; but we have
         * to be sure not to overwrite previously-valid state.
         */
-       tm_recheckpoint(&current->thread, regs->msr & ~orig_msr);
+       tm_recheckpoint(&current->thread, regs->msr);
 
        msr_check_and_set(orig_msr & (MSR_FP | MSR_VEC));

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9f3e2c9..c6abad1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -880,10 +880,10 @@ static void tm_reclaim_thread(struct thread_struct *thr,
         * not. So either this will write the checkpointed registers,
         * or reclaim will. Similarly for VMX.
         */
-       if ((thr->ckpt_regs.msr & MSR_FP) == 0)
+       if ((thr->regs->msr & MSR_FP) == 0)
                memcpy(&thr->ckfp_state, &thr->fp_state,
                       sizeof(struct thread_fp_state));
-       if ((thr->ckpt_regs.msr & MSR_VEC) == 0)
+       if ((thr->regs->msr & MSR_VEC) == 0)
                memcpy(&thr->ckvr_state, &thr->vr_state,
                       sizeof(struct thread_vr_state));
