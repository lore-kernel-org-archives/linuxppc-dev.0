Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED1911A0B87
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:31:02 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Wed, 9 Mar 2016 16:31:02 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 23E5B2BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 17:31:00 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u296UqpS59965548
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:31:00 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u296URC8011892
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 9 Mar 2016 17:30:27 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH kernel 06/10] powerpc/powernv/npu: Simplify DMA setup
Date: Wed,  9 Mar 2016 17:29:02 +1100
Message-Id: <1457504946-40649-7-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

NPU devices are quite specific, in fact they represent side DMA channel
of a GPU device. The GPU/NPU driver never actually configures DMA
for NPU devices, instead it relies on the platform code to propagate
DMA setup to NPU devices when a main GPU device is being configured.
When GPU is being set up, the same configuration - bypass or 32bit DMA -
is used for NPU. This makes DMA setup explicit.

pnv_npu_ioda_controller_ops::pnv_npu_dma_set_mask is moved to pci-ioda,
made static and prints warning as dma_set_mask() should never be called
on this function as in any case it will not configure GPU; so we make
this explicit.

Instead of using PNV_IODA_PE_PEER and peers[] (which next patch will
remove), we test every PCI device if there are corresponding NVLink
devices. If there are any, we propagate bypass mode to just found NPU
devices by calling the setup helper directly (which takes @bypass) and
avoid guessing (i.e. calculating from DMA mask) whether we need bypass
or not on NPU devices. Since DMA setup happens in very rare occasion,
this will not slow down booting or VFIO start/stop much.

This renames pnv_npu_disable_bypass to pnv_npu_dma_set_32 to make it
more clear what the function really does which is programming 32bit
table address to the TVT ("disabling bypass" means writing zeroes to
the TVT).

This removes pnv_npu_dma_set_bypass() from pnv_npu_ioda_fixup() as
the DMA configuration on NPU does not matter until dma_set_mask() is
called on GPU and that will do the NPU DMA configuration.

This removes phb->dma_dev_setup initialization for NPU as
pnv_pci_ioda_dma_dev_setup is no-op for it anyway.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c  | 90 ++++++++++++++-----------------
 arch/powerpc/platforms/powernv/pci-ioda.c | 30 +++++------
 arch/powerpc/platforms/powernv/pci.h      |  3 +-
 3 files changed, 54 insertions(+), 69 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 5bd5fee..8960e46 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -196,10 +196,9 @@ void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe)
 }
 
 /*
- * For the NPU we want to point the TCE table at the same table as the
- * real PCI device.
+ * Enables 32 bit DMA on NPU.
  */
-static void pnv_npu_disable_bypass(struct pnv_ioda_pe *npe)
+static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
 {
 	struct pnv_phb *phb = npe->phb;
 	struct pci_dev *gpdev;
@@ -235,72 +234,63 @@ static void pnv_npu_disable_bypass(struct pnv_ioda_pe *npe)
 }
 
 /*
- * Enable/disable bypass mode on the NPU. The NPU only supports one
+ * Enables bypass mode on the NPU. The NPU only supports one
  * window per link, so bypass needs to be explicitly enabled or
  * disabled. Unlike for a PHB3 bypass and non-bypass modes can't be
  * active at the same time.
  */
-int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe, bool enable)
+static int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe)
 {
 	struct pnv_phb *phb = npe->phb;
 	int64_t rc = 0;
+	phys_addr_t top = memblock_end_of_DRAM();
 
 	if (phb->type != PNV_PHB_NPU || !npe->pdev)
 		return -EINVAL;
 
-	if (enable) {
-		/* Enable the bypass window */
-		phys_addr_t top = memblock_end_of_DRAM();
+	/* Enable the bypass window */
 
-		npe->tce_bypass_base = 0;
-		top = roundup_pow_of_two(top);
-		dev_info(&npe->pdev->dev, "Enabling bypass for PE %d\n",
-			 npe->pe_number);
-		rc = opal_pci_map_pe_dma_window_real(phb->opal_id,
-					npe->pe_number, npe->pe_number,
-					npe->tce_bypass_base, top);
-	} else {
-		/*
-		 * Disable the bypass window by replacing it with the
-		 * TCE32 window.
-		 */
-		pnv_npu_disable_bypass(npe);
-	}
+	npe->tce_bypass_base = 0;
+	top = roundup_pow_of_two(top);
+	dev_info(&npe->pdev->dev, "Enabling bypass for PE %d\n",
+			npe->pe_number);
+	rc = opal_pci_map_pe_dma_window_real(phb->opal_id,
+			npe->pe_number, npe->pe_number,
+			npe->tce_bypass_base, top);
 
 	return rc;
 }
 
