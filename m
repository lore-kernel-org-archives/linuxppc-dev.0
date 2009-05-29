Return-Path: <Ian.Campbell@eu.citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
	by ozlabs.org (Postfix) with ESMTP id 06E0CDDFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 18:44:14 +1000 (EST)
From: Ian Campbell <ian.campbell@citrix.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/9] swiotlb: use dma_to_phys and phys_to_dma
Date: Fri, 29 May 2009 09:44:00 +0100
Message-ID: <1243586643-5554-7-git-send-email-ian.campbell@citrix.com>
In-Reply-To: <1243586643-5554-1-git-send-email-ian.campbell@citrix.com>
References: <1243586643-5554-1-git-send-email-ian.campbell@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Benjamin, x86@kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>,
	Tony Luck <tony.luck@intel.com>, Olaf,
	Ian Campbell <ian.campbell@citrix.com>, Kirch <okir@suse.de>,
	Greg KH <gregkh@suse.de>, FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	linuxppc-dev@ozlabs.org, linux-ia64@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These new architecture-specific interfaces subsume the existing __weak
function hooks.

Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
Cc: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Olaf Kirch <okir@suse.de>
Cc: Greg KH <gregkh@suse.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Becky Bruce <beckyb@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: x86@kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org
---
 include/linux/swiotlb.h |    5 -----
 lib/swiotlb.c           |   18 ++++--------------
 2 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index cb1a663..954feec 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -27,11 +27,6 @@ swiotlb_init(void);
 extern void *swiotlb_alloc_boot(size_t bytes, unsigned long nslabs);
 extern void *swiotlb_alloc(unsigned order, unsigned long nslabs);
 
-extern dma_addr_t swiotlb_phys_to_bus(struct device *hwdev,
-				      phys_addr_t address);
-extern phys_addr_t swiotlb_bus_to_phys(struct device *hwdev,
-				       dma_addr_t address);
-
 extern int swiotlb_arch_range_needs_mapping(phys_addr_t paddr, size_t size);
 
 extern void
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index bffe6d7..baa1991 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -124,25 +124,15 @@ void * __weak swiotlb_alloc(unsigned order, unsigned long nslabs)
 	return (void *)__get_free_pages(GFP_DMA | __GFP_NOWARN, order);
 }
 
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
 
 void * __weak swiotlb_bus_to_virt(struct device *hwdev, dma_addr_t address)
 {
-	return phys_to_virt(swiotlb_bus_to_phys(hwdev, address));
+	return phys_to_virt(dma_to_phys(hwdev, address));
 }
 
 int __weak swiotlb_arch_address_needs_mapping(struct device *hwdev,
@@ -646,7 +636,7 @@ dma_addr_t swiotlb_map_page(struct device *dev, struct page *page,
 			    struct dma_attrs *attrs)
 {
 	phys_addr_t phys = page_to_phys(page) + offset;
-	dma_addr_t dev_addr = swiotlb_phys_to_bus(dev, phys);
+	dma_addr_t dev_addr = phys_to_dma(dev, phys);
 	void *map;
 
 	BUG_ON(dir == DMA_NONE);
@@ -817,7 +807,7 @@ swiotlb_map_sg_attrs(struct device *hwdev, struct scatterlist *sgl, int nelems,
 
 	for_each_sg(sgl, sg, nelems, i) {
 		phys_addr_t paddr = sg_phys(sg);
-		dma_addr_t dev_addr = swiotlb_phys_to_bus(hwdev, paddr);
+		dma_addr_t dev_addr = phys_to_dma(hwdev, paddr);
 
 		if (range_needs_mapping(paddr, sg->length) ||
 		    address_needs_mapping(hwdev, dev_addr, sg->length)) {
-- 
1.5.6.5
