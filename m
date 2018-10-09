Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1840EC64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:54:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AB4B21479
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rx8ORDO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB4B21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V0cW4dCbzF37v
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 01:54:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="Rx8ORDO/";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+39c443e67938b060f200+5525+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="Rx8ORDO/"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tz142kswzF3FQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:42:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t4111eWUggvDPhD1JmlTBkHpP8cYIAKt6u/lP2eJRkM=; b=Rx8ORDO/Vl2daZDQb4J0rqJloG
 GcESEP+TeojH/eEJSqgVzgxRcZGymVI9smAysM0mUdhQJ7Dw0Hnbo1cuhRknivHTry0gkbfn0ZO8D
 KxG4CB0m02b2y0S7wseMbQF16JtwTPGG3PbfkfJGKxNt8Xl24WnbPXyoIK2VnKzQJsv0cdKatS0zR
 +PpZa9kqWlmj3DG3RCp4mWMYQtvDyBYPEdYX3ngPZZ/gEbbPGv/tH4bwsUS6S6JzlUc93Bc/Du2ac
 aMJNqP0lMUeVGaqie7/eqPoPgdppkJeXL7fTCVVuMkWcJXdUF9yXpwPoB/BmATJPFKX5F/o0maJ3i
 TfLAq52A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s0W-0008Kf-PH; Tue, 09 Oct 2018 13:25:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 01/33] powerpc: use mm zones more sensibly
Date: Tue,  9 Oct 2018 15:24:28 +0200
Message-Id: <20181009132500.17643-2-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Powerpc has somewhat odd usage where ZONE_DMA is used for all memory on
common 64-bit configfs, and ZONE_DMA32 is used for 31-bit schemes.

Move to a scheme closer to what other architectures use (and I dare to
say the intent of the system):

 - ZONE_DMA: optionally for memory < 31-bit
 - ZONE_NORMAL: everything addressable by the kernel
 - ZONE_HIGHMEM: memory > 32-bit for 32-bit kernels

Also provide information on how ZONE_DMA is used by defining
ARCH_ZONE_DMA_BITS.

Contains various fixes from Benjamin Herrenschmidt.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig                          |  6 +--
 arch/powerpc/include/asm/page.h               |  2 +
 arch/powerpc/include/asm/pgtable.h            |  1 -
 arch/powerpc/kernel/dma-swiotlb.c             |  6 +--
 arch/powerpc/kernel/dma.c                     |  7 +--
 arch/powerpc/mm/mem.c                         | 50 +++++++------------
 arch/powerpc/platforms/85xx/corenet_generic.c | 10 ----
 arch/powerpc/platforms/85xx/qemu_e500.c       |  9 ----
 include/linux/mmzone.h                        |  2 +-
 9 files changed, 24 insertions(+), 69 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a80669209155..06996df07cad 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -380,7 +380,7 @@ config PPC_ADV_DEBUG_DAC_RANGE
 	depends on PPC_ADV_DEBUG_REGS && 44x
 	default y
 
-config ZONE_DMA32
+config ZONE_DMA
 	bool
 	default y if PPC64
 
@@ -879,10 +879,6 @@ config ISA
 	  have an IBM RS/6000 or pSeries machine, say Y.  If you have an
 	  embedded board, consult your board documentation.
 
-config ZONE_DMA
-	bool
-	default y
-
 config GENERIC_ISA_DMA
 	bool
 	depends on ISA_DMA_API
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index f6a1265face2..fc8c9ac0c6be 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -354,4 +354,6 @@ typedef struct page *pgtable_t;
 #endif /* __ASSEMBLY__ */
 #include <asm/slice.h>
 
+#define ARCH_ZONE_DMA_BITS 31
+
 #endif /* _ASM_POWERPC_PAGE_H */
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 14c79a7dc855..9bafb38e959e 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -37,7 +37,6 @@ extern unsigned long empty_zero_page[];
 
 extern pgd_t swapper_pg_dir[];
 
-void limit_zone_pfn(enum zone_type zone, unsigned long max_pfn);
 int dma_pfn_limit_to_zone(u64 pfn_limit);
 extern void paging_init(void);
 
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 88f3963ca30f..93a4622563c6 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -108,12 +108,8 @@ int __init swiotlb_setup_bus_notifier(void)
 
 void __init swiotlb_detect_4g(void)
 {
-	if ((memblock_end_of_DRAM() - 1) > 0xffffffff) {
+	if ((memblock_end_of_DRAM() - 1) > 0xffffffff)
 		ppc_swiotlb_enable = 1;
-#ifdef CONFIG_ZONE_DMA32
-		limit_zone_pfn(ZONE_DMA32, (1ULL << 32) >> PAGE_SHIFT);
-#endif
-	}
 }
 
 static int __init check_swiotlb_enabled(void)
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index dbfc7056d7df..6551685a4ed0 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -50,7 +50,7 @@ static int dma_nommu_dma_supported(struct device *dev, u64 mask)
 		return 1;
 
 #ifdef CONFIG_FSL_SOC
-	/* Freescale gets another chance via ZONE_DMA/ZONE_DMA32, however
+	/* Freescale gets another chance via ZONE_DMA, however
 	 * that will have to be refined if/when they support iommus
 	 */
 	return 1;
