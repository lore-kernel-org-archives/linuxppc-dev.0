Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWWd23DwLzDqDC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 06:12:22 +1000 (AEST)
Subject: [PATCH v1 4/4] sparc/PCI: Implement pci_resource_to_user() with
 pcibios_resource_to_bus()
To: Michal Simek <monstr@monstr.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Ralf Baechle <ralf@linux-mips.org>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Yinghai Lu <yinghai@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Cc: sparclinux@vger.kernel.org, linux-mips@linux-mips.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Date: Fri, 17 Jun 2016 15:12:18 -0500
Message-ID: <20160617201218.11714.38929.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20160617195835.11714.18657.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20160617195835.11714.18657.stgit@bhelgaas-glaptop2.roam.corp.google.com>
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

"User" addresses are shown in /sys/devices/pci.../.../resource and
/proc/bus/pci/devices and used as mmap offsets for /proc/bus/pci/BB/DD.F
files.  On sparc, these are PCI bus addresses, i.e., raw BAR values.

Previously pci_resource_to_user() computed the user address by
subtracting either pbm->io_space.start or pbm->mem_space.start from the
resource start.

We've already told the PCI core about those offsets here:

  pci_scan_one_pbm()
    pci_add_resource_offset(&resources, &pbm->io_space, pbm->io_space.start);
    pci_add_resource_offset(&resources, &pbm->mem_space, pbm->mem_space.start);
    pci_add_resource_offset(&resources, &pbm->mem64_space, pbm->mem_space.start);

so pcibios_resource_to_bus() knows how to do that translation.

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Yinghai Lu <yinghai@kernel.org>
---
 arch/sparc/kernel/pci.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index c2b202d..9c1878f 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -986,16 +986,18 @@ void pci_resource_to_user(const struct pci_dev *pdev, int bar,
 			  const struct resource *rp, resource_size_t *start,
 			  resource_size_t *end)
 {
-	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
-	unsigned long offset;
-
-	if (rp->flags & IORESOURCE_IO)
-		offset = pbm->io_space.start;
-	else
-		offset = pbm->mem_space.start;
+	struct pci_bus_region region;
 
-	*start = rp->start - offset;
-	*end = rp->end - offset;
+	/*
+	 * "User" addresses are shown in /sys/devices/pci.../.../resource
+	 * and /proc/bus/pci/devices and used as mmap offsets for
+	 * /proc/bus/pci/BB/DD.F files (see proc_bus_pci_mmap()).
+	 *
+	 * On sparc, these are PCI bus addresses, i.e., raw BAR values.
+	 */
+	pcibios_resource_to_bus(pdev->bus, &region, (struct resource *) rp);
+	*start = region.start;
+	*end = region.end;
 }
 
 void pcibios_set_master(struct pci_dev *dev)
