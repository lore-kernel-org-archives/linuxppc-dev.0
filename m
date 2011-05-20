Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70FA6B72C5
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 16:09:39 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p4K69Znw001078
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 01:09:36 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/14] powerpc/85xx: Cleanup PCIe support on corenet_ds boards
Date: Fri, 20 May 2011 01:09:23 -0500
Message-Id: <1305871771-16334-6-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Several changes on PCIe support on P3041DS/P4080DS/P5020DS boards:
* Add support for "fsl,qoriq-pcie-v2.2" needed by P3041 & P5020
* Removed support for setting primary_phb_addr as we have no ISA need
* Add PCI controller to of_platform_bus_probe (for EDAC)
* Cleanup building w/SWIOTLB off on P4080DS (not stricly PCIe related)

Signed-off-by: Kai.Jiang <Kai.Jiang@freescale.com>
Signed-off-by: Laurentiu TUDOR <Laurentiu.Tudor@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/85xx/corenet_ds.c |   29 ++++++++++++++---------------
 arch/powerpc/platforms/85xx/p4080_ds.c   |   18 +++---------------
 2 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/corenet_ds.c b/arch/powerpc/platforms/85xx/corenet_ds.c
index 2ab338c..10af3c7 100644
--- a/arch/powerpc/platforms/85xx/corenet_ds.c
+++ b/arch/powerpc/platforms/85xx/corenet_ds.c
@@ -3,7 +3,7 @@
  *
  * Maintained by Kumar Gala (see MAINTAINERS for contact information)
  *
- * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2009-2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -61,10 +61,6 @@ void __init corenet_ds_pic_init(void)
 	mpic_init(mpic);
 }
 
-#ifdef CONFIG_PCI
-static int primary_phb_addr;
-#endif
-
 /*
  * Setup the architecture
  */
@@ -85,17 +81,14 @@ void __init corenet_ds_setup_arch(void)
 #endif
 
 #ifdef CONFIG_PCI
-	for_each_compatible_node(np, "pci", "fsl,p4080-pcie") {
-		struct resource rsrc;
-		of_address_to_resource(np, 0, &rsrc);
-		if ((rsrc.start & 0xfffff) == primary_phb_addr)
-			fsl_add_bridge(np, 1);
-		else
+	for_each_node_by_type(np, "pci") {
+		if (of_device_is_compatible(np, "fsl,p4080-pcie") ||
+		    of_device_is_compatible(np, "fsl,qoriq-pcie-v2.2")) {
 			fsl_add_bridge(np, 0);
-
-		hose = pci_find_hose_for_OF_device(np);
-		max = min(max, hose->dma_window_base_cur +
-				hose->dma_window_size);
+			hose = pci_find_hose_for_OF_device(np);
+			max = min(max, hose->dma_window_base_cur +
+					hose->dma_window_size);
+		}
 	}
 #endif
 
@@ -116,6 +109,12 @@ static const struct of_device_id of_device_ids[] __devinitconst = {
 	{
 		.compatible	= "fsl,rapidio-delta",
 	},
+	{
+		.compatible	= "fsl,p4080-pcie",
+	},
+	{
+		.compatible	= "fsl,qoriq-pcie-v2.2",
+	},
 	{}
 };
 
diff --git a/arch/powerpc/platforms/85xx/p4080_ds.c b/arch/powerpc/platforms/85xx/p4080_ds.c
index 8417046..ec8320c 100644
--- a/arch/powerpc/platforms/85xx/p4080_ds.c
+++ b/arch/powerpc/platforms/85xx/p4080_ds.c
@@ -32,10 +32,6 @@
 
 #include "corenet_ds.h"
 
-#ifdef CONFIG_PCI
-static int primary_phb_addr;
-#endif
-
 /*
  * Called very early, device-tree isn't unflattened
  */
@@ -43,17 +39,7 @@ static int __init p4080_ds_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
 
-	if (of_flat_dt_is_compatible(root, "fsl,P4080DS")) {
-#ifdef CONFIG_PCI
-		/* treat PCIe1 as primary,
-		 * shouldn't matter as we have no ISA on the board
-		 */
-		primary_phb_addr = 0x0000;
-#endif
-		return 1;
-	} else {
-		return 0;
-	}
+	return of_flat_dt_is_compatible(root, "fsl,P4080DS");
 }
 
 define_machine(p4080_ds) {
@@ -71,4 +57,6 @@ define_machine(p4080_ds) {
 };
 
 machine_device_initcall(p4080_ds, corenet_ds_publish_devices);
+#ifdef CONFIG_SWIOTLB
 machine_arch_initcall(p4080_ds, swiotlb_setup_bus_notifier);
+#endif
-- 
1.7.3.4
