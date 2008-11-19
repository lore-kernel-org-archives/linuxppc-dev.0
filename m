Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 868ACDDDED
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 09:22:12 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mAJMM8xP021362
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Nov 2008 16:22:09 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Use RCU based pte free mechanism for all powerpc
Date: Wed, 19 Nov 2008 16:22:08 -0600
Message-Id: <1227133328-21422-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Refactor the RCU based pte free code that was used on ppc64 to be used
on all powerpc.

Additionally refactor pte_free() & pte_free_kernel() into common code
between ppc32 & ppc64.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/pgalloc-32.h |   11 ++-
 arch/powerpc/include/asm/pgalloc-64.h |   34 ----------
 arch/powerpc/include/asm/pgalloc.h    |   46 +++++++++++++
 arch/powerpc/mm/Makefile              |    2 +-
 arch/powerpc/mm/pgtable.c             |  117 +++++++++++++++++++++++++++++++++
 arch/powerpc/mm/pgtable_32.c          |   21 ------
 arch/powerpc/mm/tlb_64.c              |   86 ------------------------
 7 files changed, 172 insertions(+), 145 deletions(-)
 create mode 100644 arch/powerpc/mm/pgtable.c

diff --git a/arch/powerpc/include/asm/pgalloc-32.h b/arch/powerpc/include/asm/pgalloc-32.h
index 58c0714..0815eb4 100644
--- a/arch/powerpc/include/asm/pgalloc-32.h
+++ b/arch/powerpc/include/asm/pgalloc-32.h
@@ -3,6 +3,8 @@
 
 #include <linux/threads.h>
 
+#define PTE_NONCACHE_NUM	0  /* dummy for now to share code w/ppc64 */
+
 extern void __bad_pte(pmd_t *pmd);
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
@@ -33,10 +35,13 @@ extern void pgd_free(struct mm_struct *mm, pgd_t *pgd);
 
 extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
 extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
-extern void pte_free_kernel(struct mm_struct *mm, pte_t *pte);
-extern void pte_free(struct mm_struct *mm, pgtable_t pte);
 
-#define __pte_free_tlb(tlb, pte)	pte_free((tlb)->mm, (pte))
+static inline void pgtable_free(pgtable_free_t pgf)
+{
+	void *p = (void *)(pgf.val & ~PGF_CACHENUM_MASK);
+
+	free_page((unsigned long)p);
+}
 
 #define check_pgt_cache()	do { } while (0)
 
diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index 812a1d8..afda2bd 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -7,7 +7,6 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
@@ -108,31 +107,6 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm,
 	return page;
 }
 
-static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-	free_page((unsigned long)pte);
-}
-
-static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-{
-	pgtable_page_dtor(ptepage);
-	__free_page(ptepage);
-}
-
-#define PGF_CACHENUM_MASK	0x7
-
-typedef struct pgtable_free {
-	unsigned long val;
-} pgtable_free_t;
-
-static inline pgtable_free_t pgtable_free_cache(void *p, int cachenum,
-						unsigned long mask)
-{
-	BUG_ON(cachenum > PGF_CACHENUM_MASK);
-
-	return (pgtable_free_t){.val = ((unsigned long) p & ~mask) | cachenum};
-}
-
 static inline void pgtable_free(pgtable_free_t pgf)
 {
 	void *p = (void *)(pgf.val & ~PGF_CACHENUM_MASK);
@@ -144,14 +118,6 @@ static inline void pgtable_free(pgtable_free_t pgf)
 		kmem_cache_free(pgtable_cache[cachenum], p);
 }
 
-extern void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf);
-
-#define __pte_free_tlb(tlb,ptepage)	\
-do { \
-	pgtable_page_dtor(ptepage); \
-	pgtable_free_tlb(tlb, pgtable_free_cache(page_address(ptepage), \
-		PTE_NONCACHE_NUM, PTE_TABLE_SIZE-1)); \
-} while (0)
 #define __pmd_free_tlb(tlb, pmd) 	\
 	pgtable_free_tlb(tlb, pgtable_free_cache(pmd, \
 		PMD_CACHE_NUM, PMD_TABLE_SIZE-1))
diff --git a/arch/powerpc/include/asm/pgalloc.h b/arch/powerpc/include/asm/pgalloc.h
index b4505ed..538b606 100644
--- a/arch/powerpc/include/asm/pgalloc.h
+++ b/arch/powerpc/include/asm/pgalloc.h
@@ -2,11 +2,57 @@
 #define _ASM_POWERPC_PGALLOC_H
 #ifdef __KERNEL__
 
