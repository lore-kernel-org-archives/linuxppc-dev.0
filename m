Return-Path: <linuxppc-dev+bounces-17463-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B38FD0049
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2026 01:38:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNl874fyzz2yFK;
	Sun, 01 Mar 2026 12:38:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772329111;
	cv=none; b=CMVFJkLwdKIBiNcWrGqpMurWkA6a7fp/sF23wSH0y0xmtWGeySxjYzPvhZ7SjwY7l2qWUghyzgrMhMPNkIlohEpFIfxajOGC/SlzAUReGqZoOKq6RkiEV2afn77dWjwmlQn0z4LZGaAt2/eUgQQEw4jMeqAJoNHf6rapI/KOwrJh3gzOMfgsfGlWTt16hzw5gSsdYmNruy00PxVViipZKGTQktV15jFfoJELcguYj5mb/zbfH9/mvZPR67XCLVEhc3mPIWHiH4RsFDrzv21fLhwlKaiV/rC1vQJigmXj1UGD1a825Bb0g0W66QWp7MF7hE9vVfXLWAVCBj8Y+du99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772329111; c=relaxed/relaxed;
	bh=BXRdPAcQl8TeX/oHfzibV2ezp5XrgF0uGARPh95fHns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ITHT8zCjLqS7rQwuP0ST/aXOB7uUlhQFJRTfj+kABOTou3j4JhMD7gBKvsOGaR2VxoEk8x9zXe4LQlumdPpCf927NyxK7s+vzA+WgjQdnryIeL1CN4gsNgtv8TddCHCNP1bjSkcJPRx/gJe2Ktqp8Ctfpj1DprjFmIcyT6nCahhVZhVfHs7H9I5T7fMw9CNnhvOJOaA/j2e331pn2xntWtvxNAHCX2Iub/2+ikR8xzn9Qu8E5QrHf8VLLa8PIw5tq77cmGGbfoTzspNhLx5DQTX9mBg9gAynmlXqGFiGNptJNvA+DCLlUBCN9ULVRU6zmKBx+X3zJfibXT4QhO98xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q8oavIFB; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=q8oavIFB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNl864bydz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Mar 2026 12:38:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id A4DFC6012A;
	Sun,  1 Mar 2026 01:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB26FC19421;
	Sun,  1 Mar 2026 01:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329108;
	bh=r83bL9Ip788wcTF1R+/r0bNkCXbnYOhnB1jth0XjJ5M=;
	h=From:To:Cc:Subject:Date:From;
	b=q8oavIFBm2JDgKkXBKsHOY3v8KEaLpbACqpBnMkl5RIHP8o3cvEq/qWvQyzQm9wey
	 OSVEcZXwPX5XL6FprF/yOrW2Y9uomcL2mk9VCkPqsMnTFiKsFIjNjCcWRiE0RGF4fE
	 kHgMwIjakERgbM7klV5Gyps61Sz+8dYKPwwm8U8U9B0lpQyx3Sq3Qpshnxpiv+SlIO
	 9/p16dFfAYymofgk4Ns8svxwlmSuxp1BSyUR+SkY9FZGvzCQqulG9xzZarn2wXDpRy
	 /ogysGZ545jRJGv+pRD/dfpnJbObpDf9COBcLptvX2oDs53nSIbu0jCVzRjqyIbXvW
	 070hnOlMeSOcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	fourier.thomas@gmail.com
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: FAILED: Patch "net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in uhdlc_memclean()" failed to apply to 6.6-stable tree
Date: Sat, 28 Feb 2026 20:38:26 -0500
Message-ID: <20260301013826.1698870-1-sashal@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
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





