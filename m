Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 09E2DDE136
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 03:46:10 +1100 (EST)
Message-ID: <47F509CC.9010205@mvista.com>
Date: Thu, 03 Apr 2008 09:46:04 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH v2] E500 Make steal_context SMP-safe.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When steal_context is used on SMP systems, it can steal a context in
use by one of the other processors. This patch adds context tracking to
prevent this as suggested by BenH.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
The previous version of this patch had some unnecessary code which has been
removed in this version. 

Note: This is a proof-of-concept patch. This isn't my area of expertise,
so I'd greatly appreciate any guidance I can get. I'm considering the
use of for_each_online_cpu() instead of for_each_possible_cpu() and
possibly putting the changes under a CONFIG_SMP switch to prevent unnecessary
overhead in the non-SMP case.

 arch/powerpc/mm/mmu_context_32.c  |   29 ++++++++++++++++++++++++-----
 include/asm-powerpc/mmu_context.h |    5 +++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/mmu_context_32.c b/arch/powerpc/mm/mmu_context_32.c
index cc32ba4..0dc7b83 100644
--- a/arch/powerpc/mm/mmu_context_32.c
+++ b/arch/powerpc/mm/mmu_context_32.c
@@ -34,6 +34,8 @@ unsigned long context_map[LAST_CONTEXT / BITS_PER_LONG + 1];
 atomic_t nr_free_contexts;
 struct mm_struct *context_mm[LAST_CONTEXT+1];
 void steal_context(void);
+DEFINE_SPINLOCK(mm_lock);
+DEFINE_PER_CPU(struct mm_struct *, curr_mm);
 #endif /* FEW_CONTEXTS */
 
 /*
@@ -42,6 +44,9 @@ void steal_context(void);
 void __init
 mmu_context_init(void)
 {
+#ifdef FEW_CONTEXTS
+	int cpu;
+#endif
 	/*
 	 * Some processors have too few contexts to reserve one for
 	 * init_mm, and require using context 0 for a normal task.
@@ -52,6 +57,8 @@ mmu_context_init(void)
 	next_mmu_context = FIRST_CONTEXT;
 #ifdef FEW_CONTEXTS
 	atomic_set(&nr_free_contexts, LAST_CONTEXT - FIRST_CONTEXT + 1);
+	for_each_possible_cpu(cpu)
+		per_cpu(curr_mm, cpu) = NULL;
 #endif /* FEW_CONTEXTS */
 }
 
@@ -72,12 +79,24 @@ void
 steal_context(void)
 {
 	struct mm_struct *mm;
+	int cpu;
+
+	do {
+		/* free up context `next_mmu_context' */
+		/* if we shouldn't free context 0, don't... */
+		if (next_mmu_context < FIRST_CONTEXT)
+			next_mmu_context = FIRST_CONTEXT;
+		mm = context_mm[next_mmu_context];
+		for_each_possible_cpu(cpu) {
+			if ((cpu != smp_processor_id()) &&
+					per_cpu(curr_mm, cpu) == mm) {
+				mm = NULL;
+				next_mmu_context = (next_mmu_context + 1) &
+					LAST_CONTEXT;
+			}
+		}
+	} while(!mm);
 
-	/* free up context `next_mmu_context' */
-	/* if we shouldn't free context 0, don't... */
-	if (next_mmu_context < FIRST_CONTEXT)
-		next_mmu_context = FIRST_CONTEXT;
-	mm = context_mm[next_mmu_context];
 	flush_tlb_mm(mm);
 	destroy_context(mm);
 }
diff --git a/include/asm-powerpc/mmu_context.h b/include/asm-powerpc/mmu_context.h
index 9102b8b..e083b25 100644
--- a/include/asm-powerpc/mmu_context.h
+++ b/include/asm-powerpc/mmu_context.h
@@ -113,6 +113,8 @@ extern unsigned long next_mmu_context;
 extern atomic_t nr_free_contexts;
 extern struct mm_struct *context_mm[LAST_CONTEXT+1];
 extern void steal_context(void);
+extern spinlock_t mm_lock;
+DECLARE_PER_CPU(struct mm_struct *, curr_mm);
 #endif
 
 /*
@@ -125,6 +127,7 @@ static inline void get_mmu_context(struct mm_struct *mm)
 	if (mm->context.id != NO_CONTEXT)
 		return;
 #ifdef FEW_CONTEXTS
+	spin_lock(&mm_lock);
 	while (atomic_dec_if_positive(&nr_free_contexts) < 0)
 		steal_context();
 #endif
@@ -138,6 +141,8 @@ static inline void get_mmu_context(struct mm_struct *mm)
 	mm->context.id = ctx;
 #ifdef FEW_CONTEXTS
 	context_mm[ctx] = mm;
+	per_cpu(curr_mm, smp_processor_id()) = mm;
+	spin_unlock(&mm_lock);
 #endif
 }
 
-- 
1.5.4.4.551.g1658c
