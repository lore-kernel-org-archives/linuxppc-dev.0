Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7F59EB6FD5
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 17:04:31 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 11:34:24 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S64Kug4436200
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 11:34:20 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S64KjX005415
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 11:34:20 +0530
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/21] pSeries platform EEH PE address retrieval
Date: Tue, 28 Feb 2012 14:03:56 +0800
Message-Id: <1330409051-8941-7-git-send-email-shangw@linux.vnet.ibm.com>
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

There're 2 types of addresses used for EEH operations. The first
one would be BDF (Bus/Device/Function) address which is retrieved
from the reg property of the corresponding FDT node. Another one
is PE address that should be enquired from firmware through RTAS
call on pSeries platform. When issuing EEH operation, the PE address
has precedence over BDF address.

The patch implements retrieving PE address according to the given
BDF address on pSeries platform. Also, the struct eeh_early_enable_info
has been removed since the information can be figured out from
dn->pdn->phb->buid directly and that simplifies the code.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh.c         |   67 +------------------------
 arch/powerpc/platforms/pseries/eeh_pseries.c |   46 +++++++++++++++++-
 2 files changed, 48 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 70a9617..00797e0 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -91,8 +91,6 @@ static int ibm_set_slot_reset;
 static int ibm_read_slot_reset_state;
 static int ibm_read_slot_reset_state2;
 static int ibm_slot_error_detail;
-static int ibm_get_config_addr_info;
-static int ibm_get_config_addr_info2;
 static int ibm_configure_bridge;
 static int ibm_configure_pe;
 
@@ -1048,56 +1046,6 @@ void eeh_configure_bridge(struct pci_dn *pdn)
 	}
 }
 
-#define EEH_ENABLE 1
-
-struct eeh_early_enable_info {
-	unsigned int buid_hi;
-	unsigned int buid_lo;
-};
-
-/**
- * eeh_get_pe_addr - Retrieve PE address with given BDF address
- * @config_addr: BDF address
- * @info: BUID of the associated PHB
- *
- * There're 2 kinds of addresses existing in EEH core components:
- * BDF address and PE address. Besides, there has dedicated platform
- * dependent function call to retrieve the PE address according to
- * the given BDF address. Further more, we prefer PE address on BDF
- * address in EEH core components.
- */
-static int eeh_get_pe_addr(int config_addr,
-                        struct eeh_early_enable_info *info)
-{
-	unsigned int rets[3];
-	int ret;
-
-	/* Use latest config-addr token on power6 */
-	if (ibm_get_config_addr_info2 != RTAS_UNKNOWN_SERVICE) {
-		/* Make sure we have a PE in hand */
-		ret = rtas_call(ibm_get_config_addr_info2, 4, 2, rets,
-			config_addr, info->buid_hi, info->buid_lo, 1);
-		if (ret || (rets[0]==0))
-			return 0;
-
-		ret = rtas_call(ibm_get_config_addr_info2, 4, 2, rets,
-			config_addr, info->buid_hi, info->buid_lo, 0);
-		if (ret)
-			return 0;
-		return rets[0];
-	}
-
-	/* Use older config-addr token on power5 */
-	if (ibm_get_config_addr_info != RTAS_UNKNOWN_SERVICE) {
-		ret = rtas_call(ibm_get_config_addr_info, 4, 2, rets,
-			config_addr, info->buid_hi, info->buid_lo, 0);
-		if (ret)
-			return 0;
-		return rets[0];
-	}
-	return 0;
-}
-
 /**
  * eeh_early_enable - Early enable EEH on the indicated device
  * @dn: device node
@@ -1110,7 +1058,6 @@ static int eeh_get_pe_addr(int config_addr,
 static void *eeh_early_enable(struct device_node *dn, void *data)
 {
 	unsigned int rets[3];
-	struct eeh_early_enable_info *info = data;
 	int ret;
 	const u32 *class_code = of_get_property(dn, "class-code", NULL);
 	const u32 *vendor_id = of_get_property(dn, "vendor-id", NULL);
@@ -1155,7 +1102,7 @@ static void *eeh_early_enable(struct device_node *dn, void *data)
 			/* If the newer, better, ibm,get-config-addr-info is supported, 
 			 * then use that instead.
 			 */
