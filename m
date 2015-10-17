Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5609D1A02DE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 21:09:02 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 17 Oct 2015 15:38:59 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 3287E394005A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:58 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9HA8vNr4391368
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:57 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9HA8ueb017481
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2015 15:38:57 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V4 29/31] powerpc/mm: Move hugetlb related headers
Date: Sat, 17 Oct 2015 15:38:40 +0530
Message-Id: <1445076522-20527-30-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1445076522-20527-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Acked-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 31 +++++++++++++++
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 51 +++++++++++++++++++++++++
 arch/powerpc/include/asm/nohash/pgtable.h     | 25 +++++++++++++
 arch/powerpc/include/asm/page.h               | 42 ++-------------------
 arch/powerpc/mm/hugetlbpage.c                 | 54 ---------------------------
 5 files changed, 111 insertions(+), 92 deletions(-)

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
index f46fbd6cd837..20865ca7a179 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -119,6 +119,57 @@ static inline bool __rpte_sub_valid(real_pte_t rpte, unsigned long index)
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
+#ifdef CONFIG_DEBUG_VM
+extern int hugepd_ok(hugepd_t hpd);
+#define is_hugepd(hpd)               (hugepd_ok(hpd))
+#else
+/*
+ * With 64k page size, we have hugepage ptes in the pgd and pmd entries. We don't
+ * need to setup hugepage directory for them. Our pte and page directory format
+ * enable us to have this enabled.
+ */
+static inline int hugepd_ok(hugepd_t hpd)
+{
+	return 0;
+}
+#define is_hugepd(pdep)			0
+#endif /* CONFIG_DEBUG_VM */
+
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
index 9c3211eb487c..f63b2761cdd0 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -386,45 +386,11 @@ typedef unsigned long pgprot_t;
 
 typedef struct { signed long pd; } hugepd_t;
 
-#ifdef CONFIG_HUGETLB_PAGE
-#ifdef CONFIG_PPC_BOOK3S_64
-#ifdef CONFIG_PPC_64K_PAGES
-/*
- * With 64k page size, we have hugepage ptes in the pgd and pmd entries. We don't
- * need to setup hugepage directory for them. Our pte and page directory format
- * enable us to have this enabled. But to avoid errors when implementing new
- * features disable hugepd for 64K. We enable a debug version here, So we catch
- * wrong usage.
- */
-#ifdef CONFIG_DEBUG_VM
-extern int hugepd_ok(hugepd_t hpd);
-#else
-#define hugepd_ok(x)	(0)
-#endif
-#else
-static inline int hugepd_ok(hugepd_t hpd)
-{
-	/*
-	 * hugepd pointer, bottom two bits == 00 and next 4 bits
-	 * indicate size of table
-	 */
-	return (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
-}
-#endif
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
index 9833fee493ec..f20c1a9065da 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -53,43 +53,6 @@ static unsigned nr_gpages;
 
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
-
 #if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_DEBUG_VM)
 /*
  * This enables us to catch the wrong page directory format
@@ -108,23 +71,6 @@ int hugepd_ok(hugepd_t hpd)
 }
 #endif
 
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
