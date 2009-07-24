Return-Path: <benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C5FC6B869E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Jul 2009 19:15:46 +1000 (EST)
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 24 Jul 2009 19:15:28 +1000
Subject: [PATCH 12/20] powerpc/mm: Rework & cleanup page table freeing code
	path
In-Reply-To: <1248426902.401617.944220131651.qpush@grosgo>
Message-Id: <20090724091546.B52E8DDD1B@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

That patch used to just add a hook to page table flushing but
pulling that string brought out a whole bunch of issues, so it
now does that and more:

 - We now make the RCU batching of page freeing SMP only, as I
believe it was intended initially. We make a few more things compile
to nothing on !CONFIG_SMP

 - Some macros are turned into functions, though that forced me to
out of line a few stuffs due to unsolvable include depenencies,
however it's probably better that way anyway, it's not -that-
critical code path.

 - 32-bit didn't call pte_free_finish() on tlb_flush() which means
that it wouldn't push out the batch to RCU for delayed freeing when
a bunch of page tables have been freed, they would just stay in there
until the batch gets full.

64-bit BookE will use that hook to maintain the virtually linear
page tables or the indirect entries in the TLB when using the
HW loader.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/pgalloc.h |   39 ++++++++++++++++++++++++++-----------
 arch/powerpc/include/asm/tlb.h     |   38 ++----------------------------------
 arch/powerpc/mm/pgtable.c          |   10 +++++++++
 arch/powerpc/mm/tlb_hash32.c       |    3 ++
 arch/powerpc/mm/tlb_hash64.c       |   15 ++++++++++++++
 arch/powerpc/mm/tlb_nohash.c       |    8 +++++++
 6 files changed, 67 insertions(+), 46 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pgalloc.h	2009-07-24 17:39:52.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/pgalloc.h	2009-07-24 17:41:40.000000000 +1000
@@ -4,6 +4,15 @@
 
 #include <linux/mm.h>
 
+#ifdef CONFIG_PPC_BOOK3E
+extern void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address);
+#else /* CONFIG_PPC_BOOK3E */
+static inline void tlb_flush_pgtable(struct mmu_gather *tlb,
+				     unsigned long address)
+{
+}
+#endif /* !CONFIG_PPC_BOOK3E */
+
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
 	free_page((unsigned long)pte);
@@ -35,19 +44,27 @@ static inline pgtable_free_t pgtable_fre
 #include <asm/pgalloc-32.h>
 #endif
 
-extern void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf);
-
 #ifdef CONFIG_SMP
-#define __pte_free_tlb(tlb,ptepage,address)		\
-do { \
-	pgtable_page_dtor(ptepage); \
-	pgtable_free_tlb(tlb, pgtable_free_cache(page_address(ptepage), \
-					PTE_NONCACHE_NUM, PTE_TABLE_SIZE-1)); \
-} while (0)
-#else
-#define __pte_free_tlb(tlb, pte, address)	pte_free((tlb)->mm, (pte))
-#endif
+extern void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf);
+extern void pte_free_finish(void);
+#else /* CONFIG_SMP */
+static inline void pgtable_free_tlb(struct mmu_gather *tlb, pgtable_free_t pgf)
+{
+	pgtable_free(pgf);
+}
+static inline void pte_free_finish(void) { }
+#endif /* !CONFIG_SMP */
 
+static inline void __pte_free_tlb(struct mmu_gather *tlb, struct page *ptepage,
+				  unsigned long address)
+{
+	pgtable_free_t pgf = pgtable_free_cache(page_address(ptepage),
+						PTE_NONCACHE_NUM,
+						PTE_TABLE_SIZE-1);
+ 	tlb_flush_pgtable(tlb, address);
+	pgtable_page_dtor(ptepage);
+	pgtable_free_tlb(tlb, pgf);
+}
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_PGALLOC_H */
Index: linux-work/arch/powerpc/include/asm/tlb.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/tlb.h	2009-07-24 17:39:52.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/tlb.h	2009-07-24 17:41:40.000000000 +1000
@@ -25,57 +25,25 @@
 
 #include <linux/pagemap.h>
 
-struct mmu_gather;
-
 #define tlb_start_vma(tlb, vma)	do { } while (0)
 #define tlb_end_vma(tlb, vma)	do { } while (0)
 
