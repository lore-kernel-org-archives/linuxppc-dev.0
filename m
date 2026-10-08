Return-Path: <linuxppc-dev+bounces-29046-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F88CA6007
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:43:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mn66rvxz3by2;
	Thu, 08 Oct 2026 21:43:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1331"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456218;
	cv=none; b=l1cGGu/O+C1ohWT9LwnZlhgps7uK+NlAjPiwVMLqTF5iZM1hZzKeZs54zyt7rV8zV/zTtCz/PYdW2eGWf2OkTyzCjEW9NEOLE/f2FXofaSt+xtT6gTHjTv/vu6jk5uWmtT8dktzWiOkW7L+kywalZU6APqabatAR4W4ldUBIz5i0byOf7vED72sjhhFZAynWmtcouiLHbr8cufubdcaZvkEiFkcpvb4TjntX3rTE7m9wlwdqs6rHv4ESBL+RDkzve/pf+U93SyDyf2/T/SO9DWbM5aYz7QoJ8TtUtFUiEX2AbjPogRO+3VS6oHIfEz8ryNXCakZIX24eraRtCBwoQA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456218; c=relaxed/relaxed;
	bh=NfWx2qRDgtNnVPrZV6mmc0DG+YGHGqR8DbBEhiLgtRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfC0IBK5EtBg5WViqJXGarxzlohKaDJGkqAelKFJStKdBhFk3i0UbxDKdWqSOXS+Xd1xVBWgtWyZfIee837856N66gJbApucukwtGiSNP2thTe/XHjQ547tzZwtKW8AkeObyM7tg8eIgJu2oCCigX1VrVoXbn0Gs1LO0u2A3cCwkgKVR6NgMePqBadtzuZ+NbApopAUgLI7BE3Hf4AyG0IWHFsUw9+kAsk2mM9U2GVMdfx8WsZ4yu4lbrBUspEplF06kOtFpmi9g0POHi4TCar7YaOHBSIJW4+BB9Gn/9eMTT6uk4T1gYbzV9gCsD0W8t2Iagl8Ck98bPI+v1Bkb0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U54xvXt5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U54xvXt5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1331; helo=mail-dy1-x1331.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mn61p0mz3bxp
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:43:38 +1100 (AEDT)
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-33fb4680717so894283eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456216; x=1792061016; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfWx2qRDgtNnVPrZV6mmc0DG+YGHGqR8DbBEhiLgtRc=;
        b=U54xvXt5DAGebCYzk35qeDKFOL3aTEWwUVznJxneqZgnmDCkRKJsLsd2nuxR0ZGWaD
         tTwwk/4MSFdWTCsFaQmSz+RY/wxNVOgHLMhQR9vziA0D+PXSsEg6TChV5nX32BoNmVR0
         Q779W5anJpcwAo/VjR/jGB0WUFgZQfUx7gnM3xeS1DWyLOeKPgFSWoi+PWLwlN+8m7qq
         TR3ILY0V0q0yjHV0sxu4GSDGY5MNdDOwhblGdEtGI5IKOylZSJ9nyhZJLfVsUZTNWWHg
         V2tHzkshfe/Kk7TOeRPilTGTHhIgOp6YVMKCqiQw1Xj1e46BTjNe3K2MuoezRZAkFixa
         kPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456216; x=1792061016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfWx2qRDgtNnVPrZV6mmc0DG+YGHGqR8DbBEhiLgtRc=;
        b=uQB8c51U3Adf7gt4MRUafjhuQ/n4B2WlS6+nORtvuij0yL31yeeuOT1mgC7m6JziGz
         q4khxBSrJN8pMCgk9AcIh6baI7mu4ouZec6IO1IvJIUhwfLxs+pbleSmwr9V3OzgVojT
         e7l6DI+7igTNJgvZFhBvE35SD5iy2aEoWLGTfEn837HuMq6raCFIzcVp2MBlHknS5uXX
         W9uWf/Uj4Y4m8g4gSLHYnDRn/5oewQFzAylnlfHAEFak18NphpbX4F359HQmmPfHD5Y/
         SHPzW5KMvem8o+fZBTVeJVoG1k/NdHTg8QMiOqLP0+q177qRy8OabDgeIw5dv3Kaikig
         bsAA==