+#include <linux/mm.h>
+
+#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_32)
+extern void hash_page_sync(void);
+#endif
+
+static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_32)
+	hash_page_sync();
+#endif
+	free_page((unsigned long)pte);
+}
+
+static inline void pte_free(struct mm_struct *mm, pgtable_t ptepage)
+{
+#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_32)
+	hash_page_sync();
+#endif
+	pgtable_page_dtor(ptepage);
+	__free_page(ptepage);
+}
+
+typedef struct pgtable_free {
+	unsigned long val;
+} pgtable_free_t;
+
+#define PGF_CACHENUM_MASK	0x7
+
+static inline pgtable_free_t pgtable_free_cache(void *p, int cachenum,
+						unsigned long mask)
+{
+	BUG_ON(cachenum > PGF_CACHENUM_MASK);
+
+	return (pgtable_free_t){.val = ((unsigned long) p & ~mask) | cachenum};
+}
+
 #ifdef CONFIG_PPC64
 #include <asm/pgalloc-64.h>
 #else
 #include <asm/pgalloc-32.h>
 #endif
 
+extern void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf);
+
+#define __pte_free_tlb(tlb,ptepage)	\
+do { \
+	pgtable_page_dtor(ptepage); \
+	pgtable_free_tlb(tlb, pgtable_free_cache(page_address(ptepage), \
+		PTE_NONCACHE_NUM, PTE_TABLE_SIZE-1)); \
+} while (0)
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_PGALLOC_H */
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index e7392b4..86e657b 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -6,7 +6,7 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS	+= -mno-minimal-toc
 endif
 
-obj-y				:= fault.o mem.o \
+obj-y				:= fault.o mem.o pgtable.o \
 				   init_$(CONFIG_WORD_SIZE).o \
 				   pgtable_$(CONFIG_WORD_SIZE).o \
 				   mmu_context_$(CONFIG_WORD_SIZE).o
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
new file mode 100644
index 0000000..6d94116
--- /dev/null
+++ b/arch/powerpc/mm/pgtable.c
@@ -0,0 +1,117 @@
+/*
+ * This file contains common routines for dealing with free of page tables
+ *
+ *  Derived from arch/powerpc/mm/tlb_64.c:
+ *    Copyright (C) 1995-1996 Gary Thomas (gdt@linuxppc.org)
+ *
+ *  Modifications by Paul Mackerras (PowerMac) (paulus@cs.anu.edu.au)
+ *  and Cort Dougan (PReP) (cort@cs.nmt.edu)
+ *    Copyright (C) 1996 Paul Mackerras
+ *
+ *  Derived from "arch/i386/mm/init.c"
+ *    Copyright (C) 1991, 1992, 1993, 1994  Linus Torvalds
+ *
+ *  Dave Engebretsen <engebret@us.ibm.com>
+ *      Rework for PPC64 port.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+#include <linux/percpu.h>
+#include <linux/hardirq.h>
+#include <asm/pgalloc.h>
+#include <asm/tlbflush.h>
+#include <asm/tlb.h>
+
+static DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
+static unsigned long pte_freelist_forced_free;
+
+struct pte_freelist_batch
+{
+	struct rcu_head	rcu;
+	unsigned int	index;
+	pgtable_free_t	tables[0];
+};
+
+#define PTE_FREELIST_SIZE \
+	((PAGE_SIZE - sizeof(struct pte_freelist_batch)) \
+	  / sizeof(pgtable_free_t))
+
+static void pte_free_smp_sync(void *arg)
+{
+	/* Do nothing, just ensure we sync with all CPUs */
+}
+
+/* This is only called when we are critically out of memory
+ * (and fail to get a page in pte_free_tlb).
+ */
+static void pgtable_free_now(pgtable_free_t pgf)
+{
+	pte_freelist_forced_free++;
+
+	smp_call_function(pte_free_smp_sync, NULL, 1);
+
+	pgtable_free(pgf);
+}
+
+static void pte_free_rcu_callback(struct rcu_head *head)
+{
+	struct pte_freelist_batch *batch =
+		container_of(head, struct pte_freelist_batch, rcu);
+	unsigned int i;
+
+	for (i = 0; i < batch->index; i++)
+		pgtable_free(batch->tables[i]);
+
+	free_page((unsigned long)batch);
+}
+
+static void pte_free_submit(struct pte_freelist_batch *batch)
+{
+	INIT_RCU_HEAD(&batch->rcu);
+	call_rcu(&batch->rcu, pte_free_rcu_callback);
+}
+
+void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf)
+{
+	/* This is safe since tlb_gather_mmu has disabled preemption */
+        cpumask_t local_cpumask = cpumask_of_cpu(smp_processor_id());
+	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
+
+	if (atomic_read(&tlb->mm->mm_users) < 2 ||
+	    cpus_equal(tlb->mm->cpu_vm_mask, local_cpumask)) {
+		pgtable_free(pgf);
+		return;
+	}
+
+	if (*batchp == NULL) {
+		*batchp = (struct pte_freelist_batch *)__get_free_page(GFP_ATOMIC);
+		if (*batchp == NULL) {
+			pgtable_free_now(pgf);
+			return;
+		}
+		(*batchp)->index = 0;
+	}
+	(*batchp)->tables[(*batchp)->index++] = pgf;
+	if ((*batchp)->index == PTE_FREELIST_SIZE) {
+		pte_free_submit(*batchp);
+		*batchp = NULL;
+	}
+}
+
+void pte_free_finish(void)
+{
+	/* This is safe since tlb_gather_mmu has disabled preemption */
+	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
+
+	if (*batchp == NULL)
+		return;
+	pte_free_submit(*batchp);
+	*batchp = NULL;
+}
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 44fbc81..c7b755c 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -48,10 +48,6 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
 extern char etext[], _stext[];
 
