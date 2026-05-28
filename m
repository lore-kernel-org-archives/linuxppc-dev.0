Return-Path: <linuxppc-dev+bounces-21624-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3078BCD5BD1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 May 2026 09:06:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gR0wS5Xmqz2xMW;
	Thu, 28 May 2026 19:06:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779959192;
	cv=none; b=JIGHMKrvggN2WqjsL7vUSPAKGMB7M9WYMZ69OEIKn4hkSOJiiWaGi9JKeQYlWsT569M2kjKCtsEGgAomwHLlugQvFruxlhyV5NPqcaC8tCjW1B6oVwZZHolNySJb9zURhkDSYur3j27qFi18BQ7trCRcDUMgrGvwtwalI+r/nqpQCpHn9K6buVp7AaEqFkPrwUCBcPfU4H1Gtmh1a0q9d/jzpyCfOgM2OFKbnf5xNrUB24xuoow1CYO4y1DvirAdrK14OICQFlQXubWPlipnwfvGmWYfKnoIQ99j861yQCmD0WC/dx+P7Ko5TwmbelBB6KsGYoQym2koBQGvHBLw7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779959192; c=relaxed/relaxed;
	bh=NCpVC/B+fK7iJncp3doDyeYOwNSb+lqrnGIijdp/R+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zpyr0cyvRoYYFkzV1OsZhMIFZatqHOwG3OjHMrDLgUk1DM+Mlo9rYgqwN8ycxf+j3e0g4QKZEJHrDlOjnmAqy9NPBrTuQE6DVZzvG/Mi0Pa5t0qbHpBXsziNgitRqUd31jwGoD+snw+dFVlx30ayLdkDkbDSIxTYEUEg5osxiOVW9cSjyK0FrjbNvEnLD0UMiVlZgIzNQ2hjB/+iHF0g4sBILvlIUK548MHSN7g0W4aOcUp/XsirrlaNwukQBM0hgA3tKha+pSC5l2h2uTUDuojpITdZYmp51dLGFlEE4ZgKIDgPPZxE/pTjGNNACIDAarCgSJM9jaFp/yUigLqVJQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jLT42A+t; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=jLT42A+t;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gR0wP025Jz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 19:06:26 +1000 (AEST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-43eb05b1875so6608016f8f.3
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 02:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779959182; x=1780563982; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NCpVC/B+fK7iJncp3doDyeYOwNSb+lqrnGIijdp/R+8=;
        b=jLT42A+tuED5dqz3gF3n8cZXRT3bG4DzEYkzkg3qewK8n5XEbQ5AMEdq7TUted/VQE
         0nf+SJc+tjmaN6lDVp7iZPhWsjbggQmMLx95C5qAMjKjuK7cv9bDJcLrdphYqiNTxpEe
         oGcg+XMjIJyzeMLKULP/Ap8iHcyupCWjXJ8EuQUOVcZ+R3sL8Tl766gbTLnZITxmj6SF
         9VUcbqD4Fjw9uYxpPvgwtDN35GaedwxV7S8p4lVa0Ni/DKRCUUd2o53la4OG+/ULpX+l
         Tgn4/sAwMbFvdn0m6YjHMQ999+1I+Q+X8CH03jFZvW0U8wy45hnSce3wu4r2ZK6X6dy+
         Dv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779959182; x=1780563982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCpVC/B+fK7iJncp3doDyeYOwNSb+lqrnGIijdp/R+8=;
        b=j63CgiwG8W5m4lBTzauR8gd9b3T/UeDCvGmunhkZXr/w9jSubcoPPqud0M08d83bag
         Fxdkfk9zMkLhUtzaDD8OGHJh9ss2E19m/DSvtfhwOttmVLJnZBS3V4BEZxQIQ5+umG1W
         cfwv11WPI+3AKk8p4fMGZcBclAJciew/ZYCQC+BOypvPsZt0ugOtGMqq43LWs6PWdNak
         RfFaEpKYjNnX00zzrQppf5dvq61GH6rDhC4M7rF03k9mCnw9yuYbHI2aE5+aaMGS3QXZ
         vgUWxiZbWV1xtUrwXYra53/+YGYOYcvhJ4NZKS+VrBTZgq9/qa/k40uMJpWjNMWZO7+L
         MAhg==
X-Forwarded-Encrypted: i=1; AFNElJ/XIc7U7tgiuWe2FP1oYbvErAoysc4AdNli2m2pay/Oxi3GvNuQyuU8D48h4lpWGN5HmT4AsxekT7y8fSo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwF5Ez3QjHLoFZijqTbavuP/NHwHIVc9/01vRh3JY+4L34mi8cb
	oG/U9KYjg5anpxq5ACARXwkW+1wDR9hGjNe/lVj0KzICOenchr5bgmnhRb/W1qsMC1Q=
X-Gm-Gg: Acq92OEWOfdeS9py0Fn3nhM/NzpF5oeetMZMJGhRF1P5qrbv7efLK6D4RVfedOOw+Xw
	aMWVDKhVny3ilfx8c7WU0VGNn/NvOTPRUqxBtKGToMuC2KgR6i2DTZT46iwnwzpfV9XA4u3SDiv
	ni5EF3pMMdsPmjTk4pNV7mkpujzsFeAyxuIeaS9eqd9DbeCvM7c0ycR6ooWEYCBo/H2fkYF203m
	bzzG2ltiS0Hsc+2K8d2oo6IL5/fcv+1DRYAMxWAntRwc7VEtXOs1w/z4rkh0mZsudpVaSHl0Et1
	g2DsJhuWB0EhJIsfABTLpYHGOamu0bp6c3DDQEHkRvNlFTn2QwWqZ1pl4xpb5qQ30lhxzHXdiqh
	60kednwOxpM32WYZ+JQ/20GRM6mJFGpXERlHXSMF7ZDy3XPwuKaD/nKTG/W82sCFCQ6A9jLLGv3
	lKyIMsMhIcKoXxsw0JiUMRxzhfVTBculcNA+P9d3iG3Y+Li0DkGY0ZIVi5oFQAra0BrcGtjP4Kh
	r0ZOCz8GBqtAl0lgMisYG76Yg==
X-Received: by 2002:a05:600c:35c8:b0:490:44eb:c1e7 with SMTP id 5b1f17b1804b1-49044ebc2d5mr480016505e9.30.1779959181935;
        Thu, 28 May 2026 02:06:21 -0700 (PDT)
Received: from localhost (p200300f65f47db04e95e43453a0d1648.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e95e:4345:3a0d:1648])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49091d57c0dsm45855525e9.0.2026.05.28.02.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:06:21 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Hasun Park <hasunpark@gmail.com>,
	Li Qiang <liqiang01@kylinos.cn>,
	Kees Cook <kees@kernel.org>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mac Chiang <mac.chiang@intel.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	patches@opensource.cirrus.com,
	Lars-Peter Clausen <lars@metafoo.de>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	=?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev
