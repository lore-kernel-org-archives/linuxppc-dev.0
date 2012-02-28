Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 95DE1B6FF9
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:33 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 05:58:01 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S5wur13547338
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 16:58:56 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S64MSg019046
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:22 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 09/21] pSeries platform EEH reset PE
Date: Tue, 28 Feb 2012 14:03:59 +0800
Message-Id: <1330409051-8941-10-git-send-email-shangw@linux.vnet.ibm.com>
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

On RTAS compliant pSeries platform, there is a dedicated RTAS call
(ibm,set-slot-reset) to reset the specified PE. Furthermore, two
types of resets are supported: hot and fundamental. the type of
reset is to be used actually depends on the included PCI device's
requirements.

The patch implements resetting PE on pSeries platform through RTAS
call. Besides, it has been abstracted through struct eeh_ops::reset
so that EEH core components could support multiple platforms in future.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    3 +
 arch/powerpc/platforms/pseries/eeh.c         |   63 +++-----------------------
 arch/powerpc/platforms/pseries/eeh_pseries.c |   25 ++++++++++-
 3 files changed, 33 insertions(+), 58 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 1d3c9e5..894ea6c 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -49,6 +49,9 @@ struct device_node;
 #define EEH_STATE_DMA_ACTIVE	(1 << 4)	/* Active DMA		*/
 #define EEH_STATE_MMIO_ENABLED	(1 << 5)	/* MMIO enabled		*/
 #define EEH_STATE_DMA_ENABLED	(1 << 6)	/* DMA enabled		*/
+#define EEH_RESET_DEACTIVATE	0	/* Deactivate the PE reset	*/
+#define EEH_RESET_HOT		1	/* Hot reset			*/
+#define EEH_RESET_FUNDAMENTAL	3	/* Fundamental reset		*/
 
 struct eeh_ops {
 	char *name;
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index b5b03d4..4f329f5 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -87,7 +87,6 @@
 #define PCI_BUS_RESET_WAIT_MSEC (60*1000)
 
 /* RTAS tokens */
-static int ibm_set_slot_reset;
 static int ibm_slot_error_detail;
 static int ibm_configure_bridge;
 static int ibm_configure_pe;
@@ -607,54 +606,6 @@ int eeh_pci_enable(struct pci_dn *pdn, int function)
 }
 
 /**
- * eeh_slot_reset - Raises/Lowers the pci #RST line
- * @pdn: pci device node
- * @state: 1/0 to raise/lower the #RST
- *
- * Clear the EEH-frozen condition on a slot.  This routine
- * asserts the PCI #RST line if the 'state' argument is '1',
- * and drops the #RST line if 'state is '0'.  This routine is
- * safe to call in an interrupt context.
- */
-static void eeh_slot_reset(struct pci_dn *pdn, int state)
-{
-	int config_addr;
-	int rc;
-
-	BUG_ON(pdn==NULL);
-
-	if (!pdn->phb) {
-		printk(KERN_WARNING "EEH: in slot reset, device node %s has no phb\n",
-		        pdn->node->full_name);
-		return;
-	}
-
-	/* Use PE configuration address, if present */
-	config_addr = pdn->eeh_config_addr;
-	if (pdn->eeh_pe_config_addr)
-		config_addr = pdn->eeh_pe_config_addr;
-
-	rc = rtas_call(ibm_set_slot_reset, 4, 1, NULL,
-	               config_addr,
-	               BUID_HI(pdn->phb->buid),
-	               BUID_LO(pdn->phb->buid),
-	               state);
-
-	/* Fundamental-reset not supported on this PE, try hot-reset */
-	if (rc == -8 && state == 3) {
-		rc = rtas_call(ibm_set_slot_reset, 4, 1, NULL,
-			       config_addr,
-			       BUID_HI(pdn->phb->buid),
-			       BUID_LO(pdn->phb->buid), 1);
-		if (rc)
-			printk(KERN_WARNING
-				"EEH: Unable to reset the failed slot,"
-				" #RST=%d dn=%s\n",
-				rc, pdn->node->full_name);
-	}
-}
-
-/**
  * pcibios_set_pcie_slot_reset - Set PCI-E reset state
  * @dev: pci device struct
  * @state: reset state to enter
@@ -665,17 +616,16 @@ static void eeh_slot_reset(struct pci_dn *pdn, int state)
 int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
 {
 	struct device_node *dn = pci_device_to_OF_node(dev);
-	struct pci_dn *pdn = PCI_DN(dn);
 
 	switch (state) {
 	case pcie_deassert_reset:
-		eeh_slot_reset(pdn, 0);
+		eeh_ops->reset(dn, EEH_RESET_DEACTIVATE);
 		break;
 	case pcie_hot_reset:
-		eeh_slot_reset(pdn, 1);
+		eeh_ops->reset(dn, EEH_RESET_HOT);
 		break;
 	case pcie_warm_reset:
-		eeh_slot_reset(pdn, 3);
+		eeh_ops->reset(dn, EEH_RESET_FUNDAMENTAL);
 		break;
 	default:
 		return -EINVAL;
@@ -754,9 +704,9 @@ static void eeh_reset_pe_once(struct pci_dn *pdn)
 	eeh_set_pe_freset(pdn->node, &freset);
 
 	if (freset)
-		eeh_slot_reset(pdn, 3);
+		eeh_ops->reset(pdn->node, EEH_RESET_FUNDAMENTAL);
 	else
-		eeh_slot_reset(pdn, 1);
+		eeh_ops->reset(pdn->node, EEH_RESET_HOT);
 
 	/* The PCI bus requires that the reset be held high for at least
 	 * a 100 milliseconds. We wait a bit longer 'just in case'.
@@ -770,7 +720,7 @@ static void eeh_reset_pe_once(struct pci_dn *pdn)
 	 */
 	eeh_clear_slot(pdn->node, EEH_MODE_ISOLATED);
 
