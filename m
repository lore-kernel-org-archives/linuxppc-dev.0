Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 682481A087B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:39 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 12:29:39 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 7E4B12CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:36 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U2TTob524610
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:37 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U2T3kb009149
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:04 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 29/31] powerpc/mm: Move hugetlb related headers
Date: Wed, 30 Sep 2015 07:57:22 +0530
Message-Id: <1443580044-30659-30-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

W.r.t hugetlb, we support two format for pmd. With book3s_64 and
64K linux page size, we can have pte at the pmd level. Hence we
don't need to support hugepd there. For everything else hugepd
is supported and pmd_huge is (0).

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 31 ++++++++++++++++
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 40 ++++++++++++++++++++
 arch/powerpc/include/asm/nohash/pgtable.h     | 25 +++++++++++++
 arch/powerpc/include/asm/page.h               | 27 ++------------
 arch/powerpc/mm/hugetlbpage.c                 | 53 ---------------------------
 5 files changed, 100 insertions(+), 76 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 75e8b9326e4b..b4d25529d179 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -93,6 +93,37 @@ extern struct page *pgd_page(pgd_t pgd);
 #define remap_4k_pfn(vma, addr, pfn, prot)	\
 	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE, (prot))
 
+#ifdef CONFIG_HUGETLB_PAGE
+/*
+ * For 4k page size, we support explicit hugepage via hugepd
+ */
+static inline int pmd_huge(pmd_t pmd)
+{
+	return 0;
+}
+
+static inline int pud_huge(pud_t pud)
+{
+	return 0;
+}
+
+static inline int pgd_huge(pgd_t pgd)
+{
+	return 0;
+}
+#define pgd_huge pgd_huge
+
+static inline int hugepd_ok(hugepd_t hpd)
+{
+	/*
+	 * hugepd pointer, bottom two bits == 00 and next 4 bits
+	 * indicate size of table
+	 */
+	return (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
+}
+#define is_hugepd(hpd)		(hugepd_ok(hpd))
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index f46fbd6cd837..0869e5fe5d08 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -119,6 +119,46 @@ static inline bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
 #define pgd_pte(pgd)	(pud_pte(((pud_t){ pgd })))
 #define pte_pgd(pte)	((pgd_t)pte_pud(pte))
 
+#ifdef CONFIG_HUGETLB_PAGE
+/*
+ * We have PGD_INDEX_SIZ = 12 and PTE_INDEX_SIZE = 8, so that we can have
+ * 16GB hugepage pte in PGD and 16MB hugepage pte at PMD;
+ *
+ * Defined in such a way that we can optimize away code block at build time
+ * if CONFIG_HUGETLB_PAGE=n.
+ */
+static inline int pmd_huge(pmd_t pmd)
+{
+	/*
+	 * leaf pte for huge page, bottom two bits != 00
+	 */
+	return ((pmd_val(pmd) & 0x3) != 0x0);
+}
+
+static inline int pud_huge(pud_t pud)
+{
+	/*
+	 * leaf pte for huge page, bottom two bits != 00
+	 */
+	return ((pud_val(pud) & 0x3) != 0x0);
+}
+
+static inline int pgd_huge(pgd_t pgd)
+{
+	/*
+	 * leaf pte for huge page, bottom two bits != 00
+	 */
+	return ((pgd_val(pgd) & 0x3) != 0x0);
+}
+#define pgd_huge pgd_huge
+
+static inline int hugepd_ok(hugepd_t hpd)
+{
+	return 0;
+}
+#define is_hugepd(pdep)			0
+#endif /* CONFIG_HUGETLB_PAGE */
+
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_BOOK3S_64_HASH_64K_H */
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index c0c41a2409d2..1263c22d60d8 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -223,5 +223,30 @@ extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
 				     unsigned long size, pgprot_t vma_prot);
 #define __HAVE_PHYS_MEM_ACCESS_PROT
 
+#ifdef CONFIG_HUGETLB_PAGE
+static inline int hugepd_ok(hugepd_t hpd)
+{
+	return (hpd.pd > 0);
+}
+
+static inline int pmd_huge(pmd_t pmd)
+{
+	return 0;
+}
+
+static inline int pud_huge(pud_t pud)
+{
+	return 0;
+}
+
+static inline int pgd_huge(pgd_t pgd)
+{
+	return 0;
+}
+#define pgd_huge		pgd_huge
+
+#define is_hugepd(hpd)		(hugepd_ok(hpd))
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 83a4cc5fc306..31835988c12a 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -384,30 +384,11 @@ typedef unsigned long pgprot_t;
 
 typedef struct { signed long pd; } hugepd_t;
 
-#ifdef CONFIG_HUGETLB_PAGE
-#ifdef CONFIG_PPC_BOOK3S_64
-static inline int hugepd_ok(hugepd_t hpd)
-{
-	/*
-	 * hugepd pointer, bottom two bits == 00 and next 4 bits
-	 * indicate size of table
-	 */
-	return (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
-}
-#else
-static inline int hugepd_ok(hugepd_t hpd)
-{
-	return (hpd.pd > 0);
-}
-#endif
-
-#define is_hugepd(hpd)               (hugepd_ok(hpd))
-#define pgd_huge pgd_huge
-int pgd_huge(pgd_t pgd);
-#else /* CONFIG_HUGETLB_PAGE */
-#define is_hugepd(pdep)			0
-#define pgd_huge(pgd)			0
+#ifndef CONFIG_HUGETLB_PAGE
+#define is_hugepd(pdep)		(0)
+#define pgd_huge(pgd)		(0)
 #endif /* CONFIG_HUGETLB_PAGE */
+
 #define __hugepd(x) ((hugepd_t) { (x) })
 
 struct page;
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 06c14523b787..98bb20c9f71d 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -53,59 +53,6 @@ static unsigned nr_gpages;
 
 #define hugepd_none(hpd)	((hpd).pd == 0)
 
-#ifdef CONFIG_PPC_BOOK3S_64
-/*
- * At this point we do the placement change only for BOOK3S 64. This would
- * possibly work on other subarchs.
- */
-
-/*
- * We have PGD_INDEX_SIZ = 12 and PTE_INDEX_SIZE = 8, so that we can have
- * 16GB hugepage pte in PGD and 16MB hugepage pte at PMD;
- *
- * Defined in such a way that we can optimize away code block at build time
- * if CONFIG_HUGETLB_PAGE=n.
- */
-int pmd_huge(pmd_t pmd)
-{
-	/*
-	 * leaf pte for huge page, bottom two bits != 00
-	 */
-	return ((pmd_val(pmd) & 0x3) != 0x0);
-}
-
-int pud_huge(pud_t pud)
-{
-	/*
-	 * leaf pte for huge page, bottom two bits != 00
-	 */
-	return ((pud_val(pud) & 0x3) != 0x0);
-}
-
-int pgd_huge(pgd_t pgd)
-{
-	/*
-	 * leaf pte for huge page, bottom two bits != 00
-	 */
-	return ((pgd_val(pgd) & 0x3) != 0x0);
-}
-#else
-int pmd_huge(pmd_t pmd)
-{
-	return 0;
-}
-
-int pud_huge(pud_t pud)
-{
-	return 0;
-}
-
-int pgd_huge(pgd_t pgd)
-{
-	return 0;
-}
-#endif
-
 pte_t *huge_pte_offset(struct mm_struct *mm, unsigned long addr)
 {
 	/* Only called for hugetlbfs pages, hence can ignore THP */
-- 
2.5.0
