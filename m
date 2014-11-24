Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D1BFD1A0283
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:33 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 04:19:31 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 21413394004E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 04:19:29 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMnhjT60752124
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 04:19:43 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMnSST016757
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 04:19:28 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 6/8] PCI/hotplug/rpa: Abstract slot operations
Date: Tue, 25 Nov 2014 09:49:23 +1100
Message-Id: <1416869365-7671-7-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch splits the code into 2 parts: RPA PCI hotplug slot
management and RTAS backend. It enables us to support PowerNV,
which is built on top of OPAL firmware in future.

The patch also refactors the code for a bit:

    * Rename "struct slot" to "struct rpa_php_slot"
    * All macros have prefix "RPA_PHP_SLOT"
    * rpaphp_slot.c is removed and all logics moved to rpaphp_core.c

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/Makefile        |   3 +-
 drivers/pci/hotplug/rpadlpar_core.c |  10 +-
 drivers/pci/hotplug/rpaphp.h        |  64 +++----
 drivers/pci/hotplug/rpaphp_core.c   | 347 +++++++++++-------------------------
 drivers/pci/hotplug/rpaphp_pci.c    | 136 --------------
 drivers/pci/hotplug/rpaphp_rtas.c   | 320 +++++++++++++++++++++++++++++++++
 drivers/pci/hotplug/rpaphp_slot.c   | 140 ---------------
 7 files changed, 459 insertions(+), 561 deletions(-)
 delete mode 100644 drivers/pci/hotplug/rpaphp_pci.c
 create mode 100644 drivers/pci/hotplug/rpaphp_rtas.c
 delete mode 100644 drivers/pci/hotplug/rpaphp_slot.c

diff --git a/drivers/pci/hotplug/Makefile b/drivers/pci/hotplug/Makefile
index 4a9aa08..630313da 100644
--- a/drivers/pci/hotplug/Makefile
+++ b/drivers/pci/hotplug/Makefile
@@ -51,8 +51,7 @@ acpiphp-objs		:=	acpiphp_core.o	\
 				acpiphp_glue.o
 
 rpaphp-objs		:=	rpaphp_core.o	\
-				rpaphp_pci.o	\
-				rpaphp_slot.o
+				rpaphp_rtas.o
 
 rpadlpar_io-objs	:=	rpadlpar_core.o \
 				rpadlpar_sysfs.o
diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 35da3b3..a36d2c9 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -117,13 +117,13 @@ static struct device_node *find_dlpar_node(char *drc_name, int *node_type)
  * may be dlpar-able, but not hot-pluggable, so this routine
  * will return NULL for built-in PCI slots.
  */
-static struct slot *find_php_slot(struct device_node *dn)
+static struct rpa_php_slot *find_php_slot(struct device_node *dn)
 {
 	struct list_head *tmp, *n;
-	struct slot *slot;
+	struct rpa_php_slot *slot;
 
 	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
-		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
+		slot = list_entry(tmp, struct rpa_php_slot, rpaphp_slot_list);
 		if (slot->dn == dn)
 			return slot;
 	}
