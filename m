Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id BD8A8DDEC1
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 06:18:13 +1100 (EST)
Received: from pd3mr2so.prod.shaw.ca
	(pd3mr2so-qfe3.prod.shaw.ca [10.0.141.178]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JU100KU96WLERF0@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 12:17:09 -0700 (MST)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
	by pd3mr2so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JU100LXR6SLMDB0@pd3mr2so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Wed, 02 Jan 2008 12:14:47 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JU100K9M6SL3R60@l-daemon> for linuxppc-dev@ozlabs.org;
	Wed, 02 Jan 2008 12:14:45 -0700 (MST)
Date: Wed, 02 Jan 2008 12:14:36 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 2/5] [POWERPC] cell: Use machine_*_initcall() hooks in	platform
	code
In-reply-to: <20080102191135.24178.99973.stgit@trillian.secretlab.ca>
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
	vitb@kernel.crashing.org, galak@kernel.crashing.org, olof@lixom.net
Message-id: <20080102191433.24178.68793.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080102191135.24178.99973.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/cell/io-workarounds.c |    5 +----
 arch/powerpc/platforms/cell/iommu.c          |    7 ++-----
 arch/powerpc/platforms/cell/pmu.c            |    5 +----
 arch/powerpc/platforms/cell/setup.c          |    5 +----
 arch/powerpc/platforms/celleb/iommu.c        |    5 +----
 arch/powerpc/platforms/celleb/setup.c        |    7 ++-----
 6 files changed, 8 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/cell/io-workarounds.c b/arch/powerpc/platforms/cell/io-workarounds.c
index b86076e..979d4b6 100644
--- a/arch/powerpc/platforms/cell/io-workarounds.c
+++ b/arch/powerpc/platforms/cell/io-workarounds.c
@@ -309,9 +309,6 @@ static int __init spider_pci_workaround_init(void)
 {
 	struct pci_controller *phb;
 
-	if (!machine_is(cell))
-		return 0;
-
 	/* Find spider bridges. We assume they have been all probed
 	 * in setup_arch(). If that was to change, we would need to
 	 * update this code to cope with dynamically added busses
@@ -343,4 +340,4 @@ static int __init spider_pci_workaround_init(void)
 
 	return 0;
 }
-arch_initcall(spider_pci_workaround_init);
+machine_arch_initcall(cell, spider_pci_workaround_init);
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 1221c6d..bceb5e1 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -700,10 +700,6 @@ static int __init cell_iommu_init(void)
 {
 	struct device_node *np;
 
-	if (!machine_is(cell) &&
-	    !machine_is(celleb_native))
-		return -ENODEV;
-
 	/* If IOMMU is disabled or we have little enough RAM to not need
 	 * to enable it, we setup a direct mapping.
 	 *
@@ -746,5 +742,6 @@ static int __init cell_iommu_init(void)
 
 	return 0;
 }
-arch_initcall(cell_iommu_init);
+machine_arch_initcall(cell, cell_iommu_init);
+machine_arch_initcall(celleb_native, cell_iommu_init);
 
diff --git a/arch/powerpc/platforms/cell/pmu.c b/arch/powerpc/platforms/cell/pmu.c
index 99d688e..69ed0d7 100644
--- a/arch/powerpc/platforms/cell/pmu.c
+++ b/arch/powerpc/platforms/cell/pmu.c
@@ -381,9 +381,6 @@ static int __init cbe_init_pm_irq(void)
 	unsigned int irq;
 	int rc, node;
 
-	if (!machine_is(cell))
-		return 0;
-
 	for_each_node(node) {
 		irq = irq_create_mapping(NULL, IIC_IRQ_IOEX_PMI |
 					       (node << IIC_IRQ_NODE_SHIFT));
@@ -404,7 +401,7 @@ static int __init cbe_init_pm_irq(void)
 
 	return 0;
 }
-arch_initcall(cbe_init_pm_irq);
+machine_arch_initcall(cell, cbe_init_pm_irq);
 
 void cbe_sync_irq(int node)
 {
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index 4f6347c..e6534b5 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -85,9 +85,6 @@ static int __init cell_publish_devices(void)
 {
 	int node;
 
-	if (!machine_is(cell))
-		return 0;
-
 	/* Publish OF platform devices for southbridge IOs */
 	of_platform_bus_probe(NULL, NULL, NULL);
 
@@ -101,7 +98,7 @@ static int __init cell_publish_devices(void)
 	}
 	return 0;
 }
-device_initcall(cell_publish_devices);
+machine_device_initcall(cell, cell_publish_devices);
 
 static void cell_mpic_cascade(unsigned int irq, struct irq_desc *desc)
 {
diff --git a/arch/powerpc/platforms/celleb/iommu.c b/arch/powerpc/platforms/celleb/iommu.c
index fbe718d..41e1e6f 100644
--- a/arch/powerpc/platforms/celleb/iommu.c
+++ b/arch/powerpc/platforms/celleb/iommu.c
@@ -92,9 +92,6 @@ static struct notifier_block celleb_of_bus_notifier = {
 
 static int __init celleb_init_iommu(void)
 {
-	if (!machine_is(celleb_beat))
-		return -ENODEV;
-
 	celleb_init_direct_mapping();
 	set_pci_dma_ops(&dma_direct_ops);
 	bus_register_notifier(&of_platform_bus_type, &celleb_of_bus_notifier);
@@ -102,4 +99,4 @@ static int __init celleb_init_iommu(void)
 	return 0;
 }
 
-arch_initcall(celleb_init_iommu);
+machine_arch_initcall(celleb_beat, celleb_init_iommu);
diff --git a/arch/powerpc/platforms/celleb/setup.c b/arch/powerpc/platforms/celleb/setup.c
index 0f0c468..f27ae1e 100644
--- a/arch/powerpc/platforms/celleb/setup.c
+++ b/arch/powerpc/platforms/celleb/setup.c
@@ -111,10 +111,6 @@ static struct of_device_id celleb_bus_ids[] __initdata = {
 
 static int __init celleb_publish_devices(void)
 {
-	if (!machine_is(celleb_beat) &&
-	    !machine_is(celleb_native))
-		return -ENODEV;
-
 	/* Publish OF platform devices for southbridge IOs */
 	of_platform_bus_probe(NULL, celleb_bus_ids, NULL);
 
@@ -122,7 +118,8 @@ static int __init celleb_publish_devices(void)
 
 	return 0;
 }
-device_initcall(celleb_publish_devices);
+machine_device_initcall(celleb_beat, celleb_publish_devices);
+machine_device_initcall(celleb_native, celleb_publish_devices);
 
 
 /*
