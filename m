Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xG7fl5khXzDrJm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jul 2017 14:28:47 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/6] powerpc/mm: Move pgdir setting into a helper
Date: Mon, 24 Jul 2017 14:27:58 +1000
Message-Id: <20170724042803.25848-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Makes switch_mm_irqs_off() a bit more readable

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/mmu_context.h | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 94d93f256b94..603b0e5cdec0 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -77,6 +77,26 @@ extern void switch_cop(struct mm_struct *next);
 extern int use_cop(unsigned long acop, struct mm_struct *mm);
 extern void drop_cop(unsigned long acop, struct mm_struct *mm);
 
+#if defined(CONFIG_PPC32)
+static inline void switch_mm_pgdir(struct task_struct *tsk,
+				   struct mm_struct *mm)
+{
+	/* 32-bit keeps track of the current PGDIR in the thread struct */
+	tsk->thread.pgdir = mm->pgd;
+}
+#elif defined(CONFIG_PPC_BOOK3E_64)
+static inline void switch_mm_pgdir(struct task_struct *tsk,
+				   struct mm_struct *mm)
+{
+	/* 64-bit Book3E keeps track of current PGD in the PACA */
+	get_paca()->pgd = mm->pgd;
+}
+#else
+static inline void switch_mm_pgdir(struct task_struct *tsk,
+				   struct mm_struct *mm) { }
+#endif
+
+
 /*
  * switch_mm is the entry point called from the architecture independent
  * code in kernel/sched/core.c
@@ -93,15 +113,9 @@ static inline void switch_mm_irqs_off(struct mm_struct *prev,
 		new_on_cpu = true;
 	}
 
-	/* 32-bit keeps track of the current PGDIR in the thread struct */
-#ifdef CONFIG_PPC32
-	tsk->thread.pgdir = next->pgd;
-#endif /* CONFIG_PPC32 */
+	/* Some subarchs need to track the PGD elsewhere */
+	switch_mm_pgdir(tsk, next);
 
-	/* 64-bit Book3E keeps track of current PGD in the PACA */
-#ifdef CONFIG_PPC_BOOK3E_64
-	get_paca()->pgd = next->pgd;
-#endif
 	/* Nothing else to do if we aren't actually switching */
 	if (prev == next)
 		return;
-- 
2.13.3
