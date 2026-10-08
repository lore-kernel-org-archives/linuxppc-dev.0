Return-Path: <linuxppc-dev+bounces-29028-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCDBCA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:39:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mgx6r5pz2yWy;
	Thu, 08 Oct 2026 21:39:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791455949;
	cv=none; b=P5YQLOxT88H9IGhJWU8Gl5HBFNI2U2Uhzh0MHwpNxqqReHt37HZI4k1MFRmZZeB1Y2xR3GHLgQQDYR+N/ngdIZB/tGUNv+i6l/71n4HKuckUXoQTIeiOOs4KtiyPjLIsykffR8d8wmij7HZHXoX8A/eVW+Wg3qC9fs3B/ksGTajG1wElg5z1wZYlCfgzIgLy/fEwPL+WzV3hYPQxcMYTjkFPy7//N3NXG/pAfCkj3b4Pm5ln2JxRm6K/bJodXxUzRcLX4u7yCiW0I1eINw2RFo+xJpnFwvGb+q0421Ql6waCX/fkdOR1p9Mq6Jtayco8o0WjYT/6+Fl3YXOt+bmrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791455949; c=relaxed/relaxed;
	bh=2hpUwEsGMPkIBbYBiNYjLbx5Pg/A2Eh/bQSXX+ThuQY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9lD8IXbI1Ec86tszB9pAKupx80zq9V6xVXGeGZwHirFDB/V6GSHQR/BNfNf95/FvbKWwZQauZFftaMVTX7ddLO3SjkkcabFO4+TXxweLkV7OLFTgc2sE9kgGptPEvS36uhMiJmf8HAQ0U2113ObSNquhiVYTmtLT3HB5449fsknugPv5m8rsq24jgD+rqA5eZIembH1QO5v6L4qgiSGkd7fROiv6P/LuL0q8Ywho3OR7OR0UIBbP+L9PeWYL2VQS3andyf8MD7rFuC+c7PT2v1O083aqVDkmHKX6gR1P3DBJpMhTmRDB4CgNZH38GgO2g0pEFs4j0hGKJgADY7ZCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PiVIuJta; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PiVIuJta;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mgw3Nxhz2y8r
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:39:08 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso1963408eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791455945; x=1792060745; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hpUwEsGMPkIBbYBiNYjLbx5Pg/A2Eh/bQSXX+ThuQY=;
        b=PiVIuJtaTISVK42fpQa/i22uuycw4G/QnEBix5I+7P+Rm5Io7MAGbUIkibrFSiwIot
         55UjorSRv5CwXGXiynJjXFDM7bvVmYZ/yCgyX4kDvqamX6BuNzkzGL8lotGtv8m7wUWl
         BC8PjV3hfn5a6adYbEe+H5/nDMptFs7sfUHzFlmrDlZNq88VFb7NQOihEGmBgydCYhPI
         NYuhyLEmJA3GPslirUBaNsopI3ugkKzfi0y1wCK7hZ3cG08iLhViLv5U4SIcUDKqnPM6
         D3oDVEBDTTc0V3kZIqfo3EZtN+DkvnIFayvHwfiRa2EpE7GRXSqzVJ3Ig3FULdP0nNMi
         88wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791455945; x=1792060745;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2hpUwEsGMPkIBbYBiNYjLbx5Pg/A2Eh/bQSXX+ThuQY=;
        b=xTC/IAVo9lq0eZZOBm5g3adknkKFLvmPO0yTLMnomZVOuBoTzUIK0sgAYJc38A/1jq
         TEFfEYRNKUhH+nnd4tScwwgj+0mtrHCHrgWj0ZwqN+6rlMuz6DNUgR51IWnmDD00iSnu
         NfaBR3ioYPuMD0610C9X7+qYlLGQVw1UVWkJLOg9d/QZaJmPfLDLgBiCh/V2B7xvjgfB
         aqm7kado+C20BaIL3iLrpOoHNdYo7dV4K8O1CGciXnIknw1w/u1d5HTahoPZbntrkbL/
         cJ47j9zx0tO75dKWetWy5cqOODmEs/m3Sq8NbLEGulOsvOKLozAFKYKIoUalogieZA6u
         tITA==
X-Forwarded-Encrypted: i=1; AKwUvBzLkU8JzqHk5v4Zze++A5qNJvLV4gKskkKLuKeIODK5jt8qclHZQN21ESBNGfTp648LZIL/3dql+fiqFNA=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lNzluM78U6+1kCMyQ7vsz0GDjvM0LNRzHF57fbhfeFqL7BeETl
	y+ZR4p6FmeYVNNX5KAscUico9s5gW6o4rjjmH3VpQm6sKJLq5tyH2YWQ
