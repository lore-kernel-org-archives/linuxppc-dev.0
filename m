Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 777B61A0BB2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 16:16:13 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2C7A6140140
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:13 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 15:16:12 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 6DF2D2BB0047
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:09 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2H5G17K34668610
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:09 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2H5FZbI008511
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:15:36 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 2/7] powerpc/powernv: Use pci_dn, not device_node,
 in PCI config accessor
Date: Tue, 17 Mar 2015 16:15:03 +1100
Message-Id: <1426569308-9470-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1426569308-9470-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1426569308-9470-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCI config accessors previously relied on device_node.  Unfortunately,
VFs don't have a corresponding device_node, so change the accessors to use
pci_dn instead.

[bhelgaas: changelog]
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c | 14 +++++-
 arch/powerpc/platforms/powernv/pci.c         | 69 +++++++++++-----------------
 arch/powerpc/platforms/powernv/pci.h         |  4 +-
 3 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index ede6906..8eac8c5 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1038,21 +1038,31 @@ static inline bool pnv_eeh_cfg_blocked(struct device_node *dn)
 static int pnv_eeh_read_config(struct device_node *dn,
 			       int where, int size, u32 *val)
 {
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	if (!pdn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	if (pnv_eeh_cfg_blocked(dn)) {
 		*val = 0xFFFFFFFF;
 		return PCIBIOS_SET_FAILED;
 	}
 
-	return pnv_pci_cfg_read(dn, where, size, val);
+	return pnv_pci_cfg_read(pdn, where, size, val);
 }
 
 static int pnv_eeh_write_config(struct device_node *dn,
 				int where, int size, u32 val)
 {
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	if (!pdn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	if (pnv_eeh_cfg_blocked(dn))
 		return PCIBIOS_SET_FAILED;
 
-	return pnv_pci_cfg_write(dn, where, size, val);
+	return pnv_pci_cfg_write(pdn, where, size, val);
 }
 
 static void pnv_eeh_dump_hub_diag_common(struct OpalIoP7IOCErrorData *data)
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 54323d6..946aa3d 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -366,9 +366,9 @@ static void pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
 	spin_unlock_irqrestore(&phb->lock, flags);
 }
 
-static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
-				     struct device_node *dn)
+static void pnv_pci_config_check_eeh(struct pci_dn *pdn)
 {
+	struct pnv_phb *phb = pdn->phb->private_data;
 	u8	fstate;
 	__be16	pcierr;
 	int	pe_no;
@@ -379,7 +379,7 @@ static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
 	 * setup that yet. So all ER errors should be mapped to
 	 * reserved PE.
 	 */
-	pe_no = PCI_DN(dn)->pe_number;
+	pe_no = pdn->pe_number;
 	if (pe_no == IODA_INVALID_PE) {
 		if (phb->type == PNV_PHB_P5IOC2)
 			pe_no = 0;
@@ -407,8 +407,7 @@ static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
 	}
 
 	cfg_dbg(" -> EEH check, bdfn=%04x PE#%d fstate=%x\n",
-		(PCI_DN(dn)->busno << 8) | (PCI_DN(dn)->devfn),
-		pe_no, fstate);
+		(pdn->busno << 8) | (pdn->devfn), pe_no, fstate);
 
 	/* Clear the frozen state if applicable */
 	if (fstate == OPAL_EEH_STOPPED_MMIO_FREEZE ||
@@ -425,10 +424,9 @@ static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
 	}
 }
 
