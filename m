Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHZ3B0DMkzDrBx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 02:20:37 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAEFIl9i135350
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 10:20:36 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26q9axbk62-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 10:20:36 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 14 Nov 2016 08:20:34 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 2/2] powerpc/mm/hugetlb: Switch hugetlb update to use
 pte_update
Date: Mon, 14 Nov 2016 20:50:20 +0530
In-Reply-To: <20161114152020.4608-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161114152020.4608-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161114152020.4608-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have updated hugetlb functions to take vm_area_struct and we can
derive huge page size from vma, switch the pte update to use generic functions.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h | 34 +++++++---------------------
 arch/powerpc/include/asm/hugetlb.h           |  2 +-
 2 files changed, 9 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 80fa0c828413..0a6db2086140 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -31,36 +31,18 @@ static inline int hstate_get_psize(struct hstate *hstate)
 	}
 }
 
-static inline unsigned long huge_pte_update(struct mm_struct *mm, unsigned long addr,
+static inline unsigned long huge_pte_update(struct vm_area_struct *vma, unsigned long addr,
 					    pte_t *ptep, unsigned long clr,
 					    unsigned long set)
 {
-	if (radix_enabled()) {
-		unsigned long old_pte;
+	unsigned long pg_sz;
 
-		if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+	VM_WARN_ON(!is_vm_hugetlb_page(vma));
+	pg_sz = huge_page_size(hstate_vma(vma));
 
-			unsigned long new_pte;
-
-			old_pte = __radix_pte_update(ptep, ~0, 0);
-			asm volatile("ptesync" : : : "memory");
-			/*
-			 * new value of pte
-			 */
-			new_pte = (old_pte | set) & ~clr;
-			/*
-			 * For now let's do heavy pid flush
-			 * radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
-			 */
-			radix__flush_tlb_mm(mm);
-
-			__radix_pte_update(ptep, 0, new_pte);
-		} else
-			old_pte = __radix_pte_update(ptep, clr, set);
-		asm volatile("ptesync" : : : "memory");
-		return old_pte;
-	}
-	return hash__pte_update(mm, addr, ptep, clr, set, true);
+	if (radix_enabled())
+		return radix__pte_update(vma->vm_mm, addr, ptep, clr, set, pg_sz);
+	return hash__pte_update(vma->vm_mm, addr, ptep, clr, set, true);
 }
 
 static inline void huge_ptep_set_wrprotect(struct vm_area_struct *vma,
@@ -69,7 +51,7 @@ static inline void huge_ptep_set_wrprotect(struct vm_area_struct *vma,
 	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_WRITE)) == 0)
 		return;
 
-	huge_pte_update(vma->vm_mm, addr, ptep, _PAGE_WRITE, 0);
+	huge_pte_update(vma, addr, ptep, _PAGE_WRITE, 0);
 }
 
 #endif
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index bb1bf23d6f90..f0731dff76c2 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -136,7 +136,7 @@ static inline pte_t huge_ptep_get_and_clear(struct vm_area_struct *vma,
 					    unsigned long addr, pte_t *ptep)
 {
 #ifdef CONFIG_PPC64
-	return __pte(huge_pte_update(vma->vm_mm, addr, ptep, ~0UL, 0));
+	return __pte(huge_pte_update(vma, addr, ptep, ~0UL, 0));
 #else
 	return __pte(pte_update(ptep, ~0UL, 0));
 #endif
-- 
2.10.2
