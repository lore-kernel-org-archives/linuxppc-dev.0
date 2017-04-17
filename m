Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6M6c2MrDzDqK9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 07:37:12 +1000 (AEST)
Subject: [PATCH v11 6/7] PCI: Don't reassign resources that are already aligned
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yongji Xie <elohimes@gmail.com>
Cc: zhong@linux.vnet.ibm.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Apr 2017 16:37:08 -0500
Message-ID: <20170417213707.21092.35205.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

The "pci=resource_alignment=" kernel argument designates devices for which
we want alignment greater than is required by the PCI specs.  Previously we
set IORESOURCE_UNSET for every MEM resource of those devices, even if the
resource was *already* sufficiently aligned.

If a resource is already sufficiently aligned, leave it alone and don't try
to reassign it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |   40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 17746f778ca2..d92b80837cfa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5065,30 +5065,28 @@ static void pci_request_resource_alignment(struct pci_dev *dev, int bar,
 	}
 
 	size = resource_size(r);
-	if (size < align) {
+	if (size >= align)
+		return;
 
-		/*
-		 * Increase the size of the resource.  BARs are aligned on
-		 * their size, so when we reallocate space for this
-		 * resource, we'll allocate it with the larger alignment.
-		 * It also prevents assignment of any other BARs inside the
-		 * size.  If we're requesting page alignment, this means no
-		 * other BARs will share the page.
-		 *
-		 * This makes the resource larger than the hardware BAR,
-		 * which may break drivers that compute things based on the
-		 * resource size, e.g., to find registers at a fixed offset
-		 * before the end of the BAR.  We hope users don't request
-		 * alignment for such devices.
-		 */
-		size = align;
-		dev_info(&dev->dev, "BAR%d %pR: requesting alignment to %#llx\n",
-			 bar, r, (unsigned long long)align);
+	/*
+	 * Increase the size of the resource.  BARs are aligned on their
+	 * size, so when we reallocate space for this resource, we'll
+	 * allocate it with the larger alignment.  It also prevents
+	 * assignment of any other BARs inside the size.  If we're
+	 * requesting page alignment, this means no other BARs will share
+	 * the page.
+	 *
+	 * This makes the resource larger than the hardware BAR, which may
+	 * break drivers that compute things based on the resource size,
+	 * e.g., to find registers at a fixed offset before the end of the
+	 * BAR.  We hope users don't request alignment for such devices.
+	 */
+	dev_info(&dev->dev, "BAR%d %pR: requesting alignment to %#llx\n",
+		 bar, r, (unsigned long long)align);
 
-	}
-	r->flags |= IORESOURCE_UNSET;
-	r->end = size - 1;
 	r->start = 0;
+	r->end = align - 1;
+	r->flags |= IORESOURCE_UNSET;
 }
 
 /*
