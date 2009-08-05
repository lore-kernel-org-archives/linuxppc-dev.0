Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0D07CB7079
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 15:10:12 +1000 (EST)
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH -v2 6/7] powerpc: handle SWIOTLB mapping error properly
Date: Wed,  5 Aug 2009 14:08:27 +0900
Message-Id: <1249448908-18985-7-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, mingo@elte.hu, linux-kernel@vger.kernel.org,
	galak@kernel.crashing.orga
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/powerpc/include/asm/dma-mapping.h |    5 +++++
 arch/powerpc/kernel/dma-swiotlb.c      |    3 ++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 91217e4..4bd41b4 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -143,6 +143,11 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
+	struct dma_map_ops *dma_ops = get_dma_ops(dev);
+
+	if (dma_ops->mapping_error)
+		return dma_ops->mapping_error(dev, dma_addr);
+
 #ifdef CONFIG_PPC64
 	return (dma_addr == DMA_ERROR_CODE);
 #else
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index d1143a6..e96cbbd 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -42,7 +42,8 @@ struct dma_map_ops swiotlb_dma_ops = {
 	.sync_single_range_for_cpu = swiotlb_sync_single_range_for_cpu,
 	.sync_single_range_for_device = swiotlb_sync_single_range_for_device,
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
-	.sync_sg_for_device = swiotlb_sync_sg_for_device
+	.sync_sg_for_device = swiotlb_sync_sg_for_device,
+	.mapping_error = swiotlb_dma_mapping_error,
 };
 
 void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev)
-- 
1.6.0.6
