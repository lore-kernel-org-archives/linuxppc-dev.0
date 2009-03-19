Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D4F69DDDA5
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 00:41:05 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Subject: [PATCH v2 3/3] powerpc: expect all devices calling dma ops to have
	archdata set
Date: Thu, 19 Mar 2009 08:40:52 -0500
Message-Id: <1237470052-4071-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1237470052-4071-2-git-send-email-galak@kernel.crashing.org>
References: <1237470052-4071-1-git-send-email-galak@kernel.crashing.org>
	<1237470052-4071-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Becky Bruce <becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that we set archdata for of_platform and platform devices via
platform_notify() we no longer need to special case having a NULL device
pointer or NULL archdata.  It should be a driver error if this condition
shows up and the driver should be fixed.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/dma-mapping.h |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 86cef7d..c69f2b5 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -109,18 +109,8 @@ static inline struct dma_mapping_ops *get_dma_ops(struct device *dev)
 	 * only ISA DMA device we support is the floppy and we have a hack
 	 * in the floppy driver directly to get a device for us.
 	 */
-
-	if (unlikely(dev == NULL) || dev->archdata.dma_ops == NULL) {
-#ifdef CONFIG_PPC64
+	if (unlikely(dev == NULL))
 		return NULL;
-#else
-		/* Use default on 32-bit if dma_ops is not set up */
-		/* TODO: Long term, we should fix drivers so that dev and
-		 * archdata dma_ops are set up for all buses.
-		 */
-		return &dma_direct_ops;
-#endif
-	}
 
 	return dev->archdata.dma_ops;
 }
-- 
1.5.6.6
