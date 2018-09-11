Return-Path: <npiggin@gmail.com>
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 428hV55PNFzF37p
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 20:48:45 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id w14-v6so11149377plp.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Sep 2018 03:48:45 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: kvm-ppc@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@ozlabs.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] KVM: PPC: Book3S HV: Don't use compound_order to determine
 host mapping size
Date: Tue, 11 Sep 2018 20:48:34 +1000
Message-Id: <20180911104834.11041-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

THP paths can defer splitting compound pages until after the actual
remap and TLB flushes to split a huge PMD/PUD. This causes radix
partition scope page table mappings to get out of synch with the host
qemu page table mappings.

This results in random memory corruption in the guest when running
with THP. The easiest way to reproduce is use KVM baloon to free up
a lot of memory in the guest and then shrink the balloon to give the
memory back, while some work is being done in the guest.

Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
v2: fold in unaligned case bugfix

 arch/powerpc/kvm/book3s_64_mmu_radix.c | 91 +++++++++++---------------
 1 file changed, 37 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 0af1c0aea1fe..f85e15700355 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -525,8 +525,8 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 				   unsigned long ea, unsigned long dsisr)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long mmu_seq, pte_size;
-	unsigned long gpa, gfn, hva, pfn;
+	unsigned long mmu_seq;
+	unsigned long gpa, gfn, hva;
 	struct kvm_memory_slot *memslot;
 	struct page *page = NULL;
 	long ret;
@@ -623,9 +623,10 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 */
 	hva = gfn_to_hva_memslot(memslot, gfn);
 	if (upgrade_p && __get_user_pages_fast(hva, 1, 1, &page) == 1) {
-		pfn = page_to_pfn(page);
 		upgrade_write = true;
 	} else {
+		unsigned long pfn;
+
 		/* Call KVM generic code to do the slow-path check */
 		pfn = __gfn_to_pfn_memslot(memslot, gfn, false, NULL,
 					   writing, upgrade_p);
@@ -639,63 +640,45 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		}
 	}
 
-	/* See if we can insert a 1GB or 2MB large PTE here */
-	level = 0;
-	if (page && PageCompound(page)) {
-		pte_size = PAGE_SIZE << compound_order(compound_head(page));
-		if (pte_size >= PUD_SIZE &&
-		    (gpa & (PUD_SIZE - PAGE_SIZE)) ==
-		    (hva & (PUD_SIZE - PAGE_SIZE))) {
-			level = 2;
-			pfn &= ~((PUD_SIZE >> PAGE_SHIFT) - 1);
-		} else if (pte_size >= PMD_SIZE &&
-			   (gpa & (PMD_SIZE - PAGE_SIZE)) ==
-			   (hva & (PMD_SIZE - PAGE_SIZE))) {
-			level = 1;
-			pfn &= ~((PMD_SIZE >> PAGE_SHIFT) - 1);
-		}
-	}
-
 	/*
-	 * Compute the PTE value that we need to insert.
+	 * Read the PTE from the process' radix tree and use that
+	 * so we get the shift and attribute bits.
 	 */
-	if (page) {
-		pgflags = _PAGE_READ | _PAGE_EXEC | _PAGE_PRESENT | _PAGE_PTE |
-			_PAGE_ACCESSED;
-		if (writing || upgrade_write)
-			pgflags |= _PAGE_WRITE | _PAGE_DIRTY;
-		pte = pfn_pte(pfn, __pgprot(pgflags));
+	local_irq_disable();
+	ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
+	pte = *ptep;
+	local_irq_enable();
+
+	/* Get pte level from shift/size */
+	if (shift == PUD_SHIFT &&
+	    (gpa & (PUD_SIZE - PAGE_SIZE)) ==
+	    (hva & (PUD_SIZE - PAGE_SIZE))) {
+		level = 2;
+	} else if (shift == PMD_SHIFT &&
+		   (gpa & (PMD_SIZE - PAGE_SIZE)) ==
+		   (hva & (PMD_SIZE - PAGE_SIZE))) {
+		level = 1;
 	} else {
-		/*
-		 * Read the PTE from the process' radix tree and use that
-		 * so we get the attribute bits.
-		 */
-		local_irq_disable();
-		ptep = __find_linux_pte(vcpu->arch.pgdir, hva, NULL, &shift);
-		pte = *ptep;
-		local_irq_enable();
-		if (shift == PUD_SHIFT &&
-		    (gpa & (PUD_SIZE - PAGE_SIZE)) ==
-		    (hva & (PUD_SIZE - PAGE_SIZE))) {
-			level = 2;
-		} else if (shift == PMD_SHIFT &&
-			   (gpa & (PMD_SIZE - PAGE_SIZE)) ==
-			   (hva & (PMD_SIZE - PAGE_SIZE))) {
-			level = 1;
-		} else if (shift && shift != PAGE_SHIFT) {
-			/* Adjust PFN */
-			unsigned long mask = (1ul << shift) - PAGE_SIZE;
-			pte = __pte(pte_val(pte) | (hva & mask));
-		}
-		pte = __pte(pte_val(pte) | _PAGE_EXEC | _PAGE_ACCESSED);
-		if (writing || upgrade_write) {
-			if (pte_val(pte) & _PAGE_WRITE)
-				pte = __pte(pte_val(pte) | _PAGE_DIRTY);
-		} else {
-			pte = __pte(pte_val(pte) & ~(_PAGE_WRITE | _PAGE_DIRTY));
+		level = 0;
+		if (shift > PAGE_SHIFT) {
+			/*
+			 * If the pte maps more than one page, bring over
+			 * bits from the virtual address to get the real
+			 * address of the specific single page we want.
+			 */
+			unsigned long rpnmask = (1ul << shift) - PAGE_SIZE;
+			pte = __pte(pte_val(pte) | (hva & rpnmask));
 		}
 	}
 
+	pte = __pte(pte_val(pte) | _PAGE_EXEC | _PAGE_ACCESSED);
+	if (writing || upgrade_write) {
+		if (pte_val(pte) & _PAGE_WRITE)
+			pte = __pte(pte_val(pte) | _PAGE_DIRTY);
+	} else {
+		pte = __pte(pte_val(pte) & ~(_PAGE_WRITE | _PAGE_DIRTY));
+	}
+
 	/* Allocate space in the tree and write the PTE */
 	ret = kvmppc_create_pte(kvm, pte, gpa, level, mmu_seq);
 
-- 
2.18.0
