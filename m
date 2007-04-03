Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 76EFBDE337
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:28:58 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33HStri004375
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:28:55 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HSt0B062380
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:28:55 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HSs9b013737
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:28:55 -0600
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 14/19] PCI: rpaphp: Rename rpaphp_register_pci_slot() to
	rpaphp_enable_slot()
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403172854.4F6383A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:28:54 -0500 (CDT)
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


Rename rpaphp_register_pci_slot() because its easy to confuse
with  rpaphp_register_slot() even though it does something 
completely different. Rename it to rpaphp_enable_slot() because
its almost identical to enbale_slot().

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp.h      |    4 +---
 drivers/pci/hotplug/rpaphp_core.c |    2 +-
 drivers/pci/hotplug/rpaphp_pci.c  |   10 +++++++++-
 3 files changed, 11 insertions(+), 5 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp.h
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp.h	2007-04-03 11:04:32.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp.h	2007-04-03 11:04:37.000000000 -0500
@@ -87,13 +87,11 @@ extern struct list_head rpaphp_slot_head
 /* function prototypes */
 
 /* rpaphp_pci.c */
-extern int rpaphp_enable_pci_slot(struct slot *slot);
-extern int rpaphp_register_pci_slot(struct slot *slot);
+extern int rpaphp_enable_slot(struct slot *slot);
 extern int rpaphp_get_sensor_state(struct slot *slot, int *state);
 
 /* rpaphp_core.c */
 extern int rpaphp_add_slot(struct device_node *dn);
-extern int rpaphp_remove_slot(struct slot *slot);
 extern int rpaphp_get_drc_props(struct device_node *dn, int *drc_index,
 		char **drc_name, char **drc_type, int *drc_power_domain);
 
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:35.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:37.000000000 -0500
@@ -318,7 +318,7 @@ int rpaphp_add_slot(struct device_node *
 		dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
 				indexes[i + 1], name, type);
 
-		retval = rpaphp_register_pci_slot(slot);
+		retval = rpaphp_enable_slot(slot);
 		if (!retval)
 			retval = rpaphp_register_slot(slot);
 
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:35.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:37.000000000 -0500
@@ -77,7 +77,15 @@ static void set_slot_name(struct slot *s
 			bus->number);
 }
 
-int rpaphp_register_pci_slot(struct slot *slot)
+/**
+ * rpaphp_enable_slot - record slot state, config pci device
+ *
+ * Initialize values in the slot, and the hotplug_slot info
+ * structures to indicate if there is a pci card plugged into
+ * the slot. If the slot is not empty, run the pcibios routine
+ * to get pcibios stuff correctly set up.
+ */
+int rpaphp_enable_slot(struct slot *slot)
 {
 	int rc, level, state;
 	struct pci_bus *bus;
