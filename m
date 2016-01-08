Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A7701A0202
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jan 2016 11:40:14 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@ozlabs.org, gwshan@linux.vnet.ibm.com, ruscur@russell.cc,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] platforms/powernv: Fix update of NVLink DMA mask
Date: Fri,  8 Jan 2016 11:35:09 +1100
Message-Id: <1452213309-27592-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The emulated NVLink PCI devices share the same IODA2 TCE tables but
only support a single TVT (instead of the normal two for PCI
devices). This requires the kernel to manually replace windows with
either the bypass or non-bypass window depending on what the driver
has requested.

Unfortunately an incorrect optimisation was made in
pnv_pci_ioda_dma_set_mask() which caused updating of some NPU device
PEs to be skipped in certain configurations due to an incorrect
assumption that a NULL peer PE in the array indicated there were no
more peers present. This patch fixes the problem by ensuring all peer
PEs are updated.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 323e1e5..458133f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1612,7 +1612,10 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 
 	/* Update peer npu devices */
 	if (pe->flags & PNV_IODA_PE_PEER)
-		for (i = 0; pe->peers[i]; i++) {
+		for (i = 0; i < PNV_IODA_MAX_PEER_PES; i++) {
+			if (!pe->peers[i])
+				continue;
+
 			linked_npu_dev = pe->peers[i]->pdev;
 			if (dma_get_mask(&linked_npu_dev->dev) != dma_mask)
 				dma_set_mask(&linked_npu_dev->dev, dma_mask);
-- 
2.1.4
