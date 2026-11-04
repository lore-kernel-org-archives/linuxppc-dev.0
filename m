Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADA1606A329
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kIprKzpt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKNgD1xPxz2xNC;
	Wed, 04 Nov 2026 22:36:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::330"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793786957;
	cv=none; b=a/J4bN9tJUnlViZwe+6uxF0dH5wGNOuDfUGdT4/x9r4LglnabIpG/dt2pXETsldgRpItDXn84RhCrBGehZjQbshYYVzIDR92bXpxNw2Pk8QzUA3tk65V5CTUlRTj4HvMjt7qIM35JQBtezzfFeealxaUj9m7D7qmjms7r9+7XQrVqN8KOV7Tx62k/4UUBRFyzENcRTeXVkpJNhihtHNBpFKFS4isHT+f8/zWpN0eQUGaVfM9Uey0OelrBMo66ToNWfFie3bnNnB3KPsEdIY9p1URI3tfPI5/Hy09ZW8O3rC7CZ+WK41Trb7c/DFDqe34/D0sSNKcVM6SwVfF95Rg+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793786957; c=relaxed/relaxed;
	bh=9m08hNGJrQqFFcpwSUCA13zd6OgCwpmeyEz6J70Gtdw=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Mlw5yEsTdUmR4zWclhQ7JzqWmQeuyG4lekQZ9ORyaCbeJECcDWhJ2Mo5jURPEFhDL7V0hti6VORz+z8FU++DGgZKf6kXvN7Ub7Rb4XVYE0Cvk0z69jzZYDIm2D1X1yDMTWNqZ2fpsdASYVuwjHglJvqS239q4Q8sTgSVSFBU4zWpxXVGJgtrmWx15USVbvfdbu/+ohCIMD9/S7mYXY7XDvDwCKoFJHGmYpLKIBdhEJFaU1A2inkEJXhGnfIpfcsmbsP83P+FGuWIfXOO3JYlCVD4eNuCe4uyIkkGlPSMAfzqlv5cfxAl3F+nfSnNA/RpDutCk3wzLAoo2gwkKLNj+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kIprKzpt; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=vsetti@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=kIprKzpt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com; envelope-from=vsetti@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKLkx5MQxz2xK7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 21:09:11 +1100 (AEDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so3637675e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 02:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793786946; x=1794391746; darn=lists.ozlabs.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9m08hNGJrQqFFcpwSUCA13zd6OgCwpmeyEz6J70Gtdw=;
        b=kIprKzpt15bKhAoU51zgth3Fuso883ugWcsAAHQ83DQp2eQEkBgx01oRF0KcgfLQT+
         i4C0bfKm+IXbICmPG0TtRJWsUeLopTtB9LCKs9T7rzfmGfMLhcjdDA1J2LGc/03C2o+b
         k8p1QnLAhiKYIijEDPVemBH9brT6R7ojDd384NQRDfvLU0zdY3s6g/tS9ftVkFRlbGlW
         vovKp/lsMt/9qmBQNomoR3B78HYyr+yt434NwUZH6+IKlCaTLSYqdTJiS8KmI9xbuB6t
         n0KEjtpdTbyQVPT7DRvudwIqVJNRY/RWiyu3qXREyQWwwS8kyEjMNeWwKHHhJoKYP3iS
         2dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793786946; x=1794391746;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9m08hNGJrQqFFcpwSUCA13zd6OgCwpmeyEz6J70Gtdw=;
        b=mv1gUk7nqCx3PLOs8RAGbqU1U+DPfbLb4pX19UENr5eejPJWhf1r1ZgguSHXr7hBSz
         skNqdkFWN6uH+5vFzFsalfbos5z+2PgwdEvkRjjzl81S5o/UHePRjjWNwhhUkyA5Hwyr
         u+VWq50IhYjLz4pVG5xTIVxHKo7ijANr0TE5eTKBwi2jValwJDKfYK8PTzTSIs6eKpsZ
         z89aNVEavNFVQE+GLVeGKePHjIKhCcAB58PybUG5lF8lN4LcqruyFekH8kdRYlV8qwE1
         05d1T/GSM+uD2OLDy5qsvCwjWRvg9wcSN8QhN9T/Z6iSEvVRAyeTuaAUGugkImd4jEC0
         IIAg==
X-Forwarded-Encrypted: i=1; AKwUvBz2bTUSRpMVpbZ1hOoTaFbir7fAY6qNYieMqFDlweD71yULBjGwJ6oOyRNmjFCX89KOqkBPHWfEmuXgYM8=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z++y4KNVyflPGPo/OzOekbYNJdTbrOzBrd9jAn057dJ4zM2Tj9J
	YXldQjsaAFM1bnAfRWm8wK5Oh8kXEobQ1BWtDU4hNg3mOhmAMMdNCTyjwulFRwd53Sc=
X-Gm-Gg: AYBFou1fPpiFpxfVR5MqQNFNtjGrEfLKAeDzpxC7EtMmt0dWNqwm5KDAFi488TT+aZL
	7nDcVXZnsl/FOgQTjNcA+Vkod8+WapWibgEOHm44QRtTugI34AOKO9CGfnrijKx0QJBsJkk9vQw
	9CnIjTiBz3pV/Ud+D00l3D8Flg5B1AoHBvQ+uMHauQ+SI5s3nnLPT6IdfrZo0+qn68hjwzZcUlk
	ESmKeKID5ww55AWU53JMN5L4pz3Yi0iKELGVRiUJ4U5qpM27tHhbAmUDaEis9Hs6g7GijfyF323
	+Z6pKwDoz9zKzrVJbv2Pk6FWsqS5H6hCupnkzY4/JZwCExs5cTWxtO2pjfDcLXfi7uteHVxVdMD
	eKxRhSpCLydtfNebkwhgGtEAj5j/ko7lUounNzt9o4ddFxWlM42IRrlLfyIrpuafZDq9qdDrg/3
	qRGjGSRcKgKnqa4ji1D1KtTIXuD/48TDhmpC9NJdHZazPMlQSXCOupCOh02Bfvk4yrmd96jPhNQ
	M5TchklbzgFo2efIN1pgV6/V4NDZ/R/mWgpAgKSJbgG629l5aAGMvapENa4w3T38Jif3qdgWwzo
	tDch9vOjTjQ3srH6r1nkZTvlhWU=
X-Received: by 2002:a05:600c:c48e:b0:4a3:2f35:38b4 with SMTP id 5b1f17b1804b1-4ac16bc4829mr363600885e9.10.1793786945653;
        Wed, 04 Nov 2026 02:09:05 -0800 (PST)
Received: from [127.0.1.1] ([151.61.248.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4134ff2a3sm39589745e9.2.2026.11.04.02.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:09:05 -0800 (PST)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ASoC: fsl: imx-sgtl5000: drop codec device reference
 after probe
From: Valerio Setti <vsetti@baylibre.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20261104022815.1484320-1-vulab@iscas.ac.cn>
References: <20261104022815.1484320-1-vulab@iscas.ac.cn>
Date: Wed, 04 Nov 2026 11:08:52 +0100
Message-Id: <179378693284.334584.13927162303295738761.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=vsetti@baylibre.com;
 h=from:subject:message-id; bh=wL/4+5mCyg+xHnS2SrTRtqVLLJgE36IXiOGlWrvNvw8=;
 b=owGbwMvMwCV2z3ty7kUrRgbG02pJDFmvWWy2cK3/fMdg3YIfc7e99+hZeW+t+as5t+fmfrjrt
 Ufc7vq2Ix2lLAxiXAyyYoosLNPv/S4oVXtonHCyAGYOKxPIEAYuTgGYyMp4RoYVm6M7BY1U7+87
 E29+9dDXyEd5h26eMPjcvrpz48t1a3/OYGTY5KYQV1DCM2NZXKFpseyp2lsnU37m7v729NqmlOU
 qU1UZAQ==
X-Developer-Key: i=vsetti@baylibre.com; a=openpgp;
 fpr=0497DEFB707526E13360C970DE4B936DD13A0100
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> imx_sgtl5000_probe() takes a reference on the codec i2c device, but the
> successful probe path returns without releasing it. Only the error
> paths drop the reference, so every successful probe leaks the i2c
> client device.
> 
> Release the reference once the card has been registered.
> 
> Fixes: 81e8e4926167 ("ASoC: fsl: add sgtl5000 clock support for imx-sgtl5000")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>
> diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
> index 8bcf54ef709e..8ce333eb47fe 100644
> --- a/sound/soc/fsl/imx-sgtl5000.c
> +++ b/sound/soc/fsl/imx-sgtl5000.c
> @@ -177,6 +177,8 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
>  		goto put_device;
>  	}
>  
> +	put_device(&codec_dev->dev);
> +
>  	of_node_put(ssi_np);
>  	of_node_put(codec_np);
>  

Reviewed-by: Valerio Setti <vsetti@baylibre.com>

-- 
Valerio Setti <vsetti@baylibre.com>

