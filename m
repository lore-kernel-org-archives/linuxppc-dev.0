Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PmMd1ywtzF1RT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 21:27:57 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBPwXO099655
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:27:54 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hcstx36d7-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 07:27:53 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Mon, 16 Apr 2018 07:27:53 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V1 03/11] powerpc/mm: Use pmd_lockptr instead of opencoding it
Date: Mon, 16 Apr 2018 16:57:16 +0530
In-Reply-To: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180416112724.9677-5-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

In later patch we switch pmd_lock from mm->page_table_lock to split pmd ptlock.
It avoid compilations issues, use pmd_lockptr helper.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/pgtable-book3s64.c | 4 ++--
 arch/powerpc/mm/pgtable-hash64.c   | 8 +++++---
 arch/powerpc/mm/pgtable-radix.c    | 2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 35913b0b6d56..e1c304183172 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -37,7 +37,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
 	int changed;
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(!pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
-	assert_spin_locked(&vma->vm_mm->page_table_lock);
+	assert_spin_locked(pmd_lockptr(vma->vm_mm, pmdp));
 #endif
 	changed = !pmd_same(*(pmdp), entry);
 	if (changed) {
@@ -62,7 +62,7 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 {
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(pte_present(pmd_pte(*pmdp)) && !pte_protnone(pmd_pte(*pmdp)));
-	assert_spin_locked(&mm->page_table_lock);
+	assert_spin_locked(pmd_lockptr(mm, pmdp));
 	WARN_ON(!(pmd_trans_huge(pmd) || pmd_devmap(pmd)));
 #endif
 	trace_hugepage_set_pmd(addr, pmd_val(pmd));
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 199bfda5f0d9..692bfc9e372c 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -193,7 +193,7 @@ unsigned long hash__pmd_hugepage_update(struct mm_struct *mm, unsigned long addr
 
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(!hash__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
-	assert_spin_locked(&mm->page_table_lock);
+	assert_spin_locked(pmd_lockptr(mm, pmdp));
 #endif
 
 	__asm__ __volatile__(
@@ -265,7 +265,8 @@ void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
 				  pgtable_t pgtable)
 {
 	pgtable_t *pgtable_slot;
-	assert_spin_locked(&mm->page_table_lock);
+
+	assert_spin_locked(pmd_lockptr(mm, pmdp));
 	/*
 	 * we store the pgtable in the second half of PMD
 	 */
@@ -285,7 +286,8 @@ pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp)
 	pgtable_t pgtable;
 	pgtable_t *pgtable_slot;
 
-	assert_spin_locked(&mm->page_table_lock);
+	assert_spin_locked(pmd_lockptr(mm, pmdp));
+
 	pgtable_slot = (pgtable_t *)pmdp + PTRS_PER_PMD;
 	pgtable = *pgtable_slot;
 	/*
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index f1891e215e39..473415750cbf 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -975,7 +975,7 @@ unsigned long radix__pmd_hugepage_update(struct mm_struct *mm, unsigned long add
 
 #ifdef CONFIG_DEBUG_VM
 	WARN_ON(!radix__pmd_trans_huge(*pmdp) && !pmd_devmap(*pmdp));
-	assert_spin_locked(&mm->page_table_lock);
+	assert_spin_locked(pmd_lockptr(mm, pmdp));
 #endif
 
 	old = radix__pte_update(mm, addr, (pte_t *)pmdp, clr, set, 1);
-- 
2.14.3
