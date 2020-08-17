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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3162AC433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 09:08:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC43B2063A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 09:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBLxHBYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC43B2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVSrQ54lWzDqS6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 19:08:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1041;
 helo=mail-pj1-x1041.google.com; envelope-from=allen.lkml@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LBLxHBYX; dkim-atps=neutral
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com
 [IPv6:2607:f8b0:4864:20::1041])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVRvw6cmfzDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 18:26:20 +1000 (AEST)
Received: by mail-pj1-x1041.google.com with SMTP id f9so7338753pju.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 01:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=NGc9GivMW4Gl2PZYS1sshtdVeD119m/l6GvQX46weos=;
 b=LBLxHBYXHHShApS1V6EqhqlERMx39IJoGg9XyyNS0xxKKPf7wzJlvUp7OZH7MsJNbk
 Hhy8KpiRMnmdXLU49x03cAV9Hb30GjB3mLnkNXIVN7t7SxDQ0pzRJNjp101YiuBGrc6h
 +OaSLNfkE2xI7g79vNgCQ+sgLmy75Y0bBKtNhkfSvXuudjABMDUQL5Enx7nI0chgO32d
 t5Vq04PRATxJxYQ15CIpAo/xswWJNmoEItx+gz7uWetOIqMKbHGTpI5tFRruhMbNCxzv
 d36pjAk2F3GLgsY9HZ1tEBwdbzTGHHfWhsaWugChVMUm6Bu0PrSMhwW9pPUh7m5In5hF
 8d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=NGc9GivMW4Gl2PZYS1sshtdVeD119m/l6GvQX46weos=;
 b=UTR2QdaBrGreDDVmvdtK/q0Gce2oCrzekMofj5ndRuWqRU92funjrje7gzPffR3aq7
 IE24PCgzxBlaI6YLJ4lITulAewm4zFgRc5Ed6TB7MpuUbdRt5I++hPIs2BggQ+Au9pQZ
 GTFOur10A6Rjgov3z7ynsHLaurl6aDVAANwZezcTW1Kx0lZHPNCaCwHfbAJ2/9FZJonb
 V1nGoVuwoCa2+sNg7OQuAXuQLrZ9V8co1fAj3QMV7BdbEyFsbXYgZcggmlHLFMSQiwJe
 6LZtqU/gwoS2WxbHvWEBsHnEYdOfqmp6R05WO+fgSXLyO0I0n6/10OVNE0eyfkN+gy18
 uPTA==
X-Gm-Message-State: AOAM533TMYIQICL55Pwa18TaGvGm04wT0S+ubp5ounGpcV45LTywkCe2
 bxpx8syBI/tUmKFp2/jutIU=
X-Google-Smtp-Source: ABdhPJwRCnCkq0qh6UezjQA0oYu6vWfa6QDQxH8Q19OL3Crbp/QUQGdhIqlSJxXrujdjDsmyU1xEDw==
X-Received: by 2002:a17:90b:208:: with SMTP id
 fy8mr11168449pjb.131.1597652778097; 
 Mon, 17 Aug 2020 01:26:18 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id r186sm19928482pfr.162.2020.08.17.01.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:26:17 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: jes@trained-monkey.org, davem@davemloft.net, kuba@kernel.org,
 kda@linux-powerpc.org, dougmill@linux.ibm.com, cooldavid@cooldavid.org,
 mlindner@marvell.com, borisp@mellanox.com
Subject: [PATCH 14/20] ethernet: micrel: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 13:54:28 +0530
Message-Id: <20200817082434.21176-16-allen.lkml@gmail.com>
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
 drivers/net/ethernet/micrel/ks8842.c  | 19 ++++++++++---------
 drivers/net/ethernet/micrel/ksz884x.c | 14 ++++++--------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/micrel/ks8842.c b/drivers/net/ethernet/micrel/ks8842.c
index f3f6dfe3eddc..8fd32f98c494 100644
--- a/drivers/net/ethernet/micrel/ks8842.c
+++ b/drivers/net/ethernet/micrel/ks8842.c
@@ -587,10 +587,11 @@ static int __ks8842_start_new_rx_dma(struct net_device *netdev)
 	return err;
 }
 
