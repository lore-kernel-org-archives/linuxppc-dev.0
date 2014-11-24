Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C83E01A008D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:31 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 08:49:30 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 5D28F2BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:28 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMnR9G39452764
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:28 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMnROj025590
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 4/8] PCI/hotplug/rpa: Code cleanup
Date: Tue, 25 Nov 2014 09:49:21 +1100
Message-Id: <1416869365-7671-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch applies code cleanup to RPA modules to address following
issues and it shouldn't affect the logic:

   * Coding style issue: removed unnecessary "break" for default case
     in switch statement and added default case; removed unnecessary
     braces or parenthese for if or return statements; removed
     unecessary return statements
   * Refactor rpaphp_get_sensor_state() and find_php_slot_pci_node()
     to avoid nested if statements
   * Drop is_registered(), is_php_type(), is_dlpar_capable()

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/rpadlpar_core.c | 90 +++++++++++++++++++------------------
 drivers/pci/hotplug/rpaphp_core.c   | 57 ++++++++++-------------
 drivers/pci/hotplug/rpaphp_pci.c    | 43 +++++++++---------
 drivers/pci/hotplug/rpaphp_slot.c   | 25 ++++-------
 4 files changed, 101 insertions(+), 114 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 7660232..35da3b3 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -52,30 +52,35 @@ static struct device_node *find_vio_slot_node(char *drc_name)
 
 	while ((dn = of_get_next_child(parent, dn))) {
 		rc = rpaphp_get_drc_props(dn, NULL, &name, NULL, NULL);
-		if ((rc == 0) && (!strcmp(drc_name, name)))
-			break;
+		if (rc)
+			continue;
+
+		if (!strcmp(drc_name, name))
+			return dn;
 	}
 
-	return dn;
+	return NULL;
 }
 
 /* Find dlpar-capable pci node that contains the specified name and type */
 static struct device_node *find_php_slot_pci_node(char *drc_name,
 						  char *drc_type)
 {
-	struct device_node *np = NULL;
+	struct device_node *dn = NULL;
 	char *name;
 	char *type;
 	int rc;
 
-	while ((np = of_find_node_by_name(np, "pci"))) {
-		rc = rpaphp_get_drc_props(np, NULL, &name, &type, NULL);
-		if (rc == 0)
-			if (!strcmp(drc_name, name) && !strcmp(drc_type, type))
-				break;
+	while ((dn = of_find_node_by_name(dn, "pci"))) {
+		rc = rpaphp_get_drc_props(dn, NULL, &name, &type, NULL);
+		if (rc)
+			continue;
+
+		if (!strcmp(drc_name, name) && !strcmp(drc_type, type))
+			return dn;
 	}
 
-	return np;
+	return NULL;
 }
 
 static struct device_node *find_dlpar_node(char *drc_name, int *node_type)
@@ -239,10 +244,9 @@ static int dlpar_add_phb(char *drc_name, struct device_node *dn)
 {
 	struct pci_controller *phb;
 
-	if (PCI_DN(dn) && PCI_DN(dn)->phb) {
-		/* PHB already exists */
+	/* PHB already exists */
+	if (PCI_DN(dn) && PCI_DN(dn)->phb)
 		return -EINVAL;
-	}
 
 	phb = init_phb_dynamic(dn);
 	if (!phb)
@@ -299,15 +303,18 @@ int dlpar_add_slot(char *drc_name)
 	}
 
 	switch (node_type) {
-		case NODE_TYPE_VIO:
-			rc = dlpar_add_vio_slot(drc_name, dn);
-			break;
-		case NODE_TYPE_SLOT:
-			rc = dlpar_add_pci_slot(drc_name, dn);
-			break;
-		case NODE_TYPE_PHB:
-			rc = dlpar_add_phb(drc_name, dn);
-			break;
+	case NODE_TYPE_VIO:
+		rc = dlpar_add_vio_slot(drc_name, dn);
+		break;
+	case NODE_TYPE_SLOT:
+		rc = dlpar_add_pci_slot(drc_name, dn);
+		break;
+	case NODE_TYPE_PHB:
+		rc = dlpar_add_phb(drc_name, dn);
+		break;
+	default:
+		rc = -EINVAL;
+		goto exit;
 	}
 
 	printk(KERN_INFO "%s: slot %s added\n", DLPAR_MODULE_NAME, drc_name);
@@ -429,15 +436,18 @@ int dlpar_remove_slot(char *drc_name)
 	}
 
 	switch (node_type) {
-		case NODE_TYPE_VIO:
-			rc = dlpar_remove_vio_slot(drc_name, dn);
-			break;
-		case NODE_TYPE_PHB:
-			rc = dlpar_remove_phb(drc_name, dn);
-			break;
-		case NODE_TYPE_SLOT:
-			rc = dlpar_remove_pci_slot(drc_name, dn);
-			break;
+	case NODE_TYPE_VIO:
+		rc = dlpar_remove_vio_slot(drc_name, dn);
+		break;
+	case NODE_TYPE_PHB:
+		rc = dlpar_remove_phb(drc_name, dn);
+		break;
+	case NODE_TYPE_SLOT:
+		rc = dlpar_remove_pci_slot(drc_name, dn);
+		break;
+	default:
+		rc = -EINVAL;
+		goto exit;
 	}
 	vm_unmap_aliases();
 
