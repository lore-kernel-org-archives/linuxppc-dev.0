Return-Path: <linuxppc-dev+bounces-29034-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F05CA600E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:40:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mjg1bjpz30Vy;
	Thu, 08 Oct 2026 21:40:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1332"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456039;
	cv=none; b=BsApc+Z0o7nbj67Fuv3iuH1BJBu9b9XZqOG804efBrtoywVkZZpOZyEIcttJoAeDV8h5ycmOqz08CGMgmr9M896MwfyOFQ7q8ErHdniNIG9260/T0xwL17NMUUZGVxxAUXoGi7lLPJrNT6XgDDh6S21QZpE7K/o8RTb4gckl6IqPZfoAI1uSxxcqV7FOwI7Lhsv7EgOQHbIe5t/TJQrAeBYC/TacfYXNJaqxqmyctOreg0jdm2Hyb2Qnpv9ulm+CBG6cACJRvpgYThbSQiMDOEvgaBCe3Iqj3B77m6TcZ/kDyPliy1vu6DL9FWBtN74vp1+x4oceXEeFUgwwxURvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456039; c=relaxed/relaxed;
	bh=DCoq+QQx3kZdKIK7QgXRpmYJ03Qsfh2Iq2ERtZh+EYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALLUqzHp3BEkhOFATk9rkw2tYanKDexFRpkPTuokYtqMXo031sENokmckcLEzJfwWRpHn6KcQTIyNY2D8KRCfXGWcC02f697BWymUj6XAQnsvNSVxdnybRQwgYhYSAVHmK2WnfSOy/eyNg7G8JWeaUkQcCOh+sfRPHlEwkgwdtVvLYyTKy8B/NOYAx2dVdD5nFyrChJhdlGgsfvnqL0HpEJSwCe1R8nmy8DJIWG+6XsbdIeHbxfrZ6SEg/ZvSmiS0IMm2YK006UckZWXbPaO09Aeufdab6k5y3531G19VKNgzv1V1WqlQ27QUaCSSf6cz9rUMIDdy3/2RBVx3mqU6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pScBRnG1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pScBRnG1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1332; helo=mail-dy1-x1332.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1332.google.com (mail-dy1-x1332.google.com [IPv6:2607:f8b0:4864:20::1332])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mjf4SW9z30Vv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:40:38 +1100 (AEDT)
Received: by mail-dy1-x1332.google.com with SMTP id 5a478bee46e88-34bb8b31647so7925688eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456036; x=1792060836; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DCoq+QQx3kZdKIK7QgXRpmYJ03Qsfh2Iq2ERtZh+EYs=;
        b=pScBRnG1jmU6MyhmLxd3gFefNO/oLzll5nt2mChECqMs83l44GApfMGZ0R7JIGdgd0
         C9sjx8v1+Ahm237kx4om7B9vXDurDF8XoftHDutXotwPNl8+5XTH/vWC+s5RUj1gpGfB
         AZYsji+eyS1uJPHUWVk4w3s7rcYQ11fhBAcZ/wJLfHKVwoEfnCHRGcMLPedMIS98Uhct
         6aN2iPHU1k+qzSnpAyf/hHCHfQHwS6sZygunVk+DyfupKM64ZzcqX/zgQJ1x8SpJ3Mvd
         an+aIoJJ3GpkM46jFsmguCfkLPkHlfiq/QegbeuY5WS9rE4/ATVrQF91T2dlengu17P1
         SYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456036; x=1792060836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DCoq+QQx3kZdKIK7QgXRpmYJ03Qsfh2Iq2ERtZh+EYs=;
        b=ql+0JfMqpOiFExDXfYocJTDLqUf8ovFLvsA27w061dVXWu3hJDLVh3ijZeFsZhQ90P
         BDOR4V9i5A1k/dqeDKUYDpOcZ1NbeFKKYHudEHAG7znMWPp0BVlbjqJvVX86hAND4GRI
         bpHBQAYazOse2fhvFU9DmMdcDTDMYS7v26rJKHulcMsb+INVJf8HY9wsVoOn65+wKUtt
         4ojQ6UsZidAPhazyPL67kF5dmIC59/wXmyBtMfFu5gUZ1zUHNua0Ui7ml2CPMJuEw1ua
         dpsMx6vsBw33SVhIs3CdJ0OYC/MqQBUSi3uR18jAGBFfw3vqCadRGpJYofpKdhPSXJD7
         HkIA==
