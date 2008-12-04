Return-Path: <bgill@blarg.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1B575DDDED
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 05:13:00 +1100 (EST)
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix !CONFIG_PPC_NEED_DMA_SYNC_OPS build warning
Date: Thu,  4 Dec 2008 12:12:40 -0600
Message-Id: <1228414360-9699-1-git-send-email-beckyb@kernel.crashing.org>
Cc: sfr@canb.auug.org.au, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change #define stubs of dma_sync ops to be empty static inlines
to avoid build warning.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/dma-mapping.h |   41 +++++++++++++++++++++++++++----
 1 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 9063184..86cef7d 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -363,12 +363,41 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 					      size, direction);
 }
 #else /* CONFIG_PPC_NEED_DMA_SYNC_OPS */
-#define dma_sync_single_for_cpu(d, h, s, dir) ((void)0)
-#define dma_sync_single_for_device(d, h, s, dir) ((void)0)
-#define dma_sync_single_range_for_cpu(d, h, o, s, dir) ((void)0)
-#define dma_sync_single_range_for_device(d, h, o, s, dir) ((void)0)
-#define dma_sync_sg_for_cpu(d, s, n, dir) ((void)0)
-#define dma_sync_sg_for_device(d, s, n, dir) ((void)0)
+static inline void dma_sync_single_for_cpu(struct device *dev,
+		dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction)
+{
+}
+
+static inline void dma_sync_single_for_device(struct device *dev,
+		dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction)
+{
+}
+
+static inline void dma_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents,
+		enum dma_data_direction direction)
+{
+}
+
+static inline void dma_sync_sg_for_device(struct device *dev,
+		struct scatterlist *sgl, int nents,
+		enum dma_data_direction direction)
+{
+}
+
+static inline void dma_sync_single_range_for_cpu(struct device *dev,
+		dma_addr_t dma_handle, unsigned long offset, size_t size,
+		enum dma_data_direction direction)
+{
+}
+
+static inline void dma_sync_single_range_for_device(struct device *dev,
+		dma_addr_t dma_handle, unsigned long offset, size_t size,
+		enum dma_data_direction direction)
+{
+}
 #endif
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-- 
1.5.6.5
