Return-Path: <linuxppc-dev+bounces-29585-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87E6CC6B38
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 04:11:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5Whw4Q9sz2yPq;
	Fri, 16 Oct 2026 15:11:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792123888;
	cv=none; b=FgSDgvPie/f+nh0aVjPek4KCR62PXuZPEprmWVmX2EJg/PkSJUE4BQ0i0pzK17loP0U86043xMs6vmW475PBe/i3ZEeQSfKIaNsBMuYnss3px4UYxyuI58pSTysr1/X+fUNykWkfo3vr+qliAdZd2CcW+ChB8mC2ALKNLmkcQJ2X7XXkAgL+ZwYgmmRGKugJmvxwOGNUSZ6/Pos21rcot8GGQh74nmgGo/bDuzf3fY0MwU6/s9M7cQna+mXyYyaBcJ5DMqP/YjfRAVETRFsm5/DmdRvZYi2S6xYrPJmWCoJQL1kqUNjDZtOCd3qRAcVullRqzrqd5Gz/6HL/T8xNIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792123888; c=relaxed/relaxed;
	bh=dFZz4n9YWSVULVEw1Vk7UW4bxuXJ2XFPuy179wpDhwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d7DGuALpH6wkdKiIt/HPjXSMDWB21ntaI5Jc6QAUP8Ddmo5apJUsZ5/xTZ22mE+ntFrx10W+LkHOjXoYR07p+5bpQU6LMo2F0O9d1LNAvz/zbhh+zMediGOHYVXVK3CiL8QgeT/TAkSC/cmwhiGssXMXoymUw+7clVF5ip6SdvQUW6Y7ORToNAuJ5gFQ/TvxN4gefe8vOYWyXpU6Wp8Lh4RaLn7kjbKae9Sfpw3EpKdsEJP+fSy73k+DqsJDj0Y37Mq38XqcWy8ipvXpw81nOA3iHgcBi5XJGo74M5bfQNtgLI6J9JxOACIsAUvvoVqcZJqFnIa9Y6qf31y0HoMlQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gqprttnw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gqprttnw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5Whw06mfz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 15:11:27 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-2db80fcdf8bso35128625ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 21:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123886; x=1792728686; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dFZz4n9YWSVULVEw1Vk7UW4bxuXJ2XFPuy179wpDhwk=;
        b=gqprttnwhfKcC4iLLekhKj8oqbzYhdBSZoP/g7HRv/9AsVZLs/PksCWWDOIGIZtcWs
         QSZ1ZxMv1UVNrEqQiRs6Za5XxnmFVhEEG1oJW07AKwc20cd2XJaOrs0BK9XFfURs2Gl5
         xOSga9e+Hkv+rq2WtGVYTkjmUWs1a0KBpui5ApD5XqIO5dfj4+vsK+HZBxjsSRhrSL/g
         eUhvpBqriCQi28AEMu8f99NcGiHNQrS+blBja+u0VLxiOjmfqbyBUHxGiJASpHsrAnKu
         P1avlrKQMYVOfN5AB4UlQdSeXWkhBpYFBU+Y3F8Fp2HH5Q/fP6esZdza2FDvktnA2H2X
         dQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123886; x=1792728686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dFZz4n9YWSVULVEw1Vk7UW4bxuXJ2XFPuy179wpDhwk=;
        b=XMWUlcQQ7I0MH4JC1Bcgqb3IQD+/cRUJgDwlRyE9tlyyt0u2ul/EDzpYsnMGqFjiXi
         58WeiSMQHU73w46tYGPJWzT2acEgc6YQAPcVqzDTt5k3Jjs+tMJ8cEa4ZuxwZn/2LJ6t
         5VawFz9eJerO6A34aFyksFHfTulfCsGLYduQx/rP84/cD2u4dx7w3LuWOCJGdy8lGqbZ
         +B8LYi6RwgzZm9qjAp0BV+K4uFSVUtUFJcCoiYwE7F0UYBvfxGMVdGR6uZNWW+tbyoxq
         Vx9d/sv6hGVX1T3M2TqofZxCeFyOrKWLFKePkL2lf2gbz2XFEIRtgFVG54w9zbKtdPx3
         LY6A==
X-Forwarded-Encrypted: i=1; AKwUvBwO20fYxf5A0Hoi1gdaUtwfKbe4knfw+zOssxR5Xl/67s1Nu/LChKctz13FvgTzB2wsHPYJk2E4pSe+U4E=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYIFILv7I3KPKY/mL6opKGYKUeUcrMkq2/H0fQOHXlAW3Jm9doOu
	RFoFnryPV2Rs7PWvjkxsP9MEhS83d/x69378sX4YLZNz8CRHju83I+KZ
X-Gm-Gg: AYBFou3xuHMvOtkEkgXrFJqVl9tC92CPMAEXqiXKCwXci+k49PNyte9du4Cyr9Qrxa/
	Aaflclo1LgRHHk1XrvXON5JfwgrnFutim+XfJ6lz9erZvjlAD1pYBVYURgTNO0MKNIECdYQlxH/
	1zGhXuSBLW3BjEahrdBv5++TwwyNkqjEL66OyJTVIzc1kRrc5zJoscDaXMmWs22/OpcT8eyxfKL
	Z+mvoSf58Itar++6hkar4QBO+0KZthgtpvccduf3ZGdCOM7qEdTsQveU4A5fg4HF2HtCKnrtz5k
	Kou6hbPnAg1C1i4S1hxWYRUYJ6DLXxPUuiSOC4qMdND9akiR5ytJ9sK/xs2K3ZEdCzS0tZyMY+F
	t4pYa6dX6SMk0NN2lkWbq+g+3wo0TKEW1wiyELs2j+C6KO/0vBP99BdqwZi0VEiK+xsgMqWR48Y
	JLVwSktb1KIbzHFhlzHyR+c0euS59y/niGhI2ocGGTF16jNUBrIrpQirUgV0p2Fw/k9B1pBd6fA
	E8YUWaqVjHjtHasNdq8wkuu/KNer2aze+9AFkSuKc0iTFRNiSf1wUqtkacNRXy91sqgEa++sWwN
	ssjtBHqdcQQ2ow==
X-Received: by 2002:a17:902:ebca:b0:2e9:401f:f0f4 with SMTP id d9443c01a7336-2e9401ffb38mr56691775ad.16.1792123885664;
        Thu, 15 Oct 2026 21:11:25 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8ab443sm3815785ad.65.2026.10.15.21.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:11:25 -0700 (PDT)
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
Subject: [PATCH 06/11] ASoC: intel: atom: Explain DAI startup return value handling
Date: Fri, 16 Oct 2026 11:09:41 +0700
Message-ID: <20261016040946.521195-7-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016040946.521195-1-phucduc.bui@gmail.com>
References: <20261016040946.521195-1-phucduc.bui@gmail.com>
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

Add a comment explaining why .startup() must return 0 on success
to ensure proper rollback handling and prevent future changes
from reintroducing the issue.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index db1fb3b26909..58681e007abf 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -341,6 +341,11 @@ static int sst_media_open(struct snd_pcm_substream *substream,
 
 	stream = NULL;
 
+	/*
+	 * ASoC only marks the DAI as started when .startup() returns 0.
+	 * Since snd_pcm_hw_constraint_integer() may return 1, explicitly
+	 * return 0 to ensure .shutdown() is not skipped on rollback.
+	 */
 	return 0;
 }
 
-- 
2.43.0