@@ -214,7 +214,7 @@ static int dlpar_add_pci_slot(char *drc_name, struct device_node *dn)
 
 static int dlpar_remove_phb(char *drc_name, struct device_node *dn)
 {
-	struct slot *slot;
+	struct rpa_php_slot *slot;
 	struct pci_dn *pdn;
 	int rc = 0;
 
@@ -359,7 +359,7 @@ static int dlpar_remove_vio_slot(char *drc_name, struct device_node *dn)
 int dlpar_remove_pci_slot(char *drc_name, struct device_node *dn)
 {
 	struct pci_bus *bus;
-	struct slot *slot;
+	struct rpa_php_slot *slot;
 	int ret = 0;
 
 	pci_lock_rescan_remove();
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index 39ddbdf..09dd516 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -30,21 +30,6 @@
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 
-#define DR_INDICATOR 9002
-#define DR_ENTITY_SENSE 9003
-
-#define POWER_ON	100
-#define POWER_OFF	0
-
-#define LED_OFF		0
-#define LED_ON		1	/* continuous on */
-#define LED_ID		2	/* slow blinking */
-#define LED_ACTION	3	/* fast blinking */
-
-/* Sensor values from rtas_get-sensor */
-#define EMPTY           0	/* No card in slot */
-#define PRESENT         1	/* Card in slot */
-
 #define MY_NAME "rpaphp"
 extern bool rpaphp_debug;
 #define dbg(format, arg...)					\
@@ -57,19 +42,26 @@ extern bool rpaphp_debug;
 #define info(format, arg...) printk(KERN_INFO "%s: " format, MY_NAME , ## arg)
 #define warn(format, arg...) printk(KERN_WARNING "%s: " format, MY_NAME , ## arg)
 
-/* slot states */
+/* Power */
+#define RPA_PHP_SLOT_POWER_ON	1	/* On            */
+#define RPA_PHP_SLOT_POWER_OFF	0	/* Off           */
 
-#define	NOT_VALID	3
-#define	NOT_CONFIGURED	2
-#define	CONFIGURED	1
-#define	EMPTY		0
+/* Attention */
+#define RPA_PHP_SLOT_ATTEN_OFF	0	/* Off           */
+#define RPA_PHP_SLOT_ATTEN_ON	1	/* On            */
+#define RPA_PHP_SLOT_ATTEN_IND	2	/* Slow blinking */
+#define RPA_PHP_SLOT_ATTEN_ACT	3	/* Fast blinking */
 
-/*
- * struct slot - slot information for each *physical* slot
- */
-struct slot {
+/* Presence */
+#define RPA_PHP_SLOT_EMPTY	0	/* No card       */
+#define RPA_PHP_SLOT_PRESENT	1	/* Presented     */
+
+struct rpa_php_slot {
 	struct list_head rpaphp_slot_list;
 	int state;
+#define RPA_PHP_SLOT_NOT_CONFIGURED	0
+#define RPA_PHP_SLOT_CONFIGURED		1
+#define RPA_PHP_SLOT_NOT_VALID		2
 	u32 index;
 	u32 type;
 	u32 power_domain;
@@ -80,24 +72,20 @@ struct slot {
 	struct hotplug_slot *hotplug_slot;
 };
 
-extern struct hotplug_slot_ops rpaphp_hotplug_slot_ops;
 extern struct list_head rpaphp_slot_head;
 
-/* function prototypes */
-
-/* rpaphp_pci.c */
-int rpaphp_enable_slot(struct slot *slot);
-int rpaphp_get_sensor_state(struct slot *slot, int *state);
-
 /* rpaphp_core.c */
 int rpaphp_add_slot(struct device_node *dn);
-int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
-		char **drc_name, char **drc_type, int *drc_power);
+void dealloc_slot_struct(struct rpa_php_slot *slot);
+struct rpa_php_slot *alloc_slot_struct(struct device_node *dn, int drc_index,
+				       char *drc_name, int power_domain);
+int rpaphp_register_slot(struct rpa_php_slot *slot);
+int rpaphp_deregister_slot(struct rpa_php_slot *slot);
+int rpaphp_add_slot(struct device_node *dn);
 
-/* rpaphp_slot.c */
-void dealloc_slot_struct(struct slot *slot);
-struct slot *alloc_slot_struct(struct device_node *dn, int drc_index, char *drc_name, int power_domain);
-int rpaphp_register_slot(struct slot *slot);
-int rpaphp_deregister_slot(struct slot *slot);
+/* rpaphp_rtas.c */
+int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
+			 char **drc_name, char **drc_type, int *drc_power);
+struct rpa_php_slot *rpaphp_rtas_add_slot(struct device_node *dn);
 
 #endif				/* _PPC64PHP_H */
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index a639c5c..91eff8f 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -45,194 +45,118 @@ EXPORT_SYMBOL_GPL(rpaphp_slot_head);
 #define DRIVER_AUTHOR	"Linda Xie <lxie@us.ibm.com>"
 #define DRIVER_DESC	"RPA HOT Plug PCI Controller Driver"
 
-#define MAX_LOC_CODE 128
-
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
-
 module_param_named(debug, rpaphp_debug, bool, 0644);
 
-/**
- * set_attention_status - set attention LED
- * @hotplug_slot: target &hotplug_slot
- * @value: LED control value
- *
- * echo 0 > attention -- set LED OFF
- * echo 1 > attention -- set LED ON
- * echo 2 > attention -- set LED ID(identify, light is blinking)
- */
-static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 value)
+/* free up the memory used by a slot */
+static void rpaphp_release_slot(struct hotplug_slot *hotplug_slot)
 {
-	int rc;
-	struct slot *slot = (struct slot *)hotplug_slot->private;
-
-	switch (value) {
-	case 0:
-	case 1:
-	case 2:
-		break;
-	default:
-		value = 1;
-	}
+	struct rpa_php_slot *slot = hotplug_slot->private;
 
-	rc = rtas_set_indicator(DR_INDICATOR, slot->index, value);
-	if (!rc)
-		hotplug_slot->info->attention_status = value;
-
-	return rc;
+	dealloc_slot_struct(slot);
 }
 
-/**
- * get_power_status - get power status of a slot
- * @hotplug_slot: slot to get status
- * @value: pointer to store status
- */
-static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
+void dealloc_slot_struct(struct rpa_php_slot *slot)
 {
-	int retval, level;
-	struct slot *slot = (struct slot *)hotplug_slot->private;
-
-	retval = rtas_get_power_level(slot->power_domain, &level);
-	if (!retval)
-		*value = level;
-	return retval;
+	kfree(slot->hotplug_slot->info);
+	kfree(slot->name);
+	kfree(slot->hotplug_slot);
+	kfree(slot);
 }
 
-/**
- * get_attention_status - get attention LED status
- * @hotplug_slot: slot to get status
- * @value: pointer to store status
- */
-static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
+struct rpa_php_slot *alloc_slot_struct(struct device_node *dn,
+				       int drc_index, char *drc_name,
+				       int power_domain)
 {
-	struct slot *slot = (struct slot *)hotplug_slot->private;
-	*value = slot->hotplug_slot->info->attention_status;
-	return 0;
-}
-
-static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
-{
-	struct slot *slot = (struct slot *)hotplug_slot->private;
-	int rc, state;
-
-	rc = rpaphp_get_sensor_state(slot, &state);
-
-	*value = NOT_VALID;
-	if (rc)
-		return rc;
+	struct rpa_php_slot *slot;
 
-	if (state == EMPTY)
-		*value = EMPTY;
-	else if (state == PRESENT)
-		*value = slot->state;
-
-	return 0;
+	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
+	if (!slot)
+		goto error_nomem;
+	slot->hotplug_slot = kzalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
+	if (!slot->hotplug_slot)
+		goto error_slot;
+	slot->hotplug_slot->info = kzalloc(sizeof(struct hotplug_slot_info),
+					   GFP_KERNEL);
+	if (!slot->hotplug_slot->info)
+		goto error_hpslot;
+	slot->name = kstrdup(drc_name, GFP_KERNEL);
+	if (!slot->name)
+		goto error_info;
+	slot->dn = dn;
+	slot->index = drc_index;
+	slot->power_domain = power_domain;
+	slot->hotplug_slot->private = slot;
+	slot->hotplug_slot->release = &rpaphp_release_slot;
+
+	slot->hotplug_slot->info->power_status = RPA_PHP_SLOT_POWER_ON;
+	slot->hotplug_slot->info->attention_status = RPA_PHP_SLOT_ATTEN_OFF;
+	slot->hotplug_slot->info->adapter_status = RPA_PHP_SLOT_EMPTY;
+	slot->state = RPA_PHP_SLOT_NOT_VALID;
+
+	return slot;
+
+error_info:
+	kfree(slot->hotplug_slot->info);
+error_hpslot:
+	kfree(slot->hotplug_slot);
+error_slot:
+	kfree(slot);
+error_nomem:
+	return NULL;
 }
 
-static enum pci_bus_speed get_max_bus_speed(struct slot *slot)
+int rpaphp_register_slot(struct rpa_php_slot *slot)
 {
-	enum pci_bus_speed speed;
-	switch (slot->type) {
-	case 1:
-	case 2:
-	case 3:
-	case 4:
-	case 5:
-	case 6:
-		speed = PCI_SPEED_33MHz;	/* speed for case 1-6 */
-		break;
-	case 7:
-	case 8:
-		speed = PCI_SPEED_66MHz;
-		break;
-	case 11:
-	case 14:
-		speed = PCI_SPEED_66MHz_PCIX;
-		break;
-	case 12:
-	case 15:
-		speed = PCI_SPEED_100MHz_PCIX;
-		break;
-	case 13:
-	case 16:
-		speed = PCI_SPEED_133MHz_PCIX;
-		break;
-	default:
-		speed = PCI_SPEED_UNKNOWN;
+	struct hotplug_slot *php_slot = slot->hotplug_slot;
+	struct rpa_php_slot *tmp;
+	int slotno, retval;
+
+	dbg("%s registering slot:path[%s] index[%x], name[%s] pdomain[%x] type[%d]\n",
+	    __func__, slot->dn->full_name, slot->index, slot->name,
+	    slot->power_domain, slot->type);
+
+	/* Should not try to register the same slot twice */
+	list_for_each_entry(tmp, &rpaphp_slot_head, rpaphp_slot_list) {
+		if (!strcmp(tmp->name, slot->name)) {
+			err("%s: Slot[%s] is already registered\n",
+			    __func__, slot->name);
+			return -EAGAIN;
+		}
+	}
+	if (slot->dn->child)
+		slotno = PCI_SLOT(PCI_DN(slot->dn->child)->devfn);
+	else
+		slotno = -1;
+	retval = pci_hp_register(php_slot, slot->bus, slotno, slot->name);
+	if (retval) {
+		err("pci_hp_register failed with error %d\n", retval);
+		return retval;
 	}
 
-	return speed;
+	/* add slot to our internal list */
+	list_add(&slot->rpaphp_slot_list, &rpaphp_slot_head);
+	info("Slot [%s] registered\n", slot->name);
+	return 0;
 }
 
-static int parse_drc_props(struct device_node *dn, u32 drc_index,
-			   char **drc_name, char **drc_type, u32 *drc_power)
+int rpaphp_deregister_slot(struct rpa_php_slot *slot)
 {
-	const u32 *indexes, *names, *types, *domains;
-	char *name, *type;
-	struct device_node *parent = dn;
-	u32 i;
-
-	while ((parent = of_get_parent(parent))) {
-		indexes = of_get_property(parent, "ibm,drc-indexes", NULL);
-		names   = of_get_property(parent, "ibm,drc-names", NULL);
-		types   = of_get_property(parent, "ibm,drc-types", NULL);
-		domains = of_get_property(parent, "ibm,drc-power-domains", NULL);
-
-		if (!indexes || !names || !types || !domains) {
-			of_node_put(parent);
-			continue;
-		}
+	struct hotplug_slot *php_slot = slot->hotplug_slot;
+	int retval = 0;
 
-		name = (char *)&names[1];
-		type = (char *)&types[1];
-		for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
-			if (be32_to_cpu(indexes[i + 1]) != drc_index) {
-				name += (strlen(name) + 1);
-				type += (strlen(type) + 1);
-				continue;
-			}
-
-			/* Matched index */
-			if (drc_name)
-				*drc_name = name;
-			if (drc_type)
-				*drc_type = type;
-			if (drc_power)
-				*drc_power = be32_to_cpu(domains[i + 1]);
-
-			of_node_put(parent);
-			return 0;
-		}
-
-		/* Next level parent */
-		of_node_put(parent);
-	}
+	dbg("%s - Entry: deregistering slot=%s\n",
+	    __func__, slot->name);
 
-	return -ENODEV;
-}
+	list_del(&slot->rpaphp_slot_list);
 
-/*
- * To get the DRC props describing the current node, first obtain it's
- * my-drc-index property.  Next obtain the DRC list from it's parent.  Use
- * the my-drc-index for correlation, and obtain the requested properties.
- */
-int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
-			 char **drc_name, char **drc_type, int *drc_power)
-{
-	const u32 *my_index;
-
-	/* Check if node is capable of hotplug */
-	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
-	if (!my_index)
-		return -EINVAL;
-	if (drc_index)
-		*drc_index = be32_to_cpu(*my_index);
+	retval = pci_hp_deregister(php_slot);
+	if (retval)
+		err("Problem unregistering a slot %s\n", slot->name);
 
-	return parse_drc_props(dn, be32_to_cpu(*my_index),
-			       drc_name, drc_type, drc_power);
+	dbg("%s - Exit: rc[%d]\n", __func__, retval);
+	return retval;
 }
