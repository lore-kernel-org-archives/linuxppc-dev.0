Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e36.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A9FE2B6F5A
 for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2012 01:52:16 +1000 (EST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 25 Jun 2012 09:52:10 -0600
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 43BA4C903C1
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 11:43:41 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5PFheoK33292520
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 11:43:40 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5PFhaKM020907
 for <linuxppc-dev@ozlabs.org>; Mon, 25 Jun 2012 12:43:39 -0300
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 8/8] ppc/pnv: remove unused functions
Date: Mon, 25 Jun 2012 23:43:21 +0800
Message-Id: <1340639001-28152-9-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1340639001-28152-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1340639001-28152-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't need them anymore. The patch removes those functions.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
Reviewed-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Richard Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |  441 -----------------------------
 1 file changed, 441 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 1368804..a40071f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -35,14 +35,6 @@
 #include "powernv.h"
 #include "pci.h"
 
-struct resource_wrap {
-	struct list_head	link;
-	resource_size_t		size;
-	resource_size_t		align;
-	struct pci_dev		*dev;	/* Set if it's a device */
-	struct pci_bus		*bus;	/* Set if it's a bridge */
-};
-
 static int __pe_printk(const char *level, const struct pnv_ioda_pe *pe,
 		       struct va_format *vaf)
 {
@@ -78,273 +70,6 @@ define_pe_printk_level(pe_err, KERN_ERR);
 define_pe_printk_level(pe_warn, KERN_WARNING);
 define_pe_printk_level(pe_info, KERN_INFO);
 
-
-/* Calculate resource usage & alignment requirement of a single
- * device. This will also assign all resources within the device
- * for a given type starting at 0 for the biggest one and then
- * assigning in decreasing order of size.
- */
-static void __devinit pnv_ioda_calc_dev(struct pci_dev *dev, unsigned int flags,
-					resource_size_t *size,
-					resource_size_t *align)
-{
-	resource_size_t start;
-	struct resource *r;
-	int i;
-
-	pr_devel("  -> CDR %s\n", pci_name(dev));
-
-	*size = *align = 0;
-
-	/* Clear the resources out and mark them all unset */
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		r = &dev->resource[i];
-		if (!(r->flags & flags))
-		    continue;
-		if (r->start) {
-			r->end -= r->start;
-			r->start = 0;
-		}
-		r->flags |= IORESOURCE_UNSET;
-	}
-
-	/* We currently keep all memory resources together, we
-	 * will handle prefetch & 64-bit separately in the future
-	 * but for now we stick everybody in M32
-	 */
-	start = 0;
-	for (;;) {
-		resource_size_t max_size = 0;
-		int max_no = -1;
-
-		/* Find next biggest resource */
-		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-			r = &dev->resource[i];
-			if (!(r->flags & IORESOURCE_UNSET) ||
-			    !(r->flags & flags))
-				continue;
-			if (resource_size(r) > max_size) {
-				max_size = resource_size(r);
-				max_no = i;
-			}
-		}
-		if (max_no < 0)
-			break;
-		r = &dev->resource[max_no];
-		if (max_size > *align)
-			*align = max_size;
-		*size += max_size;
-		r->start = start;
-		start += max_size;
-		r->end = r->start + max_size - 1;
-		r->flags &= ~IORESOURCE_UNSET;
-		pr_devel("  ->     R%d %016llx..%016llx\n",
-			 max_no, r->start, r->end);
-	}
-	pr_devel("  <- CDR %s size=%llx align=%llx\n",
-		 pci_name(dev), *size, *align);
-}
-
-/* Allocate a resource "wrap" for a given device or bridge and
- * insert it at the right position in the sorted list
- */
-static void __devinit pnv_ioda_add_wrap(struct list_head *list,
-					struct pci_bus *bus,
-					struct pci_dev *dev,
-					resource_size_t size,
-					resource_size_t align)
-{
-	struct resource_wrap *w1, *w = kzalloc(sizeof(*w), GFP_KERNEL);
-
-	w->size = size;
-	w->align = align;
-	w->dev = dev;
-	w->bus = bus;
-
-	list_for_each_entry(w1, list, link) {
-		if (w1->align < align) {
-			list_add_tail(&w->link, &w1->link);
-			return;
-		}
-	}
-	list_add_tail(&w->link, list);
-}
-
-/* Offset device resources of a given type */
-static void __devinit pnv_ioda_offset_dev(struct pci_dev *dev,
-					  unsigned int flags,
-					  resource_size_t offset)
-{
-	struct resource *r;
-	int i;
-
-	pr_devel("  -> ODR %s [%x] +%016llx\n", pci_name(dev), flags, offset);
-
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		r = &dev->resource[i];
-		if (r->flags & flags) {
-			dev->resource[i].start += offset;
-			dev->resource[i].end += offset;
-		}
-	}
-
-	pr_devel("  <- ODR %s [%x] +%016llx\n", pci_name(dev), flags, offset);
-}
-
-/* Offset bus resources (& all children) of a given type */
-static void __devinit pnv_ioda_offset_bus(struct pci_bus *bus,
-					  unsigned int flags,
-					  resource_size_t offset)
-{
-	struct resource *r;
-	struct pci_dev *dev;
-	struct pci_bus *cbus;
-	int i;
-
-	pr_devel("  -> OBR %s [%x] +%016llx\n",
-		 bus->self ? pci_name(bus->self) : "root", flags, offset);
-
-	pci_bus_for_each_resource(bus, r, i) {
-		if (r && (r->flags & flags)) {
-			r->start += offset;
-			r->end += offset;
-		}
-	}
-	list_for_each_entry(dev, &bus->devices, bus_list)
-		pnv_ioda_offset_dev(dev, flags, offset);
-	list_for_each_entry(cbus, &bus->children, node)
-		pnv_ioda_offset_bus(cbus, flags, offset);
-
-	pr_devel("  <- OBR %s [%x]\n",
-		 bus->self ? pci_name(bus->self) : "root", flags);
-}
-
-/* This is the guts of our IODA resource allocation. This is called
- * recursively for each bus in the system. It calculates all the
- * necessary size and requirements for children and assign them
- * resources such that:
- *
- *   - Each function fits in it's own contiguous set of IO/M32
- *     segment
- *
- *   - All segments behind a P2P bridge are contiguous and obey
- *     alignment constraints of those bridges
- */
-static void __devinit pnv_ioda_calc_bus(struct pci_bus *bus, unsigned int flags,
-					resource_size_t *size,
-					resource_size_t *align)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	struct pnv_phb *phb = hose->private_data;
-	resource_size_t dev_size, dev_align, start;
-	resource_size_t min_align, min_balign;
-	struct pci_dev *cdev;
-	struct pci_bus *cbus;
-	struct list_head head;
-	struct resource_wrap *w;
-	unsigned int bres;
-
-	*size = *align = 0;
-
-	pr_devel("-> CBR %s [%x]\n",
-		 bus->self ? pci_name(bus->self) : "root", flags);
-
-	/* Calculate alignment requirements based on the type
-	 * of resource we are working on
-	 */
-	if (flags & IORESOURCE_IO) {
-		bres = 0;
-		min_align = phb->ioda.io_segsize;
-		min_balign = 0x1000;
-	} else {
-		bres = 1;
-		min_align = phb->ioda.m32_segsize;
-		min_balign = 0x100000;
-	}
-
-	/* Gather all our children resources ordered by alignment */
-	INIT_LIST_HEAD(&head);
-
-	/*   - Busses */
-	list_for_each_entry(cbus, &bus->children, node) {
-		pnv_ioda_calc_bus(cbus, flags, &dev_size, &dev_align);
-		pnv_ioda_add_wrap(&head, cbus, NULL, dev_size, dev_align);
-	}
-
-	/*   - Devices */
-	list_for_each_entry(cdev, &bus->devices, bus_list) {
-		pnv_ioda_calc_dev(cdev, flags, &dev_size, &dev_align);
-		/* Align them to segment size */
-		if (dev_align < min_align)
-			dev_align = min_align;
-		pnv_ioda_add_wrap(&head, NULL, cdev, dev_size, dev_align);
-	}
-	if (list_empty(&head))
-		goto empty;
-
-	/* Now we can do two things: assign offsets to them within that
-	 * level and get our total alignment & size requirements. The
-	 * assignment algorithm is going to be uber-trivial for now, we
-	 * can try to be smarter later at filling out holes.
-	 */
-	if (bus->self) {
-		/* No offset for downstream bridges */
-		start = 0;
-	} else {
-		/* Offset from the root */
-		if (flags & IORESOURCE_IO)
-			/* Don't hand out IO 0 */
-			start = hose->io_resource.start + 0x1000;
-		else
-			start = hose->mem_resources[0].start;
-	}
-	while(!list_empty(&head)) {
-		w = list_first_entry(&head, struct resource_wrap, link);
-		list_del(&w->link);
-		if (w->size) {
-			if (start) {
-				start = ALIGN(start, w->align);
-				if (w->dev)
-					pnv_ioda_offset_dev(w->dev,flags,start);
-				else if (w->bus)
-					pnv_ioda_offset_bus(w->bus,flags,start);
-			}
-			if (w->align > *align)
-				*align = w->align;
-		}
-		start += w->size;
-		kfree(w);
-	}
-	*size = start;
-
-	/* Align and setup bridge resources */
-	*align = max_t(resource_size_t, *align,
-		       max_t(resource_size_t, min_align, min_balign));
-	*size = ALIGN(*size,
-		      max_t(resource_size_t, min_align, min_balign));
- empty:
-	/* Only setup P2P's, not the PHB itself */
-	if (bus->self) {
-		struct resource *res = bus->resource[bres];
-
-		if (WARN_ON(res == NULL))
-			return;
-
-		/*
-		 * FIXME: We should probably export and call
-		 * pci_bridge_check_ranges() to properly re-initialize
-		 * the PCI portion of the flags here, and to detect
-		 * what the bridge actually supports.
-		 */
-		res->start = 0;
-		res->flags = (*size) ? flags : 0;
-		res->end = (*size) ? (*size - 1) : 0;
-	}
-
-	pr_devel("<- CBR %s [%x] *size=%016llx *align=%016llx\n",
-		 bus->self ? pci_name(bus->self) : "root", flags,*size,*align);
-}
-
 static struct pci_dn *pnv_ioda_get_pdn(struct pci_dev *dev)
 {
 	struct device_node *np;
@@ -355,172 +80,6 @@ static struct pci_dn *pnv_ioda_get_pdn(struct pci_dev *dev)
 	return PCI_DN(np);
 }
 
