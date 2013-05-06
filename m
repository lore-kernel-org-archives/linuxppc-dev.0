Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
 [209.85.220.47])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EFBAE2C0116
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 17:22:36 +1000 (EST)
Received: by mail-pa0-f47.google.com with SMTP id kl13so1872697pab.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 May 2013 00:22:34 -0700 (PDT)
From: aik@ozlabs.ru
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] KVM: PPC: iommu: Add missing
 kvm_iommu_map_pages/kvm_iommu_unmap_pages
Date: Mon,  6 May 2013 17:21:58 +1000
Message-Id: <51875a36.25ac440a.50d9.ffffe90d@mx.google.com>
In-Reply-To: <1367824921-27151-1-git-send-email-y>
References: <1367824921-27151-1-git-send-email-y>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

The IOMMU API implements groups creating/deletion, device binding
and IOMMU map/unmap operations.

The PowerPC implementation uses most of the API except map/unmap
operations, which are implemented on POWER using hypercalls.

However, in order to link a kernel with the CONFIG_IOMMU_API enabled,
the empty kvm_iommu_map_pages/kvm_iommu_unmap_pages have to be
defined, so this defines them.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_host.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index b6a047e..c025d91 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -603,4 +603,18 @@ struct kvm_vcpu_arch {
 
 #define __KVM_HAVE_ARCH_WQP
 
+#ifdef CONFIG_IOMMU_API
+/* POWERPC does not use IOMMU API for mapping/unmapping */
+static inline int kvm_iommu_map_pages(struct kvm *kvm,
+		struct kvm_memory_slot *slot)
+{
+	return 0;
+}
+
+static inline void kvm_iommu_unmap_pages(struct kvm *kvm,
+		struct kvm_memory_slot *slot)
+{
+}
+#endif /* CONFIG_IOMMU_API */
+
 #endif /* __POWERPC_KVM_HOST_H__ */
-- 
1.7.10.4
