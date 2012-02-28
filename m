Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AE0F8B701B
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:43 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 06:02:21 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S5x3NM3391546
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 16:59:03 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S64T4r019254
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:29 +1100
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 19/21] Replace pci_dn with eeh_dev for EEH on pSeries
Date: Tue, 28 Feb 2012 14:04:09 +0800
Message-Id: <1330409051-8941-20-git-send-email-shangw@linux.vnet.ibm.com>
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

The pci_dn has been replaced with eeh_dev. In order to comply with
the rule, the EEH platform implementation on pSeries should also
be adjusted for a little bit so that it will depend on eeh_dev instead
of pci_dn.

The patch replaces pci_dn with eeh_dev. The corresponding information
will be retrieved from eeh_dev instead of pci_dn.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c |   96 +++++++++++++-------------
 1 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 4ed06b2..36a1af1 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -144,11 +144,11 @@ static int pseries_eeh_init(void)
 static int pseries_eeh_set_option(struct device_node *dn, int option)
 {
 	int ret = 0;
-	struct pci_dn *pdn;
+	struct eeh_dev *edev;
 	const u32 *reg;
 	int config_addr;
 
-	pdn = PCI_DN(dn);
+	edev = of_node_to_eeh_dev(dn);
 
 	/*
 	 * When we're enabling or disabling EEH functioality on
@@ -165,9 +165,9 @@ static int pseries_eeh_set_option(struct device_node *dn, int option)
 
 	case EEH_OPT_THAW_MMIO:
 	case EEH_OPT_THAW_DMA:
-		config_addr = pdn->eeh_config_addr;
-		if (pdn->eeh_pe_config_addr)
-			config_addr = pdn->eeh_pe_config_addr;
+		config_addr = edev->config_addr;
+		if (edev->pe_config_addr)
+			config_addr = edev->pe_config_addr;
 		break;
 
 	default:
@@ -177,8 +177,8 @@ static int pseries_eeh_set_option(struct device_node *dn, int option)
 	}
 
 	ret = rtas_call(ibm_set_eeh_option, 4, 1, NULL,
-			config_addr, BUID_HI(pdn->phb->buid),
-			BUID_LO(pdn->phb->buid), option);
+			config_addr, BUID_HI(edev->phb->buid),
+			BUID_LO(edev->phb->buid), option);
 
 	return ret;
 }
@@ -198,11 +198,11 @@ static int pseries_eeh_set_option(struct device_node *dn, int option)
  */
 static int pseries_eeh_get_pe_addr(struct device_node *dn)
 {
-	struct pci_dn *pdn;
+	struct eeh_dev *edev;
 	int ret = 0;
 	int rets[3];
 
-	pdn = PCI_DN(dn);
+	edev = of_node_to_eeh_dev(dn);
 
 	if (ibm_get_config_addr_info2 != RTAS_UNKNOWN_SERVICE) {
 		/*
@@ -211,15 +211,15 @@ static int pseries_eeh_get_pe_addr(struct device_node *dn)
 		 * meaningless.
 		 */
 		ret = rtas_call(ibm_get_config_addr_info2, 4, 2, rets,
-				pdn->eeh_config_addr, BUID_HI(pdn->phb->buid),
-				BUID_LO(pdn->phb->buid), 1);
+				edev->config_addr, BUID_HI(edev->phb->buid),
+				BUID_LO(edev->phb->buid), 1);
 		if (ret || (rets[0] == 0))
 			return 0;
 
 		/* Retrieve the associated PE config address */
 		ret = rtas_call(ibm_get_config_addr_info2, 4, 2, rets,
-				pdn->eeh_config_addr, BUID_HI(pdn->phb->buid),
-				BUID_LO(pdn->phb->buid), 0);
+				edev->config_addr, BUID_HI(edev->phb->buid),
+				BUID_LO(edev->phb->buid), 0);
 		if (ret) {
 			pr_warning("%s: Failed to get PE address for %s\n",
 				__func__, dn->full_name);
@@ -231,8 +231,8 @@ static int pseries_eeh_get_pe_addr(struct device_node *dn)
 
 	if (ibm_get_config_addr_info != RTAS_UNKNOWN_SERVICE) {
 		ret = rtas_call(ibm_get_config_addr_info, 4, 2, rets,
-				pdn->eeh_config_addr, BUID_HI(pdn->phb->buid),
-				BUID_LO(pdn->phb->buid), 0);
+				edev->config_addr, BUID_HI(edev->phb->buid),
+				BUID_LO(edev->phb->buid), 0);
 		if (ret) {
 			pr_warning("%s: Failed to get PE address for %s\n",
 				__func__, dn->full_name);
@@ -260,28 +260,28 @@ static int pseries_eeh_get_pe_addr(struct device_node *dn)
  */
 static int pseries_eeh_get_state(struct device_node *dn, int *state)
 {
-	struct pci_dn *pdn;
+	struct eeh_dev *edev;
 	int config_addr;
 	int ret;
 	int rets[4];
 	int result;
 
 	/* Figure out PE config address if possible */
-	pdn = PCI_DN(dn);
-	config_addr = pdn->eeh_config_addr;
-	if (pdn->eeh_pe_config_addr)
-		config_addr = pdn->eeh_pe_config_addr;
+	edev = of_node_to_eeh_dev(dn);
+	config_addr = edev->config_addr;
+	if (edev->pe_config_addr)
+		config_addr = edev->pe_config_addr;
 
 	if (ibm_read_slot_reset_state2 != RTAS_UNKNOWN_SERVICE) {
 		ret = rtas_call(ibm_read_slot_reset_state2, 3, 4, rets,
-				config_addr, BUID_HI(pdn->phb->buid),
-				BUID_LO(pdn->phb->buid));
+				config_addr, BUID_HI(edev->phb->buid),
+				BUID_LO(edev->phb->buid));
 	} else if (ibm_read_slot_reset_state != RTAS_UNKNOWN_SERVICE) {
 		/* Fake PE unavailable info */
 		rets[2] = 0;
 		ret = rtas_call(ibm_read_slot_reset_state, 3, 3, rets,
-				config_addr, BUID_HI(pdn->phb->buid),
-				BUID_LO(pdn->phb->buid));
+				config_addr, BUID_HI(edev->phb->buid),
+				BUID_LO(edev->phb->buid));
 	} else {
 		return EEH_STATE_NOT_SUPPORT;
 	}
@@ -340,27 +340,27 @@ static int pseries_eeh_get_state(struct device_node *dn, int *state)
  */
 static int pseries_eeh_reset(struct device_node *dn, int option)
 {
-	struct pci_dn *pdn;
+	struct eeh_dev *edev;
 	int config_addr;
 	int ret;
 
 	/* Figure out PE address */
-	pdn = PCI_DN(dn);
-	config_addr = pdn->eeh_config_addr;
-	if (pdn->eeh_pe_config_addr)
-		config_addr = pdn->eeh_pe_config_addr;
+	edev = of_node_to_eeh_dev(dn);
+	config_addr = edev->config_addr;
+	if (edev->pe_config_addr)
+		config_addr = edev->pe_config_addr;
 
 	/* Reset PE through RTAS call */
 	ret = rtas_call(ibm_set_slot_reset, 4, 1, NULL,
-			config_addr, BUID_HI(pdn->phb->buid),
-			BUID_LO(pdn->phb->buid), option);
+			config_addr, BUID_HI(edev->phb->buid),
+			BUID_LO(edev->phb->buid), option);
 
 	/* If fundamental-reset not supported, try hot-reset */
 	if (option == EEH_RESET_FUNDAMENTAL &&
 	    ret == -8) {
 		ret = rtas_call(ibm_set_slot_reset, 4, 1, NULL,
-				config_addr, BUID_HI(pdn->phb->buid),
-				BUID_LO(pdn->phb->buid), EEH_RESET_HOT);
+				config_addr, BUID_HI(edev->phb->buid),
+				BUID_LO(edev->phb->buid), EEH_RESET_HOT);
 	}
 
 	return ret;
@@ -437,22 +437,22 @@ static int pseries_eeh_wait_state(struct device_node *dn, int max_wait)
  */
 static int pseries_eeh_get_log(struct device_node *dn, int severity, char *drv_log, unsigned long len)
 {
-	struct pci_dn *pdn;
+	struct eeh_dev *edev;
 	int config_addr;
 	unsigned long flags;
 	int ret;
 
-	pdn = PCI_DN(dn);
+	edev = of_node_to_eeh_dev(dn);
 	spin_lock_irqsave(&slot_errbuf_lock, flags);
 	memset(slot_errbuf, 0, eeh_error_buf_size);
 
 	/* Figure out the PE address */
-	config_addr = pdn->eeh_config_addr;
-	if (pdn->eeh_pe_config_addr)
-		config_addr = pdn->eeh_pe_config_addr;
+	config_addr = edev->config_addr;
+	if (edev->pe_config_addr)
+		config_addr = edev->pe_config_addr;
 
 	ret = rtas_call(ibm_slot_error_detail, 8, 1, NULL, config_addr,
-			BUID_HI(pdn->phb->buid), BUID_LO(pdn->phb->buid),
+			BUID_HI(edev->phb->buid), BUID_LO(edev->phb->buid),
 			virt_to_phys(drv_log), len,
 			virt_to_phys(slot_errbuf), eeh_error_buf_size,
 			severity);
@@ -473,25 +473,25 @@ static int pseries_eeh_get_log(struct device_node *dn, int severity, char *drv_l
  */
 static int pseries_eeh_configure_bridge(struct device_node *dn)
 {
-	struct pci_dn *pdn;
+	struct eeh_dev *edev;
 	int config_addr;
 	int ret;
 
 	/* Figure out the PE address */
-	pdn = PCI_DN(dn);
-	config_addr = pdn->eeh_config_addr;
-	if (pdn->eeh_pe_config_addr)
-		config_addr = pdn->eeh_pe_config_addr;
+	edev = of_node_to_eeh_dev(dn);
+	config_addr = edev->config_addr;
+	if (edev->pe_config_addr)
+		config_addr = edev->pe_config_addr;
 
 	/* Use new configure-pe function, if supported */
 	if (ibm_configure_pe != RTAS_UNKNOWN_SERVICE) {
 		ret = rtas_call(ibm_configure_pe, 3, 1, NULL,
-				config_addr, BUID_HI(pdn->phb->buid),
-				BUID_LO(pdn->phb->buid));
+				config_addr, BUID_HI(edev->phb->buid),
+				BUID_LO(edev->phb->buid));
 	} else if (ibm_configure_bridge != RTAS_UNKNOWN_SERVICE) {
 		ret = rtas_call(ibm_configure_bridge, 3, 1, NULL,
-				config_addr, BUID_HI(pdn->phb->buid),
-				BUID_LO(pdn->phb->buid));
+				config_addr, BUID_HI(edev->phb->buid),
+				BUID_LO(edev->phb->buid));
 	} else {
 		return -EFAULT;
 	}
-- 
1.7.5.4
