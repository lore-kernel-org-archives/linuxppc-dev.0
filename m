Return-Path: <linuxppc-dev+bounces-29524-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CB3CC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:46:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rWs28lcz3bwR;
	Thu, 15 Oct 2026 12:46:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028777;
	cv=none; b=fsqgy9r+CupRWanCuhpi4BRI73svxlnNTsH2s4FuR1ZwmIdPFi0pKJpmA+jFq+f7m/964XFv869jEwZO0jhbO1ZH65es0PPR3llD/7IAxrvzP5jIQW3BqAgt+lokf7zLdkWTtS4z4YXgWpIx1cW+VH1ozr/39DEpn0VzhWHb1/Ux1BhUn0JMhfOPz+lgl1qJg51y0SRyH6wTuXHQ36QNAOHhVMuf5mBdStQLs47J7VAVrG5SJjR9WntfVPcBw3nTGcvDn16jQBO+5uztkkg35DkKkCLZR/Ek+985LNNkir+L7FF1SbBiJn3msvcmx7BdbX1PuMQlMa0r6nYH3CNF+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028777; c=relaxed/relaxed;
	bh=kUuyyTReTSIMtXgKEYicRWK2Sg4dljNH29dcQFqlL0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgqhUn9GpS8ZVcqShzOl1GyyMlx8UPVW8qvLRWW0LquEjlve/rJXwPvHkk+YEmJcjoLWrpZdY62+5Z1CTSA5LCHryZatw15LlGVp+TmWUsopsqeMN0nAwmxR9JIpsx9+RSXPX1pVqel7VP/Y81PbCI8fXSi4c1kYTMxj3J7UwXoVNJkhQfk9bfwJKPvOi/Ls755dxTy5P5EXLef7qGPXHfCfjwscUmNiWroHibkeyoMovbn3/gjoiUsHAKol0URJ5tGTEFwcF7JAISePEvnI3Qel2U6BALlJJxh3rGl99UK3DvAPUybbxhkQs1vPvsJoZ7D6qzjePeMiWRt+BSt94A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m7uP2Gn5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=m7uP2Gn5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rWr3h43z3bwJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:46:16 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2e940d5d2beso5085945ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028774; x=1792633574; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kUuyyTReTSIMtXgKEYicRWK2Sg4dljNH29dcQFqlL0M=;
        b=m7uP2Gn5x3LW8dskkAIqFK6HA+zSdHkRjm3tQq7IqbSzelRY/ntsAuPc3KIujb5UBa
         Jjq3xG0t1AbV6Pt60a1Kl3HDSF0i4xm7ls+t6nHFZTMZzDL7hdK2jWuZGedLyxd4JFPq
         iP/BF3K3mmFhX+HVkezyKBJ/HAQdFDn/m9enGFWgsTnhUH8aMWutV7M9bb4lOPD3lnoL
         os79kSbpkbyVPQscqGAebjA+u8p/Suf7R7XqQ5sp0S0/s3Fa1MG1RTcZBg1FkZBQUlSZ
         6P7c551JCIdO33ku1ZHq1xU6lhuK2oPatfzkBGPzis3FOw9tDZ0sqmtzydI2jrx5gCyT
         eCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028774; x=1792633574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kUuyyTReTSIMtXgKEYicRWK2Sg4dljNH29dcQFqlL0M=;
        b=D9GmZuM+l3JGlVntksnfXH6bETS1jPWyHJeMBv86BKqQztjjzXZTsL9jFk0ZuHV/SN
         CRTgHUhQshs0Hk7odhJLsuZYxYNi3NkildJko9Wvms0ZjHywxsR67qeb8oTfcT0wCXdp
         6fjdNZWqlfLSk2BJV0T2Y9fjpFJSPNlBx62VvcW+Krnm4TrjXxDpDUFI4YTcWg1IpD/u
         S9uJC5jXQ2n3dQx+zbFbjFzuTz0x65VL24pBIJjxROYrVglS4PL7C0mqrgOZ1iWQWKSf
         5N05D6tUKCgHT0JRNdUZL2yfhZELa/5Sc0peabqT4X06p+6YaturJBrbhPAhQ24x18v5
         SUyg==