@@ -94,13 +94,10 @@ void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
 	}
 
 	switch (zone) {
+#ifdef CONFIG_ZONE_DMA
 	case ZONE_DMA:
 		flag |= GFP_DMA;
 		break;
-#ifdef CONFIG_ZONE_DMA32
-	case ZONE_DMA32:
-		flag |= GFP_DMA32;
-		break;
 #endif
 	};
 #endif /* CONFIG_FSL_SOC */
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5c8530d0c611..8bff7e893bde 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -69,15 +69,12 @@ pte_t *kmap_pte;
 EXPORT_SYMBOL(kmap_pte);
 pgprot_t kmap_prot;
 EXPORT_SYMBOL(kmap_prot);
-#define TOP_ZONE ZONE_HIGHMEM
 
 static inline pte_t *virt_to_kpte(unsigned long vaddr)
 {
 	return pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(vaddr),
 			vaddr), vaddr), vaddr);
 }
-#else
-#define TOP_ZONE ZONE_NORMAL
 #endif
 
 int page_is_ram(unsigned long pfn)
@@ -246,35 +243,19 @@ static int __init mark_nonram_nosave(void)
 }
 #endif
 
-static bool zone_limits_final;
-
-/*
- * The memory zones past TOP_ZONE are managed by generic mm code.
- * These should be set to zero since that's what every other
- * architecture does.
- */
-static unsigned long max_zone_pfns[MAX_NR_ZONES] = {
-	[0            ... TOP_ZONE        ] = ~0UL,
-	[TOP_ZONE + 1 ... MAX_NR_ZONES - 1] = 0
-};
-
 /*
- * Restrict the specified zone and all more restrictive zones
- * to be below the specified pfn.  May not be called after
- * paging_init().
+ * Zones usage:
+ *
+ * We setup ZONE_DMA to be 31-bits on all platforms and ZONE_NORMAL to be
+ * everything else. GFP_DMA32 page allocations automatically fall back to
+ * ZONE_DMA.
+ *
+ * By using 31-bit unconditionally, we can exploit ARCH_ZONE_DMA_BITS to
+ * inform the generic DMA mapping code.  32-bit only devices (if not handled
+ * by an IOMMU anyway) will take a first dip into ZONE_NORMAL and get
+ * otherwise served by ZONE_DMA.
  */
-void __init limit_zone_pfn(enum zone_type zone, unsigned long pfn_limit)
-{
-	int i;
-
-	if (WARN_ON(zone_limits_final))
-		return;
-
-	for (i = zone; i >= 0; i--) {
-		if (max_zone_pfns[i] > pfn_limit)
-			max_zone_pfns[i] = pfn_limit;
-	}
-}
+static unsigned long max_zone_pfns[MAX_NR_ZONES];
 
 /*
  * Find the least restrictive zone that is entirely below the
@@ -324,11 +305,14 @@ void __init paging_init(void)
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (long int)((top_of_ram - total_ram) >> 20));
 
+#ifdef CONFIG_ZONE_DMA
+	max_zone_pfns[ZONE_DMA]	= min(max_low_pfn, 0x7fffffffUL >> PAGE_SHIFT);
+#endif
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
 #ifdef CONFIG_HIGHMEM
-	limit_zone_pfn(ZONE_NORMAL, lowmem_end_addr >> PAGE_SHIFT);
+	max_zone_pfns[ZONE_HIGHMEM] = max_pfn
 #endif
-	limit_zone_pfn(TOP_ZONE, top_of_ram >> PAGE_SHIFT);
-	zone_limits_final = true;
+
 	free_area_init_nodes(max_zone_pfns);
 
 	mark_nonram_nosave();
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index ac191a7a1337..b0dac307bebf 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -68,16 +68,6 @@ void __init corenet_gen_setup_arch(void)
 
 	swiotlb_detect_4g();
 
-#if defined(CONFIG_FSL_PCI) && defined(CONFIG_ZONE_DMA32)
-	/*
-	 * Inbound windows don't cover the full lower 4 GiB
-	 * due to conflicts with PCICSRBAR and outbound windows,
-	 * so limit the DMA32 zone to 2 GiB, to allow consistent
-	 * allocations to succeed.
-	 */
-	limit_zone_pfn(ZONE_DMA32, 1UL << (31 - PAGE_SHIFT));
-#endif
-
 	pr_info("%s board\n", ppc_md.name);
 
 	mpc85xx_qe_init();
diff --git a/arch/powerpc/platforms/85xx/qemu_e500.c b/arch/powerpc/platforms/85xx/qemu_e500.c
index b63a8548366f..27631c607f3d 100644
--- a/arch/powerpc/platforms/85xx/qemu_e500.c
+++ b/arch/powerpc/platforms/85xx/qemu_e500.c
@@ -45,15 +45,6 @@ static void __init qemu_e500_setup_arch(void)
 
 	fsl_pci_assign_primary();
 	swiotlb_detect_4g();
-#if defined(CONFIG_FSL_PCI) && defined(CONFIG_ZONE_DMA32)
-	/*
-	 * Inbound windows don't cover the full lower 4 GiB
-	 * due to conflicts with PCICSRBAR and outbound windows,
-	 * so limit the DMA32 zone to 2 GiB, to allow consistent
-	 * allocations to succeed.
-	 */
-	limit_zone_pfn(ZONE_DMA32, 1UL << (31 - PAGE_SHIFT));
-#endif
 	mpc85xx_smp_init();
 }
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1e22d96734e0..68970340df1c 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -312,7 +312,7 @@ enum zone_type {
 	 * Architecture		Limit
 	 * ---------------------------
 	 * parisc, ia64, sparc	<4G
-	 * s390			<2G
+	 * s390, powerpc	<2G
 	 * arm			Various
 	 * alpha		Unlimited or 0-16MB.
 	 *
-- 
2.19.0

