Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnYzX5fqlzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Jun 2017 14:48:08 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org,
	Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powernv/npu-dma.c: Remove spurious WARN_ON when a PCI device
 has no of_node
Date: Wed, 14 Jun 2017 14:47:50 +1000
Message-Id: <1497415670-723-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"4c3b89e powerpc/powernv: Add sanity checks to pnv_pci_get_{gpu|npu}_dev"
introduced explicit warnings in pnv_pci_get_npu_dev() when a PCIe device
has no associated device-tree node. However not all PCIe devices have an
of_node and pnv_pci_get_npu_dev() gets indirectly called at least once for
every PCIe device in the system. This results in spurious WARN_ON()'s so
remove it.

The same situation should not exist for pnv_pci_get_gpu_dev() as any NPU
based PCIe device requires a device-tree node.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/npu-dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 78fa939..e6f444b 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -75,7 +75,8 @@ struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index)
 	if (WARN_ON(!gpdev))
 		return NULL;
 
-	if (WARN_ON(!gpdev->dev.of_node))
+	/* Not all PCI devices have device-tree nodes */
+	if (!gpdev->dev.of_node)
 		return NULL;
 
 	/* Get assoicated PCI device */
-- 
2.1.4
