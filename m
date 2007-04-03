Return-Path: <linas@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3AA80DDF96
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:47:52 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l330llOn020760
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:47:47 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330llKt265902
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:47:47 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330llU4026912
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:47:47 -0400
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 15/19] PCI: rpaphp: Document find_php_slot()
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Message-Id: <20070403004746.ECA163A65C@topology.austin.ibm.com>
Date: Mon,  2 Apr 2007 19:47:46 -0500 (CDT)
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


Document some of the interaction between dlpar and hotplug.
viz, the a dlpar remove of a htoplug slot uses hotplug to remove it.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpadlpar_core.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpadlpar_core.c	2007-04-02 14:34:46.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpadlpar_core.c	2007-04-02 14:40:09.000000000 -0500
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
