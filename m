Return-Path: <linuxppc-dev+bounces-20574-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45B5CD3442
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2026 16:15:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gBHQq3RPQz2xQC;
	Fri, 08 May 2026 02:15:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.158.144.38
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778170515;
	cv=none; b=XvJR6QPv0IYzSElO2Sb9KWNif6BOs4AlclQjikiM0nIcxI4TAfblXeVJ3x02JAN1G2/xQ1Jz8yrmQ4lFxUB58khtf0d048it4+CWwRexsQHmgPPG1mBd2+sH0k9g4/wRgz8nhPHCMXwJ6Ojdm+ECbE9oX2orjgZQX2co2eCz5EOX0/9y4Xcix8+qKzQdK3kqX/0sCRjCMLTLioPN8DEK0w5m43rWEX0my8smsrspsAmRbbQG1zoIO04polfF3xchbIBnREVAu7eRI07TCbpuv+SopR1xDiLAEnvRCtoemNzWG/LMXe9mg3ayUyRLBXKvsAfyiIHDekQ2yQ3w2GJKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778170515; c=relaxed/relaxed;
	bh=dGs6BVMCuqp4caGYANuHKzUQtLxMT0/xX8YsdTBe72A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLqWqLDXn6tgy7hB439XOWWaJaiQOUudLWMoVDvliUgs5BdknXULYyeoMuGDuxuH4Xx/+GoP+UmYwJfgfATvBRRhuR+3P/bILX44wDrGv2oMbV4O4+EfsNnYtmG9kZ1MEhFUc2WlJsMbH92yJjDNk2cXWdiZA9+bnTvncKtvCCb7bSxcYD+ZZ2tBNdRwjlpUT90vqZmZhl9oriVVPD6OFjBMrl1e26WSekcbJFC5cycjfd2jns5fF3jUmSWpGNePQevJmQwZXzEDtxe70+Dcr87rF9xx7kcLe2FHbQppDsy82R3x9yt2nWOBh8rwJTveGCaOoKrMDmEmjiIgwyIbRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=RUnyfF8H; dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=gjP2kGgp; dkim-atps=neutral; spf=pass (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=RUnyfF8H;
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=gjP2kGgp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gBHQk3qLsz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 May 2026 02:15:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=dGs6BVMCuqp4caGYANuHKzUQtLxMT0/xX8YsdTBe72A=;
	b=RUnyfF8Hiyys3JJfi8e4UqByJdBHgDR9zPjG9pMOVD+Tryo9Eab77OaDIek7taxTCE8zll/6LT+7u
	 VneW+HxzYgkyqe7mhb6XyxmC5o7OfU9BQgQPLb15MYm3nCrCNZy1LulBp93iQCWSYCDmHrxZPILLPB
	 lj5X4mTZkmAwkSgo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=dGs6BVMCuqp4caGYANuHKzUQtLxMT0/xX8YsdTBe72A=;
	b=gjP2kGgppP3Bp7ygaCCNr6u0tgs/vKRNcBqnaMA227FV7ZjlEgroZ7w5v+2NFUg8enNXu70svRzQb
	 W81x0g2ltyETAMa8Tol1VlDWbE7KC3xeo0UDiy/xi0rgKjXVliRFSTZRE9KrcWXb4ADBGiBFHXrX5/
	 WKlNq/FleHlfcvklZPR9PBvLoLFdxsqCd3zh3+GzwMH2/bRxmSgjrjXnB8vwSFLjN5ewG53ZnvoTAU
	 LeXecqFpChYGlS6Atkq0igvMoDIUiYOlSdh6yT0jXRdx1r1TnJHZsAUKQTagZS2UupoSzRiXmxf+zJ
	 Bimlk3S1fOmJfW4lNxBXFputrgFEVoQ==
X-Originating-IP: 20.82.50.241
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: ed25b36b-4a2c-11f1-839c-bda8640e0fbb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: ed25b36b-4a2c-11f1-839c-bda8640e0fbb:9
CFBL-Address: prvs=05870dbd44=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown [20.82.50.241])
	by outbound2.eu.mailhop.org (Halon) with ESMTPSA
	id ed25b36b-4a2c-11f1-839c-bda8640e0fbb;
	Thu, 07 May 2026 15:53:45 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with ESMTP id 381F480524D;
	Thu,  7 May 2026 15:53:44 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 1C45660B7D47;
	Thu,  7 May 2026 17:53:44 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	kuba@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH v3 net] net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean
Date: Thu,  7 May 2026 17:53:32 +0200
Message-ID: <20260507155332.3452319-1-holger.brunck@hitachienergy.com>
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

When the device is removed all allocated resources should be freed.
In uhdlc_memclean the netdev transmit queue was already stopped. But at
this point we may have pending skb in the transmit queue which must be
freed. Therefore iterate over the tx_skbuff pointers and free all
pending skb. The issue was discovered by sashiko.
Tested on a ls1043a board running HDLC in bus mode on kernel 6.12.

https://sashiko.dev/#/patchset/20260429114208.941011-1-holger.brunck%40hitachienergy.com
Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
v3: - add test setup to commit message
v2: https://lore.kernel.org/linuxppc-dev/20260506111529.2919079-1-holger.brunck@hitachienergy.com/
    - use dev_kfree_skb instead of kfree
    - improve commit message
    - add missing paramter in for statement
v1: https://lore.kernel.org/linuxppc-dev/20260504161145.2217950-1-holger.brunck@hitachienergy.com/

 drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index bc7c2e9e6554..417e8e4c111f 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -739,6 +739,8 @@ static int uhdlc_open(struct net_device *dev)
 
 static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 {
+	int i;
+
 	qe_muram_free(ioread16be(&priv->ucc_pram->riptr));
 	qe_muram_free(ioread16be(&priv->ucc_pram->tiptr));
 
@@ -769,6 +771,11 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 	kfree(priv->rx_skbuff);
 	priv->rx_skbuff = NULL;
 
+	for (i = 0; i < TX_BD_RING_LEN; i++) {
+		dev_kfree_skb(priv->tx_skbuff[i]);
+		priv->tx_skbuff[i] = NULL;
+	}
+
 	kfree(priv->tx_skbuff);
 	priv->tx_skbuff = NULL;
 
-- 
2.52.0.120.gb31ab939fe


