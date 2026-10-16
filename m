Return-Path: <linuxppc-dev+bounces-29581-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942DDCC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:10:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5Wgz0xzjz2yMK;
	Fri, 16 Oct 2026 15:10:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123839;
	cv=none; b=F5MoKDU34cE+MqhUhgIeXvK8OGMRQT0zvdeHrWqD1WpahdcKJUpsYIolIVhMoau5KXxPwW+cTZTHxIoxgSj+/7AWa4FwsHt4HX62t+lKmwTiDFOyzvTFnbFRxp1oiFSjOvyHcXAVcPQdrBkEHF66BPMA5dSDxGEwx8DAxQmURfUsPKlQELthCOHw3Q7466ikbndX95X0NMCD6G5qUdYMC3sWMtkcKKgU6kDM86X3JyF8m+quw53Xcg12NC/yI2DWfoArxQIjXqVki8Wi9G4NrQfuYefNu8U10JQzBbUxWFJyEhA9i9F+cdDzTqCL0+FZATtI77+jNT7ZTkgoQjV96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123839; c=relaxed/relaxed;
	bh=QFH69Gbmd4pLwYRTdAmCw0agJokE4nomqHT+KuDYM2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rp265IkPlc4brMvy03+tfCCn342+OLSI8qGe+VZ1C3HeFsHxFMhJYbl+GuQOtbHRuxMOQNGsZIYiQ9Qb567ALUSVLIZ2SRbx7gIev9sw86oFLFhfieTRmGeC7lq0IjeR6y+dQpeL0uceYblmsJFG+0/7AcfazJeb3ABLCrcxJSTBiCRja8sz0TkEFRgeKgLF0Hjskb+ogi2rWh+P7KpHQ/IR0zHZ8LlK67LybBzXZg6Fz4/ZJAcMgV+QMp7NMZb4ypYLMcNK2TEsH/2nY8XVaU2DpR3REOBxzvLEKMZkPbNHtyMqeuqu/gCGzsTnRzAfaZRksh5+STmXOE4c3nK53w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B9o9HYi7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B9o9HYi7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5Wgy3Yx6z2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:10:38 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2e812e2b31bso34989555ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123836; x=1792728636; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QFH69Gbmd4pLwYRTdAmCw0agJokE4nomqHT+KuDYM2c=;
        b=B9o9HYi7Zv5WNbUt/tqe0TJJc4P/rKjG4sz1ZZWOPYkb455Sb6WtuLblUzRNb/UXb0
         PaqFXcFxHJT6ne+97SqN2f7cYaDHcoIgH8aALS3VVE/nG0xCZaMPlks61WM3f/mrowQH
         tdT3ZSEreo3t1+RM6k5p8fkrWSGZ9pME+sbTgHr5xJw2C9wh4k6/0xXM/4DCRVQkTPGQ
         F8Fx4E3qinb/LaZi2LsTMURurrkg9sSIN65phEvAowubpB6IH0VlonPMARNVUk8wCn9l
         nyGzk5Z4tHFSQrDK08yoV1p+aeNNEhvEODfDL19FKVNKzfo5vyAqFiD+rIL/93Hp1NS3
         0Oqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123836; x=1792728636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QFH69Gbmd4pLwYRTdAmCw0agJokE4nomqHT+KuDYM2c=;
        b=HuiCZ0wOkRUVLYcyGkfkCTW8MjBOYTPuK69Nn/29T/3a2qmcHQtpnPXuY4cpS7YeO0
         hkejstKI0tygQDNdU7pmKE4amSgVdJjxlefioGX0xPDc6v6Mcmzt5qYye1nNgYT42oCL
         ihraqjGnO+iqzst6LeD2dZa2AAqaDjzdAzaIFAdDBmiqmIsz1IWo+q5aNZCEOGLU4MVf
         ZMgVVeBhcSuhp5oDSGrg7dkZMvfN8h/+kWH2ZKkzBVzdt44xOHli9ltdyREfTjv1fHQ8
         85c8Io8noHR8D1XXhBI5LCP4Lt5Hle9XRJCCBu2dHKD3Hql+/Q0iugdGZPP2neyNtuLg
         jlGA==
