Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e32.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6B87B2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 15:55:32 +1000 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 24 Jun 2013 23:55:29 -0600
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
 [9.17.195.228])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 5CEEF19D8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 23:55:18 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5P5tRbt150560
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 23:55:27 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5P5tPqM003627
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 23:55:26 -0600
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/10] powerpc/powernv: Support set/get EEH settings
Date: Tue, 25 Jun 2013 13:55:12 +0800
Message-Id: <1372139717-14885-6-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372139717-14885-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch implements PowerNV backends to support set/get settings.
Also, we needn't maintain multiple fields in "struct pnv_phb" to
trace different EEH states. The patch merges all EEH states to one
field "eeh_state".

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/eeh-ioda.c    |   82 ++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/eeh-powernv.c |   34 +++++++++++
 arch/powerpc/platforms/powernv/pci.c         |    4 +-
 arch/powerpc/platforms/powernv/pci.h         |   12 +++-
 4 files changed, 124 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
index 84f3036..64c3d1e 100644
--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
@@ -132,7 +132,7 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
 					    &ioda_eeh_dbgfs_ops);
 #endif
 
-		phb->eeh_enabled = 1;
+		phb->eeh_state |= PNV_EEH_STATE_ENABLED;
 	}
 
 	return 0;
@@ -583,6 +583,78 @@ static int ioda_eeh_configure_bridge(struct eeh_pe *pe)
 	return 0;
 }
 
