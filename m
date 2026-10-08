Return-Path: <linuxppc-dev+bounces-29037-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FB0CA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:41:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mkV3P2Rz3brc;
	Thu, 08 Oct 2026 21:41:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456082;
	cv=none; b=kkIYNTEcnNlDtepG6ZzclTE1Fo7tr8yK9XVIjW21QTKD4nuEtfhXDNWGRDvZuCWFIeA3qCYEf+DbaJVz3SvZtX9VmbSmIxtz2AB5UPWLt2hTSv8QxBzAFMdlH2M0PqcEeqVrN+4jmugrppwTl38q3pHlvMSbiFD1KlXyFF7H+/jGDzCZZCmB2ATg1Q0+rMmjiZcowrkAzh2BZAxk5DkFGlzAOMLSCGTCa9DOzF/0IXx7mcNDiNRVqeSgeJhVxZaNnBBlcxofmjOSrxeThNRJeyhleSFiKnPbRBnPhowj78VFNGERHfgiXJTMjN5IclEr4CRcEYK+xkQrKNayf663Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456082; c=relaxed/relaxed;
	bh=K47qRPAQ198u1Fkbi+cWvMQCeIpB3dQGzP07geOfbJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/r05ouPn1kX3E8FJZwyW6jNRyK+Zw1jMcEWzpnBkY7OHJp4pmReePT96u0l2ZEfSexd75JTvvdlekHBj2kH3B5SgyGoy8GCaL2ryjDInjOMV9Q0eJxEsQ8NFZBy4TJlZuZogkAE8i0cnlpzZH1xgbrkWKcYcph3M003LAt2XOEUpyrqO15cTv4YMfYGiAP+oVxkUN6BjkpKu9qJusluPqkl5JPrwPWQcZnF3L0CLgH7+odZ01ifrGQGfRazai3a+aUGyQkDqb5NNACT0P/dZjwXncwdifg6vdpfa1+jA9SVjj7pWWFZqOOxlquQr6ONB7q/CZbHXgXpIsV0LjMhwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fuiRg6XW; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fuiRg6XW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132f; helo=mail-dy1-x132f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132f.google.com (mail-dy1-x132f.google.com [IPv6:2607:f8b0:4864:20::132f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mkT5GMPz3brV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:41:21 +1100 (AEDT)
Received: by mail-dy1-x132f.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso5822013eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456080; x=1792060880; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K47qRPAQ198u1Fkbi+cWvMQCeIpB3dQGzP07geOfbJw=;
        b=fuiRg6XWBFk1c6ne49foWNPTdJQAANzSEcA5FbZ2ZpWkzGiWrqtIkI3nAE+XsDRbJA
         vTl2U8g80JnJ/UskzhXdWSwJrFhJbSsu4+IE4JInkQTRPMTbuFNd44FN/3F6mt21dwVd
         lUuVqdZAvOliJxJCjUubc7eqhkRdXHYXH365TehDA/s6OqLeZVLFOSYQp7UtB0uuPNro
         v71XL4nWGhD51o2iusObkZtiMaRQpBtTsAlevORB0HmqkDfTTW+/9DDn4WtlEVqfE0ag
         EJpnXSfjx6TJ5AHptvm5VCxPpR7MHtuj8eLyMJAlCqT/xormUzlSRUF+2//He/7NRCZ8
         5ARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456080; x=1792060880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K47qRPAQ198u1Fkbi+cWvMQCeIpB3dQGzP07geOfbJw=;
        b=09vIBxQxqITaVWQBXVZwfOiZRqOsF1IWBQCSD2b0Y+BNAHPA4/Ksv2Yqr1Ho7XBCgw
         cpG335CXq/nkHBmAG0eUcTSpo5MgajuD8EHzJ6JhjXfLeDUwSEEGpc2K6Sl3jJ1asst3
         apWNb+bfKS9T5YLvR+iqUS1RtoOH2yuoRpGjQrsL4yt5M1Pna/tx164vEAygQbgwTQuP
         G92g4sA8O+tIB+iwR8xqd5mDWSjA5SSDQewqN6zzEbuMEkImtXgVegNsLSzzW6/JhoJJ
         f1rN3Ui/mVIIl5pxysKkmLwaDFUCXlrp0inatXfrRAWu1TuDQew3B2Xb/lRHFKYAuZr1
         OVaQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBckryGG5WfmldfV7oIHPeNeL65bTuIvhBMc8dkOl2T1NkpOuI8H6CIJFB2UEWCvS2vbNFDRM2LaIZSrk=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKZloldmzGoL1DFPMxPPS77kO63tQBdynGT2mtEmZuAzXfKQMTS
	FV6vHWdQaEavXkobOBqXKstsjJ64/Yi5Z8PAVOLAdI+WeCpNvZDxTSDO
X-Gm-Gg: AYBFou0xziLGyXgs/Y6zASHnj3mZIJ+XcALJHgO+SYVJMp2Y1eylIVR9ZKPWb8xdvFC
	9TACzl4urE6KKS2fFnhFOW6EQbhAFyQ9m2t4vZAaabnNLS/O+gCw17oCpXBQraSUu62LXrD/FKh
	7oSPVhioJ6pF3mA08nnMeLGkAKGk6tNyi1EMhI2l8QpVWG710l80SK2cvm9fnADp4SotP38gnt4
	w9AYy1fk+AL9xatU2on8GVIsNAWlsdAWoL0PSUit4nmlF3COcAgTLE6YyiygyLnCj2QO5jbMuMe
	CyzEyn/E+4HbZamC3lQFShAdIlZjqZeBvgkt9rXvY1f36AY14OzYqjmCalBkUt8rjvibW3u6bTG
	NuRcupE3ogizU8URRMGxt3Y4kORGGxSSm+Y7UxSnEWfQ/Wcr0MyVJq4K0qQ7GU+qL5W/i7Q8TGb
	CMgUE+LAqr8qvjOUxeSj2MVehB/rUSQ7rl88vSzcZlJQSv/vOuLrKbmUx4wn0B9AclSC+d/ALzF
	qiVeGMyORWqGSXLd/DGDz0J5SgfLlCDH3uIutTcHOKd3t3beSiO+jZBtYCwCsprXAYzPLPBXu2j
	OfkbGIjfD5RLCQ==
X-Received: by 2002:a05:7300:6ca1:b0:351:4d2d:af26 with SMTP id 5a478bee46e88-3515d86f0aemr8805338eec.2.1791456079525;
        Thu, 08 Oct 2026 03:41:19 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:41:18 -0700 (PDT)
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
Subject: [PATCH 09/24] ASoC: atmel: atmel-pcm-pdc: Fix atmel_pcm_close() being skipped on rollback
Date: Thu,  8 Oct 2026 17:38:16 +0700
Message-ID: <20261008103831.542533-10-phucduc.bui@gmail.com>
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
from atmel_pcm_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 92dfa6198623 ("ASoC: atmel-pcm: split into two file")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/atmel/atmel-pcm-pdc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/atmel/atmel-pcm-pdc.c b/sound/soc/atmel/atmel-pcm-pdc.c
index 374f93fa6e0b..552bfa30d4ba 100644
--- a/sound/soc/atmel/atmel-pcm-pdc.c
+++ b/sound/soc/atmel/atmel-pcm-pdc.c
@@ -295,6 +295,8 @@ static int atmel_pcm_open(struct snd_soc_component *component,
 	}
 	runtime->private_data = prtd;
 
+	return 0;
+
  out:
 	return ret;
 }
-- 
2.43.0


