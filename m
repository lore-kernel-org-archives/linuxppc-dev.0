Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ECE11DE014
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:29:59 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33HTvum008549
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:29:57 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HTuSM059518
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:29:56 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HTtIb018440
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:29:56 -0600
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 15/19] PCI: rpaphp: Document find_php_slot()
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403172954.5AE633A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:29:54 -0500 (CDT)
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


Document some of the interaction between dlpar and hotplug.
viz, the a dlpar remove of a htoplug slot uses hotplug to remove it.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpadlpar_core.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpadlpar_core.c	2007-04-03 11:00:47.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpadlpar_core.c	2007-04-03 11:04:39.000000000 -0500
@@ -98,7 +98,15 @@ static struct device_node *find_dlpar_no
 	return NULL;
 }
 
-static struct slot *find_slot(struct device_node *dn)
+/**
+ * find_php_slot - return hotplug slot structure for device node
+ *
+ * This routine will return the hotplug slot structure
+ * for a given device node. Note that built-in PCI slots
+ * may be dlpar-able, but not hot-pluggable, so this routine
+ * will return NULL for built-in PCI slots.
+ */
+static struct slot *find_php_slot(struct device_node *dn)
 {
 	struct list_head *tmp, *n;
 	struct slot *slot;
@@ -224,9 +232,9 @@ static int dlpar_remove_phb(char *drc_na
 	if (!pcibios_find_pci_bus(dn))
 		return -EINVAL;
 
-	slot = find_slot(dn);
+	/* If pci slot is hotplugable, use hotplug to remove it */
+	slot = find_php_slot(dn);
 	if (slot) {
-		/* Remove hotplug slot */
 		if (rpaphp_deregister_slot(slot)) {
 			printk(KERN_ERR
 				"%s: unable to remove hotplug slot %s\n",
@@ -370,9 +378,9 @@ int dlpar_remove_pci_slot(char *drc_name
 	if (!bus)
 		return -EINVAL;
 
-	slot = find_slot(dn);
+	/* If pci slot is hotplugable, use hotplug to remove it */
+	slot = find_php_slot(dn);
 	if (slot) {
-		/* Remove hotplug slot */
 		if (rpaphp_deregister_slot(slot)) {
 			printk(KERN_ERR
 				"%s: unable to remove hotplug slot %s\n",
