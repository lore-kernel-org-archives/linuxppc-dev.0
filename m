Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0Kvx5yxgzDqVx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 22:21:49 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3v0Kvx1mDZz9vKY
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 22:21:48 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0DBFjfn021501
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 06:21:45 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27xwuk06hg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2017 06:21:45 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 13 Jan 2017 04:21:44 -0700
Subject: [PATCH v5 1/2] KVM: PPC: Add new capability to control MCE behaviour
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
To: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org, paulus@ozlabs.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com
Cc: mahesh@linux.vnet.ibm.com, mpe@ellerman.id.au, bsingharora@gmail.com,
 kvm@vger.kernel.org, david@gibson.dropbear.id.au
Date: Fri, 13 Jan 2017 16:51:34 +0530
In-Reply-To: <148430634902.22799.7589829837646104546.stgit@aravinda>
References: <148430634902.22799.7589829837646104546.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <148430649444.22799.2654896860071549934.stgit@aravinda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
---
 Documentation/virtual/kvm/api.txt   |   11 +++++++++++
 arch/powerpc/include/asm/kvm_host.h |    1 +
 arch/powerpc/kernel/asm-offsets.c   |    1 +
 arch/powerpc/kvm/powerpc.c          |    7 +++++++
 include/uapi/linux/kvm.h            |    1 +
 5 files changed, 21 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 6bbceb9..748f7f7 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3911,6 +3911,17 @@ to take care of that.
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
index 28350a2..018c684 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -264,6 +264,7 @@ struct kvm_arch {
 	int hpt_cma_alloc;
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
+	u8 fwnmi_enabled;
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index caec7bf..3acd503 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -494,6 +494,7 @@ int main(void)
 	DEFINE(KVM_NEED_FLUSH, offsetof(struct kvm, arch.need_tlb_flush.bits));
 	DEFINE(KVM_ENABLED_HCALLS, offsetof(struct kvm, arch.enabled_hcalls));
 	DEFINE(KVM_VRMA_SLB_V, offsetof(struct kvm, arch.vrma_slb_v));
+	DEFINE(KVM_FWNMI, offsetof(struct kvm, arch.fwnmi_enabled));
 	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
 	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
 	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa.pinned_addr));
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 70963c8..a4405a8 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -604,6 +604,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		r = cpu_has_feature(CPU_FTR_TM_COMP) &&
 		    is_kvmppc_hv_enabled(kvm);
 		break;
+	case KVM_CAP_PPC_FWNMI:
+		r = 1;
+		break;
 	default:
 		r = 0;
 		break;
@@ -1204,6 +1207,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
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
index 4ee67cb..3e41c42 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -870,6 +870,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_INSTR0 130
 #define KVM_CAP_MSI_DEVID 131
 #define KVM_CAP_PPC_HTM 132
+#define KVM_CAP_PPC_FWNMI 133
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
