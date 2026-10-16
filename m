Return-Path: <linuxppc-dev+bounces-29588-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103E9CC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:12:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5Wjd4TdMz2yQl;
	Fri, 16 Oct 2026 15:12:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123925;
	cv=none; b=P2LPqKnD2NDQsarLFo+TErooc9oGGBXq6alUkqswIjai5WsqlsvsN31ZkDKdrTrYLtw7k4gM9xKK5HXNBiPKxmm7Um19NKnf51KMIh9HQ7ez6ZsDJmFwM27IdY34Q8EkaG/aym4g3wqyFUWVF+ABRi0ZDd38AS6Zt3KAXMkV2a0cEX3C5YfEY0KQhSlHrIMxJYvwRLOHomWwQFbeMo266l7jPp0A84Vg4nlH6GNxr8dWTEIiBL27LyYFqxOszm1jdQOKwJPRyQN0zJaA2PSIiNQYQCCuJMwjKnTk8SzK56F7k22efeniNEc3T5ziLAHs3BkM966TMAx6r6Ze6++48Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123925; c=relaxed/relaxed;
	bh=7rWy1nSOU2shSy9HWS2JIxQi3sc/L3puAcABYmBjXjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuRd9dSnQeOrfQ7J+N5Kb0iv/3QrUfiQufL+E8vqS+/faNUmjO5nS9f4QcC2l035+TJZeMsXoOXKvxwipBHjRXG9ff6Ydq0eZ6NaTJ7jIW6v+vPdHNw9aBKJWdNlVExtecjLTLgrh0pTWowxux8TdrzUp+Ac4oYD90mztkd8gFQWM+bxyXmeveY7U7fSsuwCojTGcCbTMhxF3qyxfuE9rrNzarT32bmLx44hywQtukwiT4t5B5xdFpWdEc3jwkxlTPQHfCJLphh72jRBvCS2euGToluYnjCJ09mYmXErg4aUNLjAHHydtwQVMCxJLckpWag16fyA5ETMrMY2WE9NGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fnVCJKTL; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fnVCJKTL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5Wjc6zfyz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:12:04 +1100 (AEDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2e96502e447so9585275ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123922; x=1792728722; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7rWy1nSOU2shSy9HWS2JIxQi3sc/L3puAcABYmBjXjQ=;
        b=fnVCJKTLCmDwCiYgAdubP73BXaPUGKptMy+R1iQ7RZyCacDa0pu348xTZS3NIUBg6U
         Pl6Q2BQ7+G/ctmjTYvdnOEI8PHXMTWGhF1n2QJ3FOEvkFEO2TXqN+brqCUoa57SNBsmH
         sZKxgFFAZhqiSD8+ywL44y/lOrHw7b8UkG0NTFxQ/W8IjQZ9y9geOYfSxihRPhbf+ybK
         P1YNTFbpSjrqjZ/DfFgL4haX8qa5WZAfxHkwA9lCNILf+E7VVtrCPykVXoY9m01XjOvz
         KkOPW9+MUn94OfSs1ThPpZIefZjKvuU/INo5QTerbMGDc3GCoLBioUYvwSSEjtdGAQtM
         AjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123922; x=1792728722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7rWy1nSOU2shSy9HWS2JIxQi3sc/L3puAcABYmBjXjQ=;
        b=m/38Cew6lU93oSwkBzO2NfK/0tsRKN86IYqBnoT/28iT/Ed6JlbufIry8OWtqQD5gN
         FZ8NGWmA9oOTBeToXh6NinRiHVmyiVDoKSYtq1kyxR5a/G4P6qGjlHS31eXU0ZS85RV6
         geXHA4w72+fKWnuwM04x6ylrShNLOcCdFXx/FSuwDatGsDFH6dld41hDJJKTeNa9cUAX
         jfZzK2E/TtX+CeLfJRLs2+8m3SmiSKjs6m7sYDDq7CN0PYmoGa8DsqFQtGGA+21uAs+f
         QpW5ZQ+6iXETFzynf3Fy++ZSKQ2L6f0H9aN0IvSvNUr/IaNu6nWtlrC+QpVgiKmBWO2r
         P9+w==
X-Forwarded-Encrypted: i=1; AKwUvBw29m7icBSmRduvLddN7tnezdsZSojJqF/YrKAHOfSsjFC7SzO7fyfPOySOiZqoir8T7S+r+UZ2vDvhZPs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYL3rhnNOghwLcfe0m5iIDUkKJf/1ES3pLBBV9hcG0krg0RN18TU
	5/kXvIXXnkyyvWRvu2V4m9ot2ZfsGk6CcMAc9nyonucwMEiih2rvtBpn
X-Gm-Gg: AYBFou3qyt6I8X9OMrJ3usdXRdKJmgcLlFV3DJc/8KvWAKLDkAYSiYoUH+ZiAzyApf2
	8+e5eHaPB2A8CZ2YjRsiYB55tvLwYvnPRmNOHqRLxgYcRuqqvAM30B+nsz4eEFVUMBE/4xvkh6V
	EBkIB7Fr0VOhvOhqFfOI2f7+3fktctBHS38U6ZuwxmlGQnZm9PVb7avI2oinj6U5MIB3n81LWEA
	tQBRyiRKDsgIwnRBRbioAvoMzO5D7AJw+iGExFaOBy0HyosFSCekVwmuOhGrgh2wypeN+Oulwbo
	RidTYDxPVWpeq6Mbh6LFWrh5FBYGyTYMYprSP1q6ew1HEwgRbJdn884IRxEq8sqhcemFbJJ96WN
	UIt5J28rPbWH+yL9MSHzr/FQnncduA48wyb1v4H+dkOsV1YKNywTxsGIUj91bhVTftqf2un/+TL
	YdYyjE9GiwrruTTzOuH+col58jotjAMjQJtSLQ3YclcWV69z3k21Pv7sd071AVVSPs5HPaTXld1
	yJ/abKEgc+XL0YHmoTPoRTFc8b3rGJtW66uUMtjEkV6at5D7RK5NUMRV2W3HNJzIRBgQzvrwBLl
	Ki5FuAt6oUP5eQ==
X-Received: by 2002:a17:903:4b4c:b0:2e9:66c4:1717 with SMTP id d9443c01a7336-2e966c41865mr35460075ad.61.1792123922489;
        Thu, 15 Oct 2026 21:12:02 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:12:02 -0700 (PDT)
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
Subject: [PATCH 09/11] ASoC: renesas: rz-ssi: Explain component open return value handling
Date: Fri, 16 Oct 2026 11:09:44 +0700
Message-ID: <20261016040946.521195-10-phucduc.bui@gmail.com>
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
to ensure the component is correctly marked as opened and
prevent future changes from reintroducing the issue.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/renesas/rz-ssi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 2e297f721bb6..9f36fe2c16d2 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -946,6 +946,11 @@ static int rz_ssi_pcm_open_pio(struct snd_soc_component *component,
 	if (ret < 0)
 		return ret;
 
+	/*
+	 * ASoC only marks the component as opened when .open() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure the component is correctly marked as opened.
+	 */
 	return 0;
 }
 
-- 
2.43.0


