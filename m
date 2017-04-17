Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6M6l5hjPzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 07:37:19 +1000 (AEST)
Subject: [PATCH v11 7/7] PCI: Don't resize resources when realigning all
 devices in system
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yongji Xie <elohimes@gmail.com>
Cc: zhong@linux.vnet.ibm.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Apr 2017 16:37:15 -0500
Message-ID: <20170417213714.21092.4773.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yongji Xie <elohimes@gmail.com>

The "pci=resource_alignment" argument aligns BARs of designated devices by
artificially increasing their size.  Increasing the size increases the
alignment and prevents other resources from being assigned in the same
alignment region, e.g., in the same page, but it can break drivers that use
the BAR size to locate things, e.g., ilo_map_device() does this:

  off = pci_resource_len(pdev, bar) - 0x2000;

The new pcibios_default_alignment() interface allows an arch to request
that *all* BARs in the system be aligned to a larger size.  In this case,
we don't need to artificially increase the resource size because we know
every BAR of every device will be realigned, so nothing will share the same
alignment region.

Use IORESOURCE_STARTALIGN to request realignment of PCI BARs when we know
we're realigning all BARs in the system.

[bhelgaas: comment, changelog]
Signed-off-by: Yongji Xie <elohimes@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |   59 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d92b80837cfa..bd31ecdb2257 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4959,11 +4959,13 @@ static DEFINE_SPINLOCK(resource_alignment_lock);
 /**
  * pci_specified_resource_alignment - get resource alignment specified by user.
  * @dev: the PCI device to get
+ * @resize: whether or not to change resources' size when reassigning alignment
  *
  * RETURNS: Resource alignment if it is specified.
  *          Zero if it is not specified.
  */
-static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
+static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev,
+							bool *resize)
 {
 	int seg, bus, slot, func, align_order, count;
 	unsigned short vendor, device, subsystem_vendor, subsystem_device;
@@ -5005,6 +5007,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 				(!device || (device == dev->device)) &&
 				(!subsystem_vendor || (subsystem_vendor == dev->subsystem_vendor)) &&
 				(!subsystem_device || (subsystem_device == dev->subsystem_device))) {
+				*resize = true;
 				if (align_order == -1)
 					align = PAGE_SIZE;
 				else
@@ -5030,6 +5033,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 				bus == dev->bus->number &&
 				slot == PCI_SLOT(dev->devfn) &&
 				func == PCI_FUNC(dev->devfn)) {
+				*resize = true;
 				if (align_order == -1)
 					align = PAGE_SIZE;
 				else
@@ -5050,7 +5054,7 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 }
 
 static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
-					   resource_size_t align)
+					   resource_size_t align, bool resize)
 {
 	struct resource *r = &dev->resource[bar];
 	resource_size_t size;
@@ -5069,23 +5073,45 @@ static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 		return;
 
 	/*
-	 * Increase the size of the resource.  BARs are aligned on their
-	 * size, so when we reallocate space for this resource, we'll
-	 * allocate it with the larger alignment.  It also prevents
-	 * assignment of any other BARs inside the size.  If we're
-	 * requesting page alignment, this means no other BARs will share
-	 * the page.
+	 * Increase the alignment of the resource.  There are two ways we
+	 * can do this:
 	 *
-	 * This makes the resource larger than the hardware BAR, which may
-	 * break drivers that compute things based on the resource size,
-	 * e.g., to find registers at a fixed offset before the end of the
-	 * BAR.  We hope users don't request alignment for such devices.
+	 * 1) Increase the size of the resource.  BARs are aligned on their
+	 *    size, so when we reallocate space for this resource, we'll
+	 *    allocate it with the larger alignment.  This also prevents
+	 *    assignment of any other BARs inside the alignment region, so
+	 *    if we're requesting page alignment, this means no other BARs
+	 *    will share the page.
+	 *
+	 *    The disadvantage is that this makes the resource larger than
+	 *    the hardware BAR, which may break drivers that compute things
+	 *    based on the resource size, e.g., to find registers at a
+	 *    fixed offset before the end of the BAR.
+	 *
+	 * 2) Retain the resource size, but use IORESOURCE_STARTALIGN and
+	 *    set r->start to the desired alignment.  By itself this
+	 *    doesn't prevent other BARs being put inside the alignment
+	 *    region, but if we realign *every* resource of every device in
+	 *    the system, none of them will share an alignment region.
+	 *
+	 * When the user has requested alignment for only some devices via
+	 * the "pci=resource_alignment" argument, "resize" is true and we
+	 * use the first method.  Otherwise we assume we're aligning all
+	 * devices and we use the second.
 	 */
+
 	dev_info(&dev->dev, "BAR%d %pR: requesting alignment to %#llx\n",
 		 bar, r, (unsigned long long)align);
 
-	r->start = 0;
-	r->end = align - 1;
+	if (resize) {
+		r->start = 0;
+		r->end = align - 1;
+	} else {
+		r->flags &= ~IORESOURCE_SIZEALIGN;
+		r->flags |= IORESOURCE_STARTALIGN;
+		r->start = align;
+		r->end = r->start + size - 1;
+	}
 	r->flags |= IORESOURCE_UNSET;
 }
 
@@ -5102,6 +5128,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	struct resource *r;
 	resource_size_t align, size;
 	u16 command;
+	bool resize = false;
 
 	/*
 	 * VF BARs are read-only zero according to SR-IOV spec r1.1, sec
@@ -5113,7 +5140,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 		return;
 
 	/* check if specified PCI is target device to reassign */
-	align = pci_specified_resource_alignment(dev);
+	align = pci_specified_resource_alignment(dev, &resize);
 	if (!align)
 		return;
 
@@ -5131,7 +5158,7 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	pci_write_config_word(dev, PCI_COMMAND, command);
 
 	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
-		pci_request_resource_alignment(dev, i, align);
+		pci_request_resource_alignment(dev, i, align, resize);
 
 	/*
 	 * Need to disable bridge's resource window,
