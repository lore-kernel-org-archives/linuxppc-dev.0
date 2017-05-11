Return-Path: <srs0=ltoi=4r=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNjY22XSqzDqbB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 16:16:22 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wNjY21xSGz8t1b
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 16:16:22 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wNjY15HPwz9sCZ
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 16:16:21 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4B69Bdw153252
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 02:16:19 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2acf1afwrs-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 02:16:19 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 11 May 2017 16:16:16 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4B6G5uX4981096
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 16:16:13 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4B6FYXg014150
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 16:15:35 +1000
Subject: [PATCH v9 1/3] KVM: PPC: Add new capability to control MCE behaviour
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mackerras <paulus@samba.org>, pbonzini@redhat.com
Cc: Michael Ellerman <mpe@ellerman.id.au>, kvm@vger.kernel.org,
 david@gibson.dropbear.id.au
Date: Thu, 11 May 2017 11:45:22 +0530
In-Reply-To: <149448323691.12206.11861424815113458031.stgit@jupiter.in.ibm.com>
References: <149448323691.12206.11861424815113458031.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149448332189.12206.5811614133100561669.stgit@jupiter.in.ibm.com>
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
index 4029943..3cdf203 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -3996,6 +3996,17 @@ Parameters: none
 Allow use of adapter-interruption suppression.
 Returns: 0 on success; -EBUSY if a VCPU has already been created.
 
+7.11 KVM_CAP_PPC_FWNMI
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
index 77c6082..fad522d 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -284,6 +284,7 @@ struct kvm_arch {
 	struct dentry *debugfs_dir;
 	struct dentry *htab_dentry;
 	struct kvm_resize_hpt *resize_hpt; /* protected by kvm->lock */
+	u8 fwnmi_enabled;
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	struct mutex hpt_mutex;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 439c257..6f742af 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -485,6 +485,7 @@ int main(void)
 	OFFSET(KVM_ENABLED_HCALLS, kvm, arch.enabled_hcalls);
 	OFFSET(KVM_VRMA_SLB_V, kvm, arch.vrma_slb_v);
 	OFFSET(KVM_RADIX, kvm, arch.radix);
+	OFFSET(KVM_FWNMI, kvm, arch.fwnmi_enabled);
 	OFFSET(VCPU_DSISR, kvm_vcpu, arch.shregs.dsisr);
 	OFFSET(VCPU_DAR, kvm_vcpu, arch.shregs.dar);
 	OFFSET(VCPU_VPA, kvm_vcpu, arch.vpa.pinned_addr);
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 1ee22a9..3400477 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -616,6 +616,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 		/* Disable this on POWER9 until code handles new HPTE format */
 		r = !!hv_enabled && !cpu_has_feature(CPU_FTR_ARCH_300);
 		break;
+	case KVM_CAP_PPC_FWNMI:
+		r = 1;
+		break;
 #endif
 	case KVM_CAP_PPC_HTM:
 		r = cpu_has_feature(CPU_FTR_TM_COMP) &&
@@ -1529,6 +1532,12 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
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
index 577429a..89bc145 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -895,6 +895,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_SPAPR_TCE_VFIO 142
 #define KVM_CAP_X86_GUEST_MWAIT 143
 #define KVM_CAP_ARM_USER_IRQ 144
+#define KVM_CAP_PPC_FWNMI 145
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
