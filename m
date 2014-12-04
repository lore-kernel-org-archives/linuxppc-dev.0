Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A066E1A0C18
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:51:10 +1100 (AEDT)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 324731400E9
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 16:51:08 +1100 (AEDT)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Dec 2014 11:21:07 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 4FFB61258053
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Dec 2014 11:21:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB45ou2j46071868
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2014 11:20:57 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB45p2U4004362
 for <linuxppc-dev@ozlabs.org>; Thu, 4 Dec 2014 11:21:02 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] powerpc/powernv: Use PCI slot reset infrastructure
Date: Thu,  4 Dec 2014 16:50:51 +1100
Message-Id: <1417672253-26692-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1417672253-26692-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1417672253-26692-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For PowerPC PowerNV platform, running on top of skiboot, all PE
level reset should be routed to firmware, which exported PCI slot
reset capability with device-node property "ibm,reset-by-firmware".
Otherwise, the kernel still has to simulate hot reset on PCI bridge's
secondary bus. So the code doesn't depend on if the firmware has
corresponding feature supported.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h            |   1 +
 arch/powerpc/include/asm/opal.h           |   9 +-
 arch/powerpc/platforms/powernv/eeh-ioda.c | 163 ++++++++++++++++--------------
 3 files changed, 89 insertions(+), 84 deletions(-)

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
index 9124b0e..edd1993 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -405,11 +405,6 @@ enum OpalPciResetState {
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
@@ -906,7 +901,7 @@ int64_t opal_pci_map_pe_dma_window(uint64_t phb_id, uint16_t pe_number, uint16_t
 int64_t opal_pci_map_pe_dma_window_real(uint64_t phb_id, uint16_t pe_number,
 					uint16_t dma_window_number, uint64_t pci_start_addr,
 					uint64_t pci_mem_size);
-int64_t opal_pci_reset(uint64_t phb_id, uint8_t reset_scope, uint8_t assert_state);
+int64_t opal_pci_reset(uint64_t id, uint8_t reset_scope, uint8_t assert_state);
 
 int64_t opal_pci_get_hub_diag_data(uint64_t hub_id, void *diag_buffer,
 				   uint64_t diag_buffer_len);
@@ -922,7 +917,7 @@ int64_t opal_get_epow_status(__be64 *status);
 int64_t opal_set_system_attention_led(uint8_t led_action);
 int64_t opal_pci_next_error(uint64_t phb_id, __be64 *first_frozen_pe,
 			    __be16 *pci_error_type, __be16 *severity);
-int64_t opal_pci_poll(uint64_t phb_id);
+int64_t opal_pci_poll(uint64_t id, uint8_t *val);
 int64_t opal_return_cpu(void);
 int64_t opal_check_token(uint64_t token);
 int64_t opal_reinit_cpus(uint64_t flags);
diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 43aba2d..825da60 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -490,12 +490,12 @@ static int ioda_eeh_get_state(struct eeh_pe *pe)
 	return ioda_eeh_get_pe_state(pe);
 }
 
-static s64 ioda_eeh_phb_poll(struct pnv_phb *phb)
+static s64 ioda_eeh_poll(uint64_t id)
 {
 	s64 rc = OPAL_HARDWARE;
 
 	while (1) {
-		rc = opal_pci_poll(phb->opal_id);
+		rc = opal_pci_poll(id, NULL);
 		if (rc <= 0)
 			break;
 
@@ -511,84 +511,38 @@ static s64 ioda_eeh_phb_poll(struct pnv_phb *phb)
 int ioda_eeh_phb_reset(struct pci_controller *hose, int option)
 {
 	struct pnv_phb *phb = hose->private_data;
+	uint8_t scope;
 	s64 rc = OPAL_HARDWARE;
 
 	pr_debug("%s: Reset PHB#%x, option=%d\n",
 		 __func__, hose->global_number, option);
-
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
-
-	/*
-	 * Poll state of the PHB until the request is done
-	 * successfully. The PHB reset is usually PHB complete
-	 * reset followed by hot reset on root bus. So we also
-	 * need the PCI bus settlement delay.
-	 */
-	rc = ioda_eeh_phb_poll(phb);
-	if (option == EEH_RESET_DEACTIVATE) {
-		if (system_state < SYSTEM_RUNNING)
-			udelay(1000 * EEH_PE_RST_SETTLE_TIME);
-		else
-			msleep(EEH_PE_RST_SETTLE_TIME);
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
 	}
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
 
-	pr_debug("%s: Reset PHB#%x, option=%d\n",
-		 __func__, hose->global_number, option);
+	/* Issue reset and poll until it's completed */
+	rc = opal_pci_reset(phb->opal_id, scope, OPAL_ASSERT_RESET);
+	if (rc > 0)
+		rc = ioda_eeh_poll(phb->opal_id);
 
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
-	if (rc != OPAL_SUCCESS)
-		return -EIO;
-
-	return 0;
+	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
 }
 
-static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
+static int __ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
 
 {
 	struct device_node *dn = pci_device_to_OF_node(dev);
@@ -639,14 +593,57 @@ static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return 0;
 }
 
+static int ioda_eeh_bridge_reset(struct pci_dev *dev, int option)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	struct device_node *dn = dev ? pci_device_to_OF_node(dev) : NULL;
+	uint64_t id = (0x1ul << 60);
+	uint8_t scope;
+	s64 rc;
+
+	/*
+	 * If the firmware can't handle it, we still need simulate a hot
+	 * reset on the secondary bus. It should be the rare case.
+	 */
+	if (!of_get_property(dn, "ibm,reset-by-firmware", NULL))
+		return __ioda_eeh_bridge_reset(dev, option);
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
+		ioda_eeh_poll(id);
+
+	return (rc == OPAL_SUCCESS) ? 0 : -EIO;
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
@@ -686,7 +683,20 @@ static int ioda_eeh_reset(struct eeh_pe *pe, int option)
 	 * state explicitly after BAR restore.
 	 */
 	if (pe->type & EEH_PE_PHB) {
-		ret = ioda_eeh_phb_reset(hose, option);
+		switch (option) {
+		case EEH_RESET_HOT:
+		case EEH_RESET_FUNDAMENTAL:
+		case EEH_RESET_COMPLETE:
+			ret = ioda_eeh_phb_reset(hose, EEH_RESET_COMPLETE);
+			break;
+		case EEH_RESET_DEACTIVATE:
+			ret = 0;
+			break;
+		default:
+			ret = -EINVAL;
+		}
+
+		return ret;
 	} else {
 		struct pnv_phb *phb;
 		s64 rc;
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
-- 
1.8.3.2
