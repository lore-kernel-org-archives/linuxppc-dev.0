Return-Path: <SRS0=EJr+=UW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E49AC43613
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Jun 2019 21:16:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A2D6206BA
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Jun 2019 21:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4TzRs1n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A2D6206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45X4wM4Nd3zDqVS
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Jun 2019 07:16:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::141; helo=mail-lf1-x141.google.com;
 envelope-from=gomonovych@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="s4TzRs1n"; 
 dkim-atps=neutral
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com
 [IPv6:2a00:1450:4864:20::141])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45X4tK5j77zDqSW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2019 07:14:14 +1000 (AEST)
Received: by mail-lf1-x141.google.com with SMTP id x144so1077538lfa.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Jun 2019 14:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Yq63nB88Kgkj8Q6RKzRC9VHnoDiMRzczFesixFyv9aw=;
 b=s4TzRs1nTzkzrMcWtFZ3xWAgpRp8NZlYmTogZDQch1tH4ZZYGHZ3xznV4Um52YoULL
 q12TeJGt+aWvmGRarMDv34znE4V3Of5l/vqRHmKe6dxgdSM2gDKVwjBF/rVh82alyRYN
 ZO0iwCyrQ9U8OKzbwPQiK8zNvSThjIm8Xu9SS3VCt0UX7w4wEAYVzx+0I57VLFwQUjDC
 lMOMlc0QgdTrd4t0N6gG3w4RtoqUPgXUdwBSXl6ZYFqYch8kW5+/9TVSt6/zZm1Yn6YL
 tLmTrui9lFL3PxOP5+2/QtXFUjQciuEkaFSrnRBkIMxNcvcFfuMSg6s7I5Z+YTaB+unt
 dy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Yq63nB88Kgkj8Q6RKzRC9VHnoDiMRzczFesixFyv9aw=;
 b=n6mlhKhYGxuD4GknqBDyxtXshLoQ+JHdMzIK2BnUUAf4N+b26aKbZGyrKZtgqZfMLa
 TX5nta3ijszH0re9Hj22CWQYoXY49zdVPJ+qmEwCAcVL6xW7kvmKxUA5/sJRVT3oV3o1
 u6y4fzwi/7oWkAd7Rie8N89lE0X7Jqs/AuJ8BdTrKWzah80WgbIYE4Da0Zfy8+HCmI5A
 ks8VUYbDo4Zsz3J4fhV9/nsbsD+yTsTULig6LYI+tBDTYN1JZN9DnmTSBTz8YwgDCdu8
 OZLX65LTT586f1P7KVraej1r+AuUlbniK3jTn40M7g8CpbPCyul0hNocBWoKpyXkUTUC
 SgUw==
X-Gm-Message-State: APjAAAVo9l6TEB01QBb2UGYb5iZVDI2SxnZt8slaqT5Iy/+xkKDsaJ2U
 qauZu26WwRiIHxQa00QXYaU=
X-Google-Smtp-Source: APXvYqxTyY8feaWKXEXubyTRNHBlk2m80ddPTTgl23MptTY8kpsBcpN2d+qgHwqYDNFZVG5fho65dQ==
X-Received: by 2002:ac2:5225:: with SMTP id i5mr19068045lfl.157.1561324447751; 
 Sun, 23 Jun 2019 14:14:07 -0700 (PDT)
Received: from localhost.localdomain ([91.90.160.140])
 by smtp.gmail.com with ESMTPSA id y10sm1274970lfb.28.2019.06.23.14.14.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 23 Jun 2019 14:14:06 -0700 (PDT)
From: Vasyl Gomonovych <gomonovych@gmail.com>
To: jochen@scram.de, linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: remove casting dma_alloc
Date: Sun, 23 Jun 2019 23:13:53 +0200
Message-Id: <20190623211354.24181-1-gomonovych@gmail.com>
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
Cc: Vasyl <gomonovych@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Vasyl <gomonovych@gmail.com>

Generated by:  alloc_cast.cocci

Signed-off-by: Vasyl <gomonovych@gmail.com>
---
 drivers/i2c/busses/i2c-cpm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 187900594e3d..1213e1932ccb 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -531,7 +531,9 @@ static int cpm_i2c_setup(struct cpm_i2c *cpm)
 		}
 		out_be32(&rbdf[i].cbd_bufaddr, ((cpm->rxdma[i] + 1) & ~1));
 
-		cpm->txbuf[i] = (unsigned char *)dma_alloc_coherent(&cpm->ofdev->dev, CPM_MAX_READ + 1, &cpm->txdma[i], GFP_KERNEL);
+		cpm->txbuf[i] = dma_alloc_coherent(&cpm->ofdev->dev,
+						   CPM_MAX_READ + 1,
+						   &cpm->txdma[i], GFP_KERNEL);
 		if (!cpm->txbuf[i]) {
 			ret = -ENOMEM;
 			goto out_muram;
-- 
2.17.1

