Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A276C1A0FFD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 19:35:58 +1100 (AEDT)
Message-ID: <1424421344.27448.43.camel@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/dma: Remove ZONE_DMA completely
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 20 Feb 2015 19:35:44 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Anton Blanchard <anton@au1.ibm.com>,
 Brian J King <bjking1@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't initialize it, we don't use it, remove it.

We can bring it back if we ever wish to have support for devices
who have smaller than 32-bit DMA limitations but I don't think
we care much anymore.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig      |    2 +-
 arch/powerpc/kernel/dma.c |   10 +---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 22b0940..4efbfba 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -712,7 +712,7 @@ config ISA
 
 config ZONE_DMA
 	bool
-	default y
+	default n
 
 config NEED_DMA_MAP_STATE
 	def_bool (PPC64 || NOT_COHERENT_CACHE)
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index e24e0ae..6306d4e 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -63,16 +63,8 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	}
 
-	switch (zone) {
-	case ZONE_DMA:
-		flag |= GFP_DMA;
-		break;
-#ifdef CONFIG_ZONE_DMA32
-	case ZONE_DMA32:
+	if (zone == ZONE_DMA32)
 		flag |= GFP_DMA32;
-		break;
-#endif
-	};
 
 	/* ignore region specifiers */
 	flag  &= ~(__GFP_HIGHMEM);
