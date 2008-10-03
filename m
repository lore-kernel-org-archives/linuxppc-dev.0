Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>,
	<linux-pci@vger.kernel.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 03 Oct 2008 19:49:32 +1000
Subject: [RFC/PATCH 1/2] pci: Add ability to mmap legacy_io on some platforms
Message-Id: <20081003094951.10B3FDE183@ozlabs.org>
Cc: tony.luck@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds the ability to mmap legacy IO space to the legacy_io files
in sysfs on platforms that support it. This will allow to clean up
X to use this instead of /dev/mem for legacy IO accesses such as
those performed by Int10.

While at it I moved pci_create/remove_legacy_files() to pci-sysfs.c
where I think they belong, thus making more things statis in there
and cleaned up some spurrious prototypes in the ia64 pci.h file

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I didn't have a chance to test that I didn't break ia64, so I would
be if somebody could give it a spin there ! Thanks !

 arch/ia64/include/asm/pci.h |   12 -----
 arch/ia64/pci/pci.c         |    7 ++-
 drivers/pci/pci-sysfs.c     |   93 +++++++++++++++++++++++++++++++++++++++++---
 drivers/pci/pci.h           |    6 ++
 drivers/pci/probe.c         |   66 -------------------------------
 5 files changed, 102 insertions(+), 82 deletions(-)

--- linux-work.orig/arch/ia64/include/asm/pci.h	2008-10-03 11:24:12.000000000 +1000
+++ linux-work/arch/ia64/include/asm/pci.h	2008-10-03 11:25:08.000000000 +1000
@@ -95,16 +95,8 @@ extern int pci_mmap_page_range (struct p
 				enum pci_mmap_state mmap_state, int write_combine);
 #define HAVE_PCI_LEGACY
 extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
-				      struct vm_area_struct *vma);
-extern ssize_t pci_read_legacy_io(struct kobject *kobj,
-				  struct bin_attribute *bin_attr,
-				  char *buf, loff_t off, size_t count);
-extern ssize_t pci_write_legacy_io(struct kobject *kobj,
-				   struct bin_attribute *bin_attr,
-				   char *buf, loff_t off, size_t count);
-extern int pci_mmap_legacy_mem(struct kobject *kobj,
-			       struct bin_attribute *attr,
-			       struct vm_area_struct *vma);
+				      struct vm_area_struct *vma,
+				      enum pci_mmap_state mmap_state);
 
 #define pci_get_legacy_mem platform_pci_get_legacy_mem
 #define pci_legacy_read platform_pci_legacy_read
