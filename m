Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E01DDB6FA7
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2012 02:14:26 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 25 Jun 2012 10:14:24 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1519119D94D0
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 15:43:35 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5PFhVQo079266
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 09:43:34 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5PFhU4d030895
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 09:43:31 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/8] ppc/pnv: create bus sensitive PEs
Date: Mon, 25 Jun 2012 23:43:14 +0800
Message-Id: <1340639001-28152-2-git-send-email-shangw@linux.vnet.ibm.com>
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

Basically, there're 2 types of PCI bus sensitive PEs: (A) The PE
includes single PCI bus. (B) The PE includes the PCI bus and all
the subordinate PCI buses. At present, we'd like to put PCI bus
originated by PCI-e link to form PE that contains single PCI bus,
and the PCIe-to-PCI bridge will form the 2nd type of PE. We don't
figure out to detect PLX bridge yet. Once we can detect PLX bridge
some day, we have to put PCI buses originated from the downstream
port of PLX bridge to the 2nd type of PE.

The patch changes the original implementation for a little bit
to support 2 types of PCI bus sensitive PEs described as above.
Also, the function used to retrieve the corresponding PE according
to the given PCI device has been changed based on that because each
PCI device should trace the directly associated PE.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   97 +++++++++++++++++------------
 arch/powerpc/platforms/powernv/pci.h      |   10 +--
 2 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fbdd74d..1504795 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -548,7 +548,7 @@ static void __devinit pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
  * but in the meantime, we need to protect them to avoid warnings
  */
 #ifdef CONFIG_PCI_MSI
-static struct pnv_ioda_pe * __devinit __pnv_ioda_get_one_pe(struct pci_dev *dev)
+static struct pnv_ioda_pe * __devinit pnv_ioda_get_pe(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -560,19 +560,6 @@ static struct pnv_ioda_pe * __devinit __pnv_ioda_get_one_pe(struct pci_dev *dev)
 		return NULL;
 	return &phb->ioda.pe_array[pdn->pe_number];
 }
-
-static struct pnv_ioda_pe * __devinit pnv_ioda_get_pe(struct pci_dev *dev)
-{
-	struct pnv_ioda_pe *pe = __pnv_ioda_get_one_pe(dev);
-
-	while (!pe && dev->bus->self) {
-		dev = dev->bus->self;
-		pe = __pnv_ioda_get_one_pe(dev);
-		if (pe)
-			pe = pe->bus_pe;
-	}
-	return pe;
-}
 #endif /* CONFIG_PCI_MSI */
 
 static int __devinit pnv_ioda_configure_pe(struct pnv_phb *phb,
@@ -589,7 +576,11 @@ static int __devinit pnv_ioda_configure_pe(struct pnv_phb *phb,
 		dcomp = OPAL_IGNORE_RID_DEVICE_NUMBER;
 		fcomp = OPAL_IGNORE_RID_FUNCTION_NUMBER;
 		parent = pe->pbus->self;
-		count = pe->pbus->subordinate - pe->pbus->secondary + 1;
+		if (pe->flags & PNV_IODA_PE_BUS_ALL)
+			count = pe->pbus->subordinate - pe->pbus->secondary + 1;
+		else
+			count = 1;
+
 		switch(count) {
 		case  1: bcomp = OpalPciBusAll;		break;
 		case  2: bcomp = OpalPciBus7Bits;	break;
@@ -699,6 +690,7 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
 	return 10;
 }
 
+#if 0
 static struct pnv_ioda_pe * __devinit pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
@@ -767,6 +759,7 @@ static struct pnv_ioda_pe * __devinit pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 
 	return pe;
 }
+#endif /* Useful for SRIOV case */
 
 static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 {
@@ -784,43 +777,47 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 		pdn->pcidev = dev;
 		pdn->pe_number = pe->pe_number;
 		pe->dma_weight += pnv_ioda_dma_weight(dev);
-		if (dev->subordinate)
+		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
 			pnv_ioda_setup_same_PE(dev->subordinate, pe);
 	}
 }
 
