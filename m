Return-Path: <linuxppc-dev+bounces-29535-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF53CC6B30
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:49:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rbW1hmKz3bxM;
	Thu, 15 Oct 2026 12:49:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028967;
	cv=none; b=H6Js97EIGGkq+xP74dB/SHbqYbPRWoDOeuAOf8w4D92keGydHd5HFl/QEthr4UbsVeVTqlofNNU0I1DJvbuo3jDH+TmSX9vemWbvEGTaZUZMnfx2zCsgN3nXx9s7RGRGbIaM/UjqgX9T+RF09VpH97uyAtJRVIU1HDixADmVk7IJJ+qHSWSYUVZ5g4ElkhShpGEjhkAOxSkn+0jjFU+plzPwkEWob2QWPS0uI9T++KyIfjQNIIysgjK1HwifYtN4YRA4KI6qw9oEbgIgH8uI+EXvSGgYndqcbuNEjB4dy7C3z6tL0cgsfNAH6HNlfSqVHWRgHP1X3iJyho7HrXOFhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028967; c=relaxed/relaxed;
	bh=uRhw/DGZE60v7F2bKWHVZMO73GmaBC+Vm8KSgOideNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lRZ9mYxr92ErLkztEqG/JV/RN9wBpzHFP1GwXrAzY5ytpeTgS+wZTv5QVMp0J/v7uQFo6skZWXTvkF8pAJ32+8FNwoqDd4fZtz/5N+n78MlC0CfmO4Y30Vl94itmCwKzqehzwlS4QNF5dFBqL/Vy51oSy0/0yK29GD+5aXRYZdnAu5o7ia+nMHju1n5GaLj78lVtNLYsh/N6eCIoW7AVU0mbGbdCS7GnpROWPPML36aILX6PWqGgblOSe0B5hIo0yLnnaz+O6Ly0q5dDQCsS18F10F12owMq3NsGMM9XlQKbjJzY/UAcuS2nJTEkjGytKBXT4Dwv875ZxUoF/1L9hQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BaGndWAS; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BaGndWAS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rbV2Dp3z3bxL
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:49:26 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2e60f9af6e6so12939485ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028964; x=1792633764; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uRhw/DGZE60v7F2bKWHVZMO73GmaBC+Vm8KSgOideNk=;
        b=BaGndWASH+bW78BpX9wngpV+o2IlsTgLI9oqBkEJqTzSPu3Kez3oq96oRfZGGtK7eK
         oP7FmwxjM/yEmris0odoEoFRNsfFV7OpV2UwsxkRTbgUNkDhBa3KxgJE2fmYUv1t75jF
         aP3DSbNAz2TxeUTpDtHJMQq4yx8IqSrhhd7h00JIWVylaFHcRSLpUNXbSHRiHIi4gIG4
         DIR1eBtvU6DTopVv4qxZR3dpJ6NDBYhgsnWDgrGHGqbhBze+iQExZnirbbCaP87P9nN7
         pIx3gkWC2gQL1F1SJnby/gHVLfXTNuir8Fh9jkORT+rOw8uMr54Pv9Db2OKizPRXMui4
         770w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028964; x=1792633764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uRhw/DGZE60v7F2bKWHVZMO73GmaBC+Vm8KSgOideNk=;
        b=UiztwdAR9ZcW1PjJpirQAzYWBygkVWSp2Qjmy+VF5e9sPBXp4GGWZWBC8pgum+Le6v
         pCK1wZk7jZxwhR/r6cYwG9q8DkzOgxu96oogqy/Pq9qbHLhN9BSD/mSaPeuCw+4ySY1U
         dLKKCjn2xmhjP1E8eAwwbv01bvTheC3JmklzAWKJCphT/2sCYKdL/VHmgNgqFctJbONu
         U3bDVFeltH5Nty4Duxzso0iAlfdDAclQJ47tXTVwitLfjB7leICIHqp5lmDdDmDnGYX+
         k9YMkjZlsHVouRKvBY7mjlc6/9a5ePwz0X9WUkA2rGCRIRgwjRSZZDR7uXFpz+wcXwGK
         mDNw==
X-Forwarded-Encrypted: i=1; AKwUvBzl+f6pP2yaasLS+FPqnyQrQi894UKZdX/ODL4hGey8pjlK+aiHYwqymVu3J6QVy35p96V/Ov+wDH9k7eU=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLUbo3NmUBIgFhmZYw/7009/z2IIeVP1aGnNPhGMe6QzMMbvBYH
	pi3nhxB1jQACzFLwD4hwvMXsEgWJLrkG2llCb7qSFL8q/OfXddzP67N0
X-Gm-Gg: AYBFou1KIVW2WeleHutsU3cxsGa4auooRokxlwZKZacuFB7CZMVPGY0qc1yXUZEI3Xq
	WcsPhkW0z36G6A5l0GRVI2qkVoX9DOjIdZAFxYZEf8T+Lu+rY0lhk7TX29hemYTzMD2BIcJQqYe
	ZT+Z09Cx3kgwN2fVbJFy7IZucmtnt2g/SzXDj2Ms4gjkdwk1c/W+Eeo+WxqoYn6C4SsOCofnehG
	wqfXro88t8CZ/WwMAET542uPQMIm47Nnlv1wpgXXMiPdUgVO6OWWfPI1kBs4hTibIiOFsHyFFlk
	/we4VM5RSAH/2vHOpawZD47SbIhRrvuI9Uo2IngAscec2Oukp6ui6oUxNNWzQZv2qebtZ2gutmS
	vY2QvPrE2ZOV8vAxTmSZVFiQDDyg8dmAb5N3f9iyLcdESQ+ZHcTrNaa4KwJ1wkn6fsnyG6hl9+Y
	AFcx/4MNV/nhaGa2glYih7JIqJciwLo6d6ZuAlxfrVL/DclkeCRcfc1UcgOUR59UBpVCHHWWDUV
	7ceIWtwdCqNhX6/S15jm4fVm50orICzSgI79r0NG8flwkkTZjfWc8PN0r3gtFn/7iHlfNNceq0Q
	5tbu1knqmJbCbA==
X-Received: by 2002:a17:902:e548:b0:2e5:54c6:e5a2 with SMTP id d9443c01a7336-2e842820581mr176747665ad.6.1792028964152;
        Wed, 14 Oct 2026 18:49:24 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:49:22 -0700 (PDT)
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
Subject: [PATCH v2 19/25] ASoC: intel: atom: Fix .shutdown() being skipped on rollback
Date: Thu, 15 Oct 2026 08:43:18 +0700
Message-ID: <20261015014324.5569-20-phucduc.bui@gmail.com>
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
from sst_media_open(). ASoC only marks the DAI as started when
.startup() returns 0, so .shutdown() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 4889a8a73f65 ("ASoC: intel: atom: Use __free(kfree) for stream pointer")
Fixes: 6cc0f4e63994 ("ASoC: Intel: mfld_pcm: move stream handling to dai_ops")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index a4c8cbfba096..58681e007abf 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -341,7 +341,12 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 
 	stream = NULL;
 
-	return ret_val;
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .shutdown() is not skipped on rollback.
+	 */
+	return 0;
 }
 
 static void sst_media_close(struct snd_pcm_substream *substream,
-- 
2.43.0


