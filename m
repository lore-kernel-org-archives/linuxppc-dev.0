Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3AEE42C03D2
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2013 01:18:03 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 1 Mar 2013 09:18:01 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id BDF8338C801E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2013 09:17:59 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r21EHxOC29687880
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:59 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r21EHwIj009938
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Mar 2013 09:17:59 -0500
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 19/22] powerpc/eeh: Initialization for PowerNV
Date: Fri,  1 Mar 2013 22:17:17 +0800
Message-Id: <1362147440-14096-20-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1362147440-14096-1-git-send-email-shangw@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/pci-ioda.c   |   13 +++++++++++--
 arch/powerpc/platforms/powernv/pci-p5ioc2.c |    6 ++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8e90e89..4af5fdf 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -782,6 +782,11 @@ static void pnv_pci_ioda_fixup(void)
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
@@ -852,7 +857,7 @@ static u32 pnv_ioda_bdfn_to_pe(struct pnv_phb *phb, struct pci_bus *bus,
 	return phb->ioda.pe_rmap[(bus->number << 8) | devfn];
 }
 
-void __init pnv_pci_init_ioda1_phb(struct device_node *np)
+void __init pnv_pci_init_ioda1_phb(struct device_node *np, u64 hub_id)
 {
 	struct pci_controller *hose;
 	static int primary = 1;
@@ -889,6 +894,7 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	hose->first_busno = 0;
 	hose->last_busno = 0xff;
 	hose->private_data = phb;
+	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
 	phb->type = PNV_PHB_IODA1;
 
@@ -985,6 +991,9 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 		pr_devel(" M32_SAR  = 0x%016llx\n", in_be64(phb->regs + 0x1a0));
 	}
 	phb->hose->ops = &pnv_pci_ops;
+#ifdef CONFIG_EEH
+	phb->eeh_ops = &ioda_eeh_ops;
+#endif
 
 	/* Setup RID -> PE mapping function */
 	phb->bdfn_to_pe = pnv_ioda_bdfn_to_pe;
@@ -1034,6 +1043,6 @@ void __init pnv_pci_init_ioda_hub(struct device_node *np)
 	for_each_child_of_node(np, phbn) {
 		/* Look for IODA1 PHBs */
 		if (of_device_is_compatible(phbn, "ibm,ioda-phb"))
-			pnv_pci_init_ioda1_phb(phbn);
+			pnv_pci_init_ioda1_phb(phbn, hub_id);
 	}
 }
diff --git a/arch/powerpc/platforms/powernv/pci-p5ioc2.c b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
index 7db8771..deab179 100644
--- a/arch/powerpc/platforms/powernv/pci-p5ioc2.c
+++ b/arch/powerpc/platforms/powernv/pci-p5ioc2.c
@@ -93,7 +93,7 @@ static void pnv_pci_p5ioc2_dma_dev_setup(struct pnv_phb *phb,
 	set_iommu_table_base(&pdev->dev, &phb->p5ioc2.iommu_table);
 }
 
-static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np,
+static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np, u64 hub_id,
 					   void *tce_mem, u64 tce_size)
 {
 	struct pnv_phb *phb;
@@ -134,6 +134,7 @@ static void __init pnv_pci_init_p5ioc2_phb(struct device_node *np,
 	phb->hose->first_busno = 0;
 	phb->hose->last_busno = 0xff;
 	phb->hose->private_data = phb;
+	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
 	phb->type = PNV_PHB_P5IOC2;
 	phb->model = PNV_PHB_MODEL_P5IOC2;
@@ -227,7 +228,8 @@ void __init pnv_pci_init_p5ioc2_hub(struct device_node *np)
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
