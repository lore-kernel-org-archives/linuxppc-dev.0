Return-Path: <linuxppc-dev+bounces-7399-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD0BC3600C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 31 Mar 2025 14:53:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZRDfJ49XRz2yn9;
	Tue,  1 Apr 2025 01:53:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743432824;
	cv=none; b=MdHKPvyui5R86g3VHhoersfN2mOhS5kBweASPq6sUcBxwPR4GGyUzBdeT5oqVQEwRFzos+I4zbGpIOL11ygW8WxbOZbMMnYwzV1pXTiL66uofLscu3ThPn0TLw/CmQrBjZL2zQa1J5DxhKh+qwhcHxtdPyhCRbDr6APZmYGs/PRAMsXOkMfwb0Wbyt+jIWek456ND3F6v3CCsSNvh5+Z6utJS/s6zYXs/6LB4NnAChDWzQe3/OjbRdX+M7hMHBM0rCRLn/ZpsSVDazcxQfakjWkz2b/TeD/Hoy2oe2NQY0DCOmVby7HL/yW+UzeYArLaouGT2p6t5XSF7egOnzOshw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743432824; c=relaxed/relaxed;
	bh=1v/1p2Yj8qA125rNjTUSBxlrAI7RMQrGeSuEPED6ACQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TdRiaVI8Wu88ciwLaPCA0BKE0BxMYCPzTLdSJiqCZDI4zc0YTxxKLXxBOdkJgb45M/fIQASev6JUaX9bhz/SyBv4ueCqLodZrwPFZgiQByV3Z2l+x2wNhAoS0rqmzQTZE4A3sV50irRz2D4iTwUerMs1GWdGwQuh/ZcawlhkuQkfSf0BkREAwz1SBZwh6rmW3BsigVN8pbj4tdIGvEvPI85rlfdgrpPqbhZQUoSY+2oZ0akuvlUmeJwVYCgNVWDmLzTMalOon6zDUQmRoXle3lsbZX6kBG/Ppq2l+aqY1Ai7/i6R31NOjmn1vId3OcrN3rWKfcr9NhD3giwHdlCbVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ppbbQCfZ; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ppbbQCfZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZRDfH3YL2z2yVX
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Apr 2025 01:53:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 57D4D5C5526;
	Mon, 31 Mar 2025 14:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0935C4CEE3;
	Mon, 31 Mar 2025 14:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743432820;
	bh=DofeCn7+p+C7HWB7rPQvFmfiOTP/DSvjSaOvKewTANA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ppbbQCfZ8FoMwSG+keIfQ1s+9qKb65G/Fb+eqT1EmnK3mauJORmUbO2XFzR7taq/M
	 ORSYzdfPpTQpyJVYQvmjnrMAz3RUFS8OrOhMnWmSspiVAzxLFnUr+l5kC51k6tCWwf
	 jp3ntyeDETPguSeYlv1Btyq/MtOEmsH4CDqIKLcvP4f8CtzsVY6hmHqk8RnKPi4dCq
	 kW9HioM6Bmh9MPAuTMnaG7nCMF59OvjZxWI4VJkXkR3AdrN2u3qR2Vhd9cz4TO91sD
	 xm80222POndyuMn07Xac4uoS4UxpZuqvbpe4w0wh/AC2CnLJgqK8SSNY29uJaPeE5p
	 Q8RFn3kJElUOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.14 17/27] ASoC: fsl_audmix: register card device depends on 'dais' property
Date: Mon, 31 Mar 2025 10:52:35 -0400
Message-Id: <20250331145245.1704714-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331145245.1704714-1-sashal@kernel.org>
References: <20250331145245.1704714-1-sashal@kernel.org>
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
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Shengjiu Wang <shengjiu.wang@nxp.com>

[ Upstream commit 294a60e5e9830045c161181286d44ce669f88833 ]

In order to make the audmix device linked by audio graph card, make
'dais' property to be optional.

If 'dais' property exists, then register the imx-audmix card driver.
otherwise, it should be linked by audio graph card.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Link: https://patch.msgid.link/20250226100508.2352568-5-shengjiu.wang@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/fsl/fsl_audmix.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 3cd9a66b70a15..7981d598ba139 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -488,11 +488,17 @@ static int fsl_audmix_probe(struct platform_device *pdev)
 		goto err_disable_pm;
 	}
 
-	priv->pdev = platform_device_register_data(dev, "imx-audmix", 0, NULL, 0);
-	if (IS_ERR(priv->pdev)) {
-		ret = PTR_ERR(priv->pdev);
-		dev_err(dev, "failed to register platform: %d\n", ret);
-		goto err_disable_pm;
+	/*
+	 * If dais property exist, then register the imx-audmix card driver.
+	 * otherwise, it should be linked by audio graph card.
+	 */
+	if (of_find_property(pdev->dev.of_node, "dais", NULL)) {
+		priv->pdev = platform_device_register_data(dev, "imx-audmix", 0, NULL, 0);
+		if (IS_ERR(priv->pdev)) {
+			ret = PTR_ERR(priv->pdev);
+			dev_err(dev, "failed to register platform: %d\n", ret);
+			goto err_disable_pm;
+		}
 	}
 
 	return 0;
-- 
2.39.5


