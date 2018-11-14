Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C90C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 08:44:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CCDA223DD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 08:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="puNjWpF7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CCDA223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vyj217VkzF3Cy
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 19:44:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="puNjWpF7";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=198.137.202.133;
 helo=bombadil.infradead.org;
 envelope-from=batv+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="puNjWpF7"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vyFN12PFzF3K6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 19:23:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q8shXA+ccAxgPpr+2652jWyzRdInsknrVFfhPeaPFlc=; b=puNjWpF7uPzrJ64htqV/7TvHFL
 slo3xM4iwU15fstg+Ywihl/Vc4O3GXQW9B+zDm2XKgDt0hbtIndsmtROjfbrIP8knJLOQRlVq3gQ1
 Cq541vbvybg8PekOFo8xMAzmqw9Mmn1qmUpiR4We5R1oPApfx/D2GplPJQSHZTifGn7QW/dLYMI3n
 nwhSNIFrOxT7DHlZWLe+hjTgMeTVWpBAE5cM4KjCZ5TWuwOEqjYWxBoqNcHqvMTogsznkdgLa1qcJ
 ebXc0MDkTLmYeUuPVK1VsW53aC3Yi7dXIwRUSGgmANtUdbx5D+9GiM3pSMivpDwqpaBNbiiKjC3Wq
 pOuIEC2A==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMqSQ-0004mj-0O; Wed, 14 Nov 2018 08:23:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 05/34] powerpc/dma: remove the unused dma_iommu_ops export
Date: Wed, 14 Nov 2018 09:22:45 +0100
Message-Id: <20181114082314.8965-6-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/dma-iommu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index f9fe2080ceb9..2ca6cfaebf65 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -6,7 +6,6 @@
  * busses using the iommu infrastructure
  */
 
-#include <linux/export.h>
 #include <asm/iommu.h>
 
 /*
@@ -123,4 +122,3 @@ struct dma_map_ops dma_iommu_ops = {
 	.get_required_mask	= dma_iommu_get_required_mask,
 	.mapping_error		= dma_iommu_mapping_error,
 };
-EXPORT_SYMBOL(dma_iommu_ops);
-- 
2.19.1

