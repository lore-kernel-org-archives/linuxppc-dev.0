Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9B52A1A0D47
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:32 +1100 (AEDT)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 12:28:31 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id F40A72CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:28 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F2SSFJ46006430
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:28 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F2SSie019969
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:28 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V11 10/17] powerpc/powernv: Use pci_dn in PCI config accessor
Date: Thu, 15 Jan 2015 10:28:00 +0800
Message-Id: <1421288887-7765-11-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PCI config accessors rely on device node. Unfortunately, VFs
don't have corresponding device nodes. So we have to switch to
pci_dn for PCI config access.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c |   14 +++++-
 arch/powerpc/platforms/powernv/pci.c         |   69 ++++++++++----------------
 arch/powerpc/platforms/powernv/pci.h         |    4 +-
 3 files changed, 40 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 1d19e79..c63b6c1 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -419,21 +419,31 @@ static inline bool powernv_eeh_cfg_blocked(struct device_node *dn)
 static int powernv_eeh_read_config(struct device_node *dn,
 				   int where, int size, u32 *val)
 {
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	if (!pdn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	if (powernv_eeh_cfg_blocked(dn)) {
 		*val = 0xFFFFFFFF;
 		return PCIBIOS_SET_FAILED;
 	}
 
-	return pnv_pci_cfg_read(dn, where, size, val);
+	return pnv_pci_cfg_read(pdn, where, size, val);
 }
 
 static int powernv_eeh_write_config(struct device_node *dn,
 				    int where, int size, u32 val)
 {
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	if (!pdn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	if (powernv_eeh_cfg_blocked(dn))
 		return PCIBIOS_SET_FAILED;
 
-	return pnv_pci_cfg_write(dn, where, size, val);
+	return pnv_pci_cfg_write(pdn, where, size, val);
 }
 
 /**
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 4945e87..b7d4b9d 100644
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
index 6c02ff8..e5b75b2 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -219,9 +219,9 @@ extern struct pnv_eeh_ops ioda_eeh_ops;
 
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
1.7.9.5
