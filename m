Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydC7y2gkCzDrJP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 07:11:58 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAGKARgH056397
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 15:11:56 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e9gwm9rwy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Nov 2017 15:11:55 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Thu, 16 Nov 2017 13:11:55 -0700
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>, nfont@linux.vnet.ibm.com
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: Subject: [PATCH V4 3/4] hotplug/drc-info: Add code to search
 ibm,drc-info property
In-Reply-To: <cf4b4744-8401-540c-db0f-4731e513fc2c@linux.vnet.ibm.com>
Date: Thu, 16 Nov 2017 14:11:52 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <6a94bcc7-20c5-98fc-3f17-ab1b9d4385fa@linux.vnet.ibm.com>
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
Changes in V4:
  -- Rename of_one_drc_info to of_read_drc_info_cell
  -- Fix some spacing within arguments
---
 drivers/pci/hotplug/rpadlpar_core.c |   13 ++--
 drivers/pci/hotplug/rpaphp.h        |    4 +
 drivers/pci/hotplug/rpaphp_core.c   |  110 +++++++++++++++++++++++++++--------
 3 files changed, 92 insertions(+), 35 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index a3449d7..fc01d7d 100644
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
index 1e29aba..0a3b5f5 100644
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
+	const __be32 *value;
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
+		of_read_drc_info_cell(&info, &value, &drc);
+
+		/* Should now know end of current entry */
+
+		WARN_ON((my_index < drc.drc_index_start) ||
+			(((my_index - drc.drc_index_start) %
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
