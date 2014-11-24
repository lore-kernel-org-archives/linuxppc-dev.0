Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E9931A025C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:38:57 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 48B92140187
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:57 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 08:38:56 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7760E2BB0060
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:54 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMcs3N36634874
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:54 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMcrTH015310
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2014 09:38:54 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/5] powerpc/powernv: Drop opal_pci_reinit()
Date: Tue, 25 Nov 2014 09:38:47 +1100
Message-Id: <1416868727-5814-6-git-send-email-gwshan@linux.vnet.ibm.com>
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

With unified PCI slot reset infrastructure supported by the firmware,
we needn't reinitialize the affected devices after PE reset. OPAL API
opal_pci_reinit() and related logic, including EEH restore_config()
callback can be killed safely. All the work covered by opal_pci_reinit()
should be done in firmware insteadly.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h                 |  1 -
 arch/powerpc/include/asm/opal.h                |  6 ------
 arch/powerpc/kernel/eeh_pe.c                   |  3 ---
 arch/powerpc/platforms/powernv/eeh-powernv.c   | 24 +-----------------------
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 -
 arch/powerpc/platforms/pseries/eeh_pseries.c   |  3 +--
 6 files changed, 2 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 5847721..687fc5c 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -214,7 +214,6 @@ struct eeh_ops {
 	int (*read_config)(struct device_node *dn, int where, int size, u32 *val);
 	int (*write_config)(struct device_node *dn, int where, int size, u32 val);
 	int (*next_error)(struct eeh_pe **pe);
-	int (*restore_config)(struct device_node *dn);
 };
 
 extern int eeh_subsystem_flags;
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 0b8b4b1..b59811f 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -108,7 +108,6 @@ struct opal_sg_list {
 #define OPAL_PCI_GET_HUB_DIAG_DATA		50
 #define OPAL_PCI_GET_PHB_DIAG_DATA		51
 #define OPAL_PCI_FENCE_PHB			52
-#define OPAL_PCI_REINIT				53
 #define OPAL_PCI_MASK_PE_ERROR			54
 #define OPAL_SET_SLOT_LED_STATUS		55
 #define OPAL_GET_EPOW_STATUS			56
@@ -395,10 +394,6 @@ enum OpalPciResetScope {
 	OPAL_RESET_PHB_ERROR		= 4
 };
 
-enum OpalPciReinitScope {
-	OPAL_REINIT_PCI_DEV = 1000
-};
-
 enum OpalSlotLedType {
 	OPAL_SLOT_LED_ID_TYPE = 0,
 	OPAL_SLOT_LED_FAULT_TYPE = 1
@@ -904,7 +899,6 @@ int64_t opal_pci_get_phb_diag_data(uint64_t phb_id, void *diag_buffer,
 int64_t opal_pci_get_phb_diag_data2(uint64_t phb_id, void *diag_buffer,
 				    uint64_t diag_buffer_len);
 int64_t opal_pci_fence_phb(uint64_t phb_id);
-int64_t opal_pci_reinit(uint64_t phb_id, uint64_t reinit_scope, uint64_t data);
 int64_t opal_pci_mask_pe_error(uint64_t phb_id, uint16_t pe_number, uint8_t error_type, uint8_t mask_action);
 int64_t opal_set_slot_led_status(uint64_t phb_id, uint64_t slot_id, uint8_t led_type, uint8_t led_action);
 int64_t opal_get_epow_status(__be64 *status);
diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index fa950fb..98a1f12 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -814,9 +814,6 @@ static void *eeh_restore_one_device_bars(void *data, void *flag)
 	else
 		eeh_restore_device_bars(edev, dn);
 
-	if (eeh_ops->restore_config)
-		eeh_ops->restore_config(dn);
-
 	return NULL;
 }
 
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index e261869..d57ff59c 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -469,27 +469,6 @@ static int powernv_eeh_next_error(struct eeh_pe **pe)
 	return -EEXIST;
 }
 
-static int powernv_eeh_restore_config(struct device_node *dn)
-{
-	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
-	struct pnv_phb *phb;
-	s64 ret;
-
-	if (!edev)
-		return -EEXIST;
-
-	phb = edev->phb->private_data;
-	ret = opal_pci_reinit(phb->opal_id,
-			      OPAL_REINIT_PCI_DEV, edev->config_addr);
-	if (ret) {
-		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
-			__func__, edev->config_addr, ret);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static struct eeh_ops powernv_eeh_ops = {
 	.name                   = "powernv",
 	.init                   = powernv_eeh_init,
@@ -506,8 +485,7 @@ static struct eeh_ops powernv_eeh_ops = {
 	.err_inject		= powernv_eeh_err_inject,
 	.read_config            = powernv_eeh_read_config,
 	.write_config           = powernv_eeh_write_config,
-	.next_error		= powernv_eeh_next_error,
-	.restore_config		= powernv_eeh_restore_config
+	.next_error		= powernv_eeh_next_error
 };
 
 /**
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index feb549a..b6474a1 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -209,7 +209,6 @@ OPAL_CALL(opal_pci_reset,			OPAL_PCI_RESET);
 OPAL_CALL(opal_pci_get_hub_diag_data,		OPAL_PCI_GET_HUB_DIAG_DATA);
 OPAL_CALL(opal_pci_get_phb_diag_data,		OPAL_PCI_GET_PHB_DIAG_DATA);
 OPAL_CALL(opal_pci_fence_phb,			OPAL_PCI_FENCE_PHB);
-OPAL_CALL(opal_pci_reinit,			OPAL_PCI_REINIT);
 OPAL_CALL(opal_pci_mask_pe_error,		OPAL_PCI_MASK_PE_ERROR);
 OPAL_CALL(opal_set_slot_led_status,		OPAL_SET_SLOT_LED_STATUS);
 OPAL_CALL(opal_get_epow_status,			OPAL_GET_EPOW_STATUS);
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index a6c7e19..e69aff6 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -719,8 +719,7 @@ static struct eeh_ops pseries_eeh_ops = {
 	.err_inject		= NULL,
 	.read_config		= pseries_eeh_read_config,
 	.write_config		= pseries_eeh_write_config,
-	.next_error		= NULL,
-	.restore_config		= NULL
+	.next_error		= NULL
 };
 
 /**
-- 
1.8.3.2
