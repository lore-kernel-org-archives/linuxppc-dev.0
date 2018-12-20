Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E5FC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 08:41:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0A021720
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 08:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0A021720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L4xR5t8rzDr6Y
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 19:41:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 43L4YZ2Dq9zDqvZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 19:24:34 +1100 (AEDT)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 1956FAE8032F;
 Thu, 20 Dec 2018 03:24:29 -0500 (EST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v7 10/20] powerpc/iommu_api: Move IOMMU groups setup to
 a single place
Date: Thu, 20 Dec 2018 19:23:40 +1100
Message-Id: <20181220082350.58113-11-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220082350.58113-1-aik@ozlabs.ru>
References: <20181220082350.58113-1-aik@ozlabs.ru>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Christoph Hellwig <hch@infradead.org>,
 Jose Ricardo Ziviani <joserz@linux.ibm.com>, kvm@vger.kernel.org,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alistair Popple <alistair@popple.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
 Piotr Jaroszynski <pjaroszynski@nvidia.com>,
 =?UTF-8?q?Leonardo=20Augusto=20Guimar=C3=A3es=20Garcia?= <lagarcia@br.ibm.com>,
 Reza Arbab <arbab@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Registering new IOMMU groups and adding devices to them are separated in
code and the latter is dug in the DMA setup code which it does not
really belong to.

This moved IOMMU groups setup to a separate helper which registers a group
and adds devices as before. This does not make a difference as IOMMU
groups are not used anyway; the only dependency here is that
iommu_add_device() requires a valid pointer to an iommu_table
(set by set_iommu_table_base()).

To keep the old behaviour, this does not add new IOMMU groups for PEs
with no DMA weight and also skips NVLink bridges which do not have
pci_controller_ops::setup_bridge (the normal way of adding PEs).

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v5:
* fixed compile with defined but not used pnv_ioda_setup_bus_iommu_group();
unfortunately defining a dummy version looks uglier than #ifdef
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 82 +++++++++++++++++++----
 1 file changed, 68 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b86a6e0..f6ab13d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1538,6 +1538,9 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe);
+#ifdef CONFIG_IOMMU_API
+static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe);
+#endif
 static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 {
 	struct pci_bus        *bus;
@@ -1591,6 +1594,9 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 		mutex_unlock(&phb->ioda.pe_list_mutex);
 
 		pnv_pci_ioda2_setup_dma_pe(phb, pe);
+#ifdef CONFIG_IOMMU_API
+		pnv_ioda_setup_bus_iommu_group(pe);
+#endif
 	}
 }
 
@@ -1930,21 +1936,16 @@ static u64 pnv_pci_ioda_dma_get_required_mask(struct pci_dev *pdev)
 	return mask;
 }
 
-static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
-				   struct pci_bus *bus,
-				   bool add_to_group)
+static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
 		set_dma_offset(&dev->dev, pe->tce_bypass_base);
-		if (add_to_group)
-			iommu_add_device(&pe->table_group, &dev->dev);
 
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
-			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
-					add_to_group);
+			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
 	}
 }
 
@@ -2374,7 +2375,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 	iommu_init_table(tbl, phb->hose->node);
 
 	if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
-		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 
 	return;
  fail:
@@ -2607,7 +2608,7 @@ static void pnv_ioda2_take_ownership(struct iommu_table_group *table_group)
 	pnv_pci_ioda2_set_bypass(pe, false);
 	pnv_pci_ioda2_unset_window(&pe->table_group, 0);
 	if (pe->pbus)
-		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 	iommu_tce_table_put(tbl);
 }
 
@@ -2618,7 +2619,7 @@ static void pnv_ioda2_release_ownership(struct iommu_table_group *table_group)
 
 	pnv_pci_ioda2_setup_default_config(pe);
 	if (pe->pbus)
-		pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 }
 
 static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
@@ -2735,12 +2736,68 @@ static struct iommu_table_group_ops pnv_pci_ioda2_npu_ops = {
 	.release_ownership = pnv_ioda2_release_ownership,
 };
 
+static void pnv_ioda_setup_bus_iommu_group_add_devices(struct pnv_ioda_pe *pe,
+		struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		iommu_add_device(&pe->table_group, &dev->dev);
+
+		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
+			pnv_ioda_setup_bus_iommu_group_add_devices(pe,
+					dev->subordinate);
+	}
+}
+
+static void pnv_ioda_setup_bus_iommu_group(struct pnv_ioda_pe *pe)
+{
+	if (!pnv_pci_ioda_pe_dma_weight(pe))
+		return;
+
+	iommu_register_group(&pe->table_group, pe->phb->hose->global_number,
+			pe->pe_number);
+
+	/*
+	 * set_iommu_table_base(&pe->pdev->dev, tbl) should have been called
+	 * by now
+	 */
+	if (pe->flags & PNV_IODA_PE_DEV)
+		iommu_add_device(&pe->table_group, &pe->pdev->dev);
+	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
+		pnv_ioda_setup_bus_iommu_group_add_devices(pe, pe->pbus);
+}
+
 static void pnv_pci_ioda_setup_iommu_api(void)
 {
 	struct pci_controller *hose, *tmp;
 	struct pnv_phb *phb;
 	struct pnv_ioda_pe *pe, *gpe;
 
+	/*
+	 * There are 4 types of PEs:
+	 * - PNV_IODA_PE_BUS: a downstream port with an adapter,
+	 *   created from pnv_pci_setup_bridge();
+	 * - PNV_IODA_PE_BUS_ALL: a PCI-PCIX bridge with devices behind it,
+	 *   created from pnv_pci_setup_bridge();
+	 * - PNV_IODA_PE_VF: a SRIOV virtual function,
+	 *   created from pnv_pcibios_sriov_enable();
+	 * - PNV_IODA_PE_DEV: an NPU or OCAPI device,
+	 *   created from pnv_pci_ioda_fixup().
+	 *
+	 * Normally a PE is represented by an IOMMU group, however for
+	 * devices with side channels the groups need to be more strict.
+	 */
+	list_for_each_entry(hose, &hose_list, list_node) {
+		phb = hose->private_data;
+
+		if (phb->type == PNV_PHB_NPU_NVLINK)
+			continue;
+
+		list_for_each_entry(pe, &phb->ioda.pe_list, list)
+			pnv_ioda_setup_bus_iommu_group(pe);
+	}
+
 	/*
 	 * Now we have all PHBs discovered, time to add NPU devices to
 	 * the corresponding IOMMU groups.
@@ -2801,9 +2858,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	/* TVE #1 is selected by PCI address bit 59 */
 	pe->tce_bypass_base = 1ull << 59;
 
-	iommu_register_group(&pe->table_group, phb->hose->global_number,
-			pe->pe_number);
-
 	/* The PE will reserve all possible 32-bits space */
 	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
 		phb->ioda.m32_pci_base);
@@ -2824,7 +2878,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		return;
 
 	if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
-		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 }
 
 #ifdef CONFIG_PCI_MSI
-- 
2.17.1

