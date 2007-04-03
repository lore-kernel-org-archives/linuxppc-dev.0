Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4EB2DDDFD3
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:21:01 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33HKt5a015038
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:20:55 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HKsAk066482
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:20:54 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HKscY030014
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:20:54 -0600
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 6/19] PCI: rpaphp: remove a function that does nothing but
	wrap debug printk's
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403172053.D8F5F3A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:20:53 -0500 (CDT)
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


Remove a stove-pipe-- a function that is called from only one place, 
does nothing but wraps another function with debug printk's.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp_pci.c |   37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:16.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:21.000000000 -0500
@@ -116,23 +116,6 @@ static void print_slot_pci_funcs(struct 
 	return;
 }
 
-static int setup_pci_hotplug_slot_info(struct slot *slot)
-{
-	struct hotplug_slot_info *hotplug_slot_info = slot->hotplug_slot->info;
-
-	dbg("%s Initilize the PCI slot's hotplug->info structure ...\n",
-	    __FUNCTION__);
-	rpaphp_get_power_status(slot, &hotplug_slot_info->power_status);
-	rpaphp_get_pci_adapter_status(slot, 1,
-				      &hotplug_slot_info->adapter_status);
-	if (hotplug_slot_info->adapter_status == NOT_VALID) {
-		err("%s: NOT_VALID: skip dn->full_name=%s\n",
-		    __FUNCTION__, slot->dn->full_name);
-		return -EINVAL;
-	}
-	return 0;
-}
-
 static void set_slot_name(struct slot *slot)
 {
 	struct pci_bus *bus = slot->bus;
@@ -200,14 +183,20 @@ exit_rc:
 
 int rpaphp_register_pci_slot(struct slot *slot)
 {
-	int rc = -EINVAL;
+	struct hotplug_slot_info *info = slot->hotplug_slot->info;
+
+	rpaphp_get_power_status(slot, &info->power_status);
+	rpaphp_get_pci_adapter_status(slot, 1, &info->adapter_status);
+
+	if (info->adapter_status == NOT_VALID) {
+		err("%s: NOT_VALID: skip dn->full_name=%s\n",
+		    __FUNCTION__, slot->dn->full_name);
+		return -EINVAL;
+	}
 
-	if (setup_pci_hotplug_slot_info(slot))
-		goto exit_rc;
 	if (setup_pci_slot(slot))
-		goto exit_rc;
-	rc = rpaphp_register_slot(slot);
-exit_rc:
-	return rc;
+		return -EINVAL;
+
+	return rpaphp_register_slot(slot);
 }
 
