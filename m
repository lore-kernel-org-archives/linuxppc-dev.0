Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67BE5B6FA4
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 13:10:39 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Sun, 24 Jun 2012 23:10:34 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 439D838C8056
 for <linuxppc-dev@ozlabs.org>; Sun, 24 Jun 2012 23:10:32 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5P3AWMg135932
 for <linuxppc-dev@ozlabs.org>; Sun, 24 Jun 2012 23:10:32 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5P8fNmM015968
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 04:41:24 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linux-pci@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V3 2/2] PCI: minimal alignment for bars of P2P bridges
Date: Mon, 25 Jun 2012 11:10:20 +0800
Message-Id: <1340593821-19011-2-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340593821-19011-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340593821-19011-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On some powerpc platforms, device BARs need to be assigned to separate
"segments" of the address space in order for the error isolation and HW
virtualization mechanisms (EEH) to work properly. Those "segments" have
a minimum size that can be fairly large (16M). In order to be able to
use the generic resource assignment code rather than re-inventing our
own, we chose to group devices by bus. That way, a simple change of the
minimum alignment requirements of resources assigned to PCI to PCI (P2P)
bridges is enough to ensure that all BARs for devices below those bridges
will fit into contiguous sets of segments and there will be no overlap.

This patch provides a way for the host bridge to override the default
alignment values used by the resource allocation code for that purpose.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
---
 drivers/pci/probe.c     |    5 +++++
 drivers/pci/setup-bus.c |   28 +++++++++++++++++++++-------
 include/linux/pci.h     |    8 ++++++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 658ac97..a196529 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -431,6 +431,11 @@ static struct pci_host_bridge *pci_alloc_host_bridge(struct pci_bus *b)
 	if (bridge) {
 		INIT_LIST_HEAD(&bridge->windows);
 		bridge->bus = b;
+
+		/* Set minimal alignment shift of P2P bridges */
+		bridge->io_align_shift = PCI_DEFAULT_IO_ALIGN_SHIFT;
+		bridge->mem_align_shift = PCI_DEFAULT_MEM_ALIGN_SHIFT;
+		bridge->pmem_align_shift = PCI_DEFAULT_PMEM_ALIGN_SHIFT;
 	}
 
 	return bridge;
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8fa2d4b..7c3e90d 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -706,10 +706,12 @@ static resource_size_t calculate_memsize(resource_size_t size,
 static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		resource_size_t add_size, struct list_head *realloc_head)
 {
+	struct pci_host_bridge *phb;
 	struct pci_dev *dev;
 	struct resource *b_res = find_free_bus_resource(bus, IORESOURCE_IO);
 	unsigned long size = 0, size0 = 0, size1 = 0;
 	resource_size_t children_add_size = 0;
+	resource_size_t io_align;
 
 	if (!b_res)
  		return;
@@ -735,13 +737,17 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 				children_add_size += get_res_add_size(realloc_head, r);
 		}
 	}
+
+	phb = pci_bus_host_bridge(bus);
+	io_align = (1 << phb->io_align_shift);
+
 	size0 = calculate_iosize(size, min_size, size1,
-			resource_size(b_res), 4096);
+			resource_size(b_res), io_align);
 	if (children_add_size > add_size)
 		add_size = children_add_size;
 	size1 = (!realloc_head || (realloc_head && !add_size)) ? size0 :
 		calculate_iosize(size, min_size, add_size + size1,
-			resource_size(b_res), 4096);
+			resource_size(b_res), io_align);
 	if (!size0 && !size1) {
 		if (b_res->start || b_res->end)
 			dev_info(&bus->self->dev, "disabling bridge window "
@@ -751,11 +757,11 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		return;
 	}
 	/* Alignment of the IO window is always 4K */
-	b_res->start = 4096;
+	b_res->start = io_align;
 	b_res->end = b_res->start + size0 - 1;
 	b_res->flags |= IORESOURCE_STARTALIGN;
 	if (size1 > size0 && realloc_head) {
-		add_to_list(realloc_head, bus->self, b_res, size1-size0, 4096);
+		add_to_list(realloc_head, bus->self, b_res, size1-size0, io_align);
 		dev_printk(KERN_DEBUG, &bus->self->dev, "bridge window "
 				 "%pR to [bus %02x-%02x] add_size %lx\n", b_res,
 				 bus->secondary, bus->subordinate, size1-size0);
@@ -778,6 +784,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			resource_size_t add_size,
 			struct list_head *realloc_head)
 {
+	struct pci_host_bridge *phb;
 	struct pci_dev *dev;
 	resource_size_t min_align, align, size, size0, size1;
 	resource_size_t aligns[12];	/* Alignments from 1Mb to 2Gb */
@@ -785,10 +792,17 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	struct resource *b_res = find_free_bus_resource(bus, type);
 	unsigned int mem64_mask = 0;
 	resource_size_t children_add_size = 0;
+	int mem_align_shift;
 
 	if (!b_res)
 		return 0;
 
+	phb = pci_bus_host_bridge(bus);
+	if (type & IORESOURCE_PREFETCH)
+		mem_align_shift = phb->pmem_align_shift;
+	else
+		mem_align_shift = phb->mem_align_shift;
+
 	memset(aligns, 0, sizeof(aligns));
 	max_order = 0;
 	size = 0;
@@ -818,8 +832,8 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 #endif
 			/* For bridges size != alignment */
 			align = pci_resource_alignment(dev, r);
-			order = __ffs(align) - 20;
-			if (order > 11) {
+			order = __ffs(align) - mem_align_shift;
+			if (order > (11 - (mem_align_shift - 20))) {
 				dev_warn(&dev->dev, "disabling BAR %d: %pR "
 					 "(bad alignment %#llx)\n", i, r,
 					 (unsigned long long) align);
@@ -846,7 +860,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 	for (order = 0; order <= max_order; order++) {
 		resource_size_t align1 = 1;
 
-		align1 <<= (order + 20);
+		align1 <<= (order + mem_align_shift);
 
 		if (!align)
 			min_align = align1;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 6d5bb1c..ed55e58 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -376,9 +376,17 @@ struct pci_host_bridge_window {
 	resource_size_t offset;		/* bus address + offset = CPU address */
 };
 
+/* Default shits for P2P I/O and MMIO bar minimal alignment shifts */
+#define PCI_DEFAULT_IO_ALIGN_SHIFT	12	/* 4KB  */
+#define PCI_DEFAULT_MEM_ALIGN_SHIFT	20	/* 1MB  */
+#define PCI_DEFAULT_PMEM_ALIGN_SHIFT	20	/* 1MB */
+
 struct pci_host_bridge {
 	struct device dev;
 	struct pci_bus *bus;		/* root bus */
+	int io_align_shift;		/* P2P I/O bar minimal alignment shift  */
+	int mem_align_shift;		/* P2P MMIO bar minimal alignment shift */
+	int pmem_align_shift;		/* P2P prefetchable MMIO bar minimal alignment shift */
 	struct list_head windows;	/* pci_host_bridge_windows */
 	void (*release_fn)(struct pci_host_bridge *);
 	void *release_data;
-- 
1.7.9.5