X-Gm-Gg: AYBFou3tfv9LL2dVzmx5n5Mx+rB9pqB0hlWKHphAFQnMbOXcMlbeejQZWb41VsH2n8p
	g4NoChhWulPlqrsLwhGOgk0og3OWdIB+OVCxiZEfNAYVGY2tS1z6CuMadTwxzmdffZa+qyeQmZ9
	Q8ZhVAp0I7zCpl0JD3/M1V8i/WTQQN8oz6pfyPUMcEOD32WZeTCSbWL9uTfK0HE3vRyVA3yoyfK
	oqNOIJSkEW/vWl4/mwYktrz1AieqbUcWBphlPRYBDywTmPwkKWrpuxZLqSGrCBhhKt1cs4H86eo
	OWFLydM0AcJ60Tk5cZuGd3QgmT/+By7XJWZ09/TKwIfpno4Hs/7JIexbmpQpON81lR0nRzo6Cqj
	7KzS4TRFDQfT7V5V3eXFrP0d4FJEILzGrSiU3bPBVbNAHhVIuxgIEkwxj0UYtzZHee2sOGulo9z
	eN7SEwI/yOmV1ZSnea61jS+mkkAWp4VhO4lxdpVarHOYnoPRNfkkoamfBDx2tjAZdTxlm1b3io3
	ukSs3PhCcQU1PUqsadoE8tnM9LNscVoAAUItGn3QkinJi1f6vDaJazXZF79kav1NFjTOqChTfSJ
	f65FZF6XiyAb8Q==
X-Received: by 2002:a05:693c:8819:10b0:352:2e15:49a9 with SMTP id 5a478bee46e88-3522e154b4amr965099eec.33.1791455944704;
        Thu, 08 Oct 2026 03:39:04 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:39:03 -0700 (PDT)
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
Subject: [PATCH 00/24] ASoC: Fix constraint return value handling
Date: Thu,  8 Oct 2026 17:38:07 +0700
Message-ID: <20261008103831.542533-1-phucduc.bui@gmail.com>
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

Best regards,
Phuc

bui duc phuc (24):
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
  ASoC: renesas: msiof: Fix msiof_close() being skipped on rollback
  ASoC: renesas: rz-ssi: Ensure the component is marked as opened on
    success
  ASoC: rockchip: rk3399_gru_sound: Mark the link as started on success
  ASoC: rockchip: rockchip_max98090: Mark the link as started on success

 sound/soc/amd/acp/acp-platform.c             |  2 +-
 sound/soc/amd/ps/ps-pdm-dma.c                |  2 +-
 sound/soc/amd/ps/ps-sdw-dma.c                |  2 +-
 sound/soc/amd/raven/acp3x-pcm-dma.c          |  2 +-
 sound/soc/amd/renoir/acp3x-pdm-dma.c         |  2 +-
 sound/soc/amd/vangogh/acp5x-pcm-dma.c        |  2 +-
 sound/soc/amd/yc/acp6x-pdm-dma.c             |  2 +-
 sound/soc/apple/mca.c                        | 11 ++++++++---
 sound/soc/atmel/atmel-pcm-pdc.c              |  2 ++
 sound/soc/codecs/cs42l42.c                   | 11 ++++++++---
 sound/soc/codecs/nau8325.c                   | 11 ++++++++---
 sound/soc/codecs/nau8540.c                   | 11 ++++++++---
 sound/soc/codecs/nau8821.c                   | 11 ++++++++---
 sound/soc/codecs/nau8824.c                   | 11 ++++++++---
 sound/soc/codecs/nau8825.c                   | 11 ++++++++---
 sound/soc/codecs/wm8580.c                    | 10 ++++++++--
 sound/soc/codecs/wm8782.c                    |  7 ++++++-
 sound/soc/fsl/imx-pcm-rpmsg.c                |  2 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c |  2 +-
 sound/soc/renesas/fsi.c                      |  6 ++++--
 sound/soc/renesas/rcar/msiof.c               |  6 ++++--
 sound/soc/renesas/rz-ssi.c                   | 18 +++++++++++++++---
 sound/soc/rockchip/rk3399_gru_sound.c        |  9 +++++++--
 sound/soc/rockchip/rockchip_max98090.c       | 10 ++++++++--
 24 files changed, 119 insertions(+), 44 deletions(-)

-- 
2.43.0


