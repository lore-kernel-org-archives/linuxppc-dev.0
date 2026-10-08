Return-Path: <linuxppc-dev+bounces-29047-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8B7CA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:43:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mnT4NRrz2yYK;
	Thu, 08 Oct 2026 21:43:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456237;
	cv=none; b=WXCipSIiwcJ702jQ1jFHYx3iQJPiNE7pBLGmap8xb0JENCR0g6oLct16h+S482bFn7+HkfbS+XJGBa8aDxBHA2xUs4MFwY6Ect2q1uiEgNzfLviYPyjhVeTv45IzA2EYpt/lQRrC5HJpdswYkiqlrd2R52QtsRQ0CI91RozoHPxI89sfQCR42w7JhjCEyFUwdtIEGRIVAAvNPFjA94nLh0rDAbs0sPNhNLVdjxUxTNv+ME1zHHF6q7NhuH38K++rPR6FF8Qma/+CyUXsxoTCaXqmkgO3EJ1/79JYlCSRuXJ64JP5D1kkdTs2blvNr2furS1F7ZxDrw9LWf6xNOacQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456237; c=relaxed/relaxed;
	bh=YXFN+txE8KZkOhxhM5jNUs8Hv1tuj3AnGefbY7UN1PM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F1ZHvn2j36egxBwmUqCvWOn0oxTPVU/IVd1rKAD6/GE69fZ3MDNP9wPrTsvfZtipgPDFdWHHIyGiTV+EA2St6WitqwrXzeN1lnriGvoYoZiOcWnIy1pD7haNI41Ayjh/pAL+RiBn8WMKKJ1kevfqqSBXjEcLC8RsEh22M0e6ew2BqDH+OS4x+FeLYsM+3jHJQbAAnE4ETtefuC1OCGgDhxqNw5GFiZ70gSQ0YXD3Wf9hA+CZtOWvmvl0OCK8hh9IQLq65LcD0zdvNZpKc/mSKC1842UBoBJ8npbBrmfNdrTKlNDD6Ai/27Y2YSbF2dgHcNLLRmmXcesL+Pjrb13vbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eVzgV65h; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eVzgV65h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mnS5Xkqz2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:43:56 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-351775aa1c0so1015669eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456235; x=1792061035; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXFN+txE8KZkOhxhM5jNUs8Hv1tuj3AnGefbY7UN1PM=;
        b=eVzgV65haRIvlx//yx2xWylenFA6ygrJB59GpYVMauVmaFAcBA+QPWwrs8xWs7sGWu
         XgJDeZD6JXVejVGNBNsoxworMBUis0AHjwXuUPzjSUjbZ72ms4V/8aXzo5jnG7W72LL3
         +AM5UF9T8Lur1EG05Fz0QlSlsNGCyqXwuhe9pQsJPjM4YobRQDlxB0CDzFeyci/jQqtx
         gkR7qX5Ro6pDRlR/6/F9o6cSoiXrbcmF6GaczPUXdOqk7NbPqFAAfnnrhn4xTvrLf6wn
         cDn9HnzF9mgz8rQK41d3RhPlViSk9+amZUaDcePlVlZY1NBHoo1jcNg5zApMpLbULk8K
         clug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456235; x=1792061035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YXFN+txE8KZkOhxhM5jNUs8Hv1tuj3AnGefbY7UN1PM=;
        b=nVMx1NQ7PtRhvoDVjzKERFukvrmbCT4rWLjSrcQLbdtDqcRTZHYNMXZ3tXPoktKPdc
         gLNlQtwnVaoN1dCyw386+T+7xsNlZfkj16UERcZPn/IvZTKyFJnPfnLb08MOe0e1Hv04
         0Xs3yNnitGljGG04lGrCShJ8yh9nJQXpYfMhJG4kJLVNNDE4elD1oZ0Ka1SSeblAvMsz
         4LT+kWE1Ittw2lJQQy/rhRWSTiHSW1z3xxqiJ84j4wTyTomqxSk8z9PmNPZMtKMKpcl0
         Sjj/rMWYKBuuWfTIDqIgtDvIJnJcyW7yjyigHBY1O3PeLMC5XoSZYrqp27klJ26tE8FS
         rBfg==
X-Forwarded-Encrypted: i=1; AKwUvBzc/0FwcQR9Nftb9GinPuSfTv35ArbXVJ4UztPlfGEgvuKxIXFwIzglWVqd1UO+OtIdGavEAYiU7OPnvXw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLVwElLyseUA/NdsixbjZnl5H2YDtr+e3X29+oJkSUlqANVQn0b
	qKLNXee4YlfgadaYXE6y3CRGLKL+ZngtL0rqAszommD41bI2d5l6huWB
X-Gm-Gg: AYBFou2a9ldQAtgWdeX9vhw5+tcorFsYI0b4bMqW9g1xvQCfQ+CV1Irzu4uTBdNjVYb
	l3g9WeCr+LWt+G9JJeDxA5DwqPxIpKw6673N7fNYJSYonvwuyKFOYiSEmzdXWQgj0xG47wOTZ0W
	dNunn5V5rG1gMCX+gCXj/9NaepZzXOF99K4TB+PvAVDrcwqwAgIFqShZcH5ZB7bMjgRTbEwqaaW
	h4/o6fXlCWWBJRuhIdrJR/Dr6zEwp63GPmxuz7SOKpF24+aucJMymwyiLPfhN4Tw3o6GsVw/tZb
	bdptDhy2ePKANCR9mzvapuLLIf0MjWfQ/Yr6wHrw3EDMHVO1pzSsy6xNbtPVma8OZ7FMRlvaaup
	Pe+5AViN2ialx2m007XAA6CUMFRq6Ps+cLgobLPbDD0ekwx7yICyNPCYYUMS4qHhLvhpgPDYNQq
	ew76oSx8wLRzOw/sfBuvUyaQASJejTJbnmKKzxxTyb7xNXdcdGDFQ1USXVevsz0pifdkOhpIGL0
	dCs1xBHWbA8DBKd9j+r/RigdlvqCxPPtoHTOCQdKzoQM4De+6L5nyWGfzi8UYVKm0GCAhxEGxEM
	x1zTAPxrV0dLV/AKjnDf17sHJQ==
X-Received: by 2002:a05:7300:fd0e:b0:352:3bdd:423b with SMTP id 5a478bee46e88-3523bdd4437mr1444746eec.21.1791456234716;
        Thu, 08 Oct 2026 03:43:54 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:43:54 -0700 (PDT)
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
Subject: [PATCH 19/24] ASoC: intel: atom: Fix .shutdown() being skipped on rollback
Date: Thu,  8 Oct 2026 17:38:26 +0700
Message-ID: <20261008103831.542533-20-phucduc.bui@gmail.com>
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
from sst_media_open(). ASoC only marks the DAI as started when
.startup() returns 0, so .shutdown() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: 4889a8a73f65 ("ASoC: intel: atom: Use __free(kfree) for stream pointer")
Fixes: 6cc0f4e63994 ("ASoC: Intel: mfld_pcm: move stream handling to dai_ops")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index a4c8cbfba096..db1fb3b26909 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -341,7 +341,7 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 
 	stream = NULL;
 
-	return ret_val;
+	return 0;
 }
 
 static void sst_media_close(struct snd_pcm_substream *substream,
-- 
2.43.0


