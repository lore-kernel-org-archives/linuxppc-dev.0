Return-Path: <SRS0=O7I3=MJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55934C43382
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 23:16:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0C3216C4
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Sep 2018 23:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dJ1u5Li0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0C3216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42LrJy1KfmzF39F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Sep 2018 09:16:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="dJ1u5Li0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+52436e8290dcef712379+5513+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="dJ1u5Li0"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LrCj3DMyzF39P
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 09:11:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zFnABaVYDvLyfzf8K/udk4n4/CG7WFWPFCUf6/Knavs=; b=dJ1u5Li0n0szZwAdJP1KDsbM0H
 SzJH7bk49GmllRdnAgmyjgLWtqjcne7m8zBM+d59AVatQX1EEys3jtWq2DYLbtJoSWGsDoRDCNBe3
 eLwiAe5On3Qp9I0GSJd12yNHsi19tjjqZjcJKxli01vIiEmvS0eD4eQm2fb2+s0XJjMUBqJe9Eut+
 we7dxIyWROp34aEOOc6BVtrJOcQ9NGw7AqlUgNpLYC5hoc0jHbGjBUeGAkJRiADPexBx6zhmGDYMI
 8EnBzQH6aSeL2KjDQ2F9mh5rXXozqHa/19g+YhGZzq7g3uh60cajk9HvcKR1adSOWBo5/Cflcw5pt
 H+7Q8w1w==;
Received: from [199.255.44.5] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5etH-0002kr-Ci; Thu, 27 Sep 2018 22:36:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Subject: [PATCH 1/5] dma-mapping: make the get_required_mask method available
 unconditionally
Date: Thu, 27 Sep 2018 15:35:35 -0700
Message-Id: <20180927223539.28449-2-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927223539.28449-1-hch@lst.de>
References: <20180927223539.28449-1-hch@lst.de>
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
Cc: Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linuxppc-dev@lists.ozlabs.org,
 Marek Szyprowski <m.szyprowski@samsung.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This save some duplication for ia64, and makes the interface more
general.  In the long run we want each dma_map_ops instance to fill this
out, but this will take a little more prep work.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org> [powerpc bits]
---
 arch/ia64/include/asm/dma-mapping.h  |  2 --
 arch/ia64/include/asm/machvec.h      |  7 -------
 arch/ia64/include/asm/machvec_init.h |  1 -
 arch/ia64/include/asm/machvec_sn2.h  |  2 --
 arch/ia64/pci/pci.c                  | 26 --------------------------
 arch/ia64/sn/pci/pci_dma.c           |  4 ++--
 drivers/base/platform.c              | 13 +++++++++++--
 drivers/pci/controller/vmd.c         |  4 ----
 include/linux/dma-mapping.h          |  2 --
 9 files changed, 13 insertions(+), 48 deletions(-)

diff --git a/arch/ia64/include/asm/dma-mapping.h b/arch/ia64/include/asm/dma-mapping.h
index 76e4d6632d68..522745ae67bb 100644
--- a/arch/ia64/include/asm/dma-mapping.h
+++ b/arch/ia64/include/asm/dma-mapping.h
@@ -10,8 +10,6 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
 
-#define ARCH_HAS_DMA_GET_REQUIRED_MASK
-
 extern const struct dma_map_ops *dma_ops;
 extern struct ia64_machine_vector ia64_mv;
 extern void set_iommu_machvec(void);
diff --git a/arch/ia64/include/asm/machvec.h b/arch/ia64/include/asm/machvec.h
index 267f4f170191..5133739966bc 100644
--- a/arch/ia64/include/asm/machvec.h
+++ b/arch/ia64/include/asm/machvec.h
@@ -44,7 +44,6 @@ typedef void ia64_mv_kernel_launch_event_t(void);
 
 /* DMA-mapping interface: */
 typedef void ia64_mv_dma_init (void);
