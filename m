Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6D88DB71D0
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Aug 2011 22:31:35 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH 11/10] KVM: PPC: Add sanity checking to vcpu_run
Date: Wed, 10 Aug 2011 14:31:29 +0200
Message-Id: <1312979489-17234-1-git-send-email-agraf@suse.de>
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

There are multiple features in PowerPC KVM that can now be enabled
depending on the user's wishes. Some of the combinations don't make
sense or don't work though.

So this patch adds a way to check if the executing environment would
actually be able to run the guest properly. It also adds sanity
checks if PVR is set (should always be true given the current code
flow), if PAPR is only used with book3s_64 where it works and that
HV KVM is only used in PAPR mode.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/include/asm/kvm.h      |    5 +++++
 arch/powerpc/include/asm/kvm_host.h |    2 ++
 arch/powerpc/include/asm/kvm_ppc.h  |    1 +
 arch/powerpc/kvm/44x.c              |    2 ++
 arch/powerpc/kvm/book3s_hv.c        |    8 ++++++++
 arch/powerpc/kvm/book3s_pr.c        |   10 ++++++++++
 arch/powerpc/kvm/booke.c            |   10 +++++++++-
 arch/powerpc/kvm/e500.c             |    2 ++
 arch/powerpc/kvm/powerpc.c          |   28 ++++++++++++++++++++++++++++
 9 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/asm/kvm.h
index a6a253e..08fe69e 100644
--- a/arch/powerpc/include/asm/kvm.h
+++ b/arch/powerpc/include/asm/kvm.h
@@ -284,6 +284,11 @@ struct kvm_guest_debug_arch {
 #define KVM_INTERRUPT_UNSET	-2U
 #define KVM_INTERRUPT_SET_LEVEL	-3U
 
+#define KVM_CPU_440		1
+#define KVM_CPU_E500V2		2
+#define KVM_CPU_3S_32		3
+#define KVM_CPU_3S_64		4
+
 /* for KVM_CAP_SPAPR_TCE */
 struct kvm_create_spapr_tce {
 	__u64 liobn;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e681302..2b8284f 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -390,6 +390,8 @@ struct kvm_vcpu_arch {
 	u8 osi_needed;
 	u8 osi_enabled;
 	u8 papr_enabled;
+	u8 sane;
+	u8 cpu_type;
 	u8 hcall_needed;
 
 	u32 cpr0_cfgaddr; /* holds the last set cpr0_cfgaddr */
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index d121f49..46efd1a 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -66,6 +66,7 @@ extern int kvmppc_emulate_instruction(struct kvm_run *run,
 extern int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu);
 extern void kvmppc_emulate_dec(struct kvm_vcpu *vcpu);
 extern u32 kvmppc_get_dec(struct kvm_vcpu *vcpu, u64 tb);
+extern int kvmppc_sanity_check(struct kvm_vcpu *vcpu);
 
 /* Core-specific hooks */
 
diff --git a/arch/powerpc/kvm/44x.c b/arch/powerpc/kvm/44x.c
index da3a122..ca1f88b 100644
--- a/arch/powerpc/kvm/44x.c
+++ b/arch/powerpc/kvm/44x.c
@@ -78,6 +78,8 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
 	for (i = 0; i < ARRAY_SIZE(vcpu_44x->shadow_refs); i++)
 		vcpu_44x->shadow_refs[i].gtlb_index = -1;
 
+	vcpu->arch.cpu_type = KVM_CPU_440;
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index cc0d7f1..830e07a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -510,6 +510,9 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	spin_unlock(&vcore->lock);
 	vcpu->arch.vcore = vcore;
 
+	vcpu->arch.cpu_type = KVM_CPU_3S_64;
+	kvmppc_sanity_check(vcpu);
+
 	return vcpu;
 
 free_vcpu:
@@ -800,6 +803,11 @@ int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	int r;
 
+	if (!vcpu->arch.sane) {
+		kvm_run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		return -EINVAL;
+	}
+
 	do {
 		r = kvmppc_run_vcpu(run, vcpu);
 
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 48558f6..6e3488b 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -153,6 +153,7 @@ void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr)
 		if (!to_book3s(vcpu)->hior_sregs)
 			to_book3s(vcpu)->hior = 0xfff00000;
 		to_book3s(vcpu)->msr_mask = 0xffffffffffffffffULL;
+		vcpu->arch.cpu_type = KVM_CPU_3S_64;
 	} else
 #endif
 	{
@@ -160,8 +161,11 @@ void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr)
 		if (!to_book3s(vcpu)->hior_sregs)
 			to_book3s(vcpu)->hior = 0;
 		to_book3s(vcpu)->msr_mask = 0xffffffffULL;
+		vcpu->arch.cpu_type = KVM_CPU_3S_32;
 	}
 
+	kvmppc_sanity_check(vcpu);
+
 	/* If we are in hypervisor level on 970, we can tell the CPU to
 	 * treat DCBZ as 32 bytes store */
 	vcpu->arch.hflags &= ~BOOK3S_HFLAG_DCBZ32;
@@ -938,6 +942,12 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 #endif
 	ulong ext_msr;
 
+	/* Check if we can run the vcpu at all */
+	if (!vcpu->arch.sane) {
+		kvm_run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		return -EINVAL;
+	}
+
 	/* No need to go into the guest when all we do is going out */
 	if (signal_pending(current)) {
 		kvm_run->exit_reason = KVM_EXIT_INTR;
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index ee45fa0..bb6c988 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -316,6 +316,11 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
 	int ret;
 
+	if (!vcpu->arch.sane) {
+		kvm_run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		return -EINVAL;
+	}
+
 	local_irq_disable();
 	kvm_guest_enter();
 	ret = __kvmppc_vcpu_run(kvm_run, vcpu);
@@ -618,6 +623,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 {
 	int i;
+	int r;
 
 	vcpu->arch.pc = 0;
 	vcpu->arch.shared->msr = 0;
@@ -634,7 +640,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	kvmppc_init_timing_stats(vcpu);
 
-	return kvmppc_core_vcpu_setup(vcpu);
+	r = kvmppc_core_vcpu_setup(vcpu);
+	kvmppc_sanity_check(vcpu);
+	return r;
 }
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
index 797a744..26d2090 100644
--- a/arch/powerpc/kvm/e500.c
+++ b/arch/powerpc/kvm/e500.c
@@ -73,6 +73,8 @@ int kvmppc_core_vcpu_setup(struct kvm_vcpu *vcpu)
 	/* Since booke kvm only support one core, update all vcpus' PIR to 0 */
 	vcpu->vcpu_id = 0;
 
+	vcpu->arch.cpu_type = KVM_CPU_E500V2;
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 13bc798..a8000ce 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -95,6 +95,31 @@ int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
 	return r;
 }
 
+int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
+{
+	int r = false;
+
+	/* We have to know what CPU to virtualize */
+	if (!vcpu->arch.pvr)
+		goto out;
+
+	/* PAPR only works with book3s_64 */
+	if ((vcpu->arch.cpu_type != KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
+		goto out;
+
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	/* HV KVM can only do PAPR mode for now */
+	if (!vcpu->arch.papr_enabled)
+		goto out;
+#endif
+
+	r = true;
+
+out:
+	vcpu->arch.sane = r;
+	return r ? 0 : -EINVAL;
+}
+
 int kvmppc_emulate_mmio(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er;
@@ -582,6 +607,9 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		break;
 	}
 
+	if (!r)
+		r = kvmppc_sanity_check(vcpu);
+
 	return r;
 }
 
-- 
1.6.0.2
