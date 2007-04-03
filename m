Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E4381DDEBF
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:38:51 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l330cl57024708
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:38:47 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330clDJ306800
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:38:47 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330ck47031925
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:38:47 -0400
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 6/19] PCI: rpaphp: remove a function that does nothing but
	wrap debug printk's
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Message-Id: <20070403003846.7A5FD3A65C@topology.austin.ibm.com>
Date: Mon,  2 Apr 2007 19:38:46 -0500 (CDT)
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


Remove a stove-pipe-- a function that is called from only one place, 
does nothing but wraps another function with debug printk's.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp_pci.c |   37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-03-28 18:02:42.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c	2007-03-28 18:10:17.000000000 -0500
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
 
