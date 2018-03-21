Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405yvK0qlWzF1kN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 05:27:08 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LIOkdd127591
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 14:27:06 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2gurat4g8k-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 14:27:06 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 14:27:05 -0400
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Subject: [RFC v2 4/4] powerpc/hotplug/drcinfo: Improve code for ibm,drc-info
 device processing
To: linuxppc-dev@lists.ozlabs.org
In-Reply-To: <9ed45428-fdad-a945-55df-3d47959204fb@linux.vnet.ibm.com>
Date: Wed, 21 Mar 2018 13:27:01 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <a6d3d1c0-16af-57ae-329e-56f1b1af7247@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch extends the use of a common parse function for the
ibm,drc-info property that can be modified by a callback function
to the hotplug device processing.  Candidate code is replaced by
a call to the parser including a pointer to a local context-specific
functions, and local data.

In addition, the original set missed several opportunities to compress
and reuse common code which this patch attempts to provide.

Finally, a bug with the registration of slots was observed on some
systems, and the code was rewritten to prevent its reoccurrence.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
Fixes: 3f38000eda48 ("powerpc/firmware: Add definitions for new drc-info firmwar
e feature" -- end of patch series applied to powerpc next)
---
Changes in V2:
  -- Update code to account for v4.16 kernel checkins.
  -- Fix bug searching for virtual device slots.
---
 drivers/pci/hotplug/rpaphp_core.c |  188 ++++++++++++++++++++++++++-----------
 1 file changed, 130 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index dccdf62..974147a 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -222,49 +222,52 @@ static int rpaphp_check_drc_props_v1(struct device_node *dn, char *drc_name,
 	return -EINVAL;
 }
 
-static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
-				char *drc_type, unsigned int my_index)
+struct check_drc_props_v2_struct {
+	char *drc_name;
+	char *drc_type;
+        unsigned int my_index;
+};
+
+static int check_drc_props_v2_checkRun(struct of_drc_info *drc,
+                                        void *idata, void *not_used,
+					int *ret_code)
 {
-	struct property *info;
-	unsigned int entries;
-	struct of_drc_info drc;
-	const __be32 *value;
+	struct check_drc_props_v2_struct *cdata = idata;
 	char cell_drc_name[MAX_DRC_NAME_LEN];
-	int j, fndit;
-
-	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
-	if (info == NULL)
-		return -EINVAL;
-
-	value = of_prop_next_u32(info, NULL, &entries);
-	if (!value)
-		return -EINVAL;
-	value++;
-
-	for (j = 0; j < entries; j++) {
-		of_read_drc_info_cell(&info, &value, &drc);
 
-		/* Should now know end of current entry */
+	(*ret_code) = -EINVAL;
 
-		if (my_index > drc.last_drc_index)
-			continue;
+	if (cdata->my_index > drc->last_drc_index)
+		return 0;
 
-		fndit = 1;
-		break;
+	/* Found drc_index.  Now match the rest. */
+	sprintf(cell_drc_name, "%s%d", drc->drc_name_prefix, 
+		cdata->my_index - drc->drc_index_start +
+		drc->drc_name_suffix_start);
+
+	if (((cdata->drc_name == NULL) ||
+	     (cdata->drc_name && !strcmp(cdata->drc_name, cell_drc_name))) &&
+	    ((cdata->drc_type == NULL) ||
+	     (cdata->drc_type && !strcmp(cdata->drc_type, drc->drc_type)))) {
+		(*ret_code) = 0;
+		return 1;
 	}
-	/* Found it */
 
-	if (fndit)
-		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix, 
-			my_index);
+        return 0;
+}
 
-	if (((drc_name == NULL) ||
-	     (drc_name && !strcmp(drc_name, cell_drc_name))) &&
-	    ((drc_type == NULL) ||
-	     (drc_type && !strcmp(drc_type, drc.drc_type))))
-		return 0;
+static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
+				char *drc_type, unsigned int my_index)
+{
+	struct device_node *root = dn;
+	struct check_drc_props_v2_struct cdata = {
+		drc_name, drc_type, be32_to_cpu(my_index) };
 
-	return -EINVAL;
+	if (!drc_type || (drc_type && strcmp(drc_type, "SLOT")))
+		root = dn->parent;
+
+	return drc_info_parser(root, check_drc_props_v2_checkRun,
+				drc_type, &cdata);
 }
 
 int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
@@ -287,7 +290,6 @@ int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
 }
 EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
 
