Return-Path: <linuxppc-dev+bounces-29590-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D2BCC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:12:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5Wk64Mdhz2yTH;
	Fri, 16 Oct 2026 15:12:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123950;
	cv=none; b=CFvuH9e1gmLmMMbFpX3a5Q8RAmf5vxi52SZGvRC89hxeXh9ah7QFGG8dpIpy5Fuh1mpI5s7vLg8KZIm3/e9UG5w8kwPy2MAPCqAiHpKdJ2ssfI4cDaOIpqCAT1pQp1K95GImNGCEVwlTVym3LtPazQRsrqnT8DN8enRf7V2Pa+1D+Q59V7eZFeH/97+BCnL992FSagXbLllCuNj5NBUaK0tg+eL2DbShckFG2BCMRaIT95c9mL4yXE8iikZEv71VxZln1a63UxtSwxkBX5aT+YqHa/h17arIc2tR95os64KKNiZbyI+q4MEXDpeeKryRW5D+eP3YYSSKfcI0wYGXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123950; c=relaxed/relaxed;
	bh=tCZ6GoTFAN+ex1Ct3jpbL93IWIQW5JGKx6t1S7CNuas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D2jqaD+Dp2EyGXi56ZTXs4Qw2EsA8wVMKu43GNScChHSkueVyUtrRFKa4gKWq2Aq5kNi5PBubua/J7dQP2WVCM63OLibR8wTqmBuxtnOpyLPSCu+Udg4Je1ROZqOjpBBh4yeq28NgFRAvqhuBogxuY6Z4R4JXSPgFW/ZvBLW6ugIuuXe5Avzq06dklskbUvTYZ5K1dlwab6WKWELH8c+z/KoEMJ2r3F+vRuyN3DdqpSRgQznn4VGqf9zVcyLJMcAt7nPy8HmFCD599iUr0JtnHm3jN9rsqSuG315zVyEJDW//4lt4tzD92GW1kPRotaA754b4DUZkr0tKyqdGjVZgg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R0snaI0Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=R0snaI0Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5Wk55xF8z2ySl
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:12:29 +1100 (AEDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2e987a2ba0cso2041455ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123948; x=1792728748; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tCZ6GoTFAN+ex1Ct3jpbL93IWIQW5JGKx6t1S7CNuas=;
        b=R0snaI0ZSUmdJTh8EdiaALhEWRoKcx8WTFcLK20u5tSuTRFlfXHHd8B6M0m6EXuEmQ
         GE+3t0/hi5V5Iw+cvDCw23FjGOhm/WylKbmEXn1LrqorQ9l1Xkt15sjYKOkX3e/JPqHo
         ETYnBIAMAjMnPTCZyMQt7zPUntdbgX67+nAzeVn7wzuY07A/s1tEPyXHBXkPMGxiUsev
         +AJ3e22OeJK6/E06MN20TrAFwqsPYqzANFCVXd6Frf9MDMmubhe8XnUs+GqjxpP9q9aU
         fA6z18TilHO9DTehuZ15Tir3Q2fterPG2Kkg1Znt0pCM7/b2G5o8tFrqpW+ycsRkaykV
         gkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123948; x=1792728748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tCZ6GoTFAN+ex1Ct3jpbL93IWIQW5JGKx6t1S7CNuas=;
        b=A9oxwye1V0EEpBaR22zJa5HbcVq8CYK69YXyGXJKN6ESh8gN/0NPU3ZMhJKEnL0El5
         WHBrYupAk6PcGuK0mRaftsz2xiRwSvDx75UQERqcE5nxLuRzuFf3NApazj4uqSAD8KXC
         NywPL/3xKqapEY9RvrdudHMnOjL8ioiLULNkkmMC7x7yaB4hkVPYNd/guFW77zqvGss8
         +0VXo/ExQGO7k8Q3+ojBTLcS2qe68vYsQ/KjSC7rx41a4Qemt8fEKLaN5kHVIIeaah0o
         +PqQ5zUES1FUsj3ri9CzmspD53UFXfhApCQjA9FdlPktcl3iSw582CQp6pZzQZVCq5qd
         jkSQ==
X-Forwarded-Encrypted: i=1; AKwUvByafpKfhzc//XC77ES6Wp0V4T+SfCmlvN2s8rCkGkjRFsSgtS9sBerNQwq1r9AbD31Gko2DvcPKMK8iO78=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL82Z9jsegD80h431Gc+0Sc5aEWjgQOUSqR+CGBEAPlhxUR8dUD
	baT4U//fqybLoROUrmHhGwiyH+akhghrHFLQUUFF9Ydd1gf5dBdKw0AX
X-Gm-Gg: AYBFou2l9BZC8m2pQbJYBs5oUZ/w0uXJ96cp9vzbqvT2L846ftfp3CUhNqQnnlWXM8P
	kbJCbAxUa/0D2IlIRR+VIEo0Ji7XUbFamXtYV6H89umerebGo4B02++7XwOcHrCdzbwjaD8cn3a
	mGpA/pXaNqb4f7lOAWl4Gm7jPRxYUBTouwCuh17b17T2FtYEVcE2ExZekBtpG4Xc1YlEWrbLv53
	YLTPi0YcHNRhAg7ob23OicpLoqAi/e1Dn0MLxNmjYGNvG0SMxvXy8GRKW4O6GpoXQwQx9mleCBr
	QRdfMf0utw+kW9ROCwOqPerwveENxzV2+CGeFAWNa9K+iZgNsRzAlteid1WGfuqPfl8d3LFjlXt
	n9wERm3WECB2o7Ggx1GBTtFyAwz6e6XB1D+B1PaL8X8407J4zP4jeOsHVomOW0uedvhrExDxWdT
	VNXMrQ99tRIinVUmSlFfu4XZQ/HcRl0ebcTeDvb936aAAURkksfHzqHrf7WHJKDbbezkvcmKWsb
	A5eSn+d3/1k/qSuTGLcqI6xVGq1lh9HiegRzWdGVwQ/MhyXvB2S411/LK9SgYOjW9jMQnZVCYFM
	feRnPhHhBzATRA==
X-Received: by 2002:a17:903:94e:b0:2e9:4243:431d with SMTP id d9443c01a7336-2e942434bd5mr63920435ad.30.1792123947778;
        Thu, 15 Oct 2026 21:12:27 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:12:27 -0700 (PDT)
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
Subject: [PATCH 11/11] ASoC: rockchip: Explain DAI link startup return value handling
Date: Fri, 16 Oct 2026 11:09:46 +0700
Message-ID: <20261016040946.521195-12-phucduc.bui@gmail.com>
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

Add comments explaining why the .startup() callbacks must return
0 on success to ensure the DAI link is correctly marked as started
and prevent future changes from reintroducing the issue.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/rockchip/rk3399_gru_sound.c  | 5 +++++
 sound/soc/rockchip/rockchip_max98090.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 0ec80a4b8c59..d4a0daabfb42 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -266,6 +266,11 @@ static int rockchip_sound_startup(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the DAI link as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI link is correctly marked as started.
+	 */
 	return 0;
 }
 
diff --git a/sound/soc/rockchip/rockchip_max98090.c b/sound/soc/rockchip/rockchip_max98090.c
index d54c36682415..de392b420ebd 100644
--- a/sound/soc/rockchip/rockchip_max98090.c
+++ b/sound/soc/rockchip/rockchip_max98090.c
@@ -202,6 +202,11 @@ static int rk_aif1_startup(struct snd_pcm_substream *substream)
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the DAI link as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI link is correctly marked as started.
+	 */
 	return 0;
 }
 
-- 
2.43.0


