Return-Path: <linas@austin.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E25ADDE3F
	for <linuxppc-dev@ozlabs.org>; Thu, 24 May 2007 03:16:51 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l4NHGkMR002115
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:16:46 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l4NHGk2l544982
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:16:46 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l4NHGkIQ007375
	for <linuxppc-dev@ozlabs.org>; Wed, 23 May 2007 13:16:46 -0400
Date: Wed, 23 May 2007 12:16:46 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/4] powerpc: Add EEH sysfs blinkenlights
Message-ID: <20070523171646.GA32380@austin.ibm.com>
References: <20070523171328.GY5921@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070523171328.GY5921@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add sysfs blinkenlights for EEH statistics. Shuffle the
eeh_add_device_tree() call so that it appears in the correct
sequence.


Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/Makefile    |    2 
 arch/powerpc/platforms/pseries/eeh.c       |    4 +
 arch/powerpc/platforms/pseries/eeh_cache.c |    2 
 arch/powerpc/platforms/pseries/eeh_sysfs.c |   84 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pci_dlpar.c |    7 +-
 include/asm-powerpc/ppc-pci.h              |    3 +
 6 files changed, 98 insertions(+), 4 deletions(-)

Index: linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh_sysfs.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh_sysfs.c	2007-05-23 11:57:23.000000000 -0500
@@ -0,0 +1,84 @@
+/*
+ * Sysfs entries for PCI Error Recovery for PAPR-compliant platform.
+ * Copyright IBM Corporation 2007
+ * Copyright Linas Vepstas <linas@austin.ibm.com> 2007
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send comments and feedback to Linas Vepstas <linas@austin.ibm.com>
+ */
+#include <linux/pci.h>
+#include <asm/ppc-pci.h>
+#include <asm/pci-bridge.h>
+#include <linux/kobject.h>
+
+/**
+ * EEH_SHOW_ATTR -- create sysfs entry for eeh statistic
+ * @_name: name of file in sysfs directory
+ * @_memb: name of member in struct pci_dn to access
+ * @_format: printf format for display
+ *
+ * All of the attributes look very similar, so just
+ * auto-gen a cut-n-paste routine to display them.
+ */
+#define EEH_SHOW_ATTR(_name,_memb,_format)               \
+static ssize_t eeh_show_##_name(struct device *dev,      \
+		struct device_attribute *attr, char *buf)          \
+{                                                        \
+	struct pci_dev *pdev = to_pci_dev(dev);               \
+	struct device_node *dn = pci_device_to_OF_node(pdev); \
+	struct pci_dn *pdn;                                   \
+	                                                      \
+	if (!dn || PCI_DN(dn) == NULL)                        \
+		return 0;                                          \
+	                                                      \
+	pdn = PCI_DN(dn);                                     \
+	return sprintf(buf, _format "\n", pdn->_memb);        \
+}                                                        \
+static DEVICE_ATTR(_name, S_IRUGO, eeh_show_##_name, NULL);
+
+
+EEH_SHOW_ATTR(eeh_mode, eeh_mode, "0x%x");
+EEH_SHOW_ATTR(eeh_config_addr, eeh_config_addr, "0x%x");
+EEH_SHOW_ATTR(eeh_pe_config_addr, eeh_pe_config_addr, "0x%x");
+EEH_SHOW_ATTR(eeh_check_count, eeh_check_count, "%d");
+EEH_SHOW_ATTR(eeh_freeze_count, eeh_freeze_count, "%d");
+
+void eeh_sysfs_add_device(struct pci_dev *pdev)
+{
+	int rc=0;
+
+	rc += device_create_file(&pdev->dev, &dev_attr_eeh_mode);
+	rc += device_create_file(&pdev->dev, &dev_attr_eeh_config_addr);
+	rc += device_create_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
+	rc += device_create_file(&pdev->dev, &dev_attr_eeh_check_count);
+	rc += device_create_file(&pdev->dev, &dev_attr_eeh_freeze_count);
+
+	if (rc)
+		printk(KERN_WARNING "EEH: Unable to create sysfs entries\n");
+}
+
+void eeh_sysfs_remove_device(struct pci_dev *pdev)
+{
+	device_remove_file(&pdev->dev, &dev_attr_eeh_mode);
+	device_remove_file(&pdev->dev, &dev_attr_eeh_config_addr);
+	device_remove_file(&pdev->dev, &dev_attr_eeh_pe_config_addr);
+	device_remove_file(&pdev->dev, &dev_attr_eeh_check_count);
+	device_remove_file(&pdev->dev, &dev_attr_eeh_freeze_count);
+}
+
Index: linux-2.6.22-rc1/arch/powerpc/platforms/pseries/Makefile
===================================================================
--- linux-2.6.22-rc1.orig/arch/powerpc/platforms/pseries/Makefile	2007-05-23 11:43:42.000000000 -0500
+++ linux-2.6.22-rc1/arch/powerpc/platforms/pseries/Makefile	2007-05-23 11:44:43.000000000 -0500
@@ -8,7 +8,7 @@ obj-y			:= lpar.o hvCall.o nvram.o recon
 obj-$(CONFIG_SMP)	+= smp.o
 obj-$(CONFIG_XICS)	+= xics.o
 obj-$(CONFIG_SCANLOG)	+= scanlog.o
-obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o
+obj-$(CONFIG_EEH)	+= eeh.o eeh_cache.o eeh_driver.o eeh_event.o eeh_sysfs.o
 obj-$(CONFIG_KEXEC)	+= kexec.o
 obj-$(CONFIG_PCI)	+= pci.o pci_dlpar.o
 obj-$(CONFIG_PCI_MSI)	+= msi.o
Index: linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.22-rc1.orig/arch/powerpc/platforms/pseries/eeh.c	2007-05-23 11:43:44.000000000 -0500
+++ linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh.c	2007-05-23 11:56:53.000000000 -0500
@@ -1139,7 +1139,8 @@ static void eeh_add_device_late(struct p
 	pdn = PCI_DN(dn);
 	pdn->pcidev = dev;
 
-	pci_addr_cache_insert_device (dev);
+	pci_addr_cache_insert_device(dev);
+	eeh_sysfs_add_device(dev);
 }
 
 void eeh_add_device_tree_late(struct pci_bus *bus)
@@ -1178,6 +1179,7 @@ static void eeh_remove_device(struct pci
 	printk(KERN_DEBUG "EEH: remove device %s\n", pci_name(dev));
 #endif
 	pci_addr_cache_remove_device(dev);
+	eeh_sysfs_remove_device(dev);
 
 	dn = pci_device_to_OF_node(dev);
 	if (PCI_DN(dn)->pcidev) {
Index: linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh_cache.c
===================================================================
--- linux-2.6.22-rc1.orig/arch/powerpc/platforms/pseries/eeh_cache.c	2007-05-23 11:43:44.000000000 -0500
+++ linux-2.6.22-rc1/arch/powerpc/platforms/pseries/eeh_cache.c	2007-05-23 11:56:52.000000000 -0500
@@ -295,6 +295,8 @@ void __init pci_addr_cache_build(void)
 			continue;
 		pci_dev_get (dev);  /* matching put is in eeh_remove_device() */
 		PCI_DN(dn)->pcidev = dev;
+
+		eeh_sysfs_add_device(dev);
 	}
 
 #ifdef DEBUG
Index: linux-2.6.22-rc1/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- linux-2.6.22-rc1.orig/arch/powerpc/platforms/pseries/pci_dlpar.c	2007-05-23 11:43:42.000000000 -0500
+++ linux-2.6.22-rc1/arch/powerpc/platforms/pseries/pci_dlpar.c	2007-05-23 11:44:43.000000000 -0500
@@ -110,8 +110,6 @@ pcibios_fixup_new_pci_devices(struct pci
 			}
 		}
 	}
