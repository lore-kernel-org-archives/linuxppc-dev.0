Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D1C90DE15B
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 03:17:58 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l33HFia6007500
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 13:15:45 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l33HHtOe065504
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:17:55 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l33HHsrp018507
	for <linuxppc-dev@ozlabs.org>; Tue, 3 Apr 2007 11:17:55 -0600
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH 3/19] PCI: rpaphp: match up alloc and free in same routine
In-Reply-To: 20070403164850.GP4922@austin.ibm.com>
Message-Id: <20070403171753.B17B13A65C@topology.austin.ibm.com>
Date: Tue,  3 Apr 2007 12:17:53 -0500 (CDT)
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


The routine that called an alloc should be the same routine that 
calles the mathcing free, if anything in the middle failed.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: John Rose <johnrose@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp_core.c |    5 +++++
 drivers/pci/hotplug/rpaphp_pci.c  |    1 -
 drivers/pci/hotplug/rpaphp_slot.c |    1 -
 3 files changed, 5 insertions(+), 2 deletions(-)

Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:08.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_core.c	2007-04-03 11:04:16.000000000 -0500
@@ -321,10 +321,15 @@ int rpaphp_add_slot(struct device_node *
 				indexes[i + 1], name, type);
 
 		retval = rpaphp_register_pci_slot(slot);
+		if (retval)
+			dealloc_slot_struct(slot);
+
 		name += strlen(name) + 1;
 		type += strlen(type) + 1;
 	}
 	dbg("%s - Exit: rc[%d]\n", __FUNCTION__, retval);
+
+	/* XXX FIXME: reports a failure only if last entry in loop failed */
 	return retval;
 }
 
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_slot.c	2007-04-03 11:04:08.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_slot.c	2007-04-03 11:04:16.000000000 -0500
@@ -184,7 +184,6 @@ int rpaphp_register_slot(struct slot *sl
 sysfs_fail:
 	pci_hp_deregister(php_slot);
 register_fail:
-	rpaphp_release_slot(php_slot);
 	return retval;
 }
 
Index: linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:00:48.000000000 -0500
+++ linux-2.6.21-rc4-git4/drivers/pci/hotplug/rpaphp_pci.c	2007-04-03 11:04:16.000000000 -0500
@@ -195,7 +195,6 @@ static int setup_pci_slot(struct slot *s
 	}
 	return 0;
 exit_rc:
-	dealloc_slot_struct(slot);
 	return -EINVAL;
 }
 
