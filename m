Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0EBE2B831A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jan 2010 14:10:32 +1100 (EST)
Subject: [PATCH 3/3] powerpc/pci: Add missing call to header fixup
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 27 Jan 2010 14:10:05 +1100
Message-ID: <1264561805.3601.165.camel@pasglop>
Mime-Version: 1.0
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	Breno Leitao <leitao@linux.vnet.ibm.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add missing call to  pci_fixup_device(pci_fixup_early, ...) when
building the pci_dev from scratch off the Open Firmware device-tree

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/pci_of_scan.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
index b6b2e86..4aa1740 100644
--- a/arch/powerpc/kernel/pci_of_scan.c
+++ b/arch/powerpc/kernel/pci_of_scan.c
@@ -166,6 +166,9 @@ struct pci_dev *of_create_pci_dev(struct device_node *node,
 	dev->error_state = pci_channel_io_normal;
 	dev->dma_mask = 0xffffffff;
 
+	/* Early fixups, before probing the BARs */
+	pci_fixup_device(pci_fixup_early, dev);
+
 	if (!strcmp(type, "pci") || !strcmp(type, "pciex")) {
 		/* a PCI-PCI bridge */
 		dev->hdr_type = PCI_HEADER_TYPE_BRIDGE;
