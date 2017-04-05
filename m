Return-Path: <srs0=rqy9=3n=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vyyZk7159zDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 06:47:26 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vyyZk62V3z8sXJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 06:47:26 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vyyZk2qB8z9s8c
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2017 06:47:25 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v35Kj20g001849
 for <linuxppc-dev@ozlabs.org>; Wed, 5 Apr 2017 16:47:23 -0400
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29n79j1k51-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 05 Apr 2017 16:47:23 -0400
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 6 Apr 2017 02:17:20 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v35KlHKS11927684
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2017 02:17:17 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v35KlGmK009853
 for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2017 02:17:17 +0530
Subject: [PATCH v7 1/3] KVM: PPC: Add new capability to control MCE behaviour
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: gleb@kernel.org, agraf@suse.de, KVM-PPC <kvm-ppc@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com
Cc: Aravinda Prasad <aravinda@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>,
 david@gibson.dropbear.id.au
Date: Thu, 06 Apr 2017 02:17:15 +0530
In-Reply-To: <149142508580.28284.10052904644951828717.stgit@jupiter.in.ibm.com>
References: <149142508580.28284.10052904644951828717.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149142523540.28284.11369785235451616846.stgit@jupiter.in.ibm.com>
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
 arch/powerpc/kvm/powerpc.c          |    9 +++++++++
 include/uapi/linux/kvm.h            |    1 +
 5 files changed, 23 insertions(+)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index fd10689..1c9d281 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4164,6 +4164,17 @@ to take care of that.
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
index 7bba8f4..4d02cbc 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -279,6 +279,7 @@ struct kvm_arch {
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
 	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->lock */
+	u8 fwnmi_enabled;
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 4367e7d..0daa47b 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -481,6 +481,7 @@ int main(void)
 	OFFSET(KVM_ENABLED_HCALLS, kvm, arch.enabled_hcalls);
 	OFFSET(KVM_VRMA_SLB_V, kvm, arch.vrma_slb_v);
 	OFFSET(KVM_RADIX, kvm, arch.radix);
+	OFFSET(KVM_FWNMI, kvm, arch.fwnmi_enabled);
 	OFFSET(VCPU_DSISR, kvm_vcpu, arch.shregs.dsisr);
 	OFFSET(VCPU_DAR, kvm_vcpu, arch.shregs.dar);
 	OFFSET(VCPU_VPA, kvm_vcpu, arch.vpa.pinned_addr);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 95c91a9..b8e8cd4 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -618,6 +618,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		/* Disable this on POWER9 until code handles new HPTE format */
 		r = !!hv_enabled && !cpu_has_feature(CPU_FTR_ARCH_300);
 		break;
+	case KVM_CAP_PPC_FWNMI:
+		r = 1;
+		break;
 #endif
 	case KVM_CAP_PPC_HTM:
 		r = cpu_has_feature(CPU_FTR_TM_COMP) &&
@@ -1226,6 +1229,12 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 		break;
 	}
 #endif /* CONFIG_KVM_XICS */
+#ifdef CONFIG_PPC_BOOK3S_64
+	case KVM_CAP_PPC_FWNMI:
+		r = 0;
+		vcpu->kvm->arch.fwnmi_enabled = true;
+		break;
+#endif /* CONFIG_PPC_BOOK3S_64 */
 	default:
 		r = -EINVAL;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f51d508..d5428a7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -883,6 +883,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_MMU_RADIX 134
 #define KVM_CAP_PPC_MMU_HASH_V3 135
 #define KVM_CAP_IMMEDIATE_EXIT 136
+#define KVM_CAP_PPC_FWNMI 137
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
