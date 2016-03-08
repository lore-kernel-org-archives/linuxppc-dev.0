Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F3A8A1A02EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:15 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 19/25] powerpc/kbm: Allocations for HPT resizing
Date: Tue,  8 Mar 2016 14:08:56 +1100
Message-Id: <1457406542-6210-20-git-send-email-david@gibson.dropbear.id.au>
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

This adds code to initialize an HPT resize operation, including allocating
a tentative new HPT and reverse maps.  It also includes corresponding code
to free things afterwards.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index ee50e46..d2f04ee 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -68,6 +68,13 @@ struct kvm_resize_hpt {
 	/* Private to the work thread, until RESIZE_HPT_FAILED is set,
 	 * thereafter read-only */
 	int error;
+
+	/* Private to the work thread, until RESIZE_HPT_PREPARED, then
+	 * protected by kvm->mmu_lock until the resize struct is
+	 * unlinked from struct kvm, then private to the work thread
+	 * again */
+	struct kvm_hpt_info hpt;
+	unsigned long *rmap[KVM_USER_MEM_SLOTS];
 };
 
 #ifdef DEBUG_RESIZE_HPT
@@ -1173,6 +1180,31 @@ void kvmppc_unpin_guest_page(struct kvm *kvm, void *va, unsigned long gpa,
 static int resize_hpt_allocate(struct kvm_resize_hpt *resize,
 			       struct kvm_memslots *slots)
 {
+	struct kvm_memory_slot *memslot;
+	int rc;
+
+	rc = kvmppc_allocate_hpt(&resize->hpt, resize->order);
+	if (rc == -ENOMEM)
+		return H_NO_MEM;
+	else if (rc < 0)
+		return H_HARDWARE;
+
+	resize_hpt_debug(resize, "HPT @ 0x%lx\n", resize->hpt.virt);
+
+	kvm_for_each_memslot(memslot, slots) {
+		unsigned long *rmap;
+
+		if (memslot->flags & KVM_MEMSLOT_INVALID)
+			continue;
+
+		rmap = vzalloc(memslot->npages * sizeof(*rmap));
+		if (!rmap)
+			return H_NO_MEM;
+		resize->rmap[memslot->id] = rmap;
+		resize_hpt_debug(resize, "Memslot %d (%lu pages): %p\n",
+				 memslot->id, memslot->npages, rmap);
+	}
+
 	return H_SUCCESS;
 }
 
@@ -1193,6 +1225,13 @@ static void resize_hpt_flush_rmaps(struct kvm_resize_hpt *resize,
 
 static void resize_hpt_free(struct kvm_resize_hpt *resize)
 {
+	int i;
+	if (resize->hpt.virt)
+		kvmppc_free_hpt(&resize->hpt);
+
+	for (i = 0; i < KVM_USER_MEM_SLOTS; i++)
+		if (resize->rmap[i])
+			vfree(resize->rmap[i]);
 }
 
 static void resize_hpt_work(struct work_struct *work)
@@ -1205,6 +1244,9 @@ static void resize_hpt_work(struct work_struct *work)
 
 	resize_hpt_debug(resize, "Starting work, order = %d\n", resize->order);
 
+	memset(&resize->hpt, 0, sizeof(resize->hpt));
+	memset(&resize->rmap, 0, sizeof(resize->rmap));
+
 	mutex_lock(&kvm->arch.resize_hpt_mutex);
 
 	/* Don't want to have memslots change under us */
-- 
2.5.0
