Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 04 Mar 2009 16:15:00 +1100
Subject: [PATCH] powerpc/mm: Unify PTE_RPN_SHIFT and _PAGE_CHG_MASK definitions
Message-Id: <20090304051604.3C30ADDF9E@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This updates the 32-bit headers to use the same definitions for the RPN
shift inside the PTE as 64-bit, and thus updates _PAGE_CHG_MASK to
become identical.

This does introduce a runtime visible difference, which is that now,
_PAGE_HASHPTE will be part of _PAGE_CHG_MASK and thus preserved. However
this should have no practical effect as it should have been preserved in
the first place and we got away with not having it there due to our
PTE access functions preserving it anyway.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/pgtable-ppc32.h |   36 ++++++++++++++++++++-----------
 arch/powerpc/include/asm/pte-fsl-booke.h |    2 +
 2 files changed, 26 insertions(+), 12 deletions(-)

--- linux-work.orig/arch/powerpc/include/asm/pgtable-ppc32.h	2009-03-02 13:41:49.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pgtable-ppc32.h	2009-03-02 13:41:50.000000000 +1100
@@ -146,9 +146,29 @@ extern int icache_44x_need_flush;
 
 #define _PAGE_HPTEFLAGS _PAGE_HASHPTE
 
-#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | \
-			 _PAGE_SPECIAL)
+/* Location of the PFN in the PTE. Most platforms use the same as _PAGE_SHIFT
+ * here (ie, naturally aligned). Platform who don't just pre-define the
+ * value so we don't override it here
+ */
+#ifndef PTE_RPN_SHIFT
+#define PTE_RPN_SHIFT	(PAGE_SHIFT)
+#endif
+
+#ifdef CONFIG_PTE_64BIT
+#define PTE_RPN_MAX	(1ULL << (64 - PTE_RPN_SHIFT))
+#define PTE_RPN_MASK	(~((1ULL<<PTE_RPN_SHIFT)-1))
+#else
+#define PTE_RPN_MAX	(1UL << (32 - PTE_RPN_SHIFT))
+#define PTE_RPN_MASK	(~((1UL<<PTE_RPN_SHIFT)-1))
+#endif
 
+/* _PAGE_CHG_MASK masks of bits that are to be preserved accross
+ * pgprot changes
+ */
+#define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
+                         _PAGE_ACCESSED | _PAGE_SPECIAL)
+
+/* Mask of bits returned by pte_pgprot() */
 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
 			 _PAGE_WRITETHRU | _PAGE_ENDIAN | \
 			 _PAGE_USER | _PAGE_ACCESSED | \
@@ -236,18 +256,10 @@ extern unsigned long bad_call_to_PMD_PAG
  * Conversions between PTE values and page frame numbers.
  */
 
-/* in some case we want to additionaly adjust where the pfn is in the pte to
- * allow room for more flags */
-#if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
-#define PFN_SHIFT_OFFSET	(PAGE_SHIFT + 8)
-#else
-#define PFN_SHIFT_OFFSET	(PAGE_SHIFT)
-#endif
-
-#define pte_pfn(x)		(pte_val(x) >> PFN_SHIFT_OFFSET)
+#define pte_pfn(x)		(pte_val(x) >> PTE_RPN_SHIFT)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
 
-#define pfn_pte(pfn, prot)	__pte(((pte_basic_t)(pfn) << PFN_SHIFT_OFFSET) |\
+#define pfn_pte(pfn, prot)	__pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |\
 					pgprot_val(prot))
 #define mk_pte(page, prot)	pfn_pte(page_to_pfn(page), prot)
 #endif /* __ASSEMBLY__ */
Index: linux-work/arch/powerpc/include/asm/pte-fsl-booke.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/pte-fsl-booke.h	2009-03-02 13:41:49.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/pte-fsl-booke.h	2009-03-02 13:41:50.000000000 +1100
@@ -36,6 +36,8 @@
 #ifdef CONFIG_PTE_64BIT
 /* ERPN in a PTE never gets cleared, ignore it */
 #define _PTE_NONE_MASK	0xffffffffffff0000ULL
+/* We extend the size of the PTE flags area when using 64-bit PTEs */
+#define PTE_RPN_SHIFT	(PAGE_SHIFT + 8)
 #endif
 
 #define _PMD_PRESENT	0
