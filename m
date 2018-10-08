Return-Path: <SRS0=rj9n=MU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14849C64EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:14:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4822086D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 06:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="SnBNNYsG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4822086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42T9702yq5zF1nb
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Oct 2018 17:14:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="SnBNNYsG";
	dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42T89r5t0bzF37f
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Oct 2018 16:31:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="SnBNNYsG"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 42T89p6TYKz9sCV; Mon,  8 Oct 2018 16:31:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42T89p29xBzB4NX;
 Mon,  8 Oct 2018 16:31:42 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1538976702; bh=/3SdPyHOgzFfdGZjSttxsKegQKsjarW3w8x8LJD5yHE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SnBNNYsGxLHgx+rLzltfvLYzRSz7vEiDVSL7Qz7qOue6qj6rwVfYNjjHrB5cbVPgq
 ax72CK0dtvX1YqXU9d7uswGI/nmwUm9JCZCIdculC8nNFSkNdN0vYXsQmNnRWEpcw2
 LA3UabU3TfwO/I2SCTXyK3FvnkIVdtZ3S4ST25Ptpa3jK8jva+C2i/ZaLIjCM/V4TP
 XNQh8QjYPMEIjkLsWLK+kqMYPSRIxbbTnR42uoc1v6WpIeF9YngeC+x64JMSTMa4++
 776trpUfk+DA965R+biffzlkhI8CzNSfJ4OhTe1hxr0pXbjgWuPAAwhKrgudTYDBuY
 8UP8dSWSLWmsw==
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH v5 15/33] KVM: PPC: Book3S HV: Refactor radix page fault
 handler
Date: Mon,  8 Oct 2018 16:31:01 +1100
Message-Id: <1538976679-1363-16-git-send-email-paulus@ozlabs.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
References: <1538976679-1363-1-git-send-email-paulus@ozlabs.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The radix page fault handler accounts for all cases, including just
needing to insert a pte.  This breaks it up into separate functions for
the two main cases; setting rc and inserting a pte.

This allows us to make the setting of rc and inserting of a pte
generic for any pgtable, not specific to the one for this guest.