-EXPORT_SYMBOL_GPL(rpaphp_get_drc_props);
+EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
 
 /**
  * rpaphp_add_slot -- declare a hotplug slot to the hotplug subsystem.
@@ -252,29 +176,22 @@ EXPORT_SYMBOL_GPL(rpaphp_get_drc_props);
  */
 int rpaphp_add_slot(struct device_node *dn)
 {
-	char *name, *type, *endptr;
-	int index, power_domain;
-	struct slot *slot;
-	int val, ret;
-
-	/* Get and parse the hotplug properties */
-	ret = rpaphp_get_drc_props(dn, &index, &name, &type, &power_domain);
-	if (ret)
-		return ret;
-
-	/* PCI Hotplug nodes have an integer for drc_type */
-	val = simple_strtoul(type, &endptr, 10);
-	if (endptr == type)
-		return -EINVAL;
+	struct rpa_php_slot *slot = NULL;
+	int ret;
 
-	slot = alloc_slot_struct(dn, index, name, power_domain);
+	/* Create slot */
+	if (machine_is(pseries))
+		slot = rpaphp_rtas_add_slot(dn);
 	if (!slot)
-		return -ENOMEM;
+		return -EIO;
 
-	slot->type = val;
-	ret = rpaphp_enable_slot(slot);
-	if (!ret)
-		ret = rpaphp_register_slot(slot);
+	/* Enable slot */
+	ret = slot->hotplug_slot->ops->enable_slot(slot->hotplug_slot);
+	if (ret)
+		goto fail;
+
+	/* Register slot */
+	ret = rpaphp_register_slot(slot);
 	if (ret)
 		goto fail;
 
@@ -288,7 +205,7 @@ EXPORT_SYMBOL_GPL(rpaphp_add_slot);
 static void __exit cleanup_slots(void)
 {
 	struct list_head *tmp, *n;
-	struct slot *slot;
+	struct rpa_php_slot *slot;
 
 	/*
 	 * Unregister all of our slots with the pci_hotplug subsystem,
@@ -297,7 +214,7 @@ static void __exit cleanup_slots(void)
 	 */
 
 	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
-		slot = list_entry(tmp, struct slot, rpaphp_slot_list);
+		slot = list_entry(tmp, struct rpa_php_slot, rpaphp_slot_list);
 		list_del(&slot->rpaphp_slot_list);
 		pci_hp_deregister(slot->hotplug_slot);
 	}
@@ -320,59 +237,9 @@ static void __exit rpaphp_exit(void)
 	cleanup_slots();
 }
 
