Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 55F78B6FCB
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:32 +1100 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 15:08:25 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1O9cL1g3436714
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 15:08:22 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1O9cL8G026202
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 15:08:21 +0530
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/21] Cleanup on function names of EEH core
Date: Fri, 24 Feb 2012 17:37:59 +0800
Message-Id: <1330076298-7006-3-git-send-email-shangw@linux.vnet.ibm.com>
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

The EEH has been implemented on pSeries platform. The original
code looks a little bit nasty. The patch does cleanup on the
current EEH implementation so that it looks more clean.

        * Try adding prefix "eeh" for functions.
        * Some function names have been adjusted so that they looks
          shorter and meaningful.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/ppc-pci.h          |    8 +-
 arch/powerpc/platforms/pseries/eeh.c        |  102 +++++++++++++--------------
 arch/powerpc/platforms/pseries/eeh_driver.c |   10 ++--
 arch/powerpc/platforms/pseries/msi.c        |    2 +-
 4 files changed, 59 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 221d82f..605a970 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -58,16 +58,16 @@ struct pci_dev *pci_get_device_by_addr(unsigned long addr);
 void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
 #define EEH_THAW_MMIO 2
 #define EEH_THAW_DMA  3
-int rtas_pci_enable(struct pci_dn *pdn, int function);
-int rtas_set_slot_reset (struct pci_dn *);
+int eeh_pci_enable(struct pci_dn *pdn, int function);
+int eeh_reset_pe(struct pci_dn *);
 int eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs);
 void eeh_restore_bars(struct pci_dn *);
-void rtas_configure_bridge(struct pci_dn *);
+void eeh_configure_bridge(struct pci_dn *);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 void eeh_mark_slot(struct device_node *dn, int mode_flag);
 void eeh_clear_slot(struct device_node *dn, int mode_flag);
-struct device_node *find_device_pe(struct device_node *dn);
+struct device_node *eeh_find_device_pe(struct device_node *dn);
 
 void eeh_sysfs_add_device(struct pci_dev *pdev);
 void eeh_sysfs_remove_device(struct pci_dev *pdev);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 5f6d37b..fa88589 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -130,7 +130,7 @@ static unsigned long slot_resets;
 #define IS_BRIDGE(class_code) (((class_code)<<16) == PCI_BASE_CLASS_BRIDGE)
 
 /**
- * rtas_slot_error_detail - Retrieve error log through RTAS call
+ * eeh_rtas_slot_error_detail - Retrieve error log through RTAS call
  * @pdn: device node
  * @severity: temporary or permanent error log
  * @driver_log: driver log to be combined with the retrieved error log
@@ -139,7 +139,7 @@ static unsigned long slot_resets;
  * This routine should be called to retrieve error log through the dedicated
  * RTAS call.
  */
