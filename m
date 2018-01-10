Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGhWZ6ZTbzF0Rp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 19:10:02 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Michal Simek <monstr@monstr.eu>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/22] swiotlb: rename swiotlb_free to swiotlb_exit
Date: Wed, 10 Jan 2018 09:09:16 +0100
Message-Id: <20180110080932.14157-7-hch@lst.de>
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/dma-swiotlb.c | 2 +-
 arch/x86/kernel/pci-swiotlb.c     | 2 +-
 include/linux/swiotlb.h           | 4 ++--
 lib/swiotlb.c                     | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 506ac4fafac5..88f3963ca30f 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -121,7 +121,7 @@ static int __init check_swiotlb_enabled(void)
 	if (ppc_swiotlb_enable)
 		swiotlb_print_info();
 	else
-		swiotlb_free();
+		swiotlb_exit();
 
 	return 0;
 }
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index 0d77603c2f50..0ee0f8f34251 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -120,7 +120,7 @@ void __init pci_swiotlb_late_init(void)
 {
 	/* An IOMMU turned us off. */
 	if (!swiotlb)
-		swiotlb_free();
+		swiotlb_exit();
 	else {
 		printk(KERN_INFO "PCI-DMA: "
 		       "Using software bounce buffering for IO (SWIOTLB)\n");
diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 24ed817082ee..606375e35d87 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -115,10 +115,10 @@ extern int
 swiotlb_dma_supported(struct device *hwdev, u64 mask);
 
 #ifdef CONFIG_SWIOTLB
-extern void __init swiotlb_free(void);
+extern void __init swiotlb_exit(void);
 unsigned int swiotlb_max_segment(void);
 #else
-static inline void swiotlb_free(void) { }
+static inline void swiotlb_exit(void) { }
 static inline unsigned int swiotlb_max_segment(void) { return 0; }
 #endif
 
diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 125c1062119f..cf5311908fa9 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -417,7 +417,7 @@ swiotlb_late_init_with_tbl(char *tlb, unsigned long nslabs)
 	return -ENOMEM;
 }
 
-void __init swiotlb_free(void)
+void __init swiotlb_exit(void)
 {
 	if (!io_tlb_orig_addr)
 		return;
-- 
2.14.2
