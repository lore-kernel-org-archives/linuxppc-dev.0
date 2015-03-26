Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 258521A0671
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2015 00:13:53 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 18:43:51 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id F0FF2125804B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:45:25 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2QDDkQx43253948
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:43:47 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2QD5Qpo025946
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 18:35:26 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V4 4/4] powerpc/mm/thp: Return pte address if we find
 trans_splitting.
Date: Thu, 26 Mar 2015 18:43:42 +0530
Message-Id: <1427375622-3708-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1427375622-3708-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1427375622-3708-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For THP that is marked trans splitting, we return the pte.
This require the callers to handle the pmd_trans_splitting scenario,
if they care. All the current callers are either looking at pfn or
write_ok, hence we don't need to update them.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V3:
* Added this new patch.

 arch/powerpc/include/asm/kvm_book3s_64.h | 12 ++----------
 arch/powerpc/kvm/book3s_64_mmu_hv.c      |  9 +++------
 arch/powerpc/kvm/book3s_hv_rm_mmu.c      |  2 +-
 arch/powerpc/mm/hugetlbpage.c            |  9 ++++-----
 4 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index f06820c67175..5233a35d80e2 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -281,11 +281,9 @@ static inline int hpte_cache_flags_ok(unsigned long ptel, unsigned long io_type)
 
 /*
  * If it's present and writable, atomically set dirty and referenced bits and
- * return the PTE, otherwise return 0. If we find a transparent hugepage
- * and if it is marked splitting we return 0;
+ * return the PTE, otherwise return 0.
  */
-static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing,
-						 unsigned int hugepage)
+static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing)
 {
 	pte_t old_pte, new_pte = __pte(0);
 
@@ -301,12 +299,6 @@ static inline pte_t kvmppc_read_update_linux_pte(pte_t *ptep, int writing,
 			cpu_relax();
 			continue;
 		}
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
-		/* If hugepage and is trans splitting return None */
-		if (unlikely(hugepage &&
-			     pmd_trans_splitting(pte_pmd(old_pte))))
-			return __pte(0);
-#endif
 		/* If pte is not present return None */
 		if (unlikely(!(pte_val(old_pte) & _PAGE_PRESENT)))
 			return __pte(0);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 26df3864d85a..0fe9c92e78ed 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -537,20 +537,17 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		}
 		/* if the guest wants write access, see if that is OK */
 		if (!writing && hpte_is_writable(r)) {
-			unsigned int hugepage_shift;
 			pte_t *ptep, pte;
 			unsigned long flags;
-
 			/*
 			 * We need to protect against page table destruction
-			 * while looking up and updating the pte.
+			 * hugepage split and collapse.
 			 */
 			local_irq_save(flags);
 			ptep = find_linux_pte_or_hugepte(current->mm->pgd,
-							 hva, &hugepage_shift);
+							 hva, NULL);
 			if (ptep) {
-				pte = kvmppc_read_update_linux_pte(ptep, 1,
-							   hugepage_shift);
+				pte = kvmppc_read_update_linux_pte(ptep, 1);
 				if (pte_write(pte))
 					write_ok = 1;
 			}
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index f559b25de173..d839f08cb903 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -219,7 +219,7 @@ long kvmppc_do_h_enter(struct kvm *kvm, unsigned long flags,
 				local_irq_restore(flags);
 			return H_PARAMETER;
 		}
-		pte = kvmppc_read_update_linux_pte(ptep, writing, hpage_shift);
+		pte = kvmppc_read_update_linux_pte(ptep, writing);
 		if (pte_present(pte) && !pte_protnone(pte)) {
 			if (writing && !pte_write(pte))
 				/* make the actual HPTE be read-only */
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index d79cd3190b39..b07270cd82a4 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -1011,12 +1011,11 @@ pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
 			 * A hugepage collapse is captured by pmd_none, because
 			 * it mark the pmd none and do a hpte invalidate.
 			 *
-			 * A hugepage split is captured by pmd_trans_splitting
-			 * because we mark the pmd trans splitting and do a
-			 * hpte invalidate
-			 *
+			 * We don't worry about pmd_trans_splitting here, The
+			 * caller if it needs to handle the splitting case
+			 * should check for that.
 			 */
-			if (pmd_none(pmd) || pmd_trans_splitting(pmd))
+			if (pmd_none(pmd))
 				return NULL;
 
 			if (pmd_huge(pmd) || pmd_large(pmd)) {
-- 
2.1.0
