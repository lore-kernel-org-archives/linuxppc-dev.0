Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP04P3WMBzDw3Z
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 22:10:29 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uANB8sHF063342
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:10:27 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26w5j200q6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 06:10:27 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 23 Nov 2016 04:10:25 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v5 5/7] powerpc/mm/hugetlb: Switch hugetlb update to use
 huge_pte_update
Date: Wed, 23 Nov 2016 16:40:01 +0530
In-Reply-To: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161123111003.459-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161123111003.459-5-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want to switch pte_update to use va based tlb flush. In order to do that we
need to track the page size. With hugetlb we currently don't have page size
available in these functions. Hence switch hugetlb to use seperate functions
for update. In later patch we will update hugetlb functions to take
vm_area_struct from which we can derive the page size. After that we will switch
this back to use pte_update

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hugetlb.h | 43 +++++++++++++++++++++++++++-
 arch/powerpc/include/asm/book3s/64/pgtable.h |  9 ------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 8fc04d2ac86f..586236625117 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -31,9 +31,50 @@ static inline int hstate_get_psize(struct hstate *hstate)
 	}
 }
 
+static inline unsigned long huge_pte_update(struct mm_struct *mm, unsigned long addr,
+					    pte_t *ptep, unsigned long clr,
+					    unsigned long set)
+{
+	if (radix_enabled()) {
+		unsigned long old_pte;
+
+		if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+
+			unsigned long new_pte;
+
+			old_pte = __radix_pte_update(ptep, ~0, 0);
+			asm volatile("ptesync" : : : "memory");
+			/*
+			 * new value of pte
+			 */
+			new_pte = (old_pte | set) & ~clr;
+			/*
+			 * For now let's do heavy pid flush
+			 * radix__flush_tlb_page_psize(mm, addr, mmu_virtual_psize);
+			 */
+			radix__flush_tlb_mm(mm);
+
+			__radix_pte_update(ptep, 0, new_pte);
+		} else
+			old_pte = __radix_pte_update(ptep, clr, set);
+		asm volatile("ptesync" : : : "memory");
+		return old_pte;
+	}
+	return hash__pte_update(mm, addr, ptep, clr, set, true);
+}
+
+static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
+					   unsigned long addr, pte_t *ptep)
+{
+	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_WRITE)) == 0)
+		return;
+
+	huge_pte_update(mm, addr, ptep, _PAGE_WRITE, 0);
+}
+
 static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 					    unsigned long addr, pte_t *ptep)
 {
-	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
+	return __pte(huge_pte_update(mm, addr, ptep, ~0UL, 0));
 }
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 761622ec7f2a..4a2bd260eec0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -346,15 +346,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 0);
 }
 
-static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
-					   unsigned long addr, pte_t *ptep)
-{
-	if ((pte_raw(*ptep) & cpu_to_be64(_PAGE_WRITE)) == 0)
-		return;
-
-	pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 1);
-}
-
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pte_t *ptep)
-- 
2.10.2
