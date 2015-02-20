Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9FAE31A0E91
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 19:35:44 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E1EB714018C
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2015 19:35:43 +1100 (AEDT)
Message-ID: <1424421330.27448.42.camel@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/dma: Support 32-bit coherent mask with 64-bit
 dma_mask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Fri, 20 Feb 2015 19:35:30 +1100
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

Some drivers try to use a 64-bit dma_mask and a smaller (32-bit typically)
coherent dma mask.

We don't currently support that on platforms that do direct DMA
because:

 - We use the generic dma_set_coherent_mask()

 - It will use dma_supported() with the provided mask

 - Our imlpementation of the latter in
   dma_set_our dma_direct_dma_supported() will fail if the mask
   passed isn't big enough to cover all of memory (+ DMA offset)

This fixes it by making dma_direct_dma_supported() use the ZONE_DMA32
limit when it's enabled, and removing the ifdef CONFIG_FSL_SOC around
the code in dma_direct_alloc_coherent() that supports allocating
from the 32-bit zone. (Nowadays, most drivers have been fixed).

This carries an additional change which is to generalize the test
against memblock_end_of_DRAM() + "dma_offset" to 32-bit platforms,
instead of just unconditionally returning 1 for these. This should
work since the rest of the code in the direct DMA ops assume this
is true anyway.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/pgtable.h |    1 +
 arch/powerpc/kernel/dma.c          |   21 ++++++---------------
 arch/powerpc/mm/mem.c              |    5 +++++
 3 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 9835ac4..a3680b8 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -217,6 +217,7 @@ extern pgd_t swapper_pg_dir[];
 
 void limit_zone_pfn(enum zone_type zone, unsigned long max_pfn);
 int dma_pfn_limit_to_zone(u64 pfn_limit);
+u64 dma_get_zone_limit(int zone);
 extern void paging_init(void);
 
 /*
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 484b2d4..e24e0ae 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -53,16 +53,9 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 #else
 	struct page *page;
 	int node = dev_to_node(dev);
-#ifdef CONFIG_FSL_SOC
 	u64 pfn = get_pfn_limit(dev);
 	int zone;
 
-	/*
-	 * This code should be OK on other platforms, but we have drivers that
-	 * don't set coherent_dma_mask. As a workaround we just ifdef it. This
-	 * whole routine needs some serious cleanup.
-	 */
-
 	zone = dma_pfn_limit_to_zone(pfn);
 	if (zone < 0) {
 		dev_err(dev, "%s: No suitable zone for pfn %#llx\n",
@@ -80,7 +73,6 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 		break;
 #endif
 	};
-#endif /* CONFIG_FSL_SOC */
 
 	/* ignore region specifiers */
 	flag  &= ~(__GFP_HIGHMEM);
@@ -149,14 +141,13 @@ static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
 
 static int dma_direct_dma_supported(struct device *dev, u64 mask)
 {
-#ifdef CONFIG_PPC64
-	/* Could be improved so platforms can set the limit in case
-	 * they have limited DMA windows
-	 */
-	return mask >= get_dma_offset(dev) + (memblock_end_of_DRAM() - 1);
-#else
-	return 1;
+	u64 offset = get_dma_offset(dev);
+	u64 limit = offset + memblock_end_of_DRAM() - 1;
+
+#if defined(CONFIG_ZONE_DMA32)
+	limit = offset + dma_get_zone_limit(ZONE_DMA32);
 #endif
+	return mask >= limit;
 }
 
 static u64 dma_direct_get_required_mask(struct device *dev)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index f146ef0..a7f15e2 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -277,6 +277,11 @@ int dma_pfn_limit_to_zone(u64 pfn_limit)
 	return -EPERM;
 }
 
+u64 dma_get_zone_limit(int zone)
+{
+	return max_zone_pfns[zone] << PAGE_SHIFT;
+}
+
 /*
  * paging_init() sets up the page tables - in fact we've already done this.
  */