-
-	eeh_add_device_tree_late(bus);
 }
 EXPORT_SYMBOL_GPL(pcibios_fixup_new_pci_devices);
 
@@ -139,6 +137,8 @@ pcibios_pci_config_bridge(struct pci_dev
 
 	/* Make the discovered devices available */
 	pci_bus_add_devices(child_bus);
+
+	eeh_add_device_tree_late(child_bus);
 	return 0;
 }
 
@@ -171,6 +171,7 @@ pcibios_add_pci_devices(struct pci_bus *
 		if (!list_empty(&bus->devices)) {
 			pcibios_fixup_new_pci_devices(bus, 0);
 			pci_bus_add_devices(bus);
+			eeh_add_device_tree_late(bus);
 		}
 	} else if (mode == PCI_PROBE_NORMAL) {
 		/* use legacy probe */
@@ -179,6 +180,7 @@ pcibios_add_pci_devices(struct pci_bus *
 		if (num) {
 			pcibios_fixup_new_pci_devices(bus, 1);
 			pci_bus_add_devices(bus);
+			eeh_add_device_tree_late(bus);
 		}
 
 		list_for_each_entry(dev, &bus->devices, bus_list)
@@ -210,6 +212,7 @@ struct pci_controller * __devinit init_p
 	scan_phb(phb);
 	pcibios_fixup_new_pci_devices(phb->bus, 0);
 	pci_bus_add_devices(phb->bus);
+	eeh_add_device_tree_late(phb->bus);
 
 	return phb;
 }
Index: linux-2.6.22-rc1/include/asm-powerpc/ppc-pci.h
===================================================================
--- linux-2.6.22-rc1.orig/include/asm-powerpc/ppc-pci.h	2007-05-23 11:43:42.000000000 -0500
+++ linux-2.6.22-rc1/include/asm-powerpc/ppc-pci.h	2007-05-23 11:44:43.000000000 -0500
@@ -139,6 +139,9 @@ void eeh_clear_slot (struct device_node 
  */
 struct device_node * find_device_pe(struct device_node *dn);
 
+void eeh_sysfs_add_device(struct pci_dev *pdev);
+void eeh_sysfs_remove_device(struct pci_dev *pdev);
+
 #endif /* CONFIG_EEH */
 
 #else /* CONFIG_PCI */
