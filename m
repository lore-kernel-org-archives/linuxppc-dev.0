Return-Path: <m.szyprowski@samsung.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11]) by ozlabs.org (Postfix) with ESMTP id 55461B6FA9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 00:43:37 +1100 (EST)
Received: from euspt1 (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0M1J00BL9Q3FK2@mailout1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:42:53 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1J00794Q4BCW@spt1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:43:24 +0100 (BST)
Date: Tue, 27 Mar 2012 15:42:43 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 09/14] Unicore32: adapt for dma_map_ops changes
In-reply-to: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org
Message-id: <1332855768-32583-10-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
Content-type: TEXT/PLAIN
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

Adapt core Unicore32 architecture code for dma_map_ops changes: replace
alloc/free_coherent with generic alloc/free methods.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
[added swiotlb_alloc/free_coherent wrappers]
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/unicore32/include/asm/dma-mapping.h |   18 ++++++++++++------
 arch/unicore32/mm/dma-swiotlb.c          |   18 ++++++++++++++++--
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
index 9258e59..366460a 100644
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ b/arch/unicore32/include/asm/dma-mapping.h
@@ -82,20 +82,26 @@ static inline int dma_set_mask(struct device *dev, u64 dma_mask)
 	return 0;
 }
 
-static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t flag)
+#define dma_alloc_coherent(d,s,h,f)	dma_alloc_attrs(d,s,h,f,NULL)
+
+static inline void *dma_alloc_attrs(struct device *dev, size_t size,
+				    dma_addr_t *dma_handle, gfp_t flag,
+				    struct dma_attrs *attrs)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
 
-	return dma_ops->alloc_coherent(dev, size, dma_handle, flag);
+	return dma_ops->alloc(dev, size, dma_handle, flag, attrs);
 }
 
-static inline void dma_free_coherent(struct device *dev, size_t size,
-				     void *cpu_addr, dma_addr_t dma_handle)
+#define dma_free_coherent(d,s,c,h) dma_free_attrs(d,s,c,h,NULL)
+
+static inline void dma_free_attrs(struct device *dev, size_t size,
+				  void *cpu_addr, dma_addr_t dma_handle,
+				  struct dma_attrs *attrs)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
 
-	dma_ops->free_coherent(dev, size, cpu_addr, dma_handle);
+	dma_ops->free(dev, size, cpu_addr, dma_handle, attrs);
 }
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
diff --git a/arch/unicore32/mm/dma-swiotlb.c b/arch/unicore32/mm/dma-swiotlb.c
index bfa9fbb..4cf5f0c 100644
--- a/arch/unicore32/mm/dma-swiotlb.c
+++ b/arch/unicore32/mm/dma-swiotlb.c
@@ -17,9 +17,23 @@
 
 #include <asm/dma.h>
 
+static void *unicore_swiotlb_alloc_coherent(struct device *dev, size_t size,
+					    dma_addr_t *dma_handle, gfp_t flags,
+					    struct dma_attrs *attrs)
+{
+	return swiotlb_alloc_coherent(dev, size, dma_handle, flags);
+}
+
+static void unicode_swiotlb_free_coherent(struct device *dev, size_t size,
+					  void *vaddr, dma_addr_t dma_addr,
+					  struct dma_attrs *attrs)
+{
+	swiotlb_free_coherent(dev, size, vaddr, dma_addr);
+}
+
 struct dma_map_ops swiotlb_dma_map_ops = {
-	.alloc_coherent = swiotlb_alloc_coherent,
-	.free_coherent = swiotlb_free_coherent,
+	.alloc = unicore_swiotlb_alloc_coherent,
+	.free = unicore_swiotlb_free_coherent,
 	.map_sg = swiotlb_map_sg_attrs,
 	.unmap_sg = swiotlb_unmap_sg_attrs,
 	.dma_supported = swiotlb_dma_supported,
-- 
1.7.1.569.g6f426
