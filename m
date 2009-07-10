Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A99DFB7169
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jul 2009 11:20:52 +1000 (EST)
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5948BDDDD4
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Jul 2009 11:20:52 +1000 (EST)
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] swiotlb: use phys_to_dma and dma_to_phys
Date: Fri, 10 Jul 2009 10:05:02 +0900
Message-Id: <1247187904-31999-14-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1247187904-31999-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1247187904-31999-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org, x86@kernel.org,
	fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This converts swiotlb to use phys_to_dma and dma_to_phys instead of
swiotlb_phys_to_bus() and swiotlb_bus_to_phys().

swiotlb_phys_to_bus() and swiotlb_bus_to_phys() are not necessary so
this patch also removes them.

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 include/linux/swiotlb.h |    5 -----
 lib/swiotlb.c           |   22 ++++++----------------
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index a977da2..73b1f1c 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -23,11 +23,6 @@ struct scatterlist;
 extern void
 swiotlb_init(void);
 
-extern dma_addr_t swiotlb_phys_to_bus(struct device *hwdev,
-				      phys_addr_t address);
-extern phys_addr_t swiotlb_bus_to_phys(struct device *hwdev,
-				       dma_addr_t address);
-
 extern void
 *swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			dma_addr_t *dma_handle, gfp_t flags);
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index a0faeb0..de71dba 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -114,20 +114,10 @@ setup_io_tlb_npages(char *str)
 __setup("swiotlb=", setup_io_tlb_npages);
 /* make io_tlb_overflow tunable too? */
 
-dma_addr_t __weak swiotlb_phys_to_bus(struct device *hwdev, phys_addr_t paddr)
-{
-	return paddr;
-}
-
-phys_addr_t __weak swiotlb_bus_to_phys(struct device *hwdev, dma_addr_t baddr)
-{
-	return baddr;
-}
-
 static dma_addr_t swiotlb_virt_to_bus(struct device *hwdev,
 				      volatile void *address)
 {
-	return swiotlb_phys_to_bus(hwdev, virt_to_phys(address));
+	return phys_to_dma(hwdev, virt_to_phys(address));
 }
 
 static void swiotlb_print_info(unsigned long bytes)
@@ -566,7 +556,7 @@ void
 swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 		      dma_addr_t dev_addr)
 {
-	phys_addr_t paddr = swiotlb_bus_to_phys(hwdev, dev_addr);
+	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
 
 	WARN_ON(irqs_disabled());
 	if (!is_swiotlb_buffer(paddr))
@@ -611,7 +601,7 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 			    struct dma_attrs *attrs)
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
-	dma_addr_t dev_addr = swiotlb_phys_to_bus(dev, phys);
+	dma_addr_t dev_addr = phys_to_dma(dev, phys);
 	void *map;
 
 	BUG_ON(dir == DMA_NONE);
@@ -655,7 +645,7 @@ EXPORT_SYMBOL_GPL(swiotlb_map_page);
 static void unmap_single(struct device *hwdev, dma_addr_t dev_addr,
 			 size_t size, int dir)
 {
-	phys_addr_t paddr = swiotlb_bus_to_phys(hwdev, dev_addr);
+	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
 
 	BUG_ON(dir == DMA_NONE);
 
@@ -692,7 +682,7 @@ static void
 swiotlb_sync_single(struct device *hwdev, dma_addr_t dev_addr,
 		    size_t size, int dir, int target)
 {
-	phys_addr_t paddr = swiotlb_bus_to_phys(hwdev, dev_addr);
+	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
 
 	BUG_ON(dir == DMA_NONE);
 
@@ -781,7 +771,7 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
 
 	for_each_sg(sgl, sg, nelems, i) {
 		phys_addr_t paddr = sg_phys(sg);
-		dma_addr_t dev_addr = swiotlb_phys_to_bus(hwdev, paddr);
+		dma_addr_t dev_addr = phys_to_dma(hwdev, paddr);
 
 		if (swiotlb_force ||
 		    !dma_capable(hwdev, dev_addr, sg->length)) {
-- 
1.6.0.6
