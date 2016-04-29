Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDxn1m6pzDqBW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:26:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 12/70] powerpc/mm: Remove RPN_SHIFT and RPN_SIZE
Date: Fri, 29 Apr 2016 23:25:35 +1000
Message-Id: <1461936393-10131-12-git-send-email-mpe@ellerman.id.au>
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

PTE_RPN_SHIFT is actually page size dependent. Even though PowerISA 3.0
expects only the lower 12 bits to be zero, we will always find the pages
to be PAGE_SHIFT aligned. In case of hash config, this also allows us to
use the additional 3 bits to track pte specific information. We need
to make sure we use these bits only for hash specific pte flags.

For both 4K and 64K config, pte now can hold 57 bits address.

Inorder to keep things simpler, drop PTE_RPN_SHIFT and PTE_RPN_SIZE and
specify the 57 bit detail explicitly.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  4 ----
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 26 +++++++++++++-------------
 arch/powerpc/include/asm/book3s/64/hash.h     | 15 +++++++--------
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  4 ++--
 arch/powerpc/mm/pgtable_64.c                  |  2 +-
 5 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 5f08a0832238..772850e517f3 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -51,10 +51,6 @@
 #define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_HASHPTE | \
 			 _PAGE_F_SECOND | _PAGE_F_GIX)
 
-/* shift to put page number into pte */
-#define PTE_RPN_SHIFT	(12)
-#define PTE_RPN_SIZE	(45)	/* gives 57-bit real addresses */
-
 #define _PAGE_4K_PFN		0
 #ifndef __ASSEMBLY__
 /*
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index f4650504a61e..ecc7ce0f4baf 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -40,15 +40,6 @@
 /* PTE flags to conserve for HPTE identification */
 #define _PAGE_HPTEFLAGS (_PAGE_BUSY | _PAGE_F_SECOND | \
 			 _PAGE_F_GIX | _PAGE_HASHPTE | _PAGE_COMBO)
-
-/* Shift to put page number into pte.
- *
- * That gives us a max RPN of 41 bits, which means a max of 57 bits
- * of addressable physical space, or 53 bits for the special 4k PFNs.
- */
-#define PTE_RPN_SHIFT	(16)
-#define PTE_RPN_SIZE	(41)
-
 /*
  * we support 16 fragments per PTE page of 64K size.
  */
@@ -68,6 +59,7 @@
 #define PGD_MASKED_BITS		0xc0000000000000ffUL
 
 #ifndef __ASSEMBLY__
+#include <asm/errno.h>
 
 /*
  * With 64K pages on hash table, we have a special PTE format that
@@ -124,10 +116,18 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 #define pte_pagesize_index(mm, addr, pte)	\
 	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)
 
-#define remap_4k_pfn(vma, addr, pfn, prot)				\
-	(WARN_ON(((pfn) >= (1UL << PTE_RPN_SIZE))) ? -EINVAL :	\
-		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
-			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN)))
+extern int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
+			   unsigned long pfn, unsigned long size, pgprot_t);
+static inline int remap_4k_pfn(struct vm_area_struct *vma, unsigned long addr,
+			       unsigned long pfn, pgprot_t prot)
+{
+	if (pfn > (PTE_RPN_MASK >> PAGE_SHIFT)) {
+		WARN(1, "remap_4k_pfn called with wrong pfn value\n");
+		return -EINVAL;
+	}
+	return remap_pfn_range(vma, addr, pfn, PAGE_SIZE,
+			       __pgprot(pgprot_val(prot) | _PAGE_4K_PFN));
+}
 
 #define PTE_TABLE_SIZE	PTE_FRAG_SIZE
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 5e7e74d30eb9..e1abe39e9dc2 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -49,7 +49,11 @@
  * page, since THP huge page also need to track real subpage details
  */
 #define _PAGE_THP_HUGE  _PAGE_4K_PFN
-
+/*
+ * We support 57 bit real address in pte. Clear everything above 57, and
+ * every thing below PAGE_SHIFT;
+ */
+#define PTE_RPN_MASK	(((1UL << 57) - 1) & (PAGE_MASK))
 /*
  * set of bits not changed in pmd_modify.
  */
@@ -134,11 +138,6 @@
 
 #define _PTE_NONE_MASK	_PAGE_HPTEFLAGS
 /*
- * The mask convered by the RPN must be a ULL on 32-bit platforms with
- * 64-bit PTEs
- */
-#define PTE_RPN_MASK	(((1UL << PTE_RPN_SIZE) - 1) << PTE_RPN_SHIFT)
-/*
  * _PAGE_CHG_MASK masks of bits that are to be preserved across
  * pgprot changes
  */
@@ -437,13 +436,13 @@ static inline int pte_present(pte_t pte)
  */
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
 {
-	return __pte((((pte_basic_t)(pfn) << PTE_RPN_SHIFT) & PTE_RPN_MASK) |
+	return __pte((((pte_basic_t)(pfn) << PAGE_SHIFT) & PTE_RPN_MASK) |
 		     pgprot_val(pgprot));
 }
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	return (pte_val(pte) & PTE_RPN_MASK) >> PTE_RPN_SHIFT;
+	return (pte_val(pte) & PTE_RPN_MASK) >> PAGE_SHIFT;
 }
 
 /* Generic modifiers for PTE bits */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index b609729e0d76..0fac73721e1e 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -172,10 +172,10 @@ extern struct page *pgd_page(pgd_t pgd);
 #define SWP_TYPE_BITS 5
 #define __swp_type(x)		(((x).val >> _PAGE_BIT_SWAP_TYPE) \
 				& ((1UL << SWP_TYPE_BITS) - 1))
-#define __swp_offset(x)		(((x).val & PTE_RPN_MASK) >> PTE_RPN_SHIFT)
+#define __swp_offset(x)		(((x).val & PTE_RPN_MASK) >> PAGE_SHIFT)
 #define __swp_entry(type, offset)	((swp_entry_t) { \
 				((type) << _PAGE_BIT_SWAP_TYPE) \
-				| (((offset) << PTE_RPN_SHIFT) & PTE_RPN_MASK)})
+				| (((offset) << PAGE_SHIFT) & PTE_RPN_MASK)})
 /*
  * swp_entry_t must be independent of pte bits. We build a swp_entry_t from
  * swap type and offset we get from swap and convert that to pte to find a
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 603db71ff21d..9e0553eafcb7 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -757,7 +757,7 @@ pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
 {
 	unsigned long pmdv;
 
-	pmdv = (pfn << PTE_RPN_SHIFT) & PTE_RPN_MASK;
+	pmdv = (pfn << PAGE_SHIFT) & PTE_RPN_MASK;
 	return pmd_set_protbits(__pmd(pmdv), pgprot);
 }
 
-- 
2.5.0
