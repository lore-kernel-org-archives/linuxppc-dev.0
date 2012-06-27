Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DFBA0B6EF3
 for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2012 03:28:39 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 27 Jun 2012 11:28:35 -0600
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
 [9.17.195.107])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C03B03E417BB
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 16:02:17 +0000 (WET)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5RG27aR130150
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:10 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5RG26E3022026
 for <linuxppc-dev@ozlabs.org>; Wed, 27 Jun 2012 10:02:06 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/21] ppc/eeh: eeh options based on PE
Date: Thu, 28 Jun 2012 00:01:43 +0800
Message-Id: <1340812911-6793-14-git-send-email-shangw@linux.vnet.ibm.com>
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

Originally, all the EEH options were implemented based on OF node.
Actually, it explicitly breaks the rules that the operation target
is PE instead of device. Therefore, the patch makes all the operations
based on PE instead of device.

Unfortunately, the backend for config space has to be kept as original
because it doesn't depend on PE actually.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |   14 +--
 arch/powerpc/platforms/pseries/eeh.c         |   13 ++-
 arch/powerpc/platforms/pseries/eeh_pseries.c |  133 +++++++++++---------------
 3 files changed, 74 insertions(+), 86 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 493dc7c..96451b7 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -136,13 +136,13 @@ static inline struct pci_dev *eeh_dev_to_pci_dev(struct eeh_dev *edev)
 struct eeh_ops {
 	char *name;
 	int (*init)(void);
-	int (*set_option)(struct device_node *dn, int option);
-	int (*get_pe_addr)(struct device_node *dn);
-	int (*get_state)(struct device_node *dn, int *state);
-	int (*reset)(struct device_node *dn, int option);
-	int (*wait_state)(struct device_node *dn, int max_wait);
-	int (*get_log)(struct device_node *dn, int severity, char *drv_log, unsigned long len);
-	int (*configure_bridge)(struct device_node *dn);
+	int (*set_option)(struct eeh_pe *pe, int option);
+	int (*get_pe_addr)(struct eeh_pe *pe);
+	int (*get_state)(struct eeh_pe *pe, int *state);
+	int (*reset)(struct eeh_pe *pe, int option);
+	int (*wait_state)(struct eeh_pe *pe, int max_wait);
+	int (*get_log)(struct eeh_pe *pe, int severity, char *drv_log, unsigned long len);
+	int (*configure_bridge)(struct eeh_pe *pe);
 	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
 	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
 };
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 341ba1a..636413f 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -729,6 +729,7 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 	const u32 *regs;
 	int enable;
 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	struct eeh_pe pe;
 
 	edev->class_code = 0;
 	edev->mode = 0;
