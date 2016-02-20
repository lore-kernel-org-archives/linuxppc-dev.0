Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2AB861A0904
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 17:13:12 +1100 (AEDT)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [RFC PATCH 2/9] powerpc/mm/book3s-64: Free up 7 high-order bits in
 the Linux PTE
Date: Sat, 20 Feb 2016 17:12:33 +1100
Message-Id: <1455948760-24710-3-git-send-email-paulus@samba.org>
In-Reply-To: <1455948760-24710-1-git-send-email-paulus@samba.org>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This frees up bits 57-63 in the Linux PTE on 64-bit Book 3S machines.
In the 4k page case, this is done just by reducing the size of the
RPN field to 39 bits, giving 51-bit real addresses.  In the 64k page
case, we had 10 unused bits in the middle of the PTE, so this moves
the RPN field down 10 bits to make use of those unused bits.  This
means the RPN field is now 3 bits larger at 37 bits, giving 53-bit
real addresses in the normal case, or 49-bit real addresses for the
special 4k PFN case.

We are doing this in order to be able to move some other PTE bits
into the positions where PowerISA V3.0 processors will expect to
find them in radix-tree mode.  Ultimately we will be able to move
the RPN field to lower bit positions and make it larger.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  1 +
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 10 ++++++----
 arch/powerpc/include/asm/book3s/64/hash.h     |  6 +++---
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  6 +++---
 arch/powerpc/mm/pgtable_64.c                  |  2 +-
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index ea0414d..bee3643 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -53,6 +53,7 @@
 
 /* shift to put page number into pte */
 #define PTE_RPN_SHIFT	(18)
+#define PTE_RPN_SIZE	(39)	/* gives 51-bit real addresses */
 
 #define _PAGE_4K_PFN		0
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 849bbec..a8c4c2a 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -39,10 +39,12 @@
 
 /* Shift to put page number into pte.
  *
- * That gives us a max RPN of 34 bits, which means a max of 50 bits
- * of addressable physical space, or 46 bits for the special 4k PFNs.
+ * That gives us a max RPN of 37 bits, which means a max of 53 bits
+ * of addressable physical space, or 49 bits for the special 4k PFNs.
  */
-#define PTE_RPN_SHIFT	(30)
+#define PTE_RPN_SHIFT	(20)
+#define PTE_RPN_SIZE	(37)
+
 /*
  * we support 16 fragments per PTE page of 64K size.
  */
@@ -120,7 +122,7 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)
 
 #define remap_4k_pfn(vma, addr, pfn, prot)				\
-	(WARN_ON(((pfn) >= (1UL << (64 - PTE_RPN_SHIFT)))) ? -EINVAL :	\
+	(WARN_ON(((pfn) >= (1UL << PTE_RPN_SIZE))) ? -EINVAL :	\
 		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
 			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN)))
 
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 9a0a4ef..64eff40 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -131,7 +131,7 @@
  * The mask convered by the RPN must be a ULL on 32-bit platforms with
  * 64-bit PTEs
  */
-#define PTE_RPN_MASK	(~((1UL << PTE_RPN_SHIFT) - 1))
+#define PTE_RPN_MASK	(((1UL << PTE_RPN_SIZE) - 1) << PTE_RPN_SHIFT)
 /*
  * _PAGE_CHG_MASK masks of bits that are to be preserved across
  * pgprot changes
@@ -412,13 +412,13 @@ static inline int pte_present(pte_t pte)
  */
 static inline pte_t pfn_pte(unsigned long pfn, pgprot_t pgprot)
 {
-	return __pte(((pte_basic_t)(pfn) << PTE_RPN_SHIFT) |
+	return __pte((((pte_basic_t)(pfn) << PTE_RPN_SHIFT) & PTE_RPN_MASK) |
 		     pgprot_val(pgprot));
 }
 
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	return pte_val(pte) >> PTE_RPN_SHIFT;
+	return (pte_val(pte) & PTE_RPN_MASK) >> PTE_RPN_SHIFT;
 }
 
 /* Generic modifiers for PTE bits */
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8d1c41d..ab83892 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -154,10 +154,10 @@ static inline void pgd_set(pgd_t *pgdp, unsigned long val)
 #define SWP_TYPE_BITS 5
 #define __swp_type(x)		(((x).val >> _PAGE_BIT_SWAP_TYPE) \
 				& ((1UL << SWP_TYPE_BITS) - 1))
-#define __swp_offset(x)		((x).val >> PTE_RPN_SHIFT)
+#define __swp_offset(x)		(((x).val & PTE_RPN_MASK) >> PTE_RPN_SHIFT)
 #define __swp_entry(type, offset)	((swp_entry_t) { \
-					((type) << _PAGE_BIT_SWAP_TYPE) \
-					| ((offset) << PTE_RPN_SHIFT) })
+				((type) << _PAGE_BIT_SWAP_TYPE) \
+				| (((offset) << PTE_RPN_SHIFT) & PTE_RPN_MASK)})
 /*
  * swp_entry_t must be independent of pte bits. We build a swp_entry_t from
  * swap type and offset we get from swap and convert that to pte to find a
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 3124a20..950c572 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -717,7 +717,7 @@ pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
 {
 	unsigned long pmdv;
 
-	pmdv = pfn << PTE_RPN_SHIFT;
+	pmdv = (pfn << PTE_RPN_SHIFT) & PTE_RPN_MASK;
 	return pmd_set_protbits(__pmd(pmdv), pgprot);
 }
 
-- 
2.5.0
