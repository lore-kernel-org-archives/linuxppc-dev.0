Return-Path: <dja@axtens.net>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 138891A06C5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 16:37:34 +1100 (AEDT)
Received: by pabxg6 with SMTP id xg6so17395019pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2015 22:37:32 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 27/27] powerpc: dart_iommu: Remove check for controller_ops ==
 NULL case
Date: Wed, 25 Mar 2015 16:36:01 +1100
Message-Id: <1427261761-22952-28-git-send-email-dja@axtens.net>
In-Reply-To: <1427261761-22952-1-git-send-email-dja@axtens.net>
References: <1427261761-22952-1-git-send-email-dja@axtens.net>
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
