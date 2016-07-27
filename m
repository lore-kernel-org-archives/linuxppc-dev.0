Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzy063rq7zDrTd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:23:34 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6REJVBV009031
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:32 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24edma6vb4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:31 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 27 Jul 2016 08:23:27 -0600
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 3E5983E40060
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 08:23:24 -0600 (MDT)
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
 [9.57.199.110])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6RENRYU12321092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 14:23:27 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 70EECAE034
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:23 -0400 (EDT)
Received: from oc1376853207.ibm.com (unknown [9.77.146.137])
 by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP id 5216CAE04B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 10:23:23 -0400 (EDT)
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH V2 6/8] hotplug/drc-info: Add code to search new devtree
 properties
Date: Wed, 27 Jul 2016 09:23:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <ea98d761-2c11-1c1e-213c-df4e99a05ef1@linux.vnet.ibm.com>
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
and "ibm,drc-power-domains"), or the new property "ibm,drc-info".  The
code searches for PHP PCI Slots, gets the DRC properties within the
current node (using my-drc-index as correlation), and performs searches
by name or type of DRC node.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index dc67f39..bea9723 100644
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
@@ -91,8 +91,8 @@ int rpaphp_get_sensor_state(struct slot *slot, int *state);
 
 /* rpaphp_core.c */
 int rpaphp_add_slot(struct device_node *dn);
-int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
-		char **drc_name, char **drc_type, int *drc_power_domain);
+int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
+		char *drc_type);
 
 /* rpaphp_slot.c */
 void dealloc_slot_struct(struct slot *slot);
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 8d13202..0cfdbd9 100644
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
@@ -142,15 +143,6 @@ static enum pci_bus_speed get_max_bus_speed(struct slot *slot)
 	case 5:
 	case 6:
 		speed = PCI_SPEED_33MHz;	/* speed for case 1-6 */
-		break;
-	case 7:
-	case 8:
-		speed = PCI_SPEED_66MHz;
-		break;
-	case 11:
-	case 14:
-		speed = PCI_SPEED_66MHz_PCIX;
-		break;
 	case 12:
 	case 15:
 		speed = PCI_SPEED_100MHz_PCIX;
@@ -196,25 +188,21 @@ static int get_children_props(struct device_node *dn, const int **drc_indexes,
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
@@ -225,24 +213,83 @@ int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
 
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
+	int *info = (int *)dn;
+	unsigned int entries;
+	unsigned long int fdi = 0, ldi = 0, nsl = 0, si = 0;
+	char *name_tmp, *type_tmp;
+	int j, ret = -EINVAL;
+
+	info = (int *)of_get_property(dn->parent, "ibm,drc-info", NULL);
+	if (info == NULL)
+		return -EINVAL;
+
+	entries = be32_to_cpu(*info++);
+
+	for (j = 0; j < entries; j++) {
+		read_one_drc_info(&info, &type_tmp, &name_tmp,
+				&fdi, &nsl, &si, &ldi);
+
+		/* Should now know end of current entry */
+
+		ldi = fdi + ((nsl-1)*si);
+
+		WARN_ON(my_index < fdi);
+		if (my_index > ldi)
+			continue;
+
+		WARN_ON(((my_index-fdi)%si) != 0);
+
+		ret = ((my_index-fdi)/si);
+		break;
+	}
+	/* Found it */
+
+	if (((drc_name == NULL) ||
+	     (drc_name && !strcmp(drc_name, name_tmp))) &&
+	    ((drc_type == NULL) ||
+	     (drc_type && !strcmp(drc_type, type_tmp))))
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
