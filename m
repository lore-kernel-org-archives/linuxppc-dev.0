Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A82D7B6FC8
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:29 +1100 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 15:08:26 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1O9cNIJ4161576
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 15:08:23 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1O9cNTs030726
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:23 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/21] pSeries platform EEH error log retrieval
Date: Fri, 24 Feb 2012 17:38:07 +0800
Message-Id: <1330076298-7006-11-git-send-email-shangw@linux.vnet.ibm.com>
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

On RTAS compliant pSeries platform, one dedicated RTAS call has
been introduced to retrieve EEH temporary or permanent error log.

The patch implements the function of retriving EEH error log through
RTAS call. Besides, it has been abstracted by struct eeh_ops::get_log
so that EEH core components could support multiple platforms in future.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    2 +
 arch/powerpc/include/asm/ppc-pci.h           |    2 -
 arch/powerpc/platforms/pseries/eeh.c         |   63 +-------------------------
 arch/powerpc/platforms/pseries/eeh_driver.c  |    4 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |   47 +++++++++++++++++++-
 5 files changed, 51 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 894ea6c..ad8f318 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -52,6 +52,8 @@ struct device_node;
 #define EEH_RESET_DEACTIVATE	0	/* Deactivate the PE reset	*/
 #define EEH_RESET_HOT		1	/* Hot reset			*/
 #define EEH_RESET_FUNDAMENTAL	3	/* Fundamental reset		*/
