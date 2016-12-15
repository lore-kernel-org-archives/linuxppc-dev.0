Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tfN6X6y7BzDvk5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Dec 2016 16:58:44 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org
Cc: michael@ellerman.id.au, benh@kernel.crashing.org, sjitindarsingh@gmail.com,
 thuth@redhat.com, lvivier@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 01/11] powerpc/kvm: Reserve capabilities and ioctls for HPT
 resizing
Date: Thu, 15 Dec 2016 16:53:54 +1100
Message-Id: <20161215055404.29351-2-david@gibson.dropbear.id.au>
In-Reply-To: <20161215055404.29351-1-david@gibson.dropbear.id.au>
References: <20161215055404.29351-1-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a new powerpc-specific KVM_CAP_SPAPR_RESIZE_HPT capability to
advertise whether KVM is capable of handling the PAPR extensions for
resizing the hashed page table during guest runtime.

At present, HPT resizing is possible with KVM PR without kernel
modification, since the HPT is managed within qemu.  It's not possible yet
with KVM HV, because the HPT is managed by KVM.  At present, qemu has to
use other capabilities which (by accident) reveal whether PR or HV is in
use to know if it can advertise HPT resizing capability to the guest.

To avoid ambiguity with existing kernels, the encoding is a bit odd.
    0 means "unknown" since that's what previous kernels will return
    1 means "HPT resize possible if available if and only if the HPT is allocated in
      userspace, rather than in the kernel".  Userspace can check
      KVM_CAP_PPC_ALLOC_HTAB to determine if that's the case.  In practice
      this will give the same results as userspace's fallback check.
    2 will mean "HPT resize available and implemented via ioctl()s
      KVM_PPC_RESIZE_HPT_PREPARE and KVM_PPC_RESIZE_HPT_COMMIT"

For now we always return 1, but the intention is to return 2 once HPT
resize is implemented for KVM HV.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/powerpc.c |  3 +++
 include/uapi/linux/kvm.h   | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index efd1183..bb23923 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -605,6 +605,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SPAPR_MULTITCE:
 		r = 1;
 		break;
+	case KVM_CAP_SPAPR_RESIZE_HPT:
+		r = 1; /* resize allowed only if HPT is outside kernel */
+		break;
 #endif
 	case KVM_CAP_PPC_HTM:
 		r = cpu_has_feature(CPU_FTR_TM_COMP) &&
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index cac48ed..904afe0 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -685,6 +685,12 @@ struct kvm_ppc_smmu_info {
 	struct kvm_ppc_one_seg_page_size sps[KVM_PPC_PAGE_SIZES_MAX_SZ];
 };
 
+/* for KVM_PPC_RESIZE_HPT_{PREPARE,COMMIT} */
+struct kvm_ppc_resize_hpt {
+	__u64 flags;
+	__u32 shift;
+};
+
 #define KVMIO 0xAE
 
 /* machine type bits, to be used as argument to KVM_CREATE_VM */
@@ -871,6 +877,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_S390_USER_INSTR0 130
 #define KVM_CAP_MSI_DEVID 131
 #define KVM_CAP_PPC_HTM 132
+#define KVM_CAP_SPAPR_RESIZE_HPT 133
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1187,6 +1194,9 @@ struct kvm_s390_ucas_mapping {
 #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct kvm_arm_device_addr)
 /* Available with KVM_CAP_PPC_RTAS */
 #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xac, struct kvm_rtas_token_args)
+/* Available with KVM_CAP_SPAPR_RESIZE_HPT */
+#define KVM_PPC_RESIZE_HPT_PREPARE _IOR(KVMIO, 0xad, struct kvm_ppc_resize_hpt)
+#define KVM_PPC_RESIZE_HPT_COMMIT _IOR(KVMIO, 0xae, struct kvm_ppc_resize_hpt)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
2.9.3
