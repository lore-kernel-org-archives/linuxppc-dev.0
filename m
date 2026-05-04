Return-Path: <linuxppc-dev+bounces-20428-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6BACD3427
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 16:13:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8RWj68x6z2yZ3;
	Tue, 05 May 2026 02:13:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=18.158.144.38
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777911185;
	cv=none; b=imxke7GdeKr3sIlEZ1YCe3QAkQeaP3oZn40bf4HZu/NZIkCzHOwJBpdS5GZAcGw4TMAV7fc2hpjkKid/Yqg7cQKWz91AN/Mo+ROeY9np3Z+d79Ho/nn7kDQbyTfLnOclbPR7V8r2R57FmHZn2xoD7mtu72sJ8BFdjSoj77DBX357Pv6vAvMBr61YY4M7UNqV/eB74RGrA01oVQTfkbvMw+PRTmiyfoaVoYwdjPpOakR8e6Tf7MJ6hpDGmPJyhnEmohhEZtscvyJkDRdP1k/V5KaBDJYF508WyqtdJQn618lmZV3J86E60QVwtPzrzGT/3ibLly0dFoDxXfTfWHNcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777911185; c=relaxed/relaxed;
	bh=9orVYHdnXQuOz2avZekPiqkyjnG9PMJehPUQET09zII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9zvveST9pufDmJGWVeuGSWR4W4DZfaMBv76NXWVW935p18oQwy3eSGV9KpJysnNJzsHRpdfhQzgYMu+8CwpMidOb0gBf08IfalM5RUMr55UWs60KXshK3fe+ly+AZyhW0/witaGlid3CLq++gbIsOS8ZeISh/TfQ9bIjts8AxPoKTSBVEGvFO3rLDx/JTCoHaM/fTki3EuO8HcpZbMQbMmSpm4GdXoZgrkR+J2y+lNj0uYOIXIvET4sYrhbQi6DlpeSyOJZkZSg8tcoCTdSpbgm0iv9KqwcbvFoq0P1qA/M7WbKIXyjn1spY+nhD82m8tBn/B8UCcAzfMZWRDerZg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com; dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=L4rVJzon; dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=nhwwqAIS; dkim-atps=neutral; spf=pass (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org) smtp.mailfrom=hitachienergy.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=hitachienergy.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=duo-1630306886989-947ac67a header.b=L4rVJzon;
	dkim=pass (2048-bit key; unprotected) header.d=outbound.mailhop.org header.i=@outbound.mailhop.org header.a=rsa-sha256 header.s=dkim-high header.b=nhwwqAIS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=hitachienergy.com (client-ip=18.158.144.38; helo=out-ip0052.fra.mailhop.org; envelope-from=holger.brunck@hitachienergy.com; receiver=lists.ozlabs.org)
Received: from out-ip0052.fra.mailhop.org (out-ip0052.fra.mailhop.org [18.158.144.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8RWj0n7Rz2xS2
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 02:13:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=hitachienergy.com; s=duo-1630306886989-947ac67a;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=9orVYHdnXQuOz2avZekPiqkyjnG9PMJehPUQET09zII=;
	b=L4rVJzonX/wd7VGUtHCwS3CXy6fXgi1BAQ9HfkXgyoegw0jJQg9qZZFEG7SJg0advoY2ORJA/1tvb
	 Lyq0zhfhnerx2LrcNATSvNMqhiwu0oH6425fg4jeMoJtN41UZTF+IbkFmuryx+n9q49oYdTomtUE/r
	 4N89RKUlfEpB6rYs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=outbound.mailhop.org; s=dkim-high;
	h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
	 cfbl-address:cfbl-feedback-id:from;
	bh=9orVYHdnXQuOz2avZekPiqkyjnG9PMJehPUQET09zII=;
	b=nhwwqAIS/lTWLBZ0NcvrdoMYI7ZZ6Uf7IotFc/lzK0bTlkVfZEGyWnfgvS0nPTkx5KcePzaid7Pa3
	 C/TR+sfg6qr9aASz1RwpAbMNR/JsdMosIVinGjbCpD5Ujxkes50ri0h4Xj9cn+VXGY3KlBhSb2a8wF
	 TZKmyWTysuVpg5dpDPcYqS+0CF+Jzycsco3ZM7S3k6F5pLbM7iLQVhXE1sUz48PUTjiADzSFR0etr3
	 FPvOuji0weLyFlRDi81qvESxdqY6ILI0q31FYXDNmOI4neqkXQEeCvvwxIv5Y9LnJ9sme0p0hqHA8y
	 uETHDiIPObaMxFLOAw99MVr4UEP5DIQ==
X-Originating-IP: 20.62.140.138
X-MHO-RoutePath: aGVkY3NtdHA=
X-MHO-User: f42d5b33-47d3-11f1-8ef4-f54febe22707
X-Report-Abuse-To: https://support.duocircle.com/support/solutions/articles/5000540958-duocircle-standard-smtp-abuse-information
X-Mail-Handler: DuoCircle Outbound SMTP
CFBL-Feedback-ID: f42d5b33-47d3-11f1-8ef4-f54febe22707:7
CFBL-Address: prvs=058485b737=abuse@outbound.mailhop.org; report=arf
Received: from HPG0000000548.corp.hitachi-powergrids.com (unknown [20.62.140.138])
	by outbound3.eu.mailhop.org (Halon) with ESMTPSA
	id f42d5b33-47d3-11f1-8ef4-f54febe22707;
	Mon, 04 May 2026 16:11:49 +0000 (UTC)
Received: from gitsiv.hitachienergy.com (unknown [10.54.139.14])
	by HPG0000000548.corp.hitachi-powergrids.com (Postfix) with ESMTP id 22E611359;
	Mon,  4 May 2026 16:11:48 +0000 (UTC)
Received: from chbrn3-p-dev015.keymile.net (chbrn3-p-dev015.keymile.net [172.31.41.201])
	by gitsiv.hitachienergy.com (Postfix) with ESMTP id 9A24960B7D47;
	Mon,  4 May 2026 18:11:47 +0200 (CEST)
From: Holger Brunck <holger.brunck@hitachienergy.com>
To: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	andrew+netdev@lunn.ch,
	chleroy@kernel.org,
	qiang.zhao@nxp.com,
	horms@kernel.org,
	Holger Brunck <holger.brunck@hitachienergy.com>
Subject: [PATCH net] net: wan: fsl_ucc_hdlc: free tx_skbuff in uhdlc_memclean
Date: Mon,  4 May 2026 18:11:45 +0200
Message-ID: <20260504161145.2217950-1-holger.brunck@hitachienergy.com>
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

When cleaning up the resources we need to iterate over the
tx_skbuf array to free pending TX messages.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Signed-off-by: Holger Brunck <holger.brunck@hitachienergy.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index adf3863463f5..68f78aeabdc3 100644
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
 
+	for (i = 0; i < TX_BD_RING_LEN) {
+		kfree(priv->tx_skbuff[i]);
+		priv->tx_skbuff[i] = NULL;
+	}
+
 	kfree(priv->tx_skbuff);
 	priv->tx_skbuff = NULL;
 
-- 
2.47.3


