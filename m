Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4025E1A0341
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:20 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 25/25] powerpc/kvm: Harvest RC bits from old HPT after HPT
 resize
Date: Tue,  8 Mar 2016 14:09:02 +1100
Message-Id: <1457406542-6210-26-git-send-email-david@gibson.dropbear.id.au>
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

During an HPT resize operation we have two HPTs and sets of reverse maps
for the guest: the active one, and the tentative resized one.  This means
that information about a host page's referenced / dirty state as affected
by the guest could end up in either HPT depending on exactly what moment
it happens at.

During the transition we handle this by having things which need this
information consult both the new and old HPTs.  However, in order to clean
things up after, we need to harvest any such information left over in the
old tables and store it in the new ones.

This implements this, first harvesting R & C bits from the old HPT into
the old rmaps, then folding that information into the new (now current)
rmaps.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 57 +++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 45430fe..f132f86 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1457,9 +1457,66 @@ static void resize_hpt_pivot(struct kvm_resize_hpt *resize,
 	spin_lock(&kvm->mmu_lock);
 }
 
+static void resize_hpt_harvest_rc(struct kvm_hpt_info *hpt,
+				  unsigned long *rmapp)
+{
+	unsigned long idx;
+
+	if (!(*rmapp & KVMPPC_RMAP_PRESENT))
+		return;
+
+	idx = *rmapp & KVMPPC_RMAP_INDEX;
+	do {
+		struct revmap_entry *rev = &hpt->rev[idx];
+		__be64 *hptep = (__be64 *)(hpt->virt + (idx << 4));
+		unsigned long hpte0 = be64_to_cpu(hptep[0]);
+		unsigned long hpte1 = be64_to_cpu(hptep[1]);
+		unsigned long psize = hpte_page_size(hpte0, hpte1);
+		unsigned long rcbits = hpte1 & (HPTE_R_R | HPTE_R_C);
+
+		*rmapp |= rcbits << KVMPPC_RMAP_RC_SHIFT;
+		if (rcbits & HPTE_R_C)
+			kvmppc_update_rmap_change(rmapp, psize);
+
+		idx = rev->forw;
+	} while (idx != (*rmapp & KVMPPC_RMAP_INDEX));
+}
+
 static void resize_hpt_flush_rmaps(struct kvm_resize_hpt *resize,
 				   struct kvm_memslots *slots)
 {
+	struct kvm_memory_slot *memslot;
+
+	kvm_for_each_memslot(memslot, slots) {
+		unsigned long *old_rmap = resize->rmap[memslot->id];
+		unsigned long *new_rmap = memslot->arch.rmap;
+		unsigned long i;
+
+		resize_hpt_debug(resize, "Flushing RMAPS for memslot %d\n", memslot->id);
+
+		for (i = 0; i < memslot->npages; i++) {
+			lock_rmap(old_rmap);
+
+			resize_hpt_harvest_rc(&resize->hpt, old_rmap);
+
+			lock_rmap(new_rmap);
+
+			*new_rmap |= *old_rmap & (KVMPPC_RMAP_REFERENCED
+						  | KVMPPC_RMAP_CHANGED);
+			if ((*old_rmap & KVMPPC_RMAP_CHG_ORDER)
+			    > (*new_rmap & KVMPPC_RMAP_CHG_ORDER)) {
+				*new_rmap &= ~KVMPPC_RMAP_CHG_ORDER;
+				*new_rmap |= *old_rmap & KVMPPC_RMAP_CHG_ORDER;
+			}
+			unlock_rmap(new_rmap);
+			unlock_rmap(old_rmap);
+
+			old_rmap++;
+			new_rmap++;
+		}
+
+		resize_hpt_debug(resize, "Flushed RMAPS for memslot %d\n", memslot->id);
+	}
 }
 
 static void resize_hpt_free(struct kvm_resize_hpt *resize)
-- 
2.5.0
