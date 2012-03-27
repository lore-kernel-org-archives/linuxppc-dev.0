Return-Path: <m.szyprowski@samsung.com>
Received: from mailout3.w1.samsung.com (mailout3.w1.samsung.com
 [210.118.77.13]) by ozlabs.org (Postfix) with ESMTP id AB736B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 00:43:36 +1100 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN
Received: from euspt2 ([210.118.77.13]) by mailout3.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0M1J00EXAQ41PD60@mailout3.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:43:13 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1J00217Q471V@spt2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:43:21 +0100 (BST)
Date: Tue, 27 Mar 2012 15:42:35 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 01/14] common: dma-mapping: introduce alloc_attrs and
 free_attrs methods
In-reply-to: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org
Message-id: <1332855768-32583-2-git-send-email-m.szyprowski@samsung.com>
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

Introduce new generic alloc and free methods with attributes argument.

Existing alloc_coherent and free_coherent can be implemented on top of the
new calls with NULL attributes argument. Later also dma_alloc_non_coherent
can be implemented using DMA_ATTR_NONCOHERENT attribute as well as
dma_alloc_writecombine with separate DMA_ATTR_WRITECOMBINE attribute.

This way the drivers will get more generic, platform independent way of
allocating dma buffers with specific parameters.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: David Gibson <david@gibson.dropbear.ud.au>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/dma-mapping.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index e13117c..8cc7f95 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -13,6 +13,12 @@ struct dma_map_ops {
 				dma_addr_t *dma_handle, gfp_t gfp);
 	void (*free_coherent)(struct device *dev, size_t size,
 			      void *vaddr, dma_addr_t dma_handle);
+	void* (*alloc)(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t gfp,
+				struct dma_attrs *attrs);
+	void (*free)(struct device *dev, size_t size,
+			      void *vaddr, dma_addr_t dma_handle,
+			      struct dma_attrs *attrs);
 	dma_addr_t (*map_page)(struct device *dev, struct page *page,
 			       unsigned long offset, size_t size,
 			       enum dma_data_direction dir,
-- 
1.7.1.569.g6f426
