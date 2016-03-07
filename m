Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C1671A02EF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 00:40:04 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 7 Mar 2016 06:40:02 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1ECA61FF0062
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Mar 2016 06:28:10 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u27De0E146661860
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 06:40:00 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u27De0VQ031020
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Mar 2016 06:40:00 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 06/14] powerpc/mm: Remove RPN_SHIFT and RPN_SIZE
Date: Mon,  7 Mar 2016 19:09:26 +0530
Message-Id: <1457357974-20839-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1457357974-20839-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We had them as page size dependent. Use PAGE_SIZE instead. While there
remove them and define RPN_MASK better.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  4 ----
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 11 +----------
 arch/powerpc/include/asm/book3s/64/hash.h     | 10 +++++-----
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  4 ++--
 arch/powerpc/mm/pgtable_64.c                  |  2 +-
 5 files changed, 9 insertions(+), 22 deletions(-)

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
index 279ded72f1db..a053e8a1d0d1 100644
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
@@ -125,7 +116,7 @@ extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 	(((pte) & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K)
 
 #define remap_4k_pfn(vma, addr, pfn, prot)				\
-	(WARN_ON(((pfn) >= (1UL << PTE_RPN_SIZE))) ? -EINVAL :	\
+	(WARN_ON(((pfn) > (PTE_RPN_MASK >> PAGE_SHIFT))) ? -EINVAL :	\
 		remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE,	\
 			__pgprot(pgprot_val((prot)) | _PAGE_4K_PFN)))
 
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index fbefbaa92736..8ccb2970f30f 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -136,10 +136,10 @@
 #define PTE_ATOMIC_UPDATES	1
 #define _PTE_NONE_MASK	_PAGE_HPTEFLAGS
 /*
- * The mask convered by the RPN must be a ULL on 32-bit platforms with
- * 64-bit PTEs
+ * We support 57 bit real address in pte. Clear everything above 57, and
+ * every thing below PAGE_SHIFT;
  */
-#define PTE_RPN_MASK	(((1UL << PTE_RPN_SIZE) - 1) << PTE_RPN_SHIFT)
+#define PTE_RPN_MASK	(((1UL << 57) - 1) & (PAGE_MASK))
 /*
  * _PAGE_CHG_MASK masks of bits that are to be preserved across
  * pgprot changes
@@ -439,13 +439,13 @@ static inline int pte_present(pte_t pte)
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
index 97d06de8dbf6..144680382306 100644
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
index 441905f7bba4..1254cf107871 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -762,7 +762,7 @@ pmd_t pfn_pmd(unsigned long pfn, pgprot_t pgprot)
 {
 	unsigned long pmdv;
 
-	pmdv = (pfn << PTE_RPN_SHIFT) & PTE_RPN_MASK;
+	pmdv = (pfn << PAGE_SHIFT) & PTE_RPN_MASK;
 	return pmd_set_protbits(__pmd(pmdv), pgprot);
 }
 
-- 
2.5.0
