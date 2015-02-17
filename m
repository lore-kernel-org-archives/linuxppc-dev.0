Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E2D01A0A03
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Feb 2015 18:14:29 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A91B214029C
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:28 +1100 (AEDT)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 17:14:27 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 406EF2CE8050
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:24 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1H7EGGR49086644
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:14:24 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1H7Dopm027798
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 18:13:51 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH RESEND v2 1/7] powerpc/powernv: Use PCI slot reset
 infrastructure
Date: Tue, 17 Feb 2015 18:13:17 +1100
Message-Id: <1424157203-691-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1424157203-691-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For PowerNV platform, running on top of skiboot, all PE level reset
should be routed to firmware if the bridge of the PE primary bus has
device-node property "ibm,reset-by-firmware". Otherwise, the kernel
has to issue hot reset on PE's primary bus despite the requested
reset types, which is the behaviour before the firmware supports PCI
slot reset. So the code doesn't depend on the PCI slot reset capability
exposed from the firmware.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |   1 +
 arch/powerpc/include/asm/opal.h              |   9 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 218 ++++++++++++++-------------
 3 files changed, 114 insertions(+), 114 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 55abfd0..9de87ce 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -193,6 +193,7 @@ enum {
 #define EEH_RESET_DEACTIVATE	0	/* Deactivate the PE reset	*/
 #define EEH_RESET_HOT		1	/* Hot reset			*/
 #define EEH_RESET_FUNDAMENTAL	3	/* Fundamental reset		*/
+#define EEH_RESET_COMPLETE	4	/* PHB complete reset		*/
 #define EEH_LOG_TEMP		1	/* EEH temporary error log	*/
 #define EEH_LOG_PERM		2	/* EEH permanent error log	*/
 
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 9ee0a30..ceec756 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -374,11 +374,6 @@ enum OpalPciResetState {
 	OPAL_ASSERT_RESET = 1
 };
 
-enum OpalPciMaskAction {
-	OPAL_UNMASK_ERROR_TYPE = 0,
-	OPAL_MASK_ERROR_TYPE = 1
-};
-
 enum OpalSlotLedType {
 	OPAL_SLOT_LED_ID_TYPE = 0,
 	OPAL_SLOT_LED_FAULT_TYPE = 1
@@ -867,7 +862,7 @@ int64_t opal_pci_map_pe_dma_window(uint64_t phb_id, uint16_t pe_number, uint16_t
 int64_t opal_pci_map_pe_dma_window_real(uint64_t phb_id, uint16_t pe_number,
 					uint16_t dma_window_number, uint64_t pci_start_addr,
 					uint64_t pci_mem_size);
-int64_t opal_pci_reset(uint64_t phb_id, uint8_t reset_scope, uint8_t assert_state);
+int64_t opal_pci_reset(uint64_t id, uint8_t reset_scope, uint8_t assert_state);
 
 int64_t opal_pci_get_hub_diag_data(uint64_t hub_id, void *diag_buffer,
 				   uint64_t diag_buffer_len);
@@ -883,7 +878,7 @@ int64_t opal_get_epow_status(__be64 *status);
 int64_t opal_set_system_attention_led(uint8_t led_action);
 int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
 			    __be16 *pci_error_type, __be16 *severity);
-int64_t opal_pci_poll(uint64_t phb_id);
+int64_t opal_pci_poll(uint64_t id, uint8_t *val);
 int64_t opal_return_cpu(void);
 int64_t opal_check_token(uint64_t token);
 int64_t opal_reinit_cpus(uint64_t flags);
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index ede6906..8cec57d 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -665,12 +665,12 @@ static int pnv_eeh_get_state(struct eeh_pe *pe, int *delay)
 	return ret;
 }
 
-static s64 pnv_eeh_phb_poll(struct pnv_phb *phb)
+static s64 pnv_eeh_poll(uint64_t id)
 {
 	s64 rc = OPAL_HARDWARE;
 
 	while (1) {
-		rc = opal_pci_poll(phb->opal_id);
+		rc = opal_pci_poll(id, NULL);
 		if (rc <= 0)
 			break;
 
@@ -686,84 +686,38 @@ static s64 pnv_eeh_phb_poll(struct pnv_phb *phb)
 int pnv_eeh_phb_reset(struct pci_controller *hose, int option)
 {
 	struct pnv_phb *phb = hose->private_data;
+	uint8_t scope;
 	s64 rc = OPAL_HARDWARE;
 
 	pr_debug("%s: Reset PHB#%x, option=%d\n",
 		 __func__, hose->global_number, option);
+	switch (option) {
+	case EEH_RESET_HOT:
+		scope = OPAL_RESET_PCI_HOT;
+		break;
+	case EEH_RESET_FUNDAMENTAL:
+		scope = OPAL_RESET_PCI_FUNDAMENTAL;
+		break;
+	case EEH_RESET_COMPLETE:
+		scope = OPAL_RESET_PHB_COMPLETE;
+		break;
+	case EEH_RESET_DEACTIVATE:
+		return 0;
+	default:
+		pr_warn("%s: Unsupported option %d\n",
+			__func__, option);
+		return -EINVAL;
+        }
 
-	/* Issue PHB complete reset request */
-	if (option == EEH_RESET_FUNDAMENTAL ||
-	    option == EEH_RESET_HOT)
-		rc = opal_pci_reset(phb->opal_id,
-				    OPAL_RESET_PHB_COMPLETE,
-				    OPAL_ASSERT_RESET);
-	else if (option == EEH_RESET_DEACTIVATE)
-		rc = opal_pci_reset(phb->opal_id,
-				    OPAL_RESET_PHB_COMPLETE,
-				    OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
-
-	/*
-	 * Poll state of the PHB until the request is done
-	 * successfully. The PHB reset is usually PHB complete
-	 * reset followed by hot reset on root bus. So we also
-	 * need the PCI bus settlement delay.
-	 */
-	rc = pnv_eeh_phb_poll(phb);
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
-static int pnv_eeh_root_reset(struct pci_controller *hose, int option)
-{
-	struct pnv_phb *phb = hose->private_data;
-	s64 rc = OPAL_HARDWARE;
-
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
-				    OPAL_RESET_PCI_FUNDAMENTAL,
-				    OPAL_ASSERT_RESET);
-	else if (option == EEH_RESET_HOT)
-		rc = opal_pci_reset(phb->opal_id,
-				    OPAL_RESET_PCI_HOT,
-				    OPAL_ASSERT_RESET);
-	else if (option == EEH_RESET_DEACTIVATE)
-		rc = opal_pci_reset(phb->opal_id,
-				    OPAL_RESET_PCI_HOT,
-				    OPAL_DEASSERT_RESET);
-	if (rc < 0)
-		goto out;
-
-	/* Poll state of the PHB until the request is done */
-	rc = pnv_eeh_phb_poll(phb);
-	if (option == EEH_RESET_DEACTIVATE)
-		msleep(EEH_PE_RST_SETTLE_TIME);
-out:
-	if (rc != OPAL_SUCCESS)
-		return -EIO;
+	/* Issue reset and poll until it's completed */
+	rc = opal_pci_reset(phb->opal_id, scope, OPAL_ASSERT_RESET);
+	if (rc > 0)
+		rc = pnv_eeh_poll(phb->opal_id);
 
-	return 0;
+	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
 }
 
-static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
+static int __pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 {
 	struct device_node *dn = pci_device_to_OF_node(dev);
 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
@@ -814,14 +768,57 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return 0;
 }
 
+static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct device_node *dn = dev ? pci_device_to_OF_node(dev) : NULL;
+	uint64_t id = (0x1ul << 60);
+	uint8_t scope;
+	s64 rc;
+
+	/*
+	 * If the firmware can't handle it, we will issue hot reset
+	 * on the secondary bus despite the requested reset type
+	 */
+	if (!dn || !of_get_property(dn, "ibm,reset-by-firmware", NULL))
+		return __pnv_eeh_bridge_reset(dev, option);
+
+	/* The firmware can handle the request */
+	switch (option) {
+	case EEH_RESET_HOT:
+		scope = OPAL_RESET_PCI_HOT;
+		break;
+	case EEH_RESET_FUNDAMENTAL:
+		scope = OPAL_RESET_PCI_FUNDAMENTAL;
+		break;
+	case EEH_RESET_DEACTIVATE:
+		return 0;
+	case EEH_RESET_COMPLETE:
+	default:
+		pr_warn("%s: Unsupported option %d on device %s\n",
+			__func__, option, pci_name(dev));
+		return -EINVAL;
+	}
+
+	hose = pci_bus_to_host(dev->bus);
+	phb = hose->private_data;
+	id |= (dev->bus->number << 24) | (dev->devfn << 16) | phb->opal_id;
+	rc = opal_pci_reset(id, scope, OPAL_ASSERT_RESET);
+	if (rc > 0)
+		pnv_eeh_poll(id);
+
+	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
+}
+
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
 
 	if (pci_is_root_bus(dev->bus)) {
 		hose = pci_bus_to_host(dev->bus);
-		pnv_eeh_root_reset(hose, EEH_RESET_HOT);
-		pnv_eeh_root_reset(hose, EEH_RESET_DEACTIVATE);
+		pnv_eeh_phb_reset(hose, EEH_RESET_HOT);
+		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
 	} else {
 		pnv_eeh_bridge_reset(dev, EEH_RESET_HOT);
 		pnv_eeh_bridge_reset(dev, EEH_RESET_DEACTIVATE);
@@ -843,8 +840,9 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 {
 	struct pci_controller *hose = pe->phb;
+	struct pnv_phb *phb;
 	struct pci_bus *bus;
-	int ret;
+	s64 rc;
 
 	/*
 	 * For PHB reset, we always have complete reset. For those PEs whose
@@ -861,42 +859,48 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 	 * state explicitly after BAR restore.
 	 */
 	if (pe->type & EEH_PE_PHB) {
-		ret = pnv_eeh_phb_reset(hose, option);
-	} else {
-		struct pnv_phb *phb;
-		s64 rc;
-
-		/*
-		 * The frozen PE might be caused by PAPR error injection
-		 * registers, which are expected to be cleared after hitting
-		 * frozen PE as stated in the hardware spec. Unfortunately,
-		 * that's not true on P7IOC. So we have to clear it manually
-		 * to avoid recursive EEH errors during recovery.
-		 */
-		phb = hose->private_data;
-		if (phb->model == PNV_PHB_MODEL_P7IOC &&
-		    (option == EEH_RESET_HOT ||
-		    option == EEH_RESET_FUNDAMENTAL)) {
-			rc = opal_pci_reset(phb->opal_id,
-					    OPAL_RESET_PHB_ERROR,
-					    OPAL_ASSERT_RESET);
-			if (rc != OPAL_SUCCESS) {
-				pr_warn("%s: Failure %lld clearing "
-					"error injection registers\n",
-					__func__, rc);
-				return -EIO;
-			}
+		switch (option) {
+		case EEH_RESET_HOT:
+		case EEH_RESET_FUNDAMENTAL:
+		case EEH_RESET_COMPLETE:
+			break;
+		case EEH_RESET_DEACTIVATE:
+			return 0;
+		default:
+			return -EINVAL;
 		}
 
-		bus = eeh_pe_bus_get(pe);
-		if (pci_is_root_bus(bus) ||
-			pci_is_root_bus(bus->parent))
-			ret = pnv_eeh_root_reset(hose, option);
-		else
-			ret = pnv_eeh_bridge_reset(bus->self, option);
+		return pnv_eeh_phb_reset(hose, EEH_RESET_COMPLETE);
 	}
 
-	return ret;
+	/*
+	 * The frozen PE might be caused by PAPR error injection
+	 * registers, which are expected to be cleared after hitting
+	 * frozen PE as stated in the hardware spec. Unfortunately,
+	 * that's not true on P7IOC. So we have to clear it manually
+	 * to avoid recursive EEH errors during recovery.
+	 */
+	phb = hose->private_data;
+	if (phb->model == PNV_PHB_MODEL_P7IOC &&
+	    (option == EEH_RESET_HOT ||
+	     option == EEH_RESET_FUNDAMENTAL)) {
+		rc = opal_pci_reset(phb->opal_id,
+				    OPAL_RESET_PHB_ERROR,
+				    OPAL_ASSERT_RESET);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Failure %lld clearing error "
+				"injection registers\n",
+				__func__, rc);
+			return -EIO;
+		}
+	}
+
+	/* Route the reset request to PHB or upstream bridge */
+	bus = eeh_pe_bus_get(pe);
+	if (pci_is_root_bus(bus))
+		return pnv_eeh_phb_reset(hose, option);
+
+	return pnv_eeh_bridge_reset(bus->self, option);
 }
 
 /**
-- 
1.8.3.2
