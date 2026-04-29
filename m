Return-Path: <linuxppc-dev+bounces-20274-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F350FF8875
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 12:03:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5GDG6d1Bz2yjp;
	Wed, 29 Apr 2026 22:03:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.158.144.38
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777464222;
	cv=none; b=kPSRL72lxl3svgCdBqxa9kBt+QeoDtBq72Yz5NcRtW/2z+2WSnnFOuAuTSVyNX9DkC3PHdLFZYpfeoCQfviKYAx8kNdssN3KFyrdA1xBKt3Njh2Tk6NPbPr4S+YRgBPEPrRQNN6I33Z+h7gZPVTCiI8qeEzZxmWe1SwSYcRuXpqRj0nbdi7EGd4zBq0jEi2lXI6ZHDFUVS2hMSY6knMSTC+HHM29f68GxD3A5hEiw13I6R9gLD4Pts2cuRbwhiUXbRdHMw9X/4VZolcnCFuCDf7v2VCoXWPSCuquoqzLy5b+C/Oh+6CiNqJXtO1DYtCEeETwk5aOB36xKnp0U3aYsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777464222; c=relaxed/relaxed;
	bh=L8KWtdPE2JalTOCUmy3pa9Xkw2o8VCxZ9+OBKyymtC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWNlD+BO94KL3hs2wWIP+WmiXykvqLcPPJDHO715sYknIP5bpUZvsqy3F8D1Ug/MM6BVw8On8VOGgUNbP8AIIpw+U+yYBwc5NZWF+XjVIN79VUi38hXkvaO7dhkmc09a/zVJi9xNNpo/WxwiXqd/dd8IBB26+EH1amCK3e9jim9bhdMFRxHetCFtxB2ZJGwAqIvDSC3LpM6M0OiAv2kWuJGJr0NtEI8tGTW237EWXv0nTCFWLvZmxCwOjMD4ZX9QQ26EFrnOkc00i0VJwaddk7NLdv1V8fRBGxTxfGdvp24CX6uctpr3VsA2o+NoVGh86k+ywAFSdPP30skE+Chw4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=nbjJap7m; dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=kz0kNcUS; dkim-atps=neutral; spf=pass (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=nbjJap7m;
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=kz0kNcUS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5GDF0C6rz2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 22:03:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
	bh=L8KWtdPE2JalTOCUmy3pa9Xkw2o8VCxZ9+OBKyymtC8=;
	b=nbjJap7m4j+Q0FUNBANh6VVe0R4X9CyL6DCL+sPk56ESQkFgkesFRIgye4Ieu7EYfKKxYW75BUrdA
	 mEmxyP5vukeMYPybFAIN7bWTGw+kXPcfKGRlcAhvcVCRwxL41FyrMPT/6hW7qHfRx7M6kpJIv5lROZ
	 kq+Rq+MfrZEMiRAs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:cfbl-address:cfbl-feedback-id:from;
	bh=L8KWtdPE2JalTOCUmy3pa9Xkw2o8VCxZ9+OBKyymtC8=;
	b=kz0kNcUSsI5Tw/+Ld9hqOOdF9Ofo8XOWhFJif8qT4Dlkuzfp+aLKoqNuSQWr+2P5FhoZ6gvB++f32
	 vxl93SUyHWlWONKGI5tQOcxQWWuO3wXW3wfVQORUz9ix6KKIsIubIMhsSCWcs1LdQ/OSbES+C0t0oL
	 9sDT5XjRKUe2gL7cgGuG62cyG5ez1yQhGJ4U+Qk1GZQxeAvlfV4g8MARvXYAZHfdJYIkqCFCldX9eH
	 57EXfLAY8AtvBD6wAl9BPw8W5aRHg0wzdpgemfxF6j/hbLFIRJLBJrUm1jMWXL2g0zxRgYoOF8BSy6
	 TShXpOqYP5hBwnD4QEpl2dLekM93jlw==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: 775d39e3-43c0-11f1-8259-bda8640e0fbb
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: 775d39e3-43c0-11f1-8259-bda8640e0fbb:5
CFBL-Address: prvs=057955d709=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown [20.62.140.138])
	by outbound2.eu.mailhop.org (Halon) with ESMTPSA
	id 775d39e3-43c0-11f1-8259-bda8640e0fbb;
	Wed, 29 Apr 2026 11:42:18 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with ESMTP id B5BD5158F;
	Wed, 29 Apr 2026 11:42:13 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 412B6637F985;
	Wed, 29 Apr 2026 13:42:13 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH 2/2] net: wan: fsl_ucc_hdlc: fix ucc_hdlc_remove
Date: Wed, 29 Apr 2026 13:42:08 +0200
Message-ID: <20260429114208.941011-2-holger.brunck@hitachienergy.com>
X-Mailer: git-send-email 2.52.0.120.gb31ab939fe
In-Reply-To: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
References: <20260429114208.941011-1-holger.brunck@hitachienergy.com>
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

If the driver is used in a non tdm mode priv->utdm is a NULL pointer.
Therefore we need to check this pointer first before checking si_regs.

Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 8155e92af14e..15bfb78381d4 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1250,12 +1250,12 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 
 	uhdlc_memclean(priv);
 
-	if (priv->utdm->si_regs) {
+	if (priv->utdm && priv->utdm->si_regs) {
 		iounmap(priv->utdm->si_regs);
 		priv->utdm->si_regs = NULL;
 	}
 
-	if (priv->utdm->siram) {
+	if (priv->utdm && priv->utdm->siram) {
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
-- 
2.52.0.120.gb31ab939fe


