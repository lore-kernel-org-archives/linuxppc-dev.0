Return-Path: <m.szyprowski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14]) by ozlabs.org (Postfix) with ESMTP id 31134B71B9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2011 23:38:08 +1100 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN
Received: from euspt2 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LWN005K4PANDJ40@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 23 Dec 2011 12:28:00 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LWN009B1PAN85@spt2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 23 Dec 2011 12:27:59 +0000 (GMT)
Date: Fri, 23 Dec 2011 13:27:31 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 12/14] common: dma-mapping: introduce mmap method
In-reply-to: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org
Message-id: <1324643253-3024-13-git-send-email-m.szyprowski@samsung.com>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-mm@kvack.org, sparclinux@vger.kernel.org,
 Marek Szyprowski <m.szyprowski@samsung.com>, linux-arch@vger.kernel.org,
 Stephen Rothwell <sfr@canb.auug.org.au>, Jonathan Corbet <corbet@lwn.net>,
 x86@kernel.org, Arnd Bergmann <arnd@arndb.de>,
 microblaze-uclinux@itee.uq.edu.au, linaro-mm-sig@lists.linaro.org,
 Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 discuss@x86-64.org, Kyungmin Park <kyungmin.park@samsung.com>,
 linux-alpha@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
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
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
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
