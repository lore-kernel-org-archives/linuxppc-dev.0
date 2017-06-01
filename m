Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdqbX1vbXzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 00:34:00 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51ETvSo109384
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 10:33:58 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2atfwhr6xt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 10:33:57 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 08:33:56 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v2 2/3] powerpc/mm: Don't send IPI to all cpus on THP updates
Date: Thu,  1 Jun 2017 20:03:34 +0530
In-Reply-To: <1496327615-7754-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1496327615-7754-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1496327615-7754-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we made sure that lockless walk of linux page table is mostly limitted
to current task(current->mm->pgdir) we can update the THP update sequence to
only send IPI to cpus on which this task has run. This helps in reducing the IPI
overload on systems with large number of CPUs.

W.r.t kvm even though kvm is walking page table with vpc->arch.pgdir, it is
done only on secondary cpus and in that case we have primary cpu added to
task's mm cpumask. Sending an IPI to primary will force the secondary to do
a vm exit and hence this mm cpumask usage is safe here.

W.r.t CAPI, we still end up walking linux page table with capi context MM. For
now the pte lookup serialization sends an IPI to all cpus in CPI is in use. We
can further improve this by adding the CAPI interrupt handling cpu to task
mm cpumask. That will be done in a later patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
 arch/powerpc/mm/pgtable-book3s64.c           | 32 +++++++++++++++++++++++++++-
 arch/powerpc/mm/pgtable-hash64.c             |  8 +++----
 arch/powerpc/mm/pgtable-radix.c              |  8 +++----
 4 files changed, 40 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 85bc9875c3be..d8c3c18e220d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1145,6 +1145,7 @@ static inline bool arch_needs_pgtable_deposit(void)
 		return false;
 	return true;
 }
+extern void serialize_against_pte_lookup(struct mm_struct *mm);
 
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
index 5fcb3dd74c13..2679f57b90e2 100644
--- a/arch/powerpc/mm/pgtable-book3s64.c
+++ b/arch/powerpc/mm/pgtable-book3s64.c
@@ -9,6 +9,7 @@
 
 #include <linux/sched.h>
 #include <linux/mm_types.h>
+#include <misc/cxl-base.h>
 
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
@@ -64,6 +65,35 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 	trace_hugepage_set_pmd(addr, pmd_val(pmd));
 	return set_pte_at(mm, addr, pmdp_ptep(pmdp), pmd_pte(pmd));
 }
+
+static void do_nothing(void *unused)
+{
+
+}
+/*
+ * Serialize against find_current_mm_pte which does lock-less
+ * lookup in page tables with local interrupts disabled. For huge pages
+ * it casts pmd_t to pte_t. Since format of pte_t is different from
+ * pmd_t we want to prevent transit from pmd pointing to page table
+ * to pmd pointing to huge page (and back) while interrupts are disabled.
+ * We clear pmd to possibly replace it with page table pointer in
+ * different code paths. So make sure we wait for the parallel
+ * find_current_mm_pte to finish.
+ */
+void serialize_against_pte_lookup(struct mm_struct *mm)
+{
+	smp_mb();
+	/*
+	 * Cxl fault handling requires us to do a lockless page table
+	 * walk while inserting hash page table entry with mm tracked
+	 * in cxl context. Hence we need to do a global flush.
+	 */
+	if (cxl_ctx_in_use())
+		smp_call_function(do_nothing, NULL, 1);
+	else
+		smp_call_function_many(mm_cpumask(mm), do_nothing, NULL, 1);
+}
+
 /*
  * We use this to invalidate a pmdp entry before switching from a
  * hugepte to regular pmd entry.
@@ -77,7 +107,7 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 	 * This ensures that generic code that rely on IRQ disabling
 	 * to prevent a parallel THP split work as expected.
 	 */
-	kick_all_cpus_sync();
+	serialize_against_pte_lookup(vma->vm_mm);
 }
 
 static pmd_t pmd_set_protbits(pmd_t pmd, pgprot_t pgprot)
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 8b85a14b08ea..f6313cc29ae4 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -159,7 +159,7 @@ pmd_t hash__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addres
 	 * by sending an IPI to all the cpus and executing a dummy
 	 * function there.
 	 */
-	kick_all_cpus_sync();
+	serialize_against_pte_lookup(vma->vm_mm);
 	/*
 	 * Now invalidate the hpte entries in the range
 	 * covered by pmd. This make sure we take a
@@ -299,16 +299,16 @@ pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
 	 */
 	memset(pgtable, 0, PTE_FRAG_SIZE);
 	/*
-	 * Serialize against find_linux_pte_or_hugepte which does lock-less
+	 * Serialize against find_current_mm_pte variants which does lock-less
 	 * lookup in page tables with local interrupts disabled. For huge pages
 	 * it casts pmd_t to pte_t. Since format of pte_t is different from
 	 * pmd_t we want to prevent transit from pmd pointing to page table
 	 * to pmd pointing to huge page (and back) while interrupts are disabled.
 	 * We clear pmd to possibly replace it with page table pointer in
 	 * different code paths. So make sure we wait for the parallel
-	 * find_linux_pte_or_hugepage to finish.
+	 * find_curren_mm_pte to finish.
 	 */
-	kick_all_cpus_sync();
+	serialize_against_pte_lookup(mm);
 	return old_pmd;
 }
 
diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
index c28165d8970b..6e3d1518eef3 100644
--- a/arch/powerpc/mm/pgtable-radix.c
+++ b/arch/powerpc/mm/pgtable-radix.c
@@ -707,7 +707,7 @@ pmd_t radix__pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long addre
 	pmd = *pmdp;
 	pmd_clear(pmdp);
 	/*FIXME!!  Verify whether we need this kick below */
-	kick_all_cpus_sync();
+	serialize_against_pte_lookup(vma->vm_mm);
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
 }
@@ -767,16 +767,16 @@ pmd_t radix__pmdp_huge_get_and_clear(struct mm_struct *mm,
 	old = radix__pmd_hugepage_update(mm, addr, pmdp, ~0UL, 0);
 	old_pmd = __pmd(old);
 	/*
-	 * Serialize against find_linux_pte_or_hugepte which does lock-less
+	 * Serialize against find_current_mm_pte which does lock-less
 	 * lookup in page tables with local interrupts disabled. For huge pages
 	 * it casts pmd_t to pte_t. Since format of pte_t is different from
 	 * pmd_t we want to prevent transit from pmd pointing to page table
 	 * to pmd pointing to huge page (and back) while interrupts are disabled.
 	 * We clear pmd to possibly replace it with page table pointer in
 	 * different code paths. So make sure we wait for the parallel
-	 * find_linux_pte_or_hugepage to finish.
+	 * find_current_mm_pte to finish.
 	 */
-	kick_all_cpus_sync();
+	serialize_against_pte_lookup(mm);
 	return old_pmd;
 }
 
-- 
2.7.4
