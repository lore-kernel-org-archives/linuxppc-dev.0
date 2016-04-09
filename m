Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmJ61DZSzDqF8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:14:29 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 00:14:28 -0600
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DB20C1FF001F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 00:02:34 -0600 (MDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396EP0L41811978
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:14:25 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396EOYa026712
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:14:25 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Scott Wood <scottwood@freescale.com>
Subject: [PATCH V2 03/68] powerpc/mm/nohash: Update non SMP version of
 flush_tlb_page to handle hugetlb address
Date: Sat,  9 Apr 2016 11:42:59 +0530
Message-Id: <1460182444-2468-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

If the vma mapped a hugetlb region, use hugetlb size to flush the tlb.

Cc: Scott Wood <scottwood@freescale.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/hugetlb.h   | 9 +++++----
 arch/powerpc/mm/hugetlbpage-book3e.c | 8 ++++++++
 arch/powerpc/mm/tlb_nohash.c         | 4 ++++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index 42814f0567cc..6b49121d042e 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -45,6 +45,11 @@ static inline unsigned int hugepd_shift(hugepd_t hpd)
 	return hpd.pd & HUGEPD_SHIFT_MASK;
 }
 
+void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
+			    pte_t pte);
+void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+void __local_flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
+
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 
@@ -83,10 +88,6 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
 }
 #endif
 
-void book3e_hugetlb_preload(struct vm_area_struct *vma, unsigned long ea,
-			    pte_t pte);
-void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-
 void hugetlb_free_pgd_range(struct mmu_gather *tlb, unsigned long addr,
 			    unsigned long end, unsigned long floor,
 			    unsigned long ceiling);
diff --git a/arch/powerpc/mm/hugetlbpage-book3e.c b/arch/powerpc/mm/hugetlbpage-book3e.c
index 7e6d0880813f..bec6acca9e43 100644
--- a/arch/powerpc/mm/hugetlbpage-book3e.c
+++ b/arch/powerpc/mm/hugetlbpage-book3e.c
@@ -197,3 +197,11 @@ void flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 
 	__flush_tlb_page(vma->vm_mm, vmaddr, tsize, 0);
 }
+
+void __local_flush_hugetlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
+{
+	struct hstate *hstate = hstate_file(vma->vm_file);
+	unsigned long tsize = huge_page_shift(hstate) - 10;
+
+	__local_flush_tlb_page(vma->vm_mm, vmaddr, tsize, 0);
+}
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index 8ed4c037cb00..18f48eff0f60 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -203,6 +203,10 @@ void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
 
 void local_flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 {
+#ifdef CONFIG_HUGETLB_PAGE
+	if (vma && is_vm_hugetlb_page(vma))
+		return __local_flush_hugetlb_page(vma, vmaddr);
+#endif
 	__local_flush_tlb_page(vma ? vma->vm_mm : NULL, vmaddr,
 			       mmu_get_tsize(mmu_virtual_psize), 0);
 }
-- 
2.5.0