X-Forwarded-Encrypted: i=1; AKwUvBwGQEJahxWVYcp6G4LIf5oBwBs/nOaeUcxFSm5zGUNcGGGxwnqM9sUiF7tuVl4Emt2KGrTjWEz+wOLGOR0=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIK2cca2/R+4gysAgz0XTYNAC7yY8BMQO5+TGLKESdm9gNO65FD
	UyUO0S3vE4pLopnt8Rdh0QMLmvWHKNzIfwIb+f5MsaF/gHSxeYav5GQ+
X-Gm-Gg: AYBFou1D5xVRw/Sz1ZTr7IeqNBldDkxCzJbxtwF0H92+OQ65kCpK7ni+mXgQuLEjpL9
	LyB2QpSO4Bg9wnLaEJJaMWChCMvAx9lL/pIMmGwT++h1hfdMCdxbfJRTjhfbtKrAslRQDxMP4kk
	Xo0p1N//diE5aT0ZBCeqzbfsUrwxnfXWfxVjYVRwP7eEPf86aIXSHL+iUaDWCfYcSO2I7Bd2Mm4
	oVlQqHCmnQkrhFaLyrVSrD3IZ9hb2OdognKcxgv0xXonLn04UKulOom1rnS8eViaQWFqUapX6cA
	moBRc5iQ84txCfKN20DVbPTFqpvxMXoJwCyeGeA0DUoxSsYvAj6JrkFROLoNqdax5p/YBbkwUMh
	AYpa0PDVwp+ltWwfUqQqTaO4/AWigF7h4VqVhGhPGX9HmsIHU6ygPw1hR7j373D2fg6LaOedIb/
	yUA5lOE16TFWRiv68Gic8uIu5KFkuQ0cGoMogx7qhJb7IXx3LycAaFzqz9/y5ibVGtKwN1FKcnU
	4avFTmnVgybGD3zhdUGVFeKaulLeCMJhsJUzMugvptjEw+cP/zhB3Ykk10s3PU8jQkqac8UIaZ3
	6+JzA2nzvHkSPoIzdIvuTs3Y
X-Received: by 2002:a17:902:db0b:b0:2db:3b35:1ac6 with SMTP id d9443c01a7336-2e8427efd9dmr210035865ad.5.1792123836136;
        Thu, 15 Oct 2026 21:10:36 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:10:35 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	povik+lin@cutebit.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrei Simion <andrei.simion@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Kees Cook <kees@kernel.org>,
	Syed Saba Kareem <syed.sabakareem@amd.com>,
	wangdicheng <wangdicheng@kylinos.cn>,
	Chris Bainbridge <chris.bainbridge@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Neo Chang <YLCHANG2@nuvoton.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	u.kleine-koenig@baylibre.com,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	Md Shofiqul Islam <shofiqtest@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Zain Aboobacker <zainaboobacker33@gmail.com>,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Bo Shen <voice.shen@atmel.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-sound@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	patches@opensource.cirrus.com,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-rockchip@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 02/11] ASoC: apple: Explain DAI startup return value handling
Date: Fri, 16 Oct 2026 11:09:37 +0700
Message-ID: <20261016040946.521195-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016040946.521195-1-phucduc.bui@gmail.com>
References: <20261016040946.521195-1-phucduc.bui@gmail.com>
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

From: bui duc phuc <phucduc.bui@gmail.com>

Add a comment explaining why .startup() must return 0 on success
to ensure the DAI is correctly marked as started and prevent
future changes from reintroducing the issue.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/apple/mca.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index 3585432ad49b..26022a42a95e 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -535,6 +535,11 @@ static int mca_fe_startup(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
 	return 0;
 }
 
-- 
2.43.0


