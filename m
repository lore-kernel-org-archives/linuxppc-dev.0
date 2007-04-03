Return-Path: <linas@austin.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0B2EDDE01B
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:09:58 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l33H9rhp009405
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:09:53 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33H9rFq051382
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:09:53 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33H9qr8002585
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:09:53 -0600
To: Kristen@austin.ibm.com, Carlson@austin.ibm.com,
	"Accardi <kristen.c.accardi"@intel.com
Subject: [PATCH 5/19] PCI: rpaphp: Remove un-needed goto
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403170952.2C4A33A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:09:52 -0500 (CDT)
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


Remove un-needed goto.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp_slot.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_slot.c	2007-04-03 11:04:18.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c	2007-04-03 11:04:19.000000000 -0500
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
 