-typedef u64 ia64_mv_dma_get_required_mask (struct device *);
 typedef const struct dma_map_ops *ia64_mv_dma_get_ops(struct device *);
 
 /*
@@ -127,7 +126,6 @@ extern void machvec_tlb_migrate_finish (struct mm_struct *);
 #  define platform_global_tlb_purge	ia64_mv.global_tlb_purge
 #  define platform_tlb_migrate_finish	ia64_mv.tlb_migrate_finish
 #  define platform_dma_init		ia64_mv.dma_init
-#  define platform_dma_get_required_mask ia64_mv.dma_get_required_mask
 #  define platform_dma_get_ops		ia64_mv.dma_get_ops
 #  define platform_irq_to_vector	ia64_mv.irq_to_vector
 #  define platform_local_vector_to_irq	ia64_mv.local_vector_to_irq
@@ -171,7 +169,6 @@ struct ia64_machine_vector {
 	ia64_mv_global_tlb_purge_t *global_tlb_purge;
 	ia64_mv_tlb_migrate_finish_t *tlb_migrate_finish;
 	ia64_mv_dma_init *dma_init;
-	ia64_mv_dma_get_required_mask *dma_get_required_mask;
 	ia64_mv_dma_get_ops *dma_get_ops;
 	ia64_mv_irq_to_vector *irq_to_vector;
 	ia64_mv_local_vector_to_irq *local_vector_to_irq;
@@ -211,7 +208,6 @@ struct ia64_machine_vector {
 	platform_global_tlb_purge,		\
 	platform_tlb_migrate_finish,		\
 	platform_dma_init,			\
-	platform_dma_get_required_mask,		\
 	platform_dma_get_ops,			\
 	platform_irq_to_vector,			\
 	platform_local_vector_to_irq,		\
@@ -286,9 +282,6 @@ extern const struct dma_map_ops *dma_get_ops(struct device *);
 #ifndef platform_dma_get_ops
 # define platform_dma_get_ops		dma_get_ops
 #endif
-#ifndef platform_dma_get_required_mask
-# define  platform_dma_get_required_mask	ia64_dma_get_required_mask
-#endif
 #ifndef platform_irq_to_vector
 # define platform_irq_to_vector		__ia64_irq_to_vector
 #endif
diff --git a/arch/ia64/include/asm/machvec_init.h b/arch/ia64/include/asm/machvec_init.h
index 2b32fd06b7c6..2aafb69a3787 100644
--- a/arch/ia64/include/asm/machvec_init.h
+++ b/arch/ia64/include/asm/machvec_init.h
@@ -4,7 +4,6 @@
 
 extern ia64_mv_send_ipi_t ia64_send_ipi;
 extern ia64_mv_global_tlb_purge_t ia64_global_tlb_purge;
-extern ia64_mv_dma_get_required_mask ia64_dma_get_required_mask;
 extern ia64_mv_irq_to_vector __ia64_irq_to_vector;
 extern ia64_mv_local_vector_to_irq __ia64_local_vector_to_irq;
 extern ia64_mv_pci_get_legacy_mem_t ia64_pci_get_legacy_mem;
diff --git a/arch/ia64/include/asm/machvec_sn2.h b/arch/ia64/include/asm/machvec_sn2.h
index ece9fa85be88..b5153d300289 100644
--- a/arch/ia64/include/asm/machvec_sn2.h
+++ b/arch/ia64/include/asm/machvec_sn2.h
@@ -55,7 +55,6 @@ extern ia64_mv_readb_t __sn_readb_relaxed;
 extern ia64_mv_readw_t __sn_readw_relaxed;
 extern ia64_mv_readl_t __sn_readl_relaxed;
 extern ia64_mv_readq_t __sn_readq_relaxed;
-extern ia64_mv_dma_get_required_mask	sn_dma_get_required_mask;
 extern ia64_mv_dma_init			sn_dma_init;
 extern ia64_mv_migrate_t		sn_migrate;
 extern ia64_mv_kernel_launch_event_t	sn_kernel_launch_event;
@@ -100,7 +99,6 @@ extern ia64_mv_pci_fixup_bus_t		sn_pci_fixup_bus;
 #define platform_pci_get_legacy_mem	sn_pci_get_legacy_mem
 #define platform_pci_legacy_read	sn_pci_legacy_read
 #define platform_pci_legacy_write	sn_pci_legacy_write
-#define platform_dma_get_required_mask	sn_dma_get_required_mask
 #define platform_dma_init		sn_dma_init
 #define platform_migrate		sn_migrate
 #define platform_kernel_launch_event    sn_kernel_launch_event
diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
index 7ccc64d5fe3e..5d71800df431 100644
--- a/arch/ia64/pci/pci.c
+++ b/arch/ia64/pci/pci.c
@@ -568,32 +568,6 @@ static void __init set_pci_dfl_cacheline_size(void)
 	pci_dfl_cache_line_size = (1 << cci.pcci_line_size) / 4;
 }
 
-u64 ia64_dma_get_required_mask(struct device *dev)
-{
-	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
-	u32 high_totalram = ((max_pfn - 1) >> (32 - PAGE_SHIFT));
-	u64 mask;
-
-	if (!high_totalram) {
-		/* convert to mask just covering totalram */
-		low_totalram = (1 << (fls(low_totalram) - 1));
-		low_totalram += low_totalram - 1;
-		mask = low_totalram;
-	} else {
-		high_totalram = (1 << (fls(high_totalram) - 1));
-		high_totalram += high_totalram - 1;
-		mask = (((u64)high_totalram) << 32) + 0xffffffff;
-	}
-	return mask;
-}
-EXPORT_SYMBOL_GPL(ia64_dma_get_required_mask);
-
-u64 dma_get_required_mask(struct device *dev)
-{
-	return platform_dma_get_required_mask(dev);
-}
-EXPORT_SYMBOL_GPL(dma_get_required_mask);
-
 static int __init pcibios_init(void)
 {
 	set_pci_dfl_cacheline_size();
diff --git a/arch/ia64/sn/pci/pci_dma.c b/arch/ia64/sn/pci/pci_dma.c
index 74c934a997bb..96eb2567718a 100644
--- a/arch/ia64/sn/pci/pci_dma.c
+++ b/arch/ia64/sn/pci/pci_dma.c
@@ -344,11 +344,10 @@ static int sn_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 	return 0;
 }
 
