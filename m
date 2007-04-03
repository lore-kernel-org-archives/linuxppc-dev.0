Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 77E36DDE3B
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:37:52 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l330blFw031570
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:37:47 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330blHY269046
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:37:47 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330bkSV012913
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:37:47 -0400
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 5/19] PCI: rpaphp: Remove un-needed goto
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Message-Id: <20070403003746.6E9853A65C@topology.austin.ibm.com>
Date: Mon,  2 Apr 2007 19:37:46 -0500 (CDT)
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


Remove un-needed goto.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp_slot.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_slot.c	2007-03-28 18:07:28.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c	2007-03-28 18:10:14.000000000 -0500
@@ -157,14 +157,13 @@ int rpaphp_register_slot(struct slot *sl
 	/* should not try to register the same slot twice */
 	if (is_registered(slot)) {
 		err("rpaphp_register_slot: slot[%s] is already registered\n", slot->name);
-		retval = -EAGAIN;
-		goto register_fail;
+		return -EAGAIN;
 	}	
 
 	retval = pci_hp_register(php_slot);
 	if (retval) {
 		err("pci_hp_register failed with error %d\n", retval);
-		goto register_fail;
+		return retval;
 	}
 
 	/* create "phy_location" file */
@@ -182,7 +181,6 @@ int rpaphp_register_slot(struct slot *sl
 
 sysfs_fail:
 	pci_hp_deregister(php_slot);
-register_fail:
 	return retval;
 }
 
