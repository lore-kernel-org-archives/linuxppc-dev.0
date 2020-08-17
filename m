Return-Path: <SRS0=WC9B=B3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF71C433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 09:15:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAEC62072D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 09:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMmUPSbN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEC62072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVT0z66pRzDqSw
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 19:15:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=allen.lkml@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=EMmUPSbN; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVRwJ1z2yzDqQX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 18:26:39 +1000 (AEST)
Received: by mail-pl1-x642.google.com with SMTP id k13so7122144plk.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 01:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=o0FMk4NSKHdON29FQ/delLJrHAtl7s1b3Zn2ITn/KyQ=;
 b=EMmUPSbN+4ipANeDlXBtAnB3UwDY9H6TP8yOz6wWku97mB6+sfEUFOlpE72g1O6h+G
 eKrUOejHzvHY6tyzDx+IDTwXdbaK3zLGMU/M598ekvxCtnC/7d5d6ZCR/ZcR2UAv3fbe
 VACi+Zor+zAIOATP/Yas9HdBtd3o20TU5dAvVWXl0gbWV28T+49O1BKHmxBFxvmklfmt
 SPVaLg+2T0xkD0oIgr1nz1XfAk640XPjM5ZOfmUjy+0G9gOsCqrDT81YmPmeM6i4QCL5
 edf5DD3C4xCx1GBFsyuZiKQ42c55kRmRuEvQqQ6C2gxiwS4bNYibBkfB32keH/g72ew7
 ErFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=o0FMk4NSKHdON29FQ/delLJrHAtl7s1b3Zn2ITn/KyQ=;
 b=cz6YfgVWdgmlyUr9yhU6xDxDskC0mUcWHXawZJswV5VjKbGVO4aND05zxh4EBcfmsF
 EcBxvd+t16xwwS1F31XQzyPRYiNQGLIa54aejvMHDMmbozNmaeO3lFf1qLw0mafcDY3O
 yfVvD9B6Y0Eu13XnjWYYNFVqFM+lX6HKAXlv2OUwIjEaYhYX0hDpoSagfwhqbnCDeD7u
 piqW7KTQ2/QZZgvugeMkZJUMMM1hvCTjsDFBd84XeEJ3L3fBHOWf9QzOuLMv2BgKHYTw
 1JiNUJrsf7j19bEp941u9OoTYbm9GVGABVYoU0Jsh8w8JpmI0eWMaECnn0MaP0bq0aTN
 q6qQ==
X-Gm-Message-State: AOAM531aT1HMC92HGPuN5nixvVUVAbJiBCXI2voKoQOqxp57zC3v9ziA
 yeHV4CydgXw4rBf7XTwBAA8=
X-Google-Smtp-Source: ABdhPJybXxJ+dBHrJmIu3dZ4nk6KLcetVg87DxiqclRyCqvNLKi590hC96D0VCcPHISVJroeNA4prQ==
X-Received: by 2002:a17:90a:eb17:: with SMTP id
 j23mr11335001pjz.151.1597652797309; 
 Mon, 17 Aug 2020 01:26:37 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id r186sm19928482pfr.162.2020.08.17.01.26.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:26:36 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: jes@trained-monkey.org, davem@davemloft.net, kuba@kernel.org,
 kda@linux-powerpc.org, dougmill@linux.ibm.com, cooldavid@cooldavid.org,
 mlindner@marvell.com, borisp@mellanox.com
Subject: [PATCH 17/20] ethernet: ni: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 13:54:31 +0530
Message-Id: <20200817082434.21176-19-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817082434.21176-1-allen.lkml@gmail.com>
References: <20200817082434.21176-1-allen.lkml@gmail.com>
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
Cc: keescook@chromium.org, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Allen Pais <allen.lkml@gmail.com>,
 oss-drivers@netronome.com, Romain Perier <romain.perier@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-acenic@sunsite.dk,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/ni/nixge.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 4075f5e59955..a6861df9904f 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -787,9 +787,9 @@ static irqreturn_t nixge_rx_irq(int irq, void *_ndev)
 	return IRQ_HANDLED;
 }
 
-static void nixge_dma_err_handler(unsigned long data)
+static void nixge_dma_err_handler(struct tasklet_struct *t)
 {
-	struct nixge_priv *lp = (struct nixge_priv *)data;
+	struct nixge_priv *lp = from_tasklet(lp, t, dma_err_tasklet);
 	struct nixge_hw_dma_bd *cur_p;
 	struct nixge_tx_skb *tx_skb;
 	u32 cr, i;
@@ -879,8 +879,7 @@ static int nixge_open(struct net_device *ndev)
 	phy_start(phy);
 
 	/* Enable tasklets for Axi DMA error handling */
-	tasklet_init(&priv->dma_err_tasklet, nixge_dma_err_handler,
-		     (unsigned long)priv);
+	tasklet_setup(&priv->dma_err_tasklet, nixge_dma_err_handler);
 
 	napi_enable(&priv->napi);
 
-- 
2.17.1