Subject: [PATCH v1 0/4] ASoC: Use named initializers for platform_device_id arrays
Date: Thu, 28 May 2026 11:05:59 +0200
Message-ID: <cover.1779958164.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
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
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2760; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=pePpbntnwnsj7EYGTYln0S0Z1fUMMahUgMDQxO5w1uU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqGAV3A/XGhyTdPC2Sbsk19+exJrBTv8hN9EsT0 GAAjGOFfiyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahgFdwAKCRCPgPtYfRL+ Tgg8B/9D5gNT6QFkJSSGOnZq876EyBKdLt05krj7I+eM9aYvKsGkdCLHcG7QZHsH64DDJCElr0r rkkvYPqCAgT0nB7gOzo9U0qtyp69Vifs5eRYtlUzz+MYNPrOw1HZyPhMUokS9DH1Pp+kkk1fj3S pf2IkbuFyVhLCrKlKWuXJYjCf8Go8i/nKubc2wg6igcHvdnyTzxT+83dJT/P31ERPelDR9wXr3g NwuRB3IaDbFvfetwIRZGEvJ38cIqOwdZWALeex3CzgiNZyJVzlnyX0/cb63x8sz08tUXTRpK9XZ iQM3C8HjSEsS1U3+EfHXzpVCPMgXHp9ra49eC3vLgqNt/Qh1
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

this series targets to use named initializers for platform_device_id
arrays. In general these are better readable for humans and more robust
to changes in the respective struct definition.

This robustness is needed as I want to do

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -610,4 +610,7 @@ struct dmi_system_id {
	 struct platform_device_id {
		char name[PLATFORM_NAME_SIZE];
	-	kernel_ulong_t driver_data;
	+	union {
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };

which allows dropping several casts and eases porting CHERI to mainline
linux. When adapting e.g. sound/soc/amd/acp/acp-legacy-mach.c to that
and make use of driver_data_ptr, the added const makes it obvious that
acp_asoc_probe() modifies the structs linked in the id_table resulting
in issues if more than one device is probed using the same platform id.
sound/soc/amd/acp/acp-sof-mach.c has the same issue.

If you consider the last patch mostly churn, just drop it.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (4):
  ASoC: codecs: mt6357: Drop unused assignment of platform_device_id
    driver data
  ASoC: renesas: fsi: Simplify driver_data handling
  ASoC: Use named initializers for platform_device_id arrays
  ASOC: Unify code style for platform_device_id arrays

 sound/soc/amd/acp/acp-sdw-legacy-mach.c |  4 ++--
 sound/soc/amd/acp/acp-sdw-sof-mach.c    |  4 ++--
 sound/soc/amd/acp/acp-sof-mach.c        | 14 +++++++-------
 sound/soc/codecs/adau7118-hw.c          |  2 +-
 sound/soc/codecs/bt-sco.c               | 10 +++-------
 sound/soc/codecs/cs40l50-codec.c        |  4 ++--
 sound/soc/codecs/cs42l43.c              |  4 ++--
 sound/soc/codecs/mt6357.c               |  4 ++--
 sound/soc/codecs/wcd934x.c              |  6 ++----
 sound/soc/fsl/imx-pcm-rpmsg.c           |  6 +++---
 sound/soc/intel/avs/boards/da7219.c     |  6 ++----
 sound/soc/intel/avs/boards/dmic.c       |  6 ++----
 sound/soc/intel/avs/boards/es8336.c     |  6 ++----
 sound/soc/intel/avs/boards/hdaudio.c    |  6 ++----
 sound/soc/intel/avs/boards/i2s_test.c   |  6 ++----
 sound/soc/intel/avs/boards/max98357a.c  |  6 ++----
 sound/soc/intel/avs/boards/max98373.c   |  6 ++----
 sound/soc/intel/avs/boards/max98927.c   |  6 ++----
 sound/soc/intel/avs/boards/nau8825.c    |  6 ++----
 sound/soc/intel/avs/boards/pcm3168a.c   |  6 ++----
 sound/soc/intel/boards/sof_sdw.c        |  4 ++--
 sound/soc/renesas/fsi.c                 |  8 +++-----
 22 files changed, 51 insertions(+), 79 deletions(-)


base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
-- 
2.47.3


