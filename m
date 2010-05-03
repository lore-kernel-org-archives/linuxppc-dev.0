Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B14BAB7C48
	for <linuxppc-dev@ozlabs.org>; Mon,  3 May 2010 22:43:08 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o43Ch5Yr028932
	for <linuxppc-dev@ozlabs.org>; Mon, 3 May 2010 07:43:05 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/swiotlb: Fix off by one in determining boundary of
	which ops to use
Date: Mon,  3 May 2010 07:43:04 -0500
Message-Id: <1272890584-28631-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we compare the devices DMA mask to the amount of memory we need to
make sure we treat the DMA mask as an address boundary.  For example if
the DMA_MASK(32) and we have 4G of memory we'd incorrectly set the dma
ops to swiotlb.  We need to add one to the dma mask when we convert it.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/dma-swiotlb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 59c9285..f9ee4b0 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -70,7 +70,7 @@ static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
 	sd->max_direct_dma_addr = 0;
 
 	/* May need to bounce if the device can't address all of DRAM */
-	if (dma_get_mask(dev) < lmb_end_of_DRAM())
+	if ((dma_get_mask(dev) + 1) < lmb_end_of_DRAM())
 		set_dma_ops(dev, &swiotlb_dma_ops);
 
 	return NOTIFY_DONE;
-- 
1.6.0.6
