Return-Path: <linas@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A8BD6DDFF2
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 10:50:54 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l330pXdv007220
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:51:33 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l330om1M270882
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:50:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l330ol8O030374
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Apr 2007 20:50:47 -0400
To: Greg KH <gregkh@suse.de>
Subject: [PATCH 18/19] PCI: rpaphp: Ensure more pcibios_add/pcibios_remove
	symmetry
In-Reply-To: <20070403002629.GI4922@austin.ibm.com>
Message-Id: <20070403005047.1C01D3A65C@topology.austin.ibm.com>
Date: Mon,  2 Apr 2007 19:50:47 -0500 (CDT)
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


Calls to pcibios_add should be symmetric with calls to pcibios_remove.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpadlpar_core.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpadlpar_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpadlpar_core.c	2007-04-02 14:40:09.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpadlpar_core.c	2007-04-02 14:40:14.000000000 -0500
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