@@ -755,9 +756,14 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 	 */
 	regs = of_get_property(dn, "reg", NULL);
 	if (regs) {
+		/* Initialize the fake PE */
+		memset(&pe, 0, sizeof(struct eeh_pe));
+		pe.phb = edev->phb;
+		pe.config_addr = regs[0];
+
 		/* First register entry is addr (00BBSS00)  */
 		/* Try to enable eeh */
-		ret = eeh_ops->set_option(dn, EEH_OPT_ENABLE);
+		ret = eeh_ops->set_option(&pe, EEH_OPT_ENABLE);
 
 		enable = 0;
 		if (ret == 0) {
@@ -766,14 +772,15 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 			/* If the newer, better, ibm,get-config-addr-info is supported, 
 			 * then use that instead.
 			 */
-			edev->pe_config_addr = eeh_ops->get_pe_addr(dn);
+			edev->pe_config_addr = eeh_ops->get_pe_addr(&pe);
+			pe.addr = edev->pe_config_addr;
 
 			/* Some older systems (Power4) allow the
 			 * ibm,set-eeh-option call to succeed even on nodes
 			 * where EEH is not supported. Verify support
 			 * explicitly.
 			 */
-			ret = eeh_ops->get_state(dn, NULL);
+			ret = eeh_ops->get_state(&pe, NULL);
 			if (ret > 0 && ret != EEH_STATE_NOT_SUPPORT)
 				enable = 1;
 		}
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index bb2bd90..6760e70 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -134,22 +134,18 @@ static int pseries_eeh_init(void)
 
 /**
  * pseries_eeh_set_option - Initialize EEH or MMIO/DMA reenable
- * @dn: device node
+ * @pe: EEH PE
  * @option: operation to be issued
  *
  * The function is used to control the EEH functionality globally.
  * Currently, following options are support according to PAPR:
  * Enable EEH, Disable EEH, Enable MMIO and Enable DMA
  */
-static int pseries_eeh_set_option(struct device_node *dn, int option)
+static int pseries_eeh_set_option(struct eeh_pe *pe, int option)
 {
 	int ret = 0;
-	struct eeh_dev *edev;
-	const u32 *reg;
 	int config_addr;
 
-	edev = of_node_to_eeh_dev(dn);
-
 	/*
 	 * When we're enabling or disabling EEH functioality on
 	 * the particular PE, the PE config address is possibly
@@ -159,15 +155,11 @@ static int pseries_eeh_set_option(struct device_node *dn, int option)
 	switch (option) {
 	case EEH_OPT_DISABLE:
 	case EEH_OPT_ENABLE:
-		reg = of_get_property(dn, "reg", NULL);
-		config_addr = reg[0];
-		break;
-
 	case EEH_OPT_THAW_MMIO:
 	case EEH_OPT_THAW_DMA:
-		config_addr = edev->config_addr;
-		if (edev->pe_config_addr)
-			config_addr = edev->pe_config_addr;
+		config_addr = pe->config_addr;
+		if (pe->addr)
+			config_addr = pe->addr;
 		break;
 
 	default:
@@ -177,15 +169,15 @@ static int pseries_eeh_set_option(struct device_node *dn, int option)
 	}
 
 	ret = rtas_call(ibm_set_eeh_option, 4, 1, NULL,
-			config_addr, BUID_HI(edev->phb->buid),
-			BUID_LO(edev->phb->buid), option);
+			config_addr, BUID_HI(pe->phb->buid),
+			BUID_LO(pe->phb->buid), option);
 
 	return ret;
 }
 
 /**
  * pseries_eeh_get_pe_addr - Retrieve PE address
- * @dn: device node
+ * @pe: EEH PE
  *
  * Retrieve the assocated PE address. Actually, there're 2 RTAS
  * function calls dedicated for the purpose. We need implement
@@ -196,14 +188,11 @@ static int pseries_eeh_set_option(struct device_node *dn, int option)
  * It's notable that zero'ed return value means invalid PE config
  * address.
  */
-static int pseries_eeh_get_pe_addr(struct device_node *dn)
+static int pseries_eeh_get_pe_addr(struct eeh_pe *pe)
 {
-	struct eeh_dev *edev;
 	int ret = 0;
 	int rets[3];
 
-	edev = of_node_to_eeh_dev(dn);
-
 	if (ibm_get_config_addr_info2 != RTAS_UNKNOWN_SERVICE) {
 		/*
 		 * First of all, we need to make sure there has one PE
@@ -211,18 +200,18 @@ static int pseries_eeh_get_pe_addr(struct device_node *dn)
 		 * meaningless.
 		 */
 		ret = rtas_call(ibm_get_config_addr_info2, 4, 2, rets,
-				edev->config_addr, BUID_HI(edev->phb->buid),
-				BUID_LO(edev->phb->buid), 1);
+				pe->config_addr, BUID_HI(pe->phb->buid),
+				BUID_LO(pe->phb->buid), 1);
 		if (ret || (rets[0] == 0))
 			return 0;
 
 		/* Retrieve the associated PE config address */
 		ret = rtas_call(ibm_get_config_addr_info2, 4, 2, rets,
-				edev->config_addr, BUID_HI(edev->phb->buid),
-				BUID_LO(edev->phb->buid), 0);
+				pe->config_addr, BUID_HI(pe->phb->buid),
+				BUID_LO(pe->phb->buid), 0);
 		if (ret) {
-			pr_warning("%s: Failed to get PE address for %s\n",
-				__func__, dn->full_name);
+			pr_warning("%s: Failed to get address for PHB#%d-PE#%x\n",
+				__func__, pe->phb->global_number, pe->config_addr);
 			return 0;
 		}
 
@@ -231,11 +220,11 @@ static int pseries_eeh_get_pe_addr(struct device_node *dn)
 
 	if (ibm_get_config_addr_info != RTAS_UNKNOWN_SERVICE) {
 		ret = rtas_call(ibm_get_config_addr_info, 4, 2, rets,
-				edev->config_addr, BUID_HI(edev->phb->buid),
-				BUID_LO(edev->phb->buid), 0);
+				pe->config_addr, BUID_HI(pe->phb->buid),
+				BUID_LO(pe->phb->buid), 0);
 		if (ret) {
-			pr_warning("%s: Failed to get PE address for %s\n",
-				__func__, dn->full_name);
+			pr_warning("%s: Failed to get address for PHB#%d-PE#%x\n",
+				__func__, pe->phb->global_number, pe->config_addr);
 			return 0;
 		}
 
@@ -247,7 +236,7 @@ static int pseries_eeh_get_pe_addr(struct device_node *dn)
 
 /**
  * pseries_eeh_get_state - Retrieve PE state
- * @dn: PE associated device node
+ * @pe: EEH PE
  * @state: return value
  *
  * Retrieve the state of the specified PE. On RTAS compliant
@@ -258,30 +247,28 @@ static int pseries_eeh_get_pe_addr(struct device_node *dn)
  * RTAS calls for the purpose, we need to try the new one and back
  * to the old one if the new one couldn't work properly.
  */
-static int pseries_eeh_get_state(struct device_node *dn, int *state)
+static int pseries_eeh_get_state(struct eeh_pe *pe, int *state)
 {
-	struct eeh_dev *edev;
 	int config_addr;
 	int ret;
 	int rets[4];
 	int result;
 
 	/* Figure out PE config address if possible */
-	edev = of_node_to_eeh_dev(dn);
-	config_addr = edev->config_addr;
-	if (edev->pe_config_addr)
-		config_addr = edev->pe_config_addr;
+	config_addr = pe->config_addr;
+	if (pe->addr)
+		config_addr = pe->addr;
 
 	if (ibm_read_slot_reset_state2 != RTAS_UNKNOWN_SERVICE) {
 		ret = rtas_call(ibm_read_slot_reset_state2, 3, 4, rets,
-				config_addr, BUID_HI(edev->phb->buid),
-				BUID_LO(edev->phb->buid));
+				config_addr, BUID_HI(pe->phb->buid),
+				BUID_LO(pe->phb->buid));
 	} else if (ibm_read_slot_reset_state != RTAS_UNKNOWN_SERVICE) {
 		/* Fake PE unavailable info */
 		rets[2] = 0;
 		ret = rtas_call(ibm_read_slot_reset_state, 3, 3, rets,
-				config_addr, BUID_HI(edev->phb->buid),
-				BUID_LO(edev->phb->buid));
+				config_addr, BUID_HI(pe->phb->buid),
+				BUID_LO(pe->phb->buid));
 	} else {
 		return EEH_STATE_NOT_SUPPORT;
 	}
@@ -333,34 +320,32 @@ static int pseries_eeh_get_state(struct device_node *dn, int *state)
 
 /**
  * pseries_eeh_reset - Reset the specified PE
- * @dn: PE associated device node
+ * @pe: EEH PE
  * @option: reset option
  *
  * Reset the specified PE
  */
-static int pseries_eeh_reset(struct device_node *dn, int option)
+static int pseries_eeh_reset(struct eeh_pe *pe, int option)
 {
-	struct eeh_dev *edev;
 	int config_addr;
 	int ret;
 
 	/* Figure out PE address */
-	edev = of_node_to_eeh_dev(dn);
-	config_addr = edev->config_addr;
-	if (edev->pe_config_addr)
-		config_addr = edev->pe_config_addr;
+	config_addr = pe->config_addr;
+	if (pe->addr)
+		config_addr = pe->addr;
 
 	/* Reset PE through RTAS call */
 	ret = rtas_call(ibm_set_slot_reset, 4, 1, NULL,
-			config_addr, BUID_HI(edev->phb->buid),
-			BUID_LO(edev->phb->buid), option);
+			config_addr, BUID_HI(pe->phb->buid),
+			BUID_LO(pe->phb->buid), option);
 
 	/* If fundamental-reset not supported, try hot-reset */
 	if (option == EEH_RESET_FUNDAMENTAL &&
 	    ret == -8) {
 		ret = rtas_call(ibm_set_slot_reset, 4, 1, NULL,
-				config_addr, BUID_HI(edev->phb->buid),
-				BUID_LO(edev->phb->buid), EEH_RESET_HOT);
+				config_addr, BUID_HI(pe->phb->buid),
+				BUID_LO(pe->phb->buid), EEH_RESET_HOT);
 	}
 
 	return ret;
