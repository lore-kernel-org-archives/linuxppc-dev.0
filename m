Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 28 Oct 2008 16:48:41 +1100
Subject: [PATCH 6/10] powerpc/eeh: Make EEH device add/remove more robust
In-Reply-To: <1225172895.217185.958686212130.qpush@grosgo>
Message-Id: <20081028054941.7E9D0DDEE2@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To properly fix PCI hotplug, it's useful to be able to make
the fixup passes on all devices whether they were just hot
plugged or already there.

The EEH code however used to not be very friendly with calling
eeh_add_device_late() multiple time, and not very rebust in
the way it generally tests whether a device is in the expected
state vs. the EEH code.

This improves it, along with cleaning up a couple of debug printk's

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/include/asm/eeh.h       |    9 +++----
 arch/powerpc/platforms/pseries/eeh.c |   44 +++++++++++++++++++----------------
 2 files changed, 29 insertions(+), 24 deletions(-)

--- linux-work.orig/arch/powerpc/platforms/pseries/eeh.c	2008-10-23 14:41:05.000000000 +1100
+++ linux-work/arch/powerpc/platforms/pseries/eeh.c	2008-10-28 14:03:26.000000000 +1100
@@ -21,6 +21,8 @@
  * Please address comments and feedback to Linas Vepstas <linas@austin.ibm.com>
  */
 
+#undef DEBUG
+
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -488,10 +490,8 @@ int eeh_dn_check_failure(struct device_n
 	if (!(pdn->eeh_mode & EEH_MODE_SUPPORTED) ||
 	    pdn->eeh_mode & EEH_MODE_NOCHECK) {
 		ignored_check++;
-#ifdef DEBUG
-		printk ("EEH:ignored check (%x) for %s %s\n", 
-		        pdn->eeh_mode, pci_name (dev), dn->full_name);
-#endif
+		pr_debug("EEH: Ignored check (%x) for %s %s\n",
+			 pdn->eeh_mode, pci_name (dev), dn->full_name);
 		return 0;
 	}
 
@@ -1014,10 +1014,9 @@ static void *early_enable_eeh(struct dev
 			eeh_subsystem_enabled = 1;
 			pdn->eeh_mode |= EEH_MODE_SUPPORTED;
 
-#ifdef DEBUG
-			printk(KERN_DEBUG "EEH: %s: eeh enabled, config=%x pe_config=%x\n",
-			       dn->full_name, pdn->eeh_config_addr, pdn->eeh_pe_config_addr);
-#endif
+			pr_debug("EEH: %s: eeh enabled, config=%x pe_config=%x\n",
+				 dn->full_name, pdn->eeh_config_addr,
+				 pdn->eeh_pe_config_addr);
 		} else {
 
 			/* This device doesn't support EEH, but it may have an
@@ -1161,13 +1160,17 @@ static void eeh_add_device_late(struct p
 	if (!dev || !eeh_subsystem_enabled)
 		return;
 
-#ifdef DEBUG
-	printk(KERN_DEBUG "EEH: adding device %s\n", pci_name(dev));
-#endif
+	pr_debug("EEH: Adding device %s\n", pci_name(dev));
 
-	pci_dev_get (dev);
 	dn = pci_device_to_OF_node(dev);
 	pdn = PCI_DN(dn);
+	if (pdn->pcidev == dev) {
+		pr_debug("EEH: Already referenced !\n");
+		return;
+	}
+	WARN_ON(pdn->pcidev);
+
+	pci_dev_get (dev);
 	pdn->pcidev = dev;
 
 	pci_addr_cache_insert_device(dev);
@@ -1206,17 +1209,18 @@ static void eeh_remove_device(struct pci
 		return;
 
 	/* Unregister the device with the EEH/PCI address search system */
-#ifdef DEBUG
-	printk(KERN_DEBUG "EEH: remove device %s\n", pci_name(dev));
-#endif
-	pci_addr_cache_remove_device(dev);
-	eeh_sysfs_remove_device(dev);
+	pr_debug("EEH: Removing device %s\n", pci_name(dev));
 
 	dn = pci_device_to_OF_node(dev);
-	if (PCI_DN(dn)->pcidev) {
-		PCI_DN(dn)->pcidev = NULL;
-		pci_dev_put (dev);
+	if (PCI_DN(dn)->pcidev == NULL) {
+		pr_debug("EEH: Not referenced !\n");
+		return;
 	}
+	PCI_DN(dn)->pcidev = NULL;
+	pci_dev_put (dev);
+
+	pci_addr_cache_remove_device(dev);
+	eeh_sysfs_remove_device(dev);
 }
 
 void eeh_remove_bus_device(struct pci_dev *dev)
Index: linux-work/arch/powerpc/include/asm/eeh.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/eeh.h	2008-10-28 14:07:47.000000000 +1100
+++ linux-work/arch/powerpc/include/asm/eeh.h	2008-10-28 14:08:44.000000000 +1100
@@ -17,8 +17,8 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#ifndef _PPC64_EEH_H
-#define _PPC64_EEH_H
+#ifndef _POWERPC_EEH_H
+#define _POWERPC_EEH_H
 #ifdef __KERNEL__
 
 #include <linux/init.h>
@@ -110,6 +110,7 @@ static inline void eeh_remove_bus_device
 #define EEH_IO_ERROR_VALUE(size) (-1UL)
 #endif /* CONFIG_EEH */
 
+#ifdef CONFIG_PPC64
 /*
  * MMIO read/write operations with EEH support.
  */
@@ -206,6 +207,6 @@ static inline void eeh_readsl(const vola
 	if (EEH_POSSIBLE_ERROR((*(((u32*)buf)+nl-1)), u32))
 		eeh_check_failure(addr, *(u32*)buf);
 }
-
+#endif /* CONFIG_PPC64 */
 #endif /* __KERNEL__ */
-#endif /* _PPC64_EEH_H */
+#endif /* _POWERPC_EEH_H */
