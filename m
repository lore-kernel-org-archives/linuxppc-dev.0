Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
 [216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 8AEE9B6FD1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2011 12:34:41 +1100 (EST)
Date: Tue, 20 Dec 2011 19:34:32 -0600
From: Scott Wood <scottwood@freescale.com>
To: <agraf@suse.de>
Subject: [RFC PATCH 09/16] KVM: PPC: e500: clean up arch/powerpc/kvm/e500.h
Message-ID: <20111221013432.GI8378@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20111221013340.GA8368@schlenkerla.am.freescale.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move vcpu to the beginning of vcpu_e500 to give it appropriate
prominence, especially if more fields end up getting added to the
end of vcpu_e500 (and vcpu ends up in the middle).

Remove gratuitous "extern" and add parameter names to prototypes.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/kvm/e500.h |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index 51d13bd..6b53a88 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -42,6 +42,8 @@ struct kvmppc_e500_tlb_params {
 };
 
 struct kvmppc_vcpu_e500 {
+	struct kvm_vcpu vcpu;
+
 	/* Unmodified copy of the guest's TLB -- shared with host userspace. */
 	struct kvm_book3e_206_tlb_entry *gtlb_arch;
 
@@ -72,9 +74,6 @@ struct kvmppc_vcpu_e500 {
 	u32 pid[E500_PID_NUM];
 	u32 svr;
 
-	/* vcpu id table */
-	struct vcpu_id_table *idt;
-
 	u32 l1csr0;
 	u32 l1csr1;
 	u32 hid0;
@@ -85,8 +84,6 @@ struct kvmppc_vcpu_e500 {
 
 	struct page **shared_tlb_pages;
 	int num_shared_tlb_pages;
-
-	struct kvm_vcpu vcpu;
 };
 
 static inline struct kvmppc_vcpu_e500 *to_e500(struct kvm_vcpu *vcpu)
@@ -113,19 +110,18 @@ static inline struct kvmppc_vcpu_e500 *to_e500(struct kvm_vcpu *vcpu)
 	  (MAS3_U0 | MAS3_U1 | MAS3_U2 | MAS3_U3 \
 	   | E500_TLB_USER_PERM_MASK | E500_TLB_SUPER_PERM_MASK)
 
-extern void kvmppc_dump_tlbs(struct kvm_vcpu *);
-extern int kvmppc_e500_emul_mt_mmucsr0(struct kvmppc_vcpu_e500 *, ulong);
-extern int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *);
-extern int kvmppc_e500_emul_tlbre(struct kvm_vcpu *);
-extern int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *, int, int);
-extern int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *, int);
-extern int kvmppc_e500_tlb_search(struct kvm_vcpu *, gva_t, unsigned int, int);
-extern void kvmppc_e500_tlb_put(struct kvm_vcpu *);
-extern void kvmppc_e500_tlb_load(struct kvm_vcpu *, int);
-extern int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *);
-extern void kvmppc_e500_tlb_uninit(struct kvmppc_vcpu_e500 *);
-extern void kvmppc_e500_tlb_setup(struct kvmppc_vcpu_e500 *);
-extern void kvmppc_e500_recalc_shadow_pid(struct kvmppc_vcpu_e500 *);
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
1.7.7.rc3.4.g8d714
