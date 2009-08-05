Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from sh.osrg.net (sh.osrg.net [192.16.179.4])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 35DABB7B68
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  5 Aug 2009 15:10:14 +1000 (EST)
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org
Subject: [PATCH -v2 7/7] powerpc: add CONFIG_DMA_API_DEBUG support
Date: Wed,  5 Aug 2009 14:08:28 +0900
Message-Id: <1249448908-18985-8-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
References: <1249448908-18985-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Cc: fujita.tomonori@lab.ntt.co.jp, mingo@elte.hu, linux-kernel@vger.kernel.org,
	galak@kernel.crashing.orga
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
---
 arch/powerpc/Kconfig                   |    1 +
 arch/powerpc/include/asm/dma-mapping.h |   11 ++++++++++-
 arch/powerpc/kernel/dma.c              |   11 +++++++++++
 3 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index fb3f4ff..4459b78 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -121,6 +121,7 @@ config PPC
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_LMB
 	select HAVE_DMA_ATTRS
+	select HAVE_DMA_API_DEBUG
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select HAVE_OPROFILE
 	select HAVE_SYSCALL_WRAPPERS if PPC64
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 4bd41b4..cb2ca41 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -127,9 +127,15 @@ static inline void *dma_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag)
 {
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
+	void *cpu_addr;
 
 	BUG_ON(!dma_ops);
-	return dma_ops->alloc_coherent(dev, size, dma_handle, flag);
+
+	cpu_addr = dma_ops->alloc_coherent(dev, size, dma_handle, flag);
+
+	debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_addr);
+
+	return cpu_addr;
 }
 
 static inline void dma_free_coherent(struct device *dev, size_t size,
@@ -138,6 +144,9 @@ static inline void dma_free_coherent(struct device *dev, size_t size,
 	struct dma_map_ops *dma_ops = get_dma_ops(dev);
 
 	BUG_ON(!dma_ops);
+
+	debug_dma_free_coherent(dev, size, cpu_addr, dma_handle);
+
 	dma_ops->free_coherent(dev, size, cpu_addr, dma_handle);
 }
 
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 3e8bb9a..c6d730e 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -7,6 +7,7 @@
 
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma-debug.h>
 #include <asm/bug.h>
 #include <asm/abs_addr.h>
 
@@ -156,3 +157,13 @@ struct dma_map_ops dma_direct_ops = {
 #endif
 };
 EXPORT_SYMBOL(dma_direct_ops);
+
+#define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
+
+static int __init dma_init(void)
+{
+       dma_debug_init(PREALLOC_DMA_DEBUG_ENTRIES);
+
+       return 0;
+}
+fs_initcall(dma_init);
-- 
1.6.0.6
