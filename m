Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5B6301A0C7F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 16:16:35 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2B45714011D
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:35 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 15:16:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 08E283578053
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:32 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2H5GN6A47120402
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:16:32 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2H5FwvX011952
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:15:58 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 5/7] powerpc/eeh: Do probe on pci_dn
Date: Tue, 17 Mar 2015 16:15:06 +1100
Message-Id: <1426569308-9470-6-git-send-email-gwshan@linux.vnet.ibm.com>
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

Originally, EEH core probes on device_node or pci_dev to populate
EEH devices and PEs, which conflicts with the fact: SRIOV VFs are
usually enabled and created by PF's driver and they don't have the
corresponding device_nodes. Instead, SRIOV VFs have dynamically
created pci_dn, which can be used for EEH probe.

The patch reworks EEH probe for PowerNV and pSeries platforms to
do probing based on pci_dn, instead of pci_dev or device_node any
more.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  11 +-
 arch/powerpc/kernel/eeh.c                    |  63 ++++--------
 arch/powerpc/kernel/of_platform.c            |   2 +-
 arch/powerpc/kernel/pci-hotplug.c            |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 146 ++++++++++++++++++++-------
 arch/powerpc/platforms/pseries/eeh_pseries.c |  82 ++++++---------
 arch/powerpc/platforms/pseries/pci_dlpar.c   |   2 +-
 drivers/pci/hotplug/rpadlpar_core.c          |   2 +-
 8 files changed, 172 insertions(+), 138 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index bb24172..eefff1f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -206,8 +206,7 @@ struct eeh_ops {
 	char *name;
 	int (*init)(void);
 	int (*post_init)(void);
-	void* (*of_probe)(struct device_node *dn, void *flag);
-	int (*dev_probe)(struct pci_dev *dev, void *flag);
+	void* (*probe)(struct pci_dn *pdn, void *data);
 	int (*set_option)(struct eeh_pe *pe, int option);
 	int (*get_pe_addr)(struct eeh_pe *pe);
 	int (*get_state)(struct eeh_pe *pe, int *state);
@@ -286,8 +285,8 @@ int __exit eeh_ops_unregister(const char *name);
 int eeh_check_failure(const volatile void __iomem *token);
 int eeh_dev_check_failure(struct eeh_dev *edev);
 void eeh_addr_cache_build(void);
-void eeh_add_device_early(struct device_node *);
-void eeh_add_device_tree_early(struct device_node *);
+void eeh_add_device_early(struct pci_dn *);
+void eeh_add_device_tree_early(struct pci_dn *);
 void eeh_add_device_late(struct pci_dev *);
 void eeh_add_device_tree_late(struct pci_bus *);
 void eeh_add_sysfs_files(struct pci_bus *);
@@ -345,9 +344,9 @@ static inline int eeh_check_failure(const volatile void __iomem *token)
 
 static inline void eeh_addr_cache_build(void) { }
 
-static inline void eeh_add_device_early(struct device_node *dn) { }
+static inline void eeh_add_device_early(struct pci_dn *pdn) { }
 
-static inline void eeh_add_device_tree_early(struct device_node *dn) { }
+static inline void eeh_add_device_tree_early(struct pci_dn *pdn) { }
 
 static inline void eeh_add_device_late(struct pci_dev *dev) { }
 
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 19a897c..9504c2f 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -969,7 +969,7 @@ static struct notifier_block eeh_reboot_nb = {
 int eeh_init(void)
 {
 	struct pci_controller *hose, *tmp;
-	struct device_node *phb;
+	struct pci_dn *pdn;
 	static int cnt = 0;
 	int ret = 0;
 
@@ -1004,20 +1004,9 @@ int eeh_init(void)
 		return ret;
 
 	/* Enable EEH for all adapters */
-	if (eeh_has_flag(EEH_PROBE_MODE_DEVTREE)) {
-		list_for_each_entry_safe(hose, tmp,
-			&hose_list, list_node) {
-			phb = hose->dn;
-			traverse_pci_devices(phb, eeh_ops->of_probe, NULL);
-		}
-	} else if (eeh_has_flag(EEH_PROBE_MODE_DEV)) {
-		list_for_each_entry_safe(hose, tmp,
-			&hose_list, list_node)
-			pci_walk_bus(hose->bus, eeh_ops->dev_probe, NULL);
-	} else {
-		pr_warn("%s: Invalid probe mode %x",
-			__func__, eeh_subsystem_flags);
-		return -EINVAL;
+	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
+		pdn = hose->pci_data;
+		traverse_pci_dn(pdn, eeh_ops->probe, NULL);
 	}
 
 	/*
@@ -1043,7 +1032,7 @@ core_initcall_sync(eeh_init);
 
 /**
  * eeh_add_device_early - Enable EEH for the indicated device_node
- * @dn: device node for which to set up EEH
+ * @pdn: PCI device node for which to set up EEH
  *
  * This routine must be used to perform EEH initialization for PCI
  * devices that were added after system boot (e.g. hotplug, dlpar).
@@ -1053,44 +1042,41 @@ core_initcall_sync(eeh_init);
  * on the CEC architecture, type of the device, on earlier boot
  * command-line arguments & etc.
  */
-void eeh_add_device_early(struct device_node *dn)
+void eeh_add_device_early(struct pci_dn *pdn)
 {
 	struct pci_controller *phb;
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 
-	/*
-	 * If we're doing EEH probe based on PCI device, we
-	 * would delay the probe until late stage because
-	 * the PCI device isn't available this moment.
-	 */
-	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
-		return;
-
-	if (!of_node_to_eeh_dev(dn))
+	if (!edev)
 		return;
-	phb = of_node_to_eeh_dev(dn)->phb;
 
 	/* USB Bus children of PCI devices will not have BUID's */
-	if (NULL == phb || 0 == phb->buid)
+	phb = edev->phb;
+	if (NULL == phb ||
+	    (eeh_has_flag(EEH_PROBE_MODE_DEVTREE) && 0 == phb->buid))
 		return;
 
-	eeh_ops->of_probe(dn, NULL);
+	eeh_ops->probe(pdn, NULL);
 }
 
 /**
  * eeh_add_device_tree_early - Enable EEH for the indicated device
- * @dn: device node
+ * @pdn: PCI device node
  *
  * This routine must be used to perform EEH initialization for the
  * indicated PCI device that was added after system boot (e.g.
  * hotplug, dlpar).
  */
-void eeh_add_device_tree_early(struct device_node *dn)
+void eeh_add_device_tree_early(struct pci_dn *pdn)
 {
-	struct device_node *sib;
+	struct pci_dn *n;
+
+	if (!pdn)
+		return;
 
-	for_each_child_of_node(dn, sib)
-		eeh_add_device_tree_early(sib);
-	eeh_add_device_early(dn);
+	list_for_each_entry(n, &pdn->child_list, list)
+		eeh_add_device_tree_early(n);
+	eeh_add_device_early(pdn);
 }
 EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
 
@@ -1144,13 +1130,6 @@ void eeh_add_device_late(struct pci_dev *dev)
 	edev->pdev = dev;
 	dev->dev.archdata.edev = edev;
 
-	/*
-	 * We have to do the EEH probe here because the PCI device
-	 * hasn't been created yet in the early stage.
-	 */
-	if (eeh_has_flag(EEH_PROBE_MODE_DEV))
-		eeh_ops->dev_probe(dev, NULL);
-
 	eeh_addr_cache_insert_dev(dev);
 }
 
diff --git a/arch/powerpc/kernel/of_platform.c b/arch/powerpc/kernel/of_platform.c
index 2f35a72..b60a67d 100644
--- a/arch/powerpc/kernel/of_platform.c
+++ b/arch/powerpc/kernel/of_platform.c
@@ -72,7 +72,7 @@ static int of_pci_phb_probe(struct platform_device *dev)
 
 	/* Register devices with EEH */
 	if (dev->dev.of_node->child)
-		eeh_add_device_tree_early(dev->dev.of_node);
+		eeh_add_device_tree_early(PCI_DN(dev->dev.of_node));
 
 	/* Scan the bus */
 	pcibios_scan_phb(phb);
diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 5b78917..18d9575 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -75,7 +75,7 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 	struct pci_dev *dev;
 	struct device_node *dn = pci_bus_to_OF_node(bus);
 
-	eeh_add_device_tree_early(dn);
+	eeh_add_device_tree_early(PCI_DN(dn));
 
 	mode = PCI_PROBE_NORMAL;
 	if (ppc_md.pci_probe_mode)
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 8eac8c5..dcc524f 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -286,10 +286,82 @@ static int pnv_eeh_post_init(void)
 	return ret;
 }
 
+static int pnv_eeh_cap_start(struct pci_dn *pdn)
+{
+	u32 status;
+
+	if (!pdn)
+		return 0;
+
+	pnv_pci_cfg_read(pdn, PCI_STATUS, 2, &status);
+	if (!(status & PCI_STATUS_CAP_LIST))
+		return 0;
+
+	return PCI_CAPABILITY_LIST;
+}
+
+static int pnv_eeh_find_cap(struct pci_dn *pdn, int cap)
+{
+	int pos = pnv_eeh_cap_start(pdn);
+	int cnt = 48;   /* Maximal number of capabilities */
+	u32 id;
+
+	if (!pos)
+		return 0;
+
+	while (cnt--) {
+		pnv_pci_cfg_read(pdn, pos, 1, &pos);
+		if (pos < 0x40)
+			break;
+
+		pos &= ~3;
+		pnv_pci_cfg_read(pdn, pos + PCI_CAP_LIST_ID, 1, &id);
+		if (id == 0xff)
+			break;
+
+		/* Found */
+		if (id == cap)
+			return pos;
+
+		/* Next one */
+		pos += PCI_CAP_LIST_NEXT;
+	}
+
+	return 0;
+}
+
+static int pnv_eeh_find_ecap(struct pci_dn *pdn, int cap)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	u32 header;
+	int pos = 256, ttl = (4096 - 256) / 8;
+
+	if (!edev || !edev->pcie_cap)
+		return 0;
+	if (pnv_pci_cfg_read(pdn, pos, 4, &header) != PCIBIOS_SUCCESSFUL)
+		return 0;
+	else if (!header)
+		return 0;
+
+	while (ttl-- > 0) {
+		if (PCI_EXT_CAP_ID(header) == cap && pos)
+			return pos;
+
+		pos = PCI_EXT_CAP_NEXT(header);
+		if (pos < 256)
+			break;
+
+		if (pnv_pci_cfg_read(pdn, pos, 4, &header) != PCIBIOS_SUCCESSFUL)
+			break;
+	}
+
+	return 0;
+}
+
 /**
- * pnv_eeh_dev_probe - Do probe on PCI device
- * @dev: PCI device
- * @flag: unused
+ * pnv_eeh_probe - Do probe on PCI device
+ * @pdn: PCI device node
+ * @data: unused
  *
  * When EEH module is installed during system boot, all PCI devices
  * are checked one by one to see if it supports EEH. The function
@@ -303,12 +375,12 @@ static int pnv_eeh_post_init(void)
  * was possiblly triggered by EEH core, the binding between EEH device
  * and the PCI device isn't built yet.
  */
