Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304FAC64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:18:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F5620C0A
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i9L1kOia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F5620C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tzpz2cjgzF3FC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 01:18:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="i9L1kOia";
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
 header.b="i9L1kOia"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tyfx6XdtzF38h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:26:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z1NpYAlNjtOl6wtV5jUw9RPikGAiju1XuiWRoBAFPXo=; b=i9L1kOiaNfNO/7tZVTeWRXi2kz
 I0a1agaNzMsnb522ajukDtVwUPc2LpL27ozdBJ9e5zSvgje4+azhFCnTPzq6vLxMZgdUN7m52NRQp
 EDpw5ZUT7Z6yCVZGESJ9dPHF1jbJHlO9WSTQSey4XLseB6F6FlZJQWvgyRddKIuQClZPLZaNk4FOF
 DpOYFj/AJjdwhKFwLk/V+ZH1Bfk29QjQK6S+yhwnLgxpjmgUsSfD0VcnXjNcoXyaxA0AhNvUvVSZv
 Qtx828RuRHH8+AZ8OyeY+W+Zhpa2Z4MghUPWbV0g6EmjVD3KbNucebmbE/xEt5rGEp/L/XGWFa9QD
 cVc3bl+Q==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s1R-0001Q3-5q; Tue, 09 Oct 2018 13:26:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 23/33] powerpc/dma: remove max_direct_dma_addr
Date: Tue,  9 Oct 2018 15:24:50 +0200
Message-Id: <20181009132500.17643-24-hch@lst.de>
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

The max_direct_dma_addr duplicates the bus_dma_mask field in struct
device.  Use the generic field instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/device.h     |  3 ---
 arch/powerpc/include/asm/dma-direct.h |  4 +---
 arch/powerpc/kernel/dma-swiotlb.c     | 20 --------------------
 arch/powerpc/kernel/dma.c             |  5 ++---
 arch/powerpc/sysdev/fsl_pci.c         |  3 +--
 5 files changed, 4 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 3814e1c2d4bc..a130be13ee83 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -38,9 +38,6 @@ struct dev_archdata {
 #ifdef CONFIG_IOMMU_API
 	void			*iommu_domain;
 #endif
-#ifdef CONFIG_SWIOTLB
-	dma_addr_t		max_direct_dma_addr;
-#endif
 #ifdef CONFIG_PPC64
 	struct pci_dn		*pci_data;
 #endif
diff --git a/arch/powerpc/include/asm/dma-direct.h b/arch/powerpc/include/asm/dma-direct.h
index 7702875aabb7..e00ab5d0612d 100644
--- a/arch/powerpc/include/asm/dma-direct.h
+++ b/arch/powerpc/include/asm/dma-direct.h
@@ -5,9 +5,7 @@
 static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 {
 #ifdef CONFIG_SWIOTLB
-	struct dev_archdata *sd = &dev->archdata;
-
-	if (sd->max_direct_dma_addr && addr + size > sd->max_direct_dma_addr)
+	if (dev->bus_dma_mask && addr + size > dev->bus_dma_mask)
 		return false;
 #endif
 
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 60cb86338233..e05d95ff50ad 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -24,21 +24,6 @@
 
 unsigned int ppc_swiotlb_enable;
 
-static u64 swiotlb_powerpc_get_required(struct device *dev)
-{
-	u64 end, mask, max_direct_dma_addr = dev->archdata.max_direct_dma_addr;
-
-	end = memblock_end_of_DRAM();
-	if (max_direct_dma_addr && end > max_direct_dma_addr)
-		end = max_direct_dma_addr;
-	end += get_dma_offset(dev);
-
-	mask = 1ULL << (fls64(end) - 1);
-	mask += mask - 1;
-
-	return mask;
-}
-
 /*
  * At the moment, all platforms that use this code only require
  * swiotlb to be used if we're operating on HIGHMEM.  Since
@@ -60,22 +45,17 @@ const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = swiotlb_sync_sg_for_device,
 	.mapping_error = swiotlb_dma_mapping_error,
-	.get_required_mask = swiotlb_powerpc_get_required,
 };
 
 static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
 				  unsigned long action, void *data)
 {
 	struct device *dev = data;
-	struct dev_archdata *sd;
 
 	/* We are only intereted in device addition */
 	if (action != BUS_NOTIFY_ADD_DEVICE)
 		return 0;
 
-	sd = &dev->archdata;
-	sd->max_direct_dma_addr = 0;
-
 	/* May need to bounce if the device can't address all of DRAM */
 	if ((dma_get_mask(dev) + 1) < memblock_end_of_DRAM())
 		set_dma_ops(dev, &powerpc_swiotlb_dma_ops);
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index bef91b8ad064..e3d2c15b209c 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -30,11 +30,10 @@
 static u64 __maybe_unused get_pfn_limit(struct device *dev)
 {
 	u64 pfn = (dev->coherent_dma_mask >> PAGE_SHIFT) + 1;
-	struct dev_archdata __maybe_unused *sd = &dev->archdata;
 
 #ifdef CONFIG_SWIOTLB
-	if (sd->max_direct_dma_addr && dev->dma_ops == &powerpc_swiotlb_dma_ops)
-		pfn = min_t(u64, pfn, sd->max_direct_dma_addr >> PAGE_SHIFT);
+	if (dev->bus_dma_mask && dev->dma_ops == &powerpc_swiotlb_dma_ops)
+		pfn = min_t(u64, pfn, dev->bus_dma_mask >> PAGE_SHIFT);
 #endif
 
 	return pfn;
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 561f97d698cc..f136567a5ed5 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -117,9 +117,8 @@ static u64 pci64_dma_offset;
 static void pci_dma_dev_setup_swiotlb(struct pci_dev *pdev)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
-	struct dev_archdata *sd = &pdev->dev.archdata;
 
-	sd->max_direct_dma_addr =
+	pdev->dev.bus_dma_mask =
 		hose->dma_window_base_cur + hose->dma_window_size;
 }
 
-- 
2.19.0

