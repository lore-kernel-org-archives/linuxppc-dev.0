Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B53AE2C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 15:47:00 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 26 Jun 2013 23:46:58 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7EFF819D8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:46 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5R5ktiH148096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:55 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5R5ktcI026228
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jun 2013 23:46:55 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/8] powerpc/powernv: Use dev-node in PCI config accessors
Date: Thu, 27 Jun 2013 13:46:48 +0800
Message-Id: <1372312009-13710-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372312009-13710-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, we're using the combo (PCI bus + devfn) in the PCI
config accessors and PCI config accessors in EEH depends on them.
However, it's not safe to refer the PCI bus which might have been
removed during hotplug. So we're using device node in the PCI
config accessors and the corresponding backends just reuse them.

The patch also fix one potential risk: We possiblly have frozen
PE during the early PCI probe time, but we haven't setup the PE
mapping yet. So the errors should be counted to PE#0.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c |   44 +---------
 arch/powerpc/platforms/powernv/pci.c         |  120 ++++++++++++++++----------
 arch/powerpc/platforms/powernv/pci.h         |    4 +
 3 files changed, 79 insertions(+), 89 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 9559115..969cce7 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -315,46 +315,6 @@ static int powernv_eeh_configure_bridge(struct eeh_pe *pe)
 }
 
 /**
- * powernv_eeh_read_config - Read PCI config space
- * @dn: device node
- * @where: PCI address
- * @size: size to read
- * @val: return value
- *
- * Read config space from the speicifed device
- */
-static int powernv_eeh_read_config(struct device_node *dn, int where,
-				   int size, u32 *val)
-{
-	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	struct pci_controller *hose = edev->phb;
-
-	return hose->ops->read(dev->bus, dev->devfn, where, size, val);
-}
-
-/**
- * powernv_eeh_write_config - Write PCI config space
- * @dn: device node
- * @where: PCI address
- * @size: size to write
- * @val: value to be written
- *
- * Write config space to the specified device
- */
-static int powernv_eeh_write_config(struct device_node *dn, int where,
-				    int size, u32 val)
-{
-	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
-	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
-	struct pci_controller *hose = edev->phb;
-
-	hose = pci_bus_to_host(dev->bus);
-
-	return hose->ops->write(dev->bus, dev->devfn, where, size, val);
-}
-
-/**
  * powernv_eeh_next_error - Retrieve next EEH error to handle
  * @pe: Affected PE
  *
@@ -389,8 +349,8 @@ static struct eeh_ops powernv_eeh_ops = {
 	.wait_state             = powernv_eeh_wait_state,
 	.get_log                = powernv_eeh_get_log,
 	.configure_bridge       = powernv_eeh_configure_bridge,
-	.read_config            = powernv_eeh_read_config,
-	.write_config           = powernv_eeh_write_config,
+	.read_config            = pnv_pci_cfg_read,
+	.write_config           = pnv_pci_cfg_write,
 	.next_error		= powernv_eeh_next_error
 };
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 1f31826..229b034 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -230,47 +230,50 @@ static void pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
 	spin_unlock_irqrestore(&phb->lock, flags);
 }
 
-static void pnv_pci_config_check_eeh(struct pnv_phb *phb, struct pci_bus *bus,
-				     u32 bdfn)
+static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
+				     struct device_node *dn)
 {
 	s64	rc;
 	u8	fstate;
 	u16	pcierr;
 	u32	pe_no;
 
-	/* Get PE# if we support IODA */
-	pe_no = phb->bdfn_to_pe ? phb->bdfn_to_pe(phb, bus, bdfn & 0xff) : 0;
+	/*
+	 * Get the PE#. During the PCI probe stage, we might not
+	 * setup that yet. So all ER errors should be mapped to
+	 * PE#0
+	 */
+	pe_no = PCI_DN(dn)->pe_number;
+	if (pe_no == IODA_INVALID_PE)
+		pe_no = 0;
 
 	/* Read freeze status */
 	rc = opal_pci_eeh_freeze_status(phb->opal_id, pe_no, &fstate, &pcierr,
 					NULL);
 	if (rc) {
-		pr_warning("PCI %d: Failed to read EEH status for PE#%d,"
-			   " err %lld\n", phb->hose->global_number, pe_no, rc);
+		pr_warning("%s: Can't read EEH status (PE#%d) for "
+			   "%s, err %lld\n",
+			   __func__, pe_no, dn->full_name, rc);
 		return;
 	}
-	cfg_dbg(" -> EEH check, bdfn=%04x PE%d fstate=%x\n",
-		bdfn, pe_no, fstate);
+	cfg_dbg(" -> EEH check, bdfn=%04x PE#%d fstate=%x\n",
+		(PCI_DN(dn)->busno << 8) | (PCI_DN(dn)->devfn),
+		pe_no, fstate);
 	if (fstate != 0)
 		pnv_pci_handle_eeh_config(phb, pe_no);
 }
 
