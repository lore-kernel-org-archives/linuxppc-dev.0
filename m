Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D9121A0E91
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 19:35:44 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6238614016A
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2015 19:35:42 +1100 (AEDT)
Message-ID: <1424421325.27448.41.camel@kernel.crashing.org>
Subject: [PATCH 1/3] powerpc/dma: Always configure ZONE_DMA32 correctly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Fri, 20 Feb 2015 19:35:25 +1100
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

We do this for consistency and also in order to support the use of a
consistent mask smaller than the dma mask in subsequent patches.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/dma-swiotlb.c | 3 ---
 arch/powerpc/mm/mem.c             | 6 ++++++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 7359797..cb92f94 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -110,9 +110,6 @@ void __init swiotlb_detect_4g(void)
 {
 	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
 		ppc_swiotlb_enable = 1;
-#ifdef CONFIG_ZONE_DMA32
-		limit_zone_pfn(ZONE_DMA32, (1ULL << 32) >> PAGE_SHIFT);
-#endif
 	}
 }
 
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index b7285a5..f146ef0 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -307,6 +307,12 @@ void __init paging_init(void)
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (long int)((top_of_ram - total_ram) >> 20));
 
+#ifdef CONFIG_ZONE_DMA32
+	/* Default limit for ZONE_DMA32, platform might limit it
+	 * further due to PCI bridge addressing limitations
+	 */
+	limit_zone_pfn(ZONE_DMA32, (1ULL << 32) >> PAGE_SHIFT);
+#endif
 #ifdef CONFIG_HIGHMEM
 	top_zone = ZONE_HIGHMEM;
 	limit_zone_pfn(ZONE_NORMAL, lowmem_end_addr >> PAGE_SHIFT);
