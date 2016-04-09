Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmJh173dzDq6S
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:14:59 +1000 (AEST)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:14:58 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 8CC011FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:03:04 -0600 (MDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396EtI634144418
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:14:55 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396EsXm027870
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:14:55 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 13/68] powerpc/mm: Use generic version of
 pmdp_clear_flush_young
Date: Sat,  9 Apr 2016 11:43:09 +0530
Message-Id: <1460182444-2468-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The radix variant is going to require a flush_pmd_tlb_range. With
flush_pmd_tlb_range added, pmdp_clear_flush_young is same as the generic
version. So drop the powerpc specific variant

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  3 ---
 arch/powerpc/mm/pgtable_64.c                 | 13 +++----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 0fac73721e1e..4745d314acfb 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -298,9 +298,6 @@ extern int pmdp_set_access_flags(struct vm_area_struct *vma,
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
 extern int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 				     unsigned long address, pmd_t *pmdp);
-#define __HAVE_ARCH_PMDP_CLEAR_YOUNG_FLUSH
-extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
-				  unsigned long address, pmd_t *pmdp);
 
 #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
 extern pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index db924c54f370..98c91ad18ba7 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -593,22 +593,15 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 	return pmd;
 }
 
-int pmdp_test_and_clear_young(struct vm_area_struct *vma,
-			      unsigned long address, pmd_t *pmdp)
-{
-	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
-}
-
 /*
  * We currently remove entries from the hashtable regardless of whether
- * the entry was young or dirty. The generic routines only flush if the
- * entry was young or dirty which is not good enough.
+ * the entry was young or dirty.
  *
  * We should be more intelligent about this but for the moment we override
  * these functions and force a tlb flush unconditionally
  */
-int pmdp_clear_flush_young(struct vm_area_struct *vma,
-				  unsigned long address, pmd_t *pmdp)
+int pmdp_test_and_clear_young(struct vm_area_struct *vma,
+			      unsigned long address, pmd_t *pmdp)
 {
 	return __pmdp_test_and_clear_young(vma->vm_mm, address, pmdp);
 }
-- 
2.5.0
