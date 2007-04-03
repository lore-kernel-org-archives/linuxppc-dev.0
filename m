Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0267BDDEBA
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:25:02 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33HOt2i007884
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:24:55 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HOtNQ296764
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:24:55 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HOs5v027883
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:24:55 -0400
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 10/19] PCI: rpaphp: Remove setup_pci_slot()
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403172454.17C413A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:24:54 -0500 (CDT)
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	pcihpd-discuss@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The setup_pci_slot() routine appears to be nothing else than
a big, complicated wrapper around pcibios_add_pci_devices().
Remove the wrapping, and call pcibios_add_pci_devices() directly.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp_pci.c |   96 +++++++++++++--------------------------
 1 file changed, 33 insertions(+), 63 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:25.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:28.000000000 -0500
@@ -92,64 +92,15 @@ static void set_slot_name(struct slot *s
 			bus->number);
 }
 
-static int setup_pci_slot(struct slot *slot)
-{
-	struct device_node *dn = slot->dn;
-	struct pci_bus *bus;
-
-	BUG_ON(!dn);
-	bus = pcibios_find_pci_bus(dn);
-	if (!bus) {
-		err("%s: no pci_bus for dn %s\n", __FUNCTION__, dn->full_name);
-		goto exit_rc;
-	}
-
-	slot->bus = bus;
-	slot->pci_devs = &bus->devices;
-	set_slot_name(slot);
-
-	/* find slot's pci_dev if it's not empty */
-	if (slot->hotplug_slot->info->adapter_status == EMPTY) {
-		slot->state = EMPTY;	/* slot is empty */
-	} else {
-		/* slot is occupied */
-		if (!dn->child) {
-			/* non-empty slot has to have child */
-			err("%s: slot[%s]'s device_node doesn't have child for adapter\n", 
-				__FUNCTION__, slot->name);
-			goto exit_rc;
-		}
-
-		if (slot->hotplug_slot->info->adapter_status == NOT_CONFIGURED) {
-			dbg("%s CONFIGURING pci adapter in slot[%s]\n",  
-				__FUNCTION__, slot->name);
-			pcibios_add_pci_devices(slot->bus);
-
-		} else if (slot->hotplug_slot->info->adapter_status != CONFIGURED) {
-			err("%s: slot[%s]'s adapter_status is NOT_VALID.\n",
-				__FUNCTION__, slot->name);
-			goto exit_rc;
-		}
-		print_slot_pci_funcs(slot->bus);
-		if (!list_empty(slot->pci_devs)) {
-			slot->state = CONFIGURED;
-		} else {
-			/* DLPAR add as opposed to 
-		 	 * boot time */
-			slot->state = NOT_CONFIGURED;
-		}
-	}
-	return 0;
-exit_rc:
-	return -EINVAL;
-}
-
 int rpaphp_register_pci_slot(struct slot *slot)
 {
 	int rc, level, state;
 	struct pci_bus *bus;
 	struct hotplug_slot_info *info = slot->hotplug_slot->info;
 
+	info->adapter_status = NOT_VALID;
+	slot->state = EMPTY;
+
 	/* Find out if the power is turned on for the slot */
 	rc = rtas_get_power_level(slot->power_domain, &level);
 	if (rc)
@@ -157,23 +108,42 @@ int rpaphp_register_pci_slot(struct slot
 	info->power_status = level;
 
 	/* Figure out if there is an adapter in the slot */
-	info->adapter_status = NOT_VALID;
 	rc = rpaphp_get_sensor_state(slot, &state);
 	if (rc)
 		return rc;
 
-	if (state == EMPTY)
-		info->adapter_status = EMPTY;
-	else if (state == PRESENT) {
-		bus = pcibios_find_pci_bus(slot->dn);
-		if (bus && !list_empty(&bus->devices))
-			info->adapter_status = CONFIGURED;
-		else
-			info->adapter_status = NOT_CONFIGURED;
+	bus = pcibios_find_pci_bus(slot->dn);
+	if (!bus) {
+		err("%s: no pci_bus for dn %s\n", __FUNCTION__, slot->dn->full_name);
+		return -EINVAL;
 	}
 
-	if (setup_pci_slot(slot))
-		return -EINVAL;
+	info->adapter_status = EMPTY;
+	slot->bus = bus;
+	slot->pci_devs = &bus->devices;
+	set_slot_name(slot);
+
+	/* if there's an adapter in the slot, go add the pci devices */
+	if (state == PRESENT) {
+		info->adapter_status = NOT_CONFIGURED;
+		slot->state = NOT_CONFIGURED;
+
+		/* non-empty slot has to have child */
+		if (!slot->dn->child) {
+			err("%s: slot[%s]'s device_node doesn't have child for adapter\n",
+			    __FUNCTION__, slot->name);
+			return -EINVAL;
+		}
+
+		if (list_empty(&bus->devices))
+			pcibios_add_pci_devices(bus);
+
+		print_slot_pci_funcs(bus);
+		if (!list_empty(&bus->devices)) {
+			info->adapter_status = CONFIGURED;
+			slot->state = CONFIGURED;
+		}
+	}
 
 	return rpaphp_register_slot(slot);
 }
