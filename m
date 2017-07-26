Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHNrl13K4zDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 15:26:47 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: ruscur@russell.cc,
	benh@kernel.crashing.org,
	linuxppc-dev
Cc: mpe@ellerman.id.au,
	Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/powernv/pci: Return failure for some uses of
 dma_set_mask()
Date: Wed, 26 Jul 2017 15:26:40 +1000
Message-Id: <1501046800-6690-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 8e3f1b1d8255 ("powerpc/powernv/pci: Enable 64-bit devices to access
>4GB DMA space") introduced the ability for PCI device drivers to request a
DMA mask between 64 and 32 bits and actually get a mask greater than
32-bits. However currently if certain machine configuration dependent
conditions are not meet the code silently falls back to a 32-bit mask.

This makes it hard for device drivers to detect which mask they actually
got. Instead we should return an error when the request could not be
fulfilled which allows drivers to either fallback or implement other
workarounds as documented in DMA-API-HOWTO.txt.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---

Ideally we should do the same thing for 64-bit mode as well however there
are a lot more drivers requesting a dma mask of 64-bits so it's a much
larger task to audit them all to see if they behave correctly when
dma_set_mask() fails. Such an audit may be required as previously these
calls would not have failed on PPC64 (although may have on other
architectures).

A quick bit of grepping didn't turn up many drivers requesting 33-63 bit
dma masks. Most of the ones that do are specific to other HW, although
there were a couple of more generic drivers requesting eg. 48 bits. However
those tested the return values of dma_set_mask() and took appropriate
action (falling back to 32 bits) in the case of failure.

- Alistair

arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 4376135..b900eb1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1852,6 +1852,14 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 			/* 4GB offset bypasses 32-bit space */
 			set_dma_offset(&pdev->dev, (1ULL << 32));
 			set_dma_ops(&pdev->dev, &dma_direct_ops);
+		} else if (dma_mask >> 32 && dma_mask != DMA_BIT_MASK(64)) {
+			/*
+			 * Fail the request if a DMA mask between 32 and 64 bits
+			 * was requested but couldn't be fulfilled. Ideally we
+			 * would do this for 64-bits but historically we have
+			 * always fallen back to 32-bits.
+			 */
+			return -ENOMEM;
 		} else {
 			dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
 			set_dma_ops(&pdev->dev, &dma_iommu_ops);
-- 
2.1.4