-static int enable_slot(struct hotplug_slot *hotplug_slot)
-{
-	struct slot *slot = (struct slot *)hotplug_slot->private;
-	int state;
-	int retval;
-
-	if (slot->state == CONFIGURED)
-		return 0;
-
-	retval = rpaphp_get_sensor_state(slot, &state);
-	if (retval)
-		return retval;
-
-	if (state == PRESENT) {
-		pci_lock_rescan_remove();
-		pcibios_add_pci_devices(slot->bus);
-		pci_unlock_rescan_remove();
-		slot->state = CONFIGURED;
-	} else if (state == EMPTY) {
-		slot->state = EMPTY;
-	} else {
-		err("%s: slot[%s] is in invalid state\n", __func__, slot->name);
-		slot->state = NOT_VALID;
-		return -EINVAL;
-	}
-
-	slot->bus->max_bus_speed = get_max_bus_speed(slot);
-	return 0;
-}
-
-static int disable_slot(struct hotplug_slot *hotplug_slot)
-{
-	struct slot *slot = (struct slot *)hotplug_slot->private;
-	if (slot->state == NOT_CONFIGURED)
-		return -EINVAL;
-
-	pci_lock_rescan_remove();
-	pcibios_remove_pci_devices(slot->bus);
-	pci_unlock_rescan_remove();
-	vm_unmap_aliases();
-
-	slot->state = NOT_CONFIGURED;
-	return 0;
-}
-
-struct hotplug_slot_ops rpaphp_hotplug_slot_ops = {
-	.enable_slot = enable_slot,
-	.disable_slot = disable_slot,
-	.set_attention_status = set_attention_status,
-	.get_power_status = get_power_status,
-	.get_attention_status = get_attention_status,
-	.get_adapter_status = get_adapter_status,
-};
-
 module_init(rpaphp_init);
 module_exit(rpaphp_exit);
