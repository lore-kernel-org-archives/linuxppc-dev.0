Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDy41PFdzDqBC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 28/70] powerpc/mm: Move pte related functions together
Date: Fri, 29 Apr 2016 23:25:51 +1000
Message-Id: <1461936393-10131-28-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Only code movement. No functionality change.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 142 +++++++++++++--------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 3e64a7b13036..2643487affac 100644
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