-static void ks8842_rx_frame_dma_tasklet(unsigned long arg)
+static void ks8842_rx_frame_dma_tasklet(struct tasklet_struct *t)
 {
-	struct net_device *netdev = (struct net_device *)arg;
-	struct ks8842_adapter *adapter = netdev_priv(netdev);
+	struct ks8842_adapter *adapter = from_tasklet(adapter, t, dma_rx.tasklet);
+	struct net_device *netdev = (struct net_device *)((char *)adapter -
+				ALIGN(sizeof(struct net_device), NETDEV_ALIGN));
 	struct ks8842_rx_dma_ctl *ctl = &adapter->dma_rx;
 	struct sk_buff *skb = ctl->skb;
 	dma_addr_t addr = sg_dma_address(&ctl->sg);
@@ -720,10 +721,11 @@ static void ks8842_handle_rx_overrun(struct net_device *netdev,
 	netdev->stats.rx_fifo_errors++;
 }
 
-static void ks8842_tasklet(unsigned long arg)
+static void ks8842_tasklet(struct tasklet_struct *t)
 {
-	struct net_device *netdev = (struct net_device *)arg;
-	struct ks8842_adapter *adapter = netdev_priv(netdev);
+	struct ks8842_adapter *adapter = from_tasklet(adapter, t, tasklet);
+	struct net_device *netdev = (struct net_device *)((char *)adapter -
+				ALIGN(sizeof(struct net_device), NETDEV_ALIGN));
 	u16 isr;
 	unsigned long flags;
 	u16 entry_bank;
@@ -953,8 +955,7 @@ static int ks8842_alloc_dma_bufs(struct net_device *netdev)
 		goto err;
 	}
 
-	tasklet_init(&rx_ctl->tasklet, ks8842_rx_frame_dma_tasklet,
-		(unsigned long)netdev);
+	tasklet_setup(&rx_ctl->tasklet, ks8842_rx_frame_dma_tasklet);
 
 	return 0;
 err:
@@ -1173,7 +1174,7 @@ static int ks8842_probe(struct platform_device *pdev)
 		adapter->dma_tx.channel = -1;
 	}
 
-	tasklet_init(&adapter->tasklet, ks8842_tasklet, (unsigned long)netdev);
+	tasklet_setup(&adapter->tasklet, ks8842_tasklet);
 	spin_lock_init(&adapter->lock);
 
 	netdev->netdev_ops = &ks8842_netdev_ops;
diff --git a/drivers/net/ethernet/micrel/ksz884x.c b/drivers/net/ethernet/micrel/ksz884x.c
index bb646b65cc95..5130507bbf54 100644
--- a/drivers/net/ethernet/micrel/ksz884x.c
+++ b/drivers/net/ethernet/micrel/ksz884x.c
@@ -5159,9 +5159,9 @@ static int dev_rcv_special(struct dev_info *hw_priv)
 	return received;
 }
 
-static void rx_proc_task(unsigned long data)
+static void rx_proc_task(struct tasklet_struct *t)
 {
-	struct dev_info *hw_priv = (struct dev_info *) data;
+	struct dev_info *hw_priv = from_tasklet(hw_priv, t, rx_tasklet);
 	struct ksz_hw *hw = &hw_priv->hw;
 
 	if (!hw->enabled)
@@ -5181,9 +5181,9 @@ static void rx_proc_task(unsigned long data)
 	}
 }
 
-static void tx_proc_task(unsigned long data)
+static void tx_proc_task(struct tasklet_struct *t)
 {
-	struct dev_info *hw_priv = (struct dev_info *) data;
+	struct dev_info *hw_priv = from_tasklet(hw_priv, t, tx_tasklet);
 	struct ksz_hw *hw = &hw_priv->hw;
 
 	hw_ack_intr(hw, KS884X_INT_TX_MASK);
@@ -5436,10 +5436,8 @@ static int prepare_hardware(struct net_device *dev)
 	rc = request_irq(dev->irq, netdev_intr, IRQF_SHARED, dev->name, dev);
 	if (rc)
 		return rc;
-	tasklet_init(&hw_priv->rx_tasklet, rx_proc_task,
-		     (unsigned long) hw_priv);
-	tasklet_init(&hw_priv->tx_tasklet, tx_proc_task,
-		     (unsigned long) hw_priv);
+	tasklet_setup(&hw_priv->rx_tasklet, rx_proc_task);
+	tasklet_setup(&hw_priv->tx_tasklet, tx_proc_task);
 
 	hw->promiscuous = 0;
 	hw->all_multi = 0;
-- 
2.17.1

