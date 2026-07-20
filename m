Return-Path: <linuxppc-dev+bounces-24444-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E6BC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 06:24:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3Vpp2WFTz2xm3;
	Mon, 20 Jul 2026 16:24:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784528658;
	cv=none; b=MlJNs4PccNiwS3QlOzSjwxZivVxdjPpRCEwjr87YY4XWDISJFADjNhBPIRif9965Bb2IXW+KwOysn+vSXXQ1gUr2jLdEDLfAysqNvTc8iDcBYOkELUgL6t2KVnvDRWfo76gRw7UQ6JrmymJZ21QY9MByw4dow8i/7JIEKmxIrDyvyYm3G3qmczvRVraV6sRV4JiWqybUzs56B4s0b3mxGHCwPnhC91FDREyAMtvYplgTg/E+jB+ENNxDdJ0Mlru3aUAc+/SYfAzx3aw+47YJkPqUtxn+ZUJPslhdAKzby5bBSRMCy/5Dby3hwmrN/E7Tn+o99d3BA0Sl7PfQIL2qoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784528658; c=relaxed/relaxed;
	bh=G/H3laF11WeRlQ2NHJchQO+2MbI7YG6ixP9fYh5lWUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJqYlnK+m9loajgKHDNHDlYRDNcSjMa+6Mumsu7GxdXT+1skGaqqryOpRcCWxLXtL5vxn/+I+NyAsKMc/LIwsxGC1wIHGmG9mk5XFoA6Cq8gkwpfr7WOfO2bzD1bDTxRgjRqueCvxSwcqIIEqz7vgazbWVagRSqee6v0Bdi9ETRI98rbHMz3n+MK9mxh30F0y/PuvKe2d0GEFzDjX33tM8+igFoRxU7e708Sk0R6dFaixwPzZOItYy0ecwf7QF0Mt0YKof5HbIad3dyeyY7gnzjxDiicsB+ECcWXHEL8sFwXK/Pqva67Xr2dIvBsX7Oj5xBoiDHCMhAeP8uo2Wt5mA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com; dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iCTFcuiD; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org) smtp.mailfrom=baylibre.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=iCTFcuiD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=baylibre.com (client-ip=2a00:1450:4864:20::42f; helo=mail-wr1-x42f.google.com; envelope-from=ukleinek@baylibre.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3Vpl0BWtz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 16:24:13 +1000 (AEST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-47f365afc5aso4536649f8f.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2026 23:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784528649; x=1785133449; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/H3laF11WeRlQ2NHJchQO+2MbI7YG6ixP9fYh5lWUc=;
        b=iCTFcuiDX0mK0DTVHTrUWqjIenu0GjzAxIIfGovqAB5+PwWtZh0ZxtQajf2JegxnjF
         xJQMuuxM/SPqt4jKKPAReuFaxrOxtxW1wBiC0BYLtRdfoyXUaXoNnlHb9bb38oU1sD4b
         q36J4IitdeA1DsiiPr13rRM+w1v7a6m00lFk2ancGdB3utNJ8flzEozi2OrWZt0zVUqB
         82lNNRz2CR7j9Usa7WFAZn3REfzvYwKR9vewgbCJcd+s6KFJJ5E8i8CQhcPx8+6502QK
         mgLt0GsWj6cMKJ0leDaBaunZNlf3FND+w5QjPtwKSli/yPb166vZuOa1ongYuAmZV+Sm
         Y+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784528649; x=1785133449;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G/H3laF11WeRlQ2NHJchQO+2MbI7YG6ixP9fYh5lWUc=;
        b=KCSoy/hgsaZqjMpG4nkH4GMc2K3C4ng2hn2INXy8zq4WgkV8CM6ob2UNxzkLU6U4e6
         7F0way2dEA4yuKluA9sF489ud5TnXBur/hvFE6Vn5TQWgKWOplCKtmoTb5EklbeOptIY
         dIDIUFZek/AaWjSoiHOPfp5CrsNm0aVJp+tP3VNLsBP3W6c+uVXfZo03KX10XncMDgu0
         ar2AJEtmjtFiTzkN/GSdSoqnIv/EIP5AVtDKhPiyPuU2MVcfn3qpaZcRNb97VCC2CUod
         3cfr5jsMvJWKRvsmzUGkhT4yONUnOTfF3rY59ETIDtglCe6bBCpmX7+VbEAkyYERR+4g
         jlIg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+RrkRXrEWprldOsrzjv9x6Rb19fHdIaurl2NC4Yd8b4zyf6Rw5UgVcaZERYHwMPFNvFji+3rB0oJfQg4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy9WkVrSqQXGIXtOGnhZECCGBMqja2ZtdtYUge4SX/qGnzD4g/C
	E9BKk/iI77iW4qfGuTuVut0qfMaiJZD3IHQU/bDFYk3yVLLv77nQ1oFKm2E1+dfWmfQ=
X-Gm-Gg: AfdE7clgpY4LAadiUwk9vDdpS2jU8vZBiylmIPXPeFZyaIaNp9CXoB/pq+PKHsBxS6Q
	aLw5+bVH+oZ+VzkvtsxjOU5UeiRzYjVfQXN3DZmrfryEYFcSyW0JPAsZY50CR12QtpQ3FmqcxUs
	IyBxh0RE367RnDkSG8D88xwub2n8c0VDSf4iytjwiwsc8l42s1wMMrMIuj7bPHz5LMr/YecbOq2
	KkRPsin/pm16oq3o9eqWvinttaglzlpw8brM/dQNClNr9RTy5V71//33pL0SslDsrmd1ZU9Wj/H
	de1jp67nSRY1ysQhhzRaumBrUjCmM82bnM5TeGuqVo6qW6aUnNFQ+CfnL312YLMwPGV8hLWajps
	4tMfWxvWqDLD93LNy2qPvvgJfMOGaNTQJI99f3+/JJdnboI+MHmUV1hlmh7fACwcSll50ntDAEU
	qM+3YQ4wfWrZkkazszpNWbt3UmGGgj
X-Received: by 2002:a05:600c:6a08:b0:493:bcba:46a4 with SMTP id 5b1f17b1804b1-4954a404528mr88685635e9.20.1784528648411;
        Sun, 19 Jul 2026 23:24:08 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4954a2e83ddsm243760905e9.10.2026.07.19.23.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 23:24:07 -0700 (PDT)
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
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Syed Saba Kareem <Syed.SabaKareem@amd.com>,
	Aaron Ma <aaron.ma@canonical.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Hasun Park <hasunpark@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Kees Cook <kees@kernel.org>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	James Ogletree <jogletre@opensource.cirrus.com>,
	Fred Treven <fred.treven@cirrus.com>,
	Ben Bright <ben.bright@cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Mac Chiang <mac.chiang@intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
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
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	=?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev
Subject: [PATCH v2 0/6] ASoC: Use named initializers for platform_device_id arrays
Date: Mon, 20 Jul 2026 08:23:44 +0200
Message-ID: <cover.1784528081.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3614; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=4tB+67YMPAYA+Fp7hKThmFDs4EE5gnppfw4oTodipEM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqXb7wZqEDAgS99aNcA7ppupT1jNl9C2tgs/w94 zfkKA6R2EeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCal2+8AAKCRCPgPtYfRL+ TkJUCACIvjuWjtW0zv6qwyWNZ4eR11ChZWhjx4507jdswfBcqPRWzrztk9x5ZcJAFrtD89Hy1O3 dIQROoiGwIt6/ZT0XrIIuG6ch21Ra870AZs5MZLjQlFKaIK8Ax0Vlhfjs3HuLGrkGESBlhEcUJ7 bb0eoRYQIqpt1vO10ZxC/wn0B3HhG+8aRkBuumyMvo2JoZ2uUuIdxEM38BlZbb61zBzcB/V2Pnp 55oCYIi6Fq8nNZpLZM9cPX7FOwbZDzmX7kNiAY9S+Ewa2h/SCetXD2vMA0WFQcRZ5DGh3zqawwa 3wR1GjDeaQaO5rHw1kluRx9mB4APLagFmV3CpMXKfxK28zan
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the objective of this series is still to prepare making struct
platform_device_id::driver_data an anonymous union. See
https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
for the details about that.

If you consider the last patch mostly churn, just drop it.

v1 of this series can be found at
https://lore.kernel.org/linux-sound/cover.1779958164.git.u.kleine-koenig@baylibre.com.

Changes since then:

 - Rebase to current next
 - Some grammar improvements in the commit log for patch #1
 - Split the changes to sound/soc/amd/acp in separate changes.
 - The 2nd patch used to be "ASoC: renesas: fsi: Simplify driver_data
   handling" which removed fsi_id_table[0].driver_data, but with commit
   38d3273075d6 ("ASoC: renesas: fsi: remove platform data style
   support") that needed to change.
 - The last patch now touches a few more files. (I didn't check if these
   are new offenders or if I failed to catch them in v1.) I didn't add
   Cezary Rojewski's ack because of that.

If splitting off the amd/acp changes was requested because they go in
via a separate tree: That's possible, in fact each file is touched only
once, so the patches can be reordered freely and applied via different
trees if needed.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (6):
  ASoC: codecs: mt6357: Drop unused assignment of platform_device_id
    driver data
  ASoC: renesas: fsi: Drop platform probing metadata
  ASoC: amd: acp: Use named initializers for platform_device_id arrays
  ASoC: amd: acp: Unify code style for platform_device_id array
  ASoC: Use named initializers for platform_device_id arrays
  ASOC: Unify code style for platform_device_id arrays

 sound/soc/amd/acp/acp-sdw-legacy-mach.c |  4 ++--
 sound/soc/amd/acp/acp-sdw-sof-mach.c    |  4 ++--
 sound/soc/amd/acp/acp-sof-mach.c        | 14 +++++++-------
 sound/soc/au1x/db1200.c                 |  2 +-
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
 sound/soc/intel/avs/boards/probe.c      |  2 +-
 sound/soc/intel/avs/boards/rt274.c      |  2 +-
 sound/soc/intel/avs/boards/rt286.c      |  2 +-
 sound/soc/intel/avs/boards/rt298.c      |  2 +-
 sound/soc/intel/avs/boards/rt5514.c     |  2 +-
 sound/soc/intel/avs/boards/rt5640.c     |  2 +-
 sound/soc/intel/avs/boards/rt5663.c     |  2 +-
 sound/soc/intel/avs/boards/rt5682.c     |  2 +-
 sound/soc/intel/avs/boards/ssm4567.c    |  2 +-
 sound/soc/intel/boards/sof_sdw.c        |  4 ++--
 sound/soc/renesas/fsi.c                 |  4 ++--
 sound/soc/samsung/i2s.c                 |  2 +-
 33 files changed, 61 insertions(+), 87 deletions(-)


base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
-- 
2.55.0.11.g153666a7d9bb


