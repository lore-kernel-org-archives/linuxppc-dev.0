Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXfrXU8E
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTy2x5Hpjz2xlY;
	Wed, 18 Nov 2026 21:07:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794996473;
	cv=none; b=jeMBWE+dNvS+VBUOO79jxJI2bLXZtQlC8ZwmH++Zgm1u9y7k291wcbn0/7lz85tbiEkH7a8QWoEh5sni0MSI24u1Vhqzaa0q776rH/DDAsspWl7L6Xv9gzUparBcDbUgvLRx7IzZJWrEsGk36aE1C5Sy4UdvKbQQaszrSW0RNBWDrQ2nwlng0dSL5Kb44X94W/KwSY7uAbiBIsuYkjC0icrE+pxosVKbVBx8zKtyZ9HA093S0xdz2I+e/rK1rr+Q3QcqeQzBaGTltjnrhiLLwY6M54upDcRUbOBqfTvNjFFKr5QDtgyd5DKOhVKH3UHA1P1b6hSBbvN0gqxAaq2qPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794996473; c=relaxed/relaxed;
	bh=T5MWPlFjQcs/AXGmMiLfNtV+jA2eKvI6Y07n7HW2V7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jI87pmz5BvuMVmJ2JLZHRn/wnm8HN4wE8p6ap85PdggszqF7OJG91oV/F+gOzRHwENdhPwAhnbSRDjzutV2ZoZ35GK3VczMddldLcjEIqc/5SqSIMB46HD0U8WxZ+xrgG9k0vgl1jkN38geXo7tj4HqyOrW5lYvQheqWLEwApuEFrXulvzj3i6WgmLMUXq9B90tGQUkjAXPXaLryE/6Sz0gv+mi3iMpN9Yx/XZQ1Z3VTdgrbbg4jn5TUn/Q/3kOTQW+++pVGvsV+mW7oNGA8YV1MG7C7+EeH7/r904ZmlrVLm7kxYSl5mqTVnc4UGF+o/wMIbaw2yzgEXbf6iUIfhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXfrXU8E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mXfrXU8E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTy2w4SkJz2xdX
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 21:07:52 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2efd993e9d6so3457045ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 02:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794996470; x=1795601270; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T5MWPlFjQcs/AXGmMiLfNtV+jA2eKvI6Y07n7HW2V7A=;
        b=mXfrXU8Et/v4cNPO3vb+s6I5KLBYUtg5NtI5Hfhn+H/5AgjawZDaxY8BUa4GVTP3Eh
         N4taokVjJZR/8A23xXbDiVbbNA4rMcLAvudBuNXypDZolC/Z8YKlGmlKEr48iDU4h5wh
         PoyxNQFUQqvpbNWNJgsgwaFE/y3Qp/+m3mX1JBVo/00opAvHKNGaPx7rrwiWOeh8Bn83
         USjQrXw4fsK2hm/YwZQUU2w7szZ1Uxb0s8iZgOvvuMsxk4eBllAQ3i/uBC51+OuCoug4
         q7ZEMlYkuYuW3sXkIWVpB1T1m1NwCUZX3BP6f+vzoMNs4evmgqNa80LqbB7pIuBpP16q
         6Vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794996470; x=1795601270;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T5MWPlFjQcs/AXGmMiLfNtV+jA2eKvI6Y07n7HW2V7A=;
        b=Snn146pdwxhmqvMO1dmMBtXBZVvj4vvkQ4l011cqF8Ct4+bsVukO6Rl0kyIfJ/5hFx
         eOJntAVFFibxBlaZ8MOVUNDM/YCr80gjIi6Pt30JCCqO0hRIYyrGjD4bAhroiR4xH/H8
         L2F6xcahs8U83ua/aGvsZrgFva0IUd9kIEcz15oWB/UiPlpccjCJZs5NenhQm60eUmOF
         jm4GId7viiOMkJd19unhnyfU77++Dz12LwIQcB7uOoV7famo6lFVHgebAtlLKut9zaGJ
         gY/xXXqrp60Sb5MIlkkRzSpOHx8N+I38X2xcfEABv/Ej8i82trhsg0vyoEx4KWQYOmek
         hWiw==
