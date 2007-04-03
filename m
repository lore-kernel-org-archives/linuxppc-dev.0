Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 88468DDFC1
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:33:00 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33HXfLl018446
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:33:41 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HWt3P255584
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:32:55 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HWsis000702
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:32:55 -0400
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 18/19] PCI: rpaphp: Ensure more pcibios_add/pcibios_remove
	symmetry
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403173254.8365B3A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:32:54 -0500 (CDT)
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


Calls to pcibios_add should be symmetric with calls to pcibios_remove.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpadlpar_core.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpadlpar_core.c	2007-04-03 11:04:39.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpadlpar_core.c	2007-04-03 11:04:49.000000000 -0500
@@ -387,13 +387,8 @@ int dlpar_remove_pci_slot(char *drc_name
 				__FUNCTION__, drc_name);
 			return -EIO;
 		}
-	} else {
-		struct pci_dev *dev, *tmp;
-		list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
-			eeh_remove_bus_device(dev);
-			pci_remove_bus_device(dev);
-		}
-	}
+	} else
+		pcibios_remove_pci_devices(bus);
 
 	if (unmap_bus_range(bus)) {
 		printk(KERN_ERR "%s: failed to unmap bus range\n",
