Return-Path: <wfp5p@viridian.itc.virginia.edu>
Received: from viridian.itc.virginia.edu (viridian.itc.Virginia.EDU
 [128.143.12.139]) by ozlabs.org (Postfix) with ESMTP id DDF702C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2012 05:38:01 +1100 (EST)
From: Bill Pemberton <wfp5p@virginia.edu>
To: gregkh@linuxfoundation.org
Subject: [PATCH 014/493] PCI: remove CONFIG_HOTPLUG ifdefs
Date: Mon, 19 Nov 2012 13:19:23 -0500
Message-Id: <1353349642-3677-14-git-send-email-wfp5p@virginia.edu>
In-Reply-To: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
Cc: linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
 microblaze-uclinux@itee.uq.edu.au, linux-pci@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove conditional code based on CONFIG_HOTPLUG being false.  It's
always on now in preparation of it going away as an option.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn> 
Cc: microblaze-uclinux@itee.uq.edu.au 
Cc: linux-mips@linux-mips.org 
Cc: linuxppc-dev@lists.ozlabs.org 
Cc: linux-sh@vger.kernel.org 
Cc: linux-pci@vger.kernel.org 
---
 arch/microblaze/pci/pci-common.c |  4 ----
 arch/mips/pci/pci.c              |  2 --
 arch/powerpc/kernel/pci-common.c |  4 ----
 arch/powerpc/kernel/pci_64.c     |  4 ----
 arch/sh/drivers/pci/pci.c        |  2 --
 arch/unicore32/kernel/pci.c      |  2 --
 drivers/pci/pci-driver.c         | 15 ---------------
 drivers/pci/pci-sysfs.c          |  7 -------
 drivers/pci/pci.h                |  4 ----
 drivers/pci/probe.c              |  2 --
 include/linux/pci.h              |  2 --
 11 files changed, 48 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 4dbb505..a1c5b99 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -1346,8 +1346,6 @@ void __init pcibios_resource_survey(void)
 	pci_assign_unassigned_resources();
 }
 
-#ifdef CONFIG_HOTPLUG
-
 /* This is used by the PCI hotplug driver to allocate resource
  * of newly plugged busses. We can try to consolidate with the
  * rest of the code later, for now, keep it as-is as our main
@@ -1407,8 +1405,6 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
 
-#endif /* CONFIG_HOTPLUG */
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	return pci_enable_resources(dev, mask);
diff --git a/arch/mips/pci/pci.c b/arch/mips/pci/pci.c
index 04e35bc..4040416 100644
--- a/arch/mips/pci/pci.c
+++ b/arch/mips/pci/pci.c
@@ -313,10 +313,8 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 	}
 }
 
-#ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
-#endif
 
 int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
 			enum pci_mmap_state mmap_state, int write_combine)
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 7f94f76..abc0d08 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1428,8 +1428,6 @@ void __init pcibios_resource_survey(void)
 		ppc_md.pcibios_fixup();
 }
 