Index: linux-work/arch/ia64/pci/pci.c
===================================================================
--- linux-work.orig/arch/ia64/pci/pci.c	2008-10-03 11:23:35.000000000 +1000
+++ linux-work/arch/ia64/pci/pci.c	2008-10-03 11:47:17.000000000 +1000
@@ -614,12 +614,17 @@ char *ia64_pci_get_legacy_mem(struct pci
  * vector to get the base address.
  */
 int
-pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma)
+pci_mmap_legacy_page_range(struct pci_bus *bus, struct vm_area_struct *vma,
+			   enum pci_mmap_state mmap_state)
 {
 	unsigned long size = vma->vm_end - vma->vm_start;
 	pgprot_t prot;
 	char *addr;
 
+	/* We only support mmap'ing of legacy memory space */
+	if (mmap_state != pci_mmap_mem)
+		return -ENOSYS;
+
 	/*
 	 * Avoid attribute aliasing.  See Documentation/ia64/aliasing.txt
 	 * for more details.
Index: linux-work/drivers/pci/pci-sysfs.c
===================================================================
--- linux-work.orig/drivers/pci/pci-sysfs.c	2008-10-03 11:12:22.000000000 +1000
+++ linux-work/drivers/pci/pci-sysfs.c	2008-10-03 11:45:34.000000000 +1000
@@ -422,7 +422,7 @@ pci_write_vpd(struct kobject *kobj, stru
  * Reads 1, 2, or 4 bytes from legacy I/O port space using an arch specific
  * callback routine (pci_legacy_read).
  */
-ssize_t
+static ssize_t
 pci_read_legacy_io(struct kobject *kobj, struct bin_attribute *bin_attr,
 		   char *buf, loff_t off, size_t count)
 {
@@ -447,7 +447,7 @@ pci_read_legacy_io(struct kobject *kobj,
  * Writes 1, 2, or 4 bytes from legacy I/O port space using an arch specific
  * callback routine (pci_legacy_write).
  */
-ssize_t
+static ssize_t
 pci_write_legacy_io(struct kobject *kobj, struct bin_attribute *bin_attr,
 		    char *buf, loff_t off, size_t count)
 {
@@ -467,11 +467,11 @@ pci_write_legacy_io(struct kobject *kobj
  * @attr: struct bin_attribute for this file
  * @vma: struct vm_area_struct passed to mmap
  *
- * Uses an arch specific callback, pci_mmap_legacy_page_range, to mmap
+ * Uses an arch specific callback, pci_mmap_legacy_mem_page_range, to mmap
  * legacy memory space (first meg of bus space) into application virtual
  * memory space.
  */
-int
+static int
 pci_mmap_legacy_mem(struct kobject *kobj, struct bin_attribute *attr,
                     struct vm_area_struct *vma)
 {
@@ -479,7 +479,90 @@ pci_mmap_legacy_mem(struct kobject *kobj
                                                       struct device,
 						      kobj));
 
-        return pci_mmap_legacy_page_range(bus, vma);
+        return pci_mmap_legacy_page_range(bus, vma, pci_mmap_mem);
+}
+
+/**
+ * pci_mmap_legacy_io - map legacy PCI IO into user memory space
+ * @kobj: kobject corresponding to device to be mapped
+ * @attr: struct bin_attribute for this file
+ * @vma: struct vm_area_struct passed to mmap
+ *
+ * Uses an arch specific callback, pci_mmap_legacy_io_page_range, to mmap
+ * legacy IO space (first meg of bus space) into application virtual
+ * memory space. Returns -ENOSYS if the operation isn't supported
+ */
+static int
+pci_mmap_legacy_io(struct kobject *kobj, struct bin_attribute *attr,
+		   struct vm_area_struct *vma)
+{
+        struct pci_bus *bus = to_pci_bus(container_of(kobj,
+                                                      struct device,
+						      kobj));
+
+        return pci_mmap_legacy_page_range(bus, vma, pci_mmap_io);
+}
+
+/**
+ * pci_create_legacy_files - create legacy I/O port and memory files
+ * @b: bus to create files under
+ *
+ * Some platforms allow access to legacy I/O port and ISA memory space on
+ * a per-bus basis.  This routine creates the files and ties them into
+ * their associated read, write and mmap files from pci-sysfs.c
+ *
+ * On error unwind, but don't propogate the error to the caller
+ * as it is ok to set up the PCI bus without these files.
+ */
+void pci_create_legacy_files(struct pci_bus *b)
+{
+	int error;
+
+	b->legacy_io = kzalloc(sizeof(struct bin_attribute) * 2,
+			       GFP_ATOMIC);
+	if (!b->legacy_io)
+		goto kzalloc_err;
+
+	b->legacy_io->attr.name = "legacy_io";
+	b->legacy_io->size = 0xffff;
+	b->legacy_io->attr.mode = S_IRUSR | S_IWUSR;
+	b->legacy_io->read = pci_read_legacy_io;
+	b->legacy_io->write = pci_write_legacy_io;
+	b->legacy_io->mmap = pci_mmap_legacy_io;
+	error = device_create_bin_file(&b->dev, b->legacy_io);
+	if (error)
+		goto legacy_io_err;
+
+	/* Allocated above after the legacy_io struct */
+	b->legacy_mem = b->legacy_io + 1;
+	b->legacy_mem->attr.name = "legacy_mem";
+	b->legacy_mem->size = 1024*1024;
+	b->legacy_mem->attr.mode = S_IRUSR | S_IWUSR;
+	b->legacy_mem->mmap = pci_mmap_legacy_mem;
+	error = device_create_bin_file(&b->dev, b->legacy_mem);
+	if (error)
+		goto legacy_mem_err;
+
+	return;
+
+legacy_mem_err:
+	device_remove_bin_file(&b->dev, b->legacy_io);
+legacy_io_err:
+	kfree(b->legacy_io);
+	b->legacy_io = NULL;
+kzalloc_err:
+	printk(KERN_WARNING "pci: warning: could not create legacy I/O port "
+	       "and ISA memory resources to sysfs\n");
+	return;
+}
+
+void pci_remove_legacy_files(struct pci_bus *b)
+{
+	if (b->legacy_io) {
+		device_remove_bin_file(&b->dev, b->legacy_io);
+		device_remove_bin_file(&b->dev, b->legacy_mem);
+		kfree(b->legacy_io); /* both are allocated here */
+	}
 }
 #endif /* HAVE_PCI_LEGACY */
 
Index: linux-work/drivers/pci/pci.h
===================================================================
--- linux-work.orig/drivers/pci/pci.h	2008-10-03 11:17:53.000000000 +1000
+++ linux-work/drivers/pci/pci.h	2008-10-03 11:18:32.000000000 +1000
@@ -76,7 +76,13 @@ static inline int pci_proc_detach_bus(st
 /* Functions for PCI Hotplug drivers to use */
 extern unsigned int pci_do_scan_bus(struct pci_bus *bus);
 
+#ifdef HAVE_PCI_LEGACY
+extern void pci_create_legacy_files(struct pci_bus *bus);
 extern void pci_remove_legacy_files(struct pci_bus *bus);
+#else
+static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
+static inline void pci_remove_legacy_files(struct pci_bus *bus) { return; }
+#endif
 
 /* Lock for read/write access to pci device and bus lists */
 extern struct rw_semaphore pci_bus_sem;
Index: linux-work/drivers/pci/probe.c
===================================================================
--- linux-work.orig/drivers/pci/probe.c	2008-10-03 11:19:26.000000000 +1000
+++ linux-work/drivers/pci/probe.c	2008-10-03 11:19:57.000000000 +1000
@@ -44,72 +44,6 @@ int no_pci_devices(void)
 }
 EXPORT_SYMBOL(no_pci_devices);
 
-#ifdef HAVE_PCI_LEGACY
-/**
- * pci_create_legacy_files - create legacy I/O port and memory files
- * @b: bus to create files under
- *
- * Some platforms allow access to legacy I/O port and ISA memory space on
- * a per-bus basis.  This routine creates the files and ties them into
- * their associated read, write and mmap files from pci-sysfs.c
- *
- * On error unwind, but don't propogate the error to the caller
- * as it is ok to set up the PCI bus without these files.
- */
-static void pci_create_legacy_files(struct pci_bus *b)
-{
-	int error;
-
-	b->legacy_io = kzalloc(sizeof(struct bin_attribute) * 2,
-			       GFP_ATOMIC);
-	if (!b->legacy_io)
-		goto kzalloc_err;
-
-	b->legacy_io->attr.name = "legacy_io";
-	b->legacy_io->size = 0xffff;
-	b->legacy_io->attr.mode = S_IRUSR | S_IWUSR;
-	b->legacy_io->read = pci_read_legacy_io;
-	b->legacy_io->write = pci_write_legacy_io;
-	error = device_create_bin_file(&b->dev, b->legacy_io);
-	if (error)
-		goto legacy_io_err;
-
-	/* Allocated above after the legacy_io struct */
-	b->legacy_mem = b->legacy_io + 1;
-	b->legacy_mem->attr.name = "legacy_mem";
-	b->legacy_mem->size = 1024*1024;
-	b->legacy_mem->attr.mode = S_IRUSR | S_IWUSR;
-	b->legacy_mem->mmap = pci_mmap_legacy_mem;
-	error = device_create_bin_file(&b->dev, b->legacy_mem);
-	if (error)
-		goto legacy_mem_err;
-
-	return;
-
-legacy_mem_err:
-	device_remove_bin_file(&b->dev, b->legacy_io);
-legacy_io_err:
-	kfree(b->legacy_io);
-	b->legacy_io = NULL;
-kzalloc_err:
-	printk(KERN_WARNING "pci: warning: could not create legacy I/O port "
-	       "and ISA memory resources to sysfs\n");
-	return;
-}
-
-void pci_remove_legacy_files(struct pci_bus *b)
-{
-	if (b->legacy_io) {
-		device_remove_bin_file(&b->dev, b->legacy_io);
-		device_remove_bin_file(&b->dev, b->legacy_mem);
-		kfree(b->legacy_io); /* both are allocated here */
-	}
-}
-#else /* !HAVE_PCI_LEGACY */
-static inline void pci_create_legacy_files(struct pci_bus *bus) { return; }
-void pci_remove_legacy_files(struct pci_bus *bus) { return; }
-#endif /* HAVE_PCI_LEGACY */
-
 /*
  * PCI Bus Class Devices
  */
