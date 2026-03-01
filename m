Return-Path: <linuxppc-dev+bounces-17469-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A47FD0045
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 01:55:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNlWm1q1Yz2yFK;
	Sun, 01 Mar 2026 12:55:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772330132;
	cv=none; b=QREiF8/afNltkHUzTiry15R20UJecLudPZnaAxC84ibZPMNKBigDfNGZWNON+hHF+Fsv3bSSExqWySXPzR5Gzn0wrll4taRHAp71q5Wrv9k1756X4+HvgSZRh/EaZ5VvjHGT9/WolJHcz6/8yfpNVeZWxWkoH8l8vHalwpm2jdK02MQLpvVTnmvEgDdiwHq1e1xUp65N6/Ln5x0u8RDyCS1Hh5jTOe3aU1PBVxBWHEoNSe1j+xCPNGrxEnuHonVQJ/xDm3debhGLxy/fnSA1qwDDEIBG0wzn4Mg7myrecHodHym+HBTSzTLMScIB2qhAmygT6AKw6B3lCFbNLcUj3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772330132; c=relaxed/relaxed;
	bh=yrKauqgaIC/I7+yafloreKHKFJQx4XOupDFUqNNoqY4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQuLNjF19nYO1utqHANGuh8eIvglXfZoip8mYsFx3XxFu/pgRqDm2tvmL7EU535oUqULjSiPP4nFpOwcDXG0DyggRNK6O+zcw9cGMMIN8d2uNty2+0n2/VqhBkU6MU3r0KmNfchU5MzSU7Akj4lhZ0/JCoxMSTrygPehocqX+oBPKJeU8EXQNA/gFAMgjm3AGie4aXjM1pn262zZ1/fpbpxFEuUWAgVzB+muqKCIp+XM2R/VgiwnyBNVGsBlOAQO/WjUlo+uB1lS3TdY8uYdbBFbrvs+5Nlv/JXqGcsvJdcdh4kuVtT3GUgncDbLI/Fjxz09GH9OLo3p4CNuvM2Wfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=an4e6LUV; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=an4e6LUV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNlWl3lD5z2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 12:55:31 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B2D0F6013F;
	Sun,  1 Mar 2026 01:55:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E5C19421;
	Sun,  1 Mar 2026 01:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330129;
	bh=iRc7NPY+3aw9BU8UG95dnIYKZF3Ie7BM0RzBb8KyPAE=;
	h=From:To:Cc:Subject:Date:From;
	b=an4e6LUVzESXt5XqGzNkyTwYp15W5tbFbS8SHJwCVj8nhJ0gBjJ1Onwd0D0d/TxqP
	 /Kc2nAnki/Ni0IjCFgqG+/XKBVYj1RRHvsO2eHUgLHmRmN7pcUh4TqxrSI5xCvUsXE
	 72jU0fMtumpu5zMgSsFpH2UYUJWKBacwaV9czzTk01eAjdQtB9YT52E7REFeJPNRUd
	 zv4x0ha1qIvtFh62aEPPyaRQRTYBbO45dmj9h8yq+21Ghq1Q3aYaf6lwD2lKAqPKfR
	 4XadMwgCsn+pzPZLZUo3xbXYCo/0i/DeYwnsxIWQ3wz6c/TvZ4UJh9u2e21s5YIJ4o
	 RngyZLXcTMDWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:55:27 -0500
Message-ID: <20260301015527.1722681-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
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
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 36bd7d5deef936c4e1e3cd341598140e5c14c1d3 Mon Sep 17 00:00:00 2001
From: Thomas Fourier <fourier.thomas@gmail.com>
Date: Fri, 6 Feb 2026 09:53:33 +0100
Subject: [PATCH] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in
 uhdlc_memclean()

The priv->rx_buffer and priv->tx_buffer are alloc'd together as
contiguous buffers in uhdlc_init() but freed as two buffers in
uhdlc_memclean().

Change the cleanup to only call dma_free_coherent() once on the whole
buffer.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Link: https://patch.msgid.link/20260206085334.21195-2-fourier.thomas@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index f999798a56127..dff84731343cc 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -790,18 +790,14 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
 
 	if (priv->rx_buffer) {
 		dma_free_coherent(priv->dev,
-				  RX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
+				  (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
 				  priv->rx_buffer, priv->dma_rx_addr);
 		priv->rx_buffer = NULL;
 		priv->dma_rx_addr = 0;
-	}
 
-	if (priv->tx_buffer) {
-		dma_free_coherent(priv->dev,
-				  TX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
-				  priv->tx_buffer, priv->dma_tx_addr);
 		priv->tx_buffer = NULL;
 		priv->dma_tx_addr = 0;
+
 	}
 }
 
-- 
2.51.0





