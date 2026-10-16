Return-Path: <linuxppc-dev+bounces-29579-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACC9CC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:10:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5WgT4D6Vz2xS6;
	Fri, 16 Oct 2026 15:10:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123813;
	cv=none; b=dFJzX6a4PODFPsICyZTZw2jiG6goS3PKT/Z69yc5046JH9ur8XO+8LfdcrYJgWbTvX3sE7TrDhE6C/krgvqj0zBa0o/Nh6Ow40WieG64TP3xFih5AzBYMRtaFnjI0k8VNlYON1VCZuDeuXrdgfC0RlzlsOFQRFU2IEPoEykPTJXsuPL+N6gdTzdY2y4/Kz6Onz6wKigKbVj/sel2NmJR+554maoFMcljc/Y5vx8o0oRc3MQDHbGBqKJZhDJb+WJMCG4sUvzUFSs5q30V4ZX9OeI26GdXdgdvUlNnuZSwgm/hxXHa5S0ORLrd+GfVEXENojLTb4ZckxW9INdmZ+pNxg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123813; c=relaxed/relaxed;
	bh=SYnQxKBL88L7bG0SnRsZyN/ibAKxj/QjIVLFKTNculY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V6Sw1uRUvYL5Wo0U92YvOGbWlSp9tiawCz+3Ko6WmcyjDpXhPNdX6Y3Mp+9fabyScrwTW4ec4rn2uI033Pf5lWqxTBTyedFJW62U0XFU5T7tacT5wzoUGx4jvjISNUvlW/XEfcrz+HHJ/25cVhGnVQX6WybX+ZPhyssdCR+KkBuYGRAx4keT0FcaX+PGJRAlDHQ24jIRCrAwqY2eHWnDW/DM+U1J0IZrG1UMP4fCDZnSfDh3HSAx4/quYV0tEdgjLWgsMjG5nmQfIO7G00PM9O9Uv71cOMxkBOJLT9pK6FJ7CX2TUTnsflDN0fglpHqb+P8SRZnx4+BmVBo2bKz+9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OuMTz33W; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OuMTz33W;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5WgS4mqPz2xNC
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:10:11 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2e60f9af6e6so22915265ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123809; x=1792728609; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SYnQxKBL88L7bG0SnRsZyN/ibAKxj/QjIVLFKTNculY=;
        b=OuMTz33W4Lx17wJgHZ0uwAaNELbo7nUg4L0D+uxJhHCVX3iiukkFVbtzXX2tYr/khd
         J8tP6SFn0uIOjvdIzK+KSvVDGBOdrQftq50hN0tkGgI6JYvXSoP+s170uwm4UgxG55HJ
         pbH1hF/BjLkkjR12jgsuiS6dsmINlKKxGzq+SK/mBx4XMs0G0mO1kJEFj+NmTIbcGonG
         36//2Mqmgd7uacv6FQHjT5PipCn/3btNV8EhbptHZEhbwMYK12hCQ2Un6C19V824xgvr
         s9fssx1p+J/yJoQY0phh6tlZ47q1N39JoUUyrOY3pOVe9ShQuZHucC4mUfmNPOVzlzOd
         X55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123809; x=1792728609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SYnQxKBL88L7bG0SnRsZyN/ibAKxj/QjIVLFKTNculY=;
        b=qL4nFCl97C9qwKn70zihcELVuQdDBYucf0d/DGRkz9m4YY9fTtiOJm4n2VZ61U9w/c
         EPs/dDqX5dAnvyN0UK6c5D3C1wSGIjnZTqrryEdBY4uWl9AJgGpy4uGMZmxfD/sgF9yR
         PanIIOjOvNZa9FdvlVYLoANX+dkcyRf0lFiuFZHOtFZOwihYzSaRr7a+KiyFf62powTL
         HyrIgLYlBPe2jzFnp8n4Tg0XkLQ2VFPTySartmQxQ9msXM1OT5m9k8vAyoosB2W8AOID
         qux48i2RqEn+Pj3SE/GUVhLn+H5UIQ4rW5xQ7P7yZxpzSpgce3jSq5rXC4BI6nBBSohT
         Iflw==
X-Forwarded-Encrypted: i=1; AKwUvBzXXnz5+giJ9i/WrXJ5WpR0IG68IwvU0QggtSvqYwChUg/9XinI3Yr9INbTXvMa5j1Jc4MtBzFkXgsm/lE=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKNh99BqBmLA1mJ/JvlftMTGA+GY3AlgnNBWSV7XS2jTE7vdNz0
	S0kdZsGjJKALBk1v4ZGMJgdSAse7exA/xjOIGKqzKcMb5DYFjT9yrdHt
