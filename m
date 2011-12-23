Return-Path: <m.szyprowski@samsung.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com
 [210.118.77.14]) by ozlabs.org (Postfix) with ESMTP id 830A5B7198
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Dec 2011 23:38:07 +1100 (EST)
MIME-version: 1.0
Content-type: TEXT/PLAIN
Received: from euspt2 ([210.118.77.14]) by mailout4.w1.samsung.com
 (Sun Java(tm) System Messaging Server 6.3-8.04 (built Jul 29 2009; 32bit))
 with ESMTP id <0LWN005K4PANDJ40@mailout4.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 23 Dec 2011 12:28:00 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt2.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LWN00K8RPAN36@spt2.w1.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Fri, 23 Dec 2011 12:27:59 +0000 (GMT)
Date: Fri, 23 Dec 2011 13:27:32 +0100
From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 13/14] common: DMA-mapping: add WRITE_COMBINE attribute
In-reply-to: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
To: linux-kernel@vger.kernel.org
Message-id: <1324643253-3024-14-git-send-email-m.szyprowski@samsung.com>
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

DMA_ATTR_WRITE_COMBINE specifies that writes to the mapping may be
buffered to improve performance. It will be used by the replacement for
ARM/ARV32 specific dma_alloc_writecombine() function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 Documentation/DMA-attributes.txt |   10 ++++++++++
 include/linux/dma-attrs.h        |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index b768cc0..811a5d4 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -31,3 +31,13 @@ may be weakly ordered, that is that reads and writes may pass each other.
 Since it is optional for platforms to implement DMA_ATTR_WEAK_ORDERING,
 those that do not will simply ignore the attribute and exhibit default
 behavior.
+
+DMA_ATTR_WRITE_COMBINE
+----------------------
+
+DMA_ATTR_WRITE_COMBINE specifies that writes to the mapping may be
+buffered to improve performance.
+
+Since it is optional for platforms to implement DMA_ATTR_WRITE_COMBINE,
+those that do not will simply ignore the attribute and exhibit default
+behavior.
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index 71ad34e..ada61e1 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -13,6 +13,7 @@
 enum dma_attr {
 	DMA_ATTR_WRITE_BARRIER,
 	DMA_ATTR_WEAK_ORDERING,
+	DMA_ATTR_WRITE_COMBINE,
 	DMA_ATTR_MAX,
 };
 
-- 
1.7.1.569.g6f426
