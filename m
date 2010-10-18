Return-Path: <nacc@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7EE8AB70E6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 04:27:35 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9IHIJ40020281
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:18:19 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9IHRFlO145522
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:27:15 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9IHREc0006826
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 11:27:15 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [PATCH 3/7] ppc/pasemi: clean up pasemi iommu table initializations
Date: Mon, 18 Oct 2010 10:27:00 -0700
Message-Id: <1287422825-14999-4-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1287422825-14999-1-git-send-email-nacc@us.ibm.com>
References: <1287422825-14999-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, miltonm@bga.com,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
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
Acked-by: Olof Johansson <olof@lixom.net>
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
1.7.1
