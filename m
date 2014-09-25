Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D961E1A0121
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:04:42 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 25 Sep 2014 16:04:36 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4A72F2BB004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:04:34 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8P65t0x32899118
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:06:04 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8P641gj018082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 16:04:01 +1000
Date: Thu, 25 Sep 2014 16:03:36 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] powerpc/powernv: Fix dma_ops for bypass window
Message-ID: <20140925060336.GA16735@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1411618460-8153-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1411618460-8153-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2014 at 02:14:20PM +1000, Gavin Shan wrote:

Please ignore this. I was told by Ben some drivers don't call
set_dev_mask(). So I have to fix it in another way.

Thanks,
Gavin

>When using bypass window on IODA2, the incorrect DMA operations
>"dma_iommu_ops" is used by devices. The device driver calls
>dma_get_required_mask() to determine using 32-bits or bypass DMA
>window. Unfortunately, the returned DMA mask always forces the
>driver to use 32-bits DMA window. The problem was reported on
>the device as follows:
>
>0004:03:00.0 0107: 1000:0087 (rev 05)
>0004:03:00.0 Serial Attached SCSI controller: LSI Logic / Symbios \
>             Logic SAS2308 PCI-Express Fusion-MPT SAS-2 (rev 05)
>
>The patch fixes above issue by keeping things consistent: when
>enabling bypass window, we switch to "dma_direct_ops". Instead,
>switch to "pci_dma_ops" when disabling bypass window.
>
>Reported-by: Murali N. Iyer <mniyer@us.ibm.com>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 76 +++++++++++++++++++------------
> 1 file changed, 46 insertions(+), 30 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 36b1a7a..60e44d9 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -883,13 +883,29 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
> 		set_dma_offset(&pdev->dev, pe->tce_bypass_base);
> 	} else {
> 		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
>-		set_dma_ops(&pdev->dev, &dma_iommu_ops);
>+		set_dma_ops(&pdev->dev, get_pci_dma_ops());
> 		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
> 	}
> 	*pdev->dev.dma_mask = dma_mask;
> 	return 0;
> }
>
>+static void pnv_ioda_setup_dev_dma(struct pnv_ioda_pe *pe,
>+				   struct pci_dev *pdev,
>+				   bool add_to_iommu_group)
>+{
>+	if (pe->tce_bypass_enabled) {
>+		set_dma_ops(&pdev->dev, &dma_direct_ops);
>+		set_dma_offset(&pdev->dev, pe->tce_bypass_base);
>+	} else {
>+		set_dma_ops(&pdev->dev, get_pci_dma_ops());
>+		set_iommu_table_base(&pdev->dev, &pe->tce32_table);
>+	}
>+
>+	if (add_to_iommu_group)
>+		iommu_add_device(&pdev->dev);
>+}
>+
> static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
> 				   struct pci_bus *bus,
> 				   bool add_to_iommu_group)
>@@ -897,11 +913,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
> 	struct pci_dev *dev;
>
> 	list_for_each_entry(dev, &bus->devices, bus_list) {
>-		if (add_to_iommu_group)
>-			set_iommu_table_base_and_group(&dev->dev,
>-						       &pe->tce32_table);
>-		else
>-			set_iommu_table_base(&dev->dev, &pe->tce32_table);
>+		pnv_ioda_setup_dev_dma(pe, dev, add_to_iommu_group);
>
> 		if (dev->subordinate)
> 			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
>@@ -909,6 +921,15 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
> 	}
> }
>
>+static void pnv_ioda_setup_pe_dma(struct pnv_ioda_pe *pe,
>+				  bool add_to_iommu_group)
>+{
>+	if (pe->pdev)
>+		pnv_ioda_setup_dev_dma(pe, pe->pdev, add_to_iommu_group);
>+	else
>+		pnv_ioda_setup_bus_dma(pe, pe->pbus, add_to_iommu_group);
>+}
>+
> static void pnv_pci_ioda1_tce_invalidate(struct pnv_ioda_pe *pe,
> 					 struct iommu_table *tbl,
> 					 __be64 *startp, __be64 *endp, bool rm)
>@@ -1080,11 +1101,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
> 	iommu_init_table(tbl, phb->hose->node);
> 	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
>
>-	if (pe->pdev)
>-		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
>-	else
>-		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
>-
>+	pnv_ioda_setup_pe_dma(pe, true);
> 	return;
>  fail:
> 	/* XXX Failure: Try to fallback to 64-bit only ? */
>@@ -1101,7 +1118,13 @@ static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
> 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
> 	int64_t rc;
>
>+	/* Check if we really need do something */
>+	if (pe->tce_bypass_enabled == enable)
>+		return;
>+
> 	pe_info(pe, "%sabling 64-bit DMA bypass\n", enable ? "En" : "Dis");
>+	pe->tce_bypass_enabled = enable;
>+
> 	if (enable) {
> 		phys_addr_t top = memblock_end_of_DRAM();
>
>@@ -1117,22 +1140,15 @@ static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
> 						     window_id,
> 						     pe->tce_bypass_base,
> 						     0);
>-
>-		/*
>-		 * EEH needs the mapping between IOMMU table and group
>-		 * of those VFIO/KVM pass-through devices. We can postpone
>-		 * resetting DMA ops until the DMA mask is configured in
>-		 * host side.
>-		 */
>-		if (pe->pdev)
>-			set_iommu_table_base(&pe->pdev->dev, tbl);
>-		else
>-			pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
> 	}
>-	if (rc)
>+	if (rc != OPAL_SUCCESS) {
> 		pe_err(pe, "OPAL error %lld configuring bypass window\n", rc);
>-	else
>-		pe->tce_bypass_enabled = enable;
>+		return;
>+	}
>+
>+	/* Update base and operations */
>+	pe->tce_bypass_enabled = enable;
>+	pnv_ioda_setup_pe_dma(pe, false);
> }
>
> static void pnv_pci_ioda2_setup_bypass_pe(struct pnv_phb *phb,
>@@ -1213,12 +1229,12 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> 	iommu_init_table(tbl, phb->hose->node);
> 	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
>
>-	if (pe->pdev)
>-		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
>-	else
>-		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
>+	/* If the bypass window fails to be created, we still
>+	 * can use 32-bits window.
>+	 */
>+	pnv_ioda_setup_pe_dma(pe, true);
>
>-	/* Also create a bypass window */
>+	/* Create bypass window */
> 	pnv_pci_ioda2_setup_bypass_pe(phb, pe);
> 	return;
> fail:
>-- 
>1.8.3.2
>
