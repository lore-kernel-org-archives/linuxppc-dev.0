Return-Path: <linuxppc-dev+bounces-17472-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D68AFD0048
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:05:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNlkt3cmHz2yFK;
	Sun, 01 Mar 2026 13:05:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772330710;
	cv=none; b=aMt6Em/HEtMKSI3qCJeM9gRp5U3pZpF3LVWGB1ET14VTD23povgT8XSSPDzZa/SPZcgDuwob9qMusME7Hs/gYnUv3laQDfCo+W6O3Olvk1N9icp5h8NRwc7NAMnc1KujP3HCyrPx8wXZJkpXaz9eLBKKueToH4Xt9tmSMmSTO4S1C7Ky/2CAUJFfFtg425RpUMUBA54AOKt8mUnDcWO7k5BAgBfHXndTIHnc3YT7udtY6kcWVpRKm3Pdnf3HvU87juquyY8vOInhmGk7nXUU10c3Vldkb5RoFpdgQuDxADq/gLUosfwyjz1f6c5hgfBNZdlsbaCMLoqqsDMbyRygXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772330710; c=relaxed/relaxed;
	bh=KJywk6AbLeXf2UqoXtVdTHzlC7gZN0CSRgeNutJjjyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dll7Wt3UCtaAqgsWc9D4mmnSR+CSCppsEF12sj9BOQ/cshnvU1E4nP3obTAPXbf1w1jD6MNomhw4ndS24xQJg29R5gaFt+eCNmg5PZnCQNewvh/L3MyvZo0pwL7La+poNnDSnAQZMOaFz80ugyXIszfOUzuHP9Sih5Uq5rRRnSql9NHLACumzapijJuKsk+IRu+hBsv8LrC2nEZOW/irSQgjz40hCvvz9OTxF3gFTHoYprOwKaShmDsEnrEkkfpJFqTu5EGQtKIsJerpKEivYJb3ia9AAOgsBeGgPm1IPavGNrye5/IPfsL1QjCMUaLtR6VfU81DBBv5cvNI3YEe6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h5mLkQg3; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=h5mLkQg3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNlks5TMgz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 13:05:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9095F41868;
	Sun,  1 Mar 2026 02:05:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CFEC19421;
	Sun,  1 Mar 2026 02:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330707;
	bh=Y72sQePBqKk53X31E47JkwQ3KAQtc3l9jiZoM8T7RV4=;
	h=From:To:Cc:Subject:Date:From;
	b=h5mLkQg3SmkJUfF1EkNXMdtvblMOxzVtSsPIHczyIWEAQBarrfwTYFCHGK+TfFb8u
	 iYs6qTVUZ2MC84MvyDerkTuoYBIgKeM8yEZZtcN2qIQa1OClk2hDOC2VVR/N1cS58S
	 Ld39Xr9xM5GhncUhcUT2R2fvHVRWyjdxHsfTr5Zo2t1DxVNB70u7UO+CcMA2N8eCe5
	 JTGweFrtRZdbfbwmDqGnSTKXUinWRn8sshRYYJBMzfoAl2wBuesqhQmvK/kGFgRLJz
	 iWuJK2tKNlytMXbnWmyBPIt2zVGRe/TNsrn5egZvurAvekEq9iibojHlU0Og5yEufO
	 ZyOVeljuyt5gg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()" failed to apply to 5.10-stable tree
Date: Sat, 28 Feb 2026 21:05:05 -0500
Message-ID: <20260301020505.1733714-1-sashal@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
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





