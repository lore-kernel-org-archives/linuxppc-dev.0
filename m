Return-Path: <linuxppc-dev+bounces-20429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFEFCD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 17:45:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8TZK0HVRz2yZ3;
	Tue, 05 May 2026 03:45:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.158.144.38
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777916728;
	cv=none; b=m8bYDVeOh36VHvh5rK0SSECQYEM9/V8WowdSHIKxHjgj8u3oNMT/gMAaLoJT3dsoySMuWYI9F6bCMFo+2we+Azk51FxPSYrhgrp0ka45O8rCiH0tTcFyvlONbGI6lPTqI7FuVaLpZ7X4uMaGIU+axSvQP+wAAUPkX94lEwYMh+dslrERANaQ7R8/FRgUmaT1Gg1E1Vae0B0k1sJ2ch5MG8MZOT0AY3vtVR2VC3chHQqIPRfRx2epwiWF2hlIiIFBXJ1ItdByMqg2S1BClsNwWBJrZ8bn4vLUm/JIGDyZytrVOWyWa7b8YkcitFqQsPJm7Wl574SkTENF9zc2hAZ+ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777916728; c=relaxed/relaxed;
	bh=X3J19TUk0OReXY5Z/IXa99Q+WScavHAWc7VKN6O0XgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fo3/iuopMjQTnKlFtntiUD1hat5MFn51hpXLbbNismD7Foa2jIxdS80IUKMvnURZ0Po9ZOVbH2KD9rBtU0+dpHs7bfCjD1rXVwDa8VpPiYi19HxmxPk50h9cIuJ2D/HgwLuyIkvViZsVmRu0TXQOP5c+YtEAfGybWZBKkJ4LYZma89EdOipJfJNuzv3qwFW9hmTT/HjoJA0DpV7yBJ30OqOne2OGOely53Wf+KJannLSgyVeZxPkPHF4AYczMsVYBw9tI3x5rG7iVTNEr+ins4GHW6rs7JpnX42JKcE/WUC5WYpyDB1S6TbbYviUzCtzwIy410RSlaEetFzNw6gbjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=BNrC2MML; dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=dDJeeLiH; dkim-atps=neutral; spf=pass (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=BNrC2MML;
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=dDJeeLiH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8TZH2qZ1z2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 03:45:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=X3J19TUk0OReXY5Z/IXa99Q+WScavHAWc7VKN6O0XgE=;
	b=BNrC2MML3q1q2cWiR/Za7qoyoOSp/JUmmasynNuPIUGdXlvyOgPylgcLfQuGbQom8fAhytpDzG2Z0
	 UlMDT78RSPvcNQgii1PiogL3F2Oju8O3g4BCyjSUD03yGxQvCnrLMW5kKfKLEoyvtEe9v8uPDHrGmG
	 fYfhrr81zeqJkMEU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=X3J19TUk0OReXY5Z/IXa99Q+WScavHAWc7VKN6O0XgE=;
	b=dDJeeLiH/nX+VJnk670j8yEOAqRdmcSqqpQqUtWsRdPXSvV/RjvFrthkq9JxhkvQeShpIbsBv/PrG
	 L/3GmtoEgA1hD7raSv9mY8XUmY1ZSGHUQFgLCPR2qZQUfG/QxwVHfCg8RnrEWtx9+z/chVtj5fIqc2
	 AO9vqpvbSQu7DGcTopxInm7PtxF/rJmpBsPGcr9ib12CbayA0PXOBiKN80hTc1p757GqRgLL3mK043
	 Tmk4pi4a8enbTeeSxs0EShdMMD4Y/XRAyiNiyUA/cHEkHuMnAhQqtQ8eIYrSeKO22KVbOGLcDDO+rZ
	 2FwzwXCZJyxthfBxvlMUbPPfnbjL92Q==
X-Originating-IP: 20.82.50.241
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: daf647d2-47e0-11f1-8ef6-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: daf647d2-47e0-11f1-8ef6-f54febe22707:7
CFBL-Address: prvs=058485b737=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown [20.82.50.241])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id daf647d2-47e0-11f1-8ef6-f54febe22707;
	Mon, 04 May 2026 17:44:11 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with ESMTP id 99C25805244;
	Mon,  4 May 2026 17:44:09 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 76E5160B7D47;
	Mon,  4 May 2026 19:44:09 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH net] net: wan: fsl_ucc_hdlc: return NETDEV_TX_OK if skb was freed
Date: Mon,  4 May 2026 19:44:06 +0200
Message-ID: <20260504174406.2229693-1-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.52.0.120.gb31ab939fe
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the skb was freed in the ucc_hdlc_tx function and the packet marked
as dropped we need to return NETDEV_TX_OK. Otherwise the above layer
will try to requeue an already freed skb.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 7af558780bdc..6ce539151618 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -360,7 +360,7 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
 			dev->stats.tx_dropped++;
 			dev_kfree_skb(skb);
 			netdev_err(dev, "No enough space for hdlc head\n");
-			return -ENOMEM;
+			return NETDEV_TX_OK;
 		}
 
 		skb_push(skb, HDLC_HEAD_LEN);
@@ -377,7 +377,7 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
 			dev->stats.tx_dropped++;
 			dev_kfree_skb(skb);
 			netdev_err(dev, "Wrong ppp header\n");
-			return -ENOMEM;
+			return NETDEV_TX_OK;
 		}
 
 		dev->stats.tx_bytes += skb->len;
@@ -390,7 +390,7 @@ static netdev_tx_t ucc_hdlc_tx(struct sk_buff *skb, struct net_device *dev)
 	default:
 		dev->stats.tx_dropped++;
 		dev_kfree_skb(skb);
-		return -ENOMEM;
+		return NETDEV_TX_OK;
 	}
 	netdev_sent_queue(dev, skb->len);
 	spin_lock_irqsave(&priv->lock, flags);
-- 
2.47.3


