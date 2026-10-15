Return-Path: <linuxppc-dev+bounces-29517-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B25CC6B33
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:44:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rTt69N0z2yqT;
	Thu, 15 Oct 2026 12:44:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028674;
	cv=none; b=P7nez2xVVjVvPxoS9ub7z+d1gMSL4BLn4egAJO4az/6QyBFD7/eU4OxWYfj0Hex1nrDbby0DbHJBp9p1bHkCwNCc5S2dp0GU6R+glNRXl2uUhEX6YaD0lciPaKEIQtqeacQ9rGak31eOP2ZAFzfE5zrcrzRo2Z7BsbYPJ6M5+ubcp824FsAyv0Q0rimCbt/1r4CfEIHM1bin5VE1WVx1FtoBBx3OUkv1yECkKqAnwhmzp2zthBoEMmDm990FDmU6Y50Cm1W8t3O2ZlJ4iXwkR+kHI+bbtqZ+ZjGO6cs5TXiqVIMtjeps+ytV5tMg6uBjxfWt4snIU2UutHddoFkreQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028674; c=relaxed/relaxed;
	bh=0f9CDxT7c2yfniMxJX6Z2S0DK8dovzfteRrAqStY2sw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=otD4u5DXqq3mVpd+m1KKteP8Lz8+/0Ols+ylOA0vpF2MR1YF2G1ZwQ0Mh1ZjOsCWknGlZUsAR4I+nQBxE4LnDeOon0NURs915KEcOqLcdigFEIQ47PpfUdc6j+32bj5/YBP4OODv5aNwcLSZc1ddnrjN8R6huo+HjeCrQn/5Ubn35XY3JaImTKuRSFtF3QbtxsyEogKSJbEO6+TPj+U3eX3C1Vpqrlgulad439DUqA+jo9x78RCt9J684MqTN0ryBs4LoPF+7nGm0xUxVAVCbuCd6HlcWEh1ehvJmYyuPA665x7dBP+ZWe4TfRzViGd5O9W1HtxXNiKaseHojaLrxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C/9RjcvS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=C/9RjcvS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rTt1Hpjz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:44:34 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2e61ac64ec3so41079815ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028672; x=1792633472; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0f9CDxT7c2yfniMxJX6Z2S0DK8dovzfteRrAqStY2sw=;
        b=C/9RjcvS6gOVFqr8pzwKmoRMD3jHTPzpeJGpFrAdMV+i/ZbXJuH2OqHcgq3T71ll1A
         m4WjqSr59N+Zi6MFnaDmKCbl0UG7ovE8Vkqx0ad3IxarK/EFcV7lGOivacKmwY5IUEJK
         Wo3wNKU4Nh7DpupXG69mJoktvohgMCdybURHmG0mI9ONb4xvC2JfGYI8/FGM84Stri2C
         XZGFWHUYLaZMIsdSyeI/6DoqQToe9V1CPduFmF101Jerok7JjHgZccs2x1Clor9jvXaJ
         ZluIzAQYL+MsWCUXQurjL26LKk6BtNJceeMxENCNjX/mSyrlAVOeeT+UICg2QVPgRdwL
         dY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028672; x=1792633472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0f9CDxT7c2yfniMxJX6Z2S0DK8dovzfteRrAqStY2sw=;
        b=oOVVcC40+NoyyXKWEzZ9e1ZXwgER1h5RVlvhxdkXs1WOtjREPlLF2SGqvBFobC2hx4
         sAjaV6kEns2+7vqrEG20XNbCqEqK0h6vwGlvEYnjdRHIP7vC6pYTr0NGlQY0BT3djRsj
         +vo/SbRhn2ky35LV8Oi4lRVS/zrlAnsXxeTZoB5VqEsFZ1b0Gb6SooSW46nWrlLxxNaR
         i1MpZcosgZ3cO73CCqlnAklV6GmCsKerWhhHyL/IQ/Wtoe4krekmeTKkCU93xM8gXJgm
         +LHPhbxviSV8Nnh6MraN5Vy5VIEXPy2ryv3ovPRstlfak0hcQXokzdvUJtimnpObtCOX
         76WA==
X-Forwarded-Encrypted: i=1; AKwUvBw1pfBT/SDLb06UnFXDTqLovK/WO0yFFMhqGipdy4C2wGBOP0aHEfejFshY7AjJ+jKnM6vR/XtVyIgIJ+I=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ2mPQWCvjyCOWGXi2q6H7fths+HW+5g3mmKlhLDGCwQcFLGYgz
	+CvAW5NN96gBfrkWXZcgOzhUNUiAiNtbsiHeYQ3hp/bHI3gfxX3yk6dn
X-Gm-Gg: AYBFou0r8HqSfSmSM5rkU7pTOrn7RBskkfOivYMOtbekwGm8htY8tz89M89dlg16Z/u
	/8KY6oEufboqiy1yzdIknmmeVnFweqgGRhmH6hHWiRqy86HimKYuLHg902hlCKZmYjYCrj3vn8V
	6R/aL8yAcphkt8DFPo9EpESHmmIzMDqW7vHolbV3dqqA180WFoaKNyHuE6eIFj6yV6lhO6THu8K
	HqDiHFnzLsKK8qG4zsON2U01bpJPTZvgZxW7mUYxWgYfQd/hx8Ef3BA+Az1uYc0fuJZLONuPrxm
	MS4iXdjsj/0PriQyFkWlKPOyW6mEabc4Suz2O2gC0lRVdeaLdiYRzACl6iDr6RXOOI3e7SVlQQt
	GiqiQU4Z4WIGdS8n50fla7jjnyj7e5g7LCGPAdYbtmT5gGozPTMqfOCWl9pXgUJ3KeMadAAMKO+
	02Mgwtt33xTDLj4teGqR0VzS9PtZu5KBdHLUGO8IrXf3E58bnaz+eVCZlaGeL2wOhnxQp/xqdoU
	sRt0bAwiuz6sKHvJLFl/T66rYj5OcfiAf8WKYc+KFJ3Sn0GH3jsv28BwGmGvcnZCDP9+lyq+y1t
	EiFlPQ/D76gODw==
X-Received: by 2002:a17:902:f541:b0:2dd:ad73:c938 with SMTP id d9443c01a7336-2e842abebd7mr158700385ad.25.1792028671728;
        Wed, 14 Oct 2026 18:44:31 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:44:31 -0700 (PDT)
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
Subject: [PATCH v2 01/25] ASoC: amd: acp: Fix .close() being skipped on rollback
Date: Thu, 15 Oct 2026 08:43:00 +0700
Message-ID: <20261015014324.5569-2-phucduc.bui@gmail.com>
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
from acp_dma_open(). ASoC only marks the component as opened when
.open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 623621a9f9e1 ("ASoC: amd: Add common framework to support I2S on ACP SOC")
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/acp/acp-platform.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-platform.c b/sound/soc/amd/acp/acp-platform.c
index 6b1e18b31c1c..f2c8853775ad 100644
--- a/sound/soc/amd/acp/acp-platform.c
+++ b/sound/soc/amd/acp/acp-platform.c
@@ -248,7 +248,12 @@ static int acp_dma_open(struct snd_soc_component *component, struct snd_pcm_subs
 	list_add_tail(&stream->list, &chip->stream_list);
 	spin_unlock_irq(&chip->acp_lock);
 
-	return ret;
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
+	return 0;
 }
 
 static int acp_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


