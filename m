Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 48615DDF72
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:46:52 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l330kltr005817
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:46:47 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330klKH292688
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:46:47 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330klxf025480
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:46:47 -0400
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 14/19] PCI: rpaphp: Rename rpaphp_register_pci_slot() to
	rpaphp_enable_slot()
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Message-Id: <20070403004646.DF2E93A65C@topology.austin.ibm.com>
Date: Mon,  2 Apr 2007 19:46:46 -0500 (CDT)
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
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp.h	2007-04-02 14:34:46.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp.h	2007-04-02 14:40:07.000000000 -0500
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
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-04-02 14:40:00.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-04-02 14:40:07.000000000 -0500
@@ -318,7 +318,7 @@ int rpaphp_add_slot(struct device_node *
 		dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
 				indexes[i + 1], name, type);
 
-		retval = rpaphp_register_pci_slot(slot);
+		retval = rpaphp_enable_slot(slot);
 		if (!retval)
 			retval = rpaphp_register_slot(slot);
 
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-04-02 14:40:00.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c	2007-04-02 14:40:07.000000000 -0500
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
