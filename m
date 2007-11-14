Return-Path: <linas@austin.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3686FDDDF2
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 12:19:18 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lAE1JEkF015352
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 20:19:14 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lAE1JEjG127598
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 18:19:14 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lAE1JDsT001269
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 18:19:14 -0700
Date: Tue, 13 Nov 2007 19:19:13 -0600
To: Greg KH <greg@kroah.com>, gregkh@suse.de,
	Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [PATCH] pci hotplug: rm bogus item in rpaphp struct
Message-ID: <20071114011913.GE8509@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Remove unused struct element.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 drivers/pci/hotplug/rpaphp.h     |    1 -
 drivers/pci/hotplug/rpaphp_pci.c |    1 -
 2 files changed, 2 deletions(-)

Index: linux-2.6.23-rc8-mm1/drivers/pci/hotplug/rpaphp.h
===================================================================
--- linux-2.6.23-rc8-mm1.orig/drivers/pci/hotplug/rpaphp.h	2007-11-13 18:37:31.000000000 -0600
+++ linux-2.6.23-rc8-mm1/drivers/pci/hotplug/rpaphp.h	2007-11-13 19:00:42.000000000 -0600
@@ -76,7 +76,6 @@ struct slot {
 	char *name;
 	struct device_node *dn;
 	struct pci_bus *bus;
-	struct list_head *pci_devs;
 	struct hotplug_slot *hotplug_slot;
 };
 
Index: linux-2.6.23-rc8-mm1/drivers/pci/hotplug/rpaphp_pci.c
===================================================================
--- linux-2.6.23-rc8-mm1.orig/drivers/pci/hotplug/rpaphp_pci.c	2007-11-13 18:37:31.000000000 -0600
+++ linux-2.6.23-rc8-mm1/drivers/pci/hotplug/rpaphp_pci.c	2007-11-13 19:00:13.000000000 -0600
@@ -100,7 +100,6 @@ int rpaphp_enable_slot(struct slot *slot
 
 	info->adapter_status = EMPTY;
 	slot->bus = bus;
-	slot->pci_devs = &bus->devices;
 
 	/* if there's an adapter in the slot, go add the pci devices */
 	if (state == PRESENT) {
