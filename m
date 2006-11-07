Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Nov 2006 18:22:47 +1100
Subject: [PATCH 15/31] powerpc: PCI use new bus device notifier
In-Reply-To: <1162884150.435786.961370643810.qpush@grosgo>
Message-Id: <20061107072405.0995468265@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This makes the PCI code on 64 bits use the new bus device notifier
introduced by the 3rd patch of that queue instead of the old style
platform notify callbacks, for handling destruction of the device
extension for PCI devices.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
 
 arch/powerpc/kernel/pci_64.c   |   47 ++++++++++++++++++++++-------------------
 arch/powerpc/kernel/setup_64.c |    4 ---
 2 files changed, 26 insertions(+), 25 deletions(-)

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
