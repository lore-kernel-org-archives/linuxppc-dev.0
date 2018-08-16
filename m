Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41rtR04kLPzDqp5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Aug 2018 03:21:16 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7GHJCrq098082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2018 13:21:13 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kwcvessyh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2018 13:21:13 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Thu, 16 Aug 2018 11:21:12 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, Breno Leitao <leitao@debian.org>
Subject: [PATCH v3] powerpc/tm: Remove msr_tm_active()
Date: Thu, 16 Aug 2018 14:21:07 -0300
In-Reply-To: <e2f169e3ce57e5b092642088127f67a52da2bf93.camel@neuling.org>
References: <e2f169e3ce57e5b092642088127f67a52da2bf93.camel@neuling.org>
Message-Id: <1534440067-5146-1-git-send-email-leitao@debian.org>
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

This function is not necessary, since MSR_TM_ACTIVE() just do the same and
could be used, removing the dualism and simplifying the code.

This patchset remove every instance of msr_tm_active() and replaced it
by MSR_TM_ACTIVE().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/include/asm/reg.h |  7 ++++++-
 arch/powerpc/kernel/process.c  | 21 +++++++++------------
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 562568414cf4..58393bc6c964 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -116,11 +116,16 @@
 #define MSR_TS_S	__MASK(MSR_TS_S_LG)	/*  Transaction Suspended */
 #define MSR_TS_T	__MASK(MSR_TS_T_LG)	/*  Transaction Transactional */
 #define MSR_TS_MASK	(MSR_TS_T | MSR_TS_S)   /* Transaction State bits */
-#define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
 #define MSR_TM_RESV(x) (((x) & MSR_TS_MASK) == MSR_TS_MASK) /* Reserved */
 #define MSR_TM_TRANSACTIONAL(x)	(((x) & MSR_TS_MASK) == MSR_TS_T)
 #define MSR_TM_SUSPENDED(x)	(((x) & MSR_TS_MASK) == MSR_TS_S)
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+#define MSR_TM_ACTIVE(x) (((x) & MSR_TS_MASK) != 0) /* Transaction active? */
+#else
+#define MSR_TM_ACTIVE(x) 0
+#endif
+
 #if defined(CONFIG_PPC_BOOK3S_64)
 #define MSR_64BIT	MSR_SF
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 9ef4aea9fffe..f18dba07ea16 100644
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
@@ -247,7 +241,8 @@ void enable_kernel_fp(void)
 		 * giveup as this would save  to the 'live' structure not the
 		 * checkpointed structure.
 		 */
-		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+		if (!MSR_TM_ACTIVE(cpumsr) &&
+		     MSR_TM_ACTIVE(current->thread.regs->msr))
 			return;
 		__giveup_fpu(current);
 	}
@@ -311,7 +306,8 @@ void enable_kernel_altivec(void)
 		 * giveup as this would save  to the 'live' structure not the
 		 * checkpointed structure.
 		 */
-		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+		if (!MSR_TM_ACTIVE(cpumsr) &&
+		     MSR_TM_ACTIVE(current->thread.regs->msr))
 			return;
 		__giveup_altivec(current);
 	}
@@ -397,7 +393,8 @@ void enable_kernel_vsx(void)
 		 * giveup as this would save  to the 'live' structure not the
 		 * checkpointed structure.
 		 */
-		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+		if (!MSR_TM_ACTIVE(cpumsr) &&
+		     MSR_TM_ACTIVE(current->thread.regs->msr))
 			return;
 		__giveup_vsx(current);
 	}
@@ -530,7 +527,7 @@ void restore_math(struct pt_regs *regs)
 {
 	unsigned long msr;
 
-	if (!msr_tm_active(regs->msr) &&
+	if (!MSR_TM_ACTIVE(regs->msr) &&
 		!current->thread.load_fp && !loadvec(current->thread))
 		return;
 
-- 
2.16.3
