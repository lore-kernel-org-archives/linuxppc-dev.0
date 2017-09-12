Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xsJLV0vwCzDrJc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 07:47:45 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v8CLhvvk091629
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 17:47:44 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cxhmt2rk1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Sep 2017 17:47:44 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 12 Sep 2017 15:47:43 -0600
To: linuxppc-dev@lists.ozlabs.org
Cc: nfont@linux.vnet.ibm.com,
 Michael Bringmann from Kernel Team <mbringm@us.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V3 3/4] hotplug/drc-info: Add code to search ibm,drc-info
 property
In-Reply-To: <531bfd59-97ed-0ea9-0a93-dea7eb415b77@linux.vnet.ibm.com>
Date: Tue, 12 Sep 2017 16:47:40 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <23a8b0e3-97ed-e8a1-d54a-cc47294cddd8@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

rpadlpar_core.c: Provide parallel routines to search the older device-
tree properties ("ibm,drc-indexes", "ibm,drc-names", "ibm,drc-types"
and "ibm,drc-power-domains"), or the new property "ibm,drc-info".

The interface to examine the DRC information is changed from a "get"
function that returns values for local verification elsewhere, to a
"check" function that validates the 'name' and/or 'type' of a device
node.  This update hides the format of the underlying device-tree
properties, and concentrates the value checks into a single function
without requiring the user to verify whether a search was successful.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
Changes in V3:
  -- Some code compression and passing values by structure
---
 drivers/pci/hotplug/rpadlpar_core.c |   13 ++--
 drivers/pci/hotplug/rpaphp.h        |    4 +
 drivers/pci/hotplug/rpaphp_core.c   |  110 +++++++++++++++++++++++++++--------
 3 files changed, 92 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 3f93a4e..e6924de 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -27,6 +27,7 @@
 #include <linux/mutex.h>
 #include <asm/rtas.h>
 #include <asm/vio.h>
+#include <linux/firmware.h>
 
 #include "../pci.h"
 #include "rpaphp.h"