X-Forwarded-Encrypted: i=1; AKwUvBxgEtQAdGhf1bk0ZlybhsRuctphl5VhoWsajCR7Pzu2gmA2VAWHaYbT2Rmrj5IhobY9agUHPaUxQoJK9PY=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lgC8dDi2dninSE4Kv5x728pm4lENEFTnQ9l45DOY8Ffbl1dRs+
	5ognOcVL+Mlz8DHFWXvamlku+fsJQMigqrm+/n4ETUK0pELhGFBfwsA5
X-Gm-Gg: AYBFou01qCHiueKqGFI268NilZBmjAXa7t8gIn00SuT75zJIm+aonFrzgWV+kJRuiSi
	aIFUFUgt7nU6lceQ9vxnn5v0Q++U+I2Fs9h7VQvfW2IasBojXTws4BN5qs2y4Cf/wthoQ+uv7rD
	DFVWd5nBnYPYieRkS/upHoGR+z7gSC3oXFaqj4Ger1aLdW4Qd2V63XxCFZHdNkycOtqZg/T6Zs5
	AHNtLxErk6UxrJjp2hqm29LAKBvSr5sEbcZsNvqAgPKsHybKjz+Bx1reeaRLVwa4HZwluufsmQD
	1Z8mVSmauujqOiWqMvtHUMcNzqpc2bCrLwcwrNsgqSvEkmjlhcxigYMJiN+tjXgrXwCeF+0bTL2
	P6pBkyXR6+QjRIVvujWprFenlnaCzhgk38S5pBR2Tn3fgKXaTZNHqnLHpAKpQ+QABlxhWnBAiEE
	24ZD9Pa6OFeTV7RZm3nKwcBjg0LpvD6uUxk8oXXZSbXL/W3nZeJ4BTRWQkwvPbR9ZWoaxzz/7oh
	/+epV645vhKIQbv8CV7wLXwdPYyY4LHbOiABpXtcttk4Dg3reQHVujT1ovdkIGJvFzGJhqErbyR
	iNWZ1ZO/I00S08QEtuMRa92P
X-Received: by 2002:a05:693c:2402:b0:34c:e77c:f92d with SMTP id 5a478bee46e88-3515de8cbfemr6349033eec.33.1791456216244;
        Thu, 08 Oct 2026 03:43:36 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:43:35 -0700 (PDT)
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
Subject: [PATCH 18/24] ASoC: imx-pcm-rpmsg: Fix imx_rpmsg_pcm_close() being skipped on rollback
Date: Thu,  8 Oct 2026 17:38:25 +0700
Message-ID: <20261008103831.542533-19-phucduc.bui@gmail.com>
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
from imx_rpmsg_pcm_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 3c00eceb2a53 ("ASoC: imx-pcm-rpmsg: Add platform driver for audio base on rpmsg")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/imx-pcm-rpmsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/imx-pcm-rpmsg.c b/sound/soc/fsl/imx-pcm-rpmsg.c
index 7086fb7fc1eb..30e75fee5175 100644
--- a/sound/soc/fsl/imx-pcm-rpmsg.c
+++ b/sound/soc/fsl/imx-pcm-rpmsg.c
@@ -269,7 +269,7 @@ static int imx_rpmsg_pcm_open(struct snd_soc_component *component,
 	info->stream_timer[substream->stream].substream = substream;
 	timer_setup(&info->stream_timer[substream->stream].timer,
 		    imx_rpmsg_timer_callback, 0);
-	return ret;
+	return 0;
 }
 
 static int imx_rpmsg_pcm_close(struct snd_soc_component *component,
-- 
2.43.0


