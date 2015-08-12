Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6621A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:09:01 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: torvalds@linux-foundation.org,
	axboe@kernel.dk
Cc: dan.j.williams@intel.com, vgupta@synopsys.com, hskinnemoen@gmail.com,
 egtvedt@samfundet.no, realmz6@gmail.com, dhowells@redhat.com,
 monstr@monstr.eu, x86@kernel.org, dwmw2@infradead.org,
 alex.williamson@redhat.com, grundler@parisc-linux.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, linux-nvdimm@ml01.01.org,
 linux-media@vger.kernel.org
Subject: [PATCH 05/31] x86/pci-calgary: handle page-less SG entries
Date: Wed, 12 Aug 2015 09:05:24 +0200
Message-Id: <1439363150-8661-6-git-send-email-hch@lst.de>
In-Reply-To: <1439363150-8661-1-git-send-email-hch@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For the iommu offset we just need and offset into the page.  Calculate
that using the physical address instead of using the virtual address
so that we don't require a virtual mapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/pci-calgary_64.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/pci-calgary_64.c b/arch/x86/kernel/pci-calgary_64.c
index 0497f71..8f1581d 100644
--- a/arch/x86/kernel/pci-calgary_64.c
+++ b/arch/x86/kernel/pci-calgary_64.c
@@ -368,16 +368,14 @@ static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 {
 	struct iommu_table *tbl = find_iommu_table(dev);
 	struct scatterlist *s;
-	unsigned long vaddr;
+	unsigned long paddr;
 	unsigned int npages;
 	unsigned long entry;
 	int i;
 
 	for_each_sg(sg, s, nelems, i) {
-		BUG_ON(!sg_page(s));
-
-		vaddr = (unsigned long) sg_virt(s);
-		npages = iommu_num_pages(vaddr, s->length, PAGE_SIZE);
+		paddr = sg_phys(s);
+		npages = iommu_num_pages(paddr, s->length, PAGE_SIZE);
 
 		entry = iommu_range_alloc(dev, tbl, npages);
 		if (entry == DMA_ERROR_CODE) {
@@ -389,7 +387,7 @@ static int calgary_map_sg(struct device *dev, struct scatterlist *sg,
 		s->dma_address = (entry << PAGE_SHIFT) | s->offset;
 
 		/* insert into HW table */
-		tce_build(tbl, entry, npages, vaddr & PAGE_MASK, dir);
+		tce_build(tbl, entry, npages, paddr & PAGE_MASK, dir);
 
 		s->dma_length = s->length;
 	}
-- 
1.9.1
