Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BA19414016F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:32 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 24 Apr 2014 18:00:30 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F1E902BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:26 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3O7dXVR19529956
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 17:39:33 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3O80Qek014826
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 18:00:26 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 06/25] powerpc/eeh: Block PCI-CFG access during PE reset
Date: Thu, 24 Apr 2014 18:00:12 +1000
Message-Id: <1398326431-24305-7-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1398326431-24305-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We've observed multiple PE reset failures because of PCI-CFG
access during that period. Potentially, some device drivers
can't support EEH very well and they can't put the device to
motionless state before PE reset. So those device drivers might
produce PCI-CFG accesses during PE reset. Also, we could have
PCI-CFG access from user space (e.g. "lspci"). Since access to
frozen PE should return 0xFF's, we can block PCI-CFG access
during the period of PE reset so that we won't get recrusive EEH
errors.

The patch adds flag EEH_PE_RESET, which is kept during PE reset.
The PowerNV/pSeries PCI-CFG accessors reuse the flag to block
PCI-CFG accordingly.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h       |   1 +
 arch/powerpc/kernel/eeh_driver.c     |  13 ++++-
 arch/powerpc/kernel/rtas_pci.c       |  66 +++++++++++++++++------
 arch/powerpc/platforms/powernv/pci.c | 100 ++++++++++++++++++++++-------------
 4 files changed, 126 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index a61b06f..fa32d8d 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -53,6 +53,7 @@ struct device_node;
 
 #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
 #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
+#define EEH_PE_RESET		(1 << 2)	/* PE reset in progress	*/
 
 #define EEH_PE_KEEP		(1 << 8)	/* Keep PE on hotplug	*/
 
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 1ddc046..6d91b51 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -451,19 +451,28 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus)
 		eeh_pe_dev_traverse(pe, eeh_rmv_device, &removed);
 	}
 
-	/* Reset the pci controller. (Asserts RST#; resets config space).
+	/*
+	 * Reset the pci controller. (Asserts RST#; resets config space).
 	 * Reconfigure bridges and devices. Don't try to bring the system
 	 * up if the reset failed for some reason.
+	 *
+	 * During the reset, it's very dangerous to have uncontrolled PCI
+	 * config accesses. So we prefer to block them. However, controlled
+	 * PCI config accesses initiated from EEH itself are allowed.
 	 */
+	eeh_pe_state_mark(pe, EEH_PE_RESET);
 	rc = eeh_reset_pe(pe);
-	if (rc)
+	if (rc) {
+		eeh_pe_state_clear(pe, EEH_PE_RESET);
 		return rc;
+	}
 
 	pci_lock_rescan_remove();
 
 	/* Restore PE */
 	eeh_ops->configure_bridge(pe);
 	eeh_pe_restore_bars(pe);
+	eeh_pe_state_clear(pe, EEH_PE_RESET);
 
 	/* Give the system 5 seconds to finish running the user-space
 	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes,
diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 7d4c717..c168337 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -80,10 +80,6 @@ int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 	if (ret)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
-	if (returnval == EEH_IO_ERROR_VALUE(size) &&
-	    eeh_dev_check_failure(of_node_to_eeh_dev(pdn->node)))
-		return PCIBIOS_DEVICE_NOT_FOUND;
-
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -92,18 +88,39 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 				int where, int size, u32 *val)
 {
 	struct device_node *busdn, *dn;
-
-	busdn = pci_bus_to_OF_node(bus);
+	struct pci_dn *pdn;
+	bool found = false;
+#ifdef CONFIG_EEH
+	struct eeh_dev *edev;
+#endif
+	int ret;
 
 	/* Search only direct children of the bus */
