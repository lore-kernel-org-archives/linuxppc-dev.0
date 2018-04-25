Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40WJY819LqzF24P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 21:55:24 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id e9so13166311pgr.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2018 04:55:24 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: kvm-ppc@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, kvm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH 08/11] KVM: PPC: add giveup_ext() hook for PPC KVM ops
Date: Wed, 25 Apr 2018 19:54:41 +0800
Message-Id: <1524657284-16706-9-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
References: <1524657284-16706-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

Currently HV will save math regs(FP/VEC/VSX) when trap into host. But
PR KVM will only save math regs when qemu task switch out of CPU.

To emulate FP/VEC/VSX load, PR KVM need to flush math regs firstly and
then be able to update saved VCPU FPR/VEC/VSX area reasonably.

This patch adds the giveup_ext() to KVM ops (an empty one for HV KVM)
and kvmppc_complete_mmio_load() can invoke that hook to flush math
regs accordingly.

Math regs flush is also necessary for STORE, which will be covered
in later patch within this patch series.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/include/asm/kvm_ppc.h | 1 +
 arch/powerpc/kvm/book3s_hv.c       | 5 +++++
 arch/powerpc/kvm/book3s_pr.c       | 1 +
 arch/powerpc/kvm/powerpc.c         | 9 +++++++++
 4 files changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index abe7032..b265538 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -324,6 +324,7 @@ struct kvmppc_ops {
 	int (*get_rmmu_info)(struct kvm *kvm, struct kvm_ppc_rmmu_info *info);
 	int (*set_smt_mode)(struct kvm *kvm, unsigned long mode,
 			    unsigned long flags);
+	void (*giveup_ext)(struct kvm_vcpu *vcpu, ulong msr);
 };
 
 extern struct kvmppc_ops *kvmppc_hv_ops;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5b875ba..7eb5507 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2084,6 +2084,10 @@ static int kvmhv_set_smt_mode(struct kvm *kvm, unsigned long smt_mode,
 	return err;
 }
 
+static void kvmhv_giveup_ext(struct kvm_vcpu *vcpu, ulong msr)
+{
+}
+
 static void unpin_vpa(struct kvm *kvm, struct kvmppc_vpa *vpa)
 {
 	if (vpa->pinned_addr)
@@ -4398,6 +4402,7 @@ static int kvmhv_configure_mmu(struct kvm *kvm, struct kvm_ppc_mmuv3_cfg *cfg)
 	.configure_mmu = kvmhv_configure_mmu,
 	.get_rmmu_info = kvmhv_get_rmmu_info,
 	.set_smt_mode = kvmhv_set_smt_mode,
+	.giveup_ext = kvmhv_giveup_ext,
 };
 
 static int kvm_init_subcore_bitmap(void)
diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 67061d3..be26636 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -1782,6 +1782,7 @@ static long kvm_arch_vm_ioctl_pr(struct file *filp,
 #ifdef CONFIG_PPC_BOOK3S_64
 	.hcall_implemented = kvmppc_hcall_impl_pr,
 #endif
+	.giveup_ext = kvmppc_giveup_ext,
 };
 
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 17f0315..e724601 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1061,6 +1061,9 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 		kvmppc_set_gpr(vcpu, vcpu->arch.io_gpr, gpr);
 		break;
 	case KVM_MMIO_REG_FPR:
+		if (!is_kvmppc_hv_enabled(vcpu->kvm))
+			vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu, MSR_FP);
+
 		VCPU_FPR(vcpu, vcpu->arch.io_gpr & KVM_MMIO_REG_MASK) = gpr;
 		break;
 #ifdef CONFIG_PPC_BOOK3S
@@ -1074,6 +1077,9 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 #endif
 #ifdef CONFIG_VSX
 	case KVM_MMIO_REG_VSX:
+		if (!is_kvmppc_hv_enabled(vcpu->kvm))
+			vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu, MSR_VSX);
+
 		if (vcpu->arch.mmio_vsx_copy_type == KVMPPC_VSX_COPY_DWORD)
 			kvmppc_set_vsr_dword(vcpu, gpr);
 		else if (vcpu->arch.mmio_vsx_copy_type == KVMPPC_VSX_COPY_WORD)
@@ -1088,6 +1094,9 @@ static void kvmppc_complete_mmio_load(struct kvm_vcpu *vcpu,
 #endif
 #ifdef CONFIG_ALTIVEC
 	case KVM_MMIO_REG_VMX:
+		if (!is_kvmppc_hv_enabled(vcpu->kvm))
+			vcpu->kvm->arch.kvm_ops->giveup_ext(vcpu, MSR_VEC);
+
 		kvmppc_set_vmx_dword(vcpu, gpr);
 		break;
 #endif
-- 
1.8.3.1
