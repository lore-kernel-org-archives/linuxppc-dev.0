Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9169F67CCB
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Nov 2006 08:23:01 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id kA3LMnLD025228
	for <linuxppc-dev@ozlabs.org>; Fri, 3 Nov 2006 15:22:50 -0600
Subject: [PATCH/RFC] powerpc: make pci use device notifier
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Sat, 04 Nov 2006 08:22:48 +1100
Message-Id: <1162588969.10630.115.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is just an add-on to my previous patch to make it use the new
device notifier thingy that I added to gregkh tree instead of the old
style function pointer hooks

Index: linux-cell/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup_64.c	2006-10-26 16:43:32.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/setup_64.c	2006-10-26 16:44:09.000000000 +1000
@@ -531,10 +531,6 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &dummy_con;
 #endif
 
-#ifdef CONFIG_PCI
-	platform_notify = pci_platform_notify;
-	platform_notify_remove = pci_platform_notify_remove;
-#endif
 	ppc_md.setup_arch();
 
 	paging_init();
Index: linux-cell/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_64.c	2006-10-26 16:43:32.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/pci_64.c	2006-10-26 16:44:09.000000000 +1000
@@ -22,6 +22,7 @@
 #include <linux/list.h>
 #include <linux/syscalls.h>
 #include <linux/irq.h>
+#include <linux/notifier.h>
 
 #include <asm/processor.h>
 #include <asm/io.h>
@@ -554,6 +555,29 @@ void __devinit scan_phb(struct pci_contr
 		hose->last_busno = bus->subordinate = pci_scan_child_bus(bus);
 }
 
+static int ppc_pci_dev_notify(struct notifier_block *nb, unsigned long action,
+			      void *data)
+{
+	struct device *dev = data;
+	struct device_ext *dext;
+
+	if (action == BUS_NOTIFY_DEL_DEVICE) {
+		dext = device_get_ext(dev);
+
+		DBG("%s:%s platform notify remove !\n",
+		    dev_driver_string(dev), dev->bus_id);
+
+		device_set_ext(dev, NULL);
+		kfree(dext);
+	}
+
+	return 0;
+}
+
+static struct notifier_block ppc_pci_dev_notifier = {
+	.notifier_call = ppc_pci_dev_notify
+};
+
 static int __init pcibios_init(void)
 {
 	struct pci_controller *hose, *tmp;
@@ -566,6 +590,8 @@ static int __init pcibios_init(void)
 	if (firmware_has_feature(FW_FEATURE_ISERIES))
 		iSeries_pcibios_init();
 
+	register_bus_notifier(&pci_bus_type, &ppc_pci_dev_notifier);
+
 	printk(KERN_DEBUG "PCI: Probing PCI hardware\n");
 
 	/* Scan all of the recorded PCI controllers.  */
@@ -1458,24 +1484,3 @@ int pcibus_to_node(struct pci_bus *bus)
 EXPORT_SYMBOL(pcibus_to_node);
 #endif
 
-int pci_platform_notify(struct device * dev)
-{
-	return 0;
-}
-
-int pci_platform_notify_remove(struct device * dev)
-{
-	struct device_ext *dext = device_get_ext(dev);
-
-	DBG("%s:%s platform notify remove !\n",
-	    dev_driver_string(dev), dev->bus_id);
-
-	if (dev->bus != &pci_bus_type)
-		return 0;
-
-	device_set_ext(dev, NULL);
-	mb();
-	kfree(dext);
-
-	return 0;
-}
