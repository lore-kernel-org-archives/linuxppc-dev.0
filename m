Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EE05FDF99D
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:32:02 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33HVtMJ022251
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:31:55 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HVtZc242432
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:31:55 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HVspA024481
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:31:55 -0400
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 17/19] PCI: rpaphp: Use pcibios_remove_pci_devices()
	symmetrically
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403173154.77B623A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:31:54 -0500 (CDT)
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


At first blush, the disable_slot() routine does not look
at all like its symmetric with the enable_slot() routine;
as it seems to call a very different set of routines.
However, this is easily fixed: pcibios_remove_pci_devices()
does the right thing.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----

 drivers/pci/hotplug/rpaphp_core.c |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:41.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:47.000000000 -0500
@@ -424,18 +424,12 @@ static int enable_slot(struct hotplug_sl
 	return retval;
 }
 
-static int __disable_slot(struct slot *slot)
+static inline int __disable_slot(struct slot *slot)
 {
-	struct pci_dev *dev, *tmp;
-
 	if (slot->state == NOT_CONFIGURED)
 		return -EINVAL;
 
-	list_for_each_entry_safe(dev, tmp, &slot->bus->devices, bus_list) {
-		eeh_remove_bus_device(dev);
-		pci_remove_bus_device(dev);
-	}
-
+	pcibios_remove_pci_devices(slot->bus);
 	slot->state = NOT_CONFIGURED;
 	return 0;
 }
