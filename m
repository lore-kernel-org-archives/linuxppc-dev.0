Return-Path: <aik@ozlabs.ru>
Received: from mail-yh0-f53.google.com (mail-yh0-f53.google.com
 [209.85.213.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93E252C0307
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jul 2013 01:07:31 +1000 (EST)
Received: by mail-yh0-f53.google.com with SMTP id a41so1246052yho.40
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jul 2013 08:07:28 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/8] KVM: PPC: reserve a capability and ioctl numbers for
 realmode VFIO
Date: Sun,  7 Jul 2013 01:07:01 +1000
Message-Id: <1373123227-22969-3-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
References: <1373123227-22969-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
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
 include/uapi/linux/kvm.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 970b1f5..0865c01 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -667,6 +667,7 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_PPC_RTAS 91
 #define KVM_CAP_IRQ_XICS 92
 #define KVM_CAP_SPAPR_MULTITCE 93
+#define KVM_CAP_SPAPR_TCE_IOMMU 94
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -923,6 +924,7 @@ struct kvm_s390_ucas_mapping {
 /* Available with KVM_CAP_PPC_ALLOC_HTAB */
 #define KVM_PPC_ALLOCATE_HTAB	  _IOWR(KVMIO, 0xa7, __u32)
 #define KVM_CREATE_SPAPR_TCE	  _IOW(KVMIO,  0xa8, struct kvm_create_spapr_tce)
+#define KVM_CREATE_SPAPR_TCE_IOMMU _IOW(KVMIO,  0xaf, struct kvm_create_spapr_tce_iommu)
 /* Available with KVM_CAP_RMA */
 #define KVM_ALLOCATE_RMA	  _IOR(KVMIO,  0xa9, struct kvm_allocate_rma)
 /* Available with KVM_CAP_PPC_HTAB_FD */
-- 
1.8.3.2
