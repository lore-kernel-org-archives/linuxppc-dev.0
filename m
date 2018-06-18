Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418ml12n0jzF0WP
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 08:59:56 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5IMxYYH125904
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 18:59:54 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jpfx95cb6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 18:59:54 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Mon, 18 Jun 2018 18:59:53 -0400
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH v2 1/4] powerpc/tm: Remove msr_tm_active()
Date: Mon, 18 Jun 2018 19:59:41 -0300
In-Reply-To: <201806160346.lDndh49W%fengguang.wu@intel.com>
References: <201806160346.lDndh49W%fengguang.wu@intel.com>
Message-Id: <1529362784-14194-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently msr_tm_active() is a wrapper around MSR_TM_ACTIVE() if
CONFIG_PPC_TRANSACTIONAL_MEM is set, or it is just a function that
returns false if CONFIG_PPC_TRANSACTIONAL_MEM is not set.

This function is not necessary, since MSR_TM_ACTIVE() just do the same,
checking for the TS bits and does not require any TM facility.

This patchset remove every instance of msr_tm_active() and replaced it
by MSR_TM_ACTIVE().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d26a150766ef..661e4ed5f628 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -102,24 +102,18 @@ static void check_if_tm_restore_required(struct task_struct *tsk)
 	}
 }
 
-static inline bool msr_tm_active(unsigned long msr)
-{
-	return MSR_TM_ACTIVE(msr);
-}
-
 static bool tm_active_with_fp(struct task_struct *tsk)
 {
-	return msr_tm_active(tsk->thread.regs->msr) &&
+	return MSR_TM_ACTIVE(tsk->thread.regs->msr) &&
 		(tsk->thread.ckpt_regs.msr & MSR_FP);
 }
 
 static bool tm_active_with_altivec(struct task_struct *tsk)
 {
-	return msr_tm_active(tsk->thread.regs->msr) &&
+	return MSR_TM_ACTIVE(tsk->thread.regs->msr) &&
 		(tsk->thread.ckpt_regs.msr & MSR_VEC);
 }
 #else
-static inline bool msr_tm_active(unsigned long msr) { return false; }
 static inline void check_if_tm_restore_required(struct task_struct *tsk) { }
 static inline bool tm_active_with_fp(struct task_struct *tsk) { return false; }
 static inline bool tm_active_with_altivec(struct task_struct *tsk) { return false; }
@@ -239,6 +233,7 @@ void enable_kernel_fp(void)
 	cpumsr = msr_check_and_set(MSR_FP);
 
 	if (current->thread.regs && (current->thread.regs->msr & MSR_FP)) {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 		check_if_tm_restore_required(current);
 		/*
 		 * If a thread has already been reclaimed then the
@@ -247,8 +242,10 @@ void enable_kernel_fp(void)
 		 * giveup as this would save  to the 'live' structure not the
 		 * checkpointed structure.
 		 */
-		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+		if (!MSR_TM_ACTIVE(cpumsr) &&
+		     MSR_TM_ACTIVE(current->thread.regs->msr))
 			return;
+#endif
 		__giveup_fpu(current);
 	}
 }
@@ -303,6 +300,7 @@ void enable_kernel_altivec(void)
 	cpumsr = msr_check_and_set(MSR_VEC);
 
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC)) {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 		check_if_tm_restore_required(current);
 		/*
 		 * If a thread has already been reclaimed then the
@@ -311,8 +309,10 @@ void enable_kernel_altivec(void)
 		 * giveup as this would save  to the 'live' structure not the
 		 * checkpointed structure.
 		 */
-		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+		if (!MSR_TM_ACTIVE(cpumsr) &&
+		     MSR_TM_ACTIVE(current->thread.regs->msr))
 			return;
+#endif
 		__giveup_altivec(current);
 	}
 }
@@ -389,6 +389,7 @@ void enable_kernel_vsx(void)
 
 	if (current->thread.regs &&
 	    (current->thread.regs->msr & (MSR_VSX|MSR_VEC|MSR_FP))) {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 		check_if_tm_restore_required(current);
 		/*
 		 * If a thread has already been reclaimed then the
@@ -397,8 +398,10 @@ void enable_kernel_vsx(void)
 		 * giveup as this would save  to the 'live' structure not the
 		 * checkpointed structure.
 		 */
-		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+		if (!MSR_TM_ACTIVE(cpumsr) &&
+		     MSR_TM_ACTIVE(current->thread.regs->msr))
 			return;
+#endif
 		__giveup_vsx(current);
 	}
 }
@@ -530,9 +533,14 @@ void restore_math(struct pt_regs *regs)
 {
 	unsigned long msr;
 
-	if (!msr_tm_active(regs->msr) &&
-		!current->thread.load_fp && !loadvec(current->thread))
+	if (!current->thread.load_fp && !loadvec(current->thread)) {
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+		if (!MSR_TM_ACTIVE(regs->msr))
+			return;
+#else
 		return;
+#endif
+	}
 
 	msr = regs->msr;
 	msr_check_and_set(msr_all_available);
-- 
2.16.3