-int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask)
+void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass)
 {
-	struct pci_controller *hose = pci_bus_to_host(npdev->bus);
-	struct pnv_phb *phb = hose->private_data;
-	struct pci_dn *pdn = pci_get_pdn(npdev);
-	struct pnv_ioda_pe *npe, *gpe;
-	struct pci_dev *gpdev;
-	uint64_t top;
-	bool bypass = false;
+	int i;
+	struct pnv_phb *phb;
+	struct pci_dn *pdn;
+	struct pnv_ioda_pe *npe;
+	struct pci_dev *npdev;
 
-	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
-		return -ENXIO;
+	for (i = 0; ; ++i) {
+		npdev = pnv_pci_get_npu_dev(gpdev, i);
 
-	/* We only do bypass if it's enabled on the linked device */
-	npe = &phb->ioda.pe_array[pdn->pe_number];
-	gpe = get_gpu_pci_dev_and_pe(npe, &gpdev);
-	if (!gpe)
-		return -ENODEV;
+		if (!npdev)
+			break;
 
-	if (gpe->tce_bypass_enabled) {
-		top = gpe->tce_bypass_base + memblock_end_of_DRAM() - 1;
-		bypass = (dma_mask >= top);
+		pdn = pci_get_pdn(npdev);
+		if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
+			return;
+
+		phb = pci_bus_to_host(npdev->bus)->private_data;
+
+		/* We only do bypass if it's enabled on the linked device */
+		npe = &phb->ioda.pe_array[pdn->pe_number];
+
+		if (bypass) {
+			dev_info(&npdev->dev,
+					"Using 64-bit DMA iommu bypass\n");
+			pnv_npu_dma_set_bypass(npe);
+		} else {
+			dev_info(&npdev->dev, "Using 32-bit DMA via iommu\n");
+			pnv_npu_dma_set_32(npe);
+		}
 	}
-
-	if (bypass)
-		dev_info(&npdev->dev, "Using 64-bit DMA iommu bypass\n");
-	else
-		dev_info(&npdev->dev, "Using 32-bit DMA via iommu\n");
-
-	pnv_npu_dma_set_bypass(npe, bypass);
-	*npdev->dev.dma_mask = dma_mask;
-
-	return 0;
 }
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 90cdf49..47085b7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1640,8 +1640,6 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 	struct pnv_ioda_pe *pe;
 	uint64_t top;
 	bool bypass = false;
-	struct pci_dev *linked_npu_dev;
-	int i;
 
 	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
 		return -ENODEV;;
@@ -1662,15 +1660,7 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 	*pdev->dev.dma_mask = dma_mask;
 
 	/* Update peer npu devices */
-	if (pe->flags & PNV_IODA_PE_PEER)
-		for (i = 0; i < PNV_IODA_MAX_PEER_PES; i++) {
-			if (!pe->peers[i])
-				continue;
-
-			linked_npu_dev = pe->peers[i]->pdev;
-			if (dma_get_mask(&linked_npu_dev->dev) != dma_mask)
-				dma_set_mask(&linked_npu_dev->dev, dma_mask);
-		}
+	pnv_npu_try_dma_set_bypass(pdev, bypass);
 
 	return 0;
 }
@@ -3120,7 +3110,6 @@ static void pnv_npu_ioda_fixup(void)
 			enable_bypass = dma_get_mask(&pe->pdev->dev) ==
 				DMA_BIT_MASK(64);
 			pnv_npu_init_dma_pe(pe);
-			pnv_npu_dma_set_bypass(pe, enable_bypass);
 		}
 	}
 }
@@ -3272,6 +3261,14 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
        .shutdown = pnv_pci_ioda_shutdown,
 };
 
+static int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask)
+{
+	dev_err_once(&npdev->dev,
+			"%s operation unsupported for NVLink devices\n",
+			__func__);
+	return -EPERM;
+}
+
 static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.dma_dev_setup = pnv_pci_dma_dev_setup,
 #ifdef CONFIG_PCI_MSI
@@ -3428,9 +3425,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	/* Setup RID -> PE mapping function */
 	phb->bdfn_to_pe = pnv_ioda_bdfn_to_pe;
 
-	/* Setup TCEs */
-	phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
-
 	/* Setup MSI support */
 	pnv_pci_init_ioda_msis(phb);
 
@@ -3443,10 +3437,12 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 
-	if (phb->type == PNV_PHB_NPU)
+	if (phb->type == PNV_PHB_NPU) {
 		hose->controller_ops = pnv_npu_ioda_controller_ops;
-	else
+	} else {
+		phb->dma_dev_setup = pnv_pci_ioda_dma_dev_setup;
 		hose->controller_ops = pnv_pci_ioda_controller_ops;
+	}
 
 #ifdef CONFIG_PCI_IOV
 	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov_resources;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 0b89a4c..d574a9d 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -239,8 +239,7 @@ extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
 /* Nvlink functions */
 extern void pnv_npu_init_dma_pe(struct pnv_ioda_pe *npe);
 extern void pnv_npu_setup_dma_pe(struct pnv_ioda_pe *npe);
-extern int pnv_npu_dma_set_bypass(struct pnv_ioda_pe *npe, bool enabled);
-extern int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask);
+extern void pnv_npu_try_dma_set_bypass(struct pci_dev *gpdev, bool bypass);
 extern void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_phb *phb, bool rm);
 
 #endif /* __POWERNV_PCI_H */
-- 
2.5.0.rc3
