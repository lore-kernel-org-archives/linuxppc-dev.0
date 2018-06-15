Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416nl82HllzF0tS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2018 03:38:11 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5FHXkt5084891
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 13:38:09 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jmf4vy270-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 13:38:09 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Fri, 15 Jun 2018 11:38:08 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Breno Leitao <leitao@debian.org>
Subject: [PATCH 1/3] powerpc/tm: Remove msr_tm_active()
Date: Fri, 15 Jun 2018 14:37:40 -0300
Message-Id: <1529084262-16372-1-git-send-email-leitao@debian.org>
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
by MSR_TM_ACTIVE();

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/kernel/process.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9ef4aea9fffe..6b73d74793c2 100644
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
@@ -247,7 +241,7 @@ void enable_kernel_fp(void)
 		 * giveup as this would save  to the 'live' structure not the
 		 * checkpointed structure.
 		 */
-		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+		if(!MSR_TM_ACTIVE(cpumsr) && MSR_TM_ACTIVE(current->thread.regs->msr))
 			return;
 		__giveup_fpu(current);
 	}
@@ -311,7 +305,7 @@ void enable_kernel_altivec(void)
 		 * giveup as this would save  to the 'live' structure not the
 		 * checkpointed structure.
 		 */
-		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+		if(!MSR_TM_ACTIVE(cpumsr) && MSR_TM_ACTIVE(current->thread.regs->msr))
 			return;
 		__giveup_altivec(current);
 	}
@@ -397,7 +391,7 @@ void enable_kernel_vsx(void)
 		 * giveup as this would save  to the 'live' structure not the
 		 * checkpointed structure.
 		 */
-		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+		if(!MSR_TM_ACTIVE(cpumsr) && MSR_TM_ACTIVE(current->thread.regs->msr))
 			return;
 		__giveup_vsx(current);
 	}
@@ -530,7 +524,7 @@ void restore_math(struct pt_regs *regs)
 {
 	unsigned long msr;
 
-	if (!msr_tm_active(regs->msr) &&
+	if (!MSR_TM_ACTIVE(regs->msr) &&
 		!current->thread.load_fp && !loadvec(current->thread))
 		return;
 
-- 
2.16.3
