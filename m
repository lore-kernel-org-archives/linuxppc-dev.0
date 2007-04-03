Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DBF4BDDEFF
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:40:51 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l330fXlS028108
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:41:33 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330elvm309972
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:40:47 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330ekF0007001
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:40:47 -0400
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 8/19] PCI: rpaphp: Remove another wrappered function
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Message-Id: <20070403004046.9344B3A65C@topology.austin.ibm.com>
Date: Mon,  2 Apr 2007 19:40:46 -0500 (CDT)
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove another stove-pipe; this funcion was called from
two different places, with a compile-time const that is
then run-time checked to perform two different things.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp.h      |    1 
 drivers/pci/hotplug/rpaphp_core.c |   16 ++++++++--
 drivers/pci/hotplug/rpaphp_pci.c  |   59 ++++++++++----------------------------
 3 files changed, 29 insertions(+), 47 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-03-28 18:10:19.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-03-28 18:10:22.000000000 -0500
@@ -130,12 +130,22 @@ static int get_attention_status(struct h
 static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 * value)
 {
 	struct slot *slot = (struct slot *)hotplug_slot->private;
-	int retval = 0;
+	int rc, state;
 
 	down(&rpaphp_sem);
-	retval = rpaphp_get_pci_adapter_status(slot, 0, value);
+	rc = rpaphp_get_sensor_state(slot, &state);
 	up(&rpaphp_sem);
-	return retval;
+
+	*value = NOT_VALID;
+	if (rc)
+		return rc;
+
+	if (state == EMPTY)
+		*value = EMPTY;
+	else if (state == PRESENT)
+		*value = slot->state;
+
+	return 0;
 }
 
 static int get_max_bus_speed(struct hotplug_slot *hotplug_slot, enum pci_bus_speed *value)
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-03-28 18:10:19.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c	2007-03-28 18:10:22.000000000 -0500
@@ -64,43 +64,6 @@ int rpaphp_get_sensor_state(struct slot 
 	return rc;
 }
 
-/**
- * get_pci_adapter_status - get the status of a slot
- * 
- * 0-- slot is empty
- * 1-- adapter is configured
- * 2-- adapter is not configured
- * 3-- not valid
- */
-int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value)
-{
-	struct pci_bus *bus;
-	int state, rc;
-
-	*value = NOT_VALID;
-	rc = rpaphp_get_sensor_state(slot, &state);
-	if (rc)
-		goto exit;
-
- 	if (state == EMPTY)
- 		*value = EMPTY;
- 	else if (state == PRESENT) {
-		if (!is_init) {
-			/* at run-time slot->state can be changed by */
-			/* config/unconfig adapter */
-			*value = slot->state;
-		} else {
-			bus = pcibios_find_pci_bus(slot->dn);
-			if (bus && !list_empty(&bus->devices))
-				*value = CONFIGURED;
-			else
-				*value = NOT_CONFIGURED;
-		}
-	}
-exit:
-	return rc;
-}
-
 static void print_slot_pci_funcs(struct pci_bus *bus)
 {
 	struct device_node *dn;
@@ -183,20 +146,30 @@ exit_rc:
 
 int rpaphp_register_pci_slot(struct slot *slot)
 {
-	int rc, level;
+	int rc, level, state;
+	struct pci_bus *bus;
 	struct hotplug_slot_info *info = slot->hotplug_slot->info;
 
+	/* Find out if the power is turned on for the slot */
 	rc = rtas_get_power_level(slot->power_domain, &level);
 	if (rc)
 		return rc;
 	info->power_status = level;
 
-	rpaphp_get_pci_adapter_status(slot, 1, &info->adapter_status);
+	/* Figure out if there is an adapter in the slot */
+	info->adapter_status = NOT_VALID;
+	rc = rpaphp_get_sensor_state(slot, &state);
+	if (rc)
+		return rc;
 
-	if (info->adapter_status == NOT_VALID) {
-		err("%s: NOT_VALID: skip dn->full_name=%s\n",
-		    __FUNCTION__, slot->dn->full_name);
-		return -EINVAL;
+	if (state == EMPTY)
+		info->adapter_status = EMPTY;
+	else if (state == PRESENT) {
+		bus = pcibios_find_pci_bus(slot->dn);
+		if (bus && !list_empty(&bus->devices))
+			info->adapter_status = CONFIGURED;
+		else
+			info->adapter_status = NOT_CONFIGURED;
 	}
 
 	if (setup_pci_slot(slot))
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp.h
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp.h	2007-03-28 18:10:19.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp.h	2007-03-28 18:10:22.000000000 -0500
@@ -89,7 +89,6 @@ extern struct list_head rpaphp_slot_head
 /* rpaphp_pci.c */
 extern int rpaphp_enable_pci_slot(struct slot *slot);
 extern int rpaphp_register_pci_slot(struct slot *slot);
-extern int rpaphp_get_pci_adapter_status(struct slot *slot, int is_init, u8 * value);
 extern int rpaphp_get_sensor_state(struct slot *slot, int *state);
 
 /* rpaphp_core.c */
