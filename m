Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C709767BDC
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Nov 2006 08:13:36 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAGLDsmK009841
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 16:13:54 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAGLDUNE211926
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 16:13:30 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAGLDTiM026705
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 16:13:30 -0500
Date: Thu, 16 Nov 2006 15:13:29 -0600
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH]: Janitor PCI rpaphp: compiler warning cleanup
Message-ID: <20061116211329.GD23600@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz,
	pcihpd-discuss@lists.sourceforge.net, johnrose@us.ibm.com,
	Greg KH <greg@kroah.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Kirsten,

I sent this yesterday to GregKH under the mistaken impression 
he was the maintainer. :-) So I'm resending again today.

This is a non-urgent janitorial patch. Please apply.

--linas

This janitorial patch removes the following annoying 
compile-time message:

drivers/pci/hotplug/rpaphp_slot.c:57: warning: ignoring return
value of sfs_create_file declared with attribute warn_unused_result

It also fixes a typo, removes some misc crud.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@us.ibm.com>

----

 drivers/pci/hotplug/rpaphp_slot.c |   45 +++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

Index: linux-2.6.19-rc4-git3/drivers/pci/hotplug/rpaphp_slot.c
===================================================================
--- linux-2.6.19-rc4-git3.orig/drivers/pci/hotplug/rpaphp_slot.c	2006-09-19 22:42:06.000000000 -0500
+++ linux-2.6.19-rc4-git3/drivers/pci/hotplug/rpaphp_slot.c	2006-11-15 13:44:08.000000000 -0600
@@ -47,21 +47,11 @@ static ssize_t location_read_file (struc
 	return retval;
 }
 
-static struct hotplug_slot_attribute hotplug_slot_attr_location = {
+static struct hotplug_slot_attribute php_attr_location = {
 	.attr = {.name = "phy_location", .mode = S_IFREG | S_IRUGO},
 	.show = location_read_file,
 };
 
-static void rpaphp_sysfs_add_attr_location (struct hotplug_slot *slot)
-{
-	sysfs_create_file(&slot->kobj, &hotplug_slot_attr_location.attr);
-}
-
-static void rpaphp_sysfs_remove_attr_location (struct hotplug_slot *slot)
-{
-	sysfs_remove_file(&slot->kobj, &hotplug_slot_attr_location.attr);
-}
-
 /* free up the memory used by a slot */
 static void rpaphp_release_slot(struct hotplug_slot *hotplug_slot)
 {
@@ -145,7 +135,7 @@ int rpaphp_deregister_slot(struct slot *
 	list_del(&slot->rpaphp_slot_list);
 	
 	/* remove "phy_location" file */
-	rpaphp_sysfs_remove_attr_location(php_slot);
+	sysfs_remove_file(&php_slot->kobj, &php_attr_location.attr);
 
 	retval = pci_hp_deregister(php_slot);
 	if (retval)
@@ -160,36 +150,43 @@ EXPORT_SYMBOL_GPL(rpaphp_deregister_slot
 
 int rpaphp_register_slot(struct slot *slot)
 {
+	struct hotplug_slot *php_slot = slot->hotplug_slot;
 	int retval;
 
 	dbg("%s registering slot:path[%s] index[%x], name[%s] pdomain[%x] type[%d]\n", 
 		__FUNCTION__, slot->dn->full_name, slot->index, slot->name, 
 		slot->power_domain, slot->type);
+
 	/* should not try to register the same slot twice */
-	if (is_registered(slot)) { /* should't be here */
+	if (is_registered(slot)) {
 		err("rpaphp_register_slot: slot[%s] is already registered\n", slot->name);
-		rpaphp_release_slot(slot->hotplug_slot);
-		return -EAGAIN;
+		retval = -EAGAIN;
+		goto register_fail;
 	}	
-	retval = pci_hp_register(slot->hotplug_slot);
+
+	retval = pci_hp_register(php_slot);
 	if (retval) {
 		err("pci_hp_register failed with error %d\n", retval);
-		rpaphp_release_slot(slot->hotplug_slot);
-		return retval;
+		goto register_fail;
 	}
-	
-	/* create "phy_locatoin" file */
-	rpaphp_sysfs_add_attr_location(slot->hotplug_slot);	
 
-	/* add slot to our internal list */
-	dbg("%s adding slot[%s] to rpaphp_slot_list\n",
-	    __FUNCTION__, slot->name);
+	/* create "phy_location" file */
+	retval = sysfs_create_file(&php_slot->kobj, &php_attr_location.attr);
+	if (retval) {
+		err("sysfs_create_file failed with error %d\n", retval);
+		goto register_fail;
+	}
 
+	/* add slot to our internal list */
 	list_add(&slot->rpaphp_slot_list, &rpaphp_slot_head);
 	info("Slot [%s](PCI location=%s) registered\n", slot->name,
 			slot->location);
 	num_slots++;
 	return 0;
+
+register_fail:
+	rpaphp_release_slot(php_slot);
+	return retval;
 }
 
 int rpaphp_get_power_status(struct slot *slot, u8 * value)
