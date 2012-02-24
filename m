Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A55F9B6FBA
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:30 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 15:08:27 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1O9cPgc2281720
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 15:08:25 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1O9cO9O005840
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:25 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 17/21] Replace pci_dn with eeh_dev for EEH core
Date: Fri, 24 Feb 2012 17:38:14 +0800
Message-Id: <1330076298-7006-18-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: kernel.crashing.org@shangw, shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The original EEH implementation is heavily depending on struct pci_dn.
We have to put EEH related information to pci_dn. Actually, we could
split struct pci_dn so that the EEH sensitive information to form an
individual struct, then EEH looks more independent.

The patch replaces pci_dn with eeh_dev for EEH core.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h   |    8 +-
 arch/powerpc/platforms/pseries/eeh.c |  269 ++++++++++++++++++----------------
 2 files changed, 144 insertions(+), 133 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index c02d5a7..8c003eb 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -53,10 +53,10 @@ void pci_addr_cache_build(void);
 void pci_addr_cache_insert_device(struct pci_dev *dev);
 void pci_addr_cache_remove_device(struct pci_dev *dev);
 struct pci_dev *pci_addr_cache_get_device(unsigned long addr);
-void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
-int eeh_pci_enable(struct pci_dn *pdn, int function);
-int eeh_reset_pe(struct pci_dn *);
-void eeh_restore_bars(struct pci_dn *);
+void eeh_slot_error_detail(struct eeh_dev *pdn, int severity);
+int eeh_pci_enable(struct eeh_dev *edev, int function);
+int eeh_reset_pe(struct eeh_dev *);
+void eeh_restore_bars(struct eeh_dev *);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 void eeh_mark_slot(struct device_node *dn, int mode_flag);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 646b520..84a8a0c 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -115,28 +115,29 @@ static unsigned long slot_resets;
 
 /**
  * eeh_gather_pci_data - Copy assorted PCI config space registers to buff
- * @pdn: device to report data for
+ * @edev: device to report data for
  * @buf: point to buffer in which to log
  * @len: amount of room in buffer
  *
  * This routine captures assorted PCI configuration space data,
  * and puts them into a buffer for RTAS error logging.
  */
-static size_t eeh_gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
+static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
 {
-	struct pci_dev *dev = pdn->pcidev;
+	struct device_node *dn = EEH_DEV_TO_OF_NODE(edev);
+	struct pci_dev *dev = EEH_DEV_TO_PCI_DEV(edev);
 	u32 cfg;
 	int cap, i;
 	int n = 0;
 
-	n += scnprintf(buf+n, len-n, "%s\n", pdn->node->full_name);
-	printk(KERN_WARNING "EEH: of node=%s\n", pdn->node->full_name);
+	n += scnprintf(buf+n, len-n, "%s\n", dn->full_name);
+	printk(KERN_WARNING "EEH: of node=%s\n", dn->full_name);
 
-	rtas_read_config(pdn, PCI_VENDOR_ID, 4, &cfg);
+	rtas_read_config(PCI_DN(dn), PCI_VENDOR_ID, 4, &cfg);
 	n += scnprintf(buf+n, len-n, "dev/vend:%08x\n", cfg);
 	printk(KERN_WARNING "EEH: PCI device/vendor: %08x\n", cfg);
 
-	rtas_read_config(pdn, PCI_COMMAND, 4, &cfg);
+	rtas_read_config(PCI_DN(dn), PCI_COMMAND, 4, &cfg);
 	n += scnprintf(buf+n, len-n, "cmd/stat:%x\n", cfg);
 	printk(KERN_WARNING "EEH: PCI cmd/status register: %08x\n", cfg);
 
@@ -147,11 +148,11 @@ static size_t eeh_gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 
 	/* Gather bridge-specific registers */
 	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
-		rtas_read_config(pdn, PCI_SEC_STATUS, 2, &cfg);
+		rtas_read_config(PCI_DN(dn), PCI_SEC_STATUS, 2, &cfg);
 		n += scnprintf(buf+n, len-n, "sec stat:%x\n", cfg);
 		printk(KERN_WARNING "EEH: Bridge secondary status: %04x\n", cfg);
 
-		rtas_read_config(pdn, PCI_BRIDGE_CONTROL, 2, &cfg);
+		rtas_read_config(PCI_DN(dn), PCI_BRIDGE_CONTROL, 2, &cfg);
 		n += scnprintf(buf+n, len-n, "brdg ctl:%x\n", cfg);
 		printk(KERN_WARNING "EEH: Bridge control: %04x\n", cfg);
 	}