+/**
+ * ioda_eeh_set_setting - Configure the settings to affect EEH core
+ * @option: option
+ * @value: value
+ * @data: dependent data
+ *
+ * Configure the settings to affect EEH core.
+ */
+static int ioda_eeh_set_setting(int option, int value, void *data)
+{
+	struct pci_controller *hose = (struct pci_controller *)data;
+	struct pnv_phb *phb = hose->private_data;
+	int ret = 0;
+
+	switch (option) {
+	case EEH_SETTING_BLOCK_CFG:
+		if (value)
+			phb->eeh_state |= PNV_EEH_STATE_CFG_BLOCKED;
+		else
+			phb->eeh_state &= ~PNV_EEH_STATE_CFG_BLOCKED;
+		break;
+	case EEH_SETTING_BLOCK_IO:
+		if (value)
+			phb->eeh_state |= PNV_EEH_STATE_IO_BLOCKED;
+		else
+			phb->eeh_state &= ~PNV_EEH_STATE_IO_BLOCKED;
+		break;
+	default:
+		pr_warning("%s: Unrecognized option (%d)\n",
+			   __func__, option);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
+ * ioda_eeh_get_setting - Retrieve the settings to affect EEH core
+ * @option: option
+ * @value: value
+ * @data: dependent data
+ *
+ * EEH core retrieves the settings and utilize them.
+ */
+static int ioda_eeh_get_setting(int option, int *value, void *data)
+{
+	struct pci_controller *hose = (struct pci_controller *)data;
+	struct pnv_phb *phb = hose->private_data;
+	int ret = 0;
+
+	switch (option) {
+	case EEH_SETTING_BLOCK_CFG:
+		if (phb->eeh_state & PNV_EEH_STATE_CFG_BLOCKED)
+			*value = 1;
+		else
+			*value = 0;
+		break;
+	case EEH_SETTING_BLOCK_IO:
+		if (phb->eeh_state & PNV_EEH_STATE_IO_BLOCKED)
+			*value = 1;
+		else
+			*value = 0;
+		break;
+	default:
+		pr_warning("%s: Unrecognized option (%d)\n",
+			   __func__, option);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
 static void ioda_eeh_hub_diag_common(struct OpalIoP7IOCErrorData *data)
 {
 	/* GEM */
@@ -815,7 +887,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 		 * removed, we needn't take care of it any more.
 		 */
 		phb = hose->private_data;
-		if (phb->removed)
+		if (phb->eeh_state & PNV_EEH_STATE_REMOVED)
 			continue;
 
 		rc = opal_pci_next_error(phb->opal_id,
@@ -850,7 +922,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 				list_for_each_entry_safe(hose, tmp,
 						&hose_list, list_node) {
 					phb = hose->private_data;
-					phb->removed = 1;
+					phb->eeh_state |= PNV_EEH_STATE_REMOVED;
 				}
 
 				WARN(1, "EEH: dead IOC detected\n");
@@ -867,7 +939,7 @@ static int ioda_eeh_next_error(struct eeh_pe **pe)
 
 				WARN(1, "EEH: dead PHB#%x detected\n",
 				     hose->global_number);
-				phb->removed = 1;
+				phb->eeh_state |= PNV_EEH_STATE_REMOVED;
 				ret = 3;
 				goto out;
 			} else if (severity == OPAL_EEH_SEV_PHB_FENCED) {
@@ -905,5 +977,7 @@ struct pnv_eeh_ops ioda_eeh_ops = {
 	.reset			= ioda_eeh_reset,
 	.get_log		= ioda_eeh_get_log,
 	.configure_bridge	= ioda_eeh_configure_bridge,
+	.set_setting		= ioda_eeh_set_setting,
+	.get_setting		= ioda_eeh_get_setting,
 	.next_error		= ioda_eeh_next_error
 };
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 9559115..cac5e18 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -355,6 +355,38 @@ static int powernv_eeh_write_config(struct device_node *dn, int where,
 }
 
 /**
+ * powernv_eeh_set_setting - Configure setting to affect EEH core
+ * @option: option
+ * @value: value
+ * @data: option dependent data
+ *
+ * Configure setting to affect the behaviour of EEH core.
+ */
+static int powernv_eeh_set_setting(int option, int value, void *data)
+{
+	struct pci_controller *hose = data;
+	struct pnv_phb *phb = hose->private_data;
+
+	return phb->set_setting(option, value, data);
+}
+
+/**
+ * powernv_eeh_get_setting - Retrieve settings to affect EEH core
+ * @option: option
+ * @value: value
+ * @data: option dependent data
+ *
+ * Retrieve setting to affect the behaviour of EEH core
+ */
+static int powernv_eeh_get_setting(int option, int *value, void *data)
+{
+	struct pci_controller *hose = data;
+	struct pnv_phb *phb = hose->private_data;
+
+	return phb->get_setting(option, value, data);
+}
+
+/**
  * powernv_eeh_next_error - Retrieve next EEH error to handle
  * @pe: Affected PE
  *
@@ -391,6 +423,8 @@ static struct eeh_ops powernv_eeh_ops = {
 	.configure_bridge       = powernv_eeh_configure_bridge,
 	.read_config            = powernv_eeh_read_config,
 	.write_config           = powernv_eeh_write_config,
+	.set_setting		= powernv_eeh_set_setting,
+	.get_setting		= powernv_eeh_get_setting,
 	.next_error		= powernv_eeh_next_error
 };
 
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 6d9a506..1f31826 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -308,7 +308,7 @@ static int pnv_pci_read_config(struct pci_bus *bus,
 	if (phb_pe && (phb_pe->state & EEH_PE_ISOLATED))
 		return PCIBIOS_SUCCESSFUL;
 
-	if (phb->eeh_enabled) {
+	if (phb->eeh_state & PNV_EEH_STATE_ENABLED) {
 		if (*val == EEH_IO_ERROR_VALUE(size)) {
 			busdn = pci_bus_to_OF_node(bus);
 			for (dn = busdn->child; dn; dn = dn->sibling) {
@@ -358,7 +358,7 @@ static int pnv_pci_write_config(struct pci_bus *bus,
 
 	/* Check if the PHB got frozen due to an error (no response) */
 #ifdef CONFIG_EEH
-	if (!phb->eeh_enabled)
+	if (!(phb->eeh_state & PNV_EEH_STATE_ENABLED))
 		pnv_pci_config_check_eeh(phb, bus, bdfn);
 #else
 	pnv_pci_config_check_eeh(phb, bus, bdfn);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 43906e3..a281a1c 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -76,8 +76,17 @@ struct pnv_eeh_ops {
 	int (*get_log)(struct eeh_pe *pe, int severity,
 		       char *drv_log, unsigned long len);
 	int (*configure_bridge)(struct eeh_pe *pe);
+	int (*set_setting)(int option, int value, void *data);
+	int (*get_setting)(int option, int *value, void *data);
 	int (*next_error)(struct eeh_pe **pe);
 };
+
+/* EEH states maintained by PCI hose */
+#define PNV_EEH_STATE_ENABLED		(1 << 0)	/* EEH enabled	*/
+#define PNV_EEH_STATE_REMOVED		(1 << 1)	/* PHB removed	*/
+#define PNV_EEH_STATE_CFG_BLOCKED	(1 << 2)	/* PHB PCI-CFG blocked */
+#define PNV_EEH_STATE_IO_BLOCKED	(1 << 3)	/* PHB MMIO blocked */
+
 #endif /* CONFIG_EEH */
 
 struct pnv_phb {
@@ -92,8 +101,7 @@ struct pnv_phb {
 
 #ifdef CONFIG_EEH
 	struct pnv_eeh_ops	*eeh_ops;
-	int			eeh_enabled;
-	int			removed;
+	int			eeh_state;
 #endif
 
 #ifdef CONFIG_DEBUG_FS
-- 
1.7.5.4