-int pnv_pci_cfg_read(struct device_node *dn,
+int pnv_pci_cfg_read(struct pci_dn *pdn,
 		     int where, int size, u32 *val)
 {
-	struct pci_dn *pdn = PCI_DN(dn);
 	struct pnv_phb *phb = pdn->phb->private_data;
 	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
 	s64 rc;
@@ -462,10 +460,9 @@ int pnv_pci_cfg_read(struct device_node *dn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int pnv_pci_cfg_write(struct device_node *dn,
+int pnv_pci_cfg_write(struct pci_dn *pdn,
 		      int where, int size, u32 val)
 {
-	struct pci_dn *pdn = PCI_DN(dn);
 	struct pnv_phb *phb = pdn->phb->private_data;
 	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
 
@@ -489,18 +486,17 @@ int pnv_pci_cfg_write(struct device_node *dn,
 }
 
 #if CONFIG_EEH
-static bool pnv_pci_cfg_check(struct pci_controller *hose,
-			      struct device_node *dn)
+static bool pnv_pci_cfg_check(struct pci_dn *pdn)
 {
 	struct eeh_dev *edev = NULL;
-	struct pnv_phb *phb = hose->private_data;
+	struct pnv_phb *phb = pdn->phb->private_data;
 
 	/* EEH not enabled ? */
 	if (!(phb->flags & PNV_PHB_FLAG_EEH))
 		return true;
 
 	/* PE reset or device removed ? */
-	edev = of_node_to_eeh_dev(dn);
+	edev = pdn->edev;
 	if (edev) {
 		if (edev->pe &&
 		    (edev->pe->state & EEH_PE_CFG_BLOCKED))
@@ -513,8 +509,7 @@ static bool pnv_pci_cfg_check(struct pci_controller *hose,
 	return true;
 }
 #else
-static inline pnv_pci_cfg_check(struct pci_controller *hose,
-				struct device_node *dn)
+static inline pnv_pci_cfg_check(struct pci_dn *pdn)
 {
 	return true;
 }
@@ -524,32 +519,26 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 			       unsigned int devfn,
 			       int where, int size, u32 *val)
 {
-	struct device_node *dn, *busdn = pci_bus_to_OF_node(bus);
 	struct pci_dn *pdn;
 	struct pnv_phb *phb;
-	bool found = false;
 	int ret;
 
 	*val = 0xFFFFFFFF;
-	for (dn = busdn->child; dn; dn = dn->sibling) {
-		pdn = PCI_DN(dn);
-		if (pdn && pdn->devfn == devfn) {
-			phb = pdn->phb->private_data;
-			found = true;
-			break;
-		}
-	}
+	pdn = pci_get_pdn_by_devfn(bus, devfn);
+	if (!pdn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (!found || !pnv_pci_cfg_check(pdn->phb, dn))
+	if (!pnv_pci_cfg_check(pdn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	ret = pnv_pci_cfg_read(dn, where, size, val);
-	if (phb->flags & PNV_PHB_FLAG_EEH) {
+	ret = pnv_pci_cfg_read(pdn, where, size, val);
+	phb = pdn->phb->private_data;
+	if (phb->flags & PNV_PHB_FLAG_EEH && pdn->edev) {
 		if (*val == EEH_IO_ERROR_VALUE(size) &&
-		    eeh_dev_check_failure(of_node_to_eeh_dev(dn)))
+		    eeh_dev_check_failure(pdn->edev))
                         return PCIBIOS_DEVICE_NOT_FOUND;
 	} else {
-		pnv_pci_config_check_eeh(phb, dn);
+		pnv_pci_config_check_eeh(pdn);
 	}
 
 	return ret;
@@ -559,27 +548,21 @@ static int pnv_pci_write_config(struct pci_bus *bus,
 				unsigned int devfn,
 				int where, int size, u32 val)
 {
-	struct device_node *dn, *busdn = pci_bus_to_OF_node(bus);
 	struct pci_dn *pdn;
 	struct pnv_phb *phb;
-	bool found = false;
 	int ret;
 
-	for (dn = busdn->child; dn; dn = dn->sibling) {
-		pdn = PCI_DN(dn);
-		if (pdn && pdn->devfn == devfn) {
-			phb = pdn->phb->private_data;
-			found = true;
-			break;
-		}
-	}
+	pdn = pci_get_pdn_by_devfn(bus, devfn);
+	if (!pdn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (!found || !pnv_pci_cfg_check(pdn->phb, dn))
+	if (!pnv_pci_cfg_check(pdn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	ret = pnv_pci_cfg_write(dn, where, size, val);
+	ret = pnv_pci_cfg_write(pdn, where, size, val);
+	phb = pdn->phb->private_data;
 	if (!(phb->flags & PNV_PHB_FLAG_EEH))
-		pnv_pci_config_check_eeh(phb, dn);
+		pnv_pci_config_check_eeh(pdn);
 
 	return ret;
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 18ae927..1f0cb66 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -196,9 +196,9 @@ extern struct pci_ops pnv_pci_ops;
 
 void pnv_pci_dump_phb_diag_data(struct pci_controller *hose,
 				unsigned char *log_buff);
-int pnv_pci_cfg_read(struct device_node *dn,
+int pnv_pci_cfg_read(struct pci_dn *pdn,
 		     int where, int size, u32 *val);
-int pnv_pci_cfg_write(struct device_node *dn,
+int pnv_pci_cfg_write(struct pci_dn *pdn,
 		      int where, int size, u32 val);
 extern void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 				      void *tce_mem, u64 tce_size,
-- 
1.8.3.2
