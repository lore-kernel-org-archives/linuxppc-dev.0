Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 100581A06C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 16:22:52 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 24 Jul 2014 11:52:50 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A5948394006F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:52:47 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6O6N6im65339624
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:53:06 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6O6MjDC007312
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Jul 2014 11:52:46 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
 yan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com
Subject: [PATCH V7 08/17] powerpc/powernv: Use pci_dn in PCI config accessor
Date: Thu, 24 Jul 2014 14:22:18 +0800
Message-Id: <1406182947-11302-9-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1406182947-11302-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gavin Shan <gwshan@linux.vnet.ibm.com>

The PCI config accessors rely on device node. Unfortunately, VFs
don't have corresponding device nodes. So we have to switch to
pci_dn for PCI config access.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-powernv.c |   24 ++++++++-
 arch/powerpc/platforms/powernv/pci.c         |   69 ++++++++++----------------
 arch/powerpc/platforms/powernv/pci.h         |    4 +-
 3 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index f5bbc9f..357ec68 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -380,6 +380,26 @@ static int powernv_eeh_next_error(struct eeh_pe **pe)
 	return -EEXIST;
 }
 
+static int powernv_eeh_cfg_read(struct device_node *dn,
+				int where, int size, u32 *val)
+{
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	if (!pdn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return pnv_pci_cfg_read(pdn, where, size, val);
+}
+
+static int powernv_eeh_cfg_write(struct device_node *dn,
+				 int where, int size, u32 val)
+{
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	if (!pdn)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return pnv_pci_cfg_write(pdn, where, size, val);
+}
+
 static int powernv_eeh_restore_config(struct device_node *dn)
 {
 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
@@ -414,8 +434,8 @@ static struct eeh_ops powernv_eeh_ops = {
 	.wait_state             = powernv_eeh_wait_state,
 	.get_log                = powernv_eeh_get_log,
 	.configure_bridge       = powernv_eeh_configure_bridge,
-	.read_config            = pnv_pci_cfg_read,
-	.write_config           = pnv_pci_cfg_write,
+	.read_config            = powernv_eeh_cfg_read,
+	.write_config           = powernv_eeh_cfg_write,
 	.next_error		= powernv_eeh_next_error,
 	.restore_config		= powernv_eeh_restore_config
 };
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index c823503..b97aa79 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -376,9 +376,9 @@ static void pnv_pci_handle_eeh_config(struct pnv_phb *phb, u32 pe_no)
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
@@ -389,7 +389,7 @@ static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
 	 * setup that yet. So all ER errors should be mapped to
 	 * reserved PE.
 	 */
-	pe_no = PCI_DN(dn)->pe_number;
+	pe_no = pdn->pe_number;
 	if (pe_no == IODA_INVALID_PE) {
 		if (phb->type == PNV_PHB_P5IOC2)
 			pe_no = 0;
@@ -417,8 +417,7 @@ static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
 	}
 
 	cfg_dbg(" -> EEH check, bdfn=%04x PE#%d fstate=%x\n",
-		(PCI_DN(dn)->busno << 8) | (PCI_DN(dn)->devfn),
-		pe_no, fstate);
+		(pdn->busno << 8) | (pdn->devfn), pe_no, fstate);
 
 	/* Clear the frozen state if applicable */
 	if (fstate == OPAL_EEH_STOPPED_MMIO_FREEZE ||
@@ -435,10 +434,9 @@ static void pnv_pci_config_check_eeh(struct pnv_phb *phb,
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
@@ -472,10 +470,9 @@ int pnv_pci_cfg_read(struct device_node *dn,
 	return PCIBIOS_SUCCESSFUL;
 }
 
-int pnv_pci_cfg_write(struct device_node *dn,
+int pnv_pci_cfg_write(struct pci_dn *pdn,
 		      int where, int size, u32 val)
 {
-	struct pci_dn *pdn = PCI_DN(dn);
 	struct pnv_phb *phb = pdn->phb->private_data;
 	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
 
@@ -499,18 +496,17 @@ int pnv_pci_cfg_write(struct device_node *dn,
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
 		    (edev->pe->state & EEH_PE_RESET))
@@ -523,8 +519,7 @@ static bool pnv_pci_cfg_check(struct pci_controller *hose,
 	return true;
 }
 #else
-static inline pnv_pci_cfg_check(struct pci_controller *hose,
-				struct device_node *dn)
+static inline pnv_pci_cfg_check(struct pci_dn *pdn)
 {
 	return true;
 }
@@ -534,32 +529,26 @@ static int pnv_pci_read_config(struct pci_bus *bus,
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
@@ -569,27 +558,21 @@ static int pnv_pci_write_config(struct pci_bus *bus,
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
index b160e6b..bff26d9 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -215,9 +215,9 @@ extern struct pnv_eeh_ops ioda_eeh_ops;
 
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
