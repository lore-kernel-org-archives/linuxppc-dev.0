Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C2FC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 07:00:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D15F2087F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 07:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D15F2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43YjnC0C0FzDqQf
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 17:59:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Yjjd0XTDzDqNN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 17:56:51 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43YjjV1GqLz9v2g7;
 Tue,  8 Jan 2019 07:56:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id UPAcuR7dcLCv; Tue,  8 Jan 2019 07:56:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43YjjV0l5YzB09Zh;
 Tue,  8 Jan 2019 07:56:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ECD0B8B791;
 Tue,  8 Jan 2019 07:56:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id PXTZ2k2jivoZ; Tue,  8 Jan 2019 07:56:46 +0100 (CET)
Received: from PO15451.localdomain (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id BD8558B754;
 Tue,  8 Jan 2019 07:56:46 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 7CCEB717D8; Tue,  8 Jan 2019 06:56:46 +0000 (UTC)
Message-Id: <5ed91db5e2976a4c260465c3d027acc9affd2d2b.1545445924.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 1/2] crypto: talitos - reorder code in talitos_edesc_alloc()
To: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Horia Geanta <horia.geanta@nxp.com>
Date: Tue,  8 Jan 2019 06:56:46 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This patch moves the mapping of IV after the kmalloc(). This
avoids having to unmap in case kmalloc() fails.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 new in v4

 drivers/crypto/talitos.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 45e20707cef8..54d80e7edb86 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -1361,23 +1361,18 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
 	struct talitos_private *priv = dev_get_drvdata(dev);
 	bool is_sec1 = has_ftr_sec1(priv);
 	int max_len = is_sec1 ? TALITOS1_MAX_DATA_LEN : TALITOS2_MAX_DATA_LEN;
-	void *err;
 
 	if (cryptlen + authsize > max_len) {
 		dev_err(dev, "length exceeds h/w max limit\n");
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (ivsize)
-		iv_dma = dma_map_single(dev, iv, ivsize, DMA_TO_DEVICE);
-
 	if (!dst || dst == src) {
 		src_len = assoclen + cryptlen + authsize;
 		src_nents = sg_nents_for_len(src, src_len);
 		if (src_nents < 0) {
 			dev_err(dev, "Invalid number of src SG.\n");
-			err = ERR_PTR(-EINVAL);
-			goto error_sg;
+			return ERR_PTR(-EINVAL);
 		}
 		src_nents = (src_nents == 1) ? 0 : src_nents;
 		dst_nents = dst ? src_nents : 0;
@@ -1387,16 +1382,14 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
 		src_nents = sg_nents_for_len(src, src_len);
 		if (src_nents < 0) {
 			dev_err(dev, "Invalid number of src SG.\n");
-			err = ERR_PTR(-EINVAL);
-			goto error_sg;
+			return ERR_PTR(-EINVAL);
 		}
 		src_nents = (src_nents == 1) ? 0 : src_nents;
 		dst_len = assoclen + cryptlen + (encrypt ? authsize : 0);
 		dst_nents = sg_nents_for_len(dst, dst_len);
 		if (dst_nents < 0) {
 			dev_err(dev, "Invalid number of dst SG.\n");
-			err = ERR_PTR(-EINVAL);
-			goto error_sg;
+			return ERR_PTR(-EINVAL);
 		}
 		dst_nents = (dst_nents == 1) ? 0 : dst_nents;
 	}
@@ -1425,10 +1418,10 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
 		alloc_len += sizeof(struct talitos_desc);
 
 	edesc = kmalloc(alloc_len, GFP_DMA | flags);
-	if (!edesc) {
-		err = ERR_PTR(-ENOMEM);
-		goto error_sg;
-	}
+	if (!edesc)
+		return ERR_PTR(-ENOMEM);
+	if (ivsize)
+		iv_dma = dma_map_single(dev, iv, ivsize, DMA_TO_DEVICE);
 	memset(&edesc->desc, 0, sizeof(edesc->desc));
 
 	edesc->src_nents = src_nents;
@@ -1445,10 +1438,6 @@ static struct talitos_edesc *talitos_edesc_alloc(struct device *dev,
 						     DMA_BIDIRECTIONAL);
 	}
 	return edesc;
-error_sg:
-	if (iv_dma)
-		dma_unmap_single(dev, iv_dma, ivsize, DMA_TO_DEVICE);
-	return err;
 }
 
 static struct talitos_edesc *aead_edesc_alloc(struct aead_request *areq, u8 *iv,
-- 
2.13.3

