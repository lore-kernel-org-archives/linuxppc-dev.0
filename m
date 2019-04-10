Return-Path: <SRS0=mr1i=SM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46199C10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:50:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF232083E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 06:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF232083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44fFCy475vzDqHF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Apr 2019 16:50:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 44fF9c40JXzDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2019 16:48:36 +1000 (AEST)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 9AA67AE8000A;
 Wed, 10 Apr 2019 02:48:03 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] powerpc/powernv/ioda: Handle failures correctly in
 pnv_pci_ioda_iommu_bypass_supported
Date: Wed, 10 Apr 2019 16:48:00 +1000
Message-Id: <20190410064800.82221-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When the return value type was changed from int to bool, few places were
left unchanged, this fixes them. We did not hit these failures as
the first one is not happening at all and the second one is little more
likely to happen if the user switches a 33..58bit DMA capable device
between the VFIO and vendor drivers and there are not so many of these.

Fixes: 2d6ad41b2c21 ("powerpc/powernv: use the generic iommu bypass code", 2019-02-13)
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 0565d8b8b33d..dcfb5469678e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1836,7 +1836,7 @@ static bool pnv_pci_ioda_iommu_bypass_supported(struct pci_dev *pdev,
 	struct pnv_ioda_pe *pe;
 
 	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
-		return -ENODEV;
+		return false;
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	if (pe->tce_bypass_enabled) {
@@ -1859,7 +1859,7 @@ static bool pnv_pci_ioda_iommu_bypass_supported(struct pci_dev *pdev,
 		/* Configure the bypass mode */
 		s64 rc = pnv_pci_ioda_dma_64bit_bypass(pe);
 		if (rc)
-			return rc;
+			return false;
 		/* 4GB offset bypasses 32-bit space */
 		pdev->dev.archdata.dma_offset = (1ULL << 32);
 		return true;
-- 
2.17.1

