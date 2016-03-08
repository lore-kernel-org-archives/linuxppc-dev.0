Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6513C1A02EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 14:09:15 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv2 20/25] powerpc/kvm: Make MMU notifier handlers more flexible
Date: Tue,  8 Mar 2016 14:08:57 +1100
Message-Id: <1457406542-6210-21-git-send-email-david@gibson.dropbear.id.au>
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

KVM on powerpc uses several MMU notifiers to update guest page tables and
reverse mappings based on host MM events.  At these always act on the
guest's main active hash table and reverse mappings.

However, for HPT resizing we're going to need these to sometimes operate
on a tentative hash table or reverse mapping for an in-progress or
recently completed resize.

To allow that, extend the MMU notifier helper functions to take extra
parameters for the HPT to operate on.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 65 +++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index d2f04ee..db070ad 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -720,14 +720,38 @@ static void kvmppc_rmap_reset(struct kvm *kvm)
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 }
 
+static int kvm_handle_hva_range_slot(struct kvm *kvm,
+				     struct kvm_hpt_info *hpt,
+				     struct kvm_memory_slot *memslot,
+				     unsigned long *rmap,
+				     gfn_t gfn_start, gfn_t gfn_end,
+				     int (*handler)(struct kvm *kvm,
+						    struct kvm_hpt_info *hpt,
+						    unsigned long *rmapp,
+						    unsigned long gfn))
+{
+	int ret;
+	int retval = 0;
+	gfn_t gfn;
+
+	for (gfn = gfn_start; gfn < gfn_end; ++gfn) {
+		gfn_t gfn_offset = gfn - memslot->base_gfn;
+
+		ret = handler(kvm, hpt, &rmap[gfn_offset], gfn);
+		retval |= ret;
+	}
+
+	return retval;
+}
+
 static int kvm_handle_hva_range(struct kvm *kvm,
 				unsigned long start,
 				unsigned long end,
 				int (*handler)(struct kvm *kvm,
+					       struct kvm_hpt_info *hpt,
 					       unsigned long *rmapp,
 					       unsigned long gfn))
 {
-	int ret;
 	int retval = 0;
 	struct kvm_memslots *slots;
 	struct kvm_memory_slot *memslot;
@@ -749,28 +773,27 @@ static int kvm_handle_hva_range(struct kvm *kvm,
 		gfn = hva_to_gfn_memslot(hva_start, memslot);
 		gfn_end = hva_to_gfn_memslot(hva_end + PAGE_SIZE - 1, memslot);
 
-		for (; gfn < gfn_end; ++gfn) {
-			gfn_t gfn_offset = gfn - memslot->base_gfn;
-
-			ret = handler(kvm, &memslot->arch.rmap[gfn_offset], gfn);
-			retval |= ret;
-		}
+		retval |= kvm_handle_hva_range_slot(kvm, &kvm->arch.hpt,
+						    memslot, memslot->arch.rmap,
+						    gfn, gfn_end, handler);
 	}
 
 	return retval;
 }
 
 static int kvm_handle_hva(struct kvm *kvm, unsigned long hva,
-			  int (*handler)(struct kvm *kvm, unsigned long *rmapp,
+			  int (*handler)(struct kvm *kvm,
+					 struct kvm_hpt_info *hpt,
+					 unsigned long *rmapp,
 					 unsigned long gfn))
 {
 	return kvm_handle_hva_range(kvm, hva, hva + 1, handler);
 }
 
-static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
-			   unsigned long gfn)
+static int kvm_unmap_rmapp(struct kvm *kvm, struct kvm_hpt_info *hpt,
+			   unsigned long *rmapp, unsigned long gfn)
 {
-	struct revmap_entry *rev = kvm->arch.hpt.rev;
+	struct revmap_entry *rev = hpt->rev;
 	unsigned long h, i, j;
 	__be64 *hptep;
 	unsigned long ptel, psize, rcbits;
@@ -788,7 +811,7 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 		 * rmap chain lock.
 		 */
 		i = *rmapp & KVMPPC_RMAP_INDEX;
-		hptep = (__be64 *) (kvm->arch.hpt.virt + (i << 4));
+		hptep = (__be64 *) (hpt->virt + (i << 4));
 		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
 			/* unlock rmap before spinning on the HPTE lock */
 			unlock_rmap(rmapp);
@@ -861,16 +884,16 @@ void kvmppc_core_flush_memslot_hv(struct kvm *kvm,
 		 * thus the present bit can't go from 0 to 1.
 		 */
 		if (*rmapp & KVMPPC_RMAP_PRESENT)
-			kvm_unmap_rmapp(kvm, rmapp, gfn);
+			kvm_unmap_rmapp(kvm, &kvm->arch.hpt, rmapp, gfn);
 		++rmapp;
 		++gfn;
 	}
 }
 
-static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
-			 unsigned long gfn)
+static int kvm_age_rmapp(struct kvm *kvm, struct kvm_hpt_info *hpt,
+			 unsigned long *rmapp, unsigned long gfn)
 {
-	struct revmap_entry *rev = kvm->arch.hpt.rev;
+	struct revmap_entry *rev = hpt->rev;
 	unsigned long head, i, j;
 	__be64 *hptep;
 	int ret = 0;
@@ -888,7 +911,7 @@ static int kvm_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 
 	i = head = *rmapp & KVMPPC_RMAP_INDEX;
 	do {
-		hptep = (__be64 *) (kvm->arch.hpt.virt + (i << 4));
+		hptep = (__be64 *) (hpt->virt + (i << 4));
 		j = rev[i].forw;
 
 		/* If this HPTE isn't referenced, ignore it */
@@ -925,10 +948,10 @@ int kvm_age_hva_hv(struct kvm *kvm, unsigned long start, unsigned long end)
 	return kvm_handle_hva_range(kvm, start, end, kvm_age_rmapp);
 }
 
-static int kvm_test_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
-			      unsigned long gfn)
+static int kvm_test_age_rmapp(struct kvm *kvm, struct kvm_hpt_info *hpt,
+			      unsigned long *rmapp, unsigned long gfn)
 {
-	struct revmap_entry *rev = kvm->arch.hpt.rev;
+	struct revmap_entry *rev = hpt->rev;
 	unsigned long head, i, j;
 	unsigned long *hp;
 	int ret = 1;
@@ -943,7 +966,7 @@ static int kvm_test_age_rmapp(struct kvm *kvm, unsigned long *rmapp,
 	if (*rmapp & KVMPPC_RMAP_PRESENT) {
 		i = head = *rmapp & KVMPPC_RMAP_INDEX;
 		do {
-			hp = (unsigned long *)(kvm->arch.hpt.virt + (i << 4));
+			hp = (unsigned long *)(hpt->virt + (i << 4));
 			j = rev[i].forw;
 			if (be64_to_cpu(hp[1]) & HPTE_R_R)
 				goto out;
-- 
2.5.0