-#if !defined(CONFIG_PPC_STD_MMU)
-
-#define tlb_flush(tlb)			flush_tlb_mm((tlb)->mm)
-
-#elif defined(__powerpc64__)
-
-extern void pte_free_finish(void);
-
-static inline void tlb_flush(struct mmu_gather *tlb)
-{
-	struct ppc64_tlb_batch *tlbbatch = &__get_cpu_var(ppc64_tlb_batch);
-
-	/* If there's a TLB batch pending, then we must flush it because the
-	 * pages are going to be freed and we really don't want to have a CPU
-	 * access a freed page because it has a stale TLB
-	 */
-	if (tlbbatch->index)
-		__flush_tlb_pending(tlbbatch);
-
-	pte_free_finish();
-}
-
-#else
-
 extern void tlb_flush(struct mmu_gather *tlb);
 
-#endif
-
 /* Get the generic bits... */
 #include <asm-generic/tlb.h>
 
-#if !defined(CONFIG_PPC_STD_MMU) || defined(__powerpc64__)
-
-#define __tlb_remove_tlb_entry(tlb, pte, address) do { } while (0)
-
-#else
 extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
 			     unsigned long address);
 
 static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
-					unsigned long address)
+					  unsigned long address)
 {
+#ifdef PPC_STD_MMU_32
 	if (pte_val(*ptep) & _PAGE_HASHPTE)
 		flush_hash_entry(tlb->mm, ptep, address);
+#endif
 }
 
-#endif
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_TLB_H */
Index: linux-work/arch/powerpc/mm/pgtable.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/pgtable.c	2009-07-24 17:39:52.000000000 +1000
+++ linux-work/arch/powerpc/mm/pgtable.c	2009-07-24 17:41:40.000000000 +1000
@@ -30,6 +30,14 @@
 #include <asm/tlbflush.h>
 #include <asm/tlb.h>
 
+#ifdef CONFIG_SMP
+
+/*
+ * Handle batching of page table freeing on SMP. Page tables are
+ * queued up and send to be freed later by RCU in order to avoid
+ * freeing a page table page that is being walked without locks
+ */
+
 static DEFINE_PER_CPU(struct pte_freelist_batch *, pte_freelist_cur);
 static unsigned long pte_freelist_forced_free;
 
@@ -116,6 +124,8 @@ void pte_free_finish(void)
 	*batchp = NULL;
 }
 
+#endif /* CONFIG_SMP */
+
 /*
  * Handle i/d cache flushing, called from set_pte_at() or ptep_set_access_flags()
  */
Index: linux-work/arch/powerpc/mm/tlb_hash32.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_hash32.c	2009-07-24 17:39:52.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_hash32.c	2009-07-24 17:41:40.000000000 +1000
@@ -71,6 +71,9 @@ void tlb_flush(struct mmu_gather *tlb)
 		 */
 		_tlbia();
 	}
+
+	/* Push out batch of freed page tables */
+	pte_free_finish();
 }
 
 /*
Index: linux-work/arch/powerpc/mm/tlb_hash64.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_hash64.c	2009-07-24 17:39:52.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_hash64.c	2009-07-24 17:41:40.000000000 +1000
@@ -154,6 +154,21 @@ void __flush_tlb_pending(struct ppc64_tl
 	batch->index = 0;
 }
 
+void tlb_flush(struct mmu_gather *tlb)
+{
+	struct ppc64_tlb_batch *tlbbatch = &__get_cpu_var(ppc64_tlb_batch);
+
+	/* If there's a TLB batch pending, then we must flush it because the
+	 * pages are going to be freed and we really don't want to have a CPU
+	 * access a freed page because it has a stale TLB
+	 */
+	if (tlbbatch->index)
+		__flush_tlb_pending(tlbbatch);
+
+	/* Push out batch of freed page tables */
+	pte_free_finish();
+}
+
 /**
  * __flush_hash_table_range - Flush all HPTEs for a given address range
  *                            from the hash table (and the TLB). But keeps
Index: linux-work/arch/powerpc/mm/tlb_nohash.c
===================================================================
--- linux-work.orig/arch/powerpc/mm/tlb_nohash.c	2009-07-24 17:41:33.000000000 +1000
+++ linux-work/arch/powerpc/mm/tlb_nohash.c	2009-07-24 17:41:40.000000000 +1000
@@ -233,3 +233,11 @@ void flush_tlb_range(struct vm_area_stru
 	flush_tlb_mm(vma->vm_mm);
 }
 EXPORT_SYMBOL(flush_tlb_range);
+
+void tlb_flush(struct mmu_gather *tlb)
+{
+	flush_tlb_mm(tlb->mm);
+
+	/* Push out batch of freed page tables */
+	pte_free_finish();
+}
