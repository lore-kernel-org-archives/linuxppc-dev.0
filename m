Return-Path: <linuxppc-dev+bounces-29048-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE662CA600B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Oct 2026 10:44:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j0mnm38bFz3c05;
	Thu, 08 Oct 2026 21:44:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791456252;
	cv=none; b=HE+k9P4by0jcbneV7GWnpr7ZkWLVWkagFE31VpgB+mpnHSBP5zPUN6WcirSK/NPkFPellgDMOItcNV7Q92zr4L1mATludntIkOLFeyRSLl7p2xjbWonHrsvL2JIMAsz/XI2prpbD9Y0kbxtgXAB8YTmRg+frX2qUNKraqzIBMmLIexySJbiG5UCoXp/502hMSiqEWOWKB0mkk1V0sxwRHC6+KRabu7dl26mdkobwtcZBcOydJE6Q+1LUY9Zw05o+6X/V35s9529x3IRWC+SmXTMqpXkkpUsc6s0+seIRe2bwzLVS88BBTfEZYMre3Xf4ugzkXHj6gYdFtPXXse3KWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791456252; c=relaxed/relaxed;
	bh=uLXKgERfdgngku3yQUE+LcMSxD8yCQ+a/l+GKCCFjt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDhABpF5c2rwlGLZ3TZtUuMDt8grzrcbkbQUx7HVBwijgBs9Loc4xSLUhJvuy7pmQlMOhFCZbUhDjmJpAAamh/VaT949w8wHKyHq71c4bOLMtDnz/NB/gYbSQ2H2Pz8TBnQ+6P2C7kgZgYm02VQ4N/648+OhKEd9+Yjdz+7IvTw6RKAFWDLLLwNuAxe1y88edGd4Q641xTNWWFF4fbPfDDzvTtxBb3Ey0sdNA1h1KeJoECrm0tH3ejfl4CdhU1Qz8ZQxfDQLqvZGpf/XhXllUa2589VrxjC1c9s1zDvZM9d6d4eJeSBQ22VMQBGHm2N32zx/1RhUdeaDxsYS/nm0RA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rXwhmz8z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rXwhmz8z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132e; helo=mail-dy1-x132e.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132e.google.com (mail-dy1-x132e.google.com [IPv6:2607:f8b0:4864:20::132e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j0mnl57KMz3c01
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 21:44:11 +1100 (AEDT)
Received: by mail-dy1-x132e.google.com with SMTP id 5a478bee46e88-351767ef18cso1965171eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Oct 2026 03:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791456250; x=1792061050; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uLXKgERfdgngku3yQUE+LcMSxD8yCQ+a/l+GKCCFjt4=;
        b=rXwhmz8z5/O07glpPAcMHYRQhHKS7IOI5HgjmxIoXEZ6mAUQoZdRjSxv6Qn9Y0wbkU
         kDcdCNfI1VQJF1gVEj/2XIhj0WosiSVuTBila9+dbsglf8nn5euxvHOB6ohR9V08ETbO
         uJSKvB5dFTudx1/KEypfuTk4hhTKL8MJjn4cw6xTr3iWb/Bq5SWEDciTvM9xZIlh7Xte
         LkmgIbvmdrBVSdWl97pjDMTcYw0woC92vDjj4mSzejwwIXdEg9UWccS2iwhY1csHrAm6
         fnYAzvR1vFUlDfwQE2wFgwqo25OXr0tHGTxZNuvi0GsZDB2ZF97/2pF1OtrPXucF8ATs
         8phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791456250; x=1792061050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uLXKgERfdgngku3yQUE+LcMSxD8yCQ+a/l+GKCCFjt4=;
        b=SurKetY1bBt1HRrxX1YAGx01HHuNTPbK9h/NKswK9khgbarJfBvkA0Q1vXX+DpRKpN
         LcKAZ4qkyGpPZoHE6xZAlgUrJVIdNg40r4I+JoM/J1bJJqXBT+KJj//wgfpy8aA1abV6
         HIK1jp5eAUo1a22Nml7oR5A/CUPIasr2WGHCcGxK1Aw0IsgXxJ9NrnzT6aActiiI1cEH
         PmB2NsWYbh5ARIYCKWgKLmRmEO0T6xXlDatlmvwRkTfahcO7opXVSXw+mtNAXmpgtWUh
         rkOzDAyldCve5Mo5QGnj58okpEINqn7iJIK3u2oVLDubUkM8k3mGJ0/d4+FAWW+xkfJ8
         fwOQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpZSHEGxNO0ZioZhBKXcP25b/1pCQXzfeJoVAS78gGXImC5XXxRvdyb/pFPocqMpbkBsqWWpDdxvUxyrs=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKp7YpEn6PR9aYHdzcfcb9Pox0RDKRC8PKk+YyPmx6On7eAycww
	9zjhVj+OEIvMPGGDS3wjGoxhdrsiCcteIyGjw2k4em3kA4BdLDp0TugP
X-Gm-Gg: AYBFou0rq7DU9YbQfM+ekiE+hmWOSTbauDjgwGP4GqpquOzOc/LSP0VN+VgyNuwb7sO
	BYBfz/XysMUHWbI12rkcsZ/538HG8hXLbEHBOl/hiAPwtPux818KkbcNYT0UTIXHG5uS8p/ZB67
	Es37dXlz7YeximWorSLwo80pCKo2DOGkR33HD3reoPFKxj4UYkxhYgEkf74euBNJcK5kCS34Wxx
	cxVjjB9eJ0+164XhajS6jxrP8epzxvl90jAzLbAXc2L9lcnGfOxr4cvoEw+8PohMP4a6dxu+H0R
	3aoVYkJUJNc2eAbKcgsonxOeLQiaAsu89hBLJcpKQ3Vs1opIIkiO2WR9IqfmQeMyqu52oNobY6D
	LvP6LQ5Pf/JjVFFX/k8h3CfuqTGD6RkBCF/LgiTwI8r4k9z2p+bF9ieJEt//QPK5tQjhxralhGk
	/KF6OTP7nPCvaZaHTyiExwWej0mABY3Fs8Krf6n1CAxbepawyqhz325hkYV1vBtWzn23LTqSAJd
	5RAWtGlO9JFollk8xXOQqY/7bXmsMTe3o/f1Yr82Y4FsxCkL0Im3K/8QLhjAJ2R+OYaDUpz6CkR
	Rpb6yCy/ZQPDSQ==
X-Received: by 2002:a05:7300:d214:b0:352:2e10:10c3 with SMTP id 5a478bee46e88-3522e10401bmr948755eec.36.1791456249630;
        Thu, 08 Oct 2026 03:44:09 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3517810b895sm7496369eec.17.2026.10.08.03.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:44:09 -0700 (PDT)
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
Subject: [PATCH 20/24] ASoC: renesas: fsi: Ensure the component is marked as opened on success
Date: Thu,  8 Oct 2026 17:38:27 +0700
Message-ID: <20261008103831.542533-21-phucduc.bui@gmail.com>
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
from fsi_pcm_open(). ASoC only marks the component as opened when
.open() returns 0.

This currently has no functional impact, as fsi_soc_component has no
.close() callback. Still, return 0 explicitly on success to
match what ASoC expects and ensure the component is correctly marked
as opened.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/renesas/fsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/renesas/fsi.c b/sound/soc/renesas/fsi.c
index 23b7e63596d3..88618e4b052d 100644
--- a/sound/soc/renesas/fsi.c
+++ b/sound/soc/renesas/fsi.c
@@ -1811,14 +1811,16 @@ static int fsi_pcm_open(struct snd_soc_component *component,
 			struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	int ret = 0;
+	int ret;
 
 	snd_soc_set_runtime_hwparams(substream, &fsi_pcm_hardware);
 
 	ret = snd_pcm_hw_constraint_integer(runtime,
 					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0)
+		return ret;
 
-	return ret;
+	return 0;
 }
 
 static snd_pcm_uframes_t fsi_pointer(struct snd_soc_component *component,
-- 
2.43.0


