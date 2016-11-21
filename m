Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMy0l08VBzDvmC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 05:33:42 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uALIT1TD083622
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 13:33:40 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26v5j3jj9d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 13:33:40 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Nov 2016 13:33:40 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 4/6] powerpc/mm/hugetlb: Switch hugetlb update to use
 huge_pte_update
Date: Tue, 22 Nov 2016 00:03:20 +0530
In-Reply-To: <20161121183322.14585-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161121183322.14585-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161121183322.14585-4-aneesh.kumar@linux.vnet.ibm.com>
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
 arch/powerpc/include/asm/book3s/64/hugetlb.h | 42 ++++++++++++++++++++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h |  9 ------
 arch/powerpc/include/asm/hugetlb.h           |  2 +-
 3 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index d9c283f95e05..9a64f356a8e8 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -30,4 +30,46 @@ static inline int hstate_get_psize(struct hstate *hstate)
 		return mmu_virtual_psize;
 	}
 }
+
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
 #endif
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 46d739457d68..ef2eef1ba99a 100644
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
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index c03e0a3dd4d8..058d6311de87 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -136,7 +136,7 @@ static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 					    unsigned long addr, pte_t *ptep)
 {
 #ifdef CONFIG_PPC64
-	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
+	return __pte(huge_pte_update(mm, addr, ptep, ~0UL, 0));
 #else
 	return __pte(pte_update(ptep, ~0UL, 0));
 #endif
-- 
2.10.2