@@ -159,11 +160,11 @@ static size_t eeh_gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 	/* Dump out the PCI-X command and status regs */
 	cap = pci_find_capability(dev, PCI_CAP_ID_PCIX);
 	if (cap) {
-		rtas_read_config(pdn, cap, 4, &cfg);
+		rtas_read_config(PCI_DN(dn), cap, 4, &cfg);
 		n += scnprintf(buf+n, len-n, "pcix-cmd:%x\n", cfg);
 		printk(KERN_WARNING "EEH: PCI-X cmd: %08x\n", cfg);
 
-		rtas_read_config(pdn, cap+4, 4, &cfg);
+		rtas_read_config(PCI_DN(dn), cap+4, 4, &cfg);
 		n += scnprintf(buf+n, len-n, "pcix-stat:%x\n", cfg);
 		printk(KERN_WARNING "EEH: PCI-X status: %08x\n", cfg);
 	}
@@ -176,7 +177,7 @@ static size_t eeh_gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 		       "EEH: PCI-E capabilities and status follow:\n");
 
 		for (i=0; i<=8; i++) {
-			rtas_read_config(pdn, cap+4*i, 4, &cfg);
+			rtas_read_config(PCI_DN(dn), cap+4*i, 4, &cfg);
 			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
 			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
 		}
@@ -188,7 +189,7 @@ static size_t eeh_gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 			       "EEH: PCI-E AER capability register set follows:\n");
 
 			for (i=0; i<14; i++) {
-				rtas_read_config(pdn, cap+4*i, 4, &cfg);
+				rtas_read_config(PCI_DN(dn), cap+4*i, 4, &cfg);
 				n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
 				printk(KERN_WARNING "EEH: PCI-E AER %02x: %08x\n", i, cfg);
 			}
