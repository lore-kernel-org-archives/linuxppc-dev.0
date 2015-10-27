Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0ADF1A0468
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 11:19:05 +1100 (AEDT)
Message-ID: <1445905135.1856.12.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/dma: Basic DMA operations shouldn't be GPL only
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <michaele@au1.ibm.com>
Date: Tue, 27 Oct 2015 09:18:55 +0900
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When turning these from inline to exported functions I was a bit
over-eager and made them GPL only. This basically prevent use of
any non-GPL PCI driver which is a bit over the top. Bring them
in line with other architecture.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 59503ed..18ea012 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -303,7 +303,7 @@ int dma_set_coherent_mask(struct device *dev, u64 mask)
 	dev->coherent_dma_mask = mask;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(dma_set_coherent_mask);
+EXPORT_SYMBOL(dma_set_coherent_mask);
 
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 
@@ -362,7 +362,7 @@ u64 dma_get_required_mask(struct device *dev)
 
 	return __dma_get_required_mask(dev);
 }
-EXPORT_SYMBOL_GPL(dma_get_required_mask);
+EXPORT_SYMBOL(dma_get_required_mask);
 
 static int __init dma_init(void)
 {
