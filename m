Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 557482C0087
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 02:53:57 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 29 Nov 2013 01:53:56 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0D5282CE8051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 02:53:49 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rASFZgRk8323450
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 02:35:43 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rASFrm4o024306
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 02:53:48 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2] powerpc: book3s: PR: Enable Little Endian PR guest
Date: Thu, 28 Nov 2013 21:23:38 +0530
Message-Id: <1385654018-18232-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

This patch make sure we inherit the LE bit correctly in different case
so that we can run Little Endian distro in PR mode

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---

Changes from V1:
* Use LPCR bit to find whether to enable LE on interrupt. We do it more or less
  same as HV now. We keep it separate at this point because HV H_SETMODE does
  a lot more than what we do here.

This patch depends on the below two changes
1)  [PATCH v5 0/6] KVM: PPC: Book3S: MMIO support for Little Endian guests (kvm-ppc)
	http://mid.gmane.org/1383672128-26795-1-git-send-email-clg@fr.ibm.com
2) [PATCH] powerpc: book3s: kvm: Use the saved dsisr and dar values
       http://mid.gmane.org/1384178577-23721-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com
3) [PATCH 11/15] KVM: PPC: Book3S HV: Add little-endian guest support
    http://mid.gmane.org/1383995103-24732-12-git-send-email-paulus@samba.org
    With further changes to make it apply to latest upstream.
    
 arch/powerpc/include/asm/kvm_host.h |  4 +--
 arch/powerpc/kernel/asm-offsets.c   |  4 +--
 arch/powerpc/kvm/book3s_64_mmu.c    |  2 +-
 arch/powerpc/kvm/book3s_pr.c        |  3 +-
 arch/powerpc/kvm/book3s_pr_papr.c   | 57 +++++++++++++++++++++++++++++++++++++
 5 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index cecd88338f28..1e67adc725d2 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -240,7 +240,6 @@ struct kvm_arch {
 	unsigned long sdr1;
 	unsigned long host_sdr1;
 	int tlbie_lock;
-	unsigned long lpcr;
 	unsigned long rmor;
 	struct kvm_rma_info *rma;
 	unsigned long vrma_slb_v;
@@ -261,6 +260,7 @@ struct kvm_arch {
 	struct mutex hpt_mutex;
 #endif
 #ifdef CONFIG_PPC_BOOK3S_64
+	unsigned long lpcr;
 	struct list_head spapr_tce_tables;
 	struct list_head rtas_tokens;
 #endif
@@ -524,6 +524,7 @@ struct kvm_vcpu_arch {
 #ifdef CONFIG_PPC_BOOK3S
 	ulong fault_dar;
 	u32 fault_dsisr;
+	unsigned long intr_msr;
 #endif
 
 #ifdef CONFIG_BOOKE
@@ -616,7 +617,6 @@ struct kvm_vcpu_arch {
 	spinlock_t tbacct_lock;
 	u64 busy_stolen;
 	u64 busy_preempt;
-	unsigned long intr_msr;
 #endif
 };
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 39dbcb3d3d7d..136c4bec52ab 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -473,7 +473,6 @@ int main(void)
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	DEFINE(KVM_SDR1, offsetof(struct kvm, arch.sdr1));
 	DEFINE(KVM_HOST_LPID, offsetof(struct kvm, arch.host_lpid));
-	DEFINE(KVM_HOST_LPCR, offsetof(struct kvm, arch.host_lpcr));
 	DEFINE(KVM_HOST_SDR1, offsetof(struct kvm, arch.host_sdr1));
 	DEFINE(KVM_TLBIE_LOCK, offsetof(struct kvm, arch.tlbie_lock));
 	DEFINE(KVM_NEED_FLUSH, offsetof(struct kvm, arch.need_tlb_flush.bits));
@@ -484,9 +483,9 @@ int main(void)
 	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
 	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
 	DEFINE(VCPU_VPA_DIRTY, offsetof(struct kvm_vcpu, arch.vpa.dirty));
-	DEFINE(VCPU_INTR_MSR, offsetof(struct kvm_vcpu, arch.intr_msr));
 #endif
 #ifdef CONFIG_PPC_BOOK3S
+	DEFINE(KVM_HOST_LPCR, offsetof(struct kvm, arch.host_lpcr));
 	DEFINE(VCPU_VCPUID, offsetof(struct kvm_vcpu, vcpu_id));
 	DEFINE(VCPU_PURR, offsetof(struct kvm_vcpu, arch.purr));
 	DEFINE(VCPU_SPURR, offsetof(struct kvm_vcpu, arch.spurr));
@@ -510,6 +509,7 @@ int main(void)
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
index f84778547c6b..dc22643a45d2 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -226,7 +226,7 @@ static void kvmppc_recalc_shadow_msr(struct kvm_vcpu *vcpu)
 	ulong smsr = vcpu->arch.shared->msr;
 
 	/* Guest MSR values */
-	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE;
+	smsr &= MSR_FE0 | MSR_FE1 | MSR_SF | MSR_SE | MSR_BE | MSR_LE;
 	/* Process MSR values */
 	smsr |= MSR_ME | MSR_RI | MSR_IR | MSR_DR | MSR_PR | MSR_EE;
 	/* External providers the guest reserved */
@@ -1207,6 +1207,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_pr(struct kvm *kvm,
 	vcpu->arch.pvr = 0x3C0301;
 	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		vcpu->arch.pvr = mfspr(SPRN_PVR);
+	vcpu->arch.intr_msr = MSR_SF;
 #else
 	/* default to book3s_32 (750) */
 	vcpu->arch.pvr = 0x84202;
diff --git a/arch/powerpc/kvm/book3s_pr_papr.c b/arch/powerpc/kvm/book3s_pr_papr.c
index 5efa97b993d8..02a23890aa0d 100644
--- a/arch/powerpc/kvm/book3s_pr_papr.c
+++ b/arch/powerpc/kvm/book3s_pr_papr.c
@@ -256,6 +256,61 @@ static int kvmppc_h_pr_xics_hcall(struct kvm_vcpu *vcpu, u32 cmd)
 	return EMULATE_DONE;
 }
 
+static int kvmppc_h_set_mode_pr(struct kvm_vcpu *vcpu, unsigned long mflags,
+				unsigned long resource, unsigned long value1,
+				unsigned long value2)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct kvm_vcpu *v;
+	int n;
+
+	switch (resource) {
+	case H_SET_MODE_RESOURCE_LE:
+		if (value1)
+			return H_P3;
+		if (value2)
+			return H_P4;
+
+		switch (mflags) {
+		case 0:
+			mutex_lock(&kvm->lock);
+			kvmppc_update_lpcr(kvm, 0, LPCR_ILE);
+			kvm_for_each_vcpu(n, v, kvm)
+				v->arch.intr_msr &= ~MSR_LE;
+			mutex_unlock(&kvm->lock);
+			kick_all_cpus_sync();
+			return H_SUCCESS;
+
+		case 1:
+			mutex_lock(&kvm->lock);
+			kvmppc_update_lpcr(kvm, LPCR_ILE, LPCR_ILE);
+			kvm_for_each_vcpu(n, v, kvm)
+				v->arch.intr_msr |= MSR_LE;
+			mutex_unlock(&kvm->lock);
+			kick_all_cpus_sync();
+			return H_SUCCESS;
+
+		default:
+			return H_UNSUPPORTED_FLAG_START;
+		}
+	default:
+		 return H_P2;
+	}
+}
+
+static int kvmppc_h_pr_set_mode(struct kvm_vcpu *vcpu)
+{
+	int ret;
+	unsigned long mflags = kvmppc_get_gpr(vcpu, 4);
+	unsigned long resource = kvmppc_get_gpr(vcpu, 5);
+	unsigned long value1 = kvmppc_get_gpr(vcpu, 6);
+	unsigned long value2 = kvmppc_get_gpr(vcpu, 7);
+
+	ret = kvmppc_h_set_mode_pr(vcpu, mflags, resource, value1, value2);
+	kvmppc_set_gpr(vcpu, 3, ret);
+	return EMULATE_DONE;
+}
+
 int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
 {
 	switch (cmd) {
@@ -291,6 +346,8 @@ int kvmppc_h_pr(struct kvm_vcpu *vcpu, unsigned long cmd)
 			break;
 		kvmppc_set_gpr(vcpu, 3, 0);
 		return EMULATE_DONE;
+	case H_SET_MODE:
+		return kvmppc_h_pr_set_mode(vcpu);
 	}
 
 	return EMULATE_FAIL;
-- 
1.8.3.2
