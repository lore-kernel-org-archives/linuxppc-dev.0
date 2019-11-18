Return-Path: <SRS0=h9PY=ZK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6A0C432C0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 13:28:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C29C2075E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Nov 2019 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="QtCF582M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C29C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47GqY21tv5zDqQy
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 00:28:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=rasmusvillemoes.dk (client-ip=2a00:1450:4864:20::444;
 helo=mail-wr1-x444.google.com; envelope-from=linux@rasmusvillemoes.dk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=rasmusvillemoes.dk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk
 header.b="QtCF582M"; dkim-atps=neutral
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Gmnb6PyPzDqVC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 22:24:35 +1100 (AEDT)
Received: by mail-wr1-x444.google.com with SMTP id s5so19007567wrw.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Nov 2019 03:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rasmusvillemoes.dk; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SKjk4xtgUQ/kA6JZGPtMJVtONpNy6V4lFIeGBwHjI8g=;
 b=QtCF582MFVIFUAE0sBGhcnpWjLaKcMJuHBmrKQSENS+VvCOL11gQdMW8atajXJA2em
 kMb/rDoirxRW0vhZP33J+/jeZLSWRclHGRqPwHLuvpPjdAmwLCRTLHjmhdLBSc+TtOWY
 iLVuDZnvsXId6BXLCalrliqwxuijTqlROC53Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SKjk4xtgUQ/kA6JZGPtMJVtONpNy6V4lFIeGBwHjI8g=;
 b=K4BAFSJJb30jHPFpMFbwI+1w3r1xFqTD4iC7mZRwfFxIvkMR+AQac6TaYd4MaMCYce
 +KBS04J8//AbHVamqko+Y52NieEsZqgalJJsLNi8OiUqTbdiCgRkF8asx4ZEbKe9E8cM
 HG0tDNEEEYgCy8gwv8nJOTcuvy57IvgA8iSNdk63xPKiPnAR/gyV5htyd+7bae6LOJDz
 FKDSn+rR9pGgnDMaOjZ2pM/pfOt+7dTW/D3dfVSqDOezVR8KpwX7rAtouSu5qtEmJ3UL
 83JRYO7ycmpB+ZaGCcDYTMRWGBL9Qibiorg5id5FoaCRVEBjeGKjiGr8t7EAMoWSRKai
 eHHg==
X-Gm-Message-State: APjAAAUyD7C3AeBex3/ypeItENs0FKhhPogF48ZEAH4rW073JcecaH4L
 ClB2phcNswvt6rP7VJebteOCiw==
X-Google-Smtp-Source: APXvYqzfWvl1cOreV62JRtAha4euFED3eBmtooUgfkfMzTKXNFT+VQz7x317y2h7bdDCVKAQxJWUvQ==
X-Received: by 2002:a5d:4b86:: with SMTP id b6mr22999180wrt.143.1574076270973; 
 Mon, 18 Nov 2019 03:24:30 -0800 (PST)
Received: from prevas-ravi.prevas.se (ip-5-186-115-54.cgn.fibianet.dk.
 [5.186.115.54])
 by smtp.gmail.com with ESMTPSA id y2sm21140815wmy.2.2019.11.18.03.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 03:24:30 -0800 (PST)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 45/48] net/wan/fsl_ucc_hdlc: fix reading of __be16 registers
Date: Mon, 18 Nov 2019 12:23:21 +0100
Message-Id: <20191118112324.22725-46-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
References: <20191118112324.22725-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Timur Tabi <timur@kernel.org>, netdev@vger.kernel.org,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

When releasing the allocated muram resource, we rely on reading back
the offsets from the riptr/tiptr registers. But those registers are
__be16 (and we indeed write them using iowrite16be), so we can't just
read them back with a normal C dereference.

This is not currently a real problem, since for now the driver is
PPC32-only. But it will soon be allowed to be used on arm and arm64 as
well.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 405b24a5a60d..8d13586bb774 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -732,8 +732,8 @@ static int uhdlc_open(struct net_device *dev)
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 {
-	qe_muram_free(priv->ucc_pram->riptr);
-	qe_muram_free(priv->ucc_pram->tiptr);
+	qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
+	qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
 
 	if (priv->rx_bd_base) {
 		dma_free_coherent(priv->dev,
-- 
2.23.0

