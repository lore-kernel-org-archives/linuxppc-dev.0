Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ECCFBDDF27
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:43:52 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l330hlqK027683
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:43:47 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330hlUp039892
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 18:43:47 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330hknl021000
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 18:43:47 -0600
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 11/19] PCI: rpaphp: remove print_slot_pci_funcs()
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Message-Id: <20070403004346.B7CF93A65C@topology.austin.ibm.com>
Date: Mon,  2 Apr 2007 19:43:46 -0500 (CDT)
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


The debug function print_slot_pci_funcs() is a large wrapper
around two debug print statements.  Just invoke these directly.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----

 drivers/pci/hotplug/rpaphp_pci.c |   23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-03-28 18:11:03.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c	2007-03-28 18:11:36.000000000 -0500
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