+#define EEH_LOG_TEMP		1	/* EEH temporary error log	*/
+#define EEH_LOG_PERM		2	/* EEH permanent error log	*/
 
 struct eeh_ops {
 	char *name;
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 1cfb2b0..bd1a84f 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -53,8 +53,6 @@ void pci_addr_cache_insert_device(struct pci_dev *dev);
 void pci_addr_cache_remove_device(struct pci_dev *dev);
 void pci_addr_cache_build(void);
 struct pci_dev *pci_get_device_by_addr(unsigned long addr);
-#define EEH_LOG_TEMP_FAILURE 1
-#define EEH_LOG_PERM_FAILURE 2
 void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
 int eeh_pci_enable(struct pci_dn *pdn, int function);
 int eeh_reset_pe(struct pci_dn *);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 4f329f5..39fcecb 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -87,7 +87,6 @@
 #define PCI_BUS_RESET_WAIT_MSEC (60*1000)
 
 /* RTAS tokens */
-static int ibm_slot_error_detail;
 static int ibm_configure_bridge;
 static int ibm_configure_pe;
 
@@ -100,14 +99,6 @@ EXPORT_SYMBOL(eeh_subsystem_enabled);
 /* Lock to avoid races due to multiple reports of an error */
 static DEFINE_RAW_SPINLOCK(confirm_error_lock);
 
-/* Buffer for reporting slot-error-detail rtas calls. Its here
- * in BSS, and not dynamically alloced, so that it ends up in
- * RMO where RTAS can access it.
- */
-static unsigned char slot_errbuf[RTAS_ERROR_LOG_MAX];
-static DEFINE_SPINLOCK(slot_errbuf_lock);
-static int eeh_error_buf_size;
-
 /* Buffer for reporting pci register dumps. Its here in BSS, and
  * not dynamically alloced, so that it ends up in RMO where RTAS
  * can access it.
@@ -127,46 +118,6 @@ static unsigned long slot_resets;
 #define IS_BRIDGE(class_code) (((class_code)<<16) == PCI_BASE_CLASS_BRIDGE)
 
 /**
- * eeh_rtas_slot_error_detail - Retrieve error log through RTAS call
- * @pdn: device node
- * @severity: temporary or permanent error log
- * @driver_log: driver log to be combined with the retrieved error log
- * @loglen: length of driver log
- *
- * This routine should be called to retrieve error log through the dedicated
- * RTAS call.
- */
-static void eeh_rtas_slot_error_detail(struct pci_dn *pdn, int severity,
-                                   char *driver_log, size_t loglen)
-{
-	int config_addr;
-	unsigned long flags;
-	int rc;
-
-	/* Log the error with the rtas logger */
-	spin_lock_irqsave(&slot_errbuf_lock, flags);
-	memset(slot_errbuf, 0, eeh_error_buf_size);
-
-	/* Use PE configuration address, if present */
-	config_addr = pdn->eeh_config_addr;
-	if (pdn->eeh_pe_config_addr)
-		config_addr = pdn->eeh_pe_config_addr;
-
-	rc = rtas_call(ibm_slot_error_detail,
-	               8, 1, NULL, config_addr,
-	               BUID_HI(pdn->phb->buid),
-	               BUID_LO(pdn->phb->buid),
-	               virt_to_phys(driver_log), loglen,
-	               virt_to_phys(slot_errbuf),
-	               eeh_error_buf_size,
-	               severity);
-
-	if (rc == 0)
-		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
-	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
-}
-
-/**
  * eeh_gather_pci_data - Copy assorted PCI config space registers to buff
  * @pdn: device to report data for
  * @buf: point to buffer in which to log
@@ -282,7 +233,7 @@ void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
 	eeh_restore_bars(pdn);
 	loglen = eeh_gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
 
-	eeh_rtas_slot_error_detail(pdn, severity, pci_regs_buf, loglen);
+	eeh_ops->get_log(pdn->node, severity, pci_regs_buf, loglen);
 }
 
 /**
@@ -1071,26 +1022,14 @@ void __init eeh_init(void)
 	}
 
 	raw_spin_lock_init(&confirm_error_lock);
-	spin_lock_init(&slot_errbuf_lock);
 
 	np = of_find_node_by_path("/rtas");
 	if (np == NULL)
 		return;
 
-	ibm_slot_error_detail = rtas_token("ibm,slot-error-detail");
 	ibm_configure_bridge = rtas_token("ibm,configure-bridge");
 	ibm_configure_pe = rtas_token("ibm,configure-pe");
 
-	eeh_error_buf_size = rtas_token("rtas-error-log-max");
-	if (eeh_error_buf_size == RTAS_UNKNOWN_SERVICE) {
-		eeh_error_buf_size = 1024;
-	}
-	if (eeh_error_buf_size > RTAS_ERROR_LOG_MAX) {
-		printk(KERN_WARNING "EEH: rtas-error-log-max is bigger than allocated "
-		      "buffer ! (%d vs %d)", eeh_error_buf_size, RTAS_ERROR_LOG_MAX);
-		eeh_error_buf_size = RTAS_ERROR_LOG_MAX;
-	}
-
 	/* Enable EEH for all adapters.  Note that eeh requires buid's */
 	for (phb = of_find_node_by_name(NULL, "pci"); phb;
 	     phb = of_find_node_by_name(phb, "pci")) {
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 584defe..6840357 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -406,7 +406,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 	 * don't post the error log until after all dev drivers
 	 * have been informed.
 	 */
-	eeh_slot_error_detail(frozen_pdn, EEH_LOG_TEMP_FAILURE);
+	eeh_slot_error_detail(frozen_pdn, EEH_LOG_TEMP);
 
 	/* If all device drivers were EEH-unaware, then shut
 	 * down all of the device drivers, and hope they
@@ -497,7 +497,7 @@ hard_fail:
 		location, drv_str, pci_str);
 
 perm_error:
-	eeh_slot_error_detail(frozen_pdn, EEH_LOG_PERM_FAILURE);
+	eeh_slot_error_detail(frozen_pdn, EEH_LOG_PERM);
 
 	/* Notify all devices that they're about to go down. */
 	pci_walk_bus(frozen_bus, eeh_report_failure, NULL);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 6643e06..7c8434f 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -56,6 +56,15 @@ static int ibm_get_config_addr_info2;
 static int ibm_configure_bridge;
 static int ibm_configure_pe;
 
+/*
+ * Buffer for reporting slot-error-detail rtas calls. Its here
+ * in BSS, and not dynamically alloced, so that it ends up in
+ * RMO where RTAS can access it.
+ */
+static unsigned char slot_errbuf[RTAS_ERROR_LOG_MAX];
+static DEFINE_SPINLOCK(slot_errbuf_lock);
+static int eeh_error_buf_size;
+
 /**
  * pseries_eeh_init - EEH platform dependent initialization
  *
@@ -107,6 +116,19 @@ static int pseries_eeh_init(void)
 		return -EINVAL;
 	}
 
+	/* Initialize error log lock and size */
+	spin_lock_init(&slot_errbuf_lock);
+	eeh_error_buf_size = rtas_token("rtas-error-log-max");
+	if (eeh_error_buf_size == RTAS_UNKNOWN_SERVICE) {
+		pr_warning("%s: unknown EEH error log size\n",
+			__func__);
+		eeh_error_buf_size = 1024;
+	} else if (eeh_error_buf_size > RTAS_ERROR_LOG_MAX) {
+		pr_warning("%s: EEH error log size %d exceeds the maximal %d\n",
+			__func__, eeh_error_buf_size, RTAS_ERROR_LOG_MAX);
+		eeh_error_buf_size = RTAS_ERROR_LOG_MAX;
+	}
+
 	return 0;
 }
 
@@ -415,7 +437,30 @@ static int pseries_eeh_wait_state(struct device_node *dn, int max_wait)
  */
 static int pseries_eeh_get_log(struct device_node *dn, int severity, char *drv_log, unsigned long len)
 {
-	return 0;
+	struct pci_dn *pdn;
+	int config_addr;
+	unsigned long flags;
+	int ret;
+
+	pdn = PCI_DN(dn);
+	spin_lock_irqsave(&slot_errbuf_lock, flags);
+	memset(slot_errbuf, 0, eeh_error_buf_size);
+
+	/* Figure out the PE address */
+	config_addr = pdn->eeh_config_addr;
+	if (pdn->eeh_pe_config_addr)
+		config_addr = pdn->eeh_pe_config_addr;
+
+	ret = rtas_call(ibm_slot_error_detail, 8, 1, NULL, config_addr,
+			BUID_HI(pdn->phb->buid), BUID_LO(pdn->phb->buid),
+			virt_to_phys(drv_log), len,
+			virt_to_phys(slot_errbuf), eeh_error_buf_size,
+			severity);
+	if (!ret)
+		log_error(slot_errbuf, ERR_TYPE_RTAS_LOG, 0);
+	spin_unlock_irqrestore(&slot_errbuf_lock, flags);
+
+	return ret;
 }
 
 /**
-- 
1.7.5.4
