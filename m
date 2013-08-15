Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-f53.google.com (mail-pb0-f53.google.com
 [209.85.160.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6F1D2C00FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 17:49:36 +1000 (EST)
Received: by mail-pb0-f53.google.com with SMTP id up15so461603pbc.40
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Aug 2013 00:49:34 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8] KVM: PPC: reserve a capability and ioctl numbers for
 realmode VFIO
Date: Thu, 15 Aug 2013 17:49:26 +1000
Message-Id: <1376552966-8529-1-git-send-email-aik@ozlabs.ru>
Cc: Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>
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

The last ioctl in the group which KVM_CREATE_SPAPR_TCE_IOMMU is added to
is 0xac, the next two numbers are taken - 0xad for KVM_KVMCLOCK_CTRL and
0xae for KVM_ARM_VCPU_INIT. So the KVM_CREATE_SPAPR_TCE_IOMMU ioclt gets
0xaf.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

---
Changes:
2013/08/15 v8:
* fixed comment again

2013/08/15:
* fixed mistype in comments
* fixed commit message which says what uses ioctls 0xad and 0xae

2013/07/16:
* changed the number

2013/07/11:
* changed order in a file, added comment about a gap in ioctl number
---
 include/uapi/linux/kvm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 99c2533..bd94127 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -668,6 +668,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_IRQ_XICS 92
 #define KVM_CAP_ARM_EL1_32BIT 93
 #define KVM_CAP_SPAPR_MULTITCE 94
+#define KVM_CAP_SPAPR_TCE_IOMMU 95
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -933,6 +934,11 @@ struct kvm_s390_ucas_mapping {
 #define KVM_ARM_SET_DEVICE_ADDR	  _IOW(KVMIO,  0xab, struct kvm_arm_device_addr)
 /* Available with KVM_CAP_PPC_RTAS */
 #define KVM_PPC_RTAS_DEFINE_TOKEN _IOW(KVMIO,  0xac, struct kvm_rtas_token_args)
+/* 0xad is taken by KVM_KVMCLOCK_CTRL */
+/* 0xae is taken by KVM_ARM_VCPU_INIT */
+/* Available with KVM_CAP_SPAPR_TCE_IOMMU */
+#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xaf, \
+					struct kvm_create_spapr_tce_iommu)
 
 /* ioctl for vm fd */
 #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
-- 
1.8.3.2