X-Forwarded-Encrypted: i=1; AKwUvBztHP6nIrTH7HklWJdiZodRZpWv94NggQ8HySRvsWzDpardmjbhesH4KkZrNl+yUjgthNs2dnsqiN/h2tg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYK/vNQLldcWlzmeQu/WQR7rCpUIR0Q7+y81IO9UYx5XMkQpMM2E
	ensdpM1zzV5PCwolft/MmZWYfsK+kDM4LPkcFjbHh1N1Ye8i3kVgr1g7
X-Gm-Gg: AYBFou1WYOW2+/pccWLFeTGVC5EjRuZtR6V0VvLL9zU34y1gaNqczN9EmixoHaQt08N
	H/v1YQPg6qAbgjN/FStuSmUhor46ROozKZTS6kCaeZcx3lp4f1oXQzGyuRxKX1/4KsytCBg1Xqs
	lqTUAGXbZxFQXwuvZvc9l1fX/bgEC4OI7TjoUwYIxvJDXYZaNz1AS8mbykdiz1Zdh3RjupGn3+T
	+RDne73OmxremoskYBfUfuf71NdaYsBPAw8G1NDbpaNxRmRleleP/Xp/gFeY8iW/smwRPdtLAfE
	zK3rWjRTD+o1TXEYUnHrOC+R2Uh50uepjVw9Uq9eD3aERJ7nwgYaqhFuTeWHZJBynMP527ILShs
	ZgfKFbY8Qanurj/S75PjWtw+uVn55NRLiFxs5dGoEH4xyPvWRGJxpWdYcQ+OZ9M/XsDcaf6+D+I
	+vKjz67BQR83N3oPEd1p3B0v+BaAPlKDllECs/DOOLeaLJEZZz1F3MldtXLRAYz0SLK7hdhfAeg
	YWjBp3nL3UMp4UY0q6F2glrOhdqG7Ff5nG9tUR5UxtujRYYBWM8Sk518dGfvQirZGs70VwJZ7sa
	oNuhR7wKn5znqw==
X-Received: by 2002:a17:902:cec2:b0:2dd:c0ff:e72b with SMTP id d9443c01a7336-2e842e02a57mr138459075ad.61.1792028774224;
        Wed, 14 Oct 2026 18:46:14 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:46:13 -0700 (PDT)
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
Subject: [PATCH v2 08/25] ASoC: apple: mca: Ensure the DAI is marked as started on success
Date: Thu, 15 Oct 2026 08:43:07 +0700
Message-ID: <20261015014324.5569-9-phucduc.bui@gmail.com>
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

snd_pcm_hw_constraint_minmax() may return 1, which is then returned
from mca_fe_startup(). ASoC only marks the DAI as started when
.startup() returns 0.

This currently has no functional impact, as mca_fe_ops has no
.shutdown() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the DAI is correctly marked as
started.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/apple/mca.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index be702b2942a5..26022a42a95e 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -516,6 +516,7 @@ static int mca_fe_startup(struct snd_pcm_substream *substream,
 {
 	struct mca_cluster *cl = mca_dai_to_cluster(dai);
 	unsigned int mask, nchannels;
+	int ret;
 
 	if (cl->tdm_slots) {
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
@@ -528,9 +529,18 @@ static int mca_fe_startup(struct snd_pcm_substream *substream,
 		nchannels = 2;
 	}
 
-	return snd_pcm_hw_constraint_minmax(substream->runtime,
-					    SNDRV_PCM_HW_PARAM_CHANNELS,
-					    1, nchannels);
+	ret = snd_pcm_hw_constraint_minmax(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_CHANNELS,
+					   1, nchannels);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_minmax() may return 1, explicitly
+	 * return 0 to ensure the DAI is correctly marked as started.
+	 */
+	return 0;
 }
 
 static int mca_fe_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
-- 
2.43.0