+
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
diff --git a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
deleted file mode 100644
index a4aa65c..0000000
--- a/drivers/pci/hotplug/rpaphp_pci.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/*
- * PCI Hot Plug Controller Driver for RPA-compliant PPC64 platform.
- * Copyright (C) 2003 Linda Xie <lxie@us.ibm.com>
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <lxie@us.ibm.com>
- *
- */
-#include <linux/pci.h>
-#include <linux/string.h>
-
-#include <asm/pci-bridge.h>
-#include <asm/rtas.h>
-#include <asm/machdep.h>
-
-#include "../pci.h"		/* for pci_add_new_bus */
-#include "rpaphp.h"
-
-int rpaphp_get_sensor_state(struct slot *slot, int *state)
-{
-	int rc;
-	int setlevel;
-
-	rc = rtas_get_sensor(DR_ENTITY_SENSE, slot->index, state);
-	if (rc >= 0)
-		return rc;
-	if (rc != -EFAULT && rc != -EEXIST) {
-		err("%s: Failure %d getting sensor state on slot[%s]\n",
-		    __func__, rc, slot->name);
-		return rc;
-	}
-
-
-	/*
-	 * Some slots have to be powered up before
-	 * get-sensor will succeed
-	 */
-	dbg("%s: Slot[%s] must be power up to get sensor-state\n",
-	    __func__, slot->name);
-	rc = rtas_set_power_level(slot->power_domain, POWER_ON,
-				  &setlevel);
-	if (rc < 0) {
-		dbg("%s: Failure %d powerng on slot[%s]\n",
-		    __func__, rc, slot->name);
-		return rc;
-	}
-
-	return rtas_get_sensor(DR_ENTITY_SENSE,
-			       slot->index, state);
-}
-
-/**
- * rpaphp_enable_slot - record slot state, config pci device
- * @slot: target &slot
- *
- * Initialize values in the slot, and the hotplug_slot info
- * structures to indicate if there is a pci card plugged into
- * the slot. If the slot is not empty, run the pcibios routine
- * to get pcibios stuff correctly set up.
- */
-int rpaphp_enable_slot(struct slot *slot)
-{
-	int rc, level, state;
-	struct pci_bus *bus;
-	struct hotplug_slot_info *info = slot->hotplug_slot->info;
-
-	info->adapter_status = NOT_VALID;
-	slot->state = EMPTY;
-
-	/* Find out if the power is turned on for the slot */
-	rc = rtas_get_power_level(slot->power_domain, &level);
-	if (rc)
-		return rc;
-	info->power_status = level;
-
-	/* Figure out if there is an adapter in the slot */
-	rc = rpaphp_get_sensor_state(slot, &state);
-	if (rc)
-		return rc;
-
-	bus = pcibios_find_pci_bus(slot->dn);
-	if (!bus) {
-		err("%s: no pci_bus for dn %s\n", __func__, slot->dn->full_name);
-		return -EINVAL;
-	}
-
-	info->adapter_status = EMPTY;
-	slot->bus = bus;
-	slot->pci_devs = &bus->devices;
-
-	/* if there's an adapter in the slot, go add the pci devices */
-	if (state == PRESENT) {
-		info->adapter_status = NOT_CONFIGURED;
-		slot->state = NOT_CONFIGURED;
-
-		/* non-empty slot has to have child */
-		if (!slot->dn->child) {
-			err("%s: slot[%s]'s device_node doesn't have child for adapter\n",
-			    __func__, slot->name);
-			return -EINVAL;
-		}
-
-		if (list_empty(&bus->devices))
-			pcibios_add_pci_devices(bus);
-
-		if (!list_empty(&bus->devices)) {
-			info->adapter_status = CONFIGURED;
-			slot->state = CONFIGURED;
-		}
-
-		if (rpaphp_debug) {
-			struct pci_dev *dev;
-			dbg("%s: pci_devs of slot[%s]\n", __func__, slot->dn->full_name);
-			list_for_each_entry (dev, &bus->devices, bus_list)
-				dbg("\t%s\n", pci_name(dev));
-		}
-	}
-
-	return 0;
-}
diff --git a/drivers/pci/hotplug/rpaphp_rtas.c b/drivers/pci/hotplug/rpaphp_rtas.c
new file mode 100644
index 0000000..74f024a
--- /dev/null
+++ b/drivers/pci/hotplug/rpaphp_rtas.c
@@ -0,0 +1,320 @@
+/*
+ * RTAS backend for RPA-compliant PP64 platform
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pci.h>
+#include <linux/pci_hotplug.h>
+#include <linux/smp.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
+#include <asm/eeh.h>
+#include <asm/rtas.h>
+#include <asm/pci-bridge.h>
+
+#include "../pci.h"
+#include "rpaphp.h"
+
+#define	RPA_PHP_DR_INDICATOR	9002
+#define RPA_PHP_DR_ENTITY_SENSE	9003
+
+static int get_power_status(struct hotplug_slot *hp_slot, u8 *val)
+{
+	struct rpa_php_slot *slot = hp_slot->private;
+	int state, ret;
+
+	/* By default, the power is on */
+	*val = RPA_PHP_SLOT_POWER_ON;
+
+	/* Retrieve power state from firmware, which might fail */
+	ret = rtas_get_power_level(slot->power_domain, &state);
+	if (!ret) {
+		if (state > 0)
+			hp_slot->info->power_status = RPA_PHP_SLOT_POWER_ON;
+		else
+			hp_slot->info->power_status = RPA_PHP_SLOT_POWER_OFF;
+		*val = hp_slot->info->power_status;
+	}
+
+	return 0;
+}
+
+static int get_adapter_status(struct hotplug_slot *hp_slot, u8 *val)
+{
+	struct rpa_php_slot *slot = hp_slot->private;
+        int state, ret;
+
+	/* By default, the slot is empty */
+	*val = RPA_PHP_SLOT_EMPTY;
+
+	/* Retrieve presence from firmware */
+	ret = rtas_get_sensor(RPA_PHP_DR_ENTITY_SENSE, slot->index, &state);
+	if (ret >= 0) {
+		if (state > 0)
+			hp_slot->info->adapter_status = RPA_PHP_SLOT_PRESENT;
+		else
+			hp_slot->info->adapter_status = RPA_PHP_SLOT_EMPTY;
+		*val = hp_slot->info->adapter_status;
+		return 0;
+	}
+
+	/* Check if we need power slot on and retry */
+	if (ret != -EFAULT && ret != -EEXIST) {
+		err("%s: Error %d getting slot[%s] presence\n",
+		    __func__, ret, slot->name);
+		return ret;
+	}
+
+	/* Power slot on, which might fail */
+	ret = rtas_set_power_level(slot->power_domain,
+				   RPA_PHP_SLOT_POWER_ON, &state);
+	if (!ret)
+		hp_slot->info->power_status = RPA_PHP_SLOT_POWER_ON;
+
+	/* Recheck the presence */
+	ret = rtas_get_sensor(RPA_PHP_DR_ENTITY_SENSE, slot->index, &state);
+	if (ret >= 0) {
+		if (state > 0)
+			hp_slot->info->adapter_status = RPA_PHP_SLOT_PRESENT;
+		else
+			hp_slot->info->adapter_status = RPA_PHP_SLOT_EMPTY;
+		*val = hp_slot->info->adapter_status;
+	}
+
+	return 0;
+}
+
+static int set_attention_status(struct hotplug_slot *hp_slot, u8 val)
+{
+	struct rpa_php_slot *slot = hp_slot->private;
+	int ret;
+
+	/*
+	 * The default operation would to turn on
+	 * the attention
+	 */
+	switch (val) {
+	case RPA_PHP_SLOT_ATTEN_OFF:
+	case RPA_PHP_SLOT_ATTEN_ON:
+	case RPA_PHP_SLOT_ATTEN_IND:
+	case RPA_PHP_SLOT_ATTEN_ACT:
+		break;
+	default:
+		val = RPA_PHP_SLOT_ATTEN_ON;
+	}
+
+	/* Set the attention */
+	ret = rtas_set_indicator(RPA_PHP_DR_INDICATOR, slot->index, val);
+	if (!ret)
+		hp_slot->info->attention_status = val;
+
+	return ret;
+}
+
+static enum pci_bus_speed get_max_bus_speed(struct rpa_php_slot *slot)
+{
+	enum pci_bus_speed speed;
+
+	switch (slot->type) {
+	case 1 ... 6:
+		speed = PCI_SPEED_33MHz;
+		break;
+	case 7 ... 8:
+		speed = PCI_SPEED_66MHz;
+		break;
+	case 11:
+	case 14:
+		speed = PCI_SPEED_66MHz_PCIX;
+		break;
+	case 12:
+	case 15:
+		speed = PCI_SPEED_100MHz_PCIX;
+		break;
+	case 13:
+	case 16:
+		speed = PCI_SPEED_133MHz_PCIX;
+		break;
+	default:
+		speed = PCI_SPEED_UNKNOWN;
+	}
+
+	return speed;
+}
+
+static int enable_slot(struct hotplug_slot *hp_slot)
+{
+	struct rpa_php_slot *slot = hp_slot->private;
+	uint8_t presence;
+	int ret;
+
+	/* Check if the slot has been configured */
+	if (slot->state == RPA_PHP_SLOT_CONFIGURED)
+		return 0;
+
+	/* Retrieve slot presence status */
+	ret = hp_slot->ops->get_adapter_status(hp_slot, &presence);
+	if (ret)
+		return ret;
+
+	switch (presence) {
+	case RPA_PHP_SLOT_PRESENT:
+		pci_lock_rescan_remove();
+		pcibios_add_pci_devices(slot->bus);
+		pci_unlock_rescan_remove();
+		slot->state = RPA_PHP_SLOT_CONFIGURED;
+		break;
+	case RPA_PHP_SLOT_EMPTY:
+		slot->state = RPA_PHP_SLOT_NOT_CONFIGURED;
+		break;
+	default:
+		slot->state = RPA_PHP_SLOT_NOT_VALID;
+		return -EINVAL;
+	}
+
+	/* Fix the bus maximal speed */
+	slot->bus->max_bus_speed = get_max_bus_speed(slot);
+	return 0;
+}
+
+static int disable_slot(struct hotplug_slot *hp_slot)
+{
+	struct rpa_php_slot *slot = hp_slot->private;
+
+	if (slot->state != RPA_PHP_SLOT_CONFIGURED)
+		return 0;
+
+	pci_lock_rescan_remove();
+	pcibios_remove_pci_devices(slot->bus);
+	pci_unlock_rescan_remove();
+	vm_unmap_aliases();
+
+	slot->state = RPA_PHP_SLOT_NOT_CONFIGURED;
+	return 0;
+}
+
+static struct hotplug_slot_ops rpaphp_rtas_ops = {
+	.enable_slot		= enable_slot,
+	.disable_slot		= disable_slot,
+	.set_attention_status	= set_attention_status,
+	.get_power_status	= get_power_status,
+	.get_adapter_status	= get_adapter_status,
+};
+
+static int parse_drc_props(struct device_node *dn, u32 drc_index,
+                           char **drc_name, char **drc_type, u32 *drc_power)
+{
+	const u32 *indexes, *names, *types, *domains;
+	char *name, *type;
+	struct device_node *parent = dn;
+	u32 i;
+
+	while ((parent = of_get_parent(parent))) {
+		indexes = of_get_property(parent, "ibm,drc-indexes", NULL);
+		names   = of_get_property(parent, "ibm,drc-names", NULL);
+		types   = of_get_property(parent, "ibm,drc-types", NULL);
+		domains = of_get_property(parent, "ibm,drc-power-domains", NULL);
+
+		if (!indexes || !names || !types || !domains) {
+			of_node_put(parent);
+			continue;
+		}
+
+		name = (char *)&names[1];
+		type = (char *)&types[1];
+		for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
+			if (be32_to_cpu(indexes[i + 1]) != drc_index) {
+				name += (strlen(name) + 1);
+				type += (strlen(type) + 1);
+				continue;
+			}
+
+			/* Matched index */
+			if (drc_name)
+				*drc_name = name;
+			if (drc_type)
+				*drc_type = type;
+			if (drc_power)
+				*drc_power = be32_to_cpu(domains[i + 1]);
+
+			of_node_put(parent);
+			return 0;
+		}
+
+		/* Next level parent */
+		of_node_put(parent);
+	}
+
+	return -ENODEV;
+}
+
+/*
+ * To get the DRC props describing the current node, first obtain it's
+ * my-drc-index property.  Next obtain the DRC list from it's parent.  Use
+ * the my-drc-index for correlation, and obtain the requested properties.
+ */
+int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
+                         char **drc_name, char **drc_type, int *drc_power)
+{
+	const u32 *my_index;
+
+	/* Check if node is capable of hotplug */
+	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
+	if (!my_index)
+		return -EINVAL;
+	if (drc_index)
+		*drc_index = be32_to_cpu(*my_index);
+
+	return parse_drc_props(dn, be32_to_cpu(*my_index),
+			       drc_name, drc_type, drc_power);
+}
+EXPORT_SYMBOL_GPL(rpaphp_get_drc_props);
+
+struct rpa_php_slot *rpaphp_rtas_add_slot(struct device_node *dn)
+{
+	char *name, *type, *endptr;
+	int index, power_domain;
+	struct rpa_php_slot *slot;
+	struct pci_bus *bus;
+	int val, ret;
+
+	/* Get and parse the hotplug properties */
+	ret = rpaphp_get_drc_props(dn, &index, &name, &type, &power_domain);
+	if (ret)
+		return NULL;
+
+	/*
+	 * PCI hotplug slots have integer DRC type. That of
+	 * PHB slot is fixed to "PHB"
+	 */
+        val = simple_strtoul(type, &endptr, 10);
+	if (strcmp(type, "PHB") && (endptr == type))
+		return NULL;
+
+	slot = alloc_slot_struct(dn, index, name, power_domain);
+	if (!slot)
+		return NULL;
+
+        /* The slot should have an associated bus */
+	bus = pcibios_find_pci_bus(dn);
+	if (!bus) {
+		err("%s: No PCI bus for device node %s\n",
+			__func__, dn->full_name);
+		goto fail;
+	}
+
+	slot->hotplug_slot->ops = &rpaphp_rtas_ops;
+	slot->type     = val;
+	slot->bus      = bus;
+	slot->pci_devs = &bus->devices;
+	return slot;
+fail:
+	dealloc_slot_struct(slot);
+	return NULL;
+}
diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
deleted file mode 100644
index be48e69..0000000
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ /dev/null
@@ -1,140 +0,0 @@
-/*
- * RPA Virtual I/O device functions
- * Copyright (C) 2004 Linda Xie <lxie@us.ibm.com>
- *
- * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
- * NON INFRINGEMENT.  See the GNU General Public License for more
- * details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- * Send feedback to <lxie@us.ibm.com>
- *
- */
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/sysfs.h>
-#include <linux/pci.h>
-#include <linux/string.h>
-#include <linux/slab.h>
-
-#include <asm/rtas.h>
-#include "rpaphp.h"
-
-/* free up the memory used by a slot */
-static void rpaphp_release_slot(struct hotplug_slot *hotplug_slot)
-{
-	struct slot *slot = (struct slot *) hotplug_slot->private;
-	dealloc_slot_struct(slot);
-}
-
-void dealloc_slot_struct(struct slot *slot)
-{
-	kfree(slot->hotplug_slot->info);
-	kfree(slot->name);
-	kfree(slot->hotplug_slot);
-	kfree(slot);
-}
-
-struct slot *alloc_slot_struct(struct device_node *dn,
-                       int drc_index, char *drc_name, int power_domain)
-{
-	struct slot *slot;
-
-	slot = kzalloc(sizeof(struct slot), GFP_KERNEL);
-	if (!slot)
-		goto error_nomem;
-	slot->hotplug_slot = kzalloc(sizeof(struct hotplug_slot), GFP_KERNEL);
-	if (!slot->hotplug_slot)
-		goto error_slot;
-	slot->hotplug_slot->info = kzalloc(sizeof(struct hotplug_slot_info),
-					   GFP_KERNEL);
-	if (!slot->hotplug_slot->info)
-		goto error_hpslot;
-	slot->name = kstrdup(drc_name, GFP_KERNEL);
-	if (!slot->name)
-		goto error_info;
-	slot->dn = dn;
-	slot->index = drc_index;
-	slot->power_domain = power_domain;
-	slot->hotplug_slot->private = slot;
-	slot->hotplug_slot->ops = &rpaphp_hotplug_slot_ops;
-	slot->hotplug_slot->release = &rpaphp_release_slot;
-
-	return slot;
-
-error_info:
-	kfree(slot->hotplug_slot->info);
-error_hpslot:
-	kfree(slot->hotplug_slot);
-error_slot:
-	kfree(slot);
-error_nomem:
-	return NULL;
-}
-
-int rpaphp_deregister_slot(struct slot *slot)
-{
-	int retval = 0;
-	struct hotplug_slot *php_slot = slot->hotplug_slot;
-
-	 dbg("%s - Entry: deregistering slot=%s\n",
-		__func__, slot->name);
-
-	list_del(&slot->rpaphp_slot_list);
-
-	retval = pci_hp_deregister(php_slot);
-	if (retval)
-		err("Problem unregistering a slot %s\n", slot->name);
-
-	dbg("%s - Exit: rc[%d]\n", __func__, retval);
-	return retval;
-}
-EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
-
-int rpaphp_register_slot(struct slot *slot)
-{
-	struct hotplug_slot *php_slot = slot->hotplug_slot;
-	struct slot *tmp;
-	int retval;
-	int slotno;
-
-	dbg("%s registering slot:path[%s] index[%x], name[%s] pdomain[%x] type[%d]\n",
-		__func__, slot->dn->full_name, slot->index, slot->name,
-		slot->power_domain, slot->type);
-
-	/* Should not try to register the same slot twice */
-	list_for_each_entry(tmp, &rpaphp_slot_head, rpaphp_slot_list) {
-		if (!strcmp(tmp->name, slot->name)) {
-			err("%s: Slot[%s] is already registered\n",
-			    __func__, slot->name);
-			return -EAGAIN;
-		}
-	}
-
-	if (slot->dn->child)
-		slotno = PCI_SLOT(PCI_DN(slot->dn->child)->devfn);
-	else
-		slotno = -1;
-	retval = pci_hp_register(php_slot, slot->bus, slotno, slot->name);
-	if (retval) {
-		err("pci_hp_register failed with error %d\n", retval);
-		return retval;
-	}
-
-	/* add slot to our internal list */
-	list_add(&slot->rpaphp_slot_list, &rpaphp_slot_head);
-	info("Slot [%s] registered\n", slot->name);
-	return 0;
-}
-- 
1.8.3.2