-#ifdef CONFIG_HOTPLUG
-
 /* This is used by the PCI hotplug driver to allocate resource
  * of newly plugged busses. We can try to consolidate with the
  * rest of the code later, for now, keep it as-is as our main
@@ -1488,8 +1486,6 @@ void pcibios_finish_adding_to_bus(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_finish_adding_to_bus);
 
-#endif /* CONFIG_HOTPLUG */
-
 int pcibios_enable_device(struct pci_dev *dev, int mask)
 {
 	if (ppc_md.pcibios_enable_device_hook)
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 4ff190f..2cbe676 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -74,8 +74,6 @@ static int __init pcibios_init(void)
 
 subsys_initcall(pcibios_init);
 
-#ifdef CONFIG_HOTPLUG
-
 int pcibios_unmap_io_space(struct pci_bus *bus)
 {
 	struct pci_controller *hose;
@@ -124,8 +122,6 @@ int pcibios_unmap_io_space(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pcibios_unmap_io_space);
 
-#endif /* CONFIG_HOTPLUG */
-
 static int __devinit pcibios_map_phb_io_space(struct pci_controller *hose)
 {
 	struct vm_struct *area;
diff --git a/arch/sh/drivers/pci/pci.c b/arch/sh/drivers/pci/pci.c
index a7e078f..81e5daf 100644
--- a/arch/sh/drivers/pci/pci.c
+++ b/arch/sh/drivers/pci/pci.c
@@ -319,7 +319,5 @@ EXPORT_SYMBOL(pci_iounmap);
 
 #endif /* CONFIG_GENERIC_IOMAP */
 
-#ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(PCIBIOS_MIN_IO);
 EXPORT_SYMBOL(PCIBIOS_MIN_MEM);
-#endif
diff --git a/arch/unicore32/kernel/pci.c b/arch/unicore32/kernel/pci.c
index b0056f6..7c43592 100644
--- a/arch/unicore32/kernel/pci.c
+++ b/arch/unicore32/kernel/pci.c
@@ -250,9 +250,7 @@ void __devinit pcibios_fixup_bus(struct pci_bus *bus)
 	printk(KERN_INFO "PCI: bus%d: Fast back to back transfers %sabled\n",
 		bus->number, (features & PCI_COMMAND_FAST_BACK) ? "en" : "dis");
 }
-#ifdef CONFIG_HOTPLUG
 EXPORT_SYMBOL(pcibios_fixup_bus);
-#endif
 
 static int __init pci_common_init(void)
 {
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 24aa44c..498e66a 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -89,10 +89,6 @@ static void pci_free_dynids(struct pci_driver *drv)
 	spin_unlock(&drv->dynids.lock);
 }
 
-/*
- * Dynamic device ID manipulation via sysfs is disabled for !CONFIG_HOTPLUG
- */
-#ifdef CONFIG_HOTPLUG
 /**
  * store_new_id - sysfs frontend to pci_add_dynid()
  * @driver: target device driver
@@ -191,10 +187,6 @@ static struct driver_attribute pci_drv_attrs[] = {
 	__ATTR_NULL,
 };
 
-#else
-#define pci_drv_attrs	NULL
-#endif /* CONFIG_HOTPLUG */
-
 /**
  * pci_match_id - See if a pci device matches a given pci_id table
  * @ids: array of PCI device id structures to search in
@@ -1223,13 +1215,6 @@ void pci_dev_put(struct pci_dev *dev)
 		put_device(&dev->dev);
 }
 
-#ifndef CONFIG_HOTPLUG
-int pci_uevent(struct device *dev, struct kobj_uevent_env *env)
-{
-	return -ENODEV;
-}
-#endif
-
 struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5d883a1..05b78b1 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -284,7 +284,6 @@ msi_bus_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-#ifdef CONFIG_HOTPLUG
 static DEFINE_MUTEX(pci_remove_rescan_mutex);
 static ssize_t bus_rescan_store(struct bus_type *bus, const char *buf,
 				size_t count)
@@ -377,8 +376,6 @@ dev_bus_rescan_store(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-#endif
-
 #if defined(CONFIG_PM_RUNTIME) && defined(CONFIG_ACPI)
 static ssize_t d3cold_allowed_store(struct device *dev,
 				    struct device_attribute *attr,
@@ -524,10 +521,8 @@ struct device_attribute pci_dev_attrs[] = {
 	__ATTR(broken_parity_status,(S_IRUGO|S_IWUSR),
 		broken_parity_status_show,broken_parity_status_store),
 	__ATTR(msi_bus, 0644, msi_bus_show, msi_bus_store),
-#ifdef CONFIG_HOTPLUG
 	__ATTR(remove, (S_IWUSR|S_IWGRP), NULL, remove_store),
 	__ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_rescan_store),
-#endif
 #if defined(CONFIG_PM_RUNTIME) && defined(CONFIG_ACPI)
 	__ATTR(d3cold_allowed, 0644, d3cold_allowed_show, d3cold_allowed_store),
 #endif
@@ -535,9 +530,7 @@ struct device_attribute pci_dev_attrs[] = {
 };
 
 struct device_attribute pcibus_dev_attrs[] = {
-#ifdef CONFIG_HOTPLUG
 	__ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store),
-#endif
 	__ATTR(cpuaffinity, S_IRUGO, pci_bus_show_cpumaskaffinity, NULL),
 	__ATTR(cpulistaffinity, S_IRUGO, pci_bus_show_cpulistaffinity, NULL),
 	__ATTR_NULL,
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 11a713b..ae06da4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -160,11 +160,7 @@ static inline int pci_no_d1d2(struct pci_dev *dev)
 extern struct device_attribute pci_dev_attrs[];
 extern struct device_attribute pcibus_dev_attrs[];
 extern struct device_type pci_dev_type;
-#ifdef CONFIG_HOTPLUG
 extern struct bus_attribute pci_bus_attrs[];
-#else
-#define pci_bus_attrs	NULL
-#endif
 
 
 /**
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 293af5a..3d17641 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1865,7 +1865,6 @@ struct pci_bus * __devinit pci_scan_bus(int bus, struct pci_ops *ops,
 }
 EXPORT_SYMBOL(pci_scan_bus);
 
-#ifdef CONFIG_HOTPLUG
 /**
  * pci_rescan_bus_bridge_resize - scan a PCI bus for devices.
  * @bridge: PCI bridge for the bus to scan
@@ -1917,7 +1916,6 @@ EXPORT_SYMBOL(pci_add_new_bus);
 EXPORT_SYMBOL(pci_scan_slot);
 EXPORT_SYMBOL(pci_scan_bridge);
 EXPORT_SYMBOL_GPL(pci_scan_child_bus);
-#endif
 
 static int __init pci_sort_bf_cmp(const struct device *d_a, const struct device *d_b)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5b37d64..9f99c59 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -944,10 +944,8 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 
 /* Functions for PCI Hotplug drivers to use */
 int pci_bus_find_capability(struct pci_bus *bus, unsigned int devfn, int cap);
-#ifdef CONFIG_HOTPLUG
 unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
-#endif
 
 /* Vital product data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
-- 
1.8.0
