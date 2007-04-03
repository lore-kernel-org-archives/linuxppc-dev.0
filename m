Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F153BDDE3B
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:36:49 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l330YbZb029811
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:34:37 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330alhX194638
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 18:36:47 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330akCo006473
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 18:36:47 -0600
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 4/19] PCI: rpaphp: Fix a memleak;
	slot->location string was never freed
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Message-Id: <20070403003646.5F7023A65C@topology.austin.ibm.com>
Date: Mon,  2 Apr 2007 19:36:46 -0500 (CDT)
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


Fix a memleak; the slot->location string was never freed.
Fix some whitespace and overlong-line probelms while we're here.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp_slot.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_slot.c	2007-03-28 18:02:42.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c	2007-03-28 18:07:28.000000000 -0500
@@ -56,7 +56,6 @@ static struct hotplug_slot_attribute php
 static void rpaphp_release_slot(struct hotplug_slot *hotplug_slot)
 {
 	struct slot *slot = (struct slot *) hotplug_slot->private;
-
 	dealloc_slot_struct(slot);
 }
 
@@ -65,12 +64,12 @@ void dealloc_slot_struct(struct slot *sl
 	kfree(slot->hotplug_slot->info);
 	kfree(slot->hotplug_slot->name);
 	kfree(slot->hotplug_slot);
+	kfree(slot->location);
 	kfree(slot);
-	return;
 }
 
-struct slot *alloc_slot_struct(struct device_node *dn, int drc_index, char *drc_name,
-		  int power_domain)
+struct slot *alloc_slot_struct(struct device_node *dn,
+                       int drc_index, char *drc_name, int power_domain)
 {
 	struct slot *slot;
 	
@@ -115,7 +114,7 @@ error_nomem:
 
 static int is_registered(struct slot *slot)
 {
-	struct slot             *tmp_slot;
+	struct slot *tmp_slot;
 
 	list_for_each_entry(tmp_slot, &rpaphp_slot_head, rpaphp_slot_list) {
 		if (!strcmp(tmp_slot->name, slot->name))
