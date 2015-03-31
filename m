Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22b.google.com (mail-pa0-x22b.google.com
 [IPv6:2607:f8b0:400e:c03::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D86A31A0A0B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 16:02:15 +1100 (AEDT)
Received: by padcy3 with SMTP id cy3so8043263pad.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 22:02:13 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 19/19] powerpc: dart_iommu: Remove check for controller_ops
 == NULL case
Date: Tue, 31 Mar 2015 16:00:57 +1100
Message-Id: <1427778057-9505-20-git-send-email-dja@axtens.net>
In-Reply-To: <1427778057-9505-1-git-send-email-dja@axtens.net>
References: <1427778057-9505-1-git-send-email-dja@axtens.net>
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that we have ported the calls to iommu_init_early_dart to always
supply a pci_controller_ops struct, we can safely drop the check.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/sysdev/dart_iommu.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 87b8000..d00a566 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -395,20 +395,17 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 	if (dart_is_u4)
 		ppc_md.dma_set_mask = dart_dma_set_mask;
 
-	if (controller_ops) {
-		controller_ops->dma_dev_setup = pci_dma_dev_setup_dart;
-		controller_ops->dma_bus_setup = pci_dma_bus_setup_dart;
-	}
+	controller_ops->dma_dev_setup = pci_dma_dev_setup_dart;
+	controller_ops->dma_bus_setup = pci_dma_bus_setup_dart;
+
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_iommu_ops);
 	return;
 
  bail:
 	/* If init failed, use direct iommu and null setup functions */
-	if (controller_ops) {
-		controller_ops->dma_dev_setup = NULL;
-		controller_ops->dma_bus_setup = NULL;
-	}
+	controller_ops->dma_dev_setup = NULL;
+	controller_ops->dma_bus_setup = NULL;
 
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_direct_ops);
-- 
2.1.4