-			pdn->eeh_pe_config_addr = eeh_get_pe_addr(pdn->eeh_config_addr, info);
+			pdn->eeh_pe_config_addr = eeh_ops->get_pe_addr(dn);
 
 			/* Some older systems (Power4) allow the
 			 * ibm,set-eeh-option call to succeed even on nodes
@@ -1264,7 +1211,6 @@ int __exit eeh_ops_unregister(const char *name)
 void __init eeh_init(void)
 {
 	struct device_node *phb, *np;
-	struct eeh_early_enable_info info;
 	int ret;
 
 	/* call platform initialization function */
@@ -1289,8 +1235,6 @@ void __init eeh_init(void)
 	ibm_read_slot_reset_state2 = rtas_token("ibm,read-slot-reset-state2");
 	ibm_read_slot_reset_state = rtas_token("ibm,read-slot-reset-state");
 	ibm_slot_error_detail = rtas_token("ibm,slot-error-detail");
-	ibm_get_config_addr_info = rtas_token("ibm,get-config-addr-info");
-	ibm_get_config_addr_info2 = rtas_token("ibm,get-config-addr-info2");
 	ibm_configure_bridge = rtas_token("ibm,configure-bridge");
 	ibm_configure_pe = rtas_token("ibm,configure-pe");
 
@@ -1313,9 +1257,7 @@ void __init eeh_init(void)
 		if (buid == 0 || PCI_DN(phb) == NULL)
 			continue;
 
-		info.buid_lo = BUID_LO(buid);
-		info.buid_hi = BUID_HI(buid);
-		traverse_pci_devices(phb, eeh_early_enable, &info);
+		traverse_pci_devices(phb, eeh_early_enable, NULL);
 	}
 
 	if (eeh_subsystem_enabled)
@@ -1339,7 +1281,6 @@ void __init eeh_init(void)
 static void eeh_add_device_early(struct device_node *dn)
 {
 	struct pci_controller *phb;
-	struct eeh_early_enable_info info;
 
 	if (!dn || !PCI_DN(dn))
 		return;
@@ -1349,9 +1290,7 @@ static void eeh_add_device_early(struct device_node *dn)
 	if (NULL == phb || 0 == phb->buid)
 		return;
 
-	info.buid_hi = BUID_HI(phb->buid);
-	info.buid_lo = BUID_LO(phb->buid);
-	eeh_early_enable(dn, &info);
+	eeh_early_enable(dn, NULL);
 }
 
 /**
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index c48a9e6..2b9543a 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -176,7 +176,51 @@ static int pseries_eeh_set_option(struct device_node *dn, int option)
  */
 static int pseries_eeh_get_pe_addr(struct device_node *dn)
 {
-	return 0;
+	struct pci_dn *pdn;
+	int ret = 0;
+	int rets[3];
+
+	pdn = PCI_DN(dn);
+
+	if (ibm_get_config_addr_info2 != RTAS_UNKNOWN_SERVICE) {
+		/*
+		 * First of all, we need to make sure there has one PE
+		 * associated with the device. Otherwise, PE address is
+		 * meaningless.
+		 */
+		ret = rtas_call(ibm_get_config_addr_info2, 4, 2, rets,
+				pdn->eeh_config_addr, BUID_HI(pdn->phb->buid),
+				BUID_LO(pdn->phb->buid), 1);
+		if (ret || (rets[0] == 0))
+			return 0;
+
+		/* Retrieve the associated PE config address */
+		ret = rtas_call(ibm_get_config_addr_info2, 4, 2, rets,
+				pdn->eeh_config_addr, BUID_HI(pdn->phb->buid),
+				BUID_LO(pdn->phb->buid), 0);
+		if (ret) {
+			pr_warning("%s: Failed to get PE address for %s\n",
+				__func__, dn->full_name);
+			return 0;
+		}
+
+		return rets[0];
+	}
+
+	if (ibm_get_config_addr_info != RTAS_UNKNOWN_SERVICE) {
+		ret = rtas_call(ibm_get_config_addr_info, 4, 2, rets,
+				pdn->eeh_config_addr, BUID_HI(pdn->phb->buid),
+				BUID_LO(pdn->phb->buid), 0);
+		if (ret) {
+			pr_warning("%s: Failed to get PE address for %s\n",
+				__func__, dn->full_name);
+			return 0;
+		}
+
+		return rets[0];
+	}
+
+	return ret;
 }
 
 /**
-- 
1.7.5.4
