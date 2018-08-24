Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xVxz1jCYzDqx0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 16:00:39 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7O5xKcU131125
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 02:00:36 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2m29v0mjh5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 02:00:36 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Fri, 24 Aug 2018 00:00:35 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V3 5/6] powerpc/mm/thp: update pmd_trans_huge to check for
 pmd_present
Date: Fri, 24 Aug 2018 11:30:07 +0530
In-Reply-To: <20180824060008.18396-1-aneesh.kumar@linux.ibm.com>
References: <20180824060008.18396-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180824060008.18396-5-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We need to make sure pmd_trans_huge returns false for a pmd migration entry.
We mark the migration entry by clearing the _PAGE_PRESENT bit. We keep the
_PAGE_PTE bit set to indicate a leaf page table entry. Hence we need to make
sure we check for pmd_present() so that pmd_trans_huge won't return true on
pmd migration entry.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 .../include/asm/book3s/64/pgtable-64k.h        |  3 +++
 arch/powerpc/include/asm/book3s/64/pgtable.h   | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
index d7ee249d6890..e3d4dd4ae2fa 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable-64k.h
@@ -10,6 +10,9 @@
  *
  * Defined in such a way that we can optimize away code block at build time
  * if CONFIG_HUGETLB_PAGE=n.
+ *
+ * returns true for pmd migration entries, THP, devmap, hugetlb
+ * But compile time dependent on CONFIG_HUGETLB_PAGE
  */
 static inline int pmd_huge(pmd_t pmd)
 {
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 8feb4a3240d5..e24db2aa260f 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1136,6 +1136,10 @@ pmd_hugepage_update(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp,
 	return hash__pmd_hugepage_update(mm, addr, pmdp, clr, set);
 }
 
+/*
+ * returns true for pmd migration entries, THP, devmap, hugetlb
+ * But compile time dependent on THP config
+ */
 static inline int pmd_large(pmd_t pmd)
 {
 	return !!(pmd_raw(pmd) & cpu_to_be64(_PAGE_PTE));
@@ -1170,8 +1174,22 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 		pmd_hugepage_update(mm, addr, pmdp, 0, _PAGE_PRIVILEGED);
 }
 
+/*
+ * Only returns true for a THP. False for pmd migration entry.
+ * We also need to return true when we come across a pte that
+ * in between a thp split. While splitting THP, we mark the pmd
+ * invalid (pmdp_invalidate()) before we set it with pte page
+ * address. A pmd_trans_huge() check against a pmd entry during that time
+ * should return true.
+ * We should not call this on a hugetlb entry. We should check for HugeTLB
+ * entry using vma->vm_flags
+ * The page table walk rule is explained in Documentation/vm/transhuge.rst
+ */
 static inline int pmd_trans_huge(pmd_t pmd)
 {
+	if (!pmd_present(pmd))
+		return false;
+
 	if (radix_enabled())
 		return radix__pmd_trans_huge(pmd);
 	return hash__pmd_trans_huge(pmd);
-- 
2.17.1
