Return-Path: <linuxppc-dev+bounces-29580-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56ECCC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:10:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5Wgl1wS7z2xS6;
	Fri, 16 Oct 2026 15:10:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123827;
	cv=none; b=f1xXJiVCjy202GF810k2+Uy1PQ9eYs/2BHrzLi4M6/h7NBMyAKgydIEEKEfjyNxWFpsxnw6gqtqsGKuA+lwjIFyFTYULPh1CERTWZugY6OouG7+dM1J0fkf+xzPNMORdt7Nf9ytNu5JeF+bOFTUaCabRPZtWW/nDhRhsOPkZWjXNQCondwELrKpHG1mLXPb15cI0o6NClhIfFn0wNQGd1gjQ+2sfvaTNBvH2pCSysl41xj99AmDO4ggBf8t8mywZnaSCY1nl7yG1wILyAVlLk/5eo0QfksP4sFLVRwjdMc8+D2/msdKl/g6vF/XNJ1NgLtAwJqYQuIja6l5vee5QmA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123827; c=relaxed/relaxed;
	bh=LqPJpnpDl1bjZy/2WTSO/k4hLO3gGJGG3iYDq3mgh9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MctcXDzJbNLAEHCqJ3vdFjFncSG0uTshU6TTxTzh1CLMjXSeFpbqLF87+JLjs4Pz/faKcrSTEDLiZscdXv+Cb8OUQhWhCu7YSB6iZgszAY0IfXi8K0tMk1VoyNlTNKdOcv7Ym81kRmgeFZapQdkJkXKAgcNNooaHT3O0iKnMuVHFW3TmHr8WC6yUsYSFF6TibBT8RWMluWr7PSBrquScNWEYvlqvQ8NZS+cgOPykjA4CCsHFmCqbwwEq287KZqva86v2G9md5D7vAg6DXSPA4GNHkblGIOXeYveSv4XGypwV8HOgYqrCqCNOd3huM+Ok8YFSW+zwockQkTnpVXuwtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sE4Eh76n; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sE4Eh76n;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5Wgk36bBz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:10:26 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2dd76b1361dso19750585ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123824; x=1792728624; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LqPJpnpDl1bjZy/2WTSO/k4hLO3gGJGG3iYDq3mgh9U=;
        b=sE4Eh76nAskrQ+a8VCYf43fOTu/In6cx63vYnO4wfQFLQk0Cglh3YdXl9q+gJ6wZ/W
         6Qjt445fXz5F0rF00PoL0WyFDL05AdTHlo6PrIqtZXMog+rfZQZAaUmLmL53P1842gNT
         a3QT6+orZVnwKhNS1eXQ7DwgP+RMG2n7V6s/nvJGnJKodm4OPaVIg5D++0y9KfqOnVNV
         28wlDgTV45vVlLhEweWvDOAgmikNqLpI4huv7TJwdGCvuhIegamni5O7GbPoCMbFLZtv
         RzJZLwOT1ldwPeV3oRXwLQjSGa0+U+fyT4P6wQUmWCRJw0GX4NFXCG7Y3FB/Lco8uwWe
         FSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123824; x=1792728624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LqPJpnpDl1bjZy/2WTSO/k4hLO3gGJGG3iYDq3mgh9U=;
        b=Zq+UlWT8g8Z8rgvdEicSS1H0dVy00P1YoGuY9ba4YLoWVS6qjoN8r9Qv0rFw+1b86J
         gsEN8QmQo5sSFOqzCbldguJna2Jz2AqBqK+y9QK7Hc1KOPEMrKO/oCwHNQo6L7V5SGg4
         JywTx7Kcw6zTiXGnCP/skbdw7oyhvlanepok0LL0TqIweuCA1+9V9IiPkeVTWuV8pNZM
         IoJu8C9dd/IR2Cn0UOU/hCfosDHCqOWbHH0I7LP4PDOLqFfPCJj/iRgYucc2fUk2T7Rx
         PmwUnvG6AInGK94WMTgrGgTDNm8PjlLFJWMKqawON8ekvuaC7qt5OXHq++dSDe8Iz4TR
         HMpw==
X-Forwarded-Encrypted: i=1; AKwUvBwbkmX5dugd1zjQx521S5V6ioss23JIwQ+KzPTYtEFDu5E6tumm9ZLP6Xe4ZjzhudcbLlGCiNhWqYilTGE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKfCtQtkYRAJYMawMUFD4L2ZdOnp8z1eXvyJpoWO9OvJKjYqqQY
	Hh1I2Wt/hXl/ME0hzkF6nsJ4xLzX4aukPtEYPHzkco1ZAe6jHijhqVLn
