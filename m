Return-Path: <johnrose@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1C1B367A04
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Mar 2006 06:59:24 +1100 (EST)
Received: from e32.co.us.ibm.com (e32.boulder.ibm.com [9.17.249.42])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k21J0SVU025281
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Mar 2006 14:00:28 -0500
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id k21J0KFv003604
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Mar 2006 14:00:20 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k21Ivl6I255904
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Mar 2006 11:57:47 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k21J0KNf004597
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Mar 2006 12:00:20 -0700
Subject: [PATCH] move eeh_add_device_tree_late()
From: John Rose <johnrose@austin.ibm.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
In-Reply-To: <20060301175922.GX20175@ca-server1.us.oracle.com>
References: <20060301001909.GU20175@ca-server1.us.oracle.com>
	<20060301010249.GV20175@ca-server1.us.oracle.com>
	<1141230954.19095.19.camel@sinatra.austin.ibm.com>
	<20060301175922.GX20175@ca-server1.us.oracle.com>
Content-Type: text/plain
Message-Id: <1141239448.19095.28.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Wed, 01 Mar 2006 12:57:28 -0600
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Hmm, you still left the EXPORT_SYMBOL(eeh_add_device_late) and you didn't
> make eeh_add_device_late() static. Shouldn't you do that if you don't want
> to make it accessible outside of eeh.c?
> 	--Mark

Again, good points.  Ever have one of those days?  Take 2.

Commit 827c1a6c1a5dcb2902fecfb648f9af6a532934eb introduced a new
function that calls eeh_add_device_late() implicitly.  This patch
reorders the two functions in question to fix the compile error.  This
might be preferable to exposing eeh_add_device_late() in eeh.h.

Thanks-
John

Signed-off-by: John Rose <johnrose@austin.ibm.com>

diff -puN arch/powerpc/platforms/pseries/eeh.c~fix_eeh_bb arch/powerpc/platforms/pseries/eeh.c
--- 2_6_linus_3/arch/powerpc/platforms/pseries/eeh.c~fix_eeh_bb	2006-03-01 10:30:52.000000000 -0600
+++ 2_6_linus_3-johnrose/arch/powerpc/platforms/pseries/eeh.c	2006-03-01 12:54:03.000000000 -0600
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
@@ -914,7 +900,7 @@ void eeh_add_device_tree_late(struct pci
  * This routine must be used to complete EEH initialization for PCI
  * devices that were added after system boot (e.g. hotplug, dlpar).
  */
-void eeh_add_device_late(struct pci_dev *dev)
+static void eeh_add_device_late(struct pci_dev *dev)
 {
 	struct device_node *dn;
 	struct pci_dn *pdn;
@@ -933,7 +919,20 @@ void eeh_add_device_late(struct pci_dev 
 
 	pci_addr_cache_insert_device (dev);
 }
-EXPORT_SYMBOL_GPL(eeh_add_device_late);
+
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
 
 /**
  * eeh_remove_device - undo EEH setup for the indicated pci device

_
