Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 035B3B6FD4
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:33 +1100 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 24 Feb 2012 09:22:15 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1O9X21T3018756
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:33:02 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1O9cNVl007719
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2012 20:38:23 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/21] pSeries platform PE state retrieval
Date: Fri, 24 Feb 2012 17:38:04 +0800
Message-Id: <1330076298-7006-8-git-send-email-shangw@linux.vnet.ibm.com>
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

On pSeries platform, there're 2 dedicated RTAS calls introduced to
retrieve the corresponding PE's state: ibm,read-slot-reset-state and
ibm,read-slot-reset-state2.

The patch implements the retrieval of PE's state according to the
given PE address. Besides, the implementation has been abstracted by
struct eeh_ops::get_state so that EEH core components could support
multiple platforms in future.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    8 ++
 arch/powerpc/platforms/pseries/eeh.c         |   96 ++++---------------------
 arch/powerpc/platforms/pseries/eeh_driver.c  |    2 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c |   70 ++++++++++++++++++-
 4 files changed, 94 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 76f7b3f..1d3c9e5 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -42,6 +42,14 @@ struct device_node;
 #define EEH_OPT_ENABLE		1	/* EEH enable	*/
 #define EEH_OPT_THAW_MMIO	2	/* MMIO enable	*/
 #define EEH_OPT_THAW_DMA	3	/* DMA enable	*/
+#define EEH_STATE_UNAVAILABLE	(1 << 0)	/* State unavailable	*/
+#define EEH_STATE_NOT_SUPPORT	(1 << 1)	/* EEH not supported	*/
+#define EEH_STATE_RESET_ACTIVE	(1 << 2)	/* Active reset		*/
+#define EEH_STATE_MMIO_ACTIVE	(1 << 3)	/* Active MMIO		*/
+#define EEH_STATE_DMA_ACTIVE	(1 << 4)	/* Active DMA		*/
+#define EEH_STATE_MMIO_ENABLED	(1 << 5)	/* MMIO enabled		*/
+#define EEH_STATE_DMA_ENABLED	(1 << 6)	/* DMA enabled		*/
+
 struct eeh_ops {
 	char *name;
 	int (*init)(void);
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 00797e0..8d11f1f 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -88,8 +88,6 @@
 
 /* RTAS tokens */
 static int ibm_set_slot_reset;
-static int ibm_read_slot_reset_state;
-static int ibm_read_slot_reset_state2;
 static int ibm_slot_error_detail;
 static int ibm_configure_bridge;
 static int ibm_configure_pe;
@@ -289,37 +287,6 @@ void eeh_slot_error_detail(struct pci_dn *pdn, int severity)
 }
 
 /**
- * eeh_read_slot_reset_state - Read the reset state of a device node's slot
- * @dn: device node to read
- * @rets: array to return results in
- *
- * Read the reset state of a device node's slot through platform dependent
- * function call.
- */
-static int eeh_read_slot_reset_state(struct pci_dn *pdn, int rets[])
-{
-	int token, outputs;
-	int config_addr;
-
-	if (ibm_read_slot_reset_state2 != RTAS_UNKNOWN_SERVICE) {
-		token = ibm_read_slot_reset_state2;
-		outputs = 4;
-	} else {
-		token = ibm_read_slot_reset_state;
-		rets[2] = 0; /* fake PE Unavailable info */
-		outputs = 3;
-	}
-
-	/* Use PE configuration address, if present */
-	config_addr = pdn->eeh_config_addr;
-	if (pdn->eeh_pe_config_addr)
-		config_addr = pdn->eeh_pe_config_addr;
-
-	return rtas_call(token, 3, outputs, rets, config_addr,
-			 BUID_HI(pdn->phb->buid), BUID_LO(pdn->phb->buid));
-}
-
-/**
  * eeh_wait_for_slot_status - Returns error status of slot
  * @pdn: pci device node
  * @max_wait_msecs: maximum number to millisecs to wait
@@ -335,21 +302,15 @@ static int eeh_read_slot_reset_state(struct pci_dn *pdn, int rets[])
 int eeh_wait_for_slot_status(struct pci_dn *pdn, int max_wait_msecs)
 {
 	int rc;
-	int rets[3];
 	int mwait;
 
 	while (1) {
-		rc = eeh_read_slot_reset_state(pdn, rets);
-		if (rc) return rc;
-		if (rets[1] == 0) return -1;  /* EEH is not supported */
-
-		if (rets[0] != 5) return rets[0]; /* return actual status */
-
-		if (rets[2] == 0) return -1; /* permanently unavailable */
+		rc = eeh_ops->get_state(pdn->node, &mwait);
+		if (rc != EEH_STATE_UNAVAILABLE)
+			return rc;
 
 		if (max_wait_msecs <= 0) break;
 
