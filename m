Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A257B6FFB
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:33 +1100 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 06:00:39 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S64KR51093860
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:20 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S64JgQ018987
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:19 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/21] pSeries platform EEH operation
Date: Tue, 28 Feb 2012 14:03:55 +0800
Message-Id: <1330409051-8941-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1330409051-8941-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There're 4 EEH operations that are covered by the dedicated RTAS
call <ibm,set-eeh-option>: enable or disable EEH, enable MMIO and
enable DMA. At early stage of system boot, the EEH would be tried
to enable on PCI device related device node. MMIO and DMA for
particular PE should be enabled when doing recovery on EEH errors
so that the PE could function properly again.

The patch implements it and abstract that through struct
eeh_ops::set_eeh. It would be help for EEH to support multiple
platforms in future.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    4 ++
 arch/powerpc/include/asm/ppc-pci.h           |    2 -
 arch/powerpc/platforms/pseries/eeh.c         |   26 ++--------------
 arch/powerpc/platforms/pseries/eeh_driver.c  |    4 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |   39 +++++++++++++++++++++++++-
 5 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 0666c52..76f7b3f 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -38,6 +38,10 @@ struct device_node;
  * platform should register its own EEH operation callback
  * functions before any EEH further operations.
  */
+#define EEH_OPT_DISABLE		0	/* EEH disable	*/
+#define EEH_OPT_ENABLE		1	/* EEH enable	*/
+#define EEH_OPT_THAW_MMIO	2	/* MMIO enable	*/
+#define EEH_OPT_THAW_DMA	3	/* DMA enable	*/
 struct eeh_ops {
 	char *name;
 	int (*init)(void);
diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
index 605a970..6150349 100644
--- a/arch/powerpc/include/asm/ppc-pci.h
+++ b/arch/powerpc/include/asm/ppc-pci.h
@@ -56,8 +56,6 @@ struct pci_dev *pci_get_device_by_addr(unsigned long addr);
 #define EEH_LOG_TEMP_FAILURE 1
 #define EEH_LOG_PERM_FAILURE 2
 void eeh_slot_error_detail (struct pci_dn *pdn, int severity);
-#define EEH_THAW_MMIO 2
-#define EEH_THAW_DMA  3
 int eeh_pci_enable(struct pci_dn *pdn, int function);
 int eeh_reset_pe(struct pci_dn *);
 int eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index bb6de6c..70a9617 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -87,7 +87,6 @@
 #define PCI_BUS_RESET_WAIT_MSEC (60*1000)
 
 /* RTAS tokens */
-static int ibm_set_eeh_option;
 static int ibm_set_slot_reset;
 static int ibm_read_slot_reset_state;
 static int ibm_read_slot_reset_state2;
@@ -283,7 +282,7 @@ void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
 	size_t loglen = 0;
 	pci_regs_buf[0] = 0;
 
-	eeh_pci_enable(pdn, EEH_THAW_MMIO);
+	eeh_pci_enable(pdn, EEH_OPT_THAW_MMIO);
 	eeh_configure_bridge(pdn);
 	eeh_restore_bars(pdn);
 	loglen = eeh_gather_pci_data(pdn, pci_regs_buf, EEH_PCI_REGS_LOG_LEN);
@@ -698,26 +697,15 @@ EXPORT_SYMBOL(eeh_check_failure);
  */
 int eeh_pci_enable(struct pci_dn *pdn, int function)
 {
-	int config_addr;
 	int rc;
 
-	/* Use PE configuration address, if present */
-	config_addr = pdn->eeh_config_addr;
-	if (pdn->eeh_pe_config_addr)
-		config_addr = pdn->eeh_pe_config_addr;
-
-	rc = rtas_call(ibm_set_eeh_option, 4, 1, NULL,
-	               config_addr,
-	               BUID_HI(pdn->phb->buid),
-	               BUID_LO(pdn->phb->buid),
-		            function);
-
+	rc = eeh_ops->set_option(pdn->node, function);
 	if (rc)
 		printk(KERN_WARNING "EEH: Unexpected state change %d, err=%d dn=%s\n",
 		        function, rc, pdn->node->full_name);
 
 	rc = eeh_wait_for_slot_status(pdn, PCI_BUS_RESET_WAIT_MSEC);
-	if ((rc == 4) && (function == EEH_THAW_MMIO))
+	if ((rc == 4) && (function == EEH_OPT_THAW_MMIO))
 		return 0;
 
 	return rc;
@@ -1158,9 +1146,7 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 	if (regs) {
 		/* First register entry is addr (00BBSS00)  */
 		/* Try to enable eeh */
-		ret = rtas_call(ibm_set_eeh_option, 4, 1, NULL,
-		                regs[0], info->buid_hi, info->buid_lo,
-		                EEH_ENABLE);
+		ret = eeh_ops->set_option(dn, EEH_OPT_ENABLE);
 
 		enable = 0;
 		if (ret == 0) {
@@ -1299,7 +1285,6 @@ void __init eeh_init(void)
 	if (np == NULL)
 		return;
 
-	ibm_set_eeh_option = rtas_token("ibm,set-eeh-option");
 	ibm_set_slot_reset = rtas_token("ibm,set-slot-reset");
 	ibm_read_slot_reset_state2 = rtas_token("ibm,read-slot-reset-state2");
 	ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
@@ -1309,9 +1294,6 @@ void __init eeh_init(void)
 	ibm_configure_bridge = rtas_token("ibm,configure-bridge");
 	ibm_configure_pe = rtas_token("ibm,configure-pe");
 
-	if (ibm_set_eeh_option == RTAS_UNKNOWN_SERVICE)
-		return;
-
 	eeh_error_buf_size = rtas_token("rtas-error-log-max");
 	if (eeh_error_buf_size == RTAS_UNKNOWN_SERVICE) {
 		eeh_error_buf_size = 1024;
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 5315350..02eab3b 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -422,7 +422,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 
 	/* If all devices reported they can proceed, then re-enable MMIO */
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
-		rc = eeh_pci_enable(frozen_pdn, EEH_THAW_MMIO);
+		rc = eeh_pci_enable(frozen_pdn, EEH_OPT_THAW_MMIO);
 
 		if (rc < 0)
 			goto hard_fail;
@@ -436,7 +436,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 
 	/* If all devices reported they can proceed, then re-enable DMA */
 	if (result == PCI_ERS_RESULT_CAN_RECOVER) {
-		rc = eeh_pci_enable(frozen_pdn, EEH_THAW_DMA);
+		rc = eeh_pci_enable(frozen_pdn, EEH_OPT_THAW_DMA);
 
 		if (rc < 0)
 			goto hard_fail;
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 1a9410a..c48a9e6 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -121,7 +121,44 @@ static int pseries_eeh_init(void)
  */
 static int pseries_eeh_set_option(struct device_node *dn, int option)
 {
-	return 0;
+	int ret = 0;
+	struct pci_dn *pdn;
+	const u32 *reg;
+	int config_addr;
+
+	pdn = PCI_DN(dn);
+
+	/*
+	 * When we're enabling or disabling EEH functioality on
+	 * the particular PE, the PE config address is possibly
+	 * unavailable. Therefore, we have to figure it out from
+	 * the FDT node.
+	 */
+	switch (option) {
+	case EEH_OPT_DISABLE:
+	case EEH_OPT_ENABLE:
+		reg = of_get_property(dn, "reg", NULL);
+		config_addr = reg[0];
+		break;
+
+	case EEH_OPT_THAW_MMIO:
+	case EEH_OPT_THAW_DMA:
+		config_addr = pdn->eeh_config_addr;
+		if (pdn->eeh_pe_config_addr)
+			config_addr = pdn->eeh_pe_config_addr;
+		break;
+
+	default:
+		pr_err("%s: Invalid option %d\n",
+			__func__, option);
+		return -EINVAL;
+	}
+
+	ret = rtas_call(ibm_set_eeh_option, 4, 1, NULL,
+			config_addr, BUID_HI(pdn->phb->buid),
+			BUID_LO(pdn->phb->buid), option);
+
+	return ret;
 }
 
 /**
-- 
1.7.5.4