-static void __devinit pnv_ioda_setup_pe_segments(struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct pnv_phb *phb = hose->private_data;
-	struct pci_dn *pdn = pnv_ioda_get_pdn(dev);
-	unsigned int pe, i;
-	resource_size_t pos;
-	struct resource io_res;
-	struct resource m32_res;
-	struct pci_bus_region region;
-	int rc;
-
-	/* Anything not referenced in the device-tree gets PE#0 */
-	pe = pdn ? pdn->pe_number : 0;
-
-	/* Calculate the device min/max */
-	io_res.start = m32_res.start = (resource_size_t)-1;
-	io_res.end = m32_res.end = 0;
-	io_res.flags = IORESOURCE_IO;
-	m32_res.flags = IORESOURCE_MEM;
-
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		struct resource *r = NULL;
-		if (dev->resource[i].flags & IORESOURCE_IO)
-			r = &io_res;
-		if (dev->resource[i].flags & IORESOURCE_MEM)
-			r = &m32_res;
-		if (!r)
-			continue;
-		if (dev->resource[i].start < r->start)
-			r->start = dev->resource[i].start;
-		if (dev->resource[i].end > r->end)
-			r->end = dev->resource[i].end;
-	}
-
-	/* Setup IO segments */
-	if (io_res.start < io_res.end) {
-		pcibios_resource_to_bus(dev, &region, &io_res);
-		pos = region.start;
-		i = pos / phb->ioda.io_segsize;
-		while(i < phb->ioda.total_pe && pos <= region.end) {
-			if (phb->ioda.io_segmap[i]) {
-				pr_err("%s: Trying to use IO seg #%d which is"
-				       " already used by PE# %d\n",
-				       pci_name(dev), i,
-				       phb->ioda.io_segmap[i]);
-				/* XXX DO SOMETHING TO DISABLE DEVICE ? */
-				break;
-			}
-			phb->ioda.io_segmap[i] = pe;
-			rc = opal_pci_map_pe_mmio_window(phb->opal_id, pe,
-							 OPAL_IO_WINDOW_TYPE,
-							 0, i);
-			if (rc != OPAL_SUCCESS) {
-				pr_err("%s: OPAL error %d setting up mapping"
-				       " for IO seg# %d\n",
-				       pci_name(dev), rc, i);
-				/* XXX DO SOMETHING TO DISABLE DEVICE ? */
-				break;
-			}
-			pos += phb->ioda.io_segsize;
-			i++;
-		};
-	}
-
-	/* Setup M32 segments */
-	if (m32_res.start < m32_res.end) {
-		pcibios_resource_to_bus(dev, &region, &m32_res);
-		pos = region.start;
-		i = pos / phb->ioda.m32_segsize;
-		while(i < phb->ioda.total_pe && pos <= region.end) {
-			if (phb->ioda.m32_segmap[i]) {
-				pr_err("%s: Trying to use M32 seg #%d which is"
-				       " already used by PE# %d\n",
-				       pci_name(dev), i,
-				       phb->ioda.m32_segmap[i]);
-				/* XXX DO SOMETHING TO DISABLE DEVICE ? */
-				break;
-			}
-			phb->ioda.m32_segmap[i] = pe;
-			rc = opal_pci_map_pe_mmio_window(phb->opal_id, pe,
-							 OPAL_M32_WINDOW_TYPE,
-							 0, i);
-			if (rc != OPAL_SUCCESS) {
-				pr_err("%s: OPAL error %d setting up mapping"
-				       " for M32 seg# %d\n",
-				       pci_name(dev), rc, i);
-				/* XXX DO SOMETHING TO DISABLE DEVICE ? */
-				break;
-			}
-			pos += phb->ioda.m32_segsize;
-			i++;
-		}
-	}
-}
-
-/* Check if a resource still fits in the total IO or M32 range
- * for a given PHB
- */
-static int __devinit pnv_ioda_resource_fit(struct pci_controller *hose,
-					   struct resource *r)
-{
-	struct resource *bounds;
-
-	if (r->flags & IORESOURCE_IO)
-		bounds = &hose->io_resource;
-	else if (r->flags & IORESOURCE_MEM)
-		bounds = &hose->mem_resources[0];
-	else
-		return 1;
-
-	if (r->start >= bounds->start && r->end <= bounds->end)
-		return 1;
-	r->flags = 0;
-	return 0;
-}
-
-static void __devinit pnv_ioda_update_resources(struct pci_bus *bus)
-{
-	struct pci_controller *hose = pci_bus_to_host(bus);
-	struct pci_bus *cbus;
-	struct pci_dev *cdev;
-	unsigned int i;
-
-	/* We used to clear all device enables here. However it looks like
-	 * clearing MEM enable causes Obsidian (IPR SCS) to go bonkers,
-	 * and shoot fatal errors to the PHB which in turns fences itself
-	 * and we can't recover from that ... yet. So for now, let's leave
-	 * the enables as-is and hope for the best.
-	 */
-
-	/* Check if bus resources fit in our IO or M32 range */
-	for (i = 0; bus->self && (i < 2); i++) {
-		struct resource *r = bus->resource[i];
-		if (r && !pnv_ioda_resource_fit(hose, r))
-			pr_err("%s: Bus %d resource %d disabled, no room\n",
-			       pci_name(bus->self), bus->number, i);
-	}
-
-	/* Update self if it's not a PHB */
-	if (bus->self)
-		pci_setup_bridge(bus);
-
-	/* Update child devices */
-	list_for_each_entry(cdev, &bus->devices, bus_list) {
-		/* Check if resource fits, if not, disabled it */
-		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-			struct resource *r = &cdev->resource[i];
-			if (!pnv_ioda_resource_fit(hose, r))
-				pr_err("%s: Resource %d disabled, no room\n",
-				       pci_name(cdev), i);
-		}
-
-		/* Assign segments */
-		pnv_ioda_setup_pe_segments(cdev);
-
-		/* Update HW BARs */
-		for (i = 0; i <= PCI_ROM_RESOURCE; i++)
-			pci_update_resource(cdev, i);
-	}
-
-	/* Update child busses */
-	list_for_each_entry(cbus, &bus->children, node)
-		pnv_ioda_update_resources(cbus);
-}
-
 static int __devinit pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
 	unsigned long pe;
-- 
1.7.9.5
