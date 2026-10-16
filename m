Return-Path: <linuxppc-dev+bounces-29582-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1926ECC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:10:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5WhC5XFZz2xNC;
	Fri, 16 Oct 2026 15:10:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123851;
	cv=none; b=EpnN45MEW9ZIp/DtXOX5J+nzR/ViIDvMveH4xuFc2HWrNtTodgx5NyZTXcwT4CBRNogUhmZib6xq70ZMRRAa1dBuU9sag2Tr9RE5TmdErfmRGqcb3C3tGYJxKyLr3ueEWg396c05Vr0+H7Q1jdTBN0aICY74En500fxuQf6zTdIytl+g2fH4a425VgwK6XcbDxHAZjM97U5M9wa007Ls0wARnsMZbCIklLkKU9NqplFpCOcC+leJr8mVyouXjNZMal2ose4XlyAKnyJ+z5N++JzVcp0TCinh+W2Rbw5LtTIS+gN5Lil5DMuHBWJjJQGNvYdDWvQFIU0fQmzOLxpgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123851; c=relaxed/relaxed;
	bh=cRXMnaMYG3V2xMcW/3gwqdrm84/mm5oGaOhlRKzj2Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiTOcjk2gmyifLMQMIoR+11zJElvk/VkjhxQum9SbersW0w/SD6LQcyz27H6CX+Mp5BEYIbMB99Zc7X07m9+du0yfY2K30iwM40J5Ki1rlV+ihP39UHufe6vUWBv1ShasSdkksuKOw+tf0jRTGY9nAx1x6B4M+3IRF65szn+KlKgEY677xGVmLg7uIy83k8w3FhrZ4btT44/pZKlvgDt9acgulMfe+vbofhGWnXQ2D9GMvGORayzUDd8LIedHY0Xc/4fVxwk+T44TiLW2jxxmEbWkQhoWs/hoHyXRSMCBr7e9UQEJKpk6G/U28eZWj9I+t1UIOZkMMNdwMqPzlho2Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GOG2qRW+; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GOG2qRW+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5WhC0zMxz2xS6
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:10:51 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2db80fcdf8bso35126145ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123848; x=1792728648; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cRXMnaMYG3V2xMcW/3gwqdrm84/mm5oGaOhlRKzj2Og=;
        b=GOG2qRW+MSzmVMKQt8iDSCnsxJpYtBa0d1QfPdTS3tNddAtQXBMWc15rnXgfnxuobA
         G3/K1rp29ON5qKHWr5pOVAAha3IQ0JhevE+KXa8qnKdRUwqh7dpR5yFib6LNf6hji3wY
         QZ2xrUGh1lmmpIxv1TE9hX3kEf26e2n7SwoGVAWNwYgbanY1kQtSLaaPyF6t2enXvsrD
         avGFERnQx4iIUImudEf0Ei02eJFfc3/U9YHxWAQO832ZxunMLENKO3UvL5Gi8kw66Wsb
         tt+SZY+xTFrKOrAfQRXBHsFkQ+4UYTEsgCuHoofQxvtcTZRsaL6Ek64irx8CboSmHTDl
         qL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123848; x=1792728648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cRXMnaMYG3V2xMcW/3gwqdrm84/mm5oGaOhlRKzj2Og=;
        b=CA3EyuFJTKd44MqsWkAYLBLHKgVR7xF0fv1dKk9zAUCow9ZKhBH1XdNV4nRFTzubhC
         tU4dA31UFHhxQLtPFcj/wiaWKZBCXNonAikaptBb00n9EEkTAtjyv+Mr701Q3mEmAPxh
         iM2bpD6b5bblTSek9meJq5bYHICvutBpvBA9YSYRj31xGxhSSu5wBvCQtUdjrnf2nb1Z
         zX0oI8Yz2KykjmTIvt/W8gon6xDgwYC0g0B8X97O2YXH+MlfLVM0ba33GiANztMCmlyI
         DsQcvlA+5hPs0QcENqlhQTIJJ8t5b2rDuq48h+8T0R5PaoLqTtqRptrzRp8E+gk4Drm7
         kvDQ==
X-Forwarded-Encrypted: i=1; AKwUvBxChFUbeRgbHSWCK/FKEqQZXYtXaryNuUc+ICWfW6S/y5OZCfS5aN6Bs9BSGBvcQutiTf41Tkv8OBgcSN4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJiaIvvhK42ddbsn3KZdGgHy/g6lfgoJgP/bop+4HEZSZ9Bg/ct
	cMbJQsPNnhzStfX8Hfia4ROLjB4RrFpsjVT4BpAwGMaFBdWJ7LjiF2Uz
X-Gm-Gg: AYBFou2gqovibdRYvC/q1HtRbcDLjr2IeVP2qk25lEn18ml89aSYDYVGHOvgknfwl6u
	AMy6reZEpHeELu8ia2yzJu0c6nKn3V33wzB+Xb3wqJropSN2VvzoM9umm0y5pbtq4oijyW9D0AA
	WNQC3Rf2/DK/4kHsT+DtjnyobTf4w3km5bliHl5LWqat1vlL5MP8eycy5kHstuerQwyoattrmsG
	Qh2WF7NYD0i3ao5NQ5EXqFD6f94MTfr/PNJlp7Z9cyKULVp1oC85IT/gjSCQ8ynXI2bOHqouF7M
	ZXq8Jh1MQsUFbvzYL+UTKeuM3ro7qXQ9+2u4nHajuSXDeJLlk6W9d58LDGOmPf41o4Di35f9pg8
	env6WbKWXdSLZqGe0QQvAcZwMqTRIwtVuM3AKAHUyTnQuelGUmMiTtXBZxI2WR9J8kJnXoxx+Og
	aOT8J4pwHwg8LfXx5iPq0OTZX0DSySFgAyqKMeCbkFAePyHoi4WUpZcQ7/zdDN8ZBeK91LzW+Ir
	xFS/ZEpX0HNDFu5kWRBnoe94morCA9xpkh1M2eUZRLZxJ0qiyu1084lMlgw3Tc1q3AL/q0UtOfO
	uPyl7kp+epd1Ew==
X-Received: by 2002:a17:903:181:b0:2e9:842d:3c34 with SMTP id d9443c01a7336-2e9842d3dd5mr10658595ad.13.1792123848458;
        Thu, 15 Oct 2026 21:10:48 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:10:48 -0700 (PDT)
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
Subject: [PATCH 03/11] ASoC: atmel: Explain component open return value handling
Date: Fri, 16 Oct 2026 11:09:38 +0700
Message-ID: <20261016040946.521195-4-phucduc.bui@gmail.com>
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

Add a comment explaining why .open() must return 0 on success
to ensure proper rollback handling and prevent future changes
from reintroducing the issue.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/atmel/atmel-pcm-pdc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
index 552bfa30d4ba..4cedf2ad934d 100644
--- a/sound/soc/atmel/atmel-pcm-pdc.c
+++ b/sound/soc/atmel/atmel-pcm-pdc.c
@@ -295,6 +295,11 @@ static int atmel_pcm_open(struct snd_soc_component *component,
 	}
 	runtime->private_data = prtd;
 
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .close() is not skipped on rollback.
+	 */
 	return 0;
 
  out:
-- 
2.43.0


