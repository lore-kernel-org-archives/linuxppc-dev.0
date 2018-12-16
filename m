Return-Path: <SRS0=MdcX=OZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E70CC43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 17:27:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 166FB2086C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 17:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tYt0O+9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 166FB2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43HrnP5MsTzDqg1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 04:27:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="tYt0O+9J";
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
 header.b="tYt0O+9J"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43HrdP21CZzDqXD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 04:20:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7NfHrcTrKamX6OVvEc99aeCdxsvosy+YygIaxwJdZtk=; b=tYt0O+9J34w6qt3SO1qd1v4l13
 5w4Os2gO4VODrn6MVWlJj2QYL9XbFHLY5oHF5zUkGU9yY6XgwEycDo11PJYMJgWPYMujcQma2cvfS
 AfpJPjjmqF5OSutUwjP3UGQvuCAxSQnAIJlsDSfWzMGMMQJsrJRfLOJ1jn86L0CnhkgDsgCAyusLl
 lecbvkle25oai8qUDLAB6RZvGVntdLllKT5Gq3dDFw5/PldJPqLq5d2tjzoazMIDtATvMC0fqRH/R
 upPGqV+d9aJuR2MARIY7Rr2KompHEIMcS+pREHmvA0OBBRmhgmqhrTrVCUW9HJgi5+oAdnuhH0iSw
 5Ls9xPkQ==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYa58-0004Pw-Bv; Sun, 16 Dec 2018 17:19:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/8] powerpc/dma: properly wire up the unmap_page and unmap_sg
 methods
Date: Sun, 16 Dec 2018 18:19:45 +0100
Message-Id: <20181216171951.31306-3-hch@lst.de>
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

The unmap methods need to transfer memory ownership back from the device
to the cpu by identical means as dma_sync_*_to_cpu.  I'm not sure powerpc
needs to do any work in this transfer direction, but given that it does
invalidate the caches in dma_sync_*_to_cpu already we should make sure
we also do so on unmapping.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/dma.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index dbfc7056d7df..d442d23e182b 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -210,10 +210,15 @@ static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sg,
+static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
 				int nents, enum dma_data_direction direction,
 				unsigned long attrs)
 {
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 }
 
 static u64 dma_nommu_get_required_mask(struct device *dev)
@@ -247,6 +252,8 @@ static inline void dma_nommu_unmap_page(struct device *dev,
 					 enum dma_data_direction direction,
 					 unsigned long attrs)
 {
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		__dma_sync(bus_to_virt(dma_address), size, dir);
 }
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
-- 
2.19.2

