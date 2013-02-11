Return-Path: <aik@ozlabs.ru>
Received: from mail-da0-f53.google.com (mail-da0-f53.google.com
 [209.85.210.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ECD852C02AD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2013 16:09:20 +1100 (EST)
Received: by mail-da0-f53.google.com with SMTP id w3so304243dad.40
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Feb 2013 21:09:18 -0800 (PST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] iommu: adding missing
 kvm_iommu_map_pages/kvm_iommu_unmap_pages
Date: Mon, 11 Feb 2013 16:09:02 +1100
Message-Id: <1360559342-21423-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The IOMMU API implements groups creating/deletion, device binding
and IOMMU map/unmap operations.

The POWERPC implementation uses most of the API except map/unmap
operations which are implemented on POWERPC using hypercalls.

However in order to link a kernel with the CONFIG_IOMMU_API enabled,
the empty kvm_iommu_map_pages/kvm_iommu_unmap_pages have to be
defined, so does the patch.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>
---
 arch/powerpc/kernel/iommu.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 31c4fdc..7c309fe 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -36,6 +36,7 @@
 #include <linux/hash.h>
 #include <linux/fault-inject.h>
 #include <linux/pci.h>
+#include <linux/kvm_host.h>
 #include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/iommu.h>
@@ -860,3 +861,19 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 		free_pages((unsigned long)vaddr, get_order(size));
 	}
 }
+
+#ifdef CONFIG_IOMMU_API
+/*
+ * SPAPR TCE API
+ */
+
+/* POWERPC does not use IOMMU API for mapping/unmapping */
+int kvm_iommu_map_pages(struct kvm *kvm, struct kvm_memory_slot *slot)
+{
+	return 0;
+}
+void kvm_iommu_unmap_pages(struct kvm *kvm, struct kvm_memory_slot *slot)
+{
+}
+
+#endif /* CONFIG_IOMMU_API */
-- 
1.7.10.4