-static int pnv_pci_read_config(struct pci_bus *bus,
-			       unsigned int devfn,
-			       int where, int size, u32 *val)
+int pnv_pci_cfg_read(struct device_node *dn,
+		     int where, int size, u32 *val)
 {
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	struct pnv_phb *phb = hose->private_data;
+	struct pci_dn *pdn = PCI_DN(dn);
+	struct pnv_phb *phb = pdn->phb->private_data;
+	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
 #ifdef CONFIG_EEH
-	struct device_node *busdn, *dn;
 	struct eeh_pe *phb_pe = NULL;
 #endif
-	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
 	s64 rc;
 
-	if (hose == NULL)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
 	switch (size) {
 	case 1: {
 		u8 v8;
@@ -294,8 +297,8 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 	default:
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
-	cfg_dbg("pnv_pci_read_config bus: %x devfn: %x +%x/%x -> %08x\n",
-		bus->number, devfn, where, size, *val);
+	cfg_dbg("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
+		__func__, pdn->busno, pdn->devfn, where, size, *val);
 
 	/*
 	 * Check if the specified PE has been put into frozen
@@ -304,44 +307,33 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 	 * PHB-fatal errors.
 	 */
 #ifdef CONFIG_EEH
-	phb_pe = eeh_phb_pe_get(hose);
+	phb_pe = eeh_phb_pe_get(pdn->phb);
 	if (phb_pe && (phb_pe->state & EEH_PE_ISOLATED))
 		return PCIBIOS_SUCCESSFUL;
 
 	if (phb->eeh_state & PNV_EEH_STATE_ENABLED) {
-		if (*val == EEH_IO_ERROR_VALUE(size)) {
-			busdn = pci_bus_to_OF_node(bus);
-			for (dn = busdn->child; dn; dn = dn->sibling) {
-				struct pci_dn *pdn = PCI_DN(dn);
-
-				if (pdn && pdn->devfn == devfn &&
-				    eeh_dev_check_failure(of_node_to_eeh_dev(dn)))
-					return PCIBIOS_DEVICE_NOT_FOUND;
-			}
-		}
+		if (*val == EEH_IO_ERROR_VALUE(size) &&
+		    eeh_dev_check_failure(of_node_to_eeh_dev(dn)))
+			return PCIBIOS_DEVICE_NOT_FOUND;
 	} else {
-		pnv_pci_config_check_eeh(phb, bus, bdfn);
+		pnv_pci_config_check_eeh(phb, dn);
 	}
 #else
-	pnv_pci_config_check_eeh(phb, bus, bdfn);
+	pnv_pci_config_check_eeh(phb, dn);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
-static int pnv_pci_write_config(struct pci_bus *bus,
-				unsigned int devfn,
-				int where, int size, u32 val)
+int pnv_pci_cfg_write(struct device_node *dn,
+		      int where, int size, u32 val)
 {
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	struct pnv_phb *phb = hose->private_data;
-	u32 bdfn = (((uint64_t)bus->number) << 8) | devfn;
+	struct pci_dn *pdn = PCI_DN(dn);
+	struct pnv_phb *phb = pdn->phb->private_data;
+	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
 
-	if (hose == NULL)
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
-	cfg_dbg("pnv_pci_write_config bus: %x devfn: %x +%x/%x -> %08x\n",
-		bus->number, devfn, where, size, val);
+	cfg_dbg("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
+		pdn->busno, pdn->devfn, where, size, val);
 	switch (size) {
 	case 1:
 		opal_pci_config_write_byte(phb->opal_id, bdfn, where, val);
@@ -359,16 +351,50 @@ static int pnv_pci_write_config(struct pci_bus *bus,
 	/* Check if the PHB got frozen due to an error (no response) */
 #ifdef CONFIG_EEH
 	if (!(phb->eeh_state & PNV_EEH_STATE_ENABLED))
-		pnv_pci_config_check_eeh(phb, bus, bdfn);
+		pnv_pci_config_check_eeh(phb, dn);
 #else
-	pnv_pci_config_check_eeh(phb, bus, bdfn);
+	pnv_pci_config_check_eeh(phb, dn);
 #endif
 
 	return PCIBIOS_SUCCESSFUL;
 }
 
+static int pnv_pci_read_config(struct pci_bus *bus,
+			       unsigned int devfn,
+			       int where, int size, u32 *val)
+{
+	struct device_node *dn, *busdn = pci_bus_to_OF_node(bus);
+	struct pci_dn *pdn;
+
+	for (dn = busdn->child; dn; dn = dn->sibling) {
+		pdn = PCI_DN(dn);
+		if (pdn && pdn->devfn == devfn)
+			return pnv_pci_cfg_read(dn, where, size, val);
+	}
+
+	*val = 0xFFFFFFFF;
+	return PCIBIOS_DEVICE_NOT_FOUND;
+
+}
+
+static int pnv_pci_write_config(struct pci_bus *bus,
+				unsigned int devfn,
+				int where, int size, u32 val)
+{
+	struct device_node *dn, *busdn = pci_bus_to_OF_node(bus);
+	struct pci_dn *pdn;
+
+	for (dn = busdn->child; dn; dn = dn->sibling) {
+		pdn = PCI_DN(dn);
+		if (pdn && pdn->devfn == devfn)
+			return pnv_pci_cfg_write(dn, where, size, val);
+	}
+
+	return PCIBIOS_DEVICE_NOT_FOUND;
+}
+
 struct pci_ops pnv_pci_ops = {
-	.read = pnv_pci_read_config,
+	.read  = pnv_pci_read_config,
 	.write = pnv_pci_write_config,
 };
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 40bdf02..d633c64 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -182,6 +182,10 @@ extern struct pci_ops pnv_pci_ops;
 extern struct pnv_eeh_ops ioda_eeh_ops;
 #endif
 
+int pnv_pci_cfg_read(struct device_node *dn,
+		     int where, int size, u32 *val);
+int pnv_pci_cfg_write(struct device_node *dn,
+		      int where, int size, u32 val);
 extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 				      void *tce_mem, u64 tce_size,
 				      u64 dma_offset);
-- 
1.7.5.4
