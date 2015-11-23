Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB87E1A1B31
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:52 +1100 (AEDT)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:34:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 355482BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:50 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANAYgx92031974
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:50 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANAYH0G027942
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:17 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 01/10] powerpc/mm: Don't hardcode page table size
Date: Mon, 23 Nov 2015 16:03:36 +0530
Message-Id: <1448274825-30289-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pte and pmd table size are dependent on config items. Don't
hard code the same. This make sure we use the right value
when masking pmd entries and also while checking pmd_bad

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h    | 30 ++++++++++++++++++------
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h | 22 +++++++++++++----
 arch/powerpc/include/asm/pgalloc-64.h            | 10 --------
 arch/powerpc/mm/init_64.c                        |  4 ----
 4 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 957d66d13a97..565f9418c25f 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -25,12 +25,6 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-/* Bits to mask out from a PMD to get to the PTE page */
-/* PMDs point to PTE table fragments which are 4K aligned.  */
-#define PMD_MASKED_BITS		0xfff
-/* Bits to mask out from a PGD/PUD to get to the PMD page */
-#define PUD_MASKED_BITS		0x1ff
-
 #define _PAGE_COMBO	0x00020000 /* this is a combo 4k page */
 #define _PAGE_4K_PFN	0x00040000 /* PFN is for a single 4k page */
 
@@ -44,6 +38,24 @@
  * of addressable physical space, or 46 bits for the special 4k PFNs.
  */
 #define PTE_RPN_SHIFT	(30)
+/*
+ * we support 8 fragments per PTE page of 64K size.
+ */
+#define PTE_FRAG_NR	8
+/*
+ * We use a 2K PTE page fragment and another 4K for storing
+ * real_pte_t hash index. Rounding the entire thing to 8K
+ */
+#define PTE_FRAG_SIZE_SHIFT  13
+#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
+
+/*
+ * Bits to mask out from a PMD to get to the PTE page
+ * PMDs point to PTE table fragments which are PTE_FRAG_SIZE aligned.
+ */
+#define PMD_MASKED_BITS		(PTE_FRAG_SIZE - 1)
+/* Bits to mask out from a PGD/PUD to get to the PMD page */
+#define PUD_MASKED_BITS		0x1ff
 
 #ifndef __ASSEMBLY__
 
@@ -112,8 +124,12 @@ static inline bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
 		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
 			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN)))
 
-#define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
+#define PTE_TABLE_SIZE	PTE_FRAG_SIZE
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define PMD_TABLE_SIZE	((sizeof(pmd_t) << PMD_INDEX_SIZE) + (sizeof(unsigned long) << PMD_INDEX_SIZE))
+#else
 #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
+#endif
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
 
 #define pgd_pte(pgd)	(pud_pte(((pud_t){ pgd })))
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
index a44660d76096..1d8e26e8167b 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
@@ -9,8 +9,20 @@
 #define PUD_INDEX_SIZE	0
 #define PGD_INDEX_SIZE  12
 
+/*
+ * we support 8 fragments per PTE page of 64K size
+ */
+#define PTE_FRAG_NR	8
+/*
+ * We use a 2K PTE page fragment and another 4K for storing
+ * real_pte_t hash index. Rounding the entire thing to 8K
+ */
+#define PTE_FRAG_SIZE_SHIFT  13
+#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
+
+
 #ifndef __ASSEMBLY__
-#define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
+#define PTE_TABLE_SIZE	PTE_FRAG_SIZE
 #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
 #endif	/* __ASSEMBLY__ */
@@ -32,9 +44,11 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-/* Bits to mask out from a PMD to get to the PTE page */
-/* PMDs point to PTE table fragments which are 4K aligned.  */
-#define PMD_MASKED_BITS		0xfff
+/*
+ * Bits to mask out from a PMD to get to the PTE page
+ * PMDs point to PTE table fragments which are PTE_FRAG_SIZE aligned.
+ */
+#define PMD_MASKED_BITS		(PTE_FRAG_SIZE - 1)
 /* Bits to mask out from a PGD/PUD to get to the PMD page */
 #define PUD_MASKED_BITS		0x1ff
 
diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index 4f1cc6c46728..69ef28a81733 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -163,16 +163,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 }
 
 #else /* if CONFIG_PPC_64K_PAGES */
-/*
- * we support 8 fragments per PTE page.
- */
-#define PTE_FRAG_NR	8
-/*
- * We use a 2K PTE page fragment and another 4K for storing
- * real_pte_t hash index. Rounding the entire thing to 8K
- */
-#define PTE_FRAG_SIZE_SHIFT  13
-#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
 
 extern pte_t *page_table_alloc(struct mm_struct *, unsigned long, int);
 extern void page_table_free(struct mm_struct *, unsigned long *, int);
diff --git a/arch/powerpc/mm/init_64.c b/arch/powerpc/mm/init_64.c
index d747dd7bc90b..379a6a90644b 100644
--- a/arch/powerpc/mm/init_64.c
+++ b/arch/powerpc/mm/init_64.c
@@ -87,11 +87,7 @@ static void pgd_ctor(void *addr)
 
 static void pmd_ctor(void *addr)
 {
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-	memset(addr, 0, PMD_TABLE_SIZE * 2);
-#else
 	memset(addr, 0, PMD_TABLE_SIZE);
-#endif
 }
 
 struct kmem_cache *pgtable_cache[MAX_PGTABLE_INDEX_SIZE];
-- 
2.5.0
