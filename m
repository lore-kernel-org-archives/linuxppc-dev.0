Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6M6T2PFQzDqFc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 07:37:05 +1000 (AEST)
Subject: [PATCH v11 5/7] PCI: Factor pci_reassigndev_resource_alignment()
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yongji Xie <elohimes@gmail.com>
Cc: zhong@linux.vnet.ibm.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Apr 2017 16:37:00 -0500
Message-ID: <20170417213700.21092.58744.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

Pull the BAR size adjustment out into a new function,
pci_request_resource_alignment(), and add a comment about how and why we
increase the resource size and alignment.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |   67 ++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index a2d1f144c94f..17746f778ca2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5049,6 +5049,48 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 	return align;
 }
 
+static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
+					   resource_size_t align)
+{
+	struct resource *r = &dev->resource[bar];
+	resource_size_t size;
+
+	if (!(r->flags & IORESOURCE_MEM))
+		return;
+
+	if (r->flags & IORESOURCE_PCI_FIXED) {
+		dev_info(&dev->dev, "BAR%d %pR: ignoring requested alignment %#llx\n",
+			 bar, r, (unsigned long long)align);
+		return;
+	}
+
+	size = resource_size(r);
+	if (size < align) {
+
+		/*
+		 * Increase the size of the resource.  BARs are aligned on
+		 * their size, so when we reallocate space for this
+		 * resource, we'll allocate it with the larger alignment.
+		 * It also prevents assignment of any other BARs inside the
+		 * size.  If we're requesting page alignment, this means no
+		 * other BARs will share the page.
+		 *
+		 * This makes the resource larger than the hardware BAR,
+		 * which may break drivers that compute things based on the
+		 * resource size, e.g., to find registers at a fixed offset
+		 * before the end of the BAR.  We hope users don't request
+		 * alignment for such devices.
+		 */
+		size = align;
+		dev_info(&dev->dev, "BAR%d %pR: requesting alignment to %#llx\n",
+			 bar, r, (unsigned long long)align);
+
+	}
+	r->flags |= IORESOURCE_UNSET;
+	r->end = size - 1;
+	r->start = 0;
+}
+
 /*
  * This function disables memory decoding and releases memory resources
  * of the device specified by kernel's boot parameter 'pci=resource_alignment='.
@@ -5090,28 +5132,11 @@ void pci_reassigndev_resource_alignment(struct pci_dev *dev)
 	command &= ~PCI_COMMAND_MEMORY;
 	pci_write_config_word(dev, PCI_COMMAND, command);
 
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		r = &dev->resource[i];
-		if (!(r->flags & IORESOURCE_MEM))
-			continue;
-		if (r->flags & IORESOURCE_PCI_FIXED) {
-			dev_info(&dev->dev, "Ignoring requested alignment for BAR%d: %pR\n",
-				i, r);
-			continue;
-		}
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++)
+		pci_request_resource_alignment(dev, i, align);
 
-		size = resource_size(r);
-		if (size < align) {
-			size = align;
-			dev_info(&dev->dev,
-				"Rounding up size of resource #%d to %#llx.\n",
-				i, (unsigned long long)size);
-		}
-		r->flags |= IORESOURCE_UNSET;
-		r->end = size - 1;
-		r->start = 0;
-	}
-	/* Need to disable bridge's resource window,
+	/*
+	 * Need to disable bridge's resource window,
 	 * to enable the kernel to reassign new resource
 	 * window later on.
 	 */
