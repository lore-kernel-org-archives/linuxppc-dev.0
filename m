Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 3E4F5DDFE5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 10:09:14 +1000 (EST)
Message-Id: <20070616000618.836850961@arndb.de>
References: <20070616000511.712667424@arndb.de>
Date: Sat, 16 Jun 2007 02:05:17 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 6/9] fix building without PCI
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some code looks can be configured to be built without
PCI support, but does not work properly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6/arch/powerpc/platforms/52xx/efika.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/52xx/efika.c
+++ linux-2.6/arch/powerpc/platforms/52xx/efika.c
@@ -252,6 +252,8 @@ define_machine(efika)
 	.progress		= rtas_progress,
 	.get_boot_time		= rtas_get_boot_time,
 	.calibrate_decr		= generic_calibrate_decr,
+#ifdef CONFIG_PCI
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
+#endif
 };
 
Index: linux-2.6/arch/powerpc/platforms/embedded6xx/linkstation.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/linkstation.c
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/linkstation.c
@@ -56,6 +56,7 @@ static struct mtd_partition linkstation_
 
 static int __init linkstation_add_bridge(struct device_node *dev)
 {
+#ifdef CONFIG_PCI
 	int len;
 	struct pci_controller *hose;
 	const int *bus_range;
@@ -78,7 +79,7 @@ static int __init linkstation_add_bridge
 	/* Interpret the "ranges" property */
 	/* This also maps the I/O region and sets isa_io/mem_base */
 	pci_process_bridge_OF_ranges(hose, dev, 1);
-
+#endif
 	return 0;
 }
 

--
