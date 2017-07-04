Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2GHT6PzCzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 06:45:56 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v64KhtRp102844
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 16:45:53 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bg9tpt0yw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 16:45:52 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Tue, 4 Jul 2017 17:45:51 -0300
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v64Kjnmn18284616
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 17:45:49 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v64KjpvD004249
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 17:45:51 -0300
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Gustavo Romero <gromero@linux.vnet.ibm.com>,
 Breno Leitao <leitao@debian.org>
Subject: [PATCH] powerpc/tm: fix live state of vs0/32 in tm_reclaim
Date: Tue,  4 Jul 2017 16:45:15 -0400
In-Reply-To: <1499127540.8033.3.camel@gmail.com>
References: <1499127540.8033.3.camel@gmail.com>
Message-Id: <1499201115-22967-1-git-send-email-gromero@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently tm_reclaim() can return with a corrupted vs0 (fp0) or vs32 (v0)
due to the fact vs0 is used to save FPSCR and vs32 is used to save VSCR.

Later, we recheckpoint trusting that the live state of FP and VEC are ok
depending on the MSR.FP and MSR.VEC bits, i.e. if MSR.FP is enabled that
means the FP registers checkpointed when we entered in TM are correct and
after a treclaim. we can trust the FP live state. Similarly to VEC regs.
However if tm_reclaim() does not return a sane state then tm_recheckpoint()
will recheckpoint a corrupted state from live state back to the checkpoint
area.

That commit fixes the corruption by restoring vs0 and vs32 from the
ckfp_state and ckvr_state after they are used to save FPSCR and VSCR,
respectively.

The effect of the issue described above is observed, for instance, once a
VSX unavailable exception is caught in the middle of a transaction with
MSR.FP = 1 or MSR.VEC = 1. If MSR.FP = 1, then after getting back to user
space FP state is corrupted. If MSR.VEC = 1, then VEC state is corrupted.

The issue does not occur if MSR.FP = 0 and MSR.VEC = 0 because ckfp_state
and ckvr_state are both copied from fp_state and vr_state, respectively,
and on recheckpointing both states will be restored from these thread
structures and not from the live state.

The issue does not occur also if MSR.FP = 1 and MSR.VEC = 1 because it
implies MSR.VSX = 1 and in that case the VSX unavailable exception does not
happen in the middle of the transactional block.

Finally, that commit also fixes the MSR used to check if FP and VEC bits
are enabled once we are in tm_reclaim_thread(). ckpt_regs.msr is valid only
if giveup_all() is called *before* using ckpt_regs.msr for checks because
check_if_tm_restore_required() in giveup_all() will copy regs->msr to
ckpt_regs.msr and so ckpt_regs.msr reflects exactly the MSR that the thread
had when it came off the processor.

No regression was observed on powerpc/tm selftests after this fix.

Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c |  9 +++++++--
 arch/powerpc/kernel/tm.S      | 14 ++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 2ad725e..ac1fc51 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -864,6 +864,13 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 	if (!MSR_TM_SUSPENDED(mfmsr()))
 		return;
 
+	/* Copy regs->msr to ckpt_regs.msr making the last valid for
+	 * the checks below. check_if_tm_restore_required() in
+	 * giveup_all() will take care of it. Also update fp_state
+	 * and vr_state from live state if the live state is valid.
+	 */
+	giveup_all(container_of(thr, struct task_struct, thread));
+
 	/*
 	 * If we are in a transaction and FP is off then we can't have
 	 * used FP inside that transaction. Hence the checkpointed
@@ -883,8 +890,6 @@ static void tm_reclaim_thread(struct thread_struct *thr,
 		memcpy(&thr->ckvr_state, &thr->vr_state,
 		       sizeof(struct thread_vr_state));
 
-	giveup_all(container_of(thr, struct task_struct, thread));
-
 	tm_reclaim(thr, thr->ckpt_regs.msr, cause);
 }
 
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 3a2d041..5dfbddb 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -259,9 +259,17 @@ _GLOBAL(tm_reclaim)
 
 	addi	r7, r3, THREAD_CKVRSTATE
 	SAVE_32VRS(0, r6, r7)	/* r6 scratch, r7 transact vr state */
+
+	/* Corrupting v0 (vs32). Should restore it later. */
 	mfvscr	v0
 	li	r6, VRSTATE_VSCR
 	stvx	v0, r7, r6
+
+	/* Restore v0 (vs32) from ckvr_state.vr[0], otherwise we might
+	 * recheckpoint the wrong live value.
+	 */
+	LXVD2X_ROT(32, R0, R7)
+
 dont_backup_vec:
 	mfspr	r0, SPRN_VRSAVE
 	std	r0, THREAD_CKVRSAVE(r3)
@@ -272,9 +280,15 @@ dont_backup_vec:
 	addi	r7, r3, THREAD_CKFPSTATE
 	SAVE_32FPRS_VSRS(0, R6, R7)	/* r6 scratch, r7 transact fp state */
 
+	/* Corrupting fr0 (vs0). Should restore it later. */
 	mffs    fr0
 	stfd    fr0,FPSTATE_FPSCR(r7)
 
+	/* Restore fr0 (vs0) from ckfp_state.fpr[0], otherwise we might
+	 * recheckpoint the wrong live value.
+	 */
+	LXVD2X_ROT(0, R0, R7)
+
 dont_backup_fp:
 
 	/* TM regs, incl TEXASR -- these live in thread_struct.  Note they've
-- 
2.7.4