@@ -368,13 +353,13 @@ static int pseries_eeh_reset(struct device_node *dn, int option)
 
 /**
  * pseries_eeh_wait_state - Wait for PE state
- * @dn: PE associated device node
+ * @pe: EEH PE
  * @max_wait: maximal period in microsecond
  *
  * Wait for the state of associated PE. It might take some time
  * to retrieve the PE's state.
  */
-static int pseries_eeh_wait_state(struct device_node *dn, int max_wait)
+static int pseries_eeh_wait_state(struct eeh_pe *pe, int max_wait)
 {
 	int ret;
 	int mwait;
@@ -391,7 +376,7 @@ static int pseries_eeh_wait_state(struct device_node *dn, int max_wait)
 #define EEH_STATE_MAX_WAIT_TIME	(300 * 1000)
 
 	while (1) {
-		ret = pseries_eeh_get_state(dn, &mwait);
+		ret = pseries_eeh_get_state(pe, &mwait);
 
 		/*
 		 * If the PE's state is temporarily unavailable,
@@ -426,7 +411,7 @@ static int pseries_eeh_wait_state(struct device_node *dn, int max_wait)
 
 /**
  * pseries_eeh_get_log - Retrieve error log
- * @dn: device node
+ * @pe: EEH PE
  * @severity: temporary or permanent error log
  * @drv_log: driver log to be combined with retrieved error log
  * @len: length of driver log
@@ -435,24 +420,22 @@ static int pseries_eeh_wait_state(struct device_node *dn, int max_wait)
  * Actually, the error will be retrieved through the dedicated
  * RTAS call.
  */
-static int pseries_eeh_get_log(struct device_node *dn, int severity, char *drv_log, unsigned long len)
+static int pseries_eeh_get_log(struct eeh_pe *pe, int severity, char *drv_log, unsigned long len)
 {
-	struct eeh_dev *edev;
 	int config_addr;
 	unsigned long flags;
 	int ret;
 
-	edev = of_node_to_eeh_dev(dn);
 	spin_lock_irqsave(&slot_errbuf_lock, flags);
 	memset(slot_errbuf, 0, eeh_error_buf_size);
 
 	/* Figure out the PE address */
-	config_addr = edev->config_addr;
-	if (edev->pe_config_addr)
-		config_addr = edev->pe_config_addr;
+	config_addr = pe->config_addr;
+	if (pe->addr)
+		config_addr = pe->addr;
 
 	ret = rtas_call(ibm_slot_error_detail, 8, 1, NULL, config_addr,
-			BUID_HI(edev->phb->buid), BUID_LO(edev->phb->buid),
+			BUID_HI(pe->phb->buid), BUID_LO(pe->phb->buid),
 			virt_to_phys(drv_log), len,
 			virt_to_phys(slot_errbuf), eeh_error_buf_size,
 			severity);
@@ -465,40 +448,38 @@ static int pseries_eeh_get_log(struct device_node *dn, int severity, char *drv_l
 
 /**
  * pseries_eeh_configure_bridge - Configure PCI bridges in the indicated PE
- * @dn: PE associated device node
+ * @pe: EEH PE
  *
  * The function will be called to reconfigure the bridges included
  * in the specified PE so that the mulfunctional PE would be recovered
  * again.
  */
-static int pseries_eeh_configure_bridge(struct device_node *dn)
+static int pseries_eeh_configure_bridge(struct eeh_pe *pe)
 {
-	struct eeh_dev *edev;
 	int config_addr;
 	int ret;
 
 	/* Figure out the PE address */
-	edev = of_node_to_eeh_dev(dn);
-	config_addr = edev->config_addr;
-	if (edev->pe_config_addr)
-		config_addr = edev->pe_config_addr;
+	config_addr = pe->config_addr;
+	if (pe->addr)
+		config_addr = pe->addr;
 
 	/* Use new configure-pe function, if supported */
 	if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE) {
 		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
-				config_addr, BUID_HI(edev->phb->buid),
-				BUID_LO(edev->phb->buid));
+				config_addr, BUID_HI(pe->phb->buid),
+				BUID_LO(pe->phb->buid));
 	} else if (ibm_configure_bridge != RTAS_UNKNOWN_SERVICE) {
 		ret = rtas_call(ibm_configure_bridge, 3, 1, NULL,
-				config_addr, BUID_HI(edev->phb->buid),
-				BUID_LO(edev->phb->buid));
+				config_addr, BUID_HI(pe->phb->buid),
+				BUID_LO(pe->phb->buid));
 	} else {
 		return -EFAULT;
 	}
 
 	if (ret)
-		pr_warning("%s: Unable to configure bridge %d for %s\n",
-			__func__, ret, dn->full_name);
+		pr_warning("%s: Unable to configure bridge PHB#%d-PE#%x (%d)\n",
+			__func__, pe->phb->global_number, pe->addr, ret);
 
 	return ret;
 }
-- 
1.7.9.5
