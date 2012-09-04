Return-Path: <aik@ozlabs.ru>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
 [209.85.210.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 01B002C0426
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Sep 2012 17:36:35 +1000 (EST)
Received: by iage36 with SMTP id e36so8145055iag.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2012 00:36:33 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc-kvm: fixing page alignment for TCE
Date: Tue,  4 Sep 2012 17:36:27 +1000
Message-Id: <1346744187-31226-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
References: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

TODO: ask Paul to make a proper message.

This is the fix for a host kernel compiled with a page size
other than 4K (TCE page size). In the case of a 64K page size,
the host used to lose address bits in hpte_rpn().
The patch fixes it.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 80a5775..a41f11b 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -503,7 +503,7 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	struct kvm *kvm = vcpu->kvm;
 	unsigned long *hptep, hpte[3], r;
 	unsigned long mmu_seq, psize, pte_size;
-	unsigned long gfn, hva, pfn;
+	unsigned long gpa, gfn, hva, pfn;
 	struct kvm_memory_slot *memslot;
 	unsigned long *rmap;
 	struct revmap_entry *rev;
@@ -541,15 +541,14 @@ int kvmppc_book3s_hv_page_fault(struct kvm_run *run, struct kvm_vcpu *vcpu,
 
 	/* Translate the logical address and get the page */
 	psize = hpte_page_size(hpte[0], r);
-	gfn = hpte_rpn(r, psize);
+	gpa = (r & HPTE_R_RPN & ~(psize - 1)) | (ea & (psize - 1));
+	gfn = gpa >> PAGE_SHIFT;
 	memslot = gfn_to_memslot(kvm, gfn);
 
 	/* No memslot means it's an emulated MMIO region */
-	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID)) {
-		unsigned long gpa = (gfn << PAGE_SHIFT) | (ea & (psize - 1));
+	if (!memslot || (memslot->flags & KVM_MEMSLOT_INVALID))
 		return kvmppc_hv_emulate_mmio(run, vcpu, gpa, ea,
 					      dsisr & DSISR_ISSTORE);
-	}
 
 	if (!kvm->arch.using_mmu_notifiers)
 		return -EFAULT;		/* should never get here */
-- 
1.7.10.4
