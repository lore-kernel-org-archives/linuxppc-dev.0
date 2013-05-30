Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4D67E2C030E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 18:24:31 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 30 May 2013 04:24:28 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B07516E8055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:21 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4U8OOBf58523738
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 04:24:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4U8ONHW000819
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 05:24:24 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 19/23] powerpc/eeh: Initialization for PowerNV
Date: Thu, 30 May 2013 16:24:01 +0800
Message-Id: <1369902245-5886-20-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1369902245-5886-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch initializes EEH for PowerNV platform. Because the OPAL
APIs requires HUB ID, we need trace that through struct pnv_phb.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c   |   16 +++++++++++++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |    6 ++++--
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9c9d15e..48b0940 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -973,6 +973,11 @@ static void pnv_pci_ioda_fixup(void)
 	pnv_pci_ioda_setup_PEs();
 	pnv_pci_ioda_setup_seg();
 	pnv_pci_ioda_setup_DMA();
+
+#ifdef CONFIG_EEH
+	eeh_addr_cache_build();
+	eeh_init();
+#endif
 }
 
 /*
@@ -1049,7 +1054,8 @@ static void pnv_pci_ioda_shutdown(struct pnv_phb *phb)
 		       OPAL_ASSERT_RESET);
 }
 
-void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
+void __init pnv_pci_init_ioda_phb(struct device_node *np,
+				  u64 hub_id, int ioda_type)
 {
 	struct pci_controller *hose;
 	static int primary = 1;
@@ -1087,6 +1093,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 	hose->first_busno = 0;
 	hose->last_busno = 0xff;
 	hose->private_data = phb;
+	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
 	phb->type = ioda_type;
 
@@ -1172,6 +1179,9 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 		phb->ioda.io_size, phb->ioda.io_segsize);
 
 	phb->hose->ops = &pnv_pci_ops;
+#ifdef CONFIG_EEH
+	phb->eeh_ops = &ioda_eeh_ops;
+#endif
 
 	/* Setup RID -> PE mapping function */
 	phb->bdfn_to_pe = pnv_ioda_bdfn_to_pe;
@@ -1212,7 +1222,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 
 void pnv_pci_init_ioda2_phb(struct device_node *np)
 {
-	pnv_pci_init_ioda_phb(np, PNV_PHB_IODA2);
+	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_IODA2);
 }
 
 void __init pnv_pci_init_ioda_hub(struct device_node *np)
@@ -1235,6 +1245,6 @@ void __init pnv_pci_init_ioda_hub(struct device_node *np)
 	for_each_child_of_node(np, phbn) {
 		/* Look for IODA1 PHBs */
 		if (of_device_is_compatible(phbn, "ibm,ioda-phb"))
-			pnv_pci_init_ioda_phb(phbn, PNV_PHB_IODA1);
+			pnv_pci_init_ioda_phb(phbn, hub_id, PNV_PHB_IODA1);
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 92b37a0..ae72616 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -92,7 +92,7 @@ static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 	set_iommu_table_base(&pdev->dev, &phb->p5ioc2.iommu_table);
 }
 
-static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np,
+static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 					   void *tce_mem, u64 tce_size)
 {
 	struct pnv_phb *phb;
@@ -133,6 +133,7 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np,
 	phb->hose->first_busno = 0;
 	phb->hose->last_busno = 0xff;
 	phb->hose->private_data = phb;
+	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
 	phb->type = PNV_PHB_P5IOC2;
 	phb->model = PNV_PHB_MODEL_P5IOC2;
@@ -226,7 +227,8 @@ void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
 	for_each_child_of_node(np, phbn) {
 		if (of_device_is_compatible(phbn, "ibm,p5ioc2-pcix") ||
 		    of_device_is_compatible(phbn, "ibm,p5ioc2-pciex")) {
-			pnv_pci_init_p5ioc2_phb(phbn, tce_mem, tce_per_phb);
+			pnv_pci_init_p5ioc2_phb(phbn, hub_id,
+					tce_mem, tce_per_phb);
 			tce_mem += tce_per_phb;
 		}
 	}
-- 
1.7.5.4