-		mwait = rets[2];
 		if (mwait <= 0) {
 			printk(KERN_WARNING "EEH: Firmware returned bad wait value=%d\n",
 				mwait);
@@ -522,7 +483,6 @@ void eeh_clear_slot(struct device_node *dn, int mode_flag)
 int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 {
 	int ret;
-	int rets[3];
 	unsigned long flags;
 	struct pci_dn *pdn;
 	int rc = 0;
@@ -584,40 +544,18 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
 	 * function zero of a multi-function device.
 	 * In any case they must share a common PHB.
 	 */
-	ret = eeh_read_slot_reset_state(pdn, rets);
-
-	/* If the call to firmware failed, punt */
-	if (ret != 0) {
-		printk(KERN_WARNING "EEH: eeh_read_slot_reset_state() failed; rc=%d dn=%s\n",
-		       ret, dn->full_name);
-		false_positives++;
-		pdn->eeh_false_positives ++;
-		rc = 0;
-		goto dn_unlock;
-	}
+	ret = eeh_ops->get_state(pdn->node, NULL);
 
 	/* Note that config-io to empty slots may fail;
 	 * they are empty when they don't have children.
+	 * We will punt with the following conditions: Failure to get
+	 * PE's state, EEH not support and Permanently unavailable
+	 * state, PE is in good state.
 	 */
-	if ((rets[0] == 5) && (rets[2] == 0) && (dn->child == NULL)) {
-		false_positives++;
-		pdn->eeh_false_positives ++;
-		rc = 0;
-		goto dn_unlock;
-	}
-
-	/* If EEH is not supported on this device, punt. */
-	if (rets[1] != 1) {
-		printk(KERN_WARNING "EEH: event on unsupported device, rc=%d dn=%s\n",
-		       ret, dn->full_name);
-		false_positives++;
-		pdn->eeh_false_positives ++;
-		rc = 0;
-		goto dn_unlock;
-	}
-
-	/* If not the kind of error we know about, punt. */
-	if (rets[0] != 1 && rets[0] != 2 && rets[0] != 4 && rets[0] != 5) {
+	if ((ret < 0) ||
+	    (ret == EEH_STATE_NOT_SUPPORT) ||
+	    (ret & (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) ==
+	    (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE)) {
 		false_positives++;
 		pdn->eeh_false_positives ++;
 		rc = 0;
@@ -703,7 +641,8 @@ int eeh_pci_enable(struct pci_dn *pdn, int function)
 		        function, rc, pdn->node->full_name);
 
 	rc = eeh_wait_for_slot_status(pdn, PCI_BUS_RESET_WAIT_MSEC);
-	if ((rc == 4) && (function == EEH_OPT_THAW_MMIO))
+	if (rc > 0 && (rc & EEH_STATE_MMIO_ENABLED) &&
+	   (function == EEH_OPT_THAW_MMIO))
 		return 0;
 
 	return rc;
@@ -900,7 +839,7 @@ int eeh_reset_pe(struct pci_dn *pdn)
 		eeh_reset_pe_once(pdn);
 
 		rc = eeh_wait_for_slot_status(pdn, PCI_BUS_RESET_WAIT_MSEC);
-		if (rc == 0)
+		if (rc == (EEH_STATE_MMIO_ACTIVE | EEH_STATE_DMA_ACTIVE))
 			return 0;
 
 		if (rc < 0) {
@@ -1057,7 +996,6 @@ void eeh_configure_bridge(struct pci_dn *pdn)
  */
 static void *eeh_early_enable(struct device_node *dn, void *data)
 {
-	unsigned int rets[3];
 	int ret;
 	const u32 *class_code = of_get_property(dn, "class-code", NULL);
 	const u32 *vendor_id = of_get_property(dn, "vendor-id", NULL);
@@ -1109,8 +1047,8 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 			 * where EEH is not supported. Verify support
 			 * explicitly.
 			 */
-			ret = eeh_read_slot_reset_state(pdn, rets);
-			if ((ret == 0) && (rets[1] == 1))
+			ret = eeh_ops->get_state(pdn->node, NULL);
+			if (ret > 0 && ret != EEH_STATE_NOT_SUPPORT)
 				enable = 1;
 		}
 
@@ -1232,8 +1170,6 @@ void __init eeh_init(void)
 		return;
 
 	ibm_set_slot_reset = rtas_token("ibm,set-slot-reset");
-	ibm_read_slot_reset_state2 = rtas_token("ibm,read-slot-reset-state2");
-	ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
 	ibm_slot_error_detail = rtas_token("ibm,slot-error-detail");
 	ibm_configure_bridge = rtas_token("ibm,configure-bridge");
 	ibm_configure_pe = rtas_token("ibm,configure-pe");
diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
index 02eab3b..4c6e0c1c 100644
--- a/arch/powerpc/platforms/pseries/eeh_driver.c
+++ b/arch/powerpc/platforms/pseries/eeh_driver.c
@@ -397,7 +397,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
 	/* Get the current PCI slot state. This can take a long time,
 	 * sometimes over 3 seconds for certain systems. */
 	rc = eeh_wait_for_slot_status (frozen_pdn, MAX_WAIT_FOR_RECOVERY*1000);
-	if (rc < 0) {
+	if (rc < 0 || rc == EEH_STATE_NOT_SUPPORT) {
 		printk(KERN_WARNING "EEH: Permanent failure\n");
 		goto hard_fail;
 	}
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 2b9543a..39567b2 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -238,7 +238,75 @@ static int pseries_eeh_get_pe_addr(struct device_node *dn)
  */
 static int pseries_eeh_get_state(struct device_node *dn, int *state)
 {
-	return 0;
+	struct pci_dn *pdn;
+	int config_addr;
+	int ret;
+	int rets[4];
+	int result;
+
+	/* Figure out PE config address if possible */
+	pdn = PCI_DN(dn);
+	config_addr = pdn->eeh_config_addr;
+	if (pdn->eeh_pe_config_addr)
+		config_addr = pdn->eeh_pe_config_addr;
+
+	if (ibm_read_slot_reset_state2 != RTAS_UNKNOWN_SERVICE) {
+		ret = rtas_call(ibm_read_slot_reset_state2, 3, 4, rets,
+				config_addr, BUID_HI(pdn->phb->buid),
+				BUID_LO(pdn->phb->buid));
+	} else if (ibm_read_slot_reset_state != RTAS_UNKNOWN_SERVICE) {
+		/* Fake PE unavailable info */
+		rets[2] = 0;
+		ret = rtas_call(ibm_read_slot_reset_state, 3, 3, rets,
+				config_addr, BUID_HI(pdn->phb->buid),
+				BUID_LO(pdn->phb->buid));
+	} else {
+		return EEH_STATE_NOT_SUPPORT;
+	}
+
+	if (ret)
+		return ret;
+
+	/* Parse the result out */
+	result = 0;
+	if (rets[1]) {
+		switch(rets[0]) {
+		case 0:
+			result &= ~EEH_STATE_RESET_ACTIVE;
+			result |= EEH_STATE_MMIO_ACTIVE;
+			result |= EEH_STATE_DMA_ACTIVE;
+			break;
+		case 1:
+			result |= EEH_STATE_RESET_ACTIVE;
+			result |= EEH_STATE_MMIO_ACTIVE;
+			result |= EEH_STATE_DMA_ACTIVE;
+			break;
+		case 2:
+			result &= ~EEH_STATE_RESET_ACTIVE;
+			result &= ~EEH_STATE_MMIO_ACTIVE;
+			result &= ~EEH_STATE_DMA_ACTIVE;
+			break;
+		case 4:
+			result &= ~EEH_STATE_RESET_ACTIVE;
+			result &= ~EEH_STATE_MMIO_ACTIVE;
+			result &= ~EEH_STATE_DMA_ACTIVE;
+			result |= EEH_STATE_MMIO_ENABLED;
+			break;
+		case 5:
+			if (rets[2]) {
+				if (state) *state = rets[2];
+				result = EEH_STATE_UNAVAILABLE;
+			} else {
+				result = EEH_STATE_NOT_SUPPORT;
+			}
+		default:
+			result = EEH_STATE_NOT_SUPPORT;
+		}
+	} else {
+		result = EEH_STATE_NOT_SUPPORT;
+	}
+
+	return result;
 }
 
 /**
-- 
1.7.5.4
