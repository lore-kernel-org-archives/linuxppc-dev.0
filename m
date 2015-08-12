Return-Path: <BATV+598c32ccc3a9ece13a58+4371+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F9DF1A067D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 17:09:18 +1000 (AEST)
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
Subject: [PATCH 11/31] sparc/iommu: handle page-less SG entries
Date: Wed, 12 Aug 2015 09:05:30 +0200
Message-Id: <1439363150-8661-12-git-send-email-hch@lst.de>
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

Use sg_phys() instead of __pa(sg_virt(sg)) so that we don't
require a kernel virtual address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sparc/kernel/iommu.c        | 2 +-
 arch/sparc/kernel/iommu_common.h | 4 +---
 arch/sparc/kernel/pci_sun4v.c    | 2 +-
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/iommu.c b/arch/sparc/kernel/iommu.c
index 5320689..2ad89d2 100644
--- a/arch/sparc/kernel/iommu.c
+++ b/arch/sparc/kernel/iommu.c
@@ -486,7 +486,7 @@ static int dma_4u_map_sg(struct device *dev, struct scatterlist *sglist,
 			continue;
 		}
 		/* Allocate iommu entries for that segment */
-		paddr = (unsigned long) SG_ENT_PHYS_ADDRESS(s);
+		paddr = sg_phys(s);
 		npages = iommu_num_pages(paddr, slen, IO_PAGE_SIZE);
 		entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages,
 					      &handle, (unsigned long)(-1), 0);
diff --git a/arch/sparc/kernel/iommu_common.h b/arch/sparc/kernel/iommu_common.h
index b40cec2..8e2c211 100644
--- a/arch/sparc/kernel/iommu_common.h
+++ b/arch/sparc/kernel/iommu_common.h
@@ -33,15 +33,13 @@
  */
 #define IOMMU_PAGE_SHIFT		13
 
-#define SG_ENT_PHYS_ADDRESS(SG)	(__pa(sg_virt((SG))))
-
 static inline int is_span_boundary(unsigned long entry,
 				   unsigned long shift,
 				   unsigned long boundary_size,
 				   struct scatterlist *outs,
 				   struct scatterlist *sg)
 {
-	unsigned long paddr = SG_ENT_PHYS_ADDRESS(outs);
+	unsigned long paddr = sg_phys(outs);
 	int nr = iommu_num_pages(paddr, outs->dma_length + sg->length,
 				 IO_PAGE_SIZE);
 
diff --git a/arch/sparc/kernel/pci_sun4v.c b/arch/sparc/kernel/pci_sun4v.c
index d2fe57d..a7a6e41 100644
--- a/arch/sparc/kernel/pci_sun4v.c
+++ b/arch/sparc/kernel/pci_sun4v.c
@@ -370,7 +370,7 @@ static int dma_4v_map_sg(struct device *dev, struct scatterlist *sglist,
 			continue;
 		}
 		/* Allocate iommu entries for that segment */
-		paddr = (unsigned long) SG_ENT_PHYS_ADDRESS(s);
+		paddr = sg_phys(s);
 		npages = iommu_num_pages(paddr, slen, IO_PAGE_SIZE);
 		entry = iommu_tbl_range_alloc(dev, &iommu->tbl, npages,
 					      &handle, (unsigned long)(-1), 0);
-- 
1.9.1