[paulus@ozlabs.org - reduced diffs from previous code]

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_64_mmu_radix.c | 210 +++++++++++++++++++--------------
 1 file changed, 123 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index f2976f4..47f2b18 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -400,8 +400,9 @@ static void kvmppc_unmap_free_pud_entry_table(struct kvm *kvm, pud_t *pud,
  */
 #define PTE_BITS_MUST_MATCH (~(_PAGE_WRITE | _PAGE_DIRTY | _PAGE_ACCESSED))
 
-static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
-			     unsigned int level, unsigned long mmu_seq)
+static int kvmppc_create_pte(struct kvm *kvm, pgd_t *pgtable, pte_t pte,
+			     unsigned long gpa, unsigned int level,
+			     unsigned long mmu_seq)
 {
 	pgd_t *pgd;
 	pud_t *pud, *new_pud = NULL;
@@ -410,7 +411,7 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 	int ret;
 
 	/* Traverse the guest's 2nd-level tree, allocate new levels needed */
-	pgd = kvm->arch.pgtable + pgd_index(gpa);
+	pgd = pgtable + pgd_index(gpa);
 	pud = NULL;
 	if (pgd_present(*pgd))
 		pud = pud_offset(pgd, gpa);
@@ -565,95 +566,49 @@ static int kvmppc_create_pte(struct kvm *kvm, pte_t pte, unsigned long gpa,
 	return ret;
 }
 
-int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
-				   unsigned long ea, unsigned long dsisr)
+static bool kvmppc_hv_handle_set_rc(struct kvm *kvm, pgd_t *pgtable,
+				    bool writing, unsigned long gpa)
+{
+	unsigned long pgflags;
+	unsigned int shift;
+	pte_t *ptep;
+
+	/*
+	 * Need to set an R or C bit in the 2nd-level tables;
+	 * since we are just helping out the hardware here,
+	 * it is sufficient to do what the hardware does.
+	 */
+	pgflags = _PAGE_ACCESSED;
+	if (writing)
+		pgflags |= _PAGE_DIRTY;
+	/*
+	 * We are walking the secondary (partition-scoped) page table here.
+	 * We can do this without disabling irq because the Linux MM
+	 * subsystem doesn't do THP splits and collapses on this tree.
+	 */
+	ptep = __find_linux_pte(pgtable, gpa, NULL, &shift);
+	if (ptep && pte_present(*ptep) && (!writing || pte_write(*ptep))) {
+		kvmppc_radix_update_pte(kvm, ptep, 0, pgflags, gpa, shift);
+		return true;
+	}
+	return false;
+}
+
+static int kvmppc_book3s_instantiate_page(struct kvm_vcpu *vcpu,
+				unsigned long gpa,
+				struct kvm_memory_slot *memslot,
+				bool writing, bool kvm_ro,
+				pte_t *inserted_pte, unsigned int *levelp)
 {
 	struct kvm *kvm = vcpu->kvm;
-	unsigned long mmu_seq;
-	unsigned long gpa, gfn, hva;
-	struct kvm_memory_slot *memslot;
 	struct page *page = NULL;
-	long ret;
-	bool writing;
+	unsigned long mmu_seq;
+	unsigned long hva, gfn = gpa >> PAGE_SHIFT;
 	bool upgrade_write = false;
 	bool *upgrade_p = &upgrade_write;
 	pte_t pte, *ptep;
-	unsigned long pgflags;
 	unsigned int shift, level;
-
-	/* Check for unusual errors */
-	if (dsisr & DSISR_UNSUPP_MMU) {
-		pr_err("KVM: Got unsupported MMU fault\n");
-		return -EFAULT;
-	}
-	if (dsisr & DSISR_BADACCESS) {
-		/* Reflect to the guest as DSI */
-		pr_err("KVM: Got radix HV page fault with DSISR=%lx\n", dsisr);
-		kvmppc_core_queue_data_storage(vcpu, ea, dsisr);
-		return RESUME_GUEST;
-	}
-
-	/* Translate the logical address and get the page */
-	gpa = vcpu->arch.fault_gpa & ~0xfffUL;
-	gpa &= ~0xF000000000000000ul;
-	gfn = gpa >> PAGE_SHIFT;
-	if (!(dsisr & DSISR_PRTABLE_FAULT))
-		gpa |= ea & 0xfff;
-	memslot = gfn_to_memslot(kvm, gfn);
-
-	/* No memslot means it's an emulated MMIO region */
-	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID)) {
-		if (dsisr & (DSISR_PRTABLE_FAULT | DSISR_BADACCESS |
-			     DSISR_SET_RC)) {
-			/*
-			 * Bad address in guest page table tree, or other
-			 * unusual error - reflect it to the guest as DSI.
-			 */
-			kvmppc_core_queue_data_storage(vcpu, ea, dsisr);
-			return RESUME_GUEST;
-		}
-		return kvmppc_hv_emulate_mmio(run, vcpu, gpa, ea,
-					      dsisr & DSISR_ISSTORE);
-	}
-
-	writing = (dsisr & DSISR_ISSTORE) != 0;
-	if (memslot->flags & KVM_MEM_READONLY) {
-		if (writing) {
-			/* give the guest a DSI */
-			dsisr = DSISR_ISSTORE | DSISR_PROTFAULT;
-			kvmppc_core_queue_data_storage(vcpu, ea, dsisr);
-			return RESUME_GUEST;
-		}
-		upgrade_p = NULL;
-	}
-
-	if (dsisr & DSISR_SET_RC) {
-		/*
-		 * Need to set an R or C bit in the 2nd-level tables;
-		 * since we are just helping out the hardware here,
-		 * it is sufficient to do what the hardware does.
-		 */
-		pgflags = _PAGE_ACCESSED;
-		if (writing)
-			pgflags |= _PAGE_DIRTY;
-		/*
-		 * We are walking the secondary page table here. We can do this
-		 * without disabling irq.
-		 */
-		spin_lock(&kvm->mmu_lock);
-		ptep = __find_linux_pte(kvm->arch.pgtable,
-					gpa, NULL, &shift);
-		if (ptep && pte_present(*ptep) &&
-		    (!writing || pte_write(*ptep))) {
-			kvmppc_radix_update_pte(kvm, ptep, 0, pgflags,
-						gpa, shift);
-			dsisr &= ~DSISR_SET_RC;
-		}
-		spin_unlock(&kvm->mmu_lock);
-		if (!(dsisr & (DSISR_BAD_FAULT_64S | DSISR_NOHPTE |
-			       DSISR_PROTFAULT | DSISR_SET_RC)))
-			return RESUME_GUEST;
-	}
+	int ret;
 
 	/* used to check for invalidations in progress */
 	mmu_seq = kvm->mmu_notifier_seq;