X-Gm-Gg: AYBFou18sfCPEmZ+g5xo+oaxQ4gIxYgwgxiP1A31KjeEfzYhO7Xbgr1xH0JURaMQf+H
	Ohje9tG4ZVPS7/6xkMZfpGoG8V5SVrUgZ0zrhZcEJru0MEgossgDvgNgsKToXDt4djEiTIje4Xw
	G+9sIZs/mz03umfrn03w3GlYsDaIDze1koQD1fOIsmGKC7ChJEmbMByJcoNfyU9aPN8YQIYv1Zz
	Nkhf1wYAI7juMCSh9I8iG8l+F2YEqIZcUuZuoD5NPwk8fksLa2Mshry6Vxjsr0pOzVQiO7vkBJD
	GXiGmXjyCjZdWaG2BI2bsj6iC2O9h3RD3VigQm1DhC3xB4BFsUHCKErZBgZVCxVjKr+77+JN0pr
	nO5f0r93l7UKXuNp7GPT96eP2Ot6Vyssc8Nlevk2s+79Wxnl9LieaveMx9EF322KVThoSo+MpBl
	lBCBeCD/82eaAmB+hNb9Nle5ZChIA15ZRBmjQHvkVdQ6IBXahc1O2Hp0JcI8ZhoQUe1+PmbEMku
	w0UEXz7t0e0GbFYv22hgJaQlk6ELlahuC3pmpM3J7WK/NHX5nvt0+8VlCSV1A9mLQ6pI3eEyXDc
	gO3hkl/vCMhneQ==
X-Received: by 2002:a17:902:d4c8:b0:2e9:970c:2c5 with SMTP id d9443c01a7336-2e9970c073cmr381995ad.39.1792123823874;
        Thu, 15 Oct 2026 21:10:23 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:10:23 -0700 (PDT)
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
Subject: [PATCH 01/11] ASoC: amd: Explain component open return value handling
Date: Fri, 16 Oct 2026 11:09:36 +0700
Message-ID: <20261016040946.521195-2-phucduc.bui@gmail.com>
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

Add comments explaining why the .open() callbacks must return 0
on success to ensure proper rollback handling and prevent future
changes from reintroducing the issue.

Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/acp/acp-platform.c      | 5 +++++
 sound/soc/amd/ps/ps-pdm-dma.c         | 6 ++++++
 sound/soc/amd/ps/ps-sdw-dma.c         | 6 ++++++
 sound/soc/amd/raven/acp3x-pcm-dma.c   | 6 ++++++
 sound/soc/amd/renoir/acp3x-pdm-dma.c  | 6 ++++++
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 6 ++++++
 sound/soc/amd/yc/acp6x-pdm-dma.c      | 6 ++++++
 7 files changed, 41 insertions(+)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index ba6dfe8fb6b7..f2c8853775ad 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -248,6 +248,11 @@ static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_subs
 	list_add_tail(&stream->list, &chip->stream_list);
 	spin_unlock_irq(&chip->acp_lock);
 
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/amd/ps/ps-pdm-dma.c b/sound/soc/amd/ps/ps-pdm-dma.c
index 28e0686e9373..12c341e89bce 100644
--- a/sound/soc/amd/ps/ps-pdm-dma.c
+++ b/sound/soc/amd/ps/ps-pdm-dma.c
@@ -211,6 +211,12 @@ static int acp63_pdm_dma_open(struct snd_soc_component *component,
 
 	pdm_data->acp63_base = adata->acp63_base;
 	runtime->private_data = pdm_data;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/amd/ps/ps-sdw-dma.c b/sound/soc/amd/ps/ps-sdw-dma.c
index 553fe11a2e50..c2640985f54c 100644
--- a/sound/soc/amd/ps/ps-sdw-dma.c
+++ b/sound/soc/amd/ps/ps-sdw-dma.c
@@ -337,6 +337,12 @@ static int acp63_sdw_dma_open(struct snd_soc_component *component,
 	stream->stream_id = cpu_dai->id;
 	stream->instance = amd_manager->instance;
 	runtime->private_data = stream;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/amd/raven/acp3x-pcm-dma.c b/sound/soc/amd/raven/acp3x-pcm-dma.c
index 072f3dc35d40..765057499021 100644
--- a/sound/soc/amd/raven/acp3x-pcm-dma.c
+++ b/sound/soc/amd/raven/acp3x-pcm-dma.c
@@ -237,6 +237,12 @@ static int acp3x_dma_open(struct snd_soc_component *component,
 
 	i2s_data->acp3x_base = adata->acp3x_base;
 	runtime->private_data = i2s_data;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index c0481a9ba858..89dc60849c06 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -233,6 +233,12 @@ static int acp_pdm_dma_open(struct snd_soc_component *component,
 
 	pdm_data->acp_base = adata->acp_base;
 	runtime->private_data = pdm_data;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index 33d59d992ee0..72050fa2de80 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -231,6 +231,12 @@ static int acp5x_dma_open(struct snd_soc_component *component,
 	}
 	i2s_data->acp5x_base = adata->acp5x_base;
 	runtime->private_data = i2s_data;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
index afa9f66533e3..cba2509faaa1 100644
--- a/sound/soc/amd/yc/acp6x-pdm-dma.c
+++ b/sound/soc/amd/yc/acp6x-pdm-dma.c
@@ -209,6 +209,12 @@ static int acp6x_pdm_dma_open(struct snd_soc_component *component,
 
 	pdm_data->acp6x_base = adata->acp6x_base;
 	runtime->private_data = pdm_data;
+
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
 	return 0;
 }
 
-- 
2.43.0


