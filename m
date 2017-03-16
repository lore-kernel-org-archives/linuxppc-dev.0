Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkPtg1TbXzDqb3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 21:32:42 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GANfhZ131762
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:36 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 297nkmtggr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 06:32:36 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 06:32:35 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 04/11] powerpc/mm/radix: rename _PAGE_LARGE to R_PAGE_LARGE
Date: Thu, 16 Mar 2017 16:02:02 +0530
In-Reply-To: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1489660329-22501-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This bit is only used by radix and it is nice to follow the naming style of having
bit name start with H_/R_ depending on which translation mode they are used.

No functional change in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h | 2 +-
 arch/powerpc/include/asm/book3s/64/radix.h   | 4 ++--
 arch/powerpc/mm/tlb-radix.c                  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index c62f14d0bec1..6666cd366596 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -46,7 +46,7 @@ static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
 	 */
 	VM_WARN_ON(page_shift == mmu_psize_defs[MMU_PAGE_1G].shift);
 	if (page_shift == mmu_psize_defs[MMU_PAGE_2M].shift)
-		return __pte(pte_val(entry) | _PAGE_LARGE);
+		return __pte(pte_val(entry) | R_PAGE_LARGE);
 	else
 		return entry;
 }
diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index 2a2ea47a9bd2..ac16d1943022 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -14,7 +14,7 @@
 /*
  * For P9 DD1 only, we need to track whether the pte's huge.
  */
-#define _PAGE_LARGE	_RPAGE_RSV1
+#define R_PAGE_LARGE	_RPAGE_RSV1
 
 
 #ifndef __ASSEMBLY__
@@ -258,7 +258,7 @@ static inline int radix__pmd_trans_huge(pmd_t pmd)
 static inline pmd_t radix__pmd_mkhuge(pmd_t pmd)
 {
 	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-		return __pmd(pmd_val(pmd) | _PAGE_PTE | _PAGE_LARGE);
+		return __pmd(pmd_val(pmd) | _PAGE_PTE | R_PAGE_LARGE);
 	return __pmd(pmd_val(pmd) | _PAGE_PTE);
 }
 static inline void radix__pmdp_huge_split_prepare(struct vm_area_struct *vma,
diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
index 952713d6cf04..83dc1ccc2fa1 100644
--- a/arch/powerpc/mm/tlb-radix.c
+++ b/arch/powerpc/mm/tlb-radix.c
@@ -437,7 +437,7 @@ void radix__flush_tlb_pte_p9_dd1(unsigned long old_pte, struct mm_struct *mm,
 		return;
 	}
 
-	if (old_pte & _PAGE_LARGE)
+	if (old_pte & R_PAGE_LARGE)
 		radix__flush_tlb_page_psize(mm, address, MMU_PAGE_2M);
 	else
 		radix__flush_tlb_page_psize(mm, address, mmu_virtual_psize);
-- 
2.7.4