@@ -666,7 +621,7 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	 * is that the page is writable.
 	 */
 	hva = gfn_to_hva_memslot(memslot, gfn);
-	if (upgrade_p && __get_user_pages_fast(hva, 1, 1, &page) == 1) {
+	if (!kvm_ro && __get_user_pages_fast(hva, 1, 1, &page) == 1) {
 		upgrade_write = true;
 	} else {
 		unsigned long pfn;
@@ -724,7 +679,12 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	}
 
 	/* Allocate space in the tree and write the PTE */
-	ret = kvmppc_create_pte(kvm, pte, gpa, level, mmu_seq);
+	ret = kvmppc_create_pte(kvm, kvm->arch.pgtable, pte, gpa, level,
+				mmu_seq);
+	if (inserted_pte)
+		*inserted_pte = pte;
+	if (levelp)
+		*levelp = level;
 
 	if (page) {
 		if (!ret && (pte_val(pte) & _PAGE_WRITE))
@@ -732,6 +692,82 @@ int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		put_page(page);
 	}
 
+	return ret;
+}
+
+int kvmppc_book3s_radix_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
+				   unsigned long ea, unsigned long dsisr)
+{
+	struct kvm *kvm = vcpu->kvm;
+	unsigned long gpa, gfn;
+	struct kvm_memory_slot *memslot;
+	long ret;
+	bool writing = !!(dsisr & DSISR_ISSTORE);
+	bool kvm_ro = false;
+
+	/* Check for unusual errors */
+	if (dsisr & DSISR_UNSUPP_MMU) {
+		pr_err("KVM: Got unsupported MMU fault\n");
+		return -EFAULT;
+	}
+	if (dsisr & DSISR_BADACCESS) {
+		/* Reflect to the guest as DSI */
+		pr_err("KVM: Got radix HV page fault with DSISR=%lx\n", dsisr);
+		kvmppc_core_queue_data_storage(vcpu, ea, dsisr);
+		return RESUME_GUEST;
+	}
+
+	/* Translate the logical address */
+	gpa = vcpu->arch.fault_gpa & ~0xfffUL;
+	gpa &= ~0xF000000000000000ul;
+	gfn = gpa >> PAGE_SHIFT;
+	if (!(dsisr & DSISR_PRTABLE_FAULT))
+		gpa |= ea & 0xfff;
+
+	/* Get the corresponding memslot */
+	memslot = gfn_to_memslot(kvm, gfn);
+
+	/* No memslot means it's an emulated MMIO region */
+	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID)) {
+		if (dsisr & (DSISR_PRTABLE_FAULT | DSISR_BADACCESS |
+			     DSISR_SET_RC)) {
+			/*
+			 * Bad address in guest page table tree, or other
+			 * unusual error - reflect it to the guest as DSI.
+			 */
+			kvmppc_core_queue_data_storage(vcpu, ea, dsisr);
+			return RESUME_GUEST;
+		}
+		return kvmppc_hv_emulate_mmio(run, vcpu, gpa, ea, writing);
+	}
+
+	if (memslot->flags & KVM_MEM_READONLY) {
+		if (writing) {
+			/* give the guest a DSI */
+			kvmppc_core_queue_data_storage(vcpu, ea, DSISR_ISSTORE |
+						       DSISR_PROTFAULT);
+			return RESUME_GUEST;
+		}
+		kvm_ro = true;
+	}
+
+	/* Failed to set the reference/change bits */
+	if (dsisr & DSISR_SET_RC) {
+		spin_lock(&kvm->mmu_lock);
+		if (kvmppc_hv_handle_set_rc(kvm, kvm->arch.pgtable,
+					    writing, gpa))
+			dsisr &= ~DSISR_SET_RC;
+		spin_unlock(&kvm->mmu_lock);
+
+		if (!(dsisr & (DSISR_BAD_FAULT_64S | DSISR_NOHPTE |
+			       DSISR_PROTFAULT | DSISR_SET_RC)))
+			return RESUME_GUEST;
+	}
+
+	/* Try to insert a pte */
+	ret = kvmppc_book3s_instantiate_page(vcpu, gpa, memslot, writing,
+					     kvm_ro, NULL, NULL);
+
 	if (ret == 0 || ret == -EAGAIN)
 		ret = RESUME_GUEST;
 	return ret;
-- 
2.7.4

