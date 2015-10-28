Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 113291A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2015 11:51:22 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 06/19] powerpc: Simplify TM restore checks
Date: Wed, 28 Oct 2015 11:50:54 +1100
Message-Id: <1445993467-667-6-git-send-email-anton@samba.org>
In-Reply-To: <1445993467-667-1-git-send-email-anton@samba.org>
References: <1445993467-667-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Instead of having multiple giveup_*_maybe_transactional() functions,
separate out the TM check into a new function called
check_if_tm_restore_required().

This will make it easier to optimise the giveup_*() functions in a
subsequent patch.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/process.c | 53 ++++++++++++++++---------------------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e098f43..ef64219 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -68,7 +68,7 @@
 extern unsigned long _get_SP(void);
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-void giveup_fpu_maybe_transactional(struct task_struct *tsk)
+static void check_if_tm_restore_required(struct task_struct *tsk)
 {
 	/*
 	 * If we are saving the current thread's registers, and the
@@ -82,31 +82,9 @@ void giveup_fpu_maybe_transactional(struct task_struct *tsk)
 		tsk->thread.ckpt_regs.msr = tsk->thread.regs->msr;
 		set_thread_flag(TIF_RESTORE_TM);
 	}
-
-	giveup_fpu(tsk);
-}
-
-void giveup_altivec_maybe_transactional(struct task_struct *tsk)
-{
-	/*
-	 * If we are saving the current thread's registers, and the
-	 * thread is in a transactional state, set the TIF_RESTORE_TM
-	 * bit so that we know to restore the registers before
-	 * returning to userspace.
-	 */
-	if (tsk == current && tsk->thread.regs &&
-	    MSR_TM_ACTIVE(tsk->thread.regs->msr) &&
-	    !test_thread_flag(TIF_RESTORE_TM)) {
-		tsk->thread.ckpt_regs.msr = tsk->thread.regs->msr;
-		set_thread_flag(TIF_RESTORE_TM);
-	}
-
-	giveup_altivec(tsk);
 }
-
 #else
-#define giveup_fpu_maybe_transactional(tsk)	giveup_fpu(tsk)
-#define giveup_altivec_maybe_transactional(tsk)	giveup_altivec(tsk)
+static inline void check_if_tm_restore_required(struct task_struct *tsk) { }
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 #ifdef CONFIG_PPC_FPU
@@ -135,7 +113,8 @@ void flush_fp_to_thread(struct task_struct *tsk)
 			 * to still have its FP state in the CPU registers.
 			 */
 			BUG_ON(tsk != current);
-			giveup_fpu_maybe_transactional(tsk);
+			check_if_tm_restore_required(tsk);
+			giveup_fpu(tsk);
 		}
 		preempt_enable();
 	}
@@ -147,10 +126,12 @@ void enable_kernel_fp(void)
 {
 	WARN_ON(preemptible());
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_FP))
-		giveup_fpu_maybe_transactional(current);
-	else
+	if (current->thread.regs && (current->thread.regs->msr & MSR_FP)) {
+		check_if_tm_restore_required(current);
+		giveup_fpu(current);
+	} else {
 		giveup_fpu(NULL);	/* just enables FP for kernel */
+	}
 }
 EXPORT_SYMBOL(enable_kernel_fp);
 
@@ -159,10 +140,12 @@ void enable_kernel_altivec(void)
 {
 	WARN_ON(preemptible());
 
-	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC))
-		giveup_altivec_maybe_transactional(current);
-	else
+	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC)) {
+		check_if_tm_restore_required(current);
+		giveup_altivec(current);
+	} else {
 		giveup_altivec_notask();
+	}
 }
 EXPORT_SYMBOL(enable_kernel_altivec);
 
@@ -176,7 +159,8 @@ void flush_altivec_to_thread(struct task_struct *tsk)
 		preempt_disable();
 		if (tsk->thread.regs->msr & MSR_VEC) {
 			BUG_ON(tsk != current);
-			giveup_altivec_maybe_transactional(tsk);
+			check_if_tm_restore_required(tsk);
+			giveup_altivec(tsk);
 		}
 		preempt_enable();
 	}
@@ -198,8 +182,9 @@ EXPORT_SYMBOL(enable_kernel_vsx);
 
 void giveup_vsx(struct task_struct *tsk)
 {
-	giveup_fpu_maybe_transactional(tsk);
-	giveup_altivec_maybe_transactional(tsk);
+	check_if_tm_restore_required(tsk);
+	giveup_fpu(tsk);
+	giveup_altivec(tsk);
 	__giveup_vsx(tsk);
 }
 EXPORT_SYMBOL(giveup_vsx);
-- 
2.5.0