-	eeh_slot_reset(pdn, 0);
+	eeh_ops->reset(pdn->node, EEH_RESET_DEACTIVATE);
 
 	/* After a PCI slot has been reset, the PCI Express spec requires
 	 * a 1.5 second idle time for the bus to stabilize, before starting
@@ -1127,7 +1077,6 @@ void __init eeh_init(void)
 	if (np == NULL)
 		return;
 
-	ibm_set_slot_reset = rtas_token("ibm,set-slot-reset");
 	ibm_slot_error_detail = rtas_token("ibm,slot-error-detail");
 	ibm_configure_bridge = rtas_token("ibm,configure-bridge");
 	ibm_configure_pe = rtas_token("ibm,configure-pe");
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 7b60131..6643e06 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -318,7 +318,30 @@ static int pseries_eeh_get_state(struct device_node *dn, int *state)
  */
 static int pseries_eeh_reset(struct device_node *dn, int option)
 {
-	return 0;
+	struct pci_dn *pdn;
+	int config_addr;
+	int ret;
+
+	/* Figure out PE address */
+	pdn = PCI_DN(dn);
+	config_addr = pdn->eeh_config_addr;
+	if (pdn->eeh_pe_config_addr)
+		config_addr = pdn->eeh_pe_config_addr;
+
+	/* Reset PE through RTAS call */
+	ret = rtas_call(ibm_set_slot_reset, 4, 1, NULL,
+			config_addr, BUID_HI(pdn->phb->buid),
+			BUID_LO(pdn->phb->buid), option);
+
+	/* If fundamental-reset not supported, try hot-reset */
+	if (option == EEH_RESET_FUNDAMENTAL &&
+	    ret == -8) {
+		ret = rtas_call(ibm_set_slot_reset, 4, 1, NULL,
+				config_addr, BUID_HI(pdn->phb->buid),
+				BUID_LO(pdn->phb->buid), EEH_RESET_HOT);
+	}
+
+	return ret;
 }
 
 /**
-- 
1.7.5.4