-u64 sn_dma_get_required_mask(struct device *dev)
+static u64 sn_dma_get_required_mask(struct device *dev)
 {
 	return DMA_BIT_MASK(64);
 }
-EXPORT_SYMBOL_GPL(sn_dma_get_required_mask);
 
 char *sn_pci_get_legacy_mem(struct pci_bus *bus)
 {
@@ -473,6 +472,7 @@ static struct dma_map_ops sn_dma_ops = {
 	.sync_sg_for_device	= sn_dma_sync_sg_for_device,
 	.mapping_error		= sn_dma_mapping_error,
 	.dma_supported		= sn_dma_supported,
+	.get_required_mask	= sn_dma_get_required_mask,
 };
 
 void sn_dma_init(void)
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dff82a3c2caa..cfe22fded980 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1179,8 +1179,7 @@ int __init platform_bus_init(void)
 	return error;
 }
 
-#ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
-u64 dma_get_required_mask(struct device *dev)
+static u64 dma_default_get_required_mask(struct device *dev)
 {
 	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
 	u32 high_totalram = ((max_pfn - 1) >> (32 - PAGE_SHIFT));
@@ -1198,6 +1197,16 @@ u64 dma_get_required_mask(struct device *dev)
 	}
 	return mask;
 }
+
+#ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
+u64 dma_get_required_mask(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (ops->get_required_mask)
+		return ops->get_required_mask(dev);
+	return dma_default_get_required_mask(dev);
+}
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 #endif
 
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index fd2dbd7eed7b..f31ed62d518c 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -404,12 +404,10 @@ static int vmd_dma_supported(struct device *dev, u64 mask)
 	return vmd_dma_ops(dev)->dma_supported(to_vmd_dev(dev), mask);
 }
 
-#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 static u64 vmd_get_required_mask(struct device *dev)
 {
 	return vmd_dma_ops(dev)->get_required_mask(to_vmd_dev(dev));
 }
-#endif
 
 static void vmd_teardown_dma_ops(struct vmd_dev *vmd)
 {
@@ -450,9 +448,7 @@ static void vmd_setup_dma_ops(struct vmd_dev *vmd)
 	ASSIGN_VMD_DMA_OPS(source, dest, sync_sg_for_device);
 	ASSIGN_VMD_DMA_OPS(source, dest, mapping_error);
 	ASSIGN_VMD_DMA_OPS(source, dest, dma_supported);
-#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 	ASSIGN_VMD_DMA_OPS(source, dest, get_required_mask);
-#endif
 	add_dma_domain(domain);
 }
 #undef ASSIGN_VMD_DMA_OPS
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index d23fc45c8208..562af6b45f23 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -130,9 +130,7 @@ struct dma_map_ops {
 			enum dma_data_direction direction);
 	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
 	int (*dma_supported)(struct device *dev, u64 mask);
-#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 	u64 (*get_required_mask)(struct device *dev);
-#endif
 };
 
 extern const struct dma_map_ops dma_direct_ops;
-- 
2.19.0

