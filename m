Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6M6C1mKZzDqJ2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 07:36:51 +1000 (AEST)
Subject: [PATCH v11 3/7] PCI: Add pcibios_default_alignment() for
 arch-specific alignment control
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yongji Xie <elohimes@gmail.com>
Cc: zhong@linux.vnet.ibm.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Date: Mon, 17 Apr 2017 16:36:46 -0500
Message-ID: <20170417213646.21092.24262.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

When VFIO passes through a PCI device to a guest, it does not allow
the guest to mmap BARs that are smaller than PAGE_SIZE unless it
can reserve the rest of the page (see vfio_pci_probe_mmaps()). This
is because a page might contain several small BARs for unrelated
devices and a guest should not be able to access all of them.

VFIO emulates guest accesses to non-mappable BARs, which is functional
but slow. On systems with large page sizes, e.g., PowerNV with 64K pages,
BARs are more likely to share a page and performance is more likely to
be a problem.

Add a weak function to set default alignment for all PCI devices.
An arch can override it to force the PCI core to place memory BARs on
their own pages.

Signed-off-by: Yongji Xie <elohimes@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 679af2a253ad..a2d1f144c94f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4947,6 +4947,11 @@ void pci_ignore_hotplug(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_ignore_hotplug);
 
+resource_size_t __weak pcibios_default_alignment(struct pci_dev *dev)
+{
+	return 0;
+}
+
 #define RESOURCE_ALIGNMENT_PARAM_SIZE COMMAND_LINE_SIZE
 static char resource_alignment_param[RESOURCE_ALIGNMENT_PARAM_SIZE] = {0};
 static DEFINE_SPINLOCK(resource_alignment_lock);
@@ -4962,14 +4967,15 @@ static resource_size_t pci_specified_resource_alignment(struct pci_dev *dev)
 {
 	int seg, bus, slot, func, align_order, count;
 	unsigned short vendor, device, subsystem_vendor, subsystem_device;
-	resource_size_t align = 0;
+	resource_size_t align = pcibios_default_alignment(dev);
 	char *p;
 
 	spin_lock(&resource_alignment_lock);
 	p = resource_alignment_param;
-	if (!*p)
+	if (!*p && !align)
 		goto out;
 	if (pci_has_flag(PCI_PROBE_ONLY)) {
+		align = 0;
 		pr_info_once("PCI: Ignoring requested alignments (PCI_PROBE_ONLY)\n");
 		goto out;
 	}
