Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D0F01A0342
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 12:59:54 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org,
	aik@ozlabs.ru,
	benh@kernel.crashing.org
Cc: bharata@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC 10/18] powerpc/kvm: Add capability flag for hashed page table
 resizing
Date: Thu,  3 Mar 2016 12:59:41 +1100
Message-Id: <1456970389-28802-11-git-send-email-david@gibson.dropbear.id.au>
In-Reply-To: <1456970389-28802-1-git-send-email-david@gibson.dropbear.id.au>
References: <1456970389-28802-1-git-send-email-david@gibson.dropbear.id.au>
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
      userspace, rather than in the kernel".  In practice this is the same
      test as userspace already uses, but this makes it explicit.
    2 will mean "HPT resize available and implemented in-kernel"

For now we always return 1, but the intention is to return 2 once HPT
resize is implemented for KVM HV.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kvm/powerpc.c | 3 +++
 include/uapi/linux/kvm.h   | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 2f21ab7..a4250f1 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -572,6 +572,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_PPC_GET_SMMU_INFO:
 		r = 1;
 		break;
+	case KVM_CAP_SPAPR_RESIZE_HPT:
+		r = 1; /* resize allowed only if HPT is outside kernel */
+		break;
 #endif
 	default:
 		r = 0;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9da9051..7e7e0e3 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -850,6 +850,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_IOEVENTFD_ANY_LENGTH 122
 #define KVM_CAP_HYPERV_SYNIC 123
 #define KVM_CAP_S390_RI 124
+#define KVM_CAP_SPAPR_RESIZE_HPT 125
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.5.0
