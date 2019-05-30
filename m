Return-Path: <SRS0=Y6lA=T6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6969C072B1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 07:07:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 902912490C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 07:07:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 902912490C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45DzCq6vSpzDqRm
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 May 2019 17:07:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 45Dz8P5n8jzDqT9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2019 17:04:05 +1000 (AEST)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id BAD7CAE80054;
 Thu, 30 May 2019 03:04:02 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v3 1/3] powerpc/iommu: Allow bypass-only for DMA
Date: Thu, 30 May 2019 17:03:53 +1000
Message-Id: <20190530070355.121802-2-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190530070355.121802-1-aik@ozlabs.ru>
References: <20190530070355.121802-1-aik@ozlabs.ru>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alistair Popple <alistair@popple.id.au>, Oliver O'Halloran <oohall@gmail.com>,
 Sam Bobroff <sbobroff@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

POWER8 and newer support a bypass mode which maps all host memory to
PCI buses so an IOMMU table is not always required. However if we fail to
create such a table, the DMA setup fails and the kernel does not boot.

This skips the 32bit DMA setup check if the bypass is can be selected.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This minor thing helped me debugging next 2 patches so it can help
somebody else too.
---
 arch/powerpc/kernel/dma-iommu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 09231ef06d01..809c1dc01edf 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -118,18 +118,17 @@ int dma_iommu_dma_supported(struct device *dev, u64 mask)
 {
 	struct iommu_table *tbl = get_iommu_table_base(dev);
 
-	if (!tbl) {
-		dev_info(dev, "Warning: IOMMU dma not supported: mask 0x%08llx"
-			", table unavailable\n", mask);
-		return 0;
-	}
-
 	if (dev_is_pci(dev) && dma_iommu_bypass_supported(dev, mask)) {
 		dev->archdata.iommu_bypass = true;
 		dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
 		return 1;
 	}
 
+	if (!tbl) {
+		dev_err(dev, "Warning: IOMMU dma not supported: mask 0x%08llx, table unavailable\n", mask);
+		return 0;
+	}
+
 	if (tbl->it_offset > (mask >> tbl->it_page_shift)) {
 		dev_info(dev, "Warning: IOMMU offset too big for device mask\n");
 		dev_info(dev, "mask: 0x%08llx, table offset: 0x%08lx\n",
-- 
2.17.1