-static void __devinit pnv_ioda_setup_bus_PE(struct pci_dev *dev,
-					    struct pnv_ioda_pe *ppe)
+/*
+ * There're 2 types of PCI bus sensitive PEs: One that is compromised of
+ * single PCI bus. Another one that contains the primary PCI bus and its
+ * subordinate PCI devices and buses. The second type of PE is normally
+ * orgiriated by PCIe-to-PCI bridge or PLX switch downstream ports.
+ */
+static void __devinit pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 {
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
-	struct pci_bus *bus = dev->subordinate;
 	struct pnv_ioda_pe *pe;
 	int pe_num;
 
-	if (!bus) {
-		pr_warning("%s: Bridge without a subordinate bus !\n",
-			   pci_name(dev));
-		return;
-	}
 	pe_num = pnv_ioda_alloc_pe(phb);
 	if (pe_num == IODA_INVALID_PE) {
-		pr_warning("%s: Not enough PE# available, disabling bus\n",
-			   pci_name(dev));
+		pr_warning("%s: Not enough PE# available for PCI bus %04x:%02x\n",
+			__func__, pci_domain_nr(bus), bus->number);
 		return;
 	}
 
 	pe = &phb->ioda.pe_array[pe_num];
-	ppe->bus_pe = pe;
+	pe->flags = (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
 	pe->pbus = bus;
+	pe->pe_number = pe_num;
 	pe->pdev = NULL;
 	pe->tce32_seg = -1;
 	pe->mve_number = -1;
 	pe->rid = bus->secondary << 8;
 	pe->dma_weight = 0;
 
-	pe_info(pe, "Secondary busses %d..%d associated with PE\n",
-		bus->secondary, bus->subordinate);
+	if (all)
+		pe_info(pe, "Secondary busses %d..%d associated with PE#%d\n",
+			bus->secondary, bus->subordinate, pe_num);
+	else
+		pe_info(pe, "Secondary busses %d associated with PE#%d\n",
+			bus->secondary, pe_num);
 
 	if (pnv_ioda_configure_pe(phb, pe)) {
 		/* XXX What do we do here ? */
@@ -848,17 +845,33 @@ static void __devinit pnv_ioda_setup_bus_PE(struct pci_dev *dev,
 static void __devinit pnv_ioda_setup_PEs(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
-	struct pnv_ioda_pe *pe;
+
+	pnv_ioda_setup_bus_PE(bus, 0);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pe = pnv_ioda_setup_dev_PE(dev);
-		if (pe == NULL)
-			continue;
-		/* Leaving the PCIe domain ... single PE# */
-		if (dev->pcie_type == PCI_EXP_TYPE_PCI_BRIDGE)
-			pnv_ioda_setup_bus_PE(dev, pe);
-		else if (dev->subordinate)
-			pnv_ioda_setup_PEs(dev->subordinate);
+		if (dev->subordinate) {
+			if (dev->pcie_type == PCI_EXP_TYPE_PCI_BRIDGE)
+				pnv_ioda_setup_bus_PE(dev->subordinate, 1);
+			else
+				pnv_ioda_setup_PEs(dev->subordinate);
+		}
+	}
+}
+
+/*
+ * Configure PEs so that the downstream PCI buses and devices
+ * could have their associated PE#. Unfortunately, we didn't
+ * figure out the way to identify the PLX bridge yet. So we
+ * simply put the PCI bus and the subordinate behind the root
+ * port to PE# here. The game rule here is expected to be changed
+ * as soon as we can detected PLX bridge correctly.
+ */
+static void __devinit pnv_pci_ioda_setup_PEs(void)
+{
+	struct pci_controller *hose, *tmp;
+
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		pnv_ioda_setup_PEs(hose->bus);
 	}
 }
 
@@ -1139,6 +1152,11 @@ static void __devinit pnv_pci_ioda_fixup_phb(struct pci_controller *hose)
 	}
 }
 
+static void __devinit pnv_pci_ioda_fixup(void)
+{
+	pnv_pci_ioda_setup_PEs();
+}
+
 /* Prevent enabling devices for which we couldn't properly
  * assign a PE
  */
@@ -1305,6 +1323,7 @@ void __init pnv_pci_init_ioda1_phb(struct device_node *np)
 	 * ourselves here
 	 */
 	ppc_md.pcibios_fixup_phb = pnv_pci_ioda_fixup_phb;
+	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 	ppc_md.pcibios_enable_device_hook = pnv_pci_enable_device_hook;
 	pci_add_flags(PCI_PROBE_ONLY | PCI_REASSIGN_ALL_RSRC);
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8bc4796..0cb760c 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -17,9 +17,14 @@ enum pnv_phb_model {
 };
 
 #define PNV_PCI_DIAG_BUF_SIZE	4096
+#define PNV_IODA_PE_DEV		(1 << 0)	/* PE has single PCI device	*/
+#define PNV_IODA_PE_BUS		(1 << 1)	/* PE has primary PCI bus	*/
+#define PNV_IODA_PE_BUS_ALL	(1 << 2)	/* PE has subordinate buses	*/
 
 /* Data associated with a PE, including IOMMU tracking etc.. */
 struct pnv_ioda_pe {
+	unsigned long		flags;
+
 	/* A PE can be associated with a single device or an
 	 * entire bus (& children). In the former case, pdev
 	 * is populated, in the later case, pbus is.
@@ -40,11 +45,6 @@ struct pnv_ioda_pe {
 	 */
 	unsigned int		dma_weight;
 
-	/* This is a PCI-E -> PCI-X bridge, this points to the
-	 * corresponding bus PE
-	 */
-	struct pnv_ioda_pe	*bus_pe;
-
 	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
 	int			tce32_seg;
 	int			tce32_segcount;
-- 
1.7.9.5