+	*val = 0xFFFFFFFF;
+	busdn = pci_bus_to_OF_node(bus);
 	for (dn = busdn->child; dn; dn = dn->sibling) {
-		struct pci_dn *pdn = PCI_DN(dn);
+		pdn = PCI_DN(dn);
 		if (pdn && pdn->devfn == devfn
-		    && of_device_is_available(dn))
-			return rtas_read_config(pdn, where, size, val);
+		    && of_device_is_available(dn)) {
+			found = true;
+			break;
+		}
 	}
 
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	if (!found)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+#ifdef CONFIG_EEH
+	edev = of_node_to_eeh_dev(dn);
+	if (edev && edev->pe && edev->pe->state & EEH_PE_RESET)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+#endif
+
+	ret = rtas_read_config(pdn, where, size, val);
+	if (*val == EEH_IO_ERROR_VALUE(size) &&
+	    eeh_dev_check_failure(of_node_to_eeh_dev(dn)))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	return ret;
 }
 
 int rtas_write_config(struct pci_dn *pdn, int where, int size, u32 val)
@@ -136,17 +153,34 @@ static int rtas_pci_write_config(struct pci_bus *bus,
 				 int where, int size, u32 val)
 {
 	struct device_node *busdn, *dn;
-
-	busdn = pci_bus_to_OF_node(bus);
+	struct pci_dn *pdn;
+	bool found = false;
+#ifdef CONFIG_EEH
+	struct eeh_dev *edev;
+#endif
+	int ret;
 
 	/* Search only direct children of the bus */
+	busdn = pci_bus_to_OF_node(bus);
 	for (dn = busdn->child; dn; dn = dn->sibling) {
-		struct pci_dn *pdn = PCI_DN(dn);
+		pdn = PCI_DN(dn);
 		if (pdn && pdn->devfn == devfn
-		    && of_device_is_available(dn))
-			return rtas_write_config(pdn, where, size, val);
+		    && of_device_is_available(dn)) {
+			found = true;
+			break;
+		}
 	}
