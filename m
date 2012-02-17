Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F34C0B6FD6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 03:57:11 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: <kvm-ppc@vger.kernel.org> <kvm-ppc@vger.kernel.org>
Subject: [PATCH 11/30] KVM: PPC: e500: emulate tlbilx
Date: Fri, 17 Feb 2012 17:56:39 +0100
Message-Id: <1329497818-9729-12-git-send-email-agraf@suse.de>
In-Reply-To: <1329497818-9729-1-git-send-email-agraf@suse.de>
References: <1329497818-9729-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Scott Wood <scottwood@freescale.com>

tlbilx is the new, preferred invalidation instruction.  It is not
found on e500 prior to e500mc, but there should be no harm in
supporting it on all e500.

Based on code from Ashish Kalra <Ashish.Kalra@freescale.com>.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/e500.h         |    1 +
 arch/powerpc/kvm/e500_emulate.c |    9 ++++++
 arch/powerpc/kvm/e500_tlb.c     |   52 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/e500.h b/arch/powerpc/kvm/e500.h
index f4dee55..ce3f163 100644
--- a/arch/powerpc/kvm/e500.h
+++ b/arch/powerpc/kvm/e500.h
@@ -124,6 +124,7 @@ int kvmppc_e500_emul_mt_mmucsr0(struct kvmppc_vcpu_e500 *vcpu_e500,
 int kvmppc_e500_emul_tlbwe(struct kvm_vcpu *vcpu);
 int kvmppc_e500_emul_tlbre(struct kvm_vcpu *vcpu);
 int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, int ra, int rb);
+int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, int rb);
 int kvmppc_e500_emul_tlbsx(struct kvm_vcpu *vcpu, int rb);
 int kvmppc_e500_tlb_init(struct kvmppc_vcpu_e500 *vcpu_e500);
 void kvmppc_e500_tlb_uninit(struct kvmppc_vcpu_e500 *vcpu_e500);
diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
index c80794d..af02c18 100644
--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -22,6 +22,7 @@
 #define XOP_TLBSX   914
 #define XOP_TLBRE   946
 #define XOP_TLBWE   978
+#define XOP_TLBILX  18
 
 int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
                            unsigned int inst, int *advance)
@@ -29,6 +30,7 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	int emulated = EMULATE_DONE;
 	int ra;
 	int rb;
+	int rt;
 
 	switch (get_op(inst)) {
 	case 31:
@@ -47,6 +49,13 @@ int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
 			emulated = kvmppc_e500_emul_tlbsx(vcpu,rb);
 			break;
 
+		case XOP_TLBILX:
+			ra = get_ra(inst);
+			rb = get_rb(inst);
+			rt = get_rt(inst);
+			emulated = kvmppc_e500_emul_tlbilx(vcpu, rt, ra, rb);
+			break;
+
 		case XOP_TLBIVAX:
 			ra = get_ra(inst);
 			rb = get_rb(inst);
diff --git a/arch/powerpc/kvm/e500_tlb.c b/arch/powerpc/kvm/e500_tlb.c
index c8ce51d..6eb5d65 100644
--- a/arch/powerpc/kvm/e500_tlb.c
+++ b/arch/powerpc/kvm/e500_tlb.c
@@ -631,6 +631,58 @@ int kvmppc_e500_emul_tlbivax(struct kvm_vcpu *vcpu, int ra, int rb)
 	return EMULATE_DONE;
 }
 
+static void tlbilx_all(struct kvmppc_vcpu_e500 *vcpu_e500, int tlbsel,
+		       int pid, int rt)
+{
+	struct kvm_book3e_206_tlb_entry *tlbe;
+	int tid, esel;
+
+	/* invalidate all entries */
+	for (esel = 0; esel < vcpu_e500->gtlb_params[tlbsel].entries; esel++) {
+		tlbe = get_entry(vcpu_e500, tlbsel, esel);
+		tid = get_tlb_tid(tlbe);
+		if (rt == 0 || tid == pid) {
+			inval_gtlbe_on_host(vcpu_e500, tlbsel, esel);
+			kvmppc_e500_gtlbe_invalidate(vcpu_e500, tlbsel, esel);
+		}
+	}
+}
+
+static void tlbilx_one(struct kvmppc_vcpu_e500 *vcpu_e500, int pid,
+		       int ra, int rb)
+{
+	int tlbsel, esel;
+	gva_t ea;
+
+	ea = kvmppc_get_gpr(&vcpu_e500->vcpu, rb);
+	if (ra)
+		ea += kvmppc_get_gpr(&vcpu_e500->vcpu, ra);
+
+	for (tlbsel = 0; tlbsel < 2; tlbsel++) {
+		esel = kvmppc_e500_tlb_index(vcpu_e500, ea, tlbsel, pid, -1);
+		if (esel >= 0) {
+			inval_gtlbe_on_host(vcpu_e500, tlbsel, esel);
+			kvmppc_e500_gtlbe_invalidate(vcpu_e500, tlbsel, esel);
+			break;
+		}
+	}
+}
+
+int kvmppc_e500_emul_tlbilx(struct kvm_vcpu *vcpu, int rt, int ra, int rb)
+{
+	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
+	int pid = get_cur_spid(vcpu);
+
+	if (rt == 0 || rt == 1) {
+		tlbilx_all(vcpu_e500, 0, pid, rt);
+		tlbilx_all(vcpu_e500, 1, pid, rt);
+	} else if (rt == 3) {
+		tlbilx_one(vcpu_e500, pid, ra, rb);
+	}
+
+	return EMULATE_DONE;
+}
+
 int kvmppc_e500_emul_tlbre(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
-- 
1.6.0.2
