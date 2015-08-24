Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3A4C1A1D92
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2015 22:43:08 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: linux-pci@vger.kernel.org, gpiccoli@linux.vnet.ibm.com,
 bhelgaas@google.com, mst@redhat.com
Subject: [PATCH 2/2] powerpc/PCI: Disable MSI/MSI-X interrupts at PCI probe
 time in OF case
Date: Mon, 24 Aug 2015 22:42:47 +1000
Message-Id: <1440420167-8879-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1440420167-8879-1-git-send-email-mpe@ellerman.id.au>
References: <1440420167-8879-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>

Since commit 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if
kernel doesn't support MSI"), the setup of dev->msi_cap/msix_cap and the
disable of MSI/MSI-X interrupts isn't being done at PCI probe time, as
the logic responsible for this was moved in the aforementioned commit
from pci_device_add() to pci_setup_device(). The latter function is not
reachable on PowerPC pseries platform during Open Firmware PCI probing
time.

This exhibits as drivers not being able to enable MSI, eg:

  bnx2x 0000:01:00.0: no msix capability found

This patch calls pci_msi_setup_pci_dev() explicitly to disable MSI/MSI-X
during PCI probe time on pSeries platform.

Fixes: 1851617cd2da ("PCI/MSI: Disable MSI at enumeration even if kernel doesn't support MSI")
[mpe: Flesh out change log and clarify comment]
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/pci_of_scan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index 42e02a2d570b..efc3fa54c90b 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -191,6 +191,9 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 
 	pci_device_add(dev, bus);
 
+	/* Setup MSI caps & disable MSI/MSI-X interrupts */
+	pci_msi_setup_pci_dev(dev);
+
 	return dev;
 }
 EXPORT_SYMBOL(of_create_pci_dev);
-- 
2.1.4
