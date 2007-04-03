Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC876DDF18
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:09:04 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33H8rp8025247
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:08:53 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33H8rGM056368
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:08:53 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33H8qwl011037
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:08:53 -0400
To: Kristen@austin.ibm.com, Carlson@austin.ibm.com,
	"Accardi <kristen.c.accardi"@intel.com
Subject: [PATCH 4/19] PCI: rpaphp: Fix a memleak;
	slot->location string was never freed
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403170852.211083A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:08:52 -0500 (CDT)
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


Fix a memleak; the slot->location string was never freed.
Fix some whitespace and overlong-line probelms while we're here.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp_slot.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_slot.c	2007-04-03 11:04:16.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c	2007-04-03 11:04:18.000000000 -0500
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
