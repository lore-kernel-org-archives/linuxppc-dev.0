Return-Path: <johnrose@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 26E8E679FF
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2006 03:38:56 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k21Gcp9x017447
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Mar 2006 11:38:51 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k21GcpTf119050
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Mar 2006 11:38:51 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k21GcpWZ008053
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Mar 2006 11:38:51 -0500
Subject: [PATCH] move eeh_add_device_tree_late()
From: John Rose <johnrose@austin.ibm.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
In-Reply-To: <20060301010249.GV20175@ca-server1.us.oracle.com>
References: <20060301001909.GU20175@ca-server1.us.oracle.com>
	<20060301010249.GV20175@ca-server1.us.oracle.com>
Content-Type: text/plain
Message-Id: <1141230954.19095.19.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Wed, 01 Mar 2006 10:35:55 -0600
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Good catch, Mark.

Commit 827c1a6c1a5dcb2902fecfb648f9af6a532934eb introduced a new
function that calls eeh_add_device_late() implicitly.  This patch
reorders the two functions in question to fix the compile error.  This
might be preferable to exposing eeh_add_device_late() in eeh.h.

Apologies Paul/everyone, please don't kill me.

Thanks-
John

Signed-off-by: John Rose <johnrose@austin.ibm.com>

diff -puN arch/powerpc/platforms/pseries/eeh.c~fix_eeh_bb arch/powerpc/platforms/pseries/eeh.c
--- 2_6_linus_3/arch/powerpc/platforms/pseries/eeh.c~fix_eeh_bb	2006-03-01 10:30:52.000000000 -0600
+++ 2_6_linus_3-johnrose/arch/powerpc/platforms/pseries/eeh.c	2006-03-01 10:31:28.000000000 -0600
@@ -893,20 +893,6 @@ void eeh_add_device_tree_early(struct de
 }
 EXPORT_SYMBOL_GPL(eeh_add_device_tree_early);
 
-void eeh_add_device_tree_late(struct pci_bus *bus)
-{
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &bus->devices, bus_list) {
- 		eeh_add_device_late(dev);
- 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
- 			struct pci_bus *subbus = dev->subordinate;
- 			if (subbus)
- 				eeh_add_device_tree_late(subbus);
- 		}
-	}
-}
-
 /**
  * eeh_add_device_late - perform EEH initialization for the indicated pci device
  * @dev: pci device for which to set up EEH
@@ -935,6 +921,20 @@ void eeh_add_device_late(struct pci_dev 
 }
 EXPORT_SYMBOL_GPL(eeh_add_device_late);
 
+void eeh_add_device_tree_late(struct pci_bus *bus)
+{
+	struct pci_dev *dev;
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+ 		eeh_add_device_late(dev);
+ 		if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+ 			struct pci_bus *subbus = dev->subordinate;
+ 			if (subbus)
+ 				eeh_add_device_tree_late(subbus);
+ 		}
+	}
+}
+
 /**
  * eeh_remove_device - undo EEH setup for the indicated pci device
  * @dev: pci device to be removed

_
