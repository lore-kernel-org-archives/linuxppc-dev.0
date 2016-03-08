Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70C7C1A02EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:14 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 24/25] powerpc/kvm: HPT resize pivot
Date: Tue,  8 Mar 2016 14:09:01 +1100
Message-Id: <1457406542-6210-25-git-send-email-david@gibson.dropbear.id.au>
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

This implements the code for HPT resizing to actually pivot from the
currently active HPT to the new HPT, which has previously been populated
by rehashing entries from the old HPT.

This only occurs while the guest is executing the H_RESIZE_HPT_COMMIT
hypercall, handling synchronization with the guest.  On the host side this
is executed under the kvm->mmu_lock to prevent races with host side MMU
notifiers.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index d06aef6..45430fe 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1416,9 +1416,45 @@ static int resize_hpt_rehash(struct kvm_resize_hpt *resize)
 	return H_SUCCESS;
 }
 
+static void resize_hpt_pivot_cpu(void *opaque)
+{
+	/* Nothing to do, just force a KVM exit */
+}
+
 static void resize_hpt_pivot(struct kvm_resize_hpt *resize,
 			     struct kvm_memslots *slots)
 {
+	struct kvm *kvm = resize->kvm;
+	struct kvm_memory_slot *memslot;
+	struct kvm_hpt_info hpt_tmp;
+
+	/* Exchange the pending tables in the resize structure with
+	 * the active tables */
+
+	resize_hpt_debug(resize, "PIVOT!\n");
+
+	kvm_for_each_memslot(memslot, slots) {
+		unsigned long *tmp;
+
+		tmp = memslot->arch.rmap;
+		memslot->arch.rmap = resize->rmap[memslot->id];
+		resize->rmap[memslot->id] = tmp;
+	}
+
+	hpt_tmp = kvm->arch.hpt;
+	kvmppc_set_hpt(kvm, &resize->hpt);
+	resize->hpt = hpt_tmp;
+
+	spin_unlock(&kvm->mmu_lock);
+
+	synchronize_srcu_expedited(&kvm->srcu);
+
+	/* Force an exit on every vcpu, to make sure the real SDR1
+	 * gets updated */
+
+	on_each_cpu(resize_hpt_pivot_cpu, NULL, 1);
+
+	spin_lock(&kvm->mmu_lock);
 }
 
 static void resize_hpt_flush_rmaps(struct kvm_resize_hpt *resize,
-- 
2.5.0
