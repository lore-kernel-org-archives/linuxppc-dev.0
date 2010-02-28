Return-Path: <albert_herranz@yahoo.es>
Received: from smtp138.mail.ukl.yahoo.com (smtp138.mail.ukl.yahoo.com
	[77.238.184.69]) by ozlabs.org (Postfix) with SMTP id 7E27DB7D22
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  1 Mar 2010 01:08:23 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-usb@vger.kernel.org
Subject: [RFC PATCH v2 1/9] powerpc: add per-device dma coherent support
Date: Sun, 28 Feb 2010 15:07:54 +0100
Message-Id: <1267366082-15248-2-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
References: <1267366082-15248-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the generic per-device dma coherent allocator on powerpc.
This allows a driver to declare coherent memory area from where
a device can allocate coherent memory chunks.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/include/asm/dma-mapping.h |    1 +
 arch/powerpc/kernel/dma.c              |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 80a973b..18ecec8 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -17,6 +17,7 @@
 #include <linux/dma-debug.h>
 #include <asm/io.h>
 #include <asm/swiotlb.h>
+#include <asm-generic/dma-coherent.h>
 
 #define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 6215062..83d5232 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -27,6 +27,9 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 {
 	void *ret;
 #ifdef CONFIG_NOT_COHERENT_CACHE
+	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
+		return ret;
+
 	ret = __dma_alloc_coherent(dev, size, dma_handle, flag);
 	if (ret == NULL)
 		return NULL;
@@ -54,6 +57,8 @@ void dma_direct_free_coherent(struct device *dev, size_t size,
 			      void *vaddr, dma_addr_t dma_handle)
 {
 #ifdef CONFIG_NOT_COHERENT_CACHE
+	if (dma_release_from_coherent(dev, get_order(size), vaddr))
+		return;
 	__dma_free_coherent(size, vaddr);
 #else
 	free_pages((unsigned long)vaddr, get_order(size));
-- 
1.6.3.3
