Return-Path: <SRS0=MdcX=OZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651E4C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 17:29:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBEB32082F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 16 Dec 2018 17:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FqZFg5qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEB32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Hrr600SbzDqZw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 04:29:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="FqZFg5qc";
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
 header.b="FqZFg5qc"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43HrdR45QGzDqXV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 04:20:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=izWtQPid72v7icKFIcnh3qQMTApd7mqNFwC2JDMB29M=; b=FqZFg5qcZr+jqm/7+h17WN376f
 t2OfE0WsPqc/uiEvifAm6nAIE4U3htg3hmaAFJEAft3LAt+OlP9B9u/avK3Gy2/4ftcaM3AituhxK
 Xi0H7JB2w/eLAi4wCmwVA7crPjDlBeMk+dwZ4Ox7Y1qQLGzfHmpnDpf8ANqEkI7W6p9Yc82sZyj9c
 TidWVVcjDZ/hQXU/Z+EzP1Pp5ywO+Fu4fDIHczz7JgMxcKDMemo4XP3RajDd6YAGxlddXo9ZQ/Sm0
 04zoUKNEtFm+xTE7YITUzzbLkFG9gjj0ou+canlEAM78hMmkJ4hW0Bx8EHeF7VJtxlDfj9V+JhRRz
 IIYRj/0Q==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYa5A-0004Q3-Un; Sun, 16 Dec 2018 17:20:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 3/8] crypto4xx_core: don't abuse __dma_sync_page
Date: Sun, 16 Dec 2018 18:19:46 +0100
Message-Id: <20181216171951.31306-4-hch@lst.de>
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

This function is internal to the DMA API implementation.  Instead use the
DMA API to properly unmap.  Note that the DMA API usage in this driver
is a disaster and urgently needs some work - it is missing all the unmaps,
seems to do a secondary map where it looks like it should to a unmap
in one place to work around cache coherency and the directions passed in
seem to be partially wrong.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/crypto/amcc/crypto4xx_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/amcc/crypto4xx_core.c b/drivers/crypto/amcc/crypto4xx_core.c
index 6eaec9ba0f68..63cb6956c948 100644
--- a/drivers/crypto/amcc/crypto4xx_core.c
+++ b/drivers/crypto/amcc/crypto4xx_core.c
@@ -596,7 +596,7 @@ static void crypto4xx_aead_done(struct crypto4xx_device *dev,
 					  pd->pd_ctl_len.bf.pkt_len,
 					  dst);
 	} else {
-		__dma_sync_page(sg_page(dst), dst->offset, dst->length,
+		dma_unmap_page(dev->core_dev->device, pd->dest, dst->length,
 				DMA_FROM_DEVICE);
 	}
 
-- 
2.19.2

