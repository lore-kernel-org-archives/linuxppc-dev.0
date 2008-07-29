Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 02C73DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jul 2008 10:52:20 +1000 (EST)
Date: Tue, 29 Jul 2008 10:52:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: linux-next: pci-current tree build failure
Message-Id: <20080729105213.0ac2acbd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, Ingo, Joerg Roedel <joerg.roedel@amd.com>,
	linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jesse,

Today's linux-next build (powerpc ppc64_defconfig) failed like this:

arch/powerpc/kernel/iommu.c:54: error: static declaration of 'iommu_num_pages' follows non-static declaration
include/linux/iommu-helper.h:11: error: previous declaration of 'iommu_num_pages' was here

Caused by commit 3bc9f79ee1ddc913be0a6d3592036683ef8a3148 ("iommu: add
iommu_num_pages helper function") which introduced a global version of a
function that powerpc has a different version of.  I am not sure that the
two do the same thing - in fact they don't since powerpc can have a 64k
page size and still need to use a 4k iommu pages.  I applied the
patch below (which I personally hate :-))

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

>From ade341416a628800ad2a27ecd576238087290125 Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 29 Jul 2008 10:47:59 +1000
Subject: [PATCH] powerpc: generic iommu helper fallout

Powerpc needs it own version of iommu_num_pages() since the iommu pages
may be a different size to the system pages.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/iommu.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 550a193..b147055 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -51,7 +51,7 @@ static int protect4gb = 1;
 
 static void __iommu_free(struct iommu_table *, dma_addr_t, unsigned int);
 
-static inline unsigned long iommu_num_pages(unsigned long vaddr,
+static inline unsigned long ppc_iommu_num_pages(unsigned long vaddr,
 					    unsigned long slen)
 {
 	unsigned long npages;
@@ -325,7 +325,7 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		}
 		/* Allocate iommu entries for that segment */
 		vaddr = (unsigned long) sg_virt(s);
-		npages = iommu_num_pages(vaddr, slen);
+		npages = ppc_iommu_num_pages(vaddr, slen);
 		align = 0;
 		if (IOMMU_PAGE_SHIFT < PAGE_SHIFT && slen >= PAGE_SIZE &&
 		    (vaddr & ~PAGE_MASK) == 0)
@@ -418,7 +418,7 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 			unsigned long vaddr, npages;
 
 			vaddr = s->dma_address & IOMMU_PAGE_MASK;
-			npages = iommu_num_pages(s->dma_address, s->dma_length);
+			npages = ppc_iommu_num_pages(s->dma_address, s->dma_length);
 			__iommu_free(tbl, vaddr, npages);
 			s->dma_address = DMA_ERROR_CODE;
 			s->dma_length = 0;
@@ -452,7 +452,7 @@ void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
 
 		if (sg->dma_length == 0)
 			break;
-		npages = iommu_num_pages(dma_handle, sg->dma_length);
+		npages = ppc_iommu_num_pages(dma_handle, sg->dma_length);
 		__iommu_free(tbl, dma_handle, npages);
 		sg = sg_next(sg);
 	}
@@ -584,7 +584,7 @@ dma_addr_t iommu_map_single(struct device *dev, struct iommu_table *tbl,
 	BUG_ON(direction == DMA_NONE);
 
 	uaddr = (unsigned long)vaddr;
-	npages = iommu_num_pages(uaddr, size);
+	npages = ppc_iommu_num_pages(uaddr, size);
 
 	if (tbl) {
 		align = 0;
@@ -617,7 +617,7 @@ void iommu_unmap_single(struct iommu_table *tbl, dma_addr_t dma_handle,
 	BUG_ON(direction == DMA_NONE);
 
 	if (tbl) {
-		npages = iommu_num_pages(dma_handle, size);
+		npages = ppc_iommu_num_pages(dma_handle, size);
 		iommu_free(tbl, dma_handle, npages);
 	}
 }
-- 
1.5.6.3
