Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB5A42C0182
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 21:04:11 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 23 Apr 2013 05:04:07 -0600
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
 [9.17.195.106])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 2F6483E40040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 05:03:47 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3NB409R165028
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 05:04:00 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3NB40Dr027142
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Apr 2013 05:04:00 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/5] powerpc/powernv: Supports PHB3
Date: Tue, 23 Apr 2013 19:03:50 +0800
Message-Id: <1366715034-24594-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366715034-24594-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366715034-24594-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch intends to initialize PHB3 during system boot stage. The
flag "PNV_PHB_MODEL_PHB3" is introduced to differentiate IODA2
compatible PHB3 from other types of PHBs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   62 +++++++++++++++--------------
 arch/powerpc/platforms/powernv/pci.c      |    7 +++-
 arch/powerpc/platforms/powernv/pci.h      |    8 ++-
 3 files changed, 43 insertions(+), 34 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index a5c5f15..3d4e958 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -852,18 +852,19 @@ static u32 pnv_ioda_bdfn_to_pe(struct pnv_phb *phb, struct pci_bus *bus,
 	return phb->ioda.pe_rmap[(bus->number << 8) | devfn];
 }
 
-void __init pnv_pci_init_ioda1_phb(struct device_node *np)
+void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 {
 	struct pci_controller *hose;
 	static int primary = 1;
 	struct pnv_phb *phb;
 	unsigned long size, m32map_off, iomap_off, pemap_off;
 	const u64 *prop64;
+	const u32 *prop32;
 	u64 phb_id;
 	void *aux;
 	long rc;
 
-	pr_info(" Initializing IODA OPAL PHB %s\n", np->full_name);
+	pr_info(" Initializing IODA%d OPAL PHB %s\n", ioda_type, np->full_name);
 
 	prop64 = of_get_property(np, "ibm,opal-phbid", NULL);
 	if (!prop64) {
@@ -890,37 +891,34 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	hose->last_busno = 0xff;
 	hose->private_data = phb;
 	phb->opal_id = phb_id;
-	phb->type = PNV_PHB_IODA1;
+	phb->type = ioda_type;
 
 	/* Detect specific models for error handling */
 	if (of_device_is_compatible(np, "ibm,p7ioc-pciex"))
 		phb->model = PNV_PHB_MODEL_P7IOC;
+	else if (of_device_is_compatible(np, "ibm,p8-pciex"))
+		phb->model = PNV_PHB_MODEL_PHB3;
 	else
 		phb->model = PNV_PHB_MODEL_UNKNOWN;
 
-	/* We parse "ranges" now since we need to deduce the register base
-	 * from the IO base
-	 */
+	/* Parse 32-bit and IO ranges (if any) */
 	pci_process_bridge_OF_ranges(phb->hose, np, primary);
 	primary = 0;
 
-	/* Magic formula from Milton */
+	/* Get registers */
 	phb->regs = of_iomap(np, 0);
 	if (phb->regs == NULL)
 		pr_err("  Failed to map registers !\n");
 
-
-	/* XXX This is hack-a-thon. This needs to be changed so that:
-	 *  - we obtain stuff like PE# etc... from device-tree
-	 *  - we properly re-allocate M32 ourselves
-	 *    (the OFW one isn't very good)
-	 */
-
 	/* Initialize more IODA stuff */
-	phb->ioda.total_pe = 128;
+	prop32 = of_get_property(np, "ibm,opal-num-pes", NULL);
+	if (!prop32)
+		phb->ioda.total_pe = 1;
+	else
+		phb->ioda.total_pe = *prop32;
 
 	phb->ioda.m32_size = resource_size(&hose->mem_resources[0]);
-	/* OFW Has already off top 64k of M32 space (MSI space) */
+	/* FW Has already off top 64k of M32 space (MSI space) */
 	phb->ioda.m32_size += 0x10000;
 
 	phb->ioda.m32_segsize = phb->ioda.m32_size / phb->ioda.total_pe;
@@ -930,7 +928,10 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	phb->ioda.io_segsize = phb->ioda.io_size / phb->ioda.total_pe;
 	phb->ioda.io_pci_base = 0; /* XXX calculate this ? */
 
-	/* Allocate aux data & arrays */
+	/* Allocate aux data & arrays
+	 *
+	 * XXX TODO: Don't allocate io segmap on PHB3
+	 */
 	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
 	m32map_off = size;
 	size += phb->ioda.total_pe * sizeof(phb->ioda.m32_segmap[0]);
@@ -960,7 +961,7 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	hose->mem_resources[2].start = 0;
 	hose->mem_resources[2].end = 0;
 
-#if 0
+#if 0 /* We should really do that ... */
 	rc = opal_pci_set_phb_mem_window(opal->phb_id,
 					 window_type,
 					 window_num,
@@ -974,16 +975,6 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 		phb->ioda.m32_size, phb->ioda.m32_segsize,
 		phb->ioda.io_size, phb->ioda.io_segsize);
 
-	if (phb->regs)  {
-		pr_devel(" BUID     = 0x%016llx\n", in_be64(phb->regs + 0x100));
-		pr_devel(" PHB2_CR  = 0x%016llx\n", in_be64(phb->regs + 0x160));
-		pr_devel(" IO_BAR   = 0x%016llx\n", in_be64(phb->regs + 0x170));
-		pr_devel(" IO_BAMR  = 0x%016llx\n", in_be64(phb->regs + 0x178));
-		pr_devel(" IO_SAR   = 0x%016llx\n", in_be64(phb->regs + 0x180));
-		pr_devel(" M32_BAR  = 0x%016llx\n", in_be64(phb->regs + 0x190));
-		pr_devel(" M32_BAMR = 0x%016llx\n", in_be64(phb->regs + 0x198));
-		pr_devel(" M32_SAR  = 0x%016llx\n", in_be64(phb->regs + 0x1a0));
-	}
 	phb->hose->ops = &pnv_pci_ops;
 
 	/* Setup RID -> PE mapping function */
@@ -1011,7 +1002,18 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	rc = opal_pci_reset(phb_id, OPAL_PCI_IODA_TABLE_RESET, OPAL_ASSERT_RESET);
 	if (rc)
 		pr_warning("  OPAL Error %ld performing IODA table reset !\n", rc);
-	opal_pci_set_pe(phb_id, 0, 0, 7, 1, 1 , OPAL_MAP_PE);
+
+	/*
+	 * On IODA1 map everything to PE#0, on IODA2 we assume the IODA reset
+	 * has cleared the RTT which has the same effect
+	 */
+	if (ioda_type == PNV_PHB_IODA1)
+		opal_pci_set_pe(phb_id, 0, 0, 7, 1, 1 , OPAL_MAP_PE);
+}
+
+void pnv_pci_init_ioda2_phb(struct device_node *np)
+{
+	pnv_pci_init_ioda_phb(np, PNV_PHB_IODA2);
 }
 
 void __init pnv_pci_init_ioda_hub(struct device_node *np)
@@ -1034,6 +1036,6 @@ void __init pnv_pci_init_ioda_hub(struct device_node *np)
 	for_each_child_of_node(np, phbn) {
 		/* Look for IODA1 PHBs */
 		if (of_device_is_compatible(phbn, "ibm,ioda-phb"))
-			pnv_pci_init_ioda1_phb(phbn);
+			pnv_pci_init_ioda_phb(phbn, PNV_PHB_IODA1);
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 42eee93..83514dc 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -492,12 +492,13 @@ static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 		pnv_pci_dma_fallback_setup(hose, pdev);
 }
 
-/* Fixup wrong class code in p7ioc root complex */
+/* Fixup wrong class code in p7ioc and p8 root complex */
 static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
 {
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x2da, pnv_p7ioc_rc_quirk);
 
 static int pnv_pci_probe_mode(struct pci_bus *bus)
 {
@@ -558,6 +559,10 @@ void __init pnv_pci_init(void)
 		if (!found_ioda)
 			for_each_compatible_node(np, NULL, "ibm,p5ioc2")
 				pnv_pci_init_p5ioc2_hub(np);
+
+		/* Look for ioda2 built-in PHB3's */
+		for_each_compatible_node(np, NULL, "ibm,ioda2-phb")
+			pnv_pci_init_ioda2_phb(np);
 	}
 
 	/* Setup the linkage between OF nodes and PHBs */
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 42ddfba..f6314d6 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -4,9 +4,9 @@
 struct pci_dn;
 
 enum pnv_phb_type {
-	PNV_PHB_P5IOC2,
-	PNV_PHB_IODA1,
-	PNV_PHB_IODA2,
+	PNV_PHB_P5IOC2	= 0,
+	PNV_PHB_IODA1	= 1,
+	PNV_PHB_IODA2	= 2,
 };
 
 /* Precise PHB model for error management */
@@ -14,6 +14,7 @@ enum pnv_phb_model {
 	PNV_PHB_MODEL_UNKNOWN,
 	PNV_PHB_MODEL_P5IOC2,
 	PNV_PHB_MODEL_P7IOC,
+	PNV_PHB_MODEL_PHB3,
 };
 
 #define PNV_PCI_DIAG_BUF_SIZE	4096
@@ -148,6 +149,7 @@ extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 				      u64 dma_offset);
 extern void pnv_pci_init_p5ioc2_hub(struct device_node *np);
 extern void pnv_pci_init_ioda_hub(struct device_node *np);
+extern void pnv_pci_init_ioda2_phb(struct device_node *np);
 
 
 #endif /* __POWERNV_PCI_H */
-- 
1.7.5.4