X-Gm-Gg: AYBFou3nBrnByTfaBxeEaRzC8np3VCaUa4hONZdbt1UC095YId84+9z983ETT8eKqat
	lisN3er03/GpsgLO8wC+0l4DDPh0Eglgj3jYmh+hR71cfvAC7TOU0Oftb8Bud/SmWnRp8uoC14X
	6PBsc+kZM1Q0NKq86Kp2vNo2Wn+6AAo00RIYpeTzmkI1kcaSlncUxXpm5CfsxyAwbQbiF3/oMk2
	s1J2lCFkR27j7/qjEmz0DsVxQ/xsn+hhStT8OrpE78nGAXpWIrTF6/WbcHFhETpqmQgvCjCZjIJ
	eDtc4BYZwu7cXWaOkuYthVkqFRMiUuyubOjAB+8vgRnwK+0CPkKSfiPMyupwoXPzWcg7ipqWQWe
	f7hVDOZD/IxUcFpQeuALwxSs/iDiXb8jJ96ir/a6vgXyju9cXGs5Lg37vUL1gvetVEoxdpJM4AN
	VOuZVJbhlWQm0Pg5x9Lg4JEaFXnalni4UaC0U2Q4WB8QdofK+RDCZshP7WAdTFe9MAeUSj/VDcd
	sMpThCdeNSM/kBeb6kXwM2jGJeQmtvW+/KEgNZtQCzQjlIRH/XZo3BMcRqZd7Rrgstdt9lIATZZ
	84r56hB7Jg/oDQ==
X-Received: by 2002:a17:902:cec2:b0:2db:7941:9e11 with SMTP id d9443c01a7336-2e842cd431cmr197979565ad.9.1792123809100;
        Thu, 15 Oct 2026 21:10:09 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:10:08 -0700 (PDT)
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
Subject: [PATCH 00/11] ASoC: Address remaining PCM constraint issues
Date: Fri, 16 Oct 2026 11:09:35 +0700
Message-ID: <20261016040946.521195-1-phucduc.bui@gmail.com>
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

Since v1 has already been applied, this series provides incremental 
changes to address the remaining items from v2:
 - Add comments explaining why .open() and .startup() must return 0 
   on success to prevent the issue from being reintroduced.
 - Add Reviewed-by tags from Vijendar Mukunda and Chancel Liu, 
   and Acked-by tags from Morimoto-san and Cezary.
 - Remove redundant integer constraints already applied 
   by snd_dmaengine_pcm_open().

Link v1: 
https://lore.kernel.org/all/20261008103831.542533-1-phucduc.bui@gmail.com/
Link v2: 
https://lore.kernel.org/all/20261015014324.5569-1-phucduc.bui@gmail.com/

Compile-tested only.

Best regards,
Phuc

bui duc phuc (11):
  ASoC: amd: Explain component open return value handling
  ASoC: apple: Explain DAI startup return value handling
  ASoC: atmel: Explain component open return value handling
  ASoC: codecs: Explain DAI startup return value handling
  ASoC: imx-pcm-rpmsg: Explain component open return value handling
  ASoC: intel: atom: Explain DAI startup return value handling
  ASoC: renesas: msiof: Explain component open return value handling
  ASoC: renesas: msiof: Remove redundant period constraint
  ASoC: renesas: rz-ssi: Explain component open return value handling
  ASoC: renesas: rz-ssi: Remove redundant component open callback
  ASoC: rockchip: Explain DAI link startup return value handling

 sound/soc/amd/acp/acp-platform.c             |  5 +++++
 sound/soc/amd/ps/ps-pdm-dma.c                |  6 ++++++
 sound/soc/amd/ps/ps-sdw-dma.c                |  6 ++++++
 sound/soc/amd/raven/acp3x-pcm-dma.c          |  6 ++++++
 sound/soc/amd/renoir/acp3x-pdm-dma.c         |  6 ++++++
 sound/soc/amd/vangogh/acp5x-pcm-dma.c        |  6 ++++++
 sound/soc/amd/yc/acp6x-pdm-dma.c             |  6 ++++++
 sound/soc/apple/mca.c                        |  5 +++++
 sound/soc/atmel/atmel-pcm-pdc.c              |  5 +++++
 sound/soc/codecs/cs42l42.c                   |  5 +++++
 sound/soc/codecs/nau8325.c                   |  5 +++++
 sound/soc/codecs/nau8540.c                   |  5 +++++
 sound/soc/codecs/nau8821.c                   |  5 +++++
 sound/soc/codecs/nau8824.c                   |  5 +++++
 sound/soc/codecs/nau8825.c                   |  5 +++++
 sound/soc/codecs/wm8580.c                    |  5 +++++
 sound/soc/codecs/wm8782.c                    |  5 +++++
 sound/soc/fsl/imx-pcm-rpmsg.c                |  6 ++++++
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  5 +++++
 sound/soc/renesas/fsi.c                      |  5 +++++
 sound/soc/renesas/rcar/msiof.c               | 10 ++--------
 sound/soc/renesas/rz-ssi.c                   | 19 +++++--------------
 sound/soc/rockchip/rk3399_gru_sound.c        |  5 +++++
 sound/soc/rockchip/rockchip_max98090.c       |  5 +++++
 24 files changed, 124 insertions(+), 22 deletions(-)

-- 
2.43.0


