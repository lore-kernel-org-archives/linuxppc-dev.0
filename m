Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3200DDDF0E
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:25:58 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33HPtNG032561
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:25:55 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HPttK055168
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:25:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HPs3T006450
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:25:55 -0600
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 11/19] PCI: rpaphp: remove print_slot_pci_funcs()
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403172554.23FD53A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:25:54 -0500 (CDT)
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


The debug function print_slot_pci_funcs() is a large wrapper
around two debug print statements.  Just invoke these directly.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----

 drivers/pci/hotplug/rpaphp_pci.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:28.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:30.000000000 -0500
@@ -64,21 +64,6 @@ int rpaphp_get_sensor_state(struct slot 
 	return rc;
 }
 
-static void print_slot_pci_funcs(struct pci_bus *bus)
-{
-	struct device_node *dn;
-	struct pci_dev *dev;
-
-	dn = pci_bus_to_OF_node(bus);
-	if (!dn)
-		return;
-
-	dbg("%s: pci_devs of slot[%s]\n", __FUNCTION__, dn->full_name);
-	list_for_each_entry (dev, &bus->devices, bus_list)
-		dbg("\t%s\n", pci_name(dev));
-	return;
-}
-
 static void set_slot_name(struct slot *slot)
 {
 	struct pci_bus *bus = slot->bus;
@@ -138,11 +123,17 @@ int rpaphp_register_pci_slot(struct slot
 		if (list_empty(&bus->devices))
 			pcibios_add_pci_devices(bus);
 
-		print_slot_pci_funcs(bus);
 		if (!list_empty(&bus->devices)) {
 			info->adapter_status = CONFIGURED;
 			slot->state = CONFIGURED;
 		}
+
+		if (debug) {
+			struct pci_dev *dev;
+			dbg("%s: pci_devs of slot[%s]\n", __FUNCTION__, slot->dn->full_name);
+			list_for_each_entry (dev, &bus->devices, bus_list)
+				dbg("\t%s\n", pci_name(dev));
+		}
 	}
 
 	return rpaphp_register_slot(slot);