@@ -44,15 +45,14 @@ static struct device_node *find_vio_slot_node(char *drc_name)
 {
 	struct device_node *parent = of_find_node_by_name(NULL, "vdevice");
 	struct device_node *dn = NULL;
-	char *name;
 	int rc;
 
 	if (!parent)
 		return NULL;
 
 	while ((dn = of_get_next_child(parent, dn))) {
-		rc = rpaphp_get_drc_props(dn, NULL, &name, NULL, NULL);
-		if ((rc == 0) && (!strcmp(drc_name, name)))
+		rc = rpaphp_check_drc_props(dn, drc_name, NULL);
+		if (rc == 0)
 			break;
 	}
 
@@ -64,15 +64,12 @@ static struct device_node *find_php_slot_pci_node(char *drc_name,
 						  char *drc_type)
 {
 	struct device_node *np = NULL;
-	char *name;
-	char *type;
 	int rc;
 
 	while ((np = of_find_node_by_name(np, "pci"))) {
-		rc = rpaphp_get_drc_props(np, NULL, &name, &type, NULL);
+		rc = rpaphp_check_drc_props(np, drc_name, drc_type);
 		if (rc == 0)
-			if (!strcmp(drc_name, name) && !strcmp(drc_type, type))
-				break;
+			break;
 	}
 
 	return np;
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index 7db024e..8db5f2e 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -91,8 +91,8 @@ struct slot {
 
 /* rpaphp_core.c */
 int rpaphp_add_slot(struct device_node *dn);
-int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
-		char **drc_name, char **drc_type, int *drc_power_domain);
+int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
+		char *drc_type);
 
 /* rpaphp_slot.c */
 void dealloc_slot_struct(struct slot *slot);
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 8d13202..0587dd4 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -30,6 +30,7 @@
 #include <linux/smp.h>
 #include <linux/init.h>
 #include <linux/vmalloc.h>
+#include <asm/firmware.h>
 #include <asm/eeh.h>       /* for eeh_add_device() */
 #include <asm/rtas.h>		/* rtas_call */
 #include <asm/pci-bridge.h>	/* for pci_controller */
@@ -196,25 +197,21 @@ static int get_children_props(struct device_node *dn, const int **drc_indexes,
 	return 0;
 }
 
-/* To get the DRC props describing the current node, first obtain it's
- * my-drc-index property.  Next obtain the DRC list from it's parent.  Use
- * the my-drc-index for correlation, and obtain the requested properties.
+
+/* Verify the existence of 'drc_name' and/or 'drc_type' within the
+ * current node.  First obtain it's my-drc-index property.  Next,
+ * obtain the DRC info from it's parent.  Use the my-drc-index for
+ * correlation, and obtain/validate the requested properties.
  */
-int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
-		char **drc_name, char **drc_type, int *drc_power_domain)
+
+static int rpaphp_check_drc_props_v1(struct device_node *dn, char *drc_name,
+				char *drc_type, unsigned int my_index)
 {
+	char *name_tmp, *type_tmp;
 	const int *indexes, *names;
 	const int *types, *domains;
-	const unsigned int *my_index;
-	char *name_tmp, *type_tmp;
 	int i, rc;
 
-	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
-	if (!my_index) {
-		/* Node isn't DLPAR/hotplug capable */
-		return -EINVAL;
-	}
-
 	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
 	if (rc < 0) {
 		return -EINVAL;
@@ -225,24 +222,87 @@ int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
 
 	/* Iterate through parent properties, looking for my-drc-index */
 	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
-		if ((unsigned int) indexes[i + 1] == *my_index) {
-			if (drc_name)
-				*drc_name = name_tmp;
-			if (drc_type)
-				*drc_type = type_tmp;
-			if (drc_index)
-				*drc_index = be32_to_cpu(*my_index);
-			if (drc_power_domain)
-				*drc_power_domain = be32_to_cpu(domains[i+1]);
-			return 0;
-		}
+		if ((unsigned int) indexes[i + 1] == my_index)
+			break;
+
 		name_tmp += (strlen(name_tmp) + 1);
 		type_tmp += (strlen(type_tmp) + 1);
 	}
 
+	if (((drc_name == NULL) || (drc_name && !strcmp(drc_name, name_tmp))) &&
+	    ((drc_type == NULL) || (drc_type && !strcmp(drc_type, type_tmp))))
+		return 0;
+
+	return -EINVAL;
+}
+
+static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
+				char *drc_type, unsigned int my_index)
+{
+	struct property *info;
+	unsigned int entries;
+	struct of_drc_info drc;
+	void *value;
+	int j;
+
+	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
+	if (info == NULL)
+		return -EINVAL;
+
+	value = info->value;
+	value = (void *)of_prop_next_u32(info, value, &entries);
+	if (!value)
+		return -EINVAL;
+
+	for (j = 0; j < entries; j++) {
+		of_one_drc_info(&info, &value, &drc);
+
+		/* Should now know end of current entry */
+
+		WARN_ON((my_index < drc.drc_index_start) ||
+			(((my_index-drc.drc_index_start)%
+				drc.sequential_inc) != 0));
+
+		if (my_index > drc.last_drc_index)
+			continue;
+
+		break;
+	}
+	/* Found it */
+
+	if (((drc_name == NULL) ||
+	     (drc_name && !strncmp(drc_name,
+				drc.drc_name_prefix,
+				strlen(drc.drc_name_prefix)))) &&
+	    ((drc_type == NULL) ||
+	     (drc_type && !strncmp(drc_type,
+				drc.drc_type,
+				strlen(drc.drc_type)))))
+		return 0;
+
 	return -EINVAL;
 }
-EXPORT_SYMBOL_GPL(rpaphp_get_drc_props);
+
+int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
+			char *drc_type)
+{
+	const unsigned int *my_index;
+
+	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
+	if (!my_index) {
+		/* Node isn't DLPAR/hotplug capable */
+		return -EINVAL;
+	}
+
+	if (firmware_has_feature(FW_FEATURE_DRC_INFO))
+		return rpaphp_check_drc_props_v2(dn, drc_name, drc_type,
+						*my_index);
+	else
+		return rpaphp_check_drc_props_v1(dn, drc_name, drc_type,
+						*my_index);
+}
+EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
+
 
 static int is_php_type(char *drc_type)
 {