-
 static int is_php_type(char *drc_type)
 {
 	unsigned long value;
@@ -347,17 +349,40 @@ static int is_php_dn(struct device_node *dn, const int **indexes,
  *
  * To remove a slot, it suffices to call rpaphp_deregister_slot().
  */
-int rpaphp_add_slot(struct device_node *dn)
+
+static int rpaphp_add_slot_common(struct device_node *dn,
+			u32 drc_index, char *drc_name, char *drc_type,
+			u32 drc_power_domain)
 {
 	struct slot *slot;
 	int retval = 0;
-	int i;
+
+	slot = alloc_slot_struct(dn, drc_index, drc_name,
+				 drc_power_domain);
+	if (!slot)
+		return -ENOMEM;
+
+	slot->type = simple_strtoul(drc_type, NULL, 10);
+
+	dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
+		drc_index, drc_name, drc_type);
+
+	retval = rpaphp_enable_slot(slot);
+	if (!retval)
+		retval = rpaphp_register_slot(slot);
+
+	if (retval)
+		dealloc_slot_struct(slot);
+
+	return retval;
+}
+
+static int rpaphp_add_slot_v1(struct device_node *dn)
+{
+	int i, retval = 0;
 	const int *indexes, *names, *types, *power_domains;
 	char *name, *type;
 
-	if (!dn->name || strcmp(dn->name, "pci"))
-		return 0;
-
 	/* If this is not a hotplug slot, return without doing anything. */
 	if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
 		return 0;
@@ -368,25 +393,13 @@ int rpaphp_add_slot(struct device_node *dn)
 	name = (char *) &names[1];
 	type = (char *) &types[1];
 	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
-		int index;
-
-		index = be32_to_cpu(indexes[i + 1]);
-		slot = alloc_slot_struct(dn, index, name,
-					 be32_to_cpu(power_domains[i + 1]));
-		if (!slot)
-			return -ENOMEM;
-
-		slot->type = simple_strtoul(type, NULL, 10);
-
-		dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
-				index, name, type);
-
-		retval = rpaphp_enable_slot(slot);
+	
+		retval = rpaphp_add_slot_common(dn,
+				be32_to_cpu(indexes[i + 1]),
+				name, type,
+				be32_to_cpu(power_domains[i + 1]));
 		if (!retval)
-			retval = rpaphp_register_slot(slot);
-
-		if (retval)
-			dealloc_slot_struct(slot);
+			return retval;
 
 		name += strlen(name) + 1;
 		type += strlen(type) + 1;
@@ -396,6 +409,65 @@ int rpaphp_add_slot(struct device_node *dn)
 	/* XXX FIXME: reports a failure only if last entry in loop failed */
 	return retval;
 }
+
+struct rpaphp_add_slot_v2_struct {
+	struct device_node *dn;
+};
+
+static int rpaphp_add_slot_v2_checkRun(struct of_drc_info *drc,
+                                        void *idata, void *not_used,
+					int *ret_code)
+{
+	struct rpaphp_add_slot_v2_struct *cdata = idata;
+	u32 drc_index;
+	char drc_name[MAX_DRC_NAME_LEN];
+	int i, retval;
+
+	(*ret_code) = -EINVAL;
+
+	if (!is_php_type((char *) drc->drc_type)) {
+		(*ret_code) = 0;
+		return 1;
+	}
+
+	for (i = 0, drc_index = drc->drc_index_start;
+		i < drc->num_sequential_elems; i++, drc_index++) {
+
+        	sprintf(drc_name, "%s%d", drc->drc_name_prefix,
+			drc_index - drc->drc_index_start +
+			drc->drc_name_suffix_start);
+
+		retval = rpaphp_add_slot_common(cdata->dn,
+				drc_index, drc_name, drc->drc_type,
+				drc->drc_power_domain);
+		if (!retval) {
+			(*ret_code) = retval;
+			return 1;
+		}
+	}
+
+	(*ret_code) = retval;
+	return 0;
+}
+
+static int rpaphp_add_slot_v2(struct device_node *dn)
+{
+	struct rpaphp_add_slot_v2_struct cdata = { dn };
+
+	return drc_info_parser(dn, rpaphp_add_slot_v2_checkRun,
+				NULL, &cdata);
+}
+
+int rpaphp_add_slot(struct device_node *dn)
+{
+	if (!dn->name || strcmp(dn->name, "pci"))
+		return 0;
+
+	if (firmware_has_feature(FW_FEATURE_DRC_INFO))
+		return rpaphp_add_slot_v2(dn);
+	else
+		return rpaphp_add_slot_v1(dn);
+}
 EXPORT_SYMBOL_GPL(rpaphp_add_slot);
 
 static void __exit cleanup_slots(void)
