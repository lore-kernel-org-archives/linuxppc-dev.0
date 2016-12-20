Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjRgD4z7yzDwRQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 16:49:12 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	sjitindarsingh@gmail.com
Cc: benh@kernel.crashing.org, thuth@redhat.com, lvivier@redhat.com,
 linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCHv2 08/11] powerpc/kvm: Create kvmppc_unmap_hpte_helper()
Date: Tue, 20 Dec 2016 16:49:04 +1100
Message-Id: <20161220054907.9204-9-david@gibson.dropbear.id.au>
In-Reply-To: <20161220054907.9204-1-david@gibson.dropbear.id.au>
References: <20161220054907.9204-1-david@gibson.dropbear.id.au>
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
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 77 +++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2765d04..74e909a 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -738,13 +738,53 @@ static int kvm_handle_hva(struct kvm *kvm, unsigned long hva,
 	return kvm_handle_hva_range(kvm, hva, hva + 1, handler);
 }
 
+/* Must be called with both HPTE and rmap locked */
+static void kvmppc_unmap_hpte(struct kvm *kvm, unsigned long i,
+			      unsigned long *rmapp, unsigned long gfn)
+{
+	__be64 *hptep = (__be64 *) (kvm->arch.hpt.virt + (i << 4));
+	struct revmap_entry *rev = kvm->arch.hpt.rev;
+	unsigned long j, h;
+	unsigned long ptel, psize, rcbits;
+
+	j = rev[i].forw;
+	if (j == i) {
+		/* chain is now empty */
+		*rmapp &= ~(KVMPPC_RMAP_PRESENT | KVMPPC_RMAP_INDEX);
+	} else {
+		/* remove i from chain */
+		h = rev[i].back;
+		rev[h].forw = j;
+		rev[j].back = h;
+		rev[i].forw = rev[i].back = i;
+		*rmapp = (*rmapp & ~KVMPPC_RMAP_INDEX) | j;
+	}
+
+	/* Now check and modify the HPTE */
+	ptel = rev[i].guest_rpte;
+	psize = hpte_page_size(be64_to_cpu(hptep[0]), ptel);
+	if ((be64_to_cpu(hptep[0]) & HPTE_V_VALID) &&
+	    hpte_rpn(ptel, psize) == gfn) {
+		hptep[0] |= cpu_to_be64(HPTE_V_ABSENT);
+		kvmppc_invalidate_hpte(kvm, hptep, i);
+		hptep[1] &= ~cpu_to_be64(HPTE_R_KEY_HI | HPTE_R_KEY_LO);
+		/* Harvest R and C */
+		rcbits = be64_to_cpu(hptep[1]) & (HPTE_R_R | HPTE_R_C);
+		*rmapp |= rcbits << KVMPPC_RMAP_RC_SHIFT;
+		if (rcbits & HPTE_R_C)
+			kvmppc_update_rmap_change(rmapp, psize);
+		if (rcbits & ~rev[i].guest_rpte) {
+			rev[i].guest_rpte = ptel | rcbits;
+			note_hpte_modification(kvm, &rev[i]);
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
@@ -767,37 +807,8 @@ static int kvm_unmap_rmapp(struct kvm *kvm, unsigned long *rmapp,
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
-			hptep[1] &= ~cpu_to_be64(HPTE_R_KEY_HI | HPTE_R_KEY_LO);
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
2.9.3
