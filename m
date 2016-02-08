Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 265791A02E6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 20:21:25 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 8 Feb 2016 02:21:24 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E80E51FF0041
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 02:09:30 -0700 (MST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u189LKeW33357948
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 09:21:20 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u189LKUW017097
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 04:21:20 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 13/29] powerpc/mm: Move swap related definition ot hash64
 header
Date: Mon,  8 Feb 2016 14:50:25 +0530
Message-Id: <1454923241-6681-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1454923241-6681-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

They are dependent on hash pte bits, so move them to hash64 header

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 50 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h | 50 ----------------------------
 2 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index c568eaa1c26d..e88573440bbe 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -236,6 +236,56 @@
 #define pmd_index(address) (((address) >> (PMD_SHIFT)) & (PTRS_PER_PMD - 1))
 #define pte_index(address) (((address) >> (PAGE_SHIFT)) & (PTRS_PER_PTE - 1))
 
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
+#define __swp_offset(x)		((x).val >> PTE_RPN_SHIFT)
+#define __swp_entry(type, offset)	((swp_entry_t) { \
+					((type) << _PAGE_BIT_SWAP_TYPE) \
+					| ((offset) << PTE_RPN_SHIFT) })
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
 extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 			    pte_t *ptep, unsigned long pte, int huge);
 extern unsigned long htab_convert_pte_flags(unsigned long pteflags);
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index ca73ed59131f..dcdee03ec1b1 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -156,56 +156,6 @@ extern struct page *pgd_page(pgd_t pgd);
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
-#define __swp_offset(x)		((x).val >> PTE_RPN_SHIFT)
-#define __swp_entry(type, offset)	((swp_entry_t) { \
-					((type) << _PAGE_BIT_SWAP_TYPE) \
-					| ((offset) << PTE_RPN_SHIFT) })
-/*
- * swp_entry_t must be independent of pte bits. We build a swp_entry_t from
- * swap type and offset we get from swap and convert that to pte to find a
- * matching pte in linux page table.
- * Clear bits not found in swap entries here.
- */
-#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~_PAGE_PTE })
-#define __swp_entry_to_pte(x)	__pte((x).val | _PAGE_PTE)
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
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
 
-- 
2.5.0
