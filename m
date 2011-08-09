Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 099D8B7322
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 02:32:00 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 03/10] KVM: PPC: Check privilege level on SPRs
Date: Tue,  9 Aug 2011 18:31:41 +0200
Message-Id: <1312907508-14599-4-git-send-email-agraf@suse.de>
In-Reply-To: <1312907508-14599-1-git-send-email-agraf@suse.de>
References: <1312907508-14599-1-git-send-email-agraf@suse.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have 3 privilege levels: problem state, supervisor state and hypervisor
state. Each of them can access different SPRs, so we need to check on every
SPR if it's accessible in the respective mode.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kvm/book3s_emulate.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
index 4668465..bf0ddcd 100644
--- a/arch/powerpc/kvm/book3s_emulate.c
+++ b/arch/powerpc/kvm/book3s_emulate.c
@@ -63,6 +63,25 @@
  * function pointers, so let's just disable the define. */
 #undef mfsrin
 
+enum priv_level {
+	PRIV_PROBLEM = 0,
+	PRIV_SUPER = 1,
+	PRIV_HYPER = 2,
+};
+
+static bool spr_allowed(struct kvm_vcpu *vcpu, enum priv_level level)
+{
+	/* PAPR VMs only access supervisor SPRs */
+	if (vcpu->arch.papr_enabled && (level > PRIV_SUPER))
+		return false;
+
+	/* Limit user space to its own small SPR set */
+	if ((vcpu->arch.shared->msr & MSR_PR) && level > PRIV_PROBLEM)
+		return false;
+
+	return true;
+}
+
 int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
                            unsigned int inst, int *advance)
 {
@@ -296,6 +315,8 @@ int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
 
 	switch (sprn) {
 	case SPRN_SDR1:
+		if (!spr_allowed(vcpu, PRIV_HYPER))
+			goto unprivileged;
 		to_book3s(vcpu)->sdr1 = spr_val;
 		break;
 	case SPRN_DSISR:
@@ -390,6 +411,7 @@ int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
 	case SPRN_PMC4_GEKKO:
 	case SPRN_WPAR_GEKKO:
 		break;
+unprivileged:
 	default:
 		printk(KERN_INFO "KVM: invalid SPR write: %d\n", sprn);
 #ifndef DEBUG_SPR
@@ -421,6 +443,8 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
 		break;
 	}
 	case SPRN_SDR1:
+		if (!spr_allowed(vcpu, PRIV_HYPER))
+			goto unprivileged;
 		kvmppc_set_gpr(vcpu, rt, to_book3s(vcpu)->sdr1);
 		break;
 	case SPRN_DSISR:
@@ -476,6 +500,7 @@ int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
 		kvmppc_set_gpr(vcpu, rt, 0);
 		break;
 	default:
+unprivileged:
 		printk(KERN_INFO "KVM: invalid SPR read: %d\n", sprn);
 #ifndef DEBUG_SPR
 		emulated = EMULATE_FAIL;
-- 
1.6.0.2
