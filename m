Message-ID: <40C70D4D.5010101@fh-landshut.de>
Date: Wed, 09 Jun 2004 15:14:53 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Complete VME driver patch for PowerPC
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com> <40C48A1C.30602@fh-landshut.de> <40C7099D.10206@fh-landshut.de>
In-Reply-To: <40C7099D.10206@fh-landshut.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This should be the complete patch for vmisft-7433-3.2 to work on PPCs.

With kind regards,
Oliver Korpilla

Index: module/vme_master.c
===================================================================
--- module/vme_master.c (revision 1)
+++ module/vme_master.c (revision 8)
@@ -164,6 +164,66 @@
  MODULE_PARM(master_window7, "3-4i");


+extern struct pci_dev *universe_pci_dev;
+
+/* Try getting a resource (range of PCI addresses) from the PCI bus we're on */
+static int allocate_pci_resource(unsigned long size, unsigned long align,
+                                struct resource *new_resource) {
+  /* Determine the bus the Tundra is on */
+  struct pci_bus *bus = universe_pci_dev->bus;
+  int i;
+
+  for (i=0; i<4; i++) {
+    int retval;
+    struct resource *r = bus->resource[i];
+
+    /* Check if that resource exists */
+    if (!r)
+      continue;
+
+    /* If the resource is not I/O memory (e.g. I/O ports) */
+    if (! (r->flags & IORESOURCE_MEM))
+      continue;
+
+#ifdef DEBUG
+    /* Print out name of resource for debugging */
+    if (r->name)
+      printk(KERN_INFO "Checking bus resource with name \"%s\".\n", r->name);
+    printk(KERN_INFO "resource.start: %08lX, resource.end: %08lX.\n",
+          r->start, r->end);
+#endif
+
+    /* Try to allocate a new sub-resource from this
+       given the proper size and alignment*/
+    retval = allocate_resource(r, new_resource, size,
+                              pci_lo_bound, pci_hi_bound,
+                              align, NULL, NULL);
+
+    /* If this allocation fails, try with next resource
+       (and give debug message) */
+    if (retval < 0) {
+
+#ifdef DEBUG
+      if (r->name)
+       printk(KERN_INFO
+              "Failed allocating from bus resource with name \"%s\".\n",
+              r->name);
+      else
+       printk(KERN_INFO
+              "Failed allocating from bus resource with number %d.\n", i);
+#endif
+
+      continue;
+    }
+    /* If this allocation succeeds, return what allocate_resource() returned */
+    else
+      return retval;
+  }
+
+  /* return busy if no resource could be successfully allocated */
+  return -EBUSY;
+}
+
  /*============================================================================
   * Hook for display proc page info
   * WARNING: If the amount of data displayed exceeds a page, then we need to
@@ -428,9 +488,8 @@
                         return rval;
                 }
         } else {
-               rval = allocate_resource(&iomem_resource, &window->resource,
-                                        size, pci_lo_bound, pci_hi_bound,
-                                        resolution, NULL, NULL);
+               rval = allocate_pci_resource(size, resolution, &window->resource);
+
                 if (rval) {
                         window->resource.start = 0;
                         window->resource.end = 0;
@@ -622,9 +681,8 @@

         /* Allocate a 64MB window with 64kb resolution
          */
-       rval = allocate_resource(&iomem_resource, &slsi_window.resource,
-                                0x4000000, pci_lo_bound, pci_hi_bound,
-                                0x10000, NULL, NULL);
+       rval = allocate_pci_resource(0x4000000, 0x10000, &slsi_window.resource);
+
         if (rval) {
                 printk(KERN_WARNING "VME: Unable to allocate memory for SLSI "
                        "window\n");
Index: module/vme_main.c
===================================================================
--- module/vme_main.c   (revision 1)
+++ module/vme_main.c   (revision 8)
@@ -191,14 +191,18 @@
   */
  int vme_mmap(struct file *file_ptr, struct vm_area_struct *vma)
  {
-
         DPRINTF("Attempting to map %#lx bytes of memory at "
                 "physical address %#lx\n", vma->vm_end - vma->vm_start,
                 vma->vm_pgoff << PAGE_SHIFT);

+#ifdef CONFIG_PPC32
+       vma->vm_page_prot.pgprot |= _PAGE_NO_CACHE | _PAGE_GUARDED;
+       DPRINTF("PowerPC protection flags set.\n");
+#endif
+
         /* Don't swap these pages out
          */
-       vma->vm_flags |= VM_RESERVED;
+       vma->vm_flags |= VM_LOCKED | VM_IO | VM_SHM;

  #if LINUX_VERSION_CODE >= KERNEL_VERSION(2,5,3) || defined RH9BRAINDAMAGE
         return remap_page_range(vma, vma->vm_start, vma->vm_pgoff << PAGE_SHIFT,

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
