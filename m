Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198E2C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:03:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88925222B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SEeGTTZ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88925222B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ynZb3wgSzDqWh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:03:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+9b1dcb6e3a5668f89bb7+5650+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="SEeGTTZ4"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ymyv49gmzDqRw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 00:36:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sJHSng1mMmFU4HMNF3kwSNHwhc7neFJSDUpiHiHS/ss=; b=SEeGTTZ4NsBCZtKQ2A4JvxZ5Ww
 6oaWEP6evHOYNvfEnGMWmM6l/VfMLVtUDShkaGOrx4MpnWhzFIf5TuTrC3UYUN6fJNZ0GXn33vd/H
 A51hKq3KTIzu5Q44hDrFB1AzPSczJDHsInWbZWHRvPGktpuVp9taXPKrgrpZNTOiLyDt01KpzBPkt
 bjU7rPfB5YakuSc6cMwCkm6H93LvSPR2mhldAwpGKS4QKa9gOvVbzKnt8ybSSnfywDHf3ryiidTTK
 eegZqM8NMamH9QQ/8D1qVOXvlZzHQAnubBah1oTI6UfGSDmD7BwSXvsNUJ9XbEmlZA9FwRtYnaaHx
 sl16e0Lw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtBkt-0000A8-N8; Mon, 11 Feb 2019 13:36:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 06/12] dma-mapping: improve selection of dma_declare_coherent
 availability
Date: Mon, 11 Feb 2019 14:35:48 +0100
Message-Id: <20190211133554.30055-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211133554.30055-1-hch@lst.de>
References: <20190211133554.30055-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
 linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This API is primarily used through DT entries, but two architectures
and two drivers call it directly.  So instead of selecting the config
symbol for random architectures pull it in implicitly for the actual
users.  Also rename the Kconfig option to describe the feature better.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arc/Kconfig            | 1 -
 arch/arm/Kconfig            | 2 +-
 arch/arm64/Kconfig          | 1 -
 arch/csky/Kconfig           | 1 -
 arch/mips/Kconfig           | 1 -
 arch/riscv/Kconfig          | 1 -
 arch/sh/Kconfig             | 2 +-
 arch/unicore32/Kconfig      | 1 -
 arch/x86/Kconfig            | 1 -
 drivers/mfd/Kconfig         | 2 ++
 drivers/of/Kconfig          | 3 ++-
 include/linux/device.h      | 2 +-
 include/linux/dma-mapping.h | 8 ++++----
 kernel/dma/Kconfig          | 2 +-
 kernel/dma/Makefile         | 2 +-
 15 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 4103f23b6cea..56e9397542e0 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -30,7 +30,6 @@ config ARC
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_FUTEX_CMPXCHG if FUTEX
-	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IOREMAP_PROT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZMA
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9395f138301a..25fbbd3cb91d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -30,6 +30,7 @@ config ARM
 	select CLONE_BACKWARDS
 	select CPU_PM if SUSPEND || CPU_IDLE
 	select DCACHE_WORD_ACCESS if HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select DMA_DECLARE_COHERENT
 	select DMA_REMAP if MMU
 	select EDAC_SUPPORT
 	select EDAC_ATOMIC_SCRUB
@@ -72,7 +73,6 @@ config ARM
 	select HAVE_FUNCTION_GRAPH_TRACER if !THUMB2_KERNEL
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL
 	select HAVE_GCC_PLUGINS
-	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7)
 	select HAVE_IDE if PCI || ISA || PCMCIA
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1d22e969bdcb..d558461a5107 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -137,7 +137,6 @@ config ARM64
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
-	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_MEMBLOCK_NODE_MAP if NUMA
diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 0a9595afe9be..c009a8c63946 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -30,7 +30,6 @@ config CSKY
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_LZMA
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0d14f51d0002..ba50dc2d37dc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -56,7 +56,6 @@ config MIPS
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
-	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_IDE
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index feeeaa60697c..51b9c97751bf 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -32,7 +32,6 @@ config RISCV
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_FUTEX_CMPXCHG if FUTEX
-	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_PERF_EVENTS
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index a9c36f95744a..a3d2a24e75c7 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -7,11 +7,11 @@ config SUPERH
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
 	select HAVE_PATA_PLATFORM
 	select CLKDEV_LOOKUP
+	select DMA_DECLARE_COHERENT
 	select HAVE_IDE if HAS_IOPORT_MAP
 	select HAVE_MEMBLOCK_NODE_MAP
 	select ARCH_DISCARD_MEMBLOCK
 	select HAVE_OPROFILE
-	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_PERF_EVENTS
 	select HAVE_DEBUG_BUGVERBOSE
