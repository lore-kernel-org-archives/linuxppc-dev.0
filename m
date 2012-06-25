Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 02513B6F5A
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2012 02:05:44 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 25 Jun 2012 12:05:42 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7933E38C8145
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 11:43:34 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5PFhX4e36044852
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 11:43:33 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5PFhXci020617
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 12:43:33 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 7/8] ppc/pnv: using PCI core to do resource assignment
Date: Mon, 25 Jun 2012 23:43:20 +0800
Message-Id: <1340639001-28152-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340639001-28152-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340639001-28152-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the PCI probe flags "PCI_PROBE_ONLY | PCI_REASSIGN_ALL_RSRC"
used on powernv platform. That means the platform has to do the PCI
resource assignment by itself.

The patch changes the PCI probe flag to "PCI_REASSIGN_ALL_RSRC" so
that the PCI core will do the resource assignment. Also, the I/O
and MMIO minimal alignment for P2P bridges have been configured
while doing fixup for the PHBs.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   46 ++++++++++++-----------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ed8cf09..1368804 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1130,29 +1130,19 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb) { }
  */
 static void __devinit pnv_pci_ioda_fixup_phb(struct pci_controller *hose)
 {
-	resource_size_t size, align;
-	struct pci_bus *child;
-
-	/* Associate PEs per functions */
-	pnv_ioda_setup_PEs(hose->bus);
-
-	/* Calculate all resources */
-	pnv_ioda_calc_bus(hose->bus, IORESOURCE_IO, &size, &align);
-	pnv_ioda_calc_bus(hose->bus, IORESOURCE_MEM, &size, &align);
-
-	/* Apply then to HW */
-	pnv_ioda_update_resources(hose->bus);
-
-	/* Setup DMA */
-	pnv_ioda_setup_dma(hose->private_data);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_host_bridge *host_bridge;
 
-	/* Configure PCI Express settings */
-	list_for_each_entry(child, &hose->bus->children, node) {
-		struct pci_dev *self = child->self;
-		if (!self)
-			continue;
-		pcie_bus_configure_settings(child, self->pcie_mpss);
-	}
+	host_bridge = pci_bus_host_bridge(hose->bus);
+	host_bridge->io_align_shift = __ffs(phb->ioda.io_segsize);
+	host_bridge->mem_align_shift = __ffs(phb->ioda.m32_segsize);
+	/*
+	 * Note: We do not use the M64 window yet (64-bit MMIO window),
+	 * so we leave the alignment setting alone. In the long run,
+	 * we might use it for prefetchable memory regions in which
+	 * case pmem_align_shift will have to be adjusted as well.
+	 */
+	host_bridge->pmem_align_shift = host_bridge->mem_align_shift;
 }
 
 /*
@@ -1437,15 +1427,17 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	/* Setup MSI support */
 	pnv_pci_init_ioda_msis(phb);
 
-	/* We set both PCI_PROBE_ONLY and PCI_REASSIGN_ALL_RSRC. This is an
-	 * odd combination which essentially means that we skip all resource
-	 * fixups and assignments in the generic code, and do it all
-	 * ourselves here
+	/*
+	 * We pass the PCI probe flag PCI_REASSIGN_ALL_RSRC here
+	 * to let the PCI core do resource assignment. It's supposed
+	 * that the PCI core will do correct I/O and MMIO alignment
+	 * for the P2P bridge bars so that each PCI bus (excluding
+	 * the child P2P bridges) can form individual PE.
 	 */
 	ppc_md.pcibios_fixup_phb = pnv_pci_ioda_fixup_phb;
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
-	pci_add_flags(PCI_PROBE_ONLY | PCI_REASSIGN_ALL_RSRC);
+	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
 	rc = opal_pci_reset(phb_id, OPAL_PCI_IODA_TABLE_RESET, OPAL_ASSERT_RESET);
-- 
1.7.9.5
