Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJ53K4XRKzDrGD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 18:38:21 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6R8Z0aD128536
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 04:38:19 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bycdjs6jr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 04:38:18 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 27 Jul 2017 02:38:18 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 "Kirill A . Shutemov" <kirill@shutemov.name>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/3] powerpc/mm: Implement pmdp_establish for ppc64
Date: Thu, 27 Jul 2017 14:07:55 +0530
In-Reply-To: <20170727083756.32217-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20170727083756.32217-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20170727083756.32217-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can now use this to set pmd page table entries to absolute values. THP
need to ensure that we always update pmd PTE entries such that we never mark
the pmd none. pmdp_establish helps in implementing that.

This doesn't flush the tlb. Based on the old_pmd value returned caller can
decide to call flush_pmd_tlb_range()

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/radix.h |  9 ++++++---
 arch/powerpc/mm/pgtable-book3s64.c         | 10 ++++++++++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
index cd481ab601b6..558fea3b2d22 100644
--- a/arch/powerpc/include/asm/book3s/64/radix.h
+++ b/arch/powerpc/include/asm/book3s/64/radix.h
@@ -131,7 +131,8 @@ static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
 	do {
 		pte = READ_ONCE(*ptep);
 		old_pte = pte_val(pte);
-		new_pte = (old_pte | set) & ~clr;
+		new_pte = old_pte & ~clr;
+		new_pte |= set;
 
 	} while (!pte_xchg(ptep, __pte(old_pte), __pte(new_pte)));
 
@@ -153,9 +154,11 @@ static inline unsigned long radix__pte_update(struct mm_struct *mm,
 
 		old_pte = __radix_pte_update(ptep, ~0ul, 0);
 		/*
-		 * new value of pte
+		 * new value of pte. We clear all the bits in clr mask
+		 * first and set the bits in set mask.
 		 */
-		new_pte = (old_pte | set) & ~clr;
+		new_pte = old_pte & ~clr;
+		new_pte |= set;
 		radix__flush_tlb_pte_p9_dd1(old_pte, mm, addr);
 		if (new_pte)
 			__radix_pte_update(ptep, 0, new_pte);
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 0bb7f824ecdd..7100b0150a2a 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -45,6 +45,16 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	return changed;
 }
 
+pmd_t pmdp_establish(struct vm_area_struct *vma, unsigned long addr,
+		     pmd_t *pmdp, pmd_t entry)
+{
+	long pmdval;
+
+	pmdval = pmd_hugepage_update(vma->vm_mm, addr, pmdp, ~0UL, pmd_val(entry));
+	return __pmd(pmdval);
+}
+
+
 int pmdp_test_and_clear_young(struct vm_area_struct *vma,
 			      unsigned long address, pmd_t *pmdp)
 {
-- 
2.13.3
