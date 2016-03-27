Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqq60k1GzDqGn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:21 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 04:25:20 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D4D7838C8026
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:25:16 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8PGTk36503638
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:25:16 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8PG3X014845
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:25:16 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 23/65] powerpc/mm: Move pte related function together
Date: Sun, 27 Mar 2016 13:53:31 +0530
Message-Id: <1459067053-10835-23-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Only code movement. No functionality change.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 142 +++++++++++++--------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index b4d72ab609df..de3fef1f2dbe 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -430,6 +430,77 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot));
 }
 
+static inline bool pte_user(pte_t pte)
+{
+	return !(pte_val(pte) & _PAGE_PRIVILEGED);
+}
+
+/* Encode and de-code a swap entry */
+#define MAX_SWAPFILES_CHECK() do { \
+	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS); \
+	/*							\
+	 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
+	 * We filter HPTEFLAGS on set_pte.			\
+	 */							\
+	BUILD_BUG_ON(_PAGE_HPTEFLAGS & (0x1f << _PAGE_BIT_SWAP_TYPE)); \
+	BUILD_BUG_ON(_PAGE_HPTEFLAGS & _PAGE_SWP_SOFT_DIRTY);	\
+	} while (0)
+/*
+ * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
+ */
+#define SWP_TYPE_BITS 5
+#define __swp_type(x)		(((x).val >> _PAGE_BIT_SWAP_TYPE) \
+				& ((1UL << SWP_TYPE_BITS) - 1))
+#define __swp_offset(x)		(((x).val & PTE_RPN_MASK) >> PAGE_SHIFT)
+#define __swp_entry(type, offset)	((swp_entry_t) { \
+				((type) << _PAGE_BIT_SWAP_TYPE) \
+				| (((offset) << PAGE_SHIFT) & PTE_RPN_MASK)})
+/*
+ * swp_entry_t must be independent of pte bits. We build a swp_entry_t from
+ * swap type and offset we get from swap and convert that to pte to find a
+ * matching pte in linux page table.
+ * Clear bits not found in swap entries here.
+ */
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~_PAGE_PTE })
+#define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
+
+#ifdef CONFIG_MEM_SOFT_DIRTY
+#define _PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS + _PAGE_BIT_SWAP_TYPE))
+#else
+#define _PAGE_SWP_SOFT_DIRTY	0UL
+#endif /* CONFIG_MEM_SOFT_DIRTY */
+
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
+}
+static inline bool pte_swp_soft_dirty(pte_t pte)
+{
+	return !!(pte_val(pte) & _PAGE_SWP_SOFT_DIRTY);
+}
+static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_SWP_SOFT_DIRTY);
+}
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
+
+static inline bool check_pte_access(unsigned long access, unsigned long ptev)
+{
+	/*
+	 * This check for _PAGE_RWX and _PAGE_PRESENT bits
+	 */
+	if (access & ~ptev)
+		return false;
+	/*
+	 * This check for access to privilege space
+	 */
+	if ((access & _PAGE_PRIVILEGED) != (ptev & _PAGE_PRIVILEGED))
+		return false;
+
+	return true;
+}
+
 #define _PAGE_CACHE_CTL	(_PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)
 
 #define pgprot_noncached pgprot_noncached
@@ -576,77 +647,6 @@ extern struct page *pgd_page(pgd_t pgd);
 #define pgd_ERROR(e) \
 	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
-/* Encode and de-code a swap entry */
-#define MAX_SWAPFILES_CHECK() do { \
-	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS); \
-	/*							\
-	 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
-	 * We filter HPTEFLAGS on set_pte.			\
-	 */							\
-	BUILD_BUG_ON(_PAGE_HPTEFLAGS & (0x1f << _PAGE_BIT_SWAP_TYPE)); \
-	BUILD_BUG_ON(_PAGE_HPTEFLAGS & _PAGE_SWP_SOFT_DIRTY);	\
-	} while (0)
-/*
- * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
- */
-#define SWP_TYPE_BITS 5
-#define __swp_type(x)		(((x).val >> _PAGE_BIT_SWAP_TYPE) \
-				& ((1UL << SWP_TYPE_BITS) - 1))
-#define __swp_offset(x)		(((x).val & PTE_RPN_MASK) >> PAGE_SHIFT)
-#define __swp_entry(type, offset)	((swp_entry_t) { \
-				((type) << _PAGE_BIT_SWAP_TYPE) \
-				| (((offset) << PAGE_SHIFT) & PTE_RPN_MASK)})
-/*
- * swp_entry_t must be independent of pte bits. We build a swp_entry_t from
- * swap type and offset we get from swap and convert that to pte to find a
- * matching pte in linux page table.
- * Clear bits not found in swap entries here.
- */
-#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~_PAGE_PTE })
-#define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
-
-static inline bool pte_user(pte_t pte)
-{
-	return !(pte_val(pte) & _PAGE_PRIVILEGED);
-}
-
-#ifdef CONFIG_MEM_SOFT_DIRTY
-#define _PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS + _PAGE_BIT_SWAP_TYPE))
-#else
-#define _PAGE_SWP_SOFT_DIRTY	0UL
-#endif /* CONFIG_MEM_SOFT_DIRTY */
-
-#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
-static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
-{
-	return __pte(pte_val(pte) | _PAGE_SWP_SOFT_DIRTY);
-}
-static inline bool pte_swp_soft_dirty(pte_t pte)
-{
-	return !!(pte_val(pte) & _PAGE_SWP_SOFT_DIRTY);
-}
-static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
-{
-	return __pte(pte_val(pte) & ~_PAGE_SWP_SOFT_DIRTY);
-}
-#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
-
-static inline bool check_pte_access(unsigned long access, unsigned long ptev)
-{
-	/*
-	 * This check for _PAGE_RWX and _PAGE_PRESENT bits
-	 */
-	if (access & ~ptev)
-		return false;
-	/*
-	 * This check for access to privilege space
-	 */
-	if ((access & _PAGE_PRIVILEGED) != (ptev & _PAGE_PRIVILEGED))
-		return false;
-
-	return true;
-}
-
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
 
-- 
2.5.0
