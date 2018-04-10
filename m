Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40L6S66qcGzF1ys
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 22:49:10 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id v5-v6so7431425plo.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Apr 2018 05:49:10 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 5/5] KVM: PPC: Book3S HV: Radix do not clear partition
 scoped page table when page fault races with other vCPUs.
Date: Tue, 10 Apr 2018 22:48:42 +1000
Message-Id: <20180410124842.30184-6-npiggin@gmail.com>
In-Reply-To: <20180410124842.30184-1-npiggin@gmail.com>
References: <20180410124842.30184-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KVM with an SMP radix guest can get into storms of page faults and
tlbies due to the partition scopd page tables being invalidated and
TLB flushed if they were found to race with another page fault that
set them up.

This tends to cause vCPUs to pile up if several hit common addresses,
then page faults will get serialized on common locks, and then they
each invalidate the previous entry and it's long enough before installing
the new entry that will cause more CPUs to hit page faults and they will
invalidate that new entry.

There doesn't seem to be a need to invalidate in the case of an existing
entry. This solves the tlbie storms.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 39 +++++++++++++++-----------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index dab6b622011c..4af177d24f6c 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -243,6 +243,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 	pmd = pmd_offset(pud, gpa);
 	if (pmd_is_leaf(*pmd)) {
 		unsigned long lgpa = gpa & PMD_MASK;
+		pte_t old_pte = *pmdp_ptep(pmd);
 
 		/*
 		 * If we raced with another CPU which has just put
@@ -252,18 +253,17 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 			ret = -EAGAIN;
 			goto out_unlock;
 		}
-		/* Valid 2MB page here already, remove it */
-		old = kvmppc_radix_update_pte(kvm, pmdp_ptep(pmd),
-					      ~0UL, 0, lgpa, PMD_SHIFT);
-		kvmppc_radix_tlbie_page(kvm, lgpa, PMD_SHIFT);
-		if (old & _PAGE_DIRTY) {
-			unsigned long gfn = lgpa >> PAGE_SHIFT;
-			struct kvm_memory_slot *memslot;
-			memslot = gfn_to_memslot(kvm, gfn);
-			if (memslot && memslot->dirty_bitmap)
-				kvmppc_update_dirty_map(memslot,
-							gfn, PMD_SIZE);
+		WARN_ON_ONCE(pte_pfn(old_pte) != pte_pfn(pte));
+		if (pte_val(old_pte) == pte_val(pte)) {
+			ret = -EAGAIN;
+			goto out_unlock;
 		}
+
+		/* Valid 2MB page here already, remove it */
+		kvmppc_radix_update_pte(kvm, pmdp_ptep(pmd),
+					0, pte_val(pte), lgpa, PMD_SHIFT);
+		ret = 0;
+		goto out_unlock;
 	} else if (level == 1 && !pmd_none(*pmd)) {
 		/*
 		 * There's a page table page here, but we wanted
@@ -274,6 +274,8 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 		goto out_unlock;
 	}
 	if (level == 0) {
+		pte_t old_pte;
+
 		if (pmd_none(*pmd)) {
 			if (!new_ptep)
 				goto out_unlock;
@@ -281,13 +283,16 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 			new_ptep = NULL;
 		}
 		ptep = pte_offset_kernel(pmd, gpa);
-		if (pte_present(*ptep)) {
+		old_pte = *ptep;
+		if (pte_present(old_pte)) {
 			/* PTE was previously valid, so invalidate it */
-			old = kvmppc_radix_update_pte(kvm, ptep, _PAGE_PRESENT,
-						      0, gpa, 0);
-			kvmppc_radix_tlbie_page(kvm, gpa, 0);
-			if (old & _PAGE_DIRTY)
-				mark_page_dirty(kvm, gpa >> PAGE_SHIFT);
+			WARN_ON_ONCE(pte_pfn(old_pte) != pte_pfn(pte));
+			if (pte_val(old_pte) == pte_val(pte)) {
+				ret = -EAGAIN;
+				goto out_unlock;
+			}
+			kvmppc_radix_update_pte(kvm, ptep, 0,
+						pte_val(pte), gpa, 0);
 		}
 		kvmppc_radix_set_pte_at(kvm, gpa, ptep, pte);
 	} else {
-- 
2.17.0
