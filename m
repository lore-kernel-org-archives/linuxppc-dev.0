Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D9EF2B6FE0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 11:10:15 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 08/38] KVM: PPC: e500: clean up arch/powerpc/kvm/e500.h
Date: Wed, 29 Feb 2012 01:09:36 +0100
Message-Id: <1330474206-14794-9-git-send-email-agraf@suse.de>
In-Reply-To: <1330474206-14794-1-git-send-email-agraf@suse.de>
References: <1330474206-14794-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

Move vcpu to the beginning of vcpu_e500 to give it appropriate
prominence, especially if more fields end up getting added to the
end of vcpu_e500 (and vcpu ends up in the middle).

Remove gratuitous "extern" and add parameter names to prototypes.

Signed-off-by: Scott Wood <scottwood@freescale.com>
[agraf: fix bisectability]
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/e500.h |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 51d13bd..a48af00 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -42,6 +42,8 @@ struct kvmppc_e500_tlb_params {
 };
 
 struct kvmppc_vcpu_e500 {
+	struct kvm_vcpu vcpu;
+
 	/* Unmodified copy of the guest's TLB -- shared with host userspace. */
 	struct kvm_book3e_206_tlb_entry *gtlb_arch;
 
@@ -85,8 +87,6 @@ struct kvmppc_vcpu_e500 {
 
 	struct page **shared_tlb_pages;
 	int num_shared_tlb_pages;
-
-	struct kvm_vcpu vcpu;
 };
 
 static inline struct kvmppc_vcpu_e500 *to_e500(struct kvm_vcpu *vcpu)
@@ -113,19 +113,22 @@ static inline struct kvmppc_vcpu_e500 *to_e500(struct kvm_vcpu *vcpu)
 	  (MAS3_U0 | MAS3_U1 | MAS3_U2 | MAS3_U3 \
 	   | E500_TLB_USER_PERM_MASK | E500_TLB_SUPER_PERM_MASK)
 
-extern void kvmppc_dump_tlbs(struct kvm_vcpu *);
-extern int kvmppc_e500_emul_mt_mmucsr0(struct kvmppc_vcpu_e500 *, ulong);
-extern int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *);
-extern int kvmppc_e500_emul_tlbre(struct kvm_vcpu *);
-extern int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *, int, int);
-extern int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *, int);
-extern int kvmppc_e500_tlb_search(struct kvm_vcpu *, gva_t, unsigned int, int);
 extern void kvmppc_e500_tlb_put(struct kvm_vcpu *);
 extern void kvmppc_e500_tlb_load(struct kvm_vcpu *, int);
-extern int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *);
-extern void kvmppc_e500_tlb_uninit(struct kvmppc_vcpu_e500 *);
 extern void kvmppc_e500_tlb_setup(struct kvmppc_vcpu_e500 *);
 extern void kvmppc_e500_recalc_shadow_pid(struct kvmppc_vcpu_e500 *);
+int kvmppc_e500_emul_mt_mmucsr0(struct kvmppc_vcpu_e500 *vcpu_e500,
+				ulong value);
+int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu);
+int kvmppc_e500_emul_tlbre(struct kvm_vcpu *vcpu);
+int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, int ra, int rb);
+int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, int rb);
+int kvmppc_e500_tlb_search(struct kvm_vcpu *, gva_t, unsigned int, int);
+int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500);
+void kvmppc_e500_tlb_uninit(struct kvmppc_vcpu_e500 *vcpu_e500);
+
+void kvmppc_get_sregs_e500_tlb(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
+int kvmppc_set_sregs_e500_tlb(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 
 /* TLB helper functions */
 static inline unsigned int
-- 
1.6.0.2
