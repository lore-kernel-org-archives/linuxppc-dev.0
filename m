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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1158CC433E3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 08:48:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B96A420658
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 08:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZLuecL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B96A420658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVSPd5KLszDqS8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 18:48:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::644;
 helo=mail-pl1-x644.google.com; envelope-from=allen.lkml@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=jZLuecL8; dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVRv63ffpzDqMN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 18:25:38 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id r4so7141097pls.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=t98B3iZn1A9NLqkiUAje/weBgNoNpyefzZebYfgmTtE=;
 b=jZLuecL8IeUDv5a24d46K3rjLGWcoQJj69HmdPY/DPKCZxH5u+GyxjZZU0tHjy6TcL
 q4HpfCzSZMtxa61vEN7/e/eDdpbmaZVqSDB73eonA+uwHWobDX7xGEC0NjwH81/fXTVK
 7ff3VxfI4HmSAE+59SQ7UN6yt952R0GQc/s9UOWICylm4KiIaXzaPAUDZFNUpWcFYUQ4
 h4QkOSWETXpxWR04vhc42wXGtQl7Pflsu2sYnuQWpvyDpJoPvYC6WGr5KRgcK/CANL8x
 VKrhuEQhsp7U8rTTGURn1Uij6MXbcuyNQQ9WVswpOdCZJH1lpE33edBog9aESZmbcyLV
 crfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=t98B3iZn1A9NLqkiUAje/weBgNoNpyefzZebYfgmTtE=;
 b=JuHiuItMmT+ogpfSgQdZNhDwZtvCj77mhXr3V7znn1FiI/TnpvjxziQz9L872dlzd5
 Omhnrqwf9/DZ2A4UEo0nLU3ktPy4uPMhgecCveV8PnGXrb1iCZuZng7uILYv8twsAhU4
 yEDSVxhhJEaHHgGu4ICAIorVixyX6vK0TKcEQl0RvGXHsPXbnPpYOxZ9CvXgGXRS/bFl
 WZLg9iRYrPeV8YbkEwbTFhOZIPnlGUC7p9YF53qzciW8lJxuVFhTwKO9hd5xTRcN7rBY
 Q0dYkAuM3fCdCSF8n+SKx+USa1vTKfVHTereW7fRZZULaIgpoHBTRY58z0QFfC0FJcNl
 C/FA==
X-Gm-Message-State: AOAM530Yh/RurTXIAP8gPZFx1rHyVBrCW5uMQdwYuy1LlFAhrcMa4Ha7
 tUfn18NjVi1acX+gY52pkqM=
X-Google-Smtp-Source: ABdhPJw4UfJp6v93zOfVhpwON1MyO9yehUVd0VaAZcFPqK5ou/peSYq27nwwshI4OGpbk3ZqbHihsw==
X-Received: by 2002:a17:90a:ff85:: with SMTP id
 hf5mr11460448pjb.79.1597652736154; 
 Mon, 17 Aug 2020 01:25:36 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id r186sm19928482pfr.162.2020.08.17.01.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 01:25:35 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: jes@trained-monkey.org, davem@davemloft.net, kuba@kernel.org,
 kda@linux-powerpc.org, dougmill@linux.ibm.com, cooldavid@cooldavid.org,
 mlindner@marvell.com, borisp@mellanox.com
Subject: [PATCH 07/20] ethernet: dlink: convert tasklets to use new
 tasklet_setup() API
Date: Mon, 17 Aug 2020 13:54:21 +0530
Message-Id: <20200817082434.21176-9-allen.lkml@gmail.com>
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
 drivers/net/ethernet/dlink/sundance.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/dlink/sundance.c b/drivers/net/ethernet/dlink/sundance.c
index b3f8597e77aa..58022396b053 100644
--- a/drivers/net/ethernet/dlink/sundance.c
+++ b/drivers/net/ethernet/dlink/sundance.c
@@ -429,8 +429,8 @@ static void init_ring(struct net_device *dev);
 static netdev_tx_t start_tx(struct sk_buff *skb, struct net_device *dev);
 static int reset_tx (struct net_device *dev);
 static irqreturn_t intr_handler(int irq, void *dev_instance);
-static void rx_poll(unsigned long data);
-static void tx_poll(unsigned long data);
+static void rx_poll(struct tasklet_struct *t);
+static void tx_poll(struct tasklet_struct *t);
 static void refill_rx (struct net_device *dev);
 static void netdev_error(struct net_device *dev, int intr_status);
 static void netdev_error(struct net_device *dev, int intr_status);
@@ -537,8 +537,8 @@ static int sundance_probe1(struct pci_dev *pdev,
 	np->msg_enable = (1 << debug) - 1;
 	spin_lock_init(&np->lock);
 	spin_lock_init(&np->statlock);
-	tasklet_init(&np->rx_tasklet, rx_poll, (unsigned long)dev);
-	tasklet_init(&np->tx_tasklet, tx_poll, (unsigned long)dev);
+	tasklet_setup(&np->rx_tasklet, rx_poll);
+	tasklet_setup(&np->tx_tasklet, tx_poll);
 
 	ring_space = dma_alloc_coherent(&pdev->dev, TX_TOTAL_SIZE,
 			&ring_dma, GFP_KERNEL);
@@ -1054,10 +1054,9 @@ static void init_ring(struct net_device *dev)
 	}
 }
 
-static void tx_poll (unsigned long data)
+static void tx_poll(struct tasklet_struct *t)
 {
-	struct net_device *dev = (struct net_device *)data;
-	struct netdev_private *np = netdev_priv(dev);
+	struct netdev_private *np = from_tasklet(np, t, tx_tasklet);
 	unsigned head = np->cur_task % TX_RING_SIZE;
 	struct netdev_desc *txdesc =
 		&np->tx_ring[(np->cur_tx - 1) % TX_RING_SIZE];
@@ -1312,10 +1311,11 @@ static irqreturn_t intr_handler(int irq, void *dev_instance)
 	return IRQ_RETVAL(handled);
 }
 
-static void rx_poll(unsigned long data)
+static void rx_poll(struct tasklet_struct *t)
 {
-	struct net_device *dev = (struct net_device *)data;
-	struct netdev_private *np = netdev_priv(dev);
+	struct netdev_private *np = from_tasklet(np, t, rx_tasklet);
+	struct net_device *dev = (struct net_device *)((char *)np -
+				  ALIGN(sizeof(struct net_device), NETDEV_ALIGN));
 	int entry = np->cur_rx % RX_RING_SIZE;
 	int boguscnt = np->budget;
 	void __iomem *ioaddr = np->base;
-- 
2.17.1

