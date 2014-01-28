Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C2E682C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 17:46:26 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 16:46:20 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 338522CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 17:46:18 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0S6k5Cn11403604
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 17:46:05 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0S6kHNW001731
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 17:46:17 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH V3] KVM: PPC: BOOK3S: PR: Enable Little Endian PR guest
Date: Tue, 28 Jan 2014 12:16:09 +0530
Message-Id: <1390891569-21161-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch make sure we inherit the LE bit correctly in different case
so that we can run Little Endian distro in PR mode

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
Changes from V2:
 * Move H_SET_MODE to qemu


 arch/powerpc/include/asm/kvm_host.h |  1 +
 arch/powerpc/kernel/asm-offsets.c   |  1 +
 arch/powerpc/kvm/book3s_64_mmu.c    |  2 +-
 arch/powerpc/kvm/book3s_pr.c        | 32 +++++++++++++++++++++++++++++++-
 4 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 207b7826c9b1..f4be7be14330 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -550,6 +550,7 @@ struct kvm_vcpu_arch {
 #ifdef CONFIG_PPC_BOOK3S
 	ulong fault_dar;
 	u32 fault_dsisr;
+	unsigned long intr_msr;
 #endif
 
 #ifdef CONFIG_BOOKE
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index b754f629a177..7484676b8f25 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -518,6 +518,7 @@ int main(void)
 	DEFINE(VCPU_SLB_NR, offsetof(struct kvm_vcpu, arch.slb_nr));
 	DEFINE(VCPU_FAULT_DSISR, offsetof(struct kvm_vcpu, arch.fault_dsisr));
 	DEFINE(VCPU_FAULT_DAR, offsetof(struct kvm_vcpu, arch.fault_dar));
+	DEFINE(VCPU_INTR_MSR, offsetof(struct kvm_vcpu, arch.intr_msr));
 	DEFINE(VCPU_LAST_INST, offsetof(struct kvm_vcpu, arch.last_inst));
 	DEFINE(VCPU_TRAP, offsetof(struct kvm_vcpu, arch.trap));
 	DEFINE(VCPU_PTID, offsetof(struct kvm_vcpu, arch.ptid));
diff --git a/arch/powerpc/kvm/book3s_64_mmu.c b/arch/powerpc/kvm/book3s_64_mmu.c
index 83da1f868fd5..8231b83c493b 100644
--- a/arch/powerpc/kvm/book3s_64_mmu.c
+++ b/arch/powerpc/kvm/book3s_64_mmu.c
@@ -38,7 +38,7 @@
 
 static void kvmppc_mmu_book3s_64_reset_msr(struct kvm_vcpu *vcpu)
 {
-	kvmppc_set_msr(vcpu, MSR_SF);
+	kvmppc_set_msr(vcpu, vcpu->arch.intr_msr);
 }
 
 static struct kvmppc_slb *kvmppc_mmu_book3s_64_find_slbe(
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index eb070eb4da40..828056ec208f 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -263,7 +263,7 @@ static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
 	ulong smsr = vcpu->arch.shared->msr;
 
 	/* Guest MSR values */
-	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE;
+	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_LE;
 	/* Process MSR values */
 	smsr |= MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_PR | MSR_EE;
 	/* External providers the guest reserved */
@@ -1178,6 +1178,15 @@ static int kvmppc_get_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
 		break;
 	}
 #endif /* CONFIG_VSX */
+	case KVM_REG_PPC_LPCR:
+		/*
+		 * We are only interested in the LPCR_ILE bit
+		 */
+		if (vcpu->arch.intr_msr & MSR_LE)
+			*val = get_reg_val(id, LPCR_ILE);
+		else
+			*val = get_reg_val(id, 0);
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -1186,6 +1195,23 @@ static int kvmppc_get_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
 	return r;
 }
 
+static void kvmppc_set_lpcr_pr(struct kvm_vcpu *vcpu, u64 new_lpcr)
+{
+	struct kvm *kvm = vcpu->kvm;
+	/*
+	 * If ILE (interrupt little-endian) has changed, update the
+	 * MSR_LE bit in the intr_msr for each vcpu in this vcore.
+	 */
+	if ((new_lpcr & LPCR_ILE) != (vcpu->arch.intr_msr & MSR_LE)) {
+		mutex_lock(&kvm->lock);
+		if (new_lpcr & LPCR_ILE)
+			vcpu->arch.intr_msr |= MSR_LE;
+		else
+			vcpu->arch.intr_msr &= ~MSR_LE;
+		mutex_unlock(&kvm->lock);
+	}
+}
+
 static int kvmppc_set_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
 				 union kvmppc_one_reg *val)
 {
@@ -1209,6 +1235,9 @@ static int kvmppc_set_one_reg_pr(struct kvm_vcpu *vcpu, u64 id,
 		break;
 	}
 #endif /* CONFIG_VSX */
+	case KVM_REG_PPC_LPCR:
+		kvmppc_set_lpcr_pr(vcpu, set_reg_val(id, *val));
+		break;
 	default:
 		r = -EINVAL;
 		break;
@@ -1261,6 +1290,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_pr(struct kvm *kvm,
 	vcpu->arch.pvr = 0x3C0301;
 	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		vcpu->arch.pvr = mfspr(SPRN_PVR);
+	vcpu->arch.intr_msr = MSR_SF;
 #else
 	/* default to book3s_32 (750) */
 	vcpu->arch.pvr = 0x84202;
-- 
1.8.5.3