X-Forwarded-Encrypted: i=1; AL+hErEK/+TBi7WHYNM5SQq0WIbFiY+batXP0BT6CbAwXBvyThALk00fcyheFDiHfm9GIRwn0TJggzNHN5rEqeM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z8CqeDuWdEWwvey58C65SDwDqs3nKl2CRjODp0+RRSl72+HOGJp
	gGmIFgNRqcKMr08qQILDhqbJ04f4e90/7NesnDJPQT2wpfcPZir8bp1O
X-Gm-Gg: AZFdTZfickT/5mYUIEhF+jt122gNDVCpgzWoVAyXeAGcJpEHTyKSJ0WCbxqfe7ZziIl
	cQsFdvUFPs1wclckSb2GZ2bUnWR1nDRFt16zFshcFMwGhWGNmS9GhYWa20W4wNIigL72x0iWQHi
	3uP4pfBxXU3B+YO8V07+1mPVUHnSuZsLPkZA9EcKeQz2s0KtUq74uXtbvavSTK7UOUHwckfOQlO
	+8D1gAdPNTCLtV/Ow8TMFsUdBpVNQwPl5SUzJNye59vRa4dpIgRHIU1vWJ03HpJQl92FxfQYIUJ
	bqnDIORkyZ0npBBoHydptYsYKZrDAGilwX+uRge5KIDs8mt0sNdI8Gul+yyloXwO7PnJJqx9dw1
	gQoVOUvopg5yb6G3ESP0DKxcaydChL/8nv19z0CaysjgMdZeKU05ibUmwcxC8xCXBFGyxQuJabD
	v1mx1n6JiLgjtS7RHXht6slA6vA0HSa7giiW3X1gpPwxPKcg6cc5kpZG55M4/rqmkL0HbiQNJk5
	6tsE6FOwtO4ntl7gMTZvzOoUTOLljRCCXYXj209b1urAXO07ht5HASpaeOoSz/xRVTMQo8zBHbm
	CUv3H1iTWNo3/JlaCMuGPyYpFjyKDXxGvse1jJxOjwsEsZYmzBAK2NX54tF4MRvf5pqzOH35GGG
	073uKzviIGnIq171FAQswaFTWeQah0I1TIDzr/I4kkVjm
X-Received: by 2002:a17:903:1a8d:b0:2dd:c053:b9cb with SMTP id d9443c01a7336-2eff753ebc6mr15920055ad.28.1794996470442;
        Wed, 18 Nov 2026 02:07:50 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eff6215025sm10634145ad.46.2026.11.18.02.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:07:50 -0800 (PST)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	jonathan.downing@nautel.com,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>,
	Vladimir Zapolskiy <vz@mleia.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 1/2] ASoC: fsl: lpc3xxx-i2s: Simplify error handling
Date: Wed, 18 Nov 2026 17:06:30 +0700
Message-ID: <20261118100631.26658-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118100631.26658-1-phucduc.bui@gmail.com>
References: <20261118100631.26658-1-phucduc.bui@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: bui duc phuc <phucduc.bui@gmail.com>

Return -EBUSY directly when the I2S channel is already in use.

Also remove the redundant error pointer from the regmap initialization
error message, as dev_err_probe() already reports the error.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/lpc3xxx-i2s.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/lpc3xxx-i2s.c b/sound/soc/fsl/lpc3xxx-i2s.c
index 757e0619d368..75bd148c1432 100644
--- a/sound/soc/fsl/lpc3xxx-i2s.c
+++ b/sound/soc/fsl/lpc3xxx-i2s.c
@@ -82,8 +82,7 @@ static int lpc3xxx_i2s_startup(struct snd_pcm_substream *substream, struct snd_s
 
 	if (flag & i2s_info_p->streams_in_use) {
 		dev_warn(dev, "I2S channel is busy\n");
-		ret = -EBUSY;
-		return ret;
+		return -EBUSY;
 	}
 
 	if (i2s_info_p->streams_in_use == 0) {
@@ -320,7 +319,7 @@ static int lpc32xx_i2s_probe(struct platform_device *pdev)
 	i2s_info_p->regs = devm_regmap_init_mmio(dev, iomem, &lpc32xx_i2s_regconfig);
 	if (IS_ERR(i2s_info_p->regs))
 		return dev_err_probe(dev, PTR_ERR(i2s_info_p->regs),
-				     "failed to init register map: %pe\n", i2s_info_p->regs);
+				     "failed to init register map\n");
 
 	i2s_info_p->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(i2s_info_p->clk))
-- 
2.43.0


