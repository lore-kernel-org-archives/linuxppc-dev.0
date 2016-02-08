Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79DB91A02D3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 20:21:59 +1100 (AEDT)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 8 Feb 2016 04:21:57 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 79F2AC90041
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 04:21:52 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u189Ls7636503714
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 09:21:54 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u189Lrdl018794
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 04:21:54 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 29/29] powerpc/mm: Hash linux abstraction for pte swap
 encoding
Date: Mon,  8 Feb 2016 14:50:41 +0530
Message-Id: <1454923241-6681-30-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h    | 35 +++++++----------
 arch/powerpc/include/asm/book3s/64/pgtable.h | 57 ++++++++++++++++++++++++++++
 arch/powerpc/mm/slb.c                        |  1 -
 3 files changed, 70 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 5e66915f47ee..2039587c11ea 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -234,34 +234,25 @@
 #define hlpmd_index(address) (((address) >> (H_PMD_SHIFT)) & (H_PTRS_PER_PMD - 1))
 #define hlpte_index(address) (((address) >> (PAGE_SHIFT)) & (H_PTRS_PER_PTE - 1))
 
-/* Encode and de-code a swap entry */
-#define MAX_SWAPFILES_CHECK() do { \
-	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS); \
-	/*							\
-	 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
-	 * We filter HPTEFLAGS on set_pte.			\
-	 */							\
-	BUILD_BUG_ON(H_PAGE_HPTEFLAGS & (0x1f << H_PAGE_BIT_SWAP_TYPE)); \
-	BUILD_BUG_ON(H_PAGE_HPTEFLAGS & H_PAGE_SWP_SOFT_DIRTY);	\
-	} while (0)
 /*
  * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
+ * We encode swap type in the lower part of pte, skipping the lowest two bits.
+ * Offset is encoded as pfn.
  */
-#define SWP_TYPE_BITS 5
-#define __swp_type(x)		(((x).val >> H_PAGE_BIT_SWAP_TYPE) \
-				& ((1UL << SWP_TYPE_BITS) - 1))
-#define __swp_offset(x)		((x).val >> H_PTE_RPN_SHIFT)
-#define __swp_entry(type, offset)	((swp_entry_t) { \
-					((type) << H_PAGE_BIT_SWAP_TYPE) \
-					| ((offset) << H_PTE_RPN_SHIFT) })
+#define hl_swp_type(x)		(((x).val >> H_PAGE_BIT_SWAP_TYPE)	\
+				 & ((1UL << SWP_TYPE_BITS) - 1))
+#define hl_swp_offset(x)	((x).val >> H_PTE_RPN_SHIFT)
+#define hl_swp_entry(type, offset)	((swp_entry_t) {		\
+				((type) << H_PAGE_BIT_SWAP_TYPE)	\
+				| ((offset) << H_PTE_RPN_SHIFT) })
 /*
  * swp_entry_t must be independent of pte bits. We build a swp_entry_t from
  * swap type and offset we get from swap and convert that to pte to find a
  * matching pte in linux page table.
  * Clear bits not found in swap entries here.
  */
-#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~H_PAGE_PTE })
-#define __swp_entry_to_pte(x)	__pte((x).val | H_PAGE_PTE)
+#define hl_pte_to_swp_entry(pte)	((swp_entry_t) { pte_val((pte)) & ~H_PAGE_PTE })
+#define hl_swp_entry_to_pte(x)	__pte((x).val | H_PAGE_PTE)
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
 #define H_PAGE_SWP_SOFT_DIRTY   (1UL << (SWP_TYPE_BITS + H_PAGE_BIT_SWAP_TYPE))
@@ -270,17 +261,17 @@
 #endif /* CONFIG_MEM_SOFT_DIRTY */
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
-static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+static inline pte_t hl_pte_swp_mksoft_dirty(pte_t pte)
 {
 	return __pte(pte_val(pte) | H_PAGE_SWP_SOFT_DIRTY);
 }
 
-static inline bool pte_swp_soft_dirty(pte_t pte)
+static inline bool hl_pte_swp_soft_dirty(pte_t pte)
 {
 	return !!(pte_val(pte) & H_PAGE_SWP_SOFT_DIRTY);
 }
 
-static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+static inline pte_t hl_pte_swp_clear_soft_dirty(pte_t pte)
 {
 	return __pte(pte_val(pte) & ~H_PAGE_SWP_SOFT_DIRTY);
 }
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 61f4d26bdaa9..c8269c71ba75 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -5,6 +5,7 @@
  * the ppc64 hashed page table.
  */
 
+#define SWP_TYPE_BITS 5
 #include <asm/book3s/64/hash.h>
 #include <asm/barrier.h>
 
@@ -325,6 +326,62 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
 {
 	return set_hlpte_at(mm, addr, ptep, pte);
 }
+/*
+ * Swap definitions
+ */
+
+/* Encode and de-code a swap entry */
+#define MAX_SWAPFILES_CHECK() do {					\
+		BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS);	\
+		/*							\
+		 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
+		 * We filter HPTEFLAGS on set_pte.			\
+		 */							\
+		BUILD_BUG_ON(H_PAGE_HPTEFLAGS & (0x1f << H_PAGE_BIT_SWAP_TYPE)); \
+		BUILD_BUG_ON(H_PAGE_HPTEFLAGS & H_PAGE_SWP_SOFT_DIRTY);	\
+	} while (0)
+/*
+ * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
+ */
+static inline swp_entry_t __pte_to_swp_entry(pte_t pte)
+{
+	return hl_pte_to_swp_entry(pte);
+}
+
+static inline pte_t __swp_entry_to_pte(swp_entry_t entry)
+{
+	return hl_swp_entry_to_pte(entry);
+}
+
+static inline unsigned long __swp_type(swp_entry_t entry)
+{
+	return hl_swp_type(entry);
+}
+
+static inline pgoff_t __swp_offset(swp_entry_t entry)
+{
+	return hl_swp_offset(entry);
+}
+
+static inline swp_entry_t __swp_entry(unsigned long type, pgoff_t offset)
+{
+	return hl_swp_entry(type, offset);
+}
+
+#ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
+static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
+{
+	return hl_pte_swp_mksoft_dirty(pte);
+}
+static inline bool pte_swp_soft_dirty(pte_t pte)
+{
+	return hl_pte_swp_soft_dirty(pte);
+}
+static inline pte_t pte_swp_clear_soft_dirty(pte_t pte)
+{
+	return hl_pte_swp_clear_soft_dirty(pte);
+}
+#endif /* CONFIG_HAVE_ARCH_SOFT_DIRTY */
 
 static inline void pmd_set(pmd_t *pmdp, unsigned long val)
 {
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 24af734fcbd7..e80da474997c 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -14,7 +14,6 @@
  *      2 of the License, or (at your option) any later version.
  */
 
-#include <asm/pgtable.h>
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/paca.h>
-- 
2.5.0
