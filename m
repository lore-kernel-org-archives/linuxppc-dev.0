Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNHxZ2RdLzDw2B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 19:02:10 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAM7wqes057860
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 03:02:07 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vdtkk9fg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 03:02:07 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 22 Nov 2016 01:02:06 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v4 4/7] powerpc/mm/hugetlb: Make copy of
 huge_ptep_get_and_clear to different platform headers
Date: Tue, 22 Nov 2016 13:31:46 +0530
In-Reply-To: <20161122080149.31306-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20161122080149.31306-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161122080149.31306-4-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In the subsequent patch we will change the implementation of book3s 64. This
also avoid #ifdef in the code.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h |  5 +++++
 arch/powerpc/include/asm/book3s/64/hugetlb.h |  6 ++++++
 arch/powerpc/include/asm/hugetlb.h           | 10 ----------
 arch/powerpc/include/asm/nohash/32/pgtable.h |  6 ++++++
 arch/powerpc/include/asm/nohash/64/pgtable.h |  7 +++++++
 5 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 0713626e9189..959ef2fb812a 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -222,6 +222,11 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	ptep_set_wrprotect(mm, addr, ptep);
 }
 
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	return __pte(pte_update(ptep, ~0UL, 0));
+}
 
 static inline void __ptep_set_access_flags(struct mm_struct *mm,
 					   pte_t *ptep, pte_t entry,
diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index d9c283f95e05..8fc04d2ac86f 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -30,4 +30,10 @@ static inline int hstate_get_psize(struct hstate *hstate)
 		return mmu_virtual_psize;
 	}
 }
+
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
+}
 #endif
diff --git a/arch/powerpc/include/asm/hugetlb.h b/arch/powerpc/include/asm/hugetlb.h
index c03e0a3dd4d8..8b39806851c0 100644
--- a/arch/powerpc/include/asm/hugetlb.h
+++ b/arch/powerpc/include/asm/hugetlb.h
@@ -132,16 +132,6 @@ static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	set_pte_at(mm, addr, ptep, pte);
 }
 
-static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-					    unsigned long addr, pte_t *ptep)
-{
-#ifdef CONFIG_PPC64
-	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
-#else
-	return __pte(pte_update(ptep, ~0UL, 0));
-#endif
-}
-
 static inline void huge_ptep_clear_flush(struct vm_area_struct *vma,
 					 unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 24ee66bf7223..b83b851827ec 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -266,6 +266,12 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	ptep_set_wrprotect(mm, addr, ptep);
 }
 
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	return __pte(pte_update(ptep, ~0UL, 0));
+}
+
 
 static inline void __ptep_set_access_flags(struct mm_struct *mm,
 					   pte_t *ptep, pte_t entry,
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 86d49dc60ec6..f53f8307a778 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -266,6 +266,13 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	pte_update(mm, addr, ptep, _PAGE_RW, 0, 1);
 }
 
+static inline pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+					    unsigned long addr, pte_t *ptep)
+{
+	return __pte(pte_update(mm, addr, ptep, ~0UL, 0, 1));
+}
+
+
 /*
  * We currently remove entries from the hashtable regardless of whether
  * the entry was young or dirty. The generic routines only flush if the
-- 
2.10.2
