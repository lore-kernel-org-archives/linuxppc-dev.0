Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX3D83f8hzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 00:56:56 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1RDt5qC140897
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 08:56:54 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28u641bptc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 08:56:54 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 27 Feb 2017 06:56:53 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/2] power/mm: update pte_write and pte_wrprotect to handle
 savedwrite
Date: Mon, 27 Feb 2017 19:26:27 +0530
In-Reply-To: <1488203787-17849-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1488203787-17849-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1488203787-17849-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use pte_write() to check whethwer the pte entry is writable. This is
mostly used to later mark the pte read only if it is writable. The other
use of pte_write() is to check whether the pte_entry is writable so that hardware
page table entry can be marked accordingly. This is used in kvm where we look
at qemu page table entry and update hardware hash page table for the guest with
correct write enable bit.

With the above, for the first usage we should also check the savedwrite bit
so that we can correctly clear the savedwite bit. For the later, we add
a new variant __pte_write().

With this we can revert write_protect_page part of 595cd8f256d2 ("mm/ksm: handle
protnone saved writes when making page write protect"). But I left it as it is
as an example code for savedwrite check.

Fixes: c137a2757b886 ("powerpc/mm/autonuma: switch ppc64 to its own
implementation of saved write")

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 24 +++++++++++++++++++-----
 arch/powerpc/kvm/book3s_64_mmu_hv.c          |  2 +-
 arch/powerpc/kvm/book3s_hv_rm_mmu.c          |  2 +-
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index f0b08acda5eb..ec1e731e6a2d 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -347,7 +347,7 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 	__r;							\
 })
 
-static inline int pte_write(pte_t pte)
+static inline int __pte_write(pte_t pte)
 {
 	return !!(pte_raw(pte) & cpu_to_be64(_PAGE_WRITE));
 }
@@ -373,11 +373,16 @@ static inline bool pte_savedwrite(pte_t pte)
 }
 #endif
 
+static inline int pte_write(pte_t pte)
+{
+	return __pte_write(pte) || pte_savedwrite(pte);
+}
+
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pte_t *ptep)
 {
-	if (pte_write(*ptep))
+	if (__pte_write(*ptep))
 		pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 0);
 	else if (unlikely(pte_savedwrite(*ptep)))
 		pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 0);
@@ -390,7 +395,7 @@ static inline void huge_ptep_set_wrprotect(struct mm_struct *mm,
 	 * We should not find protnone for hugetlb, but this complete the
 	 * interface.
 	 */
-	if (pte_write(*ptep))
+	if (__pte_write(*ptep))
 		pte_update(mm, addr, ptep, _PAGE_WRITE, 0, 1);
 	else if (unlikely(pte_savedwrite(*ptep)))
 		pte_update(mm, addr, ptep, 0, _PAGE_PRIVILEGED, 1);
@@ -490,7 +495,13 @@ static inline pte_t pte_clear_savedwrite(pte_t pte)
 	VM_BUG_ON(!pte_protnone(pte));
 	return __pte(pte_val(pte) | _PAGE_PRIVILEGED);
 }
-
+#else
+#define pte_clear_savedwrite pte_clear_savedwrite
+static inline pte_t pte_clear_savedwrite(pte_t pte)
+{
+	VM_WARN_ON(1);
+	return __pte(pte_val(pte) & ~_PAGE_WRITE);
+}
 #endif /* CONFIG_NUMA_BALANCING */
 
 static inline int pte_present(pte_t pte)
@@ -518,6 +529,8 @@ static inline unsigned long pte_pfn(pte_t pte)
 /* Generic modifiers for PTE bits */
 static inline pte_t pte_wrprotect(pte_t pte)
 {
+	if (unlikely(pte_savedwrite(pte)))
+		return pte_clear_savedwrite(pte);
 	return __pte(pte_val(pte) & ~_PAGE_WRITE);
 }
 
@@ -938,6 +951,7 @@ static inline int pmd_protnone(pmd_t pmd)
 
 #define __HAVE_ARCH_PMD_WRITE
 #define pmd_write(pmd)		pte_write(pmd_pte(pmd))
+#define __pmd_write(pmd)	__pte_write(pmd_pte(pmd))
 #define pmd_savedwrite(pmd)	pte_savedwrite(pmd_pte(pmd))
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -994,7 +1008,7 @@ static inline int __pmdp_test_and_clear_young(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pmd_t *pmdp)
 {
-	if (pmd_write((*pmdp)))
+	if (__pmd_write((*pmdp)))
 		pmd_hugepage_update(mm, addr, pmdp, _PAGE_WRITE, 0);
 	else if (unlikely(pmd_savedwrite(*pmdp)))
 		pmd_hugepage_update(mm, addr, pmdp, 0, _PAGE_PRIVILEGED);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index f3158fb16de3..8c68145ba1bd 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -601,7 +601,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 							 hva, NULL, NULL);
 			if (ptep) {
 				pte = kvmppc_read_update_linux_pte(ptep, 1);
-				if (pte_write(pte))
+				if (__pte_write(pte))
 					write_ok = 1;
 			}
 			local_irq_restore(flags);
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index 6fca970373ee..ce6f2121fffe 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -256,7 +256,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 		}
 		pte = kvmppc_read_update_linux_pte(ptep, writing);
 		if (pte_present(pte) && !pte_protnone(pte)) {
-			if (writing && !pte_write(pte))
+			if (writing && !__pte_write(pte))
 				/* make the actual HPTE be read-only */
 				ptel = hpte_make_readonly(ptel);
 			is_ci = pte_ci(pte);
-- 
2.7.4