diff --git a/arch/unicore32/Kconfig b/arch/unicore32/Kconfig
index c3a41bfe161b..6d2891d37e32 100644
--- a/arch/unicore32/Kconfig
+++ b/arch/unicore32/Kconfig
@@ -4,7 +4,6 @@ config UNICORE32
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
-	select HAVE_GENERIC_DMA_COHERENT
 	select HAVE_KERNEL_GZIP
 	select HAVE_KERNEL_BZIP2
 	select GENERIC_ATOMIC64
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 26387c7bf305..0e33dede053e 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -15,7 +15,6 @@ config X86_32
 	select CLKSRC_I8253
 	select CLONE_BACKWARDS
 	select HAVE_AOUT
-	select HAVE_GENERIC_DMA_COHERENT
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f15f6489803d..c3ccf2c7b3ef 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1067,6 +1067,7 @@ config MFD_SI476X_CORE
 config MFD_SM501
 	tristate "Silicon Motion SM501"
 	depends on HAS_DMA
+	select DMA_DECLARE_COHERENT
 	 ---help---
 	  This is the core driver for the Silicon Motion SM501 multimedia
 	  companion chip. This device is a multifunction device which may
@@ -1675,6 +1676,7 @@ config MFD_TC6393XB
 	select GPIOLIB
 	select MFD_CORE
 	select MFD_TMIO
+	select DMA_DECLARE_COHERENT
 	help
 	  Support for Toshiba Mobile IO Controller TC6393XB
 
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 3607fd2810e4..f8c66a9472a4 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -43,6 +43,7 @@ config OF_FLATTREE
 
 config OF_EARLY_FLATTREE
 	bool
+	select DMA_DECLARE_COHERENT
 	select OF_FLATTREE
 
 config OF_PROMTREE
@@ -83,7 +84,7 @@ config OF_MDIO
 config OF_RESERVED_MEM
 	bool
 	depends on OF_EARLY_FLATTREE
-	default y if HAVE_GENERIC_DMA_COHERENT || DMA_CMA
+	default y if DMA_DECLARE_COHERENT || DMA_CMA
 
 config OF_RESOLVE
 	bool
diff --git a/include/linux/device.h b/include/linux/device.h
index be544400acdd..c52d90348cef 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1017,7 +1017,7 @@ struct device {
 
 	struct list_head	dma_pools;	/* dma pools (if dma'ble) */
 
-#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
+#ifdef CONFIG_DMA_DECLARE_COHERENT
 	struct dma_coherent_mem	*dma_mem; /* internal for coherent mem
 					     override */
 #endif
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index b904d55247ab..fde0cfc71824 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -153,7 +153,7 @@ static inline int is_device_dma_capable(struct device *dev)
 	return dev->dma_mask != NULL && *dev->dma_mask != DMA_MASK_NONE;
 }
 
-#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
+#ifdef CONFIG_DMA_DECLARE_COHERENT
 /*
  * These three functions are only for dma allocator.
  * Don't use them in device drivers.
@@ -192,7 +192,7 @@ static inline int dma_mmap_from_global_coherent(struct vm_area_struct *vma,
 {
 	return 0;
 }
-#endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
+#endif /* CONFIG_DMA_DECLARE_COHERENT */
 
 static inline bool dma_is_direct(const struct dma_map_ops *ops)
 {
@@ -731,7 +731,7 @@ static inline int dma_get_cache_alignment(void)
 /* flags for the coherent memory api */
 #define DMA_MEMORY_EXCLUSIVE		0x01
 
-#ifdef CONFIG_HAVE_GENERIC_DMA_COHERENT
+#ifdef CONFIG_DMA_DECLARE_COHERENT
 int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 				dma_addr_t device_addr, size_t size, int flags);
 void dma_release_declared_memory(struct device *dev);
@@ -756,7 +756,7 @@ dma_mark_declared_memory_occupied(struct device *dev,
 {
 	return ERR_PTR(-EBUSY);
 }
-#endif /* CONFIG_HAVE_GENERIC_DMA_COHERENT */
+#endif /* CONFIG_DMA_DECLARE_COHERENT */
 
 static inline void *dmam_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp)
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index ca88b867e7fe..b122ab100d66 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -16,7 +16,7 @@ config ARCH_DMA_ADDR_T_64BIT
 config ARCH_HAS_DMA_COHERENCE_H
 	bool
 
-config HAVE_GENERIC_DMA_COHERENT
+config DMA_DECLARE_COHERENT
 	bool
 
 config ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
index 72ff6e46aa86..d237cf3dc181 100644
--- a/kernel/dma/Makefile
+++ b/kernel/dma/Makefile
@@ -2,7 +2,7 @@
 
 obj-$(CONFIG_HAS_DMA)			+= mapping.o direct.o dummy.o
 obj-$(CONFIG_DMA_CMA)			+= contiguous.o
-obj-$(CONFIG_HAVE_GENERIC_DMA_COHERENT) += coherent.o
+obj-$(CONFIG_DMA_DECLARE_COHERENT)	+= coherent.o
 obj-$(CONFIG_DMA_VIRT_OPS)		+= virt.o
 obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
 obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
-- 
2.20.1