-static void rtas_slot_error_detail(struct pci_dn *pdn, int severity,
+static void eeh_rtas_slot_error_detail(struct pci_dn *pdn, int severity,
                                    char *driver_log, size_t loglen)
 {
 	int config_addr;
@@ -170,7 +170,7 @@ static void rtas_slot_error_detail(struct pci_dn *pdn, int severity,
 }
 
 /**
- * gather_pci_data - Copy assorted PCI config space registers to buff
+ * eeh_gather_pci_data - Copy assorted PCI config space registers to buff
  * @pdn: device to report data for
  * @buf: point to buffer in which to log
  * @len: amount of room in buffer
@@ -178,7 +178,7 @@ static void rtas_slot_error_detail(struct pci_dn *pdn, int severity,
  * This routine captures assorted PCI configuration space data,
  * and puts them into a buffer for RTAS error logging.
  */
-static size_t gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
+static size_t eeh_gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 {
 	struct pci_dev *dev = pdn->pcidev;
 	u32 cfg;
@@ -258,7 +258,7 @@ static size_t gather_pci_data(struct pci_dn *pdn, char * buf, size_t len)
 		for_each_child_of_node(pdn->node, dn) {
 			pdn = PCI_DN(dn);
 			if (pdn)
-				n += gather_pci_data(pdn, buf+n, len-n);
+				n += eeh_gather_pci_data(pdn, buf+n, len-n);
 		}
 	}
 
@@ -280,23 +280,23 @@ void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
 	size_t loglen = 0;
 	pci_regs_buf[0] = 0;
 
-	rtas_pci_enable(pdn, EEH_THAW_MMIO);
-	rtas_configure_bridge(pdn);
+	eeh_pci_enable(pdn, EEH_THAW_MMIO);
+	eeh_configure_bridge(pdn);
 	eeh_restore_bars(pdn);
-	loglen = gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
+	loglen = eeh_gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
 
-	rtas_slot_error_detail(pdn, severity, pci_regs_buf, loglen);
+	eeh_rtas_slot_error_detail(pdn, severity, pci_regs_buf, loglen);
 }
 
 /**
- * read_slot_reset_state - Read the reset state of a device node's slot
+ * eeh_read_slot_reset_state - Read the reset state of a device node's slot
  * @dn: device node to read
  * @rets: array to return results in
  *
  * Read the reset state of a device node's slot through platform dependent
  * function call.
  */
-static int read_slot_reset_state(struct pci_dn *pdn, int rets[])
+static int eeh_read_slot_reset_state(struct pci_dn *pdn, int rets[])
 {
 	int token, outputs;
 	int config_addr;
@@ -332,15 +332,14 @@ static int read_slot_reset_state(struct pci_dn *pdn, int rets[])
  * the max allowed wait time is exceeded, in which case
  * a -2 is returned.
  */
-int
-eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs)
+int eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs)
 {
 	int rc;
 	int rets[3];
 	int mwait;
 
 	while (1) {
-		rc = read_slot_reset_state(pdn, rets);
+		rc = eeh_read_slot_reset_state(pdn, rets);
 		if (rc) return rc;
 		if (rets[1] == 0) return -1;  /* EEH is not supported */
 
@@ -389,12 +388,12 @@ static inline unsigned long eeh_token_to_phys(unsigned long token)
 }
 
 /**
- * find_device_pe - Retrieve the PE for the given device
+ * eeh_find_device_pe - Retrieve the PE for the given device
  * @dn: device node
  *
  * Return the PE under which this device lies
  */
-struct device_node * find_device_pe(struct device_node *dn)
+struct device_node *eeh_find_device_pe(struct device_node *dn)
 {
 	while ((dn->parent) && PCI_DN(dn->parent) &&
 	      (PCI_DN(dn->parent)->eeh_mode & EEH_MODE_SUPPORTED)) {
@@ -445,7 +444,7 @@ static void __eeh_mark_slot(struct device_node *parent, int mode_flag)
 void eeh_mark_slot(struct device_node *dn, int mode_flag)
 {
 	struct pci_dev *dev;
-	dn = find_device_pe(dn);
+	dn = eeh_find_device_pe(dn);
 
 	/* Back up one, since config addrs might be shared */
 	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
@@ -493,7 +492,7 @@ void eeh_clear_slot(struct device_node *dn, int mode_flag)
 	unsigned long flags;
 	raw_spin_lock_irqsave(&confirm_error_lock, flags);
 	
-	dn = find_device_pe(dn);
+	dn = eeh_find_device_pe(dn);
 	
 	/* Back up one, since config addrs might be shared */
 	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
@@ -538,7 +537,7 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 		no_dn++;
 		return 0;
 	}
-	dn = find_device_pe(dn);
+	dn = eeh_find_device_pe(dn);
 	pdn = PCI_DN(dn);
 
 	/* Access to IO BARs might get this far and still not want checking. */
@@ -585,11 +584,11 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	 * function zero of a multi-function device.
 	 * In any case they must share a common PHB.
 	 */
-	ret = read_slot_reset_state(pdn, rets);
+	ret = eeh_read_slot_reset_state(pdn, rets);
 
 	/* If the call to firmware failed, punt */
 	if (ret != 0) {
-		printk(KERN_WARNING "EEH: read_slot_reset_state() failed; rc=%d dn=%s\n",
+		printk(KERN_WARNING "EEH: eeh_read_slot_reset_state() failed; rc=%d dn=%s\n",
 		       ret, dn->full_name);
 		false_positives++;
 		pdn->eeh_false_positives ++;
@@ -687,15 +686,14 @@ EXPORT_SYMBOL(eeh_check_failure);
 
 
 /**
- * rtas_pci_enable - Enable MMIO or DMA transfers for this slot
+ * eeh_pci_enable - Enable MMIO or DMA transfers for this slot
  * @pdn pci device node
  *
  * This routine should be called to reenable frozen MMIO or DMA
  * so that it would work correctly again. It's useful while doing
  * recovery or log collection on the indicated device.
  */
-int
-rtas_pci_enable(struct pci_dn *pdn, int function)
+int eeh_pci_enable(struct pci_dn *pdn, int function)
 {
 	int config_addr;
 	int rc;
@@ -723,7 +721,7 @@ rtas_pci_enable(struct pci_dn *pdn, int function)
 }
 
 /**
- * rtas_pci_slot_reset - Raises/Lowers the pci #RST line
+ * eeh_slot_reset - Raises/Lowers the pci #RST line
  * @pdn: pci device node
  * @state: 1/0 to raise/lower the #RST
  *
@@ -732,8 +730,7 @@ rtas_pci_enable(struct pci_dn *pdn, int function)
  * and drops the #RST line if 'state is '0'.  This routine is
  * safe to call in an interrupt context.
  */
-static void
-rtas_pci_slot_reset(struct pci_dn *pdn, int state)
+static void eeh_slot_reset(struct pci_dn *pdn, int state)
 {
 	int config_addr;
 	int rc;
@@ -786,13 +783,13 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 
 	switch (state) {
 	case pcie_deassert_reset:
-		rtas_pci_slot_reset(pdn, 0);
+		eeh_slot_reset(pdn, 0);
 		break;
 	case pcie_hot_reset:
-		rtas_pci_slot_reset(pdn, 1);
+		eeh_slot_reset(pdn, 1);
 		break;
 	case pcie_warm_reset:
-		rtas_pci_slot_reset(pdn, 3);
+		eeh_slot_reset(pdn, 3);
 		break;
 	default:
 		return -EINVAL;
@@ -839,7 +836,7 @@ void __eeh_set_pe_freset(struct device_node *parent, unsigned int *freset)
 void eeh_set_pe_freset(struct device_node *dn, unsigned int *freset)
 {
 	struct pci_dev *dev;
-	dn = find_device_pe(dn);
+	dn = eeh_find_device_pe(dn);
 
 	/* Back up one, since config addrs might be shared */
 	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
@@ -853,12 +850,12 @@ void eeh_set_pe_freset(struct device_node *dn, unsigned int *freset)
 }
 
 /**
- * __rtas_set_slot_reset - Assert the pci #RST line for 1/4 second
+ * eeh_reset_pe_once - Assert the pci #RST line for 1/4 second
  * @pdn: pci device node to be reset.
  *
  * Assert the PCI #RST line for 1/4 second.
  */
-static void __rtas_set_slot_reset(struct pci_dn *pdn)
+static void eeh_reset_pe_once(struct pci_dn *pdn)
 {
 	unsigned int freset = 0;
 
@@ -871,9 +868,9 @@ static void __rtas_set_slot_reset(struct pci_dn *pdn)
 	eeh_set_pe_freset(pdn->node, &freset);
 
 	if (freset)
-		rtas_pci_slot_reset(pdn, 3);
+		eeh_slot_reset(pdn, 3);
 	else
-		rtas_pci_slot_reset(pdn, 1);
+		eeh_slot_reset(pdn, 1);
 
 	/* The PCI bus requires that the reset be held high for at least
 	 * a 100 milliseconds. We wait a bit longer 'just in case'.
@@ -887,7 +884,7 @@ static void __rtas_set_slot_reset(struct pci_dn *pdn)
 	 */
 	eeh_clear_slot(pdn->node, EEH_MODE_ISOLATED);
 
-	rtas_pci_slot_reset(pdn, 0);
+	eeh_slot_reset(pdn, 0);
 
 	/* After a PCI slot has been reset, the PCI Express spec requires
 	 * a 1.5 second idle time for the bus to stabilize, before starting
@@ -898,20 +895,20 @@ static void __rtas_set_slot_reset(struct pci_dn *pdn)
 }
 
 /**
- * rtas_set_slot_reset - Reset the indicated PE
+ * eeh_reset_pe - Reset the indicated PE
  * @pdn: PCI device node
  *
  * This routine should be called to reset indicated device, including
  * PE. A PE might include multiple PCI devices and sometimes PCI bridges
  * might be involved as well.
  */
-int rtas_set_slot_reset(struct pci_dn *pdn)
+int eeh_reset_pe(struct pci_dn *pdn)
 {
 	int i, rc;
 
 	/* Take three shots at resetting the bus */
 	for (i=0; i<3; i++) {
-		__rtas_set_slot_reset(pdn);
+		eeh_reset_pe_once(pdn);
 
 		rc = eeh_wait_for_slot_status(pdn, PCI_BUS_RESET_WAIT_MSEC);
 		if (rc == 0)
@@ -938,14 +935,14 @@ int rtas_set_slot_reset(struct pci_dn *pdn)
  */
 
 /**
- * __restore_bars - Restore the Base Address Registers
+ * eeh_restore_one_device_bars - Restore the Base Address Registers for one device
  * @pdn: pci device node
  *
  * Loads the PCI configuration space base address registers,
  * the expansion ROM base address, the latency timer, and etc.
  * from the saved values in the device node.
  */
-static inline void __restore_bars(struct pci_dn *pdn)
+static inline void eeh_restore_one_device_bars(struct pci_dn *pdn)
 {
 	int i;
 	u32 cmd;
@@ -999,7 +996,7 @@ void eeh_restore_bars(struct pci_dn *pdn)
 		return;
 	
 	if ((pdn->eeh_mode & EEH_MODE_SUPPORTED) && !IS_BRIDGE(pdn->class_code))
-		__restore_bars(pdn);
+		eeh_restore_one_device_bars(pdn);
 
 	for_each_child_of_node(pdn->node, dn)
 		eeh_restore_bars(PCI_DN(dn));
@@ -1026,15 +1023,14 @@ static void eeh_save_bars(struct pci_dn *pdn)
 }
 
 /**
- * rtas_configure_bridge - Configure PCI bridges for the indicated PE
+ * eeh_configure_bridge - Configure PCI bridges for the indicated PE
  * @pdn: PCI device node
  *
  * PCI bridges might be included in PE. In order to make the PE work
  * again. The included PCI bridges should be recovered after the PE
  * encounters frozen state.
  */
-void
-rtas_configure_bridge(struct pci_dn *pdn)
+void eeh_configure_bridge(struct pci_dn *pdn)
 {
 	int config_addr;
 	int rc;
@@ -1069,7 +1065,7 @@ struct eeh_early_enable_info {
 };
 
 /**
- * get_pe_addr - Retrieve PE address with given BDF address
+ * eeh_get_pe_addr - Retrieve PE address with given BDF address
  * @config_addr: BDF address
  * @info: BUID of the associated PHB
  *
@@ -1079,7 +1075,7 @@ struct eeh_early_enable_info {
  * the given BDF address. Further more, we prefer PE address on BDF
  * address in EEH core components.
  */
-static int get_pe_addr(int config_addr,
+static int eeh_get_pe_addr(int config_addr,
                         struct eeh_early_enable_info *info)
 {
 	unsigned int rets[3];
@@ -1112,7 +1108,7 @@ static int get_pe_addr(int config_addr,
 }
 
 /**
- * early_enable_eeh - Early enable EEH on the indicated device
+ * eeh_early_enable - Early enable EEH on the indicated device
  * @dn: device node
  * @data: BUID
  *
@@ -1120,7 +1116,7 @@ static int get_pe_addr(int config_addr,
  * is expected to be called before real PCI probing is done. However,
  * the PHBs have been initialized at this point.
  */
-static void *early_enable_eeh(struct device_node *dn, void *data)
+static void *eeh_early_enable(struct device_node *dn, void *data)
 {
 	unsigned int rets[3];
 	struct eeh_early_enable_info *info = data;
@@ -1170,14 +1166,14 @@ static void *early_enable_eeh(struct device_node *dn, void *data)
 			/* If the newer, better, ibm,get-config-addr-info is supported, 
 			 * then use that instead.
 			 */
-			pdn->eeh_pe_config_addr = get_pe_addr(pdn->eeh_config_addr, info);
+			pdn->eeh_pe_config_addr = eeh_get_pe_addr(pdn->eeh_config_addr, info);
 
 			/* Some older systems (Power4) allow the
 			 * ibm,set-eeh-option call to succeed even on nodes
 			 * where EEH is not supported. Verify support
 			 * explicitly.
 			 */
-			ret = read_slot_reset_state(pdn, rets);
+			ret = eeh_read_slot_reset_state(pdn, rets);
 			if ((ret == 0) && (rets[1] == 1))
 				enable = 1;
 		}
@@ -1272,7 +1268,7 @@ void __init eeh_init(void)
 
 		info.buid_lo = BUID_LO(buid);
 		info.buid_hi = BUID_HI(buid);
-		traverse_pci_devices(phb, early_enable_eeh, &info);
+		traverse_pci_devices(phb, eeh_early_enable, &info);
 	}
 
 	if (eeh_subsystem_enabled)
@@ -1308,7 +1304,7 @@ static void eeh_add_device_early(struct device_node *dn)
 
 	info.buid_hi = BUID_HI(phb->buid);
 	info.buid_lo = BUID_LO(phb->buid);
-	early_enable_eeh(dn, &info);
+	eeh_early_enable(dn, &info);
 }
 
 /**
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 1b6cb10..5315350 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -282,7 +282,7 @@ static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
 	/* Reset the pci controller. (Asserts RST#; resets config space).
 	 * Reconfigure bridges and devices. Don't try to bring the system
 	 * up if the reset failed for some reason. */
-	rc = rtas_set_slot_reset(pe_dn);
+	rc = eeh_reset_pe(pe_dn);
 	if (rc)
 		return rc;
 
@@ -295,7 +295,7 @@ static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
 		struct pci_dn *ppe = PCI_DN(dn);
 		/* On Power4, always true because eeh_pe_config_addr=0 */
 		if (pe_dn->eeh_pe_config_addr == ppe->eeh_pe_config_addr) {
-			rtas_configure_bridge(ppe);
+			eeh_configure_bridge(ppe);
 			eeh_restore_bars(ppe);
  		}
 		dn = dn->sibling;
@@ -330,7 +330,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 	enum pci_ers_result result = PCI_ERS_RESULT_NONE;
 	const char *location, *pci_str, *drv_str, *bus_pci_str, *bus_drv_str;
 
-	frozen_dn = find_device_pe(event->dn);
+	frozen_dn = eeh_find_device_pe(event->dn);
 	if (!frozen_dn) {
 
 		location = of_get_property(event->dn, "ibm,loc-code", NULL);
@@ -422,7 +422,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 
 	/* If all devices reported they can proceed, then re-enable MMIO */
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
-		rc = rtas_pci_enable(frozen_pdn, EEH_THAW_MMIO);
+		rc = eeh_pci_enable(frozen_pdn, EEH_THAW_MMIO);
 
 		if (rc < 0)
 			goto hard_fail;
@@ -436,7 +436,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 
 	/* If all devices reported they can proceed, then re-enable DMA */
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
-		rc = rtas_pci_enable(frozen_pdn, EEH_THAW_DMA);
+		rc = eeh_pci_enable(frozen_pdn, EEH_THAW_DMA);
 
 		if (rc < 0)
 			goto hard_fail;
diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
index 38d24e7..109fdb7 100644
--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -217,7 +217,7 @@ static struct device_node *find_pe_dn(struct pci_dev *dev, int *total)
 	if (!dn)
 		return NULL;
 
-	dn = find_device_pe(dn);
+	dn = eeh_find_device_pe(dn);
 	if (!dn)
 		return NULL;
 
-- 
1.7.5.4
