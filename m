Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3056EDDFB1
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:48:52 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l330mmtK007387
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:48:48 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330mlGK260274
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:48:47 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330mlvJ017780
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:48:47 -0400
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 16/19] PCI: rpaphp: Document is_php_dn()
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Message-Id: <20070403004847.0409E3A65C@topology.austin.ibm.com>
Date: Mon,  2 Apr 2007 19:48:46 -0500 (CDT)
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


Fix up the documentation: the rpaphp_add_slot() does not actually
handle embedded slots: in fact, it ignores them. Fix the flow of
control in the routine that checks for embedded slots.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp_core.c |   42 ++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 13 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-04-02 14:40:07.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-04-02 14:40:10.000000000 -0500
@@ -262,6 +262,14 @@ static int is_php_type(char *drc_type)
 	return 1;
 }
 
+/**
+ * is_php_dn() - return 1 if this is a hotpluggable pci slot, else 0
+ *
+ * This routine will return true only if the device node is
+ * a hotpluggable slot. This routine will return false
+ * for built-in pci slots (even when the built-in slots are
+ * dlparable.)
+ */
 static int is_php_dn(struct device_node *dn, const int **indexes,
 		const int **names, const int **types, const int **power_domains)
 {
@@ -269,24 +277,31 @@ static int is_php_dn(struct device_node 
 	int rc;
 
 	rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
-	if (rc >= 0) {
-		if (is_php_type((char *) &drc_types[1])) {
-			*types = drc_types;
-			return 1;
-		}
-	}
+	if (rc < 0)
+		return 0;
 
-	return 0;
+	if (!is_php_type((char *) &drc_types[1]))
+		return 0;
+
+	*types = drc_types;
+	return 1;
 }
 
 /**
- * rpaphp_add_slot -- add hotplug or dlpar slot
+ * rpaphp_add_slot -- declare a hotplug slot to the hotplug subsystem.
+ * @dn device node of slot
+ *
+ * This subroutine will register a hotplugable slot with the
+ * PCI hotplug infrastructure. This routine is typicaly called
+ * during boot time, if the hotplug slots are present at boot time,
+ * or is called later, by the dlpar add code, if the slot is
+ * being dynamically added during runtime.
+ *
+ * If the device node points at an embedded (built-in) slot, this
+ * routine will just return without doing anything, since embedded
+ * slots cannot be hotplugged.
  *
- *	rpaphp not only registers PCI hotplug slots(HOTPLUG), 
- *	but also logical DR slots(EMBEDDED).
- *	HOTPLUG slot: An adapter can be physically added/removed. 
- *	EMBEDDED slot: An adapter can be logically removed/added
- *		  from/to a partition with the slot.
+ * To remove a slot, it suffices to call rpaphp_deregister_slot()
  */
 int rpaphp_add_slot(struct device_node *dn)
 {
@@ -299,6 +314,7 @@ int rpaphp_add_slot(struct device_node *
 	if (!dn || strcmp(dn->name, "pci"))
 		return 0;
 
+	/* If this is not a hotplug slot, return without doing anything. */
 	if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
 		return 0;
 	
