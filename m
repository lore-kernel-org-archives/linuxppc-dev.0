Return-Path: <m.szyprowski@samsung.com>
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11]) by ozlabs.org (Postfix) with ESMTP id C16BBB6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2012 00:43:55 +1100 (EST)
Received: from euspt2 (mailout1.w1.samsung.com [210.118.77.11])
 by mailout1.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0M1J00BZ2Q3ILC@mailout1.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:42:56 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1J00KRZQ4AN9@spt2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Tue, 27 Mar 2012 14:43:23 +0100 (BST)
Date: Tue, 27 Mar 2012 15:42:46 +0200
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 12/14] common: dma-mapping: introduce mmap method
In-reply-to: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org
Message-id: <1332855768-32583-13-git-send-email-m.szyprowski@samsung.com>
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

Introduce new generic mmap method with attributes argument.

This method lets drivers to create a userspace mapping for a DMA buffer
in generic, architecture independent way.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/dma-mapping.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 2fc413a..b903a20 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -15,6 +15,9 @@ struct dma_map_ops {
 	void (*free)(struct device *dev, size_t size,
 			      void *vaddr, dma_addr_t dma_handle,
 			      struct dma_attrs *attrs);
+	int (*mmap)(struct device *, struct vm_area_struct *,
+			  void *, dma_addr_t, size_t, struct dma_attrs *attrs);
+
 	dma_addr_t (*map_page)(struct device *dev, struct page *page,
 			       unsigned long offset, size_t size,
 			       enum dma_data_direction dir,
-- 
1.7.1.569.g6f426
