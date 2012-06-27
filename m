Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A029B7098
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 02:05:09 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 12:05:06 -0400
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id EC22B38C82E7
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:25 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG2P7Y159074
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 12:02:25 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG2DRk011359
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 13:02:15 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 20/21] ppc/eeh: probe mode support
Date: Thu, 28 Jun 2012 00:01:50 +0800
Message-Id: <1340812911-6793-21-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340812911-6793-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While EEH module is installed, PCI devices is checked one by one
to see if it supports eeh. That is done based on OF nodes or
PCI device referred by "struct pci_dev". In order to distinguish
the case, global variable "eeh_probe_mode" is introduced.

The patch implements the support to eeh probe mode. Also, the
EEH on pseries has set it into EEH_PROBE_MODE_FDT. That means
the probe will be done based on OF nodes on pSeries platform.

In addition, On pSeries platform, it's done by OF nodes. The patch
moves the the probe function to platform dependent backend and do
some cleanup.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |   21 +++++
 arch/powerpc/include/asm/ppc-pci.h           |    1 +
 arch/powerpc/platforms/pseries/eeh.c         |  131 +++++---------------------
 arch/powerpc/platforms/pseries/eeh_pseries.c |   96 +++++++++++++++++++
 4 files changed, 140 insertions(+), 109 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index b7ac3f7..91c38b7 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -129,6 +129,8 @@ static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
 struct eeh_ops {
 	char *name;
 	int (*init)(void);
+	void* (*of_probe)(struct device_node *dn, void *flag);
+	void* (*dev_probe)(struct pci_dev *dev, void *flag);
 	int (*set_option)(struct eeh_pe *pe, int option);
 	int (*get_pe_addr)(struct eeh_pe *pe);
 	int (*get_state)(struct eeh_pe *pe, int *state);
@@ -143,6 +145,25 @@ struct eeh_ops {
 extern struct eeh_ops *eeh_ops;
 extern int eeh_subsystem_enabled;
 extern struct mutex eeh_mutex;
+extern int eeh_probe_mode;
+
+#define EEH_PROBE_MODE_DEV	(1<<0)	/* From PCI device	*/
+#define EEH_PROBE_MODE_FDT	(1<<1)	/* From FDT		*/
+
+static inline void eeh_probe_mode_set(int flag)
+{
+	eeh_probe_mode = flag;
+}
+
+static inline int eeh_probe_mode_fdt(void)
+{
+	return (eeh_probe_mode == EEH_PROBE_MODE_FDT);
+}
+
+static inline int eeh_probe_mode_dev(void)
+{
+	return (eeh_probe_mode == EEH_PROBE_MODE_DEV);
+}
 
 static inline void eeh_lock(void)
 {
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 2a80f08..56d55c7 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -54,6 +54,7 @@ struct pci_dev *pci_addr_cache_get_device(unsigned long addr);
 void eeh_slot_error_detail(struct eeh_pe *pe, int severity);
 int eeh_pci_enable(struct eeh_pe *pe, int function);
 int eeh_reset_pe(struct eeh_pe *);
+void eeh_save_bars(struct eeh_dev *edev);
 int rtas_write_config(struct pci_dn *, int where, int size, u32 val);
 int rtas_read_config(struct pci_dn *, int where, int size, u32 *val);
 void eeh_pe_state_mark(struct eeh_pe *pe, int state);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 1438c4e..b2caf84 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -92,6 +92,17 @@ struct eeh_ops *eeh_ops = NULL;
 int eeh_subsystem_enabled;
 EXPORT_SYMBOL(eeh_subsystem_enabled);
 
+/*
+ * EEH probe mode support. The intention is to support multiple
+ * platforms for EEH. Some platforms like pSeries do PCI emunation
+ * based on FDT (Flat Device Tree). However, other platforms like
+ * powernv probe PCI devices from hardware. The flag is used to
+ * distinguish that. In addition, struct eeh_ops::probe would be
+ * invoked for particular OF node or PCI device so that the
+ * corresponding PE would be created there.
+ */
+int eeh_probe_mode;
+
 /* Global EEH mutex */
 DEFINE_MUTEX(eeh_mutex);
 
@@ -590,7 +601,7 @@ int eeh_reset_pe(struct eeh_pe *pe)
  * PCI devices are added individually; but, for the restore,
  * an entire slot is reset at a time.
  */
-static void eeh_save_bars(struct eeh_dev *edev)
+void eeh_save_bars(struct eeh_dev *edev)
 {
 	int i;
 	struct device_node *dn;
@@ -604,108 +615,6 @@ static void eeh_save_bars(struct eeh_dev *edev)
 }
 
 /**
- * eeh_early_enable - Early enable EEH on the indicated device
- * @dn: device node
- * @data: BUID
- *
- * Enable EEH functionality on the specified PCI device. The function
- * is expected to be called before real PCI probing is done. However,
- * the PHBs have been initialized at this point.
- */
-static void *eeh_early_enable(struct device_node *dn, void *data)
-{
-	int ret;
-	const u32 *class_code = of_get_property(dn, "class-code", NULL);
-	const u32 *vendor_id = of_get_property(dn, "vendor-id", NULL);
-	const u32 *device_id = of_get_property(dn, "device-id", NULL);
-	const u32 *regs;
-	int enable;
-	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
-	struct eeh_pe pe;
-
-	edev->class_code = 0;
-	edev->mode = 0;
-
-	if (!of_device_is_available(dn))
-		return NULL;
-
-	/* Ignore bad nodes. */
-	if (!class_code || !vendor_id || !device_id)
-		return NULL;
-
-	/* There is nothing to check on PCI to ISA bridges */
-	if (dn->type && !strcmp(dn->type, "isa"))
-		return NULL;
-	edev->class_code = *class_code;
-
-	/* Ok... see if this device supports EEH.  Some do, some don't,
-	 * and the only way to find out is to check each and every one.
-	 */
-	regs = of_get_property(dn, "reg", NULL);
-	if (regs) {
-		/* Initialize the fake PE */
-		memset(&pe, 0, sizeof(struct eeh_pe));
-		pe.phb = edev->phb;
-		pe.config_addr = regs[0];
-
-		/* First register entry is addr (00BBSS00)  */
-		/* Try to enable eeh */
-		ret = eeh_ops->set_option(&pe, EEH_OPT_ENABLE);
-
-		enable = 0;
-		if (ret == 0) {
-			edev->config_addr = regs[0];
-
-			/* If the newer, better, ibm,get-config-addr-info is supported, 
-			 * then use that instead.
-			 */
-			edev->pe_config_addr = eeh_ops->get_pe_addr(&pe);
-			pe.addr = edev->pe_config_addr;
-
-			/* Some older systems (Power4) allow the
-			 * ibm,set-eeh-option call to succeed even on nodes
-			 * where EEH is not supported. Verify support
-			 * explicitly.
-			 */
-			ret = eeh_ops->get_state(&pe, NULL);
-			if (ret > 0 && ret != EEH_STATE_NOT_SUPPORT)
-				enable = 1;
-		}
-
-		if (enable) {
-			eeh_subsystem_enabled = 1;
-
-			eeh_pe_create(edev);
-
-			pr_debug("EEH: %s: eeh enabled, config=%x pe_config=%x\n",
-				 dn->full_name, edev->config_addr,
-				 edev->pe_config_addr);
-		} else {
-
-			/* This device doesn't support EEH, but it may have an
-			 * EEH parent, in which case we mark it as supported.
-			 */
-			if (dn->parent && of_node_to_eeh_dev(dn->parent) &&
-			    of_node_to_eeh_dev(dn->parent)->pe) {
-				/* Parent supports EEH. */
-				edev->config_addr = of_node_to_eeh_dev(dn->parent)->config_addr;
-				edev->pe_config_addr = of_node_to_eeh_dev(dn->parent)->pe_config_addr;
-
-				eeh_pe_create(edev);
-
-				return NULL;
-			}
-		}
-	} else {
-		printk(KERN_WARNING "EEH: %s: unable to get reg property.\n",
-		       dn->full_name);
-	}
-
-	eeh_save_bars(edev);
-	return NULL;
-}
-
-/**
  * eeh_ops_register - Register platform dependent EEH operations
  * @ops: platform dependent EEH operations
  *
@@ -790,15 +699,18 @@ static int __init eeh_init(void)
 	raw_spin_lock_init(&confirm_error_lock);
 
 	/* Enable EEH for all adapters */
-	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		phb = hose->dn;
-		traverse_pci_devices(phb, eeh_early_enable, NULL);
+	if (eeh_probe_mode_fdt()) {
+		list_for_each_entry_safe(hose, tmp,
+			&hose_list, list_node) {
+			phb = hose->dn;
+			traverse_pci_devices(phb, eeh_ops->of_probe, NULL);
+		}
 	}
 
 	if (eeh_subsystem_enabled)
-		printk(KERN_INFO "EEH: PCI Enhanced I/O Error Handling Enabled\n");
+		pr_info("EEH: PCI Enhanced I/O Error Handling Enabled\n");
 	else
-		printk(KERN_WARNING "EEH: No capable adapters found\n");
+		pr_warning("EEH: No capable adapters found\n");
 
 	return ret;
 }
@@ -829,7 +741,8 @@ static void eeh_add_device_early(struct device_node *dn)
 	if (NULL == phb || 0 == phb->buid)
 		return;
 
-	eeh_early_enable(dn, NULL);
+	/* FIXME: hotplug support on POWERNV */
+	eeh_ops->of_probe(dn, NULL);
 }
 
 /**
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 6760e70..faeb26a 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -129,10 +129,104 @@ static int pseries_eeh_init(void)
 		eeh_error_buf_size = RTAS_ERROR_LOG_MAX;
 	}
 
+	/* Set EEH probe mode */
+	eeh_probe_mode_set(EEH_PROBE_MODE_FDT);
+
 	return 0;
 }
 
 /**
+ * pseries_eeh_of_probe - EEH probe on the given device
+ * @dn: OF node
+ * @flag: Unused
+ *
+ * When EEH module is installed during system boot, all PCI devices
+ * are checked one by one to see if it supports EEH. The function
+ * is introduced for the purpose.
+ */
+static void *pseries_eeh_of_probe(struct device_node *dn, void *flag)
+{
+	struct eeh_dev *edev;
+	struct eeh_pe pe;
+	const u32 *class_code, *vendor_id, *device_id;
+	const u32 *regs;
+	int enable = 0;
+	int ret;
+
+	/* Retrieve OF node and eeh device */
+	edev = of_node_to_eeh_dev(dn);
+	if (!of_device_is_available(dn))
+		return NULL;
+
+	/* Retrieve class/vendor/device IDs */
+	class_code = of_get_property(dn, "class-code", NULL);
+	vendor_id  = of_get_property(dn, "vendor-id", NULL);
+	device_id  = of_get_property(dn, "device-id", NULL);
+
+	/* Skip for bad OF node or PCI-ISA bridge */
+	if (!class_code || !vendor_id || !device_id)
+		return NULL;
+	if (dn->type && !strcmp(dn->type, "isa"))
+		return NULL;
+
+	/* Update class code and mode of eeh device */
+	edev->class_code = *class_code;
+	edev->mode = 0;
+
+	/* Retrieve the device address */
+	regs = of_get_property(dn, "reg", NULL);
+	if (!regs) {
+		pr_warning("%s: OF node property %s::reg not found\n",
+			__func__, dn->full_name);
+		return NULL;
+	}
+
+	/* Initialize the fake PE */
+	memset(&pe, 0, sizeof(struct eeh_pe));
+	pe.phb = edev->phb;
+	pe.config_addr = regs[0];
+
+	/* Enable EEH on the device */
+	ret = eeh_ops->set_option(&pe, EEH_OPT_ENABLE);
+	if (!ret) {
+		edev->config_addr = regs[0];
+		/* Retrieve PE address */
+		edev->pe_config_addr = eeh_ops->get_pe_addr(&pe);
+		pe.addr = edev->pe_config_addr;
+
+		/* Some older systems (Power4) allow the ibm,set-eeh-option
+		 * call to succeed even on nodes where EEH is not supported.
+		 * Verify support explicitly.
+		 */
+		ret = eeh_ops->get_state(&pe, NULL);
+		if (ret > 0 && ret != EEH_STATE_NOT_SUPPORT)
+			enable = 1;
+
+		if (enable) {
+			eeh_subsystem_enabled = 1;
+			eeh_pe_create(edev);
+
+			pr_debug("%s: EEH enabled on %s PHB#%d-PE#%x, config addr#%x\n",
+				__func__, dn->full_name, pe.phb->global_number,
+				pe.addr, pe.config_addr);
+		} else if (dn->parent && of_node_to_eeh_dev(dn->parent) &&
+			   (of_node_to_eeh_dev(dn->parent))->pe) {
+			/* This device doesn't support EEH, but it may have an
+			 * EEH parent, in which case we mark it as supported.
+			 */
+			edev->config_addr = of_node_to_eeh_dev(dn->parent)->config_addr;
+			edev->pe_config_addr = of_node_to_eeh_dev(dn->parent)->pe_config_addr;
+			eeh_pe_create(edev);
+		}
+	}
+
+	/* Save memory bars */
+	eeh_save_bars(edev);
+
+	return NULL;
+}
+
+/**
  * pseries_eeh_set_option - Initialize EEH or MMIO/DMA reenable
  * @pe: EEH PE
  * @option: operation to be issued
@@ -523,6 +617,8 @@ static int pseries_eeh_write_config(struct device_node *dn, int where, int size,
 static struct eeh_ops pseries_eeh_ops = {
 	.name			= "pseries",
 	.init			= pseries_eeh_init,
+	.of_probe		= pseries_eeh_of_probe,
+	.dev_probe		= NULL,
 	.set_option		= pseries_eeh_set_option,
 	.get_pe_addr		= pseries_eeh_get_pe_addr,
 	.get_state		= pseries_eeh_get_state,
-- 
1.7.9.5
