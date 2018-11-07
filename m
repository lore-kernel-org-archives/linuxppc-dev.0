Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783D1C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 08:11:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B20DB20862
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 08:11:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20DB20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42qfJg3yJwzF3H1
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 19:11:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=31.15.61.139; helo=smtp.transmode.se;
 envelope-from=mathias.thore@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=infinera.com
Received: from smtp.transmode.se (smtp.transmode.se [31.15.61.139])
 by lists.ozlabs.org (Postfix) with ESMTP id 42qfGf3jTrzF3GP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Nov 2018 19:09:59 +1100 (AEDT)
Received: from se-math-lx.infinera.com (se-math-lx.infinera.com [10.210.72.58])
 by smtp.transmode.se (Postfix) with ESMTP id C800F1187065;
 Wed,  7 Nov 2018 09:09:54 +0100 (CET)
Received: from se-math-lx.infinera.com (se-math-lx.infinera.com [127.0.0.1])
 by se-math-lx.infinera.com (8.14.9/8.14.9) with ESMTP id wA789skw030735;
 Wed, 7 Nov 2018 09:09:54 +0100
Received: (from math@localhost)
 by se-math-lx.infinera.com (8.14.9/8.14.9/Submit) id wA789ssv030734;
 Wed, 7 Nov 2018 09:09:54 +0100
From: Mathias Thore <mathias.thore@infinera.com>
To: qiang.zhao@nxp.com, linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
 joakim.tjernlund@infinera.com, david.gounaris@infinera.com
Subject: [PATCH] net/wan/fsl_ucc_hdlc: add BQL support
Date: Wed,  7 Nov 2018 09:09:45 +0100
Message-Id: <20181107080945.30651-1-mathias.thore@infinera.com>
X-Mailer: git-send-email 2.18.1
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
Cc: Mathias Thore <mathias.thore@infinera.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add byte queue limits support in the fsl_ucc_hdlc driver.

Signed-off-by: Mathias Thore <mathias.thore@infinera.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 4d6409605207..7a42336c8af8 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -391,6 +391,7 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
 		dev_kfree_skb(skb);
 		return -ENOMEM;
 	}
+	netdev_sent_queue(dev, skb->len);
 	spin_lock_irqsave(&priv->lock, flags);
 
 	/* Start from the next BD that should be filled */
@@ -447,6 +448,8 @@ static int hdlc_tx_done(struct ucc_hdlc_private *priv)
 {
 	/* Start from the next BD that should be filled */
 	struct net_device *dev = priv->ndev;
+	unsigned int bytes_sent = 0;
+	int howmany = 0;
 	struct qe_bd *bd;		/* BD pointer */
 	u16 bd_status;
 	int tx_restart = 0;
@@ -474,6 +477,8 @@ static int hdlc_tx_done(struct ucc_hdlc_private *priv)
 		skb = priv->tx_skbuff[priv->skb_dirtytx];
 		if (!skb)
 			break;
+		howmany++;
+		bytes_sent += skb->len;
 		dev->stats.tx_packets++;
 		memset(priv->tx_buffer +
 		       (be32_to_cpu(bd->buf) - priv->dma_tx_addr),
@@ -501,6 +506,7 @@ static int hdlc_tx_done(struct ucc_hdlc_private *priv)
 	if (tx_restart)
 		hdlc_tx_restart(priv);
 
+	netdev_completed_queue(dev, howmany, bytes_sent);
 	return 0;
 }
 
@@ -721,6 +727,7 @@ static int uhdlc_open(struct net_device *dev)
 		priv->hdlc_busy = 1;
 		netif_device_attach(priv->ndev);
 		napi_enable(&priv->napi);
+		netdev_reset_queue(dev);
 		netif_start_queue(dev);
 		hdlc_open(dev);
 	}
@@ -812,6 +819,7 @@ static int uhdlc_close(struct net_device *dev)
 
 	free_irq(priv->ut_info->uf_info.irq, priv);
 	netif_stop_queue(dev);
+	netdev_reset_queue(dev);
 	priv->hdlc_busy = 0;
 
 	return 0;
-- 
2.18.1

