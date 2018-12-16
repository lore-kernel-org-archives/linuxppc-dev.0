Return-Path: <SRS0=MdcX=OZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2435EC43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 17:34:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F4C32082F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 17:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c01YZ4dQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F4C32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Hry72HnnzDqc6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 04:34:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="c01YZ4dQ";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+e42ca9829499f781535b+5593+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="c01YZ4dQ"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43HrdY1d5QzDqXN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 04:20:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ikox8B/qV0jqtqMp2ODObDvK+gHzlX0IPEMB39mT4qA=; b=c01YZ4dQQ9J3TPqks6WYDe7PWG
 A2FFptIdJIopNGj5KMkZknJOzPxEesOI1gkRIC6Chrmz80PmFGh9/7wIpFJcUpsdQAHHUACZWymge
 R15CcAUGwy6aHw05sbTHId6y7+EjZUsBqGT4WLrGqCwVjx5B/VVLifrzHczTX7ODa097YXp2wNMOk
 DXQfCTjbyjkGbj6qvd3caAG6LzfscWY5qknix5d8Ipj8MwloDNyvPGJr5NUcskuABrhI6VQ9WBYC+
 AeI41ALwbxTiexLdJosVeFwqmibpTpWHa0Xf4B1wa26joXxrtI4yzot6K40/lzJwGQeEh3Uvtrq9a
 rir2NhEw==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYa5I-0005Dq-Nw; Sun, 16 Dec 2018 17:20:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 6/8] powerpc/dma: remove the unused dma_iommu_ops export
Date: Sun, 16 Dec 2018 18:19:49 +0100
Message-Id: <20181216171951.31306-7-hch@lst.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181216171951.31306-1-hch@lst.de>
References: <20181216171951.31306-1-hch@lst.de>
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
Cc: linuxppc-dev@lists.ozlabs.org, Christian Lamparter <chunkeey@gmail.com>
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
2.19.2

