Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 246B4DDDFD
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:34:51 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l330YlPR029072
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:34:47 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330YlXJ260314
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:34:47 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330Ykrq001751
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:34:47 -0400
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 2/19] PCI: rpaphp: Remove global num_slots variable
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Message-Id: <20070403003446.477433A65C@topology.austin.ibm.com>
Date: Mon,  2 Apr 2007 19:34:46 -0500 (CDT)
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


Cleanup cruft: remove the global "num_slots" variable; 
although scattered across multiple files, it is used only 
once, in a debug statement.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp.h      |    1 -
 drivers/pci/hotplug/rpaphp_core.c |    4 +---
 drivers/pci/hotplug/rpaphp_slot.c |    3 ---
 3 files changed, 1 insertion(+), 7 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-03-28 11:10:47.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-03-28 17:38:24.000000000 -0500
@@ -41,7 +41,6 @@
 int debug;
 static struct semaphore rpaphp_sem;
 LIST_HEAD(rpaphp_slot_head);
-int num_slots;
 
 #define DRIVER_VERSION	"0.1"
 #define DRIVER_AUTHOR	"Linda Xie <lxie@us.ibm.com>"
@@ -325,8 +324,7 @@ int rpaphp_add_slot(struct device_node *
 		name += strlen(name) + 1;
 		type += strlen(type) + 1;
 	}
-	dbg("%s - Exit: num_slots=%d rc[%d]\n",
-	    __FUNCTION__, num_slots, retval);
+	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
 	return retval;
 }
 
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_slot.c	2007-03-28 11:10:08.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c	2007-03-28 17:38:24.000000000 -0500
@@ -140,8 +140,6 @@ int rpaphp_deregister_slot(struct slot *
 	retval = pci_hp_deregister(php_slot);
 	if (retval)
 		err("Problem unregistering a slot %s\n", slot->name);
-	else
-		num_slots--;
 
 	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
 	return retval;
@@ -181,7 +179,6 @@ int rpaphp_register_slot(struct slot *sl
 	list_add(&slot->rpaphp_slot_list, &rpaphp_slot_head);
 	info("Slot [%s](PCI location=%s) registered\n", slot->name,
 			slot->location);
-	num_slots++;
 	return 0;
 
 sysfs_fail:
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp.h
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp.h	2007-03-28 17:38:24.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp.h	2007-03-28 17:38:49.000000000 -0500
@@ -83,7 +83,6 @@ struct slot {
 
 extern struct hotplug_slot_ops rpaphp_hotplug_slot_ops;
 extern struct list_head rpaphp_slot_head;
-extern int num_slots;
 
 /* function prototypes */
 
