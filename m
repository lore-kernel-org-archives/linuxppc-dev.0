Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 941C01A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:31 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 25 Nov 2014 08:49:30 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 77CBF2CE806A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:28 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAOMnSgX33030390
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:28 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAOMnRCT025606
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Nov 2014 09:49:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org
Subject: [PATCH 7/8] PCI/hotplug/rpa: Hierarchial slots
Date: Tue, 25 Nov 2014 09:49:24 +1100
Message-Id: <1416869365-7671-8-git-send-email-gwshan@linux.vnet.ibm.com>
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

The direct or indirect parent of hotpluggable slot has possibility
to be hotpluggable. Unfortunately, current implementation doesn't
cover it. The patch fixes the issue:

   * When adding slots based on the given device node, the child
     device nodes are scanned to see if they're hotpluggable and
     add slots for them if applicable.
   * When unregistering slot, its children slots will be removed
     automatically.
   * Parent slot is added prior to child slots in addition path,
     while child slots should be removed before parent slot in
     removal path.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/rpadlpar_core.c |   6 +--
 drivers/pci/hotplug/rpaphp.h        |  22 ++++----
 drivers/pci/hotplug/rpaphp_core.c   | 105 ++++++++++++++++++++++++------------
 3 files changed, 85 insertions(+), 48 deletions(-)

diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index a36d2c9..f375e92 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -119,11 +119,9 @@ static struct device_node *find_dlpar_node(char *drc_name, int *node_type)
  */
 static struct rpa_php_slot *find_php_slot(struct device_node *dn)
 {
-	struct list_head *tmp, *n;
-	struct rpa_php_slot *slot;
+	struct rpa_php_slot *slot, *tmp;
 
-	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
-		slot = list_entry(tmp, struct rpa_php_slot, rpaphp_slot_list);
+	list_for_each_entry_safe(slot, tmp, &rpaphp_slot_head, link) {
 		if (slot->dn == dn)
 			return slot;
 	}
diff --git a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
index 09dd516..0354572 100644
--- a/drivers/pci/hotplug/rpaphp.h
+++ b/drivers/pci/hotplug/rpaphp.h
@@ -57,19 +57,21 @@ extern bool rpaphp_debug;
 #define RPA_PHP_SLOT_PRESENT	1	/* Presented     */
 
 struct rpa_php_slot {
-	struct list_head rpaphp_slot_list;
-	int state;
+	char			*name;
+	int			state;
 #define RPA_PHP_SLOT_NOT_CONFIGURED	0
 #define RPA_PHP_SLOT_CONFIGURED		1
 #define RPA_PHP_SLOT_NOT_VALID		2
-	u32 index;
-	u32 type;
-	u32 power_domain;
-	char *name;
-	struct device_node *dn;
-	struct pci_bus *bus;
-	struct list_head *pci_devs;
-	struct hotplug_slot *hotplug_slot;
+	u32			index;
+	u32			type;
+	u32			power_domain;
+	struct device_node	*dn;
+	struct pci_bus		*bus;
+	struct list_head	*pci_devs;
+	struct hotplug_slot	*hotplug_slot;
+	struct list_head	link;
+	struct list_head	list;
+	struct list_head	children;
 };
 
 extern struct list_head rpaphp_slot_head;
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index 91eff8f..ba28212 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/pci_hotplug.h>
 #include <linux/smp.h>
@@ -87,6 +88,9 @@ struct rpa_php_slot *alloc_slot_struct(struct device_node *dn,
 	slot->power_domain = power_domain;
 	slot->hotplug_slot->private = slot;
 	slot->hotplug_slot->release = &rpaphp_release_slot;
+	INIT_LIST_HEAD(&slot->link);
+	INIT_LIST_HEAD(&slot->list);
+	INIT_LIST_HEAD(&slot->children);
 
 	slot->hotplug_slot->info->power_status = RPA_PHP_SLOT_POWER_ON;
 	slot->hotplug_slot->info->attention_status = RPA_PHP_SLOT_ATTEN_OFF;
@@ -107,16 +111,17 @@ error_nomem:
 
 int rpaphp_register_slot(struct rpa_php_slot *slot)
 {
+	struct device_node *dn;
 	struct hotplug_slot *php_slot = slot->hotplug_slot;
-	struct rpa_php_slot *tmp;
-	int slotno, retval;
+	struct rpa_php_slot *parent, *tmp;
+	int slotno, ret;
 
 	dbg("%s registering slot:path[%s] index[%x], name[%s] pdomain[%x] type[%d]\n",
 	    __func__, slot->dn->full_name, slot->index, slot->name,
 	    slot->power_domain, slot->type);
 
 	/* Should not try to register the same slot twice */
-	list_for_each_entry(tmp, &rpaphp_slot_head, rpaphp_slot_list) {
+	list_for_each_entry(tmp, &rpaphp_slot_head, link) {
 		if (!strcmp(tmp->name, slot->name)) {
 			err("%s: Slot[%s] is already registered\n",
 			    __func__, slot->name);
@@ -127,34 +132,62 @@ int rpaphp_register_slot(struct rpa_php_slot *slot)
 		slotno = PCI_SLOT(PCI_DN(slot->dn->child)->devfn);
 	else
 		slotno = -1;
-	retval = pci_hp_register(php_slot, slot->bus, slotno, slot->name);
-	if (retval) {
-		err("pci_hp_register failed with error %d\n", retval);
-		return retval;
+	ret = pci_hp_register(php_slot, slot->bus, slotno, slot->name);
+	if (ret) {
+		err("pci_hp_register failed with error %d\n", ret);
+		return ret;
+	}
+
+	/* Search parent slot */
+	parent = NULL;
+	dn = slot->dn;
+	while (!parent && (dn = of_get_parent(dn))) {
+		if (!PCI_DN(dn)) {
+			of_node_put(dn);
+			break;
+		}
+
+		list_for_each_entry(tmp, &rpaphp_slot_head, link) {
+			if (tmp->dn != dn) {
+				parent = tmp;
+				break;
+			}
+		}
 	}
 
-	/* add slot to our internal list */
-	list_add(&slot->rpaphp_slot_list, &rpaphp_slot_head);
+	/* Add slot to parent list */
+	if (parent)
+		list_add(&slot->list, &parent->children);
+
+	/* Add slot to global list */
+	list_add(&slot->link, &rpaphp_slot_head);
 	info("Slot [%s] registered\n", slot->name);
 	return 0;
 }
 
 int rpaphp_deregister_slot(struct rpa_php_slot *slot)
 {
+	struct rpa_php_slot *child, *tmp;
 	struct hotplug_slot *php_slot = slot->hotplug_slot;
-	int retval = 0;
+	int ret;
 
-	dbg("%s - Entry: deregistering slot=%s\n",
-	    __func__, slot->name);
+	/* Unregister children firstly */
+	list_for_each_entry_safe(child, tmp, &slot->children, list) {
+		ret = rpaphp_deregister_slot(child);
+		if (ret)
+			return ret;
+	}
 
-	list_del(&slot->rpaphp_slot_list);
+	/* Remove from the parent and global lists */
+	list_del(&slot->list);
+	list_del(&slot->link);
 
-	retval = pci_hp_deregister(php_slot);
-	if (retval)
-		err("Problem unregistering a slot %s\n", slot->name);
+	ret = pci_hp_deregister(php_slot);
+	if (ret)
+		err("%s: Error %d unregistering slot[%s]\n",
+		    __func__, ret, slot->name);
 
-	dbg("%s - Exit: rc[%d]\n", __func__, retval);
-	return retval;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
 
@@ -176,24 +209,31 @@ EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
  */
 int rpaphp_add_slot(struct device_node *dn)
 {
+	struct device_node *child;
 	struct rpa_php_slot *slot = NULL;
 	int ret;
 
 	/* Create slot */
 	if (machine_is(pseries))
 		slot = rpaphp_rtas_add_slot(dn);
-	if (!slot)
-		return -EIO;
 
-	/* Enable slot */
-	ret = slot->hotplug_slot->ops->enable_slot(slot->hotplug_slot);
-	if (ret)
-		goto fail;
+	if (slot) {
+		/* Enable slot */
+		ret = slot->hotplug_slot->ops->enable_slot(slot->hotplug_slot);
+		if (ret)
+			goto fail;
 
-	/* Register slot */
-	ret = rpaphp_register_slot(slot);
-	if (ret)
-		goto fail;
+		/* Register slot */
+		ret = rpaphp_register_slot(slot);
+		if (ret)
+			goto fail;
+	}
+
+	for_each_child_of_node(dn, child) {
+		ret = rpaphp_add_slot(child);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 fail:
@@ -204,18 +244,15 @@ EXPORT_SYMBOL_GPL(rpaphp_add_slot);
 
 static void __exit cleanup_slots(void)
 {
-	struct list_head *tmp, *n;
-	struct rpa_php_slot *slot;
+	struct rpa_php_slot *slot, *tmp;
 
 	/*
 	 * Unregister all of our slots with the pci_hotplug subsystem,
 	 * and free up all memory that we had allocated.
 	 * memory will be freed in release_slot callback.
 	 */
-
-	list_for_each_safe(tmp, n, &rpaphp_slot_head) {
-		slot = list_entry(tmp, struct rpa_php_slot, rpaphp_slot_list);
-		list_del(&slot->rpaphp_slot_list);
+	list_for_each_entry_safe(slot, tmp, &rpaphp_slot_head, link) {
+		list_del(&slot->link);
 		pci_hp_deregister(slot->hotplug_slot);
 	}
 }
-- 
1.8.3.2
