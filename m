Return-Path: <linuxppc-dev+bounces-29534-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A5CCC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:49:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rb62gVGz3bsZ;
	Thu, 15 Oct 2026 12:49:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028946;
	cv=none; b=cTTvsiCQGKgKFjDpbEsigVG2QAaWXUcTMY1wBO3sUeqRK84jiOo00yAnDFbU3lyf3XeX4UzPUfxFNLDHJ4MKTBAdnOhnAJ9gWsm3bpoUhbwSTPmJH3ts2fwKzfhnB54p+as/kLaG1tOVK1xJ0lftt1HxAXwzPcGbJOKB+YDYewsnnbNn7r1abO9F9WzYQEnnGdeuacCHgENvnICi5D07GlQl4Mmd3PS7Xb02ORtyTtral6sEJOxBZvymT8burz47WdwnCdsz9ZHFrRjRvdvizeQq7JYy6TNE3Rx9I8S2So0rO8w7zaM8znenUVTMAlJotG8QJjcpLvzN7/Ca4TsoJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028946; c=relaxed/relaxed;
	bh=M1jbxv0B573E/6JvVMqt4p2dOdYoex1i5fkYQYaL9us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVMDOrGje4DTQoganq1MAZ0cZokkSWoEduFTwP3igesVAvjGVbnpw5VOrSNnkZpGycZ8E1ZBrn2KD8dqvH/dTGXLkMNeVmtKgqUa/2/8jrbwZsz2T7aMlee7CiT4xJFCC4mufXcJgdYijuVWWCV7/aCOJMQI/Jg3FBlLQ7w/jCST2XKzmJ+dqQHGhdUrzGdhBwfoCMD+9hV4fDdcybrWcYa7x60/0JcUyulbTZuIHOp1SXleAl7r3u1IFk3siDglyco66gjbNESb3RXHEbEecxWnr3BG7bMvDPc4cTTovpCqkhUtT+Kpivb39VAZKvy+/v9pUItN6nIceUuzuhf6tA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jG4mpekt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jG4mpekt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rb548KRz3brT
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:49:05 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2e5378b281aso26427885ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028943; x=1792633743; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M1jbxv0B573E/6JvVMqt4p2dOdYoex1i5fkYQYaL9us=;
        b=jG4mpekt4fAj40gwrTAXLGTA5bV+iRoIEYqKNhmQt3qprtg4iey93QItygY8Gjhe/H
         YxTUBxefF8H2XesqGOoLIMI9RwYKR6zUanFBmNQ5yortjI+kPSkTHijQpMsZ6eadIhYR
         r/ilc7rPs70wpkBx8E3uhn+ANnY1JbjcWl2w3OYlJa3yWiy3S55LixnyHA8rtFttgaud
         OphhWEGHt6f+D4vmk0hDyJhDLhFIettUveSqn183F7FVB5y+hU3GcsFdgtFPOEoIOgy6
         LDeRnclaoz6a1STflHmEOh0+xgZnXvPdMtvRKHt2Lu313BYm73OBv66quc2JPnqCOZMX
         DuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028943; x=1792633743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M1jbxv0B573E/6JvVMqt4p2dOdYoex1i5fkYQYaL9us=;
        b=XzthNEEsccC/uXjHVhy8fzmARPpO0IzjsAMcEcIkXNNYdxIqv65iEPIhLdD377DnOE
         rwZDdTdnOPB+r/Rh1khzzIYZKss/ftJEjk17QNpqu/U49xz7nT9LhHDRp2Fff9lGqUi0
         ay2a2FeP2n5edch2woDbIEgVItM2Ecu3t5jUJCxs3kLGz0MWinzn/xrHnlWHfz3+TD53
         gsox0rzZ20w773aEvyCWaJxQ5Hf2tPKdiAx/kQhqoPnTwhrZ8cnLt4rUEgTxkLl3a6qb
         z0Pf4PghAC++q9pOyDlvtRrJXOIHQwXxVKn1KuY+C68glunGQg4d7P1CPETw59UtHMQl
         lGxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxe4xwz7wV161L0Kq9ucndVbPDv7g2ZqAx4NRS7P8p7NxdnAdrYZ+4jh/+Z2uAzIKTxAsVuCm8zWqTxT+E=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLANoBSmqYXaYQMm2QiGtDyT7PsWWwpV0w/KrluWpUvu7C9paSM
	cG+B2ZM23LxX/fHHuvGTQgzYhZGGhRWTKL+eL8iOPEi+OHfDcS0e6Ov6
X-Gm-Gg: AYBFou1oI/slZCqyWlaDorKpqYiMDrwYdyadMi95qicyHmQVD0Z3phrkLZwUZoqTH5r
	gSTbNKhQDbEC1qLfzdMPqUM0jirmk7VRJfGUb8PBu6V2oio9WFlQwTZ/ISJcXWoIZY3+SG9MfJE
	iBvO6GGI3SlZVD3JW9FABVIKARL8jGyCpUOysLAVcY/4FUZ2ixAx9ThoEtMapamecK8IAke/ybn
	cLfxAs3zkIth/hRjpAXCbHoRW1PuTUPykUL3BhfSNeXA32ztMoTfiuNJOtGX1tvRK+YySBXDx8b
	jtlGzX6HhucyCM81b+zrTab7CwuAukROXbpw7A8r1ce2o8AY/d9UQjbN6HUqKLlzNgcVhyrq0kt
	OsLxUhvXDRsfivjJ7YguaYlGzw5lGgqwgqeLDcs4E3Gs8XOTP/vhLPkw8u5lWKVpp7XVwQax/Le
	8MuUAWvDQ+SZTKbBqToqNyy7MZevyHfYSQqOQKtzWEmHyznSotzmGE//XErnsuIpD4pziCcHHZX
	HZP1T7Tos0qW0mjziQgXMr/ijiGC7CW4x3QXf1GLhVf248pNqlh5yDxrZZilf+ovWyT0KZjDz4h
	eY5ZVQ9TOBaDYWK4FS2cfbGB
X-Received: by 2002:a17:903:41cf:b0:2dd:7a0d:e51d with SMTP id d9443c01a7336-2e842ab64f2mr171051285ad.16.1792028943557;
        Wed, 14 Oct 2026 18:49:03 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:49:02 -0700 (PDT)
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
	bui duc phuc <phucduc.bui@gmail.com>,
	Chancel Liu <chancel.liu@gmail.com>
Subject: [PATCH v2 18/25] ASoC: imx-pcm-rpmsg: Fix imx_rpmsg_pcm_close() being skipped on rollback
Date: Thu, 15 Oct 2026 08:43:17 +0700
Message-ID: <20261015014324.5569-19-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015014324.5569-1-phucduc.bui@gmail.com>
References: <20261015014324.5569-1-phucduc.bui@gmail.com>
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

snd_pcm_hw_constraint_integer() may return 1, which is then returned
from imx_rpmsg_pcm_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 3c00eceb2a53 ("ASoC: imx-pcm-rpmsg: Add platform driver for audio base on rpmsg")
Reviewed-by: Chancel Liu <chancel.liu@gmail.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/imx-pcm-rpmsg.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index 7086fb7fc1eb..85b7c929a28a 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -269,7 +269,13 @@ static int imx_rpmsg_pcm_open(struct snd_soc_component *component,
 	info->stream_timer[substream->stream].substream = substream;
 	timer_setup(&info->stream_timer[substream->stream].timer,
 		    imx_rpmsg_timer_callback, 0);
-	return ret;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
+	return 0;
 }
 
 static int imx_rpmsg_pcm_close(struct snd_soc_component *component,
-- 
2.43.0


