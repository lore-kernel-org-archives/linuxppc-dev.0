Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A36E2C0105
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 14:45:06 +1000 (EST)
Received: by mail-pd0-f174.google.com with SMTP id 10so1571618pdc.33
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jul 2013 21:45:04 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/10] KVM: PPC: reserve a capability and ioctl numbers for
 realmode VFIO
Date: Thu,  1 Aug 2013 14:44:25 +1000
Message-Id: <1375332272-22176-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1375332272-22176-1-git-send-email-aik@ozlabs.ru>
References: <1375332272-22176-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is to reserve a capablity number for upcoming support
of VFIO-IOMMU DMA operations in real mode.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

---
Changes:
2013/07/16:
* changed the number

2013/07/11:
* changed order in a file, added comment about a gap in ioctl number

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 include/uapi/linux/kvm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 99c2533..53c3f1f 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -668,6 +668,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_IRQ_XICS 92
 #define KVM_CAP_ARM_EL1_32BIT 93
 #define KVM_CAP_SPAPR_MULTITCE 94
+#define KVM_CAP_SPAPR_TCE_IOMMU 95
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -933,6 +934,9 @@ struct kvm_s390_ucas_mapping {
 #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct kvm_arm_device_addr)
 /* Available with KVM_CAP_PPC_RTAS */
 #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xac, struct kvm_rtas_token_args)
+/* 0xad and 0xaf are already taken */
+/* Available with KVM_CAP_SPAPR_TCE_IOMMU */
+#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xaf, struct kvm_create_spapr_tce_iommu)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
1.8.3.2
