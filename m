Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e31.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BC5BE2C016B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 May 2013 13:35:38 +1000 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 14 May 2013 21:35:36 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 845ED1FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:30:11 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4F3ZITd074652
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:35:18 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4F3ZHd2004123
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 21:35:18 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 19/22] powerpc/eeh: Initialization for PowerNV
Date: Wed, 15 May 2013 11:34:55 +0800
Message-Id: <1368588898-16224-20-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1368588898-16224-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/pci-ioda.c   |   17 ++++++++++++++---
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |    6 ++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1da578b..4dc4027 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -978,6 +978,11 @@ static void pnv_pci_ioda_fixup(void)
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
@@ -1048,7 +1053,9 @@ static u32 pnv_ioda_bdfn_to_pe(struct pnv_phb *phb, struct pci_bus *bus,
 	return phb->ioda.pe_rmap[(bus->number << 8) | devfn];
 }
 
-void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
+void __init pnv_pci_init_ioda_phb(struct device_node *np,
+				  u64 hub_id,
+				  int ioda_type)
 {
 	struct pci_controller *hose;
 	static int primary = 1;
@@ -1086,6 +1093,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 	hose->first_busno = 0;
 	hose->last_busno = 0xff;
 	hose->private_data = phb;
+	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
 	phb->type = ioda_type;
 
@@ -1171,6 +1179,9 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 		phb->ioda.io_size, phb->ioda.io_segsize);
 
 	phb->hose->ops = &pnv_pci_ops;
+#ifdef CONFIG_EEH
+	phb->eeh_ops = &ioda_eeh_ops;
+#endif
 
 	/* Setup RID -> PE mapping function */
 	phb->bdfn_to_pe = pnv_ioda_bdfn_to_pe;
@@ -1208,7 +1219,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np, int ioda_type)
 
 void pnv_pci_init_ioda2_phb(struct device_node *np)
 {
-	pnv_pci_init_ioda_phb(np, PNV_PHB_IODA2);
+	pnv_pci_init_ioda_phb(np, 0, PNV_PHB_IODA2);
 }
 
 void __init pnv_pci_init_ioda_hub(struct device_node *np)
@@ -1231,6 +1242,6 @@ void __init pnv_pci_init_ioda_hub(struct device_node *np)
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
