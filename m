Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CF17FDE5C9
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:28:16 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l33HQ3d0001635
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:26:03 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HS43B046236
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:28:04 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HRsfq001128
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:27:55 -0600
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 13/19] PCI: rpaphp: refactor tail call to
	rpaphp_register_slot()
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403172754.41E7E3A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:27:54 -0500 (CDT)
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


Eliminate the tail call to rpaphp_register_slot() 
by placing it in the caller. This will help later
dis-entanglement.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----

 drivers/pci/hotplug/rpaphp_core.c |    3 +++
 drivers/pci/hotplug/rpaphp_pci.c  |    2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:32.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:35.000000000 -0500
@@ -319,6 +319,9 @@ int rpaphp_add_slot(struct device_node *
 				indexes[i + 1], name, type);
 
 		retval = rpaphp_register_pci_slot(slot);
+		if (!retval)
+			retval = rpaphp_register_slot(slot);
+
 		if (retval)
 			dealloc_slot_struct(slot);
 
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:30.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:35.000000000 -0500
@@ -136,6 +136,6 @@ int rpaphp_register_pci_slot(struct slot
 		}
 	}
 
-	return rpaphp_register_slot(slot);
+	return 0;
 }
 
