Message-ID: <40C48A1C.30602@fh-landshut.de>
Date: Mon, 07 Jun 2004 17:30:36 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: "Heater, Daniel (GE Infrastructure)" <Daniel.Heater@gefanuc.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: VME driver patch for PowerPC
References: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com>
In-Reply-To: <DB1DE297F535B340AEAE1E51B221C3D0016B3DCB@FTWMLVEM02.e2k.ad.ge.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello!

Could you check, whether the patch to your driver (version 7433-3.2 of your
Linux support) still compiles on an Intel platform, and works as intended?

Problem is, this is not complete:

Direct referencing of the obtained memory pointer will lead to "bad" PCI
accesses, 8 long words in a row, writing to the window will trigger a read
(again 8  long words) and a failed write afterwards.

But using standard readl() and writel()  on the ioremap_nocache'd addresses will
work just fine (just except that it swaps the byte-order, from PCI little endian
to host big endian), with correct and proper accesses.

So dereferencing the pointer has bad results, using memcpy() as well, but kernel
macros work fine.

Either this is still a cache problem, and if so, I may or may not find and solve
it, or I have to use appropriate macros in read() and write() calls, and
implement those - this would work on both platforms.

Patch follows below (it's not really much - minimally different from what I've
already sent you, but it's the minimal change that will produce PCI accesses,
and correct ones, if used with readl()/writel()).

With kind regards,
Oliver Korpilla

diff -urN vme_universe/module/vme_master.c vme_universe-new/module/vme_master.c
--- vme_universe/module/vme_master.c	2004-06-07 17:16:13.000000000 +0200
+++ vme_universe-new/module/vme_master.c	2004-06-07 17:13:43.000000000 +0200
@@ -163,6 +163,65 @@
  MODULE_PARM(master_window6, "3-4i");
  MODULE_PARM(master_window7, "3-4i");

+extern struct pci_dev *universe_pci_dev;
+
+/* Try getting a resource (range of PCI addresses) from the PCI bus we're on */
+static int allocate_pci_resource(unsigned long size, unsigned long align,
+				 struct resource *new_resource) {
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
+	   r->start, r->end);
+#endif
+
+    /* Try to allocate a new sub-resource from this
+       given the proper size and alignment*/
+    retval = allocate_resource(r, new_resource, size,
+			       pci_lo_bound, pci_hi_bound,
+			       align, NULL, NULL);
+
+    /* If this allocation fails, try with next resource
+       (and give debug message) */
+    if (retval < 0) {
+
+#ifdef DEBUG
+      if (r->name)
+	printk(KERN_INFO
+	       "Failed allocating from bus resource with name \"%s\".\n",
+	       r->name);
+      else
+	printk(KERN_INFO
+	       "Failed allocating from bus resource with number %d.\n", i);
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

  /*============================================================================
   * Hook for display proc page info
@@ -428,9 +487,8 @@
  			return rval;
  		}
  	} else {
-		rval = allocate_resource(&iomem_resource, &window->resource,
-					 size, pci_lo_bound, pci_hi_bound,
-					 resolution, NULL, NULL);
+		rval = allocate_pci_resource(size, resolution, &window->resource);
+
  		if (rval) {
  			window->resource.start = 0;
  			window->resource.end = 0;
@@ -622,9 +680,8 @@

  	/* Allocate a 64MB window with 64kb resolution
  	 */
-	rval = allocate_resource(&iomem_resource, &slsi_window.resource,
-				 0x4000000, pci_lo_bound, pci_hi_bound,
-				 0x10000, NULL, NULL);
+	rval = allocate_pci_resource(0x4000000, 0x10000, &slsi_window.resource);
+
  	if (rval) {
  		printk(KERN_WARNING "VME: Unable to allocate memory for SLSI "
  		       "window\n");

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
