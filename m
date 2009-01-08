Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 46D19DE90F
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 23:19:52 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Milton Miller <miltonm@bga.com>
Subject: [PATCH 2/4] powerpc: remove write only variable
Date: Thu, 08 Jan 2009 06:19:49 -0600
Message-ID: <1231417189_141720@mercury.realtime.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since we never hotplug add an isa bus, we never need to set primary.
Delete this write-only variable.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
The reference to primary was removed in during a code move
92eb4602 (v2.6.16) when dlpar for p5ioc was tested.


Index: work.git/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- work.git.orig/arch/powerpc/platforms/pseries/pci_dlpar.c	2009-01-05 04:38:15.000000000 -0600
+++ work.git/arch/powerpc/platforms/pseries/pci_dlpar.c	2009-01-05 04:38:48.000000000 -0600
@@ -137,11 +137,9 @@ EXPORT_SYMBOL_GPL(pcibios_add_pci_device
 struct pci_controller * __devinit init_phb_dynamic(struct device_node *dn)
 {
 	struct pci_controller *phb;
-	int primary;
 
 	pr_debug("PCI: Initializing new hotplug PHB %s\n", dn->full_name);
 
-	primary = list_empty(&hose_list);
 	phb = pcibios_alloc_controller(dn);
 	if (!phb)
 		return NULL;