-	return PCIBIOS_DEVICE_NOT_FOUND;
+
+	if (!found)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+#ifdef CONFIG_EEH
+	edev = of_node_to_eeh_dev(dn);
+	if (edev && edev->pe && (edev->pe->state & EEH_PE_RESET))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+#endif
+	ret = rtas_write_config(pdn, where, size, val);
+
+	return ret;
 }
 
 static struct pci_ops rtas_pci_ops = {
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 2de283d..f98cf99 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -373,9 +373,6 @@ int pnv_pci_cfg_read(struct device_node *dn,
 	struct pci_dn *pdn = PCI_DN(dn);
 	struct pnv_phb *phb = pdn->phb->private_data;
 	u32 bdfn = (pdn->busno << 8) | pdn->devfn;
-#ifdef CONFIG_EEH
-	struct eeh_pe *phb_pe = NULL;
-#endif
 	s64 rc;
 
 	switch (size) {
@@ -401,31 +398,9 @@ int pnv_pci_cfg_read(struct device_node *dn,
 	default:
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
+
 	cfg_dbg("%s: bus: %x devfn: %x +%x/%x -> %08x\n",
 		__func__, pdn->busno, pdn->devfn, where, size, *val);
-
-	/*
-	 * Check if the specified PE has been put into frozen
-	 * state. On the other hand, we needn't do that while
-	 * the PHB has been put into frozen state because of
-	 * PHB-fatal errors.
-	 */
-#ifdef CONFIG_EEH
-	phb_pe = eeh_phb_pe_get(pdn->phb);
-	if (phb_pe && (phb_pe->state & EEH_PE_ISOLATED))
-		return PCIBIOS_SUCCESSFUL;
-
-	if (phb->flags & PNV_PHB_FLAG_EEH) {
-		if (*val == EEH_IO_ERROR_VALUE(size) &&
-		    eeh_dev_check_failure(of_node_to_eeh_dev(dn)))
-			return PCIBIOS_DEVICE_NOT_FOUND;
-	} else {
-		pnv_pci_config_check_eeh(phb, dn);
-	}
-#else
-	pnv_pci_config_check_eeh(phb, dn);
-#endif
-
 	return PCIBIOS_SUCCESSFUL;
 }
 
@@ -452,12 +427,35 @@ int pnv_pci_cfg_write(struct device_node *dn,
 		return PCIBIOS_FUNC_NOT_SUPPORTED;
 	}
 
-	/* Check if the PHB got frozen due to an error (no response) */
+	return PCIBIOS_SUCCESSFUL;
+}
+
+#if CONFIG_EEH
+static bool pnv_pci_cfg_check(struct pci_controller *hose,
+			      struct device_node *dn)
+{
+	struct eeh_dev *edev = NULL;
+	struct pnv_phb *phb = hose->private_data;
+
+	/* EEH not enabled ? */
 	if (!(phb->flags & PNV_PHB_FLAG_EEH))
-		pnv_pci_config_check_eeh(phb, dn);
+		return true;
 
-	return PCIBIOS_SUCCESSFUL;
+	/* PE reset ? */
+	edev = of_node_to_eeh_dev(dn);
+	if (edev && edev->pe &&
+	    (edev->pe->state & EEH_PE_RESET))
+		return false;
+
+	return true;
+}
+#else
+static inline pnv_pci_cfg_check(struct pci_controller *hose,
+				struct device_node *dn)
+{
+	return true;
 }
+#endif /* CONFIG_EEH */
 
 static int pnv_pci_read_config(struct pci_bus *bus,
 			       unsigned int devfn,
@@ -465,16 +463,33 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 {
 	struct device_node *dn, *busdn = pci_bus_to_OF_node(bus);
 	struct pci_dn *pdn;
+	struct pnv_phb *phb;
+	bool found = false;
+	int ret;
 
+	*val = 0xFFFFFFFF;
 	for (dn = busdn->child; dn; dn = dn->sibling) {
 		pdn = PCI_DN(dn);
-		if (pdn && pdn->devfn == devfn)
-			return pnv_pci_cfg_read(dn, where, size, val);
+		if (pdn && pdn->devfn == devfn) {
+			phb = pdn->phb->private_data;
+			found = true;
+			break;
+		}
 	}
 
-	*val = 0xFFFFFFFF;
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	if (!found || !pnv_pci_cfg_check(pdn->phb, dn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	ret = pnv_pci_cfg_read(dn, where, size, val);
+	if (phb->flags & PNV_PHB_FLAG_EEH) {
+		if (*val == EEH_IO_ERROR_VALUE(size) &&
+		    eeh_dev_check_failure(of_node_to_eeh_dev(dn)))
+                        return PCIBIOS_DEVICE_NOT_FOUND;
+	} else {
+		pnv_pci_config_check_eeh(phb, dn);
+	}
+
+	return ret;
 }
 
 static int pnv_pci_write_config(struct pci_bus *bus,
@@ -483,14 +498,27 @@ static int pnv_pci_write_config(struct pci_bus *bus,
 {
 	struct device_node *dn, *busdn = pci_bus_to_OF_node(bus);
 	struct pci_dn *pdn;
+	struct pnv_phb *phb;
+	bool found = false;
+	int ret;
 
 	for (dn = busdn->child; dn; dn = dn->sibling) {
 		pdn = PCI_DN(dn);
-		if (pdn && pdn->devfn == devfn)
-			return pnv_pci_cfg_write(dn, where, size, val);
+		if (pdn && pdn->devfn == devfn) {
+			phb = pdn->phb->private_data;
+			found = true;
+			break;
+		}
 	}
 
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	if (!found || !pnv_pci_cfg_check(pdn->phb, dn))
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	ret = pnv_pci_cfg_write(dn, where, size, val);
+	if (!(phb->flags & PNV_PHB_FLAG_EEH))
+		pnv_pci_config_check_eeh(phb, dn);
+
+	return ret;
 }
 
 struct pci_ops pnv_pci_ops = {
-- 
1.8.3.2