-static int pnv_eeh_dev_probe(struct pci_dev *dev, void *flag)
+static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 {
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pci_controller *hose = pdn->phb;
 	struct pnv_phb *phb = hose->private_data;
-	struct device_node *dn = pci_device_to_OF_node(dev);
-	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	uint32_t pcie_flags;
 	int ret;
 
 	/*
@@ -317,40 +389,42 @@ static int pnv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	 * the root bridge. So it's not reasonable to continue
 	 * the probing.
 	 */
-	if (!dn || !edev || edev->pe)
-		return 0;
+	if (!edev || edev->pe)
+		return NULL;
 
 	/* Skip for PCI-ISA bridge */
-	if ((dev->class >> 8) == PCI_CLASS_BRIDGE_ISA)
-		return 0;
+	if ((pdn->class_code >> 8) == PCI_CLASS_BRIDGE_ISA)
+		return NULL;
 
 	/* Initialize eeh device */
-	edev->class_code = dev->class;
+	edev->class_code = pdn->class_code;
 	edev->mode	&= 0xFFFFFF00;
-	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+	edev->pcix_cap = pnv_eeh_find_cap(pdn, PCI_CAP_ID_PCIX);
+	edev->pcie_cap = pnv_eeh_find_cap(pdn, PCI_CAP_ID_EXP);
+	edev->aer_cap  = pnv_eeh_find_ecap(pdn, PCI_EXT_CAP_ID_ERR);
+	if ((edev->class_code >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		edev->mode |= EEH_DEV_BRIDGE;
-	edev->pcix_cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
-	if (pci_is_pcie(dev)) {
-		edev->pcie_cap = pci_pcie_cap(dev);
-
-		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-			edev->mode |= EEH_DEV_ROOT_PORT;
-		else if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)
-			edev->mode |= EEH_DEV_DS_PORT;
-
-		edev->aer_cap = pci_find_ext_capability(dev,
-							PCI_EXT_CAP_ID_ERR);
+		if (edev->pcie_cap) {
+			pnv_pci_cfg_read(pdn, edev->pcie_cap + PCI_EXP_FLAGS,
+					 2, &pcie_flags);
+			pcie_flags = (pcie_flags & PCI_EXP_FLAGS_TYPE) >> 4;
+			if (pcie_flags == PCI_EXP_TYPE_ROOT_PORT)
+				edev->mode |= EEH_DEV_ROOT_PORT;
+			else if (pcie_flags == PCI_EXP_TYPE_DOWNSTREAM)
+				edev->mode |= EEH_DEV_DS_PORT;
+		}
 	}
 
-	edev->config_addr	= ((dev->bus->number << 8) | dev->devfn);
-	edev->pe_config_addr	= phb->bdfn_to_pe(phb, dev->bus, dev->devfn & 0xff);
+	edev->config_addr    = (pdn->busno << 8) | (pdn->devfn);
+	edev->pe_config_addr = phb->ioda.pe_rmap[edev->config_addr];
 
 	/* Create PE */
 	ret = eeh_add_to_parent_pe(edev);
 	if (ret) {
-		pr_warn("%s: Can't add PCI dev %s to parent PE (%d)\n",
-			__func__, pci_name(dev), ret);
-		return ret;
+		pr_warn("%s: Can't add PCI dev %04x:%02x:%02x.%01x to parent PE (%d)\n",
+			__func__, hose->global_number, pdn->busno,
+			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn), ret);
+		return NULL;
 	}
 
 	/*
@@ -369,8 +443,10 @@ static int pnv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	 * Broadcom Austin 4-ports NICs (14e4:1657)
 	 * Broadcom Shiner 2-ports 10G NICs (14e4:168e)
 	 */
-	if ((dev->vendor == PCI_VENDOR_ID_BROADCOM && dev->device == 0x1657) ||
-	    (dev->vendor == PCI_VENDOR_ID_BROADCOM && dev->device == 0x168e))
+	if ((pdn->vendor_id == PCI_VENDOR_ID_BROADCOM &&
+	     pdn->device_id == 0x1657) ||
+	    (pdn->vendor_id == PCI_VENDOR_ID_BROADCOM &&
+	     pdn->device_id == 0x168e))
 		edev->pe->state |= EEH_PE_CFG_RESTRICTED;
 
 	/*
@@ -380,7 +456,8 @@ static int pnv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	 * to PE reset.
 	 */
 	if (!edev->pe->bus)
-		edev->pe->bus = dev->bus;
+		edev->pe->bus = pci_find_bus(hose->global_number,
+					     pdn->busno);
 
 	/*
 	 * Enable EEH explicitly so that we will do EEH check
@@ -391,7 +468,7 @@ static int pnv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	/* Save memory bars */
 	eeh_save_bars(edev);
 
-	return 0;
+	return NULL;
 }
 
 /**
@@ -1432,8 +1509,7 @@ static struct eeh_ops pnv_eeh_ops = {
 	.name                   = "powernv",
 	.init                   = pnv_eeh_init,
 	.post_init              = pnv_eeh_post_init,
-	.of_probe               = NULL,
-	.dev_probe              = pnv_eeh_dev_probe,
+	.probe			= pnv_eeh_probe,
 	.set_option             = pnv_eeh_set_option,
 	.get_pe_addr            = pnv_eeh_get_pe_addr,
 	.get_state              = pnv_eeh_get_state,
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index a6c7e19..a2946f7 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -118,9 +118,8 @@ static int pseries_eeh_init(void)
 	return 0;
 }
 
-static int pseries_eeh_cap_start(struct device_node *dn)
+static int pseries_eeh_cap_start(struct pci_dn *pdn)
 {
-	struct pci_dn *pdn = PCI_DN(dn);
 	u32 status;
 
 	if (!pdn)
@@ -134,10 +133,9 @@ static int pseries_eeh_cap_start(struct device_node *dn)
 }
 
 
-static int pseries_eeh_find_cap(struct device_node *dn, int cap)
+static int pseries_eeh_find_cap(struct pci_dn *pdn, int cap)
 {
-	struct pci_dn *pdn = PCI_DN(dn);
-	int pos = pseries_eeh_cap_start(dn);
+	int pos = pseries_eeh_cap_start(pdn);
 	int cnt = 48;	/* Maximal number of capabilities */
 	u32 id;
 
