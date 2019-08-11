Return-Path: <SRS0=y8Rr=WH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB91C433FF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Aug 2019 08:14:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2798208C2
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Aug 2019 08:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rx2STIca"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2798208C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 465sFz3tXYzDqTs
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Aug 2019 18:14:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+ae155d32c5e98ef18dee+5831+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="rx2STIca"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 465s466J5XzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Aug 2019 18:05:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/qPzNIpevvN/qwi+1IcOX2emVd7L7tcHzjYkoXjMmbs=; b=rx2STIcad83YqjkOlc8pS3EKFK
 tm5EQbOmD/zVesaB2Yrka4WpJlP1wkoqY2lwbZhzszanIlrNAV4QTyV8TCOF9F3eI3zuLrIJd1Zkz
 /6Qz6H0Uu+YmAp0zzbW9uv0aN73hwVJ4eagsQzRMNy+wzoMs2+vf0kHt/V80B+ZW/AG3/htUUV1KM
 3LsUroqS4mhIvTAjCxTfIBA/5IwbT+2Jq4jOGvfRcgkAsYpujmAHbQNcQxfqKUure4D6FDtoCq9+k
 thu7CtXONgfv8pgEAme12GQ8RHhMiE8QEIZeEdrfspL7BjvQUUI7VGUabnM6ngSB7IYK8iw/PwVYb
 0AgEyMFg==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1hwirF-0001yq-Iw; Sun, 11 Aug 2019 08:05:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH 5/6] dma-mapping: remove is_device_dma_capable
Date: Sun, 11 Aug 2019 10:05:19 +0200
Message-Id: <20190811080520.21712-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190811080520.21712-1-hch@lst.de>
References: <20190811080520.21712-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, Olav Kongas <ok@artecdesign.ee>,
 Gavin Li <git@thegavinli.com>, linuxppc-dev@lists.ozlabs.org,
 Mathias Nyman <mathias.nyman@intel.com>, Geoff Levand <geoff@infradead.org>,
 Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 linux-usb@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
 linux-kernel@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>,
 iommu@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Minas Harutyunyan <hminas@synopsys.com>, Shawn Guo <shawnguo@kernel.org>,
 Bin Liu <b-liu@ti.com>, linux-arm-kernel@lists.infradead.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

No users left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-mapping.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f7d1eea32c78..14702e2d6fa8 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -149,11 +149,6 @@ static inline int valid_dma_direction(int dma_direction)
 		(dma_direction == DMA_FROM_DEVICE));
 }
 
-static inline int is_device_dma_capable(struct device *dev)
-{
-	return dev->dma_mask != NULL && *dev->dma_mask != DMA_MASK_NONE;
-}
-
 #ifdef CONFIG_DMA_DECLARE_COHERENT
 /*
  * These three functions are only for dma allocator.
-- 
2.20.1

