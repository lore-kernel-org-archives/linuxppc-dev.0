Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC85DDDDFD
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:33:52 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l330Xl6K020279
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:33:47 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330XlQq282948
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:33:47 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330XkZP006517
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:33:47 -0400
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 1/19] PCI: rpaphp: Cleanup flow of control for rpaphp_add_slot
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Message-Id: <20070403003346.3D32D3A65C@topology.austin.ibm.com>
Date: Mon,  2 Apr 2007 19:33:46 -0500 (CDT)
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


Cleanup the flow of control for rpaphp_add_slot(), so as to
make it easier to read. The ext patch will fix a bug in this 
same code. 

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp_core.c |   40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-03-22 16:35:39.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-03-22 16:46:59.000000000 -0500
@@ -299,32 +299,32 @@ int rpaphp_add_slot(struct device_node *
 	const int *indexes, *names, *types, *power_domains;
 	char *name, *type;
 
+	if (!dn || strcmp(dn->name, "pci"))
+		return 0;
+
+	if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
+		return 0;
+	
 	dbg("Entry %s: dn->full_name=%s\n", __FUNCTION__, dn->full_name);
 
 	/* register PCI devices */
-	if (dn->name != 0 && strcmp(dn->name, "pci") == 0) {
-		if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
-			goto exit;
-
-		name = (char *) &names[1];
-		type = (char *) &types[1];
-		for (i = 0; i < indexes[0]; i++,
-	     		name += (strlen(name) + 1), type += (strlen(type) + 1)) 		{
-
-			if (!(slot = alloc_slot_struct(dn, indexes[i + 1], name,
-				       power_domains[i + 1]))) {
-				retval = -ENOMEM;
-				goto exit;
-			}
-			slot->type = simple_strtoul(type, NULL, 10);
+	name = (char *) &names[1];
+	type = (char *) &types[1];
+	for (i = 0; i < indexes[0]; i++) {
+
+		slot = alloc_slot_struct(dn, indexes[i + 1], name, power_domains[i + 1]);
+		if (!slot)
+			return -ENOMEM;
+
+		slot->type = simple_strtoul(type, NULL, 10);
 				
-			dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
-					indexes[i + 1], name, type);
+		dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
+				indexes[i + 1], name, type);
 
-			retval = rpaphp_register_pci_slot(slot);
-		}
+		retval = rpaphp_register_pci_slot(slot);
+		name += strlen(name) + 1;
+		type += strlen(type) + 1;
 	}
-exit:
 	dbg("%s - Exit: num_slots=%d rc[%d]\n",
 	    __FUNCTION__, num_slots, retval);
 	return retval;
