Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40wGM74pltzDr61
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 00:29:23 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4TETJPi104408
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 10:29:19 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j98781k16-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 May 2018 10:29:18 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Tue, 29 May 2018 10:29:07 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V2 4/4] powerpc/mm/radix: Change pte relax sequence to handle
 nest MMU hang
Date: Tue, 29 May 2018 19:58:41 +0530
In-Reply-To: <20180529142841.19428-1-aneesh.kumar@linux.ibm.com>
References: <20180529142841.19428-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180529142841.19428-4-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When relaxing access (read -> read_write update), pte needs to be marked invalid
to handle a nest MMU bug. We also need to do a tlb flush after the pte is
marked invalid before updating the pte with new access bits.

We also move tlb flush to platform specific __ptep_set_access_flags. This will
help us to gerid of unnecessary tlb flush on BOOK3S 64 later. We don't do that
in this patch. This also helps in avoiding multiple tlbies with coprocessor
attached.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  2 ++
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 ++
 arch/powerpc/include/asm/nohash/64/pgtable.h |  2 ++
 arch/powerpc/include/asm/pgtable.h           |  1 +
 arch/powerpc/mm/pgtable-book3s64.c           |  1 -
 arch/powerpc/mm/pgtable-radix.c              | 14 ++++++++++----
 arch/powerpc/mm/pgtable.c                    |  2 --
 7 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 39d3a4245694..02f5acd7ccc4 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -245,6 +245,8 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 	unsigned long clr = ~pte_val(entry) & _PAGE_RO;
 
 	pte_update(ptep, clr, set);
+
+	flush_tlb_page(vma, address);
 }
 
 #define __HAVE_ARCH_PTE_SAME
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index c2471bac86b9..7c46a98cc7f4 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -266,6 +266,8 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 	unsigned long clr = ~pte_val(entry) & (_PAGE_RO | _PAGE_NA);
 
 	pte_update(ptep, clr, set);
+
+	flush_tlb_page(vma, address);
 }
 
 static inline int pte_young(pte_t pte)
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 180161d714fb..dd0c7236208f 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -304,6 +304,8 @@ static inline void __ptep_set_access_flags(struct vm_area_struct *vma,
 	unsigned long old = pte_val(*ptep);
 	*ptep = __pte(old | bits);
 #endif
+
+	flush_tlb_page(vma, address);
 }
 
 #define __HAVE_ARCH_PTE_SAME
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index ab7d2d996be4..14c79a7dc855 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -8,6 +8,7 @@
 #include <asm/processor.h>		/* For TASK_SIZE */
 #include <asm/mmu.h>
 #include <asm/page.h>
+#include <asm/tlbflush.h>
 
 struct mm_struct;
 
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 4a8150481a88..82fed87289de 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -52,7 +52,6 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 		 */
 		__ptep_set_access_flags(vma, pmdp_ptep(pmdp),
 					pmd_pte(entry), address, MMU_PAGE_2M);
-		flush_pmd_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	}
 	return changed;
 }
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index 2034cbc9aa56..0ddfe591cd24 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -1091,8 +1091,12 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long set = pte_val(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED |
 					      _PAGE_RW | _PAGE_EXEC);
-
-	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+	/*
+	 * To avoid NMMU hang while relaxing access, we need mark
+	 * the pte invalid in between.
+	 */
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1) ||
+	    atomic_read(&mm->context.copros) > 0) {
 		unsigned long old_pte, new_pte;
 
 		old_pte = __radix_pte_update(ptep, ~0, 0);
@@ -1100,9 +1104,11 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
 		 * new value of pte
 		 */
 		new_pte = old_pte | set;
-		radix__flush_tlb_pte_p9_dd1(old_pte, mm, address);
+		radix__flush_tlb_page_psize(mm, address, psize);
 		__radix_pte_update(ptep, 0, new_pte);
-	} else
+	} else {
 		__radix_pte_update(ptep, 0, set);
+		radix__flush_tlb_page_psize(mm, address, psize);
+	}
 	asm volatile("ptesync" : : : "memory");
 }
diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 20cacd33e5be..5281c2c064af 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -224,7 +224,6 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 		assert_pte_locked(vma->vm_mm, address);
 		__ptep_set_access_flags(vma, ptep, entry,
 					address, mmu_virtual_psize);
-		flush_tlb_page(vma, address);
 	}
 	return changed;
 }
@@ -263,7 +262,6 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 		assert_spin_locked(&vma->vm_mm->page_table_lock);
 #endif
 		__ptep_set_access_flags(vma, ptep, pte, addr, psize);
-		flush_hugetlb_page(vma, addr);
 	}
 	return changed;
 #endif
-- 
2.17.0
