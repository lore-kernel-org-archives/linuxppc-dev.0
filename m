Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 41LT6M0f4dzF0X5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 03:50:18 +1000 (AEST)
From: Robin Murphy <robin.murphy@arm.com>
To: hch@lst.de,
	m.szyprowski@samsung.com
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 1/2] dma-mapping: Clean up dma_set_*mask() hooks
Date: Wed,  4 Jul 2018 18:50:11 +0100
Message-Id: <55ac9550c311f056dcfeed9b2c8265375f17b155.1530726467.git.robin.murphy@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arch-specific implementions for dma_set_{coherent_,}mask() currently
rely on an inconsistent mix of arch-defined Kconfig symbols and macro
overrides. Now that we have a nice centralised home for DMA API gubbins,
let's consolidate these loose ends under consistent config options.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Here's hoping the buildbot comes by to point out what I've inevitably
missed, although I did check a cursory cross-compile of ppc64_defconfig
to iron out the obvious howlers.

The motivation here is that I'm looking at adding set_mask overrides
for arm64, and having discovered a bit of a mess it seemed prudent to
clean up before ingraining it any more.

Robin.


 arch/arm/Kconfig                       | 3 ---
 arch/powerpc/Kconfig                   | 4 +---
 arch/powerpc/include/asm/dma-mapping.h | 3 ---
 include/linux/dma-mapping.h            | 4 +++-
 kernel/dma/Kconfig                     | 6 ++++++
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 843edfd000be..ab0c081b6ec2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -227,9 +227,6 @@ config ZONE_DMA
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
 
-config ARCH_HAS_DMA_SET_COHERENT_MASK
-	bool
-
 config GENERIC_ISA_DMA
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9f2b75fe2c2d..08d85412d783 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -119,9 +119,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
-config ARCH_HAS_DMA_SET_COHERENT_MASK
-        bool
-
 config PPC
 	bool
 	default y
@@ -129,6 +126,7 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_SET_MASK
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 8fa394520af6..fe912c4367f2 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -107,9 +107,6 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 		dev->archdata.dma_offset = off;
 }
 
-#define HAVE_ARCH_DMA_SET_MASK 1
-extern int dma_set_mask(struct device *dev, u64 dma_mask);
-
 extern u64 __dma_get_required_mask(struct device *dev);
 
 #define ARCH_HAS_DMA_MMAP_COHERENT
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index ffeca3ab59c0..30fe0c900420 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -596,7 +596,9 @@ static inline int dma_supported(struct device *dev, u64 mask)
 	return ops->dma_supported(dev, mask);
 }
 
-#ifndef HAVE_ARCH_DMA_SET_MASK
+#ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
+int dma_set_mask(struct device *dev, u64 mask);
+#else
 static inline int dma_set_mask(struct device *dev, u64 mask)
 {
 	if (!dev->dma_mask || !dma_supported(dev, mask))
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 9bd54304446f..01001371d892 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -16,6 +16,12 @@ config ARCH_DMA_ADDR_T_64BIT
 config HAVE_GENERIC_DMA_COHERENT
 	bool
 
+config ARCH_HAS_DMA_SET_MASK
+        bool
+
+config ARCH_HAS_DMA_SET_COHERENT_MASK
+        bool
+
 config ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	bool
 
-- 
2.17.1.dirty
