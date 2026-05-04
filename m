Return-Path: <linuxppc-dev+bounces-20426-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCB9FF885A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 15:58:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8RBy2Fcpz2yZ3;
	Tue, 05 May 2026 01:58:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.158.144.38
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777910314;
	cv=none; b=jDAjZW7I6VsJkO9zVdNetQj1BSpmHLS+9tP53jmAm4Dxyls1+3bLDKL8zE6tEQz2gR7pGtsovDKd0jX4VWzAQq/9kAHaxUtdTJE+i3UHHN3Fz8FHJsIBTwgaMV4MLF7k5/YIbWQzJCHdKFIWo23IwlJNi4hiqhLlaOQUGAKjAFnD9nrlAJahGNRQhtyWd2gTLBsyOr1fficFpXroDMUe0o9o7f3hCmau+MYevpYLFX0RgsnLA8TJDSdSSZqsUNeEVOEGnbL4GVT1+Ozx+IzKcM823frEUa9XeP9C5c6IsqBk4x7dUCKwcVxSLH6hqhHPQ6EbzwjEOraGOhEAFWeTqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777910314; c=relaxed/relaxed;
	bh=0BKXpo1u7lWawTu7f0xL5Pp283L9bUuja2ZdCCoXRl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dD9OJM5YOSr8+W+rEdFwP1Y9C32W9sdLf6Ah7li8zVri8elq3PmcshgSqPbiTnyg5plmsQrs1tD8oI9EAzmKSBMCb2qIpdDnaK89Uc6aP0ufG50xNZ0lrPYbe2w1RDKLTE554OfDCvhzt6Y8VO+4TYroShZjZqa92hky/tkDQiXzt8mnuquUz6VgkA4UJS2d+qbuHsSksFA4hG69fN+hbbykM6sOCdF4EuzKhtyPfLDgO2bB/mIm0nWL/TWb2lD3EQ18sKl4ZQhaukuuHhnP8ozMbm3p2I377dFj6DoAMS7INaI1MWrahqqLExz11vFKC6cTROnIxFnxvFQRIAXUwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=tDkts/HC; dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=G7n3067C; dkim-atps=neutral; spf=pass (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=tDkts/HC;
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=G7n3067C;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8RBw2ty4z2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 01:58:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=0BKXpo1u7lWawTu7f0xL5Pp283L9bUuja2ZdCCoXRl0=;
	b=tDkts/HCeoqL5MpBao8w1vVnuT2uVkhib1kiGNTc1qQpr8KH/EmekgJAUVXkeq+Ca+qVjL3YewOYQ
	 T6d9rcuo1Ef2SZJojde3ul6q2IXgBogEqZAmzbUlG1Cn8zY2wA+8qOXGsSR/V+8XgobrY25cmKk0R2
	 2ZK7c3kotn1wjPsk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=0BKXpo1u7lWawTu7f0xL5Pp283L9bUuja2ZdCCoXRl0=;
	b=G7n3067CxRdbA8JM+u6wHrwQCKxfEXduN8A+FnFJcq9gw4PTGpj5smHCCP2CQJPwNBo3oWCD82Dae
	 cBKlNwYmYQbkA4Hgaq19w30dZlzwXrI2EaMUZyEoTbjxIr6C1/5JD/lkWuXSG+YdVH6ZPGl3faVduq
	 6bKVTnljKswCMTNFiO2GeTscesW1eAPS5zLca3UC6L0yvlBi2qUF2gdt/wMdK13/hr9/xTeVU+Cqn2
	 Zw8qigyMj9ZVsFEd06LxG3drfzhFfOiSO7Wq0s5ZQvb8vLsP6axNcCLVOLXgF//NUZ2taZ80WwP1hi
	 2YXmRg1zwH3J0sPv+QngKKikEH7Adxg==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: eb4e0fb5-47d1-11f1-8ef3-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: eb4e0fb5-47d1-11f1-8ef3-f54febe22707:7
CFBL-Address: prvs=058485b737=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000534.corp.hitachi-powergrids.com (unknown [20.62.140.138])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id eb4e0fb5-47d1-11f1-8ef3-f54febe22707;
	Mon, 04 May 2026 15:57:16 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000534.corp.hitachi-powergrids.com (Postfix) with ESMTP id 541C9402502;
	Mon,  4 May 2026 15:57:14 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id CB2EF60B7D47;
	Mon,  4 May 2026 17:57:13 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH net] net: wan: fsl_uhdlc_hdlc: fix dma_rmb usage in hdlc_rx_done
Date: Mon,  4 May 2026 17:56:42 +0200
Message-ID: <20260504155642.2216040-1-holger.brunck@hitachienergy.com>
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

If dma_rmb is used it has to be done after reading bd_status and checking
if R_E_S is zero. Therefore we need to move it into the while loop.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 15bfb78381d4..09081f128a98 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -523,12 +523,12 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
 	u16 length, howmany = 0;
 	u8 *bdbuffer;
 
-	dma_rmb();
 	bd = priv->currx_bd;
 	bd_status = be16_to_cpu(bd->status);
 
 	/* while there are received buffers and BD is full (~R_E) */
 	while (!((bd_status & (R_E_S)) || (--rx_work_limit < 0))) {
+		dma_rmb();
 		if (bd_status & (RX_BD_ERRORS)) {
 			dev->stats.rx_errors++;
 
@@ -610,7 +610,6 @@ static int hdlc_rx_done(struct ucc_hdlc_private *priv, int rx_work_limit)
 
 		bd_status = be16_to_cpu(bd->status);
 	}
-	dma_rmb();
 
 	priv->currx_bd = bd;
 	return howmany;
-- 
2.47.3


