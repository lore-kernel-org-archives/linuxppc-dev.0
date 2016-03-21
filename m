Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qT22r0brMzDq7K
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Mar 2016 14:52:20 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 michael@ellerman.id.au, David Gibson <david@gibson.dropbear.id.au>
Subject: [RFCv3 12/17] powerpc/kvm: Create kvmppc_unmap_hpte_helper()
Date: Mon, 21 Mar 2016 14:53:19 +1100
Message-Id: <1458532404-21258-13-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
References: <1458532404-21258-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The kvm_unmap_rmapp() function, called from certain MMU notifiers, is used
to force all guest mappings of a particular host page to be set ABSENT, and
removed from the reverse mappings.

For HPT resizing, we will have some cases where we want to set just a
single guest HPTE ABSENT and remove its reverse mappings.  To prepare with
this, we split out the logic from kvm_unmap_rmapp() to evict a single HPTE,
moving it to a new helper function.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 75 +++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index e975c5a..89878a4 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -710,13 +710,52 @@ static int kvm_handle_hva(struct kvm *kvm, unsigned long hva,
 	return kvm_handle_hva_range(kvm, hva, hva + 1, handler);
 }
 
+/* Must be called with both HPTE and rmap locked */
+static void kvmppc_unmap_hpte(struct kvm *kvm, unsigned long idx,
+			      unsigned long *rmapp, unsigned long gfn)
+{
+	__be64 *hptep = (__be64 *) (kvm->arch.hpt.virt + (idx << 4));
+	struct revmap_entry *rev = kvm->arch.hpt.rev;
+	unsigned long j, h;
+	unsigned long ptel, psize, rcbits;
+
+	j = rev[idx].forw;
+	if (j == idx) {
+		/* chain is now empty */
+		*rmapp &= ~(KVMPPC_RMAP_PRESENT | KVMPPC_RMAP_INDEX);
+	} else {
+		/* remove idx from chain */
+		h = rev[idx].back;
+		rev[h].forw = j;
+		rev[j].back = h;
+		rev[idx].forw = rev[idx].back = idx;
+		*rmapp = (*rmapp & ~KVMPPC_RMAP_INDEX) | j;
+	}
+
+	/* Now check and modify the HPTE */
+	ptel = rev[idx].guest_rpte;
+	psize = hpte_page_size(be64_to_cpu(hptep[0]), ptel);
+	if ((be64_to_cpu(hptep[0]) & HPTE_V_VALID) &&
+	    hpte_rpn(ptel, psize) == gfn) {
+		hptep[0] |= cpu_to_be64(HPTE_V_ABSENT);
+		kvmppc_invalidate_hpte(kvm, hptep, idx);
+		/* Harvest R and C */
+		rcbits = be64_to_cpu(hptep[1]) & (HPTE_R_R | HPTE_R_C);
+		*rmapp |= rcbits << KVMPPC_RMAP_RC_SHIFT;
+		if (rcbits & HPTE_R_C)
+			kvmppc_update_rmap_change(rmapp, psize);
+		if (rcbits & ~rev[idx].guest_rpte) {
+			rev[idx].guest_rpte = ptel | rcbits;
+			note_hpte_modification(kvm, &rev[idx]);
+		}
+	}
+}
+
 static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 			   unsigned long gfn)
 {
-	struct revmap_entry *rev = kvm->arch.hpt.rev;
-	unsigned long h, i, j;
+	unsigned long i;
 	__be64 *hptep;
-	unsigned long ptel, psize, rcbits;
 
 	for (;;) {
 		lock_rmap(rmapp);
@@ -739,36 +778,8 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
 				cpu_relax();
 			continue;
 		}
-		j = rev[i].forw;
-		if (j == i) {
-			/* chain is now empty */
-			*rmapp &= ~(KVMPPC_RMAP_PRESENT | KVMPPC_RMAP_INDEX);
-		} else {
-			/* remove i from chain */
-			h = rev[i].back;
-			rev[h].forw = j;
-			rev[j].back = h;
-			rev[i].forw = rev[i].back = i;
-			*rmapp = (*rmapp & ~KVMPPC_RMAP_INDEX) | j;
-		}
 
-		/* Now check and modify the HPTE */
-		ptel = rev[i].guest_rpte;
-		psize = hpte_page_size(be64_to_cpu(hptep[0]), ptel);
-		if ((be64_to_cpu(hptep[0]) & HPTE_V_VALID) &&
-		    hpte_rpn(ptel, psize) == gfn) {
-			hptep[0] |= cpu_to_be64(HPTE_V_ABSENT);
-			kvmppc_invalidate_hpte(kvm, hptep, i);
-			/* Harvest R and C */
-			rcbits = be64_to_cpu(hptep[1]) & (HPTE_R_R | HPTE_R_C);
-			*rmapp |= rcbits << KVMPPC_RMAP_RC_SHIFT;
-			if (rcbits & HPTE_R_C)
-				kvmppc_update_rmap_change(rmapp, psize);
-			if (rcbits & ~rev[i].guest_rpte) {
-				rev[i].guest_rpte = ptel | rcbits;
-				note_hpte_modification(kvm, &rev[i]);
-			}
-		}
+		kvmppc_unmap_hpte(kvm, i, rmapp, gfn);
 		unlock_rmap(rmapp);
 		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
 	}
-- 
2.5.0
