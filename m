Return-Path: <linuxppc-dev+bounces-29035-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C7ECA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:40:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mjx5Vngz3br5;
	Thu, 08 Oct 2026 21:40:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456053;
	cv=none; b=Cwl0GQ6OC45gTDci0VeyyZiCjR73FBPxZO6RA2MEgrokTSDSixs57LojO2QcKPN25KTIFP2mvm1PR2bu5tRyTMjsTZP9rx6ZcFs5GsIGOIVql4jDNYvbF+w/FwYGlCE/2rajx1YRbtq3kNaEc7ejefUs6Cct0OjnCcZke3bMwDkk9EehYyfwIFJUZpzLijl4JBbbXy/+KdEcRW3Ln6ml3lgtZihFHKvm5qH8aR5foyqW/1cih5dg8ZSjWEjroXmnJ7LFEg+R6NtrcV+gA6MBOxaMPT+RMm5xrBjtc6+pf1NQ3g8TSxEyO14xWYAwJkwQZ1c2kVedO12kY5g2KorG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456053; c=relaxed/relaxed;
	bh=A3hFCOdGFcpARJPE61Pz7wx4lXLyiEMweFG5G2TuDs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYTdRG/0a+oy/DgRY7vOOl8rpAU+sM56GicMpxUuJg2pZ5CHd7JOaQshKGqN1D2RbcPWa6FiWkJosZzKPYEmKaPLEZayY7goM90H2u2wMfLtejKkGKDocCHYBv0qox0kbs8ppa/gW9JAw0o77sRvfFV9f96ARjHbepbhpq3RTnP3BAlLFBbLYXqg9vh96czGyAQMFe3wkgyaQpNMQpSId1jsaW9h9uhMlk+IYRBlF4gSZhmIY74i00NhHylu+AYqGi9BYmQpFGLq0iEOi2OI3nAH+P4+WYZ9/knY6VfWqs3COiTwel+pPRGVAmOIiRIlCyv+daVuyazQp0N21+cyDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WyrtdbuT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WyrtdbuT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132a; helo=mail-dy1-x132a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132a.google.com (mail-dy1-x132a.google.com [IPv6:2607:f8b0:4864:20::132a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mjx0Sscz3br2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:40:53 +1100 (AEDT)
Received: by mail-dy1-x132a.google.com with SMTP id 5a478bee46e88-34bb8b31647so7925997eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456051; x=1792060851; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A3hFCOdGFcpARJPE61Pz7wx4lXLyiEMweFG5G2TuDs0=;
        b=WyrtdbuTkRmLZ1U2euvhmOOUlhXkdjSNMNf3yEkji/MXrvRpp5pgJiLqfCaPSMpiG9
         vLoT5ZwFY0DifKzpIaF6Czln8C9cX/0V1gKqTJXdCICuFBVbw/XC98D+f/ea6ZtGUhgM
         tv3i/ozKnEAy5Ai3tLVt2Vq4QN385IfnrQVz56xXNE31uKOK5cbhwvcuvpFPjf6CBZkx
         UHC2Cim1cJ04dxYO4rtoaWA1yKpEaG3ixlkrAvmd58xCZUSFSLTNl1dCDcp+sGm7dkNq
         NzPpt7jpaw2KCqh9/NCHkbZlcZ1i5FvbaUdE0PU+fq1pW5J/0SbSt2fS8IJX4gTJSDuO
         afKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456051; x=1792060851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A3hFCOdGFcpARJPE61Pz7wx4lXLyiEMweFG5G2TuDs0=;
        b=AfjpqP7ErSRNicsqukc9oh6jmeIVidPAmBtH3pXoP331TtPPTHKBOpi446p/qmyRsj
         6wRtI9bzNG5MpSabS+ySqs9U88cFFyFj0X81n+IDX6MEKrNBXgMgiIOy6csaw804XbWU
         IRwOaihTRSqfYsarugY3XV15QIKCGnpUD1lsLRb2YNa1+KxOY+nIaI12QDhxgYFPiW8t
         SVlml1CTXvLpegta0/lQdpjBPIqf+5/CgWCJVJOO+lEc+eujhYtqOwG4FNE1qEunY6mF
         x+QnciGFA42XlmrzqAadcsIgpFqjMKxckjr2GaMKseBP8+rL81GDuNNQTSMVGjg7/arO
         zJgQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvC+J9H3THCp85lNqyx7AmCzoOTGGcaGSXqV2Rt6uDcwhgXiWodjcvzUKkYxC+LPgbEob8B6/FsN/YM/k=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mkNIv7wCh9lbDpsDSaWD5dt0Kx6Snl9Oc5eCgcAof0wxhigTRW
	vIaWzaoR8NfZI6yFaYq5KaQ32K1rbB8xsiavUPu3HLXcXVc1cCyM9Stk
X-Gm-Gg: AYBFou0LtUxSKqCWymURqXWinN+L2DnyWhDI6Y4xxYYzFefZOkD8y6Uw6KzWlzS+FOG
	PKiPk4SAScKbeufucas9T5X+XzTOJ0IguVZ4Q7yDMNfjcWFkLIKbWND3vaRKUrQ1pS+WVr/kZFh
	GFJ2BGFN88qM/bHgAaCh5OiZ/kds4rNeIMv6jPxu+JLP/5mg8wXKtyVDkFiQ8c3VrslWUfwhL0y
	f7nxYswntuvuvdkF0A6drRwUPB0/RlCH9dBv1lrQmnfEOBUQR69Kinbs7Nz6giPU5y5Ss2Si/Tv
	P0q8rjebRMxsDOsZD/pmBu4bEAvPAs4QOroyuBFl2a2k0JxrbNstS5JNijMnCqgjHiFdynxAuEC
	vw+cmyfQwXlCv2Nk2VH8zI8gLpvS4JV7043DWiYB8VDyTzbV05JqMb1yb/KYfkP7lP43HKaI2T7
	XTLJO1cVhjSrbq+46+U3uZXgAi+tKXkJcElh0GKrWa+dS2Wxhhj7Wt2STi69mohlNQEuXspmqQh
	sIFJfsgSdQf+8JhPrSaUSgXgPBTGsLj3e7biP3CTyxKuArSwIs0rY8CpcPwgE18B8S/G+BXo8HC
	8tvtgYPByBOjHSaKFTPvs/xt
X-Received: by 2002:a05:693c:41d2:10b0:351:62fe:62 with SMTP id 5a478bee46e88-35162fe0200mr5293677eec.19.1791456050997;
        Thu, 08 Oct 2026 03:40:50 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:40:49 -0700 (PDT)
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
Subject: [PATCH 07/24] ASoC: amd: yc: Fix acp6x_pdm_dma_close() being skipped on rollback
Date: Thu,  8 Oct 2026 17:38:14 +0700
Message-ID: <20261008103831.542533-8-phucduc.bui@gmail.com>
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
from acp6x_pdm_dma_open(). ASoC only marks the component as opened
when .open() returns 0, so .close() can be skipped on rollback.

Return 0 explicitly on success.

Fixes: ceb4fcc13ae5 ("ASoC: amd: add acp6x pdm driver dma ops")
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/amd/yc/acp6x-pdm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
index 40c4d833f4ed..afa9f66533e3 100644
--- a/sound/soc/amd/yc/acp6x-pdm-dma.c
+++ b/sound/soc/amd/yc/acp6x-pdm-dma.c
@@ -209,7 +209,7 @@ static int acp6x_pdm_dma_open(struct snd_soc_component *component,
 
 	pdm_data->acp6x_base = adata->acp6x_base;
 	runtime->private_data = pdm_data;
-	return ret;
+	return 0;
 }
 
 static int acp6x_pdm_dma_hw_params(struct snd_soc_component *component,
-- 
2.43.0


