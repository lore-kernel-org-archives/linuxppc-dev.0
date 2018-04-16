Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Pb8z46QNzF1sj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 14:33:07 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id p6so9927684pfn.4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 21:33:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 5/5] KVM: PPC: Book3S HV: radix do not clear partition
 scoped page table when page fault races with other vCPUs.
Date: Mon, 16 Apr 2018 14:32:40 +1000
Message-Id: <20180416043240.8796-6-npiggin@gmail.com>
In-Reply-To: <20180416043240.8796-1-npiggin@gmail.com>
References: <20180416043240.8796-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When running a SMP radix guest, KVM can get into page fault / tlbie
storms -- hundreds of thousands to the same address from different
threads -- due to partition scoped page faults invalidating the
page table entry if it was found to be already set up by a racing
CPU.

What can happen is that guest threads can hit page faults for the
same addresses, this can happen when KSM or THP takes out a commonly
used page. gRA zero (the interrupt vectors and important kernel text)
was a common one. Multiple CPUs will page fault and contend on the
same lock, when one CPU sets up the page table and releases the lock,
the next will find the new entry and invalidate it before installing
its own, which causes other page faults which invalidate that entry,
etc.

The solution to this is to avoid invalidating the entry or flushing
TLBs in case of a race. The pte may still need bits updated, but
those are to add R/C or relax access restrictions so no flush is
required.

This solves the page fault / tlbie storms.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 52 ++++++++++++++++----------
 1 file changed, 33 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index dab6b622011c..2d3af22f90dd 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -199,7 +199,6 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 	pud_t *pud, *new_pud = NULL;
 	pmd_t *pmd, *new_pmd = NULL;
 	pte_t *ptep, *new_ptep = NULL;
-	unsigned long old;
 	int ret;
 
 	/* Traverse the guest's 2nd-level tree, allocate new levels needed */
@@ -243,6 +242,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 	pmd = pmd_offset(pud, gpa);
 	if (pmd_is_leaf(*pmd)) {
 		unsigned long lgpa = gpa & PMD_MASK;
+		pte_t old_pte = *pmdp_ptep(pmd);
 
 		/*
 		 * If we raced with another CPU which has just put
@@ -252,18 +252,22 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
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
+
+		/* PTE was previously valid, so update it */
+		if (pte_val(old_pte) == pte_val(pte)) {
+			ret = -EAGAIN;
+			goto out_unlock;
 		}
+
+		/* Make sure we're weren't trying to take bits away */
+		WARN_ON_ONCE(pte_pfn(old_pte) != pte_pfn(pte));
+		WARN_ON_ONCE((pte_val(old_pte) & ~pte_val(pte)) &
+			(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE));
+
+		kvmppc_radix_update_pte(kvm, pmdp_ptep(pmd),
+					0, pte_val(pte), lgpa, PMD_SHIFT);
+		ret = 0;
+		goto out_unlock;
 	} else if (level == 1 && !pmd_none(*pmd)) {
 		/*
 		 * There's a page table page here, but we wanted
@@ -274,6 +278,8 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 		goto out_unlock;
 	}
 	if (level == 0) {
+		pte_t old_pte;
+
 		if (pmd_none(*pmd)) {
 			if (!new_ptep)
 				goto out_unlock;
@@ -281,13 +287,21 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 			new_ptep = NULL;
 		}
 		ptep = pte_offset_kernel(pmd, gpa);
-		if (pte_present(*ptep)) {
-			/* PTE was previously valid, so invalidate it */
-			old = kvmppc_radix_update_pte(kvm, ptep, _PAGE_PRESENT,
-						      0, gpa, 0);
-			kvmppc_radix_tlbie_page(kvm, gpa, 0);
-			if (old & _PAGE_DIRTY)
-				mark_page_dirty(kvm, gpa >> PAGE_SHIFT);
+		old_pte = *ptep;
+		if (pte_present(old_pte)) {
+			/* PTE was previously valid, so update it */
+			if (pte_val(old_pte) == pte_val(pte)) {
+				ret = -EAGAIN;
+				goto out_unlock;
+			}
+
+			/* Make sure we're weren't trying to take bits away */
+			WARN_ON_ONCE(pte_pfn(old_pte) != pte_pfn(pte));
+			WARN_ON_ONCE((pte_val(old_pte) & ~pte_val(pte)) &
+				(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE));
+
+			kvmppc_radix_update_pte(kvm, ptep, 0,
+						pte_val(pte), gpa, 0);
 		}
 		kvmppc_radix_set_pte_at(kvm, gpa, ptep, pte);
 	} else {
-- 
2.17.0
