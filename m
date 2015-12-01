Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD2A71A1AAD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:24 +1100 (AEDT)
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:22 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id AAF59125805B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:07:36 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13bHZH3604922
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:18 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13bGe7022493
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:17 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 30/35] powerpc/mm: Don't hardcode page table size
Date: Tue,  1 Dec 2015 09:06:55 +0530
Message-Id: <1448941020-15168-31-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h | 21 +++++++++++++----
 arch/powerpc/include/asm/pgalloc-64.h            | 10 --------
 arch/powerpc/mm/init_64.c                        |  4 ----
 4 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 52110d7af659..cca050aa1aa8 100644
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
 /*
@@ -49,6 +43,24 @@
  * of addressable physical space, or 46 bits for the special 4k PFNs.
  */
 #define PTE_RPN_SHIFT	(30)
+/*
+ * we support 16 fragments per PTE page of 64K size.
+ */
+#define PTE_FRAG_NR	16
+/*
+ * We use a 2K PTE page fragment and another 2K for storing
+ * real_pte_t hash index
+ */
+#define PTE_FRAG_SIZE_SHIFT  12
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
 
@@ -112,8 +124,12 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
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
index a44660d76096..2217de6454d6 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
@@ -9,8 +9,19 @@
 #define PUD_INDEX_SIZE	0
 #define PGD_INDEX_SIZE  12
 
+/*
+ * we support 16 fragments per PTE page of 64K size.
+ */
+#define PTE_FRAG_NR	16
+/*
+ * We use a 2K PTE page fragment and another 2K for storing
+ * real_pte_t hash index
+ */
+#define PTE_FRAG_SIZE_SHIFT  12
+#define PTE_FRAG_SIZE (1UL << PTE_FRAG_SIZE_SHIFT)
+
 #ifndef __ASSEMBLY__
-#define PTE_TABLE_SIZE	(sizeof(real_pte_t) << PTE_INDEX_SIZE)
+#define PTE_TABLE_SIZE	PTE_FRAG_SIZE
 #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
 #endif	/* __ASSEMBLY__ */
@@ -32,9 +43,11 @@
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
index d8cde71f6734..69ef28a81733 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -163,16 +163,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
 }
 
 #else /* if CONFIG_PPC_64K_PAGES */
-/*
- * we support 16 fragments per PTE page.
- */
-#define PTE_FRAG_NR	16
-/*
- * We use a 2K PTE page fragment and another 2K for storing
- * real_pte_t hash index
- */
-#define PTE_FRAG_SIZE_SHIFT  12
-#define PTE_FRAG_SIZE (2 * PTRS_PER_PTE * sizeof(pte_t))
 
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