@@ -447,20 +457,15 @@ exit:
 	return rc;
 }
 
-static inline int is_dlpar_capable(void)
-{
-	int rc = rtas_token("ibm,configure-connector");
-
-	return (int) (rc != RTAS_UNKNOWN_SERVICE);
-}
-
-int __init rpadlpar_io_init(void)
+static int __init rpadlpar_io_init(void)
 {
 	int rc = 0;
 
-	if (!is_dlpar_capable()) {
+	/* Check if we have DLPAR capability */
+	rc = rtas_token("ibm,configure-connector");
+	if (rc == RTAS_UNKNOWN_SERVICE) {
 		printk(KERN_WARNING "%s: partition not DLPAR capable\n",
-			__func__);
+		       __func__);
 		return -EPERM;
 	}
 
@@ -468,10 +473,9 @@ int __init rpadlpar_io_init(void)
 	return rc;
 }
 
-void rpadlpar_io_exit(void)
+static void __exit rpadlpar_io_exit(void)
 {
 	dlpar_sysfs_exit();
-	return;
 }
 
 module_init(rpadlpar_io_init);
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index f2945fa..ff800df 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -74,7 +74,6 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
 		break;
 	default:
 		value = 1;
-		break;
 	}
 
 	rc = rtas_set_indicator(DR_INDICATOR, slot->index, value);
@@ -94,7 +93,7 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	int retval, level;
 	struct slot *slot = (struct slot *)hotplug_slot->private;
 
-	retval = rtas_get_power_level (slot->power_domain, &level);
+	retval = rtas_get_power_level(slot->power_domain, &level);
 	if (!retval)
 		*value = level;
 	return retval;
@@ -161,7 +160,6 @@ static enum pci_bus_speed get_max_bus_speed(struct slot *slot)
 		break;
 	default:
 		speed = PCI_SPEED_UNKNOWN;
-		break;
 	}
 
 	return speed;
@@ -178,17 +176,17 @@ static int get_children_props(struct device_node *dn, const int **drc_indexes,
 	types = of_get_property(dn, "ibm,drc-types", NULL);
 	domains = of_get_property(dn, "ibm,drc-power-domains", NULL);
 
-	if (!indexes || !names || !types || !domains) {
-		/* Slot does not have dynamically-removable children */
+	/* Slot does not have dynamically-removable children */
+	if (!indexes || !names || !types || !domains)
 		return -EINVAL;
-	}
+
 	if (drc_indexes)
 		*drc_indexes = indexes;
+	/* &drc_names[1] contains NULL terminated slot names */
 	if (drc_names)
-		/* &drc_names[1] contains NULL terminated slot names */
 		*drc_names = names;
+	/* &drc_types[1] contains NULL terminated slot types */
 	if (drc_types)
-		/* &drc_types[1] contains NULL terminated slot types */
 		*drc_types = types;
 	if (drc_power_domains)
 		*drc_power_domains = domains;
@@ -210,15 +208,13 @@ int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
 	int i, rc;
 
 	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
-	if (!my_index) {
-		/* Node isn't DLPAR/hotplug capable */
+	/* Node isn't DLPAR/hotplug capable */
+	if (!my_index)
 		return -EINVAL;
-	}
 
 	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
-	if (rc < 0) {
+	if (rc < 0)
 		return -EINVAL;
-	}
 
 	name_tmp = (char *) &names[1];
 	type_tmp = (char *) &types[1];
@@ -244,21 +240,8 @@ int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
 }
 EXPORT_SYMBOL_GPL(rpaphp_get_drc_props);
 
-static int is_php_type(char *drc_type)
-{
-	unsigned long value;
-	char *endptr;
-
-	/* PCI Hotplug nodes have an integer for drc_type */
-	value = simple_strtoul(drc_type, &endptr, 10);
-	if (endptr == drc_type)
-		return 0;
-
-	return 1;
-}
-
 /**
- * is_php_dn() - return 1 if this is a hotpluggable pci slot, else 0
+ * is_php_dn() - return true if this is a hotpluggable pci slot, else false
  * @dn: target &device_node
  * @indexes: passed to get_children_props()
  * @names: passed to get_children_props()
@@ -270,21 +253,28 @@ static int is_php_type(char *drc_type)
  * for built-in pci slots (even when the built-in slots are
  * dlparable.)
  */
