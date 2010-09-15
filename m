Return-Path: <nacc@us.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 15DDD1007DA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:06:43 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FHposR010407
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 13:51:50 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FI6ajU471292
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:06:37 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8FI6ZeA003173
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 12:06:36 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 10/15] ppc/pasemi: clean up pasemi iommu table initializations
Date: Wed, 15 Sep 2010 11:05:53 -0700
Message-Id: <1284573958-8397-11-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Milton Miller <miltonm@bga.com>,
	Paul Mackerras <paulus@samba.org>,
	Olof Johansson <olof@lixom.net>, Yinghai Lu <yinghai@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No need for empty helpers with iommu off, the ppc_md hooks are optional.

The direct_dma_ops are the default pci_dma_ops, so no need to set in the
them iommu off case.

No need to set the device tree device_node pci node iommu pointer, its
only used for dlpar remove.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pasemi/iommu.c |   19 +------------------
 1 files changed, 1 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/iommu.c b/arch/powerpc/platforms/pasemi/iommu.c
index 1f9fb2c..14943ef 100644
--- a/arch/powerpc/platforms/pasemi/iommu.c
+++ b/arch/powerpc/platforms/pasemi/iommu.c
@@ -156,20 +156,12 @@ static void iommu_table_iobmap_setup(void)
 
 static void pci_dma_bus_setup_pasemi(struct pci_bus *bus)
 {
-	struct device_node *dn;
-
 	pr_debug("pci_dma_bus_setup, bus %p, bus->self %p\n", bus, bus->self);
 
 	if (!iommu_table_iobmap_inited) {
 		iommu_table_iobmap_inited = 1;
 		iommu_table_iobmap_setup();
 	}
-
-	dn = pci_bus_to_OF_node(bus);
-
-	if (dn)
-		PCI_DN(dn)->iommu_table = &iommu_table_iobmap;
-
 }
 
 
@@ -192,9 +184,6 @@ static void pci_dma_dev_setup_pasemi(struct pci_dev *dev)
 	set_iommu_table_base(&dev->dev, &iommu_table_iobmap);
 }
 
-static void pci_dma_bus_setup_null(struct pci_bus *b) { }
-static void pci_dma_dev_setup_null(struct pci_dev *d) { }
-
 int __init iob_init(struct device_node *dn)
 {
 	unsigned long tmp;
@@ -251,14 +240,8 @@ void __init iommu_init_early_pasemi(void)
 	iommu_off = of_chosen &&
 			of_get_property(of_chosen, "linux,iommu-off", NULL);
 #endif
-	if (iommu_off) {
-		/* Direct I/O, IOMMU off */
-		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_null;
-		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_null;
-		set_pci_dma_ops(&dma_direct_ops);
-
+	if (iommu_off)
 		return;
-	}
 
 	iob_init(NULL);
 
-- 
1.7.0.4
