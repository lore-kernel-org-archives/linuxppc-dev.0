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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4856C433E1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 09:23:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877292072E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 09:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tdpwarCY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877292072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVT9l2wdSzDqT1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 19:23:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::544;
 helo=mail-pg1-x544.google.com; envelope-from=allen.lkml@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=tdpwarCY; dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVRwd6624zDqMF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 18:26:57 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id j21so7759370pgi.9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 01:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lVv9KH9OHYQxfiTtM7sr/yrxc3VHJHaRO2GRJfzHnA0=;
 b=tdpwarCYYV8gEQ5ZksyKAt24uXKiAXb9mffYCIfGOHo6XRdKn3E/4d0a7jNVUxQglq
 SV6/7fuATPb///IcuEDDTQy3TJ09Q1W87uRD8n3gBQVMDEY+AhZVua01ADz8gmMn4X6i
 nfm9It6IQbwseLhnOfwPJUrm1lyCdalOqlvSZVMv0KDkIDIe3qq850RJhPZX578LBRk3
 JOWeQLhC13jRH9ekm9SPnhrPyqSRYvPEVa8c8KfC1fyiaQebuzhJeeCTmaDDyw7hnXW7
 3sd06wpWx4FeZO9QIEMGU9dvOliR2qloKLNMr/vJ1TEZEJxwBBUuWHb/5Cro85mZTxbd
 o4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lVv9KH9OHYQxfiTtM7sr/yrxc3VHJHaRO2GRJfzHnA0=;
 b=WrUc4UFjBXH8j8HAwD7ViTvM7gZstnC3F3I1GSV3eoPzT5PywpzzUf8Ait/fefNs8h
 2Hc2TJYoQuOER1hqq0fXVxPNNgCW4JV6PMWQlz4QqsUIKmTL2E12y06m//bditWzTi9L
 ydKFRiLbjIdvAPy7KRBXDVwb3LFNg0eL9uD4h1pvzoVM0g0NAhyCjnbyCNkBxlV1Zyk0
 lF9Wm+jYybh7ggY3WuIPUaNFT9u8EmxNJMnRVDkoN8K03MRa5gbi9gXa4xPJg1W4rsO/
 tCDBjrs0O+lH3IMx2ar2awa48wFcL0j5EM23baqmvI8NyEGmhy/WTjCZq7zvD9/y8ya7
 h4bw==
X-Gm-Message-State: AOAM530+KYr7nJEh9Z1+U6jTSvIezC1V46QEKyOVF3TVGT5yzro3wacV
 CPvaJGc1qzY4pH8zUu+zQTI=
X-Google-Smtp-Source: ABdhPJwxI7njVddj/NNf3D82oUgJzonLqIGa7AYU/tTYlx3E4MoM1tP++tr/dbSigeWK25H0FtOm/g==
X-Received: by 2002:a63:ee12:: with SMTP id e18mr8908728pgi.1.1597652814950;
 Mon, 17 Aug 2020 01:26:54 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id r186sm19928482pfr.162.2020.08.17.01.26.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:26:54 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: jes@trained-monkey.org, davem@davemloft.net, kuba@kernel.org,
 kda@linux-powerpc.org, dougmill@linux.ibm.com, cooldavid@cooldavid.org,
 mlindner@marvell.com, borisp@mellanox.com
Subject: [PATCH 20/20] ethernet: smsc: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 13:54:34 +0530
Message-Id: <20200817082434.21176-22-allen.lkml@gmail.com>
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
 drivers/net/ethernet/smsc/smc91x.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 1c4fea9c3ec4..7e585aa3031c 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -535,10 +535,10 @@ static inline void  smc_rcv(struct net_device *dev)
 /*
  * This is called to actually send a packet to the chip.
  */
-static void smc_hardware_send_pkt(unsigned long data)
+static void smc_hardware_send_pkt(struct tasklet_struct *t)
 {
-	struct net_device *dev = (struct net_device *)data;
-	struct smc_local *lp = netdev_priv(dev);
+	struct smc_local *lp = from_tasklet(lp, t, tx_task);
+	struct net_device *dev = lp->dev;
 	void __iomem *ioaddr = lp->base;
 	struct sk_buff *skb;
 	unsigned int packet_no, len;
@@ -688,7 +688,7 @@ smc_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		 * Allocation succeeded: push packet to the chip's own memory
 		 * immediately.
 		 */
-		smc_hardware_send_pkt((unsigned long)dev);
+		smc_hardware_send_pkt(&lp->tx_task);
 	}
 
 	return NETDEV_TX_OK;
@@ -1965,7 +1965,7 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
 	dev->netdev_ops = &smc_netdev_ops;
 	dev->ethtool_ops = &smc_ethtool_ops;
 
-	tasklet_init(&lp->tx_task, smc_hardware_send_pkt, (unsigned long)dev);
+	tasklet_setup(&lp->tx_task, smc_hardware_send_pkt);
 	INIT_WORK(&lp->phy_configure, smc_phy_configure);
 	lp->dev = dev;
 	lp->mii.phy_id_mask = 0x1f;
-- 
2.17.1

