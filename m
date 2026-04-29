Return-Path: <linuxppc-dev+bounces-20275-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3772AFF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:03:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5GDL0JwGz2yVL;
	Wed, 29 Apr 2026 22:03:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.158.144.38
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777464225;
	cv=none; b=Fx1NoexrVgCldxOSVi7Ph+PdzJF36J8yIvB2cnARqQWrzkNLWGpNZdwUtgW3YLKDl72zhaYuBtQarD09gTGSZJLSlTfF012h4nKNVcEKBMZC1I26alhe0VbD00IuWD5mzIQz5XjhdwIbyFT33dNcHrEn31545xXvX7Ujzed6YvlMilPNhXOFZ2Xk66CW7PiIJWgV9diodkGbwpNgjxjiYtD+1swp5v9l1Idjf8pKnGz1NOukCWKdzXRTLKZAWTwaoFsfE7lJyLUCIq0ymn2e9vm3OyScpewPXSOw7c9hpfLJz6t2dMCJwYZrub8gHhWUvOd8Yo0TUU2qXQd5WrFjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777464225; c=relaxed/relaxed;
	bh=dTVmkDqISXk7x13mQynSnLZ/iRnnoPVhJt0i9GNoi3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbWLf5+BzNI4YgKt6rhYIq2sWylJSEyKotjHcrVIPuyi0H6Xe1pZRvFZULfGciuzjJoHxlef0I2K7VOkBT6bNgY9jX3Q5nGaYOasVtz1IzOJSX/uR3RUI8AcilYPoI9aN5Y1KGtUm6N2nDN1nJn/wkdegpIahwaJ6mwunOkSxmK0FvMmCzgm1ymSKKUxm7otxvtwjCdE5xIHiERDwoxUrDl8lM/xYxk3j6xgXOFrd4Yv+hWD8jc9cwUUxumK4BByjdB0Iwf5JufPajAdjct/cyni6xCjFZSg9co3H3QP0zvTwdNqWYNE+67mrd9lgzrM01N3WTJfC29rVv8z75o+1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=ZGTD+XNz; dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=gJV5pOTh; dkim-atps=neutral; spf=pass (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=ZGTD+XNz;
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=gJV5pOTh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 1209 seconds by postgrey-1.37 at boromir; Wed, 29 Apr 2026 22:03:41 AEST
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5GDF05qkz2ySf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:03:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=dTVmkDqISXk7x13mQynSnLZ/iRnnoPVhJt0i9GNoi3E=;
	b=ZGTD+XNzAA0enB8AMBQIHtnH04p0HXB5bRl7VsRwfesHyydsfWitH9d2AFW2dGv5tsYpnyABm6ubT
	 MOFCSpggCiVVT5iuSbKyVO6ylmqdi4ntRPLwiDDzHPvADI794WZF6kk16Bb9zrlgNd6i2a+LAMuySW
	 yRmSKgJ+QpLuWC0Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=dTVmkDqISXk7x13mQynSnLZ/iRnnoPVhJt0i9GNoi3E=;
	b=gJV5pOThWdVKrQZ0Qj6zJ26354/jUJ/c7mdArCYGLiJY5yiPUtR/KaWaR4ussEsYc2B7jANs7x8Lr
	 7e74M/uRR14h4iCJz1rajHslcxw4No51RPgiCR1A0bIfKq/119xyKczaH7UrDhdQ8m7Swb3jRMerPs
	 fhBTZjsSJAHXPBkcouL+RVqXLmqWE36i3E0J/W3GwJP42GaHFtvfywD3rUrJqOhynblU6u3LoEMB3k
	 yoqr8TqfgSUJToibLp+52ymriHsj4yPaa8Z9xLDwjxr5LH4bSNNp1qiF+HWe+JK63ZLYJlxHQs77Ev
	 TXuTrr1g2oiyCLNGKEFx8ji7qkvyD8A==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 7752593b-43c0-11f1-8259-bda8640e0fbb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 7752593b-43c0-11f1-8259-bda8640e0fbb:5
CFBL-Address: prvs=057955d709=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown [20.62.140.138])
	by outbound2.eu.mailhop.org (Halon) with ESMTPSA
	id 7752593b-43c0-11f1-8259-bda8640e0fbb;
	Wed, 29 Apr 2026 11:42:16 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with ESMTP id A9D4E1614;
	Wed, 29 Apr 2026 11:42:13 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 3563E60B7D47;
	Wed, 29 Apr 2026 13:42:13 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH 1/2] net: wan: fsl_ucc_hdlc: fix uhdlc_memclean
Date: Wed, 29 Apr 2026 13:42:07 +0200
Message-ID: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
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

Unmapping of uf_regs is done from ucc_fast_free and doesn't need to be
done explicitly. If already unmapped ucc_fast_free will crash.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 3bd57527b1be..8155e92af14e 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -773,11 +773,6 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 	kfree(priv->tx_skbuff);
 	priv->tx_skbuff = NULL;
 
-	if (priv->uf_regs) {
-		iounmap(priv->uf_regs);
-		priv->uf_regs = NULL;
-	}
-
 	if (priv->uccf) {
 		ucc_fast_free(priv->uccf);
 		priv->uccf = NULL;
-- 
2.52.0.120.gb31ab939fe