-#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_32)
-extern void hash_page_sync(void);
-#endif
-
 #ifdef HAVE_BATS
 extern phys_addr_t v_mapped_by_bats(unsigned long va);
 extern unsigned long p_mapped_by_bats(phys_addr_t pa);
@@ -125,23 +121,6 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 	return ptepage;
 }
 
-void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_32)
-	hash_page_sync();
-#endif
-	free_page((unsigned long)pte);
-}
-
-void pte_free(struct mm_struct *mm, pgtable_t ptepage)
-{
-#if defined(CONFIG_SMP) && defined(CONFIG_PPC_STD_MMU_32)
-	hash_page_sync();
-#endif
-	pgtable_page_dtor(ptepage);
-	__free_page(ptepage);
-}
-
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
diff --git a/arch/powerpc/mm/tlb_64.c b/arch/powerpc/mm/tlb_64.c
index be7dd42..c931bc7 100644
--- a/arch/powerpc/mm/tlb_64.c
+++ b/arch/powerpc/mm/tlb_64.c
@@ -37,81 +37,6 @@ DEFINE_PER_CPU(struct ppc64_tlb_batch, ppc64_tlb_batch);
  * arch/powerpc/include/asm/tlb.h file -- tgall
  */
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
-static DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
-static unsigned long pte_freelist_forced_free;
-
-struct pte_freelist_batch
-{
-	struct rcu_head	rcu;
-	unsigned int	index;
-	pgtable_free_t	tables[0];
-};
-
-#define PTE_FREELIST_SIZE \
-	((PAGE_SIZE - sizeof(struct pte_freelist_batch)) \
-	  / sizeof(pgtable_free_t))
-
-static void pte_free_smp_sync(void *arg)
-{
-	/* Do nothing, just ensure we sync with all CPUs */
-}
-
-/* This is only called when we are critically out of memory
- * (and fail to get a page in pte_free_tlb).
- */
-static void pgtable_free_now(pgtable_free_t pgf)
-{
-	pte_freelist_forced_free++;
-
-	smp_call_function(pte_free_smp_sync, NULL, 1);
-
-	pgtable_free(pgf);
-}
-
-static void pte_free_rcu_callback(struct rcu_head *head)
-{
-	struct pte_freelist_batch *batch =
-		container_of(head, struct pte_freelist_batch, rcu);
-	unsigned int i;
-
-	for (i = 0; i < batch->index; i++)
-		pgtable_free(batch->tables[i]);
-
-	free_page((unsigned long)batch);
-}
-
-static void pte_free_submit(struct pte_freelist_batch *batch)
-{
-	INIT_RCU_HEAD(&batch->rcu);
-	call_rcu(&batch->rcu, pte_free_rcu_callback);
-}
-
-void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf)
-{
-	/* This is safe since tlb_gather_mmu has disabled preemption */
-        cpumask_t local_cpumask = cpumask_of_cpu(smp_processor_id());
-	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
-
-	if (atomic_read(&tlb->mm->mm_users) < 2 ||
-	    cpus_equal(tlb->mm->cpu_vm_mask, local_cpumask)) {
-		pgtable_free(pgf);
-		return;
-	}
-
-	if (*batchp == NULL) {
-		*batchp = (struct pte_freelist_batch *)__get_free_page(GFP_ATOMIC);
-		if (*batchp == NULL) {
-			pgtable_free_now(pgf);
-			return;
-		}
-		(*batchp)->index = 0;
-	}
-	(*batchp)->tables[(*batchp)->index++] = pgf;
-	if ((*batchp)->index == PTE_FREELIST_SIZE) {
-		pte_free_submit(*batchp);
-		*batchp = NULL;
-	}
-}
 
 /*
  * A linux PTE was changed and the corresponding hash table entry
@@ -229,17 +154,6 @@ void __flush_tlb_pending(struct ppc64_tlb_batch *batch)
 	batch->index = 0;
 }
 
-void pte_free_finish(void)
-{
-	/* This is safe since tlb_gather_mmu has disabled preemption */
-	struct pte_freelist_batch **batchp = &__get_cpu_var(pte_freelist_cur);
-
-	if (*batchp == NULL)
-		return;
-	pte_free_submit(*batchp);
-	*batchp = NULL;
-}
-
 /**
  * __flush_hash_table_range - Flush all HPTEs for a given address range
  *                            from the hash table (and the TLB). But keeps
-- 
1.5.6.5