@@ -197,12 +198,11 @@ static size_t eeh_gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 
 	/* Gather status on devices under the bridge */
 	if (dev->class >> 16 == PCI_BASE_CLASS_BRIDGE) {
-		struct device_node *dn;
+		struct device_node *child;
 
-		for_each_child_of_node(pdn->node, dn) {
-			pdn = PCI_DN(dn);
-			if (pdn)
-				n += eeh_gather_pci_data(pdn, buf+n, len-n);
+		for_each_child_of_node(dn, child) {
+			if (OF_NODE_TO_EEH_DEV(child))
+				n += eeh_gather_pci_data(OF_NODE_TO_EEH_DEV(child), buf+n, len-n);
 		}
 	}
 
@@ -211,7 +211,7 @@ static size_t eeh_gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 
 /**
  * eeh_slot_error_detail - Generate combined log including driver log and error log
- * @pdn: device node
+ * @edev: device to report error log for
  * @severity: temporary or permanent error log
  *
  * This routine should be called to generate the combined log, which
@@ -219,17 +219,17 @@ static size_t eeh_gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
  * out from the config space of the corresponding PCI device, while
  * the error log is fetched through platform dependent function call.
  */
-void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
+void eeh_slot_error_detail(struct eeh_dev *edev, int severity)
 {
 	size_t loglen = 0;
 	pci_regs_buf[0] = 0;
 
-	eeh_pci_enable(pdn, EEH_OPT_THAW_MMIO);
-	eeh_ops->configure_bridge(pdn->node);
-	eeh_restore_bars(pdn);
-	loglen = eeh_gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
+	eeh_pci_enable(edev, EEH_OPT_THAW_MMIO);
+	eeh_ops->configure_bridge(EEH_DEV_TO_OF_NODE(edev));
+	eeh_restore_bars(edev);
+	loglen = eeh_gather_pci_data(edev, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
 
-	eeh_ops->get_log(pdn->node, severity, pci_regs_buf, loglen);
+	eeh_ops->get_log(EEH_DEV_TO_OF_NODE(edev), severity, pci_regs_buf, loglen);
 }
 
 /**
@@ -260,8 +260,8 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
  */
 struct device_node *eeh_find_device_pe(struct device_node *dn)
 {
-	while ((dn->parent) && PCI_DN(dn->parent) &&
-	      (PCI_DN(dn->parent)->eeh_mode & EEH_MODE_SUPPORTED)) {
+	while (dn->parent && OF_NODE_TO_EEH_DEV(dn->parent) &&
+	       (OF_NODE_TO_EEH_DEV(dn->parent)->mode & EEH_MODE_SUPPORTED)) {
 		dn = dn->parent;
 	}
 	return dn;
@@ -284,11 +284,11 @@ static void __eeh_mark_slot(struct device_node *parent, int mode_flag)
 	struct device_node *dn;
 
 	for_each_child_of_node(parent, dn) {
-		if (PCI_DN(dn)) {
+		if (OF_NODE_TO_EEH_DEV(dn)) {
 			/* Mark the pci device driver too */
-			struct pci_dev *dev = PCI_DN(dn)->pcidev;
+			struct pci_dev *dev = OF_NODE_TO_EEH_DEV(dn)->pdev;
 
-			PCI_DN(dn)->eeh_mode |= mode_flag;
+			OF_NODE_TO_EEH_DEV(dn)->mode |= mode_flag;
 
 			if (dev && dev->driver)
 				dev->error_state = pci_channel_io_frozen;
@@ -312,13 +312,13 @@ void eeh_mark_slot(struct device_node *dn, int mode_flag)
 	dn = eeh_find_device_pe(dn);
 
 	/* Back up one, since config addrs might be shared */
-	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
+	if (!pcibios_find_pci_bus(dn) && OF_NODE_TO_EEH_DEV(dn->parent))
 		dn = dn->parent;
 
-	PCI_DN(dn)->eeh_mode |= mode_flag;
+	OF_NODE_TO_EEH_DEV(dn)->mode |= mode_flag;
 
 	/* Mark the pci device too */
-	dev = PCI_DN(dn)->pcidev;
+	dev = OF_NODE_TO_EEH_DEV(dn)->pdev;
 	if (dev)
 		dev->error_state = pci_channel_io_frozen;
 
@@ -337,9 +337,9 @@ static void __eeh_clear_slot(struct device_node *parent, int mode_flag)
 	struct device_node *dn;
 
 	for_each_child_of_node(parent, dn) {
-		if (PCI_DN(dn)) {
-			PCI_DN(dn)->eeh_mode &= ~mode_flag;
-			PCI_DN(dn)->eeh_check_count = 0;
+		if (OF_NODE_TO_EEH_DEV(dn)) {
+			OF_NODE_TO_EEH_DEV(dn)->mode &= ~mode_flag;
+			OF_NODE_TO_EEH_DEV(dn)->check_count = 0;
 			__eeh_clear_slot(dn, mode_flag);
 		}
 	}
@@ -360,11 +360,11 @@ void eeh_clear_slot(struct device_node *dn, int mode_flag)
 	dn = eeh_find_device_pe(dn);
 	
 	/* Back up one, since config addrs might be shared */
-	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
+	if (!pcibios_find_pci_bus(dn) && OF_NODE_TO_EEH_DEV(dn->parent))
 		dn = dn->parent;
 
-	PCI_DN(dn)->eeh_mode &= ~mode_flag;
-	PCI_DN(dn)->eeh_check_count = 0;
+	OF_NODE_TO_EEH_DEV(dn)->mode &= ~mode_flag;
+	OF_NODE_TO_EEH_DEV(dn)->check_count = 0;
 	__eeh_clear_slot(dn, mode_flag);
 	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 }
@@ -388,7 +388,7 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 {
 	int ret;
 	unsigned long flags;
-	struct pci_dn *pdn;
+	struct eeh_dev *edev;
 	int rc = 0;
 	const char *location;
 
@@ -402,18 +402,18 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 		return 0;
 	}
 	dn = eeh_find_device_pe(dn);
-	pdn = PCI_DN(dn);
+	edev = OF_NODE_TO_EEH_DEV(dn);
 
 	/* Access to IO BARs might get this far and still not want checking. */
-	if (!(pdn->eeh_mode & EEH_MODE_SUPPORTED) ||
-	    pdn->eeh_mode & EEH_MODE_NOCHECK) {
+	if (!(edev->mode & EEH_MODE_SUPPORTED) ||
+	    edev->mode & EEH_MODE_NOCHECK) {
 		ignored_check++;
 		pr_debug("EEH: Ignored check (%x) for %s %s\n",
-			 pdn->eeh_mode, eeh_pci_name(dev), dn->full_name);
+			edev->mode, eeh_pci_name(dev), dn->full_name);
 		return 0;
 	}
 
-	if (!pdn->eeh_config_addr && !pdn->eeh_pe_config_addr) {
+	if (!edev->config_addr && !edev->pe_config_addr) {
 		no_cfg_addr++;
 		return 0;
 	}
@@ -426,13 +426,13 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	 */
 	raw_spin_lock_irqsave(&confirm_error_lock, flags);
 	rc = 1;
-	if (pdn->eeh_mode & EEH_MODE_ISOLATED) {
-		pdn->eeh_check_count ++;
-		if (pdn->eeh_check_count % EEH_MAX_FAILS == 0) {
+	if (edev->mode & EEH_MODE_ISOLATED) {
+		edev->check_count++;
+		if (edev->check_count % EEH_MAX_FAILS == 0) {
 			location = of_get_property(dn, "ibm,loc-code", NULL);
 			printk(KERN_ERR "EEH: %d reads ignored for recovering device at "
 				"location=%s driver=%s pci addr=%s\n",
-				pdn->eeh_check_count, location,
+				edev->check_count, location,
 				eeh_driver_name(dev), eeh_pci_name(dev));
 			printk(KERN_ERR "EEH: Might be infinite loop in %s driver\n",
 				eeh_driver_name(dev));
@@ -448,7 +448,7 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	 * function zero of a multi-function device.
 	 * In any case they must share a common PHB.
 	 */
-	ret = eeh_ops->get_state(pdn->node, NULL);
+	ret = eeh_ops->get_state(dn, NULL);
 
 	/* Note that config-io to empty slots may fail;
 	 * they are empty when they don't have children.
@@ -461,7 +461,7 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	    (ret & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) ==
 	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) {
 		false_positives++;
-		pdn->eeh_false_positives ++;
+		edev->false_positives ++;
 		rc = 0;
 		goto dn_unlock;
 	}
@@ -475,7 +475,7 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	eeh_mark_slot(dn, EEH_MODE_ISOLATED);
 	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
 
-	eeh_send_failure_event(dn, dev);
+	eeh_send_failure_event(edev->dn, edev->pdev);
 
 	/* Most EEH events are due to device driver bugs.  Having
 	 * a stack trace will help the device-driver authors figure
@@ -529,22 +529,23 @@ EXPORT_SYMBOL(eeh_check_failure);
 
 /**
  * eeh_pci_enable - Enable MMIO or DMA transfers for this slot
- * @pdn pci device node
+ * @edev: pci device node
  *
  * This routine should be called to reenable frozen MMIO or DMA
  * so that it would work correctly again. It's useful while doing
  * recovery or log collection on the indicated device.
  */
-int eeh_pci_enable(struct pci_dn *pdn, int function)
+int eeh_pci_enable(struct eeh_dev *edev, int function)
 {
 	int rc;
+	struct device_node *dn = EEH_DEV_TO_OF_NODE(edev);
 
-	rc = eeh_ops->set_option(pdn->node, function);
+	rc = eeh_ops->set_option(dn, function);
 	if (rc)
 		printk(KERN_WARNING "EEH: Unexpected state change %d, err=%d dn=%s\n",
-		        function, rc, pdn->node->full_name);
+		        function, rc, dn->full_name);
 
-	rc = eeh_ops->wait_state(pdn->node, PCI_BUS_RESET_WAIT_MSEC);
+	rc = eeh_ops->wait_state(dn, PCI_BUS_RESET_WAIT_MSEC);
 	if (rc > 0 && (rc & EEH_STATE_MMIO_ENABLED) &&
 	   (function == EEH_OPT_THAW_MMIO))
 		return 0;
@@ -595,8 +596,8 @@ void __eeh_set_pe_freset(struct device_node *parent, unsigned int *freset)
 	struct device_node *dn;
 
 	for_each_child_of_node(parent, dn) {
-		if (PCI_DN(dn)) {
-			struct pci_dev *dev = PCI_DN(dn)->pcidev;
+		if (OF_NODE_TO_EEH_DEV(dn)) {
+			struct pci_dev *dev = OF_NODE_TO_EEH_DEV(dn)->pdev;
 
 			if (dev && dev->driver)
 				*freset |= dev->needs_freset;
@@ -622,10 +623,10 @@ void eeh_set_pe_freset(struct device_node *dn, unsigned int *freset)
 	dn = eeh_find_device_pe(dn);
 
 	/* Back up one, since config addrs might be shared */
-	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
+	if (!pcibios_find_pci_bus(dn) && OF_NODE_TO_EEH_DEV(dn->parent))
 		dn = dn->parent;
 
-	dev = PCI_DN(dn)->pcidev;
+	dev = OF_NODE_TO_EEH_DEV(dn)->pdev;
 	if (dev)
 		*freset |= dev->needs_freset;
 
@@ -634,13 +635,14 @@ void eeh_set_pe_freset(struct device_node *dn, unsigned int *freset)
 
 /**
  * eeh_reset_pe_once - Assert the pci #RST line for 1/4 second
- * @pdn: pci device node to be reset.
+ * @edev: pci device node to be reset.
  *
  * Assert the PCI #RST line for 1/4 second.
  */
-static void eeh_reset_pe_once(struct pci_dn *pdn)
+static void eeh_reset_pe_once(struct eeh_dev *edev)
 {
 	unsigned int freset = 0;
+	struct device_node *dn = EEH_DEV_TO_OF_NODE(edev);
 
 	/* Determine type of EEH reset required for
 	 * Partitionable Endpoint, a hot-reset (1)
@@ -648,12 +650,12 @@ static void eeh_reset_pe_once(struct pci_dn *pdn)
 	 * A fundamental reset required by any device under
 	 * Partitionable Endpoint trumps hot-reset.
   	 */
-	eeh_set_pe_freset(pdn->node, &freset);
+	eeh_set_pe_freset(dn, &freset);
 
 	if (freset)
-		eeh_ops->reset(pdn->node, EEH_RESET_FUNDAMENTAL);
+		eeh_ops->reset(dn, EEH_RESET_FUNDAMENTAL);
 	else
-		eeh_ops->reset(pdn->node, EEH_RESET_HOT);
+		eeh_ops->reset(dn, EEH_RESET_HOT);
 
 	/* The PCI bus requires that the reset be held high for at least
 	 * a 100 milliseconds. We wait a bit longer 'just in case'.
@@ -665,9 +667,9 @@ static void eeh_reset_pe_once(struct pci_dn *pdn)
 	 * pci slot reset line is dropped. Make sure we don't miss
 	 * these, and clear the flag now.
 	 */
-	eeh_clear_slot(pdn->node, EEH_MODE_ISOLATED);
+	eeh_clear_slot(dn, EEH_MODE_ISOLATED);
 
-	eeh_ops->reset(pdn->node, EEH_RESET_DEACTIVATE);
+	eeh_ops->reset(dn, EEH_RESET_DEACTIVATE);
 
 	/* After a PCI slot has been reset, the PCI Express spec requires
 	 * a 1.5 second idle time for the bus to stabilize, before starting
@@ -679,31 +681,32 @@ static void eeh_reset_pe_once(struct pci_dn *pdn)
 
 /**
  * eeh_reset_pe - Reset the indicated PE
- * @pdn: PCI device node
+ * @edev: PCI device associated EEH device
  *
  * This routine should be called to reset indicated device, including
  * PE. A PE might include multiple PCI devices and sometimes PCI bridges
  * might be involved as well.
  */
-int eeh_reset_pe(struct pci_dn *pdn)
+int eeh_reset_pe(struct eeh_dev *edev)
 {
 	int i, rc;
+	struct device_node *dn = EEH_DEV_TO_OF_NODE(edev);
 
 	/* Take three shots at resetting the bus */
 	for (i=0; i<3; i++) {
-		eeh_reset_pe_once(pdn);
+		eeh_reset_pe_once(edev);
 
-		rc = eeh_ops->wait_state(pdn->node, PCI_BUS_RESET_WAIT_MSEC);
+		rc = eeh_ops->wait_state(dn, PCI_BUS_RESET_WAIT_MSEC);
 		if (rc == (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
 			return 0;
 
 		if (rc < 0) {
 			printk(KERN_ERR "EEH: unrecoverable slot failure %s\n",
-			       pdn->node->full_name);
+			       dn->full_name);
 			return -1;
 		}
 		printk(KERN_ERR "EEH: bus reset %d failed on slot %s, rc=%d\n",
-		       i+1, pdn->node->full_name, rc);
+		       i+1, dn->full_name, rc);
 	}
 
 	return -1;
@@ -719,90 +722,95 @@ int eeh_reset_pe(struct pci_dn *pdn)
 
 /**
  * eeh_restore_one_device_bars - Restore the Base Address Registers for one device
- * @pdn: pci device node
+ * @edev: PCI device associated EEH device
  *
  * Loads the PCI configuration space base address registers,
  * the expansion ROM base address, the latency timer, and etc.
  * from the saved values in the device node.
  */
-static inline void eeh_restore_one_device_bars(struct pci_dn *pdn)
+static inline void eeh_restore_one_device_bars(struct eeh_dev *edev)
 {
 	int i;
 	u32 cmd;
+	struct device_node *dn = EEH_DEV_TO_OF_NODE(edev);
+
+	if (!edev->phb)
+		return;
 
-	if (NULL==pdn->phb) return;
 	for (i=4; i<10; i++) {
-		rtas_write_config(pdn, i*4, 4, pdn->config_space[i]);
+		rtas_write_config(PCI_DN(dn), i*4, 4, edev->config_space[i]);
 	}
 
 	/* 12 == Expansion ROM Address */
-	rtas_write_config(pdn, 12*4, 4, pdn->config_space[12]);
+	rtas_write_config(PCI_DN(dn), 12*4, 4, edev->config_space[12]);
 
 #define BYTE_SWAP(OFF) (8*((OFF)/4)+3-(OFF))
-#define SAVED_BYTE(OFF) (((u8 *)(pdn->config_space))[BYTE_SWAP(OFF)])
+#define SAVED_BYTE(OFF) (((u8 *)(edev->config_space))[BYTE_SWAP(OFF)])
 
-	rtas_write_config(pdn, PCI_CACHE_LINE_SIZE, 1,
+	rtas_write_config(PCI_DN(dn), PCI_CACHE_LINE_SIZE, 1,
 	            SAVED_BYTE(PCI_CACHE_LINE_SIZE));
 
-	rtas_write_config(pdn, PCI_LATENCY_TIMER, 1,
+	rtas_write_config(PCI_DN(dn), PCI_LATENCY_TIMER, 1,
 	            SAVED_BYTE(PCI_LATENCY_TIMER));
 
 	/* max latency, min grant, interrupt pin and line */
-	rtas_write_config(pdn, 15*4, 4, pdn->config_space[15]);
+	rtas_write_config(PCI_DN(dn), 15*4, 4, edev->config_space[15]);
 
 	/* Restore PERR & SERR bits, some devices require it,
 	 * don't touch the other command bits
 	 */
-	rtas_read_config(pdn, PCI_COMMAND, 4, &cmd);
-	if (pdn->config_space[1] & PCI_COMMAND_PARITY)
+	rtas_read_config(PCI_DN(dn), PCI_COMMAND, 4, &cmd);
+	if (edev->config_space[1] & PCI_COMMAND_PARITY)
 		cmd |= PCI_COMMAND_PARITY;
 	else
 		cmd &= ~PCI_COMMAND_PARITY;
-	if (pdn->config_space[1] & PCI_COMMAND_SERR)
+	if (edev->config_space[1] & PCI_COMMAND_SERR)
 		cmd |= PCI_COMMAND_SERR;
 	else
 		cmd &= ~PCI_COMMAND_SERR;
-	rtas_write_config(pdn, PCI_COMMAND, 4, cmd);
+	rtas_write_config(PCI_DN(dn), PCI_COMMAND, 4, cmd);
 }
 
 /**
  * eeh_restore_bars - Restore the PCI config space info
- * @pdn: PCI device node
+ * @edev: EEH device
  *
  * This routine performs a recursive walk to the children
  * of this device as well.
  */
-void eeh_restore_bars(struct pci_dn *pdn)
+void eeh_restore_bars(struct eeh_dev *edev)
 {
 	struct device_node *dn;
-	if (!pdn) 
+	if (!edev)
 		return;
 	
-	if ((pdn->eeh_mode & EEH_MODE_SUPPORTED) && !IS_BRIDGE(pdn->class_code))
-		eeh_restore_one_device_bars(pdn);
+	if ((edev->mode & EEH_MODE_SUPPORTED) && !IS_BRIDGE(edev->class_code))
+		eeh_restore_one_device_bars(edev);
 
-	for_each_child_of_node(pdn->node, dn)
-		eeh_restore_bars(PCI_DN(dn));
+	for_each_child_of_node(EEH_DEV_TO_OF_NODE(edev), dn)
+		eeh_restore_bars(OF_NODE_TO_EEH_DEV(dn));
 }
 
 /**
  * eeh_save_bars - Save device bars
- * @pdn: PCI device node
+ * @edev: PCI device associated EEH device
  *
  * Save the values of the device bars. Unlike the restore
  * routine, this routine is *not* recursive. This is because
  * PCI devices are added individually; but, for the restore,
  * an entire slot is reset at a time.
  */
-static void eeh_save_bars(struct pci_dn *pdn)
+static void eeh_save_bars(struct eeh_dev *edev)
 {
 	int i;
+	struct device_node *dn;
 
-	if (!pdn )
+	if (!edev)
 		return;
+	dn = EEH_DEV_TO_OF_NODE(edev);
 	
 	for (i = 0; i < 16; i++)
-		rtas_read_config(pdn, i * 4, 4, &pdn->config_space[i]);
+		rtas_read_config(PCI_DN(dn), i * 4, 4, &edev->config_space[i]);
 }
 
 /**
@@ -822,13 +830,13 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 	const u32 *device_id = of_get_property(dn, "device-id", NULL);
 	const u32 *regs;
 	int enable;
-	struct pci_dn *pdn = PCI_DN(dn);
+	struct eeh_dev *edev = OF_NODE_TO_EEH_DEV(dn);
 
-	pdn->class_code = 0;
-	pdn->eeh_mode = 0;
-	pdn->eeh_check_count = 0;
-	pdn->eeh_freeze_count = 0;
-	pdn->eeh_false_positives = 0;
+	edev->class_code = 0;
+	edev->mode = 0;
+	edev->check_count = 0;
+	edev->freeze_count = 0;
+	edev->false_positives = 0;
 
 	if (!of_device_is_available(dn))
 		return NULL;
@@ -839,10 +847,10 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 
 	/* There is nothing to check on PCI to ISA bridges */
 	if (dn->type && !strcmp(dn->type, "isa")) {
-		pdn->eeh_mode |= EEH_MODE_NOCHECK;
+		edev->mode |= EEH_MODE_NOCHECK;
 		return NULL;
 	}
-	pdn->class_code = *class_code;
+	edev->class_code = *class_code;
 
 	/* Ok... see if this device supports EEH.  Some do, some don't,
 	 * and the only way to find out is to check each and every one.
@@ -855,40 +863,40 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 
 		enable = 0;
 		if (ret == 0) {
-			pdn->eeh_config_addr = regs[0];
+			edev->config_addr = regs[0];
 
 			/* If the newer, better, ibm,get-config-addr-info is supported, 
 			 * then use that instead.
 			 */
-			pdn->eeh_pe_config_addr = eeh_ops->get_pe_addr(dn);
+			edev->pe_config_addr = eeh_ops->get_pe_addr(dn);
 
 			/* Some older systems (Power4) allow the
 			 * ibm,set-eeh-option call to succeed even on nodes
 			 * where EEH is not supported. Verify support
 			 * explicitly.
 			 */
-			ret = eeh_ops->get_state(pdn->node, NULL);
+			ret = eeh_ops->get_state(dn, NULL);
 			if (ret > 0 && ret != EEH_STATE_NOT_SUPPORT)
 				enable = 1;
 		}
 
 		if (enable) {
 			eeh_subsystem_enabled = 1;
-			pdn->eeh_mode |= EEH_MODE_SUPPORTED;
+			edev->mode |= EEH_MODE_SUPPORTED;
 
 			pr_debug("EEH: %s: eeh enabled, config=%x pe_config=%x\n",
-				 dn->full_name, pdn->eeh_config_addr,
-				 pdn->eeh_pe_config_addr);
+				 dn->full_name, edev->config_addr,
+				 edev->pe_config_addr);
 		} else {
 
 			/* This device doesn't support EEH, but it may have an
 			 * EEH parent, in which case we mark it as supported.
 			 */
-			if (dn->parent && PCI_DN(dn->parent)
-			    && (PCI_DN(dn->parent)->eeh_mode & EEH_MODE_SUPPORTED)) {
+			if (dn->parent && OF_NODE_TO_EEH_DEV(dn->parent) &&
+			    (OF_NODE_TO_EEH_DEV(dn->parent)->mode & EEH_MODE_SUPPORTED)) {
 				/* Parent supports EEH. */
-				pdn->eeh_mode |= EEH_MODE_SUPPORTED;
-				pdn->eeh_config_addr = PCI_DN(dn->parent)->eeh_config_addr;
+				edev->mode |= EEH_MODE_SUPPORTED;
+				edev->config_addr = OF_NODE_TO_EEH_DEV(dn->parent)->config_addr;
 				return NULL;
 			}
 		}
@@ -897,7 +905,7 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 		       dn->full_name);
 	}
 
-	eeh_save_bars(pdn);
+	eeh_save_bars(edev);
 	return NULL;
 }
 
@@ -994,7 +1002,7 @@ void __init eeh_init(void)
 		unsigned long buid;
 
 		buid = get_phb_buid(phb);
-		if (buid == 0 || PCI_DN(phb) == NULL)
+		if (buid == 0 || !OF_NODE_TO_EEH_DEV(phb))
 			continue;
 
 		traverse_pci_devices(phb, eeh_early_enable, NULL);
@@ -1022,9 +1030,9 @@ static void eeh_add_device_early(struct device_node *dn)
 {
 	struct pci_controller *phb;
 
-	if (!dn || !PCI_DN(dn))
+	if (!dn || !OF_NODE_TO_EEH_DEV(dn))
 		return;
-	phb = PCI_DN(dn)->phb;
+	phb = OF_NODE_TO_EEH_DEV(dn)->phb;
 
 	/* USB Bus children of PCI devices will not have BUID's */
 	if (NULL == phb || 0 == phb->buid)
@@ -1061,7 +1069,7 @@ EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
 static void eeh_add_device_late(struct pci_dev *dev)
 {
 	struct device_node *dn;
-	struct pci_dn *pdn;
+	struct eeh_dev *edev;
 
 	if (!dev || !eeh_subsystem_enabled)
 		return;
@@ -1069,15 +1077,16 @@ static void eeh_add_device_late(struct pci_dev *dev)
 	pr_debug("EEH: Adding device %s\n", pci_name(dev));
 
 	dn = pci_device_to_OF_node(dev);
-	pdn = PCI_DN(dn);
-	if (pdn->pcidev == dev) {
+	edev = PCI_DEV_TO_EEH_DEV(dev);
+	if (edev->pdev == dev) {
 		pr_debug("EEH: Already referenced !\n");
 		return;
 	}
-	WARN_ON(pdn->pcidev);
+	WARN_ON(edev->pdev);
 
 	pci_dev_get(dev);
-	pdn->pcidev = dev;
+	edev->pdev = dev;
+	dev->dev.archdata.edev = edev;
 
 	pci_addr_cache_insert_device(dev);
 	eeh_sysfs_add_device(dev);
@@ -1118,19 +1127,21 @@ EXPORT_SYMBOL_GPL(eeh_add_device_tree_late);
  */
 static void eeh_remove_device(struct pci_dev *dev)
 {
-	struct device_node *dn;
+	struct eeh_dev *edev;
+
 	if (!dev || !eeh_subsystem_enabled)
 		return;
+	edev = PCI_DEV_TO_EEH_DEV(dev);
 
 	/* Unregister the device with the EEH/PCI address search system */
 	pr_debug("EEH: Removing device %s\n", pci_name(dev));
 
-	dn = pci_device_to_OF_node(dev);
-	if (PCI_DN(dn)->pcidev == NULL) {
+	if (!edev || !edev->pdev) {
 		pr_debug("EEH: Not referenced !\n");
 		return;
 	}
-	PCI_DN(dn)->pcidev = NULL;
+	edev->pdev = NULL;
+	dev->dev.archdata.edev = NULL;
 	pci_dev_put(dev);
 
 	pci_addr_cache_remove_device(dev);
-- 
1.7.5.4
