Return-Path: <linuxppc-dev+bounces-29525-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EE6CC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:46:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rX737rCz30WS;
	Thu, 15 Oct 2026 12:46:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028791;
	cv=none; b=QYfJv1j6HNsVR2B0VXLSDjNjMKu+h/foGTFFOMYA4vWDuRrZ5REAhY7MIDRG3HkQT+NsDZniU+Vcl7YB+tm6dOxI7EvOiKkjp6RTmoVjLhjSRmcHdPbzb4+o2TddFJxMltRkLTeMtYozRo0Ml7x9Zu78uwiCUP85B6OJWgs7vguwWX3oXvFmXgPjJ9np0YRMbcEOUApWWKfB7ehubzB8k+MxQOAk3Bh2hG7ovvvaLmKCvbjcjUANBmZ7f5n+2DD/gmdHNtd/E1LnYuvOC4f5GFyhuwhd+ZC5FLOdZloeqvb8KTMLjKV7Vx/uiiMA3K1U7ZenaS5vSsqs+Ro0wYJH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028791; c=relaxed/relaxed;
	bh=FVoaE90uxAa4MGE2u5YmtFWHqpvVUok70EqIpA+eTKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVfz10z1g59OCx1CeGZmJCd8b2XIzlgN7/wpV0g/Rm+t7N7GGTaNxf6R8taLv9xyi88nYRf5st9X5+UEuJ4zuT+HVqCkTdealrbWPe9RZpzgZyQyaVnYrolw69SdcyQyye/IdVat9Lb6AFOX9ToRT6FylKb0KXEz3KS8wHmjDdwkmd3WAtsaNKPsEkuTUJZ6IT3/KH8HNycQCQvED/J6HjR7ZibqAQb2yTleMECKlEFbm4LeMELn5jg1RrWc+uQLuJIuNOWjqQurFU72ID22Q+ZYM7AFeYGZQvj64NGHBPSHy+bjm9F/3E6lkKjIJ3cL7NTkPVoYCDkNLrNaPJSkbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TZ5BcII0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TZ5BcII0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rX65H7Sz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:46:30 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2e60f9af6e6so12927215ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028788; x=1792633588; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FVoaE90uxAa4MGE2u5YmtFWHqpvVUok70EqIpA+eTKA=;
        b=TZ5BcII0w9N0fjXCWzPC8hUlf5jLdgds/Llj3IAhuRVPFOqdYKnL8QH9oERJTfyrmU
         fFUai+VetORguVe/hf/teINtp6AjkXjDF/tOawdNnYXEs8e+ogI2kYug9dJZKezrkE+W
         /wrFyRbiNgRJhF2lStvAi9JUApC7O9Ssgsw6e/q8YfGwHUbYqVlaVHLUKK1vTPr5GsdZ
         CX2G0ca23nVG2tbCc0l6K0AAnAYScGgmlgzyrJabAwP+ij5tXG8PXcQhjdemH8Sa9rAr
         526pXVSJNX8AjbIOHZMqjI5R3kKCRdTZuBIRLMWn2dWptqyNficNPj+Lg843s2sEt79Z
         uDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028788; x=1792633588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FVoaE90uxAa4MGE2u5YmtFWHqpvVUok70EqIpA+eTKA=;
        b=bHMzLWs3RxYVnaEfIYTWHa1z3hid16xDPoyixYL3+abOrkfsjvEID8IQVySSpDkIvD
         M2AQh7iDn93pGl85mHctMgX19wZscnR41j5R3sJyQgIBc4vMKAM5GoTA+x/CiRMwLW4j
         8j71KVPzl5m8YN+mRoO7TfuIUc0rRu0LtqOlZTcTyoEAdeMCbI/3VCCJJK5wDhpUE/lS
         nbKBWU/YxT0DN69D4dRucfvHQbImN9mB9BKkTMu6osUjQLlJMlAr9NdNP+3hXv0VrkQQ
         T/Cj2Tq9E5wCG9HwtjbdVpCh1Iezaelrh0kzgM7lna5Bzie2q6se06S2JCaXYdTQltZB
         W2Vw==
X-Forwarded-Encrypted: i=1; AKwUvBzu2QiGs6Jttc7Rdg2D98UllV8aJncJh+D8P2/+fKaIMWjg43R4/n0K/tEoLOrUxEK69qSjAbQjYik0FlY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIJxDZBOlWf8HbiVOyZ0+kog8KvZzhvgK06LLW0Sk2DF+GISnRp
	vU3FE9kZP4Q03uECq/RmX2yCJZkHMR80Ci6zDqauRhf/ZCBmNRd5kLAj
X-Gm-Gg: AYBFou0Jg7BCfsuAbez2N1Y0KvDCmClXglUblPFY0pgm1xFHNCWMrf5WsY1Aup1mINI
	xlnhRwboX6FZkuvXJZkxD38XxGTaveJmF+K7JwU4vyoIjzEUSOrby+W3SDyU4pmHcj/OfVMAbam
	Bs4W4cZDbf3f4c/izl45P1EALBtet5yJ5JQGF4CCq0drfOdKDaWQKhjkSp5y9U/rvLDEajkRFSd
	ycs70hZ8BbGRZUUDB5/9h0oMeRB2lzJjC9X5prhXqDCQJPOsKgwcH/hMSl0g9oU5wp+ouQ1kvmu
	GO1cziO5iXGjddT3ZFVxxYp+GP8Y73vuWi2kafimDVXevxpXeQjjslf9J6408Geowk2MWz864bf
	MDHHOHoptJL13yZCZfCi87gd0ovl1YbTRaVoep5UTKCupoapfbWgkszuGy+DCcSKqac1LxnaA5y
	rwJfBtL8pIV1ZGZzWrPPNzgfWFm1PzfCwRb2IRVY6UYMhWWY8BjCl33MEsv7J2wM8+Dpn0C3q9S
	sLrFuFvemXJf5vq3ybdGSkdoeSFALg/HWkTk66YHFqswFRZS+apxBK2DhUa5Krtzf5puZD/7JWr
	xafC9B2+CqctBQ==
X-Received: by 2002:a17:903:38c8:b0:2e5:e3da:be04 with SMTP id d9443c01a7336-2e84304792emr134212015ad.59.1792028788486;
        Wed, 14 Oct 2026 18:46:28 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:46:27 -0700 (PDT)
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
Subject: [PATCH v2 09/25] ASoC: atmel: atmel-pcm-pdc: Fix atmel_pcm_close() being skipped on rollback
Date: Thu, 15 Oct 2026 08:43:08 +0700
Message-ID: <20261015014324.5569-10-phucduc.bui@gmail.com>
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
from atmel_pcm_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 92dfa6198623 ("ASoC: atmel-pcm: split into two file")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/atmel/atmel-pcm-pdc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
index 374f93fa6e0b..4cedf2ad934d 100644
--- a/sound/soc/atmel/atmel-pcm-pdc.c
+++ b/sound/soc/atmel/atmel-pcm-pdc.c
@@ -295,6 +295,13 @@ static int atmel_pcm_open(struct snd_soc_component *component,
 	}
 	runtime->private_data = prtd;
 
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
+	return 0;
+
  out:
 	return ret;
 }
-- 
2.43.0


