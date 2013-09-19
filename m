Return-Path: <R65777@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CD77E2C0121
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Sep 2013 16:10:54 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <benh@kernel.crashing.org>, <agraf@suse.de>, <paulus@samba.org>,
 <kvm@vger.kernel.org>, <kvm-ppc@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH 5/6 v5] kvm: booke: clear host tlb reference flag on guest tlb
 invalidation
Date: Thu, 19 Sep 2013 11:32:45 +0530
Message-ID: <1379570566-3715-6-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379570566-3715-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On booke, "struct tlbe_ref" contains host tlb mapping information
(pfn: for guest-pfn to pfn, flags: attribute associated with this mapping)
for a guest tlb entry. So when a guest creates a TLB entry then
"struct tlbe_ref" is set to point to valid "pfn" and set attributes in
"flags" field of the above said structure. When a guest TLB entry is
invalidated then flags field of corresponding "struct tlbe_ref" is
updated to point that this is no more valid, also we selectively clear
some other attribute bits, example: if E500_TLB_BITMAP was set then we clear
E500_TLB_BITMAP, if E500_TLB_TLB0 is set then we clear this.

Ideally we should clear complete "flags" as this entry is invalid and does not
have anything to re-used. The other part of the problem is that when we use
the same entry again then also we do not clear (started doing or-ing etc).

So far it was working because the selectively clearing mentioned above
actually clears "flags" what was set during TLB mapping. But the problem
starts coming when we add more attributes to this then we need to selectively
clear them and which is not needed.

This patch we do both
        - Clear "flags" when invalidating;
        - Clear "flags" when reusing same entry later

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v3-> v5
 - New patch (found this issue when doing vfio-pci development)

 arch/powerpc/kvm/e500_mmu_host.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 1c6a9d7..60f5a3c 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -217,7 +217,8 @@ void inval_gtlbe_on_host(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
 		}
 		mb();
 		vcpu_e500->g2h_tlb1_map[esel] = 0;
-		ref->flags &= ~(E500_TLB_BITMAP | E500_TLB_VALID);
+		/* Clear flags as TLB is not backed by the host anymore */
+		ref->flags = 0;
 		local_irq_restore(flags);
 	}
 
@@ -227,7 +228,8 @@ void inval_gtlbe_on_host(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
 		 * rarely and is not worth optimizing. Invalidate everything.
 		 */
 		kvmppc_e500_tlbil_all(vcpu_e500);
-		ref->flags &= ~(E500_TLB_TLB0 | E500_TLB_VALID);
+		/* Clear flags as TLB is not backed by the host anymore */
+		ref->flags = 0;
 	}
 
 	/* Already invalidated in between */
@@ -237,8 +239,8 @@ void inval_gtlbe_on_host(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
 	/* Guest tlbe is backed by at most one host tlbe per shadow pid. */
 	kvmppc_e500_tlbil_one(vcpu_e500, gtlbe);
 
-	/* Mark the TLB as not backed by the host anymore */
-	ref->flags &= ~E500_TLB_VALID;
+	/* Clear flags as TLB is not backed by the host anymore */
+	ref->flags = 0;
 }
 
 static inline int tlbe_is_writable(struct kvm_book3e_206_tlb_entry *tlbe)
@@ -251,7 +253,7 @@ static inline void kvmppc_e500_ref_setup(struct tlbe_ref *ref,
 					 pfn_t pfn)
 {
 	ref->pfn = pfn;
-	ref->flags |= E500_TLB_VALID;
+	ref->flags = E500_TLB_VALID;
 
 	if (tlbe_is_writable(gtlbe))
 		kvm_set_pfn_dirty(pfn);
-- 
1.7.0.4
