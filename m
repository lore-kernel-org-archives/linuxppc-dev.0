Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXJfT5kRDzDrCl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 16:02:41 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] powerpc: Remove more redundant VSX save/tests
Date: Wed, 16 Aug 2017 16:01:18 +1000
Message-Id: <20170816060118.24803-5-benh@kernel.crashing.org>
In-Reply-To: <20170816060118.24803-1-benh@kernel.crashing.org>
References: <20170816060118.24803-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

__giveup_vsx/save_vsx are completely equivalent to testing MSR_FP
and MSR_VEC and calling the corresponding giveup/save function so
just remove the spurious VSX cases. Also add WARN_ONs checking that
we never have VSX enabled without the two other.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/process.c | 33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index fc285fab7118..7093b46b3603 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -355,14 +355,6 @@ static void giveup_vsx(struct task_struct *tsk)
 	msr_check_and_clear(MSR_FP|MSR_VEC|MSR_VSX);
 }
 
-static void save_vsx(struct task_struct *tsk)
-{
-	if (tsk->thread.regs->msr & MSR_FP)
-		save_fpu(tsk);
-	if (tsk->thread.regs->msr & MSR_VEC)
-		save_altivec(tsk);
-}
-
 void enable_kernel_vsx(void)
 {
 	unsigned long cpumsr;
@@ -412,7 +404,6 @@ static int restore_vsx(struct task_struct *tsk)
 }
 #else
 static inline int restore_vsx(struct task_struct *tsk) { return 0; }
-static inline void save_vsx(struct task_struct *tsk) { }
 #endif /* CONFIG_VSX */
 
 #ifdef CONFIG_SPE
@@ -492,6 +483,8 @@ void giveup_all(struct task_struct *tsk)
 	msr_check_and_set(msr_all_available);
 	check_if_tm_restore_required(tsk);
 
+	WARN_ON((usermsr & MSR_VSX) && !((usermsr & MSR_FP) && (usermsr & MSR_VEC)));
+
 #ifdef CONFIG_PPC_FPU
 	if (usermsr & MSR_FP)
 		__giveup_fpu(tsk);
@@ -500,10 +493,6 @@ void giveup_all(struct task_struct *tsk)
 	if (usermsr & MSR_VEC)
 		__giveup_altivec(tsk);
 #endif
-#ifdef CONFIG_VSX
-	if (usermsr & MSR_VSX)
-		__giveup_vsx(tsk);
-#endif
 #ifdef CONFIG_SPE
 	if (usermsr & MSR_SPE)
 		__giveup_spe(tsk);
@@ -562,19 +551,13 @@ void save_all(struct task_struct *tsk)
 
 	msr_check_and_set(msr_all_available);
 
-	/*
-	 * Saving the way the register space is in hardware, save_vsx boils
-	 * down to a save_fpu() and save_altivec()
-	 */
-	if (usermsr & MSR_VSX) {
-		save_vsx(tsk);
-	} else {
-		if (usermsr & MSR_FP)
-			save_fpu(tsk);
+	WARN_ON((usermsr & MSR_VSX) && !((usermsr & MSR_FP) && (usermsr & MSR_VEC)));
 
-		if (usermsr & MSR_VEC)
-			save_altivec(tsk);
-	}
+	if (usermsr & MSR_FP)
+		save_fpu(tsk);
+
+	if (usermsr & MSR_VEC)
+		save_altivec(tsk);
 
 	if (usermsr & MSR_SPE)
 		__giveup_spe(tsk);
-- 
2.13.4