-static int is_php_dn(struct device_node *dn, const int **indexes,
-		const int **names, const int **types, const int **power_domains)
+static bool is_php_dn(struct device_node *dn,
+		      const int **indexes, const int **names,
+		      const int **types, const int **power_domains)
 {
 	const int *drc_types;
+	const char *drc_type_str;
+	char *endptr;
+	unsigned long val;
 	int rc;
 
 	rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
 	if (rc < 0)
-		return 0;
+		return false;
 
-	if (!is_php_type((char *) &drc_types[1]))
-		return 0;
+	/* PCI Hotplug nodes have an integer for drc_type */
+	drc_type_str = (char *)&drc_types[1];
+	val = simple_strtoul(drc_type_str, &endptr, 10);
+	if (endptr == drc_type_str)
+		return false;
 
 	*types = drc_types;
-	return 1;
+	return true;
 }
 
 /**
@@ -370,7 +360,6 @@ static void __exit cleanup_slots(void)
 		list_del(&slot->rpaphp_slot_list);
 		pci_hp_deregister(slot->hotplug_slot);
 	}
-	return;
 }
 
 static int __init rpaphp_init(void)
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
index 9243f3e7..a4aa65c 100644
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ b/drivers/pci/hotplug/rpaphp_pci.c
@@ -38,30 +38,31 @@ int rpaphp_get_sensor_state(struct slot *slot, int *state)
 	int setlevel;
 
 	rc = rtas_get_sensor(DR_ENTITY_SENSE, slot->index, state);
+	if (rc >= 0)
+		return rc;
+	if (rc != -EFAULT && rc != -EEXIST) {
+		err("%s: Failure %d getting sensor state on slot[%s]\n",
+		    __func__, rc, slot->name);
+		return rc;
+	}
 
+
+	/*
+	 * Some slots have to be powered up before
+	 * get-sensor will succeed
+	 */
+	dbg("%s: Slot[%s] must be power up to get sensor-state\n",
+	    __func__, slot->name);
+	rc = rtas_set_power_level(slot->power_domain, POWER_ON,
+				  &setlevel);
 	if (rc < 0) {
-		if (rc == -EFAULT || rc == -EEXIST) {
-			dbg("%s: slot must be power up to get sensor-state\n",
-			    __func__);
-
-			/* some slots have to be powered up
-			 * before get-sensor will succeed.
-			 */
-			rc = rtas_set_power_level(slot->power_domain, POWER_ON,
-						  &setlevel);
-			if (rc < 0) {
-				dbg("%s: power on slot[%s] failed rc=%d.\n",
-				    __func__, slot->name, rc);
-			} else {
-				rc = rtas_get_sensor(DR_ENTITY_SENSE,
-						     slot->index, state);
-			}
-		} else if (rc == -ENODEV)
-			info("%s: slot is unusable\n", __func__);
-		else
-			err("%s failed to get sensor state\n", __func__);
+		dbg("%s: Failure %d powerng on slot[%s]\n",
+		    __func__, rc, slot->name);
+		return rc;
 	}
-	return rc;
+
+	return rtas_get_sensor(DR_ENTITY_SENSE,
+			       slot->index, state);
 }
 
 /**
diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index a6082cc..be48e69 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -72,7 +72,7 @@ struct slot *alloc_slot_struct(struct device_node *dn,
 	slot->hotplug_slot->ops = &rpaphp_hotplug_slot_ops;
 	slot->hotplug_slot->release = &rpaphp_release_slot;
 
-	return (slot);
+	return slot;
 
 error_info:
 	kfree(slot->hotplug_slot->info);
@@ -84,17 +84,6 @@ error_nomem:
 	return NULL;
 }
 
-static int is_registered(struct slot *slot)
-{
-	struct slot *tmp_slot;
-
-	list_for_each_entry(tmp_slot, &rpaphp_slot_head, rpaphp_slot_list) {
-		if (!strcmp(tmp_slot->name, slot->name))
-			return 1;
-	}
-	return 0;
-}
-
 int rpaphp_deregister_slot(struct slot *slot)
 {
 	int retval = 0;
@@ -117,6 +106,7 @@ EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
 int rpaphp_register_slot(struct slot *slot)
 {
 	struct hotplug_slot *php_slot = slot->hotplug_slot;
+	struct slot *tmp;
 	int retval;
 	int slotno;
 
@@ -124,10 +114,13 @@ int rpaphp_register_slot(struct slot *slot)
 		__func__, slot->dn->full_name, slot->index, slot->name,
 		slot->power_domain, slot->type);
 
-	/* should not try to register the same slot twice */
-	if (is_registered(slot)) {
-		err("rpaphp_register_slot: slot[%s] is already registered\n", slot->name);
-		return -EAGAIN;
+	/* Should not try to register the same slot twice */
+	list_for_each_entry(tmp, &rpaphp_slot_head, rpaphp_slot_list) {
+		if (!strcmp(tmp->name, slot->name)) {
+			err("%s: Slot[%s] is already registered\n",
+			    __func__, slot->name);
+			return -EAGAIN;
+		}
 	}
 
 	if (slot->dn->child)
-- 
1.8.3.2
