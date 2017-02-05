Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGgN911pczDqFT
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 06:17:29 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vGgN841Hpz9s2s
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2017 06:17:28 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v15JDZn6055967
 for <linuxppc-dev@ozlabs.org>; Sun, 5 Feb 2017 14:17:26 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28dm7m0dsp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 05 Feb 2017 14:17:26 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 6 Feb 2017 00:47:23 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 31874394004E
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2017 00:47:20 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v15JHK5s26476554
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Feb 2017 00:47:20 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v15JHIxk026612
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Feb 2017 00:47:19 +0530
Subject: [PATCH v6 1/2] KVM: PPC: Add new capability to control MCE behaviour
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, bsingharora@gmail.com,
 Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
 david@gibson.dropbear.id.au
Date: Mon, 06 Feb 2017 00:47:17 +0530
In-Reply-To: <148632203211.7314.13690405241893581965.stgit@jupiter.in.ibm.com>
References: <148632203211.7314.13690405241893581965.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148632223704.7314.15559511266588172763.stgit@jupiter.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>

This patch introduces a new KVM capability to control
how KVM behaves on machine check exception (MCE).
Without this capability, KVM redirects machine check
exceptions to guest's 0x200 vector, if the address in
error belongs to the guest. With this capability KVM
causes a guest exit with NMI exit reason.

The new capability is required to avoid problems if
a new kernel/KVM is used with an old QEMU for guests
that don't issue "ibm,nmi-register". As old QEMU does
not understand the NMI exit type, it treats it as a
fatal error. However, the guest could have handled
the machine check error if the exception was delivered
to guest's 0x200 interrupt vector instead of NMI exit
in case of old QEMU.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 Documentation/virtual/kvm/api.txt   |   11 +++++++++++
 arch/powerpc/include/asm/kvm_host.h |    1 +
 arch/powerpc/kernel/asm-offsets.c   |    1 +
 arch/powerpc/kvm/powerpc.c          |    7 +++++++
 include/uapi/linux/kvm.h            |    1 +
 5 files changed, 21 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 03145b7..e2960e0 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3914,6 +3914,17 @@ to take care of that.
 This capability can be enabled dynamically even if VCPUs were already
 created and are running.
 
+7.9 KVM_CAP_PPC_FWNMI
+
+Architectures: ppc
+Parameters: none
+
+With this capability a machine check exception in the guest address
+space will cause KVM to exit the guest with NMI exit reason. This
+enables QEMU to build error log and branch to guest kernel registered
+machine check handling routine. Without this capability KVM will
+branch to guests' 0x200 interrupt vector.
+
 8. Other capabilities.
 ----------------------
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index e59b172..5f031a7 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -266,6 +266,7 @@ struct kvm_arch {
 	int hpt_cma_alloc;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
+	u8 fwnmi_enabled;
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 0601e6a..df29caf 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -498,6 +498,7 @@ int main(void)
 	DEFINE(KVM_NEED_FLUSH, offsetof(struct kvm, arch.need_tlb_flush.bits));
 	DEFINE(KVM_ENABLED_HCALLS, offsetof(struct kvm, arch.enabled_hcalls));
 	DEFINE(KVM_VRMA_SLB_V, offsetof(struct kvm, arch.vrma_slb_v));
+	DEFINE(KVM_FWNMI, offsetof(struct kvm, arch.fwnmi_enabled));
 	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
 	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
 	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index cd892de..14377bb 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -610,6 +610,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = cpu_has_feature(CPU_FTR_TM_COMP) &&
 		    is_kvmppc_hv_enabled(kvm);
 		break;
+	case KVM_CAP_PPC_FWNMI:
+		r = 1;
+		break;
 	default:
 		r = 0;
 		break;
@@ -1210,6 +1213,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		break;
 	}
 #endif /* CONFIG_KVM_XICS */
+	case KVM_CAP_PPC_FWNMI:
+		r = 0;
+		vcpu->kvm->arch.fwnmi_enabled = true;
+		break;
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index cac48ed..4783d11 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -871,6 +871,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_INSTR0 130
 #define KVM_CAP_MSI_DEVID 131
 #define KVM_CAP_PPC_HTM 132
+#define KVM_CAP_PPC_FWNMI 133
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
