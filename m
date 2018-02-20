Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlhCs4qdvzDrdv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 11:23:05 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1K0IplO063163
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:03 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g85g3pmqp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 19:23:03 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Tue, 20 Feb 2018 00:23:01 -0000
From: Cyril Bur <cyrilbur@gmail.com>
To: mikey@neuling.org, benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 09/12] [WIP] powerpc/tm: Tweak signal code to handle new
 reclaim/recheckpoint times
Date: Tue, 20 Feb 2018 11:22:38 +1100
In-Reply-To: <20180220002241.29648-1-cyrilbur@gmail.com>
References: <20180220002241.29648-1-cyrilbur@gmail.com>
Message-Id: <20180220002241.29648-10-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

---
 arch/powerpc/kernel/process.c   | 13 ++++++++++++-
 arch/powerpc/kernel/signal.c    | 11 ++++++-----
 arch/powerpc/kernel/signal_32.c | 16 ++--------------
 arch/powerpc/kernel/signal_64.c | 41 +++++++++++++++++++++++++++++------------
 4 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8a32fd062a2b..cd3ae80a6878 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1070,9 +1070,20 @@ void restore_tm_state(struct pt_regs *regs)
 	 * again, anything else could lead to an incorrect ckpt_msr being
 	 * saved and therefore incorrect signal contexts.
 	 */
-	clear_thread_flag(TIF_RESTORE_TM);
+
+	/*
+	 * So, on signals we're going to have cleared the TM bits from
+	 * the MSR, meaning that heading to userspace signal handler
+	 * this will be true.
+	 * I'm not convinced clearing the TIF_RESTORE_TM flag is a
+	 * good idea however, we should do it only if we actually
+	 * recheckpoint, which we'll need to do once the signal
+	 * hanlder is done and we're returning to the main thread of
+	 * execution.
+	 */
 	if (!MSR_TM_ACTIVE(regs->msr))
 		return;
+	clear_thread_flag(TIF_RESTORE_TM);
 
 	msr_diff = current->thread.ckpt_regs.msr & ~regs->msr;
 	msr_diff &= MSR_FP | MSR_VEC | MSR_VSX;
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 61db86ecd318..4f0398c6ce03 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -191,16 +191,17 @@ unsigned long get_tm_stackpointer(struct task_struct *tsk)
 	 *
 	 * For signals taken in non-TM or suspended mode, we use the
 	 * normal/non-checkpointed stack pointer.
+	 *
+	 * We now do reclaims on kernel entry, we should absolutely
+	 * never need to reclaim here.
+	 * TODO Update the comment above if needed.
 	 */
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	BUG_ON(tsk != current);
 
-	if (MSR_TM_ACTIVE(tsk->thread.regs->msr)) {
-		tm_reclaim_current(TM_CAUSE_SIGNAL);
-		if (MSR_TM_TRANSACTIONAL(tsk->thread.regs->msr))
-			return tsk->thread.ckpt_regs.gpr[1];
-	}
+	if (MSR_TM_TRANSACTIONAL(tsk->thread.regs->msr))
+		return tsk->thread.ckpt_regs.gpr[1];
 #endif
 	return tsk->thread.regs->gpr[1];
 }
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index a46de0035214..a87a7c8b5d9e 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -860,21 +860,9 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	tm_enable();
 	/* Make sure the transaction is marked as failed */
 	current->thread.tm_texasr |= TEXASR_FS;
-	/* This loads the checkpointed FP/VEC state, if used */
-	tm_recheckpoint(&current->thread);
 
-	/* This loads the speculative FP/VEC state, if used */
-	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
-	if (msr & MSR_FP) {
-		load_fp_state(&current->thread.fp_state);
-		regs->msr |= (MSR_FP | current->thread.fpexc_mode);
-	}
-#ifdef CONFIG_ALTIVEC
-	if (msr & MSR_VEC) {
-		load_vr_state(&current->thread.vr_state);
-		regs->msr |= MSR_VEC;
-	}
-#endif
+	/* See comment in signal_64.c */
+	set_thread_flag(TIF_RESTORE_TM);
 
 	return 0;
 }
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 720117690822..a7751d1fcac6 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -568,21 +568,20 @@ static long restore_tm_sigcontexts(struct task_struct *tsk,
 		}
 	}
 #endif
-	tm_enable();
 	/* Make sure the transaction is marked as failed */
 	tsk->thread.tm_texasr |= TEXASR_FS;
-	/* This loads the checkpointed FP/VEC state, if used */
-	tm_recheckpoint(&tsk->thread);
 
-	msr_check_and_set(msr & (MSR_FP | MSR_VEC));
-	if (msr & MSR_FP) {
-		load_fp_state(&tsk->thread.fp_state);
-		regs->msr |= (MSR_FP | tsk->thread.fpexc_mode);
-	}
-	if (msr & MSR_VEC) {
-		load_vr_state(&tsk->thread.vr_state);
-		regs->msr |= MSR_VEC;
-	}
+	/*
+	 * I believe this is only nessesary if the
+	 * clear_thread_flag(TIF_RESTORE_TM); in restore_tm_state()
+	 * stays before the if (!MSR_TM_ACTIVE(regs->msr).
+	 *
+	 * Actually no, we should follow the comment in
+	 * restore_tm_state() but this should ALSO be here if
+	 * if the signal handler does something crazy like 'generate'
+	 * a transaction.
+	 */
+	set_thread_flag(TIF_RESTORE_TM);
 
 	return err;
 }
@@ -734,6 +733,22 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 	if (MSR_TM_SUSPENDED(mfmsr()))
 		tm_reclaim_current(0);
 
+	/*
+	 * There is a universe where the signal handler did something
+	 * crazy like drop the transaction entirely. That is, the main
+	 * thread was in transactional or suspended mode and the
+	 * signal handler has put them in non transactional mode.
+	 * In that case we'll need to clear the TIF_RESTORE_TM flag.
+	 * I'll need to ponder it exactly but for now thats all I
+	 * think that needs to be done. At the moment it all works
+	 * because no signal hanlder is nuts enough to do it.
+	 *
+	 * Add... somewhere... I guess in the else block, in the
+	 * after the #endif
+	 *
+	 * clear_thread_flag(TIF_RESTORE_TM);
+	 */
+
 	if (__get_user(msr, &uc->uc_mcontext.gp_regs[PT_MSR]))
 		goto badframe;
 	if (MSR_TM_ACTIVE(msr)) {
@@ -748,6 +763,8 @@ int sys_rt_sigreturn(unsigned long r3, unsigned long r4, unsigned long r5,
 	else
 	/* Fall through, for non-TM restore */
 #endif
+	clear_thread_flag(TIF_RESTORE_TM);
+
 	if (restore_sigcontext(current, NULL, 1, &uc->uc_mcontext))
 		goto badframe;
 
-- 
2.16.2
