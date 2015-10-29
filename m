Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4501E1A0CCC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 12:06:27 +1100 (AEDT)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyrilbur@gmail.com, scottwood@freescale.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 18/19] powerpc: Rearrange __switch_to()
Date: Thu, 29 Oct 2015 11:44:10 +1100
Message-Id: <1446079451-8774-19-git-send-email-anton@samba.org>
In-Reply-To: <1446079451-8774-1-git-send-email-anton@samba.org>
References: <1446079451-8774-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Most of __switch_to() is housekeeping, TLB batching, timekeeping etc.
Move these away from the more complex and critical context switching
code.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/process.c | 52 +++++++++++++++++++++----------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e66d625..b34e1e5 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -906,30 +906,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	WARN_ON(!irqs_disabled());
 
-	/*
-	 * We need to save SPRs before treclaim/trecheckpoint as these will
-	 * change a number of them.
-	 */
-	save_sprs(&prev->thread);
-
-	__switch_to_tm(prev);
-
-	/* Save FPU, Altivec, VSX and SPE state */
-	giveup_all(prev);
-
-#ifdef CONFIG_PPC_ADV_DEBUG_REGS
-	switch_booke_debug_regs(&new->thread.debug);
-#else
-/*
- * For PPC_BOOK3S_64, we use the hw-breakpoint interfaces that would
- * schedule DABR
- */
-#ifndef CONFIG_HAVE_HW_BREAKPOINT
-	if (unlikely(!hw_brk_match(this_cpu_ptr(&current_brk), &new->thread.hw_brk)))
-		__set_breakpoint(&new->thread.hw_brk);
-#endif /* CONFIG_HAVE_HW_BREAKPOINT */
-#endif
-
 #ifdef CONFIG_PPC64
 	/*
 	 * Collect processor utilization data per process
@@ -954,6 +930,30 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
+#ifdef CONFIG_PPC_ADV_DEBUG_REGS
+	switch_booke_debug_regs(&new->thread.debug);
+#else
+/*
+ * For PPC_BOOK3S_64, we use the hw-breakpoint interfaces that would
+ * schedule DABR
+ */
+#ifndef CONFIG_HAVE_HW_BREAKPOINT
+	if (unlikely(!hw_brk_match(this_cpu_ptr(&current_brk), &new->thread.hw_brk)))
+		__set_breakpoint(&new->thread.hw_brk);
+#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+#endif
+
+	/*
+	 * We need to save SPRs before treclaim/trecheckpoint as these will
+	 * change a number of them.
+	 */
+	save_sprs(&prev->thread);
+
+	__switch_to_tm(prev);
+
+	/* Save FPU, Altivec, VSX and SPE state */
+	giveup_all(prev);
+
 	/*
 	 * We can't take a PMU exception inside _switch() since there is a
 	 * window where the kernel stack SLB and the kernel stack are out
@@ -969,6 +969,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	old_thread = &last->thread;
 	new_thread = &current->thread;
 
+	restore_sprs(old_thread, new_thread);
+
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (current_thread_info()->local_flags & _TLF_LAZY_MMU) {
 		current_thread_info()->local_flags &= ~_TLF_LAZY_MMU;
@@ -977,8 +979,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
-	restore_sprs(old_thread, new_thread);
-
 	return last;
 }
 
-- 
2.5.0