X-Forwarded-Encrypted: i=1; AKwUvBweS5QAhP4tcMBEanuS5ssgwF+IRMZ7WYob9I6zICJNQdxvgX8bHSVfNHWcmapZXEtL9AQ8FtK+B0WoDC8=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJkTsUby2ruz27gkYFq1FLGlkj+SB2saIslRmGNOkmKnAKq9oxL
	a3h4aupwi0C1lsnl3q2fjECUIh4yRCXrDdBl2+KWk8M/fnpf8fO+SQG4
X-Gm-Gg: AYBFou3BHx2JP293gtPNuR/KywaQ3awa6ZTcYP4sYMbvfrg7ATGd81FD4bYVr2Bl+a0
	W7RVTxbn9YiihxVK7bKAolNmxrli/R8qRvHbcZ+6rhAXXVp3LiTjBUfjo8OXgVaOg6sjJvB2sec
	yEwFyv1QUcIW3XI3io1ifEry5J3GLoXYjm8/EiCad3IbSF+TXVRYNJLP9oNsqTEadpiasLvQLYN
	HMrGWO55ekjIStJER6YPTP3RJ+7//3xyI6HC5g3egSa7T1KIQX0DHh6/uMx/vac4oEW6O4SV/CN
	rEHRWlyHAALPHd+9D9w6Q/X8YATQnVteHFOno07bYLOZF/Gm5FWjvAMzv/zc43WR63LWxyA49WG
	C/3e6m9I24EhetSxQ4HzaoDXA/0M9t55QTryP1/jTu86XUCf+e9JVJ8VJQwpgv+iQ85YgHzWjTq
	xJef0Gn9OXboPR+ttrFs5v9xYZQNZYd96sp21Ucv5JQz4LWtAOFZvkh59dg+ZF3tVowvDRSyyHU
	7Uv2Qu+48+2oQsAwGYM1DqA1tMnXTNBD2EcYIQL6xve1MyHtgQgGWbGqhClcBNNk/VIJGB2OSM5
	cnF2bhyZLzQw0mVK7bpv39k9
X-Received: by 2002:a05:7300:b088:b0:34c:b75a:ac1e with SMTP id 5a478bee46e88-3515df70a46mr6358739eec.33.1791456036268;
        Thu, 08 Oct 2026 03:40:36 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:40:35 -0700 (PDT)
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
	Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
	Ravulapati Vishnu vardhan rao <Vishnuvardhanrao.Ravulapati@amd.com>,
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
Subject: [PATCH 06/24] ASoC: amd: vangogh: Fix acp5x_dma_close() being skipped on rollback
Date: Thu,  8 Oct 2026 17:38:13 +0700
Message-ID: <20261008103831.542533-7-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008103831.542533-1-phucduc.bui@gmail.com>
References: <20261008103831.542533-1-phucduc.bui@gmail.com>
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
from acp5x_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: cab396d8b22c ("ASoC: amd: add ACP5x pcm dma driver ops")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/vangogh/acp5x-pcm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x-pcm-dma.c b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
index 831e30e9b042..33d59d992ee0 100644
--- a/sound/soc/amd/vangogh/acp5x-pcm-dma.c
+++ b/sound/soc/amd/vangogh/acp5x-pcm-dma.c
@@ -231,7 +231,7 @@ static int acp5x_dma_open(struct snd_soc_component *component,
 	}
 	i2s_data->acp5x_base = adata->acp5x_base;
 	runtime->private_data = i2s_data;
-	return ret;
+	return 0;
 }
 
 static int acp5x_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


