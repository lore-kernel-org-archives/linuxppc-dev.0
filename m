Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C1B01A0311
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:14 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 21/25] powerpc/kvm: Make MMU notifiers HPT resize aware
Date: Tue,  8 Mar 2016 14:08:58 +1100
Message-Id: <1457406542-6210-22-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
References: <1457406542-6210-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While an HPT resize operation is in progress, specifically when a tentative
HPT has been allocated and we are possibly in the middle of populating it
various host side MM events need to be reflected in the tentative resized
HPT as well as the currently active one.

This extends the powerpc KVM MMU notifiers to act on both the active and
tentative HPTs (and reverse maps) when there is an active resize in
progress.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index db070ad..5b84347 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -97,6 +97,17 @@ static void resize_hpt_set_state(struct kvm_resize_hpt *resize,
 	wake_up_all(&kvm->arch.resize_hpt_wq);
 }
 
+static struct kvm_resize_hpt *kvm_active_resize_hpt(struct kvm *kvm)
+{
+	struct kvm_resize_hpt *resize = kvm->arch.resize_hpt;
+
+	if (resize && (resize->state & RESIZE_HPT_PREPARED)
+	    && !(resize->state & RESIZE_HPT_FAILED))
+		return resize;
+
+	return NULL;
+}
+
 static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
 				long pte_index, unsigned long pteh,
 				unsigned long ptel, unsigned long *pte_idx_ret);
@@ -755,6 +766,7 @@ static int kvm_handle_hva_range(struct kvm *kvm,
 	int retval = 0;
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
+	struct kvm_resize_hpt *resize = kvm_active_resize_hpt(kvm);
 
 	slots = kvm_memslots(kvm);
 	kvm_for_each_memslot(memslot, slots) {
@@ -776,6 +788,10 @@ static int kvm_handle_hva_range(struct kvm *kvm,
 		retval |= kvm_handle_hva_range_slot(kvm, &kvm->arch.hpt,
 						    memslot, memslot->arch.rmap,
 						    gfn, gfn_end, handler);
+		if (resize)
+			retval |= kvm_handle_hva_range_slot(kvm, &resize->hpt,
+				memslot, resize->rmap[memslot->id],
+				gfn, gfn_end, handler);
 	}
 
 	return retval;
-- 
2.5.0
