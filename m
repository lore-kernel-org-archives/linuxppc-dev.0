Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CAA591A0468
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:36 +1100 (AEDT)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:24:36 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0D5982BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:34 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANAO9sn37355730
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:17 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANAO1su014072
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:24:01 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V5 29/31] powerpc/mm: Move hugetlb related headers
Date: Mon, 23 Nov 2015 15:52:38 +0530
Message-Id: <1448274160-28446-30-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448274160-28446-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/hash-4k.h  | 31 ++++++++++++
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 51 +++++++++++++++++++
 arch/powerpc/include/asm/nohash/pgtable.h     | 25 ++++++++++
 arch/powerpc/include/asm/page.h               | 42 ++--------------
 arch/powerpc/mm/hugetlbpage-hash64.c          | 18 +++++++
 arch/powerpc/mm/hugetlbpage.c                 | 72 ---------------------------
 6 files changed, 129 insertions(+), 110 deletions(-)

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
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index 0734e4daffef..e2138c7ae70f 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -114,3 +114,21 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 	*ptep = __pte(new_pte & ~_PAGE_BUSY);
 	return 0;
 }
+
+#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_DEBUG_VM)
+/*
+ * This enables us to catch the wrong page directory format
+ * Moved here so that we can use WARN() in the call.
+ */
+int hugepd_ok(hugepd_t hpd)
+{
+	bool is_hugepd;
+
+	/*
+	 * We should not find this format in page directory, warn otherwise.
+	 */
+	is_hugepd = (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
+	WARN(is_hugepd, "Found wrong page directory format\n");
+	return 0;
+}
+#endif
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9833fee493ec..bc72e542a83e 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -53,78 +53,6 @@ static unsigned nr_gpages;
 
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
-#if defined(CONFIG_PPC_64K_PAGES) && defined(CONFIG_DEBUG_VM)
-/*
- * This enables us to catch the wrong page directory format
- * Moved here so that we can use WARN() in the call.
- */
-int hugepd_ok(hugepd_t hpd)
-{
-	bool is_hugepd;
-
-	/*
-	 * We should not find this format in page directory, warn otherwise.
-	 */
-	is_hugepd = (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
-	WARN(is_hugepd, "Found wrong page directory format\n");
-	return 0;
-}
-#endif
-
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