@@ -160,10 +158,9 @@ static int pseries_eeh_find_cap(struct device_node *dn, int cap)
 	return 0;
 }
 
-static int pseries_eeh_find_ecap(struct device_node *dn, int cap)
+static int pseries_eeh_find_ecap(struct pci_dn *pdn, int cap)
 {
-	struct pci_dn *pdn = PCI_DN(dn);
-	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 	u32 header;
 	int pos = 256;
 	int ttl = (4096 - 256) / 8;
@@ -191,53 +188,44 @@ static int pseries_eeh_find_ecap(struct device_node *dn, int cap)
 }
 
 /**
- * pseries_eeh_of_probe - EEH probe on the given device
- * @dn: OF node
- * @flag: Unused
+ * pseries_eeh_probe - EEH probe on the given device
+ * @pdn: PCI device node
+ * @data: Unused
  *
  * When EEH module is installed during system boot, all PCI devices
  * are checked one by one to see if it supports EEH. The function
  * is introduced for the purpose.
  */
-static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
+static void *pseries_eeh_probe(struct pci_dn *pdn, void *data)
 {
 	struct eeh_dev *edev;
 	struct eeh_pe pe;
-	struct pci_dn *pdn = PCI_DN(dn);
-	const __be32 *classp, *vendorp, *devicep;
-	u32 class_code;
-	const __be32 *regs;
 	u32 pcie_flags;
 	int enable = 0;
 	int ret;
 
 	/* Retrieve OF node and eeh device */
-	edev = of_node_to_eeh_dev(dn);
-	if (edev->pe || !of_device_is_available(dn))
+	edev = pdn_to_eeh_dev(pdn);
+	if (!edev || edev->pe)
 		return NULL;
 
-	/* Retrieve class/vendor/device IDs */
-	classp = of_get_property(dn, "class-code", NULL);
-	vendorp = of_get_property(dn, "vendor-id", NULL);
-	devicep = of_get_property(dn, "device-id", NULL);
-
-	/* Skip for bad OF node or PCI-ISA bridge */
-	if (!classp || !vendorp || !devicep)
-		return NULL;
-	if (dn->type && !strcmp(dn->type, "isa"))
+	/* Check class/vendor/device IDs */
+	if (!pdn->vendor_id || !pdn->device_id || !pdn->class_code)
 		return NULL;
 
-	class_code = of_read_number(classp, 1);
+	/* Skip for PCI-ISA bridge */
+        if ((pdn->class_code >> 8) == PCI_CLASS_BRIDGE_ISA)
+		return NULL;
 
 	/*
 	 * Update class code and mode of eeh device. We need
 	 * correctly reflects that current device is root port
 	 * or PCIe switch downstream port.
 	 */
-	edev->class_code = class_code;
-	edev->pcix_cap = pseries_eeh_find_cap(dn, PCI_CAP_ID_PCIX);
-	edev->pcie_cap = pseries_eeh_find_cap(dn, PCI_CAP_ID_EXP);
-	edev->aer_cap = pseries_eeh_find_ecap(dn, PCI_EXT_CAP_ID_ERR);
+	edev->class_code = pdn->class_code;
+	edev->pcix_cap = pseries_eeh_find_cap(pdn, PCI_CAP_ID_PCIX);
+	edev->pcie_cap = pseries_eeh_find_cap(pdn, PCI_CAP_ID_EXP);
+	edev->aer_cap = pseries_eeh_find_ecap(pdn, PCI_EXT_CAP_ID_ERR);
 	edev->mode &= 0xFFFFFF00;
 	if ((edev->class_code >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		edev->mode |= EEH_DEV_BRIDGE;
@@ -252,24 +240,16 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 		}
 	}
 
-	/* Retrieve the device address */
-	regs = of_get_property(dn, "reg", NULL);
-	if (!regs) {
-		pr_warn("%s: OF node property %s::reg not found\n",
-			__func__, dn->full_name);
-		return NULL;
-	}
-
 	/* Initialize the fake PE */
 	memset(&pe, 0, sizeof(struct eeh_pe));
 	pe.phb = edev->phb;
-	pe.config_addr = of_read_number(regs, 1);
+	pe.config_addr = (pdn->busno << 16) | (pdn->devfn << 8);
 
 	/* Enable EEH on the device */
 	ret = eeh_ops->set_option(&pe, EEH_OPT_ENABLE);
 	if (!ret) {
-		edev->config_addr = of_read_number(regs, 1);
 		/* Retrieve PE address */
+		edev->config_addr = (pdn->busno << 16) | (pdn->devfn << 8);
 		edev->pe_config_addr = eeh_ops->get_pe_addr(&pe);
 		pe.addr = edev->pe_config_addr;
 
@@ -285,16 +265,17 @@ static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
 			eeh_add_flag(EEH_ENABLED);
 			eeh_add_to_parent_pe(edev);
 
-			pr_debug("%s: EEH enabled on %s PHB#%d-PE#%x, config addr#%x\n",
-				__func__, dn->full_name, pe.phb->global_number,
-				pe.addr, pe.config_addr);
-		} else if (dn->parent && of_node_to_eeh_dev(dn->parent) &&
-			   (of_node_to_eeh_dev(dn->parent))->pe) {
+			pr_debug("%s: EEH enabled on %02x:%02x.%01x PHB#%d-PE#%x\n",
+				__func__, pdn->busno, PCI_SLOT(pdn->devfn),
+				PCI_FUNC(pdn->devfn), pe.phb->global_number,
+				pe.addr);
+		} else if (pdn->parent && pdn_to_eeh_dev(pdn->parent) &&
+			   (pdn_to_eeh_dev(pdn->parent))->pe) {
 			/* This device doesn't support EEH, but it may have an
 			 * EEH parent, in which case we mark it as supported.
 			 */
-			edev->config_addr = of_node_to_eeh_dev(dn->parent)->config_addr;
-			edev->pe_config_addr = of_node_to_eeh_dev(dn->parent)->pe_config_addr;
+			edev->config_addr = pdn_to_eeh_dev(pdn->parent)->config_addr;
+			edev->pe_config_addr = pdn_to_eeh_dev(pdn->parent)->pe_config_addr;
 			eeh_add_to_parent_pe(edev);
 		}
 	}
