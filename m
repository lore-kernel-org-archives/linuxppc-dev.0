Return-Path: <m.szyprowski@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13]) by ozlabs.org (Postfix) with ESMTP id 492F8B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 00:43:35 +1100 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN
Received: from euspt2 ([210.118.77.13]) by mailout3.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0M1J00EXAQ41PD60@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:43:13 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1J0001NQ47U6@spt2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:43:21 +0100 (BST)
Date: Tue, 27 Mar 2012 15:42:37 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 03/14] MIPS: adapt for dma_map_ops changes
In-reply-to: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org
Message-id: <1332855768-32583-4-git-send-email-m.szyprowski@samsung.com>
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
Cc: linux-mips@linux-mips.org, Kevin Cernekee <cernekee@gmail.com>,
 linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>,
 x86@kernel.org, Matt Turner <mattst88@gmail.com>,
 Dezhong Diao <dediao@cisco.com>, Fenghua Yu <fenghua.yu@intel.com>,
 Arnd Bergmann <arnd@arndb.de>, microblaze-uclinux@itee.uq.edu.au,
 linaro-mm-sig@lists.linaro.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Richard Henderson <rth@twiddle.net>, discuss@x86-64.org,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 Richard Kuo <rkuo@codeaurora.org>,
 FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
 Kyungmin Park <kyungmin.park@samsung.com>, Paul Mundt <lethal@linux-sh.org>,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andrzej Pietrasiewicz <andrzej.p@samsung.com>

Adapt core MIPS architecture code for dma_map_ops changes: replace
alloc/free_coherent with generic alloc/free methods.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
[added missing changes to arch/mips/cavium-octeon/dma-octeon.c,
 fixed attrs argument in dma-mapping.h]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/cavium-octeon/dma-octeon.c |   12 ++++++------
 arch/mips/include/asm/dma-mapping.h  |   18 ++++++++++++------
 arch/mips/mm/dma-default.c           |    8 ++++----
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index b6bb92c..41dd0088 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -157,7 +157,7 @@ static void octeon_dma_sync_sg_for_device(struct device *dev,
 }
 
 static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t *dma_handle, gfp_t gfp)
+	dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
 {
 	void *ret;
 
@@ -192,7 +192,7 @@ static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
 }
 
 static void octeon_dma_free_coherent(struct device *dev, size_t size,
-	void *vaddr, dma_addr_t dma_handle)
+	void *vaddr, dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
 	int order = get_order(size);
 
@@ -240,8 +240,8 @@ EXPORT_SYMBOL(dma_to_phys);
 
 static struct octeon_dma_map_ops octeon_linear_dma_map_ops = {
 	.dma_map_ops = {
-		.alloc_coherent = octeon_dma_alloc_coherent,
-		.free_coherent = octeon_dma_free_coherent,
+		.alloc = octeon_dma_alloc_coherent,
+		.free = octeon_dma_free_coherent,
 		.map_page = octeon_dma_map_page,
 		.unmap_page = swiotlb_unmap_page,
 		.map_sg = octeon_dma_map_sg,
@@ -325,8 +325,8 @@ void __init plat_swiotlb_setup(void)
 #ifdef CONFIG_PCI
 static struct octeon_dma_map_ops _octeon_pci_dma_map_ops = {
 	.dma_map_ops = {
-		.alloc_coherent = octeon_dma_alloc_coherent,
-		.free_coherent = octeon_dma_free_coherent,
+		.alloc = octeon_dma_alloc_coherent,
+		.free = octeon_dma_free_coherent,
 		.map_page = octeon_dma_map_page,
 		.unmap_page = swiotlb_unmap_page,
 		.map_sg = octeon_dma_map_sg,
diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 7aa37dd..be39a12 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -57,25 +57,31 @@ dma_set_mask(struct device *dev, u64 mask)
 extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	       enum dma_data_direction direction);
 
-static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t gfp)
+#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
+
+static inline void *dma_alloc_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t gfp,
+				    struct dma_attrs *attrs)
 {
 	void *ret;
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
-	ret = ops->alloc_coherent(dev, size, dma_handle, gfp);
+	ret = ops->alloc(dev, size, dma_handle, gfp, attrs);
 
 	debug_dma_alloc_coherent(dev, size, *dma_handle, ret);
 
 	return ret;
 }
 
-static inline void dma_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t dma_handle)
+#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
+
+static inline void dma_free_attrs(struct device *dev, size_t size,
+				  void *vaddr, dma_addr_t dma_handle,
+				  struct dma_attrs *attrs)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
-	ops->free_coherent(dev, size, vaddr, dma_handle);
+	ops->free(dev, size, vaddr, dma_handle, attrs);
 
 	debug_dma_free_coherent(dev, size, vaddr, dma_handle);
 }
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 4608491..3fab204 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -98,7 +98,7 @@ void *dma_alloc_noncoherent(struct device *dev, size_t size,
 EXPORT_SYMBOL(dma_alloc_noncoherent);
 
 static void *mips_dma_alloc_coherent(struct device *dev, size_t size,
-	dma_addr_t * dma_handle, gfp_t gfp)
+	dma_addr_t * dma_handle, gfp_t gfp, struct dma_attrs *attrs)
 {
 	void *ret;
 
@@ -132,7 +132,7 @@ void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
 EXPORT_SYMBOL(dma_free_noncoherent);
 
 static void mips_dma_free_coherent(struct device *dev, size_t size, void *vaddr,
-	dma_addr_t dma_handle)
+	dma_addr_t dma_handle, struct dma_attrs *attrs)
 {
 	unsigned long addr = (unsigned long) vaddr;
 	int order = get_order(size);
@@ -323,8 +323,8 @@ void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 EXPORT_SYMBOL(dma_cache_sync);
 
 static struct dma_map_ops mips_default_dma_map_ops = {
-	.alloc_coherent = mips_dma_alloc_coherent,
-	.free_coherent = mips_dma_free_coherent,
+	.alloc = mips_dma_alloc_coherent,
+	.free = mips_dma_free_coherent,
 	.map_page = mips_dma_map_page,
 	.unmap_page = mips_dma_unmap_page,
 	.map_sg = mips_dma_map_sg,
-- 
1.7.1.569.g6f426
