Return-Path: <linuxppc-dev+bounces-29516-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25976CC6B2D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 01:44:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4rTC1Wczz2yqT;
	Thu, 15 Oct 2026 12:43:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792028639;
	cv=none; b=BBS9UM6B+jYwfm+t55Vr8zQ4YS36p6+V/LqYMn6xt7rAWyuvubNkacXxkEGPrRv0vKzFb0ErkMRqFkIXXIQP9RnczKHZWmWknkYbNQOR1mQCqxloGAhhRiynftwy4RaslHEYPdniaBydRw3+Z43nY6OyquylQiMnXq4Jje3H53wOxxoto1TxXEdOxAlKLXqsrRu0cpi8awbfxrSGO9GqRhc3FE6P9n9NvHLscwZHlOpTduBSWlY9vMHNkkcEymrGEVVnza96nXM3CZAbvJtVoO/PZvhPiRUM7P5Dg41YW0Ymvoe1hd8diOcJU6y9ZtxhgGxOHHGqZ5z/HXrx+XZ6GA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792028639; c=relaxed/relaxed;
	bh=geVeIRJMETVZrOFQgXZr74ay0B29FFoh4B/JZUuVWw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bRHWkX8u7F63CJeGpTP4alyY9hjWORj1yOMWTv0Aaj8baiHXGBig9h63n5EOmd3aCUeEwOy/LAykT+x2OvT0C7YoJjSVYOlMbXOZ0cScAJBMwuiwyymB94SCDag2gfy3Y2Qa7gYXY5Iy1gnWH4LtHZrIq/AEg83RjgTMCKMVtGRpH+aIEVSszQOwW1v0tBW5Wxa6BkKGym2xF+LkQ/q0UV52O246hIZtyNlLW0qpfoNKbhOldVZorHpOKzWFILCbBJOce6uCKdWqs0rTroEdSF9b7hcNrQ3Nix2veMQ1FjojH2/DJF+9d6Md4mA5LKQekCWa6LV56hJA0wiamZZloQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=phxGd8+a; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=phxGd8+a;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4rTB35DRz2yWy
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 12:43:58 +1100 (AEDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-3a813079a55so3959058a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792028636; x=1792633436; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=geVeIRJMETVZrOFQgXZr74ay0B29FFoh4B/JZUuVWw0=;
        b=phxGd8+ajBmR/arqWGTIdT7oGQkSlcvd7kAB0qUa2dyLf30qJIAcmUS6/HiRD2ivl0
         wU+hAyil40YXwjVWgnaswWOWuAQCFbI/gofLF2HJvQORV4/d8qVH0ihEP2/q/i0oyvSH
         CYn79gTz/KVEY5qHybufSxA86b9GiqJbmvPmwA+NnRpnw02fioJaG6+NSHK8ofwTdi09
         PuKUrOrWglUf0KKEZ2FJrlfStIwdEntj5WOFC1jZEbpzUZGT9c1wmDluB6N8OuCY96xA
         U8iYt9b0OuokzyaVSVbEpErjS6lrebaX1rq/7X8tKXYhBqGQFfk1xxZIJGhAZr1sGqb7
         T6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792028636; x=1792633436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=geVeIRJMETVZrOFQgXZr74ay0B29FFoh4B/JZUuVWw0=;
        b=lyfblasGyEBp26ghBYc9h9BIRnktKxjdePJcX7ucuavXEPTQZifNkqjJs14esYTnAi
         JS5sGmYgb+1NHn4lCx53KydBoJRT+/WEyqygaN+2cjdb75ZFV6TMpT2i791iMcnXrUOd
         3Gt9juaqsBe7Vb0WWz2VV5GYjkJ539dzu59yh+ZFvCutRv1ph1bOKBGyn5C+x/kPb0WZ
         0b6qtzkBEH43Nnz8E+1ipbNMAZSAcKS6yJ+Q6t9e2+eEl0UUS3hvGTyQEI+NWV1Xk9MA
         TZq/Qcji7eqS7LzOzuo/D3UdBfXDkEkIu+VmZk+bikP0zIToMKoD/Q6ENgeXp4Qyxg+R
         F2/A==
X-Forwarded-Encrypted: i=1; AKwUvBwvxY6bZArt3eLBnisdtGYmo/67ArsKNMn9fkAitGltkX0Aq+8Hng9jmYvYfpmAxSej99tdM6bdXubxcFw=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLT7gW+zXwAkWFOR/+XqxwbdTqVcljco+wFjA8ENX13hRSi7JOR
	qKd4k6cTXKo8vyeonTLP0qMIyTc55vsNbHbGA/+emy5uBO8M9vzia0L2
X-Gm-Gg: AYBFou3KOXurcR8XeUboBQS9Tx8q7v88WqiBDsDjb4QyuR1vOH4ZejjbobgXxQLmNzr
	E4GwAqdMyYSYAtg9o7b5JEJBluCm5wAhm0pl5PF6V96C7hipFodTfyUfW+4acG6onTWGVPuUFZo
	00qSoCjuW3dA1kscYpg7QSQUeDKc7s9R3K6d+C8K+lk+xd7JWBA8uamWNYuM2HibgVxRl7t+UJh
	JaKfCqacHG4l+CvlXBQ+ExXOejcsgRJqKEJHkA2fnuw9wwzX9kKlDqiel8eYrFyQw9OrY5h1a4v
	QFbE7Oblked8C5sSFE3uxaysj7xiipKQYznJE3LZCHm6GKl9xhNDikcFjIWdsDCXOPzHDvb6APg
	YbaGjR8jYC2eNYHyFgneIogQQgu0MAcNQDgyVRDPkyIZg7x0ZDytU52Tcdl6zB0L49cwny/mAuE
	rYvNrttiX8w9JOLLm96MqXTbukA271F4X/emHZ0SsHnSkQau6nzTff7xWJTP8EegnvHOxHbG4tG
	sWRxWSH28t2lmRF3ZtVezXhiYP/459ENlinUZJmZil9vIHyvv3+zaEc/sa3j4sdiiV5ipOknCOJ
	8yEF39LIkZPi7g==
X-Received: by 2002:a17:90b:4a49:b0:3ac:a167:8542 with SMTP id 98e67ed59e1d1-3aca16787f0mr98748a91.30.1792028636097;
        Wed, 14 Oct 2026 18:43:56 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cc1sm73202995ad.54.2026.10.14.18.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 18:43:55 -0700 (PDT)
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
Subject: [PATCH v2 00/25] ASoC: Fix constraint return value handling
Date: Thu, 15 Oct 2026 08:42:59 +0700
Message-ID: <20261015014324.5569-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Hi all,

snd_pcm_hw_constraint_minmax() and snd_pcm_hw_constraint_integer()
may return positive values on success. However, ASoC only marks the
DAI, link, or component as started or opened when the corresponding
callback returns 0.

This series fixes affected ASoC drivers to return 0 on success and
properly handle rollback paths.

Found by manual code inspection.

Compile-tested only.

Link v1: 
https://lore.kernel.org/all/20261008103831.542533-1-phucduc.bui@gmail.com/

Changes in v2: 
 - Add Reviewed-by tags from Vijendar Mukunda and Chancel Liu.
 - Remove redundant integer constraints already applied by 
   snd_dmaengine_pcm_open().

Best regards,
Phuc

bui duc phuc (25):
  ASoC: amd: acp: Fix .close() being skipped on rollback
  ASoC: amd: ps: Fix acp63_pdm_dma_close() being skipped on rollback
  ASoC: amd: ps: Fix acp63_sdw_dma_close() being skipped on rollback
  ASoC: amd: raven: Fix acp3x_dma_close() being skipped on rollback
  ASoC: amd: renoir: Fix acp_pdm_dma_close() being skipped on rollback
  ASoC: amd: vangogh: Fix acp5x_dma_close() being skipped on rollback
  ASoC: amd: yc: Fix acp6x_pdm_dma_close() being skipped on rollback
  ASoC: apple: mca: Ensure the DAI is marked as started on success
  ASoC: atmel: atmel-pcm-pdc: Fix atmel_pcm_close() being skipped on
    rollback
  ASoC: codecs: cs42l42: Ensure the DAI is marked as started on success
  ASoC: codecs: nau8325: Ensure the DAI is marked as started on success
  ASoC: codecs: nau8540: Ensure the DAI is marked as started on success
  ASoC: codecs: nau8821: Ensure the DAI is marked as started on success
  ASoC: codecs: nau8824: Ensure the DAI is marked as started on success
  ASoC: codecs: nau8825: Ensure the DAI is marked as started on success
  ASoC: codecs: wm8580: Ensure the DAI is marked as started on success
  ASoC: codecs: wm8782: Ensure the DAI is marked as started on success
  ASoC: imx-pcm-rpmsg: Fix imx_rpmsg_pcm_close() being skipped on
    rollback
  ASoC: intel: atom: Fix .shutdown() being skipped on rollback
  ASoC: renesas: fsi: Ensure the component is marked as opened on
    success
  ASoC: renesas: msiof: Remove redundant period constraint
  ASoC: renesas: rz-ssi: Ensure the component is marked as opened on
    success
  ASoC: renesas: rz-ssi: Remove redundant component open callback
  ASoC: rockchip: rk3399_gru_sound: Mark the link as started on success
  ASoC: rockchip: rockchip_max98090: Mark the link as started on success

 sound/soc/amd/acp/acp-platform.c             |  7 ++++++-
 sound/soc/amd/ps/ps-pdm-dma.c                |  8 +++++++-
 sound/soc/amd/ps/ps-sdw-dma.c                |  8 +++++++-
 sound/soc/amd/raven/acp3x-pcm-dma.c          |  8 +++++++-
 sound/soc/amd/renoir/acp3x-pdm-dma.c         |  8 +++++++-
 sound/soc/amd/vangogh/acp5x-pcm-dma.c        |  8 +++++++-
 sound/soc/amd/yc/acp6x-pdm-dma.c             |  8 +++++++-
 sound/soc/apple/mca.c                        | 16 +++++++++++++---
 sound/soc/atmel/atmel-pcm-pdc.c              |  7 +++++++
 sound/soc/codecs/cs42l42.c                   | 16 +++++++++++++---
 sound/soc/codecs/nau8325.c                   | 16 +++++++++++++---
 sound/soc/codecs/nau8540.c                   | 16 +++++++++++++---
 sound/soc/codecs/nau8821.c                   | 16 +++++++++++++---
 sound/soc/codecs/nau8824.c                   | 16 +++++++++++++---
 sound/soc/codecs/nau8825.c                   | 16 +++++++++++++---
 sound/soc/codecs/wm8580.c                    | 15 +++++++++++++--
 sound/soc/codecs/wm8782.c                    | 12 +++++++++++-
 sound/soc/fsl/imx-pcm-rpmsg.c                |  8 +++++++-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  7 ++++++-
 sound/soc/renesas/fsi.c                      | 11 +++++++++--
 sound/soc/renesas/rcar/msiof.c               | 16 ++++++----------
 sound/soc/renesas/rz-ssi.c                   | 19 +++++++++++--------
 sound/soc/rockchip/rk3399_gru_sound.c        | 14 ++++++++++++--
 sound/soc/rockchip/rockchip_max98090.c       | 15 +++++++++++++--
 24 files changed, 234 insertions(+), 57 deletions(-)

-- 
2.43.0