@@ -707,8 +688,7 @@ static int pseries_eeh_write_config(struct device_node *dn, int where, int size,
 static struct eeh_ops pseries_eeh_ops = {
 	.name			= "pseries",
 	.init			= pseries_eeh_init,
-	.of_probe		= pseries_eeh_of_probe,
-	.dev_probe		= NULL,
+	.probe			= pseries_eeh_probe,
 	.set_option		= pseries_eeh_set_option,
 	.get_pe_addr		= pseries_eeh_get_pe_addr,
 	.get_state		= pseries_eeh_get_state,
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 89e2381..f735f4f 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -82,7 +82,7 @@ struct pci_controller *init_phb_dynamic(struct device_node *dn)
 	eeh_dev_phb_init_dynamic(phb);
 
 	if (dn->child)
-		eeh_add_device_tree_early(dn);
+		eeh_add_device_tree_early(PCI_DN(dn));
 
 	pcibios_scan_phb(phb);
 	pcibios_finish_adding_to_bus(phb->bus);
diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 7660232..e12bafd 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -146,7 +146,7 @@ static void dlpar_pci_add_bus(struct device_node *dn)
 	struct pci_controller *phb = pdn->phb;
 	struct pci_dev *dev = NULL;
 
-	eeh_add_device_tree_early(dn);
+	eeh_add_device_tree_early(pdn);
 
 	/* Add EADS device to PHB bus, adding new entry to bus->devices */
 	dev = of_create_pci_dev(dn, phb->bus, pdn->devfn);
-- 
1.8.3.2
