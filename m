Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8DD481A0447
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:38:59 +1100 (AEDT)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9E0DD140185
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:58 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 04:08:57 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1A25B3940045
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 04:08:54 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMdSYZ57868542
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 04:09:28 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMcr3k021629
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 04:08:53 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc/powernv: Use PCI slot reset infrastructure
Date: Tue, 25 Nov 2014 09:38:43 +1100
Message-Id: <1416868727-5814-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416868727-5814-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch reworks the reset logic to reuse PCI slot reset
infrastructure implemented in OPAL firmware. For one particular
PCI slot, we have switch to hot reset in case the firmware can't
support reset for it.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            |   1 +
 arch/powerpc/include/asm/opal.h           |  25 ++---
 arch/powerpc/platforms/powernv/eeh-ioda.c | 149 ++++++++++++++++--------------
 arch/powerpc/platforms/powernv/pci-ioda.c |   5 +-
 4 files changed, 89 insertions(+), 91 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 9c11d1e..5847721 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -192,6 +192,7 @@ enum {
 #define EEH_RESET_DEACTIVATE	0	/* Deactivate the PE reset	*/
 #define EEH_RESET_HOT		1	/* Hot reset			*/
 #define EEH_RESET_FUNDAMENTAL	3	/* Fundamental reset		*/
+#define EEH_RESET_COMPLETE	4	/* PHB complete reset		*/
 #define EEH_LOG_TEMP		1	/* EEH temporary error log	*/
 #define EEH_LOG_PERM		2	/* EEH permanent error log	*/
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9124b0e..0b8b4b1 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -388,28 +388,17 @@ enum OpalM64EnableAction {
 };
 
 enum OpalPciResetScope {
-	OPAL_RESET_PHB_COMPLETE		= 1,
-	OPAL_RESET_PCI_LINK		= 2,
-	OPAL_RESET_PHB_ERROR		= 3,
-	OPAL_RESET_PCI_HOT		= 4,
-	OPAL_RESET_PCI_FUNDAMENTAL	= 5,
-	OPAL_RESET_PCI_IODA_TABLE	= 6
+	OPAL_RESET_PCI_HOT		= 0,
+	OPAL_RESET_PCI_FUNDAMENTAL	= 1,
+	OPAL_RESET_PHB_COMPLETE		= 2,
+	OPAL_RESET_PCI_IODA_TABLE	= 3,
+	OPAL_RESET_PHB_ERROR		= 4
 };
 
 enum OpalPciReinitScope {
 	OPAL_REINIT_PCI_DEV = 1000
 };
 
-enum OpalPciResetState {
-	OPAL_DEASSERT_RESET = 0,
-	OPAL_ASSERT_RESET = 1
-};
-
-enum OpalPciMaskAction {
-	OPAL_UNMASK_ERROR_TYPE = 0,
-	OPAL_MASK_ERROR_TYPE = 1
-};
-
 enum OpalSlotLedType {
 	OPAL_SLOT_LED_ID_TYPE = 0,
 	OPAL_SLOT_LED_FAULT_TYPE = 1
@@ -906,7 +895,7 @@ int64_t opal_pci_map_pe_dma_window(uint64_t phb_id, uint16_t pe_number, uint16_t
 int64_t opal_pci_map_pe_dma_window_real(uint64_t phb_id, uint16_t pe_number,
 					uint16_t dma_window_number, uint64_t pci_start_addr,
 					uint64_t pci_mem_size);
-int64_t opal_pci_reset(uint64_t phb_id, uint8_t reset_scope, uint8_t assert_state);
+int64_t opal_pci_reset(uint64_t id, uint8_t reset_scope);
 
 int64_t opal_pci_get_hub_diag_data(uint64_t hub_id, void *diag_buffer,
 				   uint64_t diag_buffer_len);
@@ -922,7 +911,7 @@ int64_t opal_get_epow_status(__be64 *status);
 int64_t opal_set_system_attention_led(uint8_t led_action);
 int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
 			    __be16 *pci_error_type, __be16 *severity);
-int64_t opal_pci_poll(uint64_t phb_id);
+int64_t opal_pci_poll(uint64_t id);
 int64_t opal_return_cpu(void);
 int64_t opal_check_token(uint64_t token);
 int64_t opal_reinit_cpus(uint64_t flags);
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 43aba2d..e5fa4ff 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -490,12 +490,12 @@ static int ioda_eeh_get_state(struct eeh_pe *pe)
 	return ioda_eeh_get_pe_state(pe);
 }
 
-static s64 ioda_eeh_phb_poll(struct pnv_phb *phb)
+static s64 ioda_eeh_phb_poll(uint64_t id)
 {
 	s64 rc = OPAL_HARDWARE;
 
 	while (1) {
-		rc = opal_pci_poll(phb->opal_id);
+		rc = opal_pci_poll(id);
 		if (rc <= 0)
 			break;
 
@@ -511,23 +511,29 @@ static s64 ioda_eeh_phb_poll(struct pnv_phb *phb)
 int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
 {
 	struct pnv_phb *phb = hose->private_data;
+	uint8_t reset_scope;
 	s64 rc = OPAL_HARDWARE;
 
 	pr_debug("%s: Reset PHB#%x, option=%d\n",
 		 __func__, hose->global_number, option);
 
-	/* Issue PHB complete reset request */
-	if (option == EEH_RESET_FUNDAMENTAL ||
-	    option == EEH_RESET_HOT)
-		rc = opal_pci_reset(phb->opal_id,
-				OPAL_RESET_PHB_COMPLETE,
-				OPAL_ASSERT_RESET);
-	else if (option == EEH_RESET_DEACTIVATE)
-		rc = opal_pci_reset(phb->opal_id,
-				OPAL_RESET_PHB_COMPLETE,
-				OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
+	switch (option) {
+	case EEH_RESET_HOT:
+		reset_scope = OPAL_RESET_PCI_HOT;
+		break;
+	case EEH_RESET_FUNDAMENTAL:
+		reset_scope = OPAL_RESET_PCI_FUNDAMENTAL;
+		break;
+	case EEH_RESET_COMPLETE:
+		reset_scope = OPAL_RESET_PHB_COMPLETE;
+		break;
+	case EEH_RESET_DEACTIVATE:
+		return 0;
+	default:
+		pr_warn("%s: Unsupported option %d\n",
+			__func__, option);
+		return -EINVAL;
+	}
 
 	/*
 	 * Poll state of the PHB until the request is done
@@ -535,61 +541,17 @@ int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
 	 * reset followed by hot reset on root bus. So we also
 	 * need the PCI bus settlement delay.
 	 */
-	rc = ioda_eeh_phb_poll(phb);
-	if (option == EEH_RESET_DEACTIVATE) {
-		if (system_state < SYSTEM_RUNNING)
-			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
-		else
-			msleep(EEH_PE_RST_SETTLE_TIME);
-	}
-out:
-	if (rc != OPAL_SUCCESS)
-		return -EIO;
-
-	return 0;
-}
-
-static int ioda_eeh_root_reset(struct pci_controller *hose, int option)
-{
-	struct pnv_phb *phb = hose->private_data;
-	s64 rc = OPAL_SUCCESS;
+	rc = opal_pci_reset(phb->opal_id, reset_scope);
+	if (rc > 0)
+		rc = ioda_eeh_phb_poll(phb->opal_id);
 
-	pr_debug("%s: Reset PHB#%x, option=%d\n",
-		 __func__, hose->global_number, option);
-
-	/*
-	 * During the reset deassert time, we needn't care
-	 * the reset scope because the firmware does nothing
-	 * for fundamental or hot reset during deassert phase.
-	 */
-	if (option == EEH_RESET_FUNDAMENTAL)
-		rc = opal_pci_reset(phb->opal_id,
-				OPAL_RESET_PCI_FUNDAMENTAL,
-				OPAL_ASSERT_RESET);
-	else if (option == EEH_RESET_HOT)
-		rc = opal_pci_reset(phb->opal_id,
-				OPAL_RESET_PCI_HOT,
-				OPAL_ASSERT_RESET);
-	else if (option == EEH_RESET_DEACTIVATE)
-		rc = opal_pci_reset(phb->opal_id,
-				OPAL_RESET_PCI_HOT,
-				OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
-
-	/* Poll state of the PHB until the request is done */
-	rc = ioda_eeh_phb_poll(phb);
-	if (option == EEH_RESET_DEACTIVATE)
-		msleep(EEH_PE_RST_SETTLE_TIME);
-out:
 	if (rc != OPAL_SUCCESS)
 		return -EIO;
 
 	return 0;
 }
 
-static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
-
+static int __ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
 {
 	struct device_node *dn = pci_device_to_OF_node(dev);
 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
@@ -639,14 +601,63 @@ static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return 0;
 }
 
+static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct device_node *dn = dev ? pci_device_to_OF_node(dev) : NULL;
+	const char *label = NULL;
+	uint64_t id = 0x1000000000000000;
+	uint8_t reset_scope;
+	s64 rc;
+
+	/*
+	 * If the firmware can't handle it, we still need simulate a hot
+	 * reset on the secondary bus. It should be the rare case.
+	 */
+	if (dn)
+		label = of_get_property(dn, "ibm,slot-label", NULL);
+	if (!label)
+		return __ioda_eeh_bridge_reset(dev, option);
+
+	/* The firmware can handle the request */
+	switch (option) {
+	case EEH_RESET_HOT:
+		reset_scope = OPAL_RESET_PCI_HOT;
+		break;
+	case EEH_RESET_FUNDAMENTAL:
+		reset_scope = OPAL_RESET_PCI_FUNDAMENTAL;
+		break;
+	case EEH_RESET_DEACTIVATE:
+		return 0;
+	case EEH_RESET_COMPLETE:
+	default:
+		pr_warn("%s: Unsupported option %d\n",
+			__func__, option);
+		return -EINVAL;
+	}
+
+	hose = pci_bus_to_host(dev->bus);
+	phb = hose->private_data;
+	id |= ((phb->opal_id << 16) | (dev->bus->number << 8) | (dev->devfn));
+	rc = opal_pci_reset(id, reset_scope);
+	if (rc > 0)
+		rc = ioda_eeh_phb_poll(id);
+
+	if (rc != OPAL_SUCCESS)
+		return -EIO;
+
+	return 0;
+}
+
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
 
 	if (pci_is_root_bus(dev->bus)) {
 		hose = pci_bus_to_host(dev->bus);
-		ioda_eeh_root_reset(hose, EEH_RESET_HOT);
-		ioda_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
+		ioda_eeh_phb_reset(hose, EEH_RESET_HOT);
+		ioda_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
 	} else {
 		ioda_eeh_bridge_reset(dev, EEH_RESET_HOT);
 		ioda_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
@@ -686,7 +697,7 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 	 * state explicitly after BAR restore.
 	 */
 	if (pe->type & EEH_PE_PHB) {
-		ret = ioda_eeh_phb_reset(hose, option);
+		ret = ioda_eeh_phb_reset(hose, EEH_RESET_COMPLETE);
 	} else {
 		struct pnv_phb *phb;
 		s64 rc;
@@ -703,8 +714,7 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 		    (option == EEH_RESET_HOT ||
 		    option == EEH_RESET_FUNDAMENTAL)) {
 			rc = opal_pci_reset(phb->opal_id,
-					    OPAL_RESET_PHB_ERROR,
-					    OPAL_ASSERT_RESET);
+					    OPAL_RESET_PHB_ERROR);
 			if (rc != OPAL_SUCCESS) {
 				pr_warn("%s: Failure %lld clearing "
 					"error injection registers\n",
@@ -714,9 +724,8 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 		}
 
 		bus = eeh_pe_bus_get(pe);
-		if (pci_is_root_bus(bus) ||
-		    pci_is_root_bus(bus->parent))
-			ret = ioda_eeh_root_reset(hose, option);
+		if (pci_is_root_bus(bus))
+			ret = ioda_eeh_phb_reset(hose, option);
 		else
 			ret = ioda_eeh_bridge_reset(bus->self, option);
 	}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ba1b4cb..5b0fcea 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1913,8 +1913,7 @@ static u32 pnv_ioda_bdfn_to_pe(struct pnv_phb *phb, struct pci_bus *bus,
 
 static void pnv_pci_ioda_shutdown(struct pnv_phb *phb)
 {
-	opal_pci_reset(phb->opal_id, OPAL_RESET_PCI_IODA_TABLE,
-		       OPAL_ASSERT_RESET);
+	opal_pci_reset(phb->opal_id, OPAL_RESET_PCI_IODA_TABLE);
 }
 
 static void __init pnv_pci_init_ioda_phb(struct device_node *np,
@@ -2090,7 +2089,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	pci_add_flags(PCI_REASSIGN_ALL_RSRC);
 
 	/* Reset IODA tables to a clean state */
-	rc = opal_pci_reset(phb_id, OPAL_RESET_PCI_IODA_TABLE, OPAL_ASSERT_RESET);
+	rc = opal_pci_reset(phb_id, OPAL_RESET_PCI_IODA_TABLE);
 	if (rc)
 		pr_warning("  OPAL Error %ld performing IODA table reset !\n", rc);
 
-- 
1.8.3.2
