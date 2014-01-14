Return-Path: <Chunhe.Lan@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 119482C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 20:44:56 +1100 (EST)
From: Chunhe Lan <Chunhe.Lan@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: dma-mapping: Return dma_direct_ops variable when dev
 == NULL
Date: Tue, 14 Jan 2014 17:44:16 +0800
Message-ID: <1389692656-27758-1-git-send-email-Chunhe.Lan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Without this patch, kind of below error will be dumped if
'insmod ixgbevf.ko' is executed:

    ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function
             Network Driver - version 2.7.12-k
    ixgbevf: Copyright (c) 2009 - 2012 Intel Corporation.
    ixgbevf 0000:01:10.0: enabling device (0000 -> 0002)
    ixgbevf 0000:01:10.0: No usable DMA configuration, aborting
    ixgbevf: probe of 0000:01:10.0 failed with error -5
    ......
    ......

Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Tested-by: Chunhe Lan <Chunhe.Lan@freescale.com>
---
 arch/powerpc/include/asm/dma-mapping.h |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index e27e9ad..b8c10de 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -84,10 +84,15 @@ static inline struct dma_map_ops *get_dma_ops(struct device *dev)
 	 * only ISA DMA device we support is the floppy and we have a hack
 	 * in the floppy driver directly to get a device for us.
 	 */
-	if (unlikely(dev == NULL))
-		return NULL;
-
-	return dev->archdata.dma_ops;
+	if (dev && dev->archdata.dma_ops)
+		return dev->archdata.dma_ops;
+	/*
+	 * In some cases (for example, use the Intel(R) 10 Gigabit PCI
+	 * expression Virtual Function Network Driver -- ixgbevf.ko),
+	 * their value of dev is the NULL. If return NULL, the driver is
+	 * aborting. So return dma_direct_ops variable when dev == NULL.
+	 */
+	return &dma_direct_ops;
 }
 
 static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
-- 
1.7.6.5
