Return-Path: <linuxppc-dev+bounces-20427-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876CCCD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 16:08:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8RQv0PhFz2yZ3;
	Tue, 05 May 2026 02:08:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.158.144.38
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777910934;
	cv=none; b=INVH+tOfzUSXOgqdNc7nwfWGXA8zoO9BTRgtmT8lYfkSRepjw8u2ZcZZWbg1cGbWzOPXGFmbtmIrTXQjL4v/P39+m82kMfNCRxt3gRyH3wLCE7dPpSEoiiYwehR5gQU5M1YHr0HlyLf/U22tam2aEJECjitdQtkYobZcqapzR2fKF50OIV472ndy0wqJnhxPnzH2UkdLuE/evZvZNGheb5tHWXQ/pqSVLyeg+lONyGqJARhcJ6ObYuFmt3uAwk/8y13zg22s1mgryIzwmUDuMUCaScDlyMTzpeI7M2xu6+0D34rRmoXYeMkVrjy/41qcHsFowb4za1k5EbgrRQAZ4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777910934; c=relaxed/relaxed;
	bh=EUFvEmeJBYqCCX1r0w814BKzBUANfrvmRMxAJS96h18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVzpSCIpovqp5+o2BEwbHFGeNtsAeLdM5okMXlF1ZknbMsfWQNQWTTinynS+hGK0U7/LXNNL0s1fbOs3bkRa7/t/dLiusEX+egekz9mFiE/sLn9Qd4QvMtuHuXgnIXdB/LUhhl1PynwDPaRNvM6B0W9GmtqjK4mz6IkTRkBBoiATDXsHvTdQmmDFHMcOiuwuIl/5kb/9PDa/EYy3c/oJl0dsPMpeNvJNToN1SyJ+57wRrI5/uiex6djKTeM6afbhJFaxQofbo6E+DNj7PYSb8+qWdF7/E8U/KlJjkSQ3pF/c313w7Ci4OkZnSf2MFjoteOO2yC3YtTLeedRp0JxpAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=a7KxS1+D; dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=JqlCWN5p; dkim-atps=neutral; spf=pass (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=a7KxS1+D;
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=JqlCWN5p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8RQs5ps2z2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 02:08:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=EUFvEmeJBYqCCX1r0w814BKzBUANfrvmRMxAJS96h18=;
	b=a7KxS1+DMo3GCRzDjro+3jvHgXyxSOX71g4vnjll0o3PHDWDCqrOoqmSNA443W6RCKac4XtHGePd7
	 bbC6zugZ/6GLwvp9I+42mlFA0qOfbPlRY4/33ZuCwflmT5/sLWUSqJ9qHpVKsyTPcXXfFaYJx6gIF+
	 v7a7120lo6NRY+9M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=EUFvEmeJBYqCCX1r0w814BKzBUANfrvmRMxAJS96h18=;
	b=JqlCWN5pwrwG0vPw6IkjWXoz7CKxURrr29G+b1T1FtqgsltXmS2Os/q+6TYDdI0GpRzDQElOQqgl5
	 mev3uuZZLw7RP02QY5uGcKVNDXNU0ZZ4gr2x7AzOHxB3caJJ7XKODYk8wDePW/EvYzd9Xh5b0IkM73
	 zOKU+gkMRjEzA7CzqKx/3G3BVfHjViL7VZUuiMYwecK9a1NcIKccMnoTw8/mokK5JSyDp9K1zuEVao
	 92IRqm1d1u1w7by1LfVDmv9SgaNVk2yv1IrwZPMKTcXWsy2DOoYKaqlIVoZLtGs4f1xV52Bux229FB
	 Nftnosh/hAejpWt9Xon+MOYF5KYNQ/A==
X-Originating-IP: 20.82.50.241
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 5de56510-47d3-11f1-8ef3-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 5de56510-47d3-11f1-8ef3-f54febe22707:7
CFBL-Address: prvs=058485b737=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000426.corp.hitachi-powergrids.com (unknown [20.82.50.241])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id 5de56510-47d3-11f1-8ef3-f54febe22707;
	Mon, 04 May 2026 16:07:38 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000426.corp.hitachi-powergrids.com (Postfix) with ESMTP id 51B5E805240;
	Mon,  4 May 2026 16:07:36 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 25F0C60B7D47;
	Mon,  4 May 2026 18:07:36 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH net] net: wan: fsl_ucc_hdlc: fix indentation error
Date: Mon,  4 May 2026 18:07:34 +0200
Message-ID: <20260504160734.2217382-1-holger.brunck@hitachienergy.com>
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

Remove the whitespace to fix the indentation.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 09081f128a98..adf3863463f5 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -764,7 +764,7 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 		qe_muram_free(priv->ucc_pram_offset);
 		priv->ucc_pram = NULL;
 		priv->ucc_pram_offset = 0;
-	 }
+	}
 
 	kfree(priv->rx_skbuff);
 	priv->rx_skbuff = NULL;
-- 
2.47.3


