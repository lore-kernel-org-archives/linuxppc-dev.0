Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fBXC65fjzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 17:48:43 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	iommu@lists.linux-foundation.org
Subject: [PATCH] powerpc: do not redefined NEED_DMA_MAP_STATE
Date: Mon, 30 Jul 2018 09:37:21 +0200
Message-Id: <20180730073721.15991-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel/dma/Kconfig already defines NEED_DMA_MAP_STATE, just select it
from PPC64 and NOT_COHERENT_CACHE instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig                   | 3 ---
 arch/powerpc/platforms/Kconfig.cputype | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9f2b75fe2c2d..f9cae7edd735 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -884,9 +884,6 @@ config ZONE_DMA
 	bool
 	default y
 
-config NEED_DMA_MAP_STATE
-	def_bool (PPC64 || NOT_COHERENT_CACHE)
-
 config GENERIC_ISA_DMA
 	bool
 	depends on ISA_DMA_API
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index e6a1de521319..a2578bf8d560 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -3,6 +3,7 @@ config PPC64
 	bool "64-bit kernel"
 	default n
 	select ZLIB_DEFLATE
+	select NEED_DMA_MAP_STATE
 	help
 	  This option selects whether a 32-bit or a 64-bit kernel
 	  will be built.
@@ -386,6 +387,7 @@ config NOT_COHERENT_CACHE
 	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
 	default n if PPC_47x
 	default y
+	select NEED_DMA_MAP_STATE
 
 config CHECK_CACHE_COHERENCY
 	bool
-- 
2.18.0
