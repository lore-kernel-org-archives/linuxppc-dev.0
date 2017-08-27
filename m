Return-Path: <BATV+0d43c28c1e7909f7e68d+5117+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgKdB0xVszDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 02:10:51 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Michal Simek <monstr@monstr.eu>,
 David Howells <dhowells@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 x86@kernel.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] mips: don't use dma_cache_sync to implement
 fd_cacheflush
Date: Sun, 27 Aug 2017 18:10:22 +0200
Message-Id: <20170827161032.22772-3-hch@lst.de>
In-Reply-To: <20170827161032.22772-1-hch@lst.de>
References: <20170827161032.22772-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The floppy drivers doesn't otherwise use the DMA API, so indirecting
through it just for cache flushing in MIPS-specific code just call
dma_cache_wback_inv directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/floppy.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/floppy.h b/arch/mips/include/asm/floppy.h
index d75aed36480a..021d09ae5670 100644
--- a/arch/mips/include/asm/floppy.h
+++ b/arch/mips/include/asm/floppy.h
@@ -10,11 +10,11 @@
 #ifndef _ASM_FLOPPY_H
 #define _ASM_FLOPPY_H
 
-#include <linux/dma-mapping.h>
+#include <asm/io.h>
 
 static inline void fd_cacheflush(char * addr, long size)
 {
-	dma_cache_sync(NULL, addr, size, DMA_BIDIRECTIONAL);
+	dma_cache_wback_inv((unsigned long)addr, size);
 }
 
 #define MAX_BUFFER_SECTORS 24
-- 
2.11.0
