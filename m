Return-Path: <linuxppc-dev+bounces-24278-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D824C4450B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Jul 2026 00:05:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h0GfF4s5Zz30B0;
	Wed, 15 Jul 2026 10:05:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784073941;
	cv=none; b=NPfsPPbbvcsL2v/MBfDNnW6rPUMNDSUpVR7++PT+1TThkDFyEuOJzBIUNFo9G09uVW599LvYE2irboFUfcO+f+sbkw9V3icxzPdL73B/ym85/J7sLHaG8Xcn51u6MUnOT9OPG9I7iKPR56xz2fVAqh52WbC3WkQZdrvIjYJ22oDyZ8AdpOH98zzdhhNBm7qgIIp2pTIze7N9nNceTtgaQl5XAhMvIKxy0hxP7GcGnzC7lbpgYCQeH2JwIzNJb7lmSfz970+DBQ2IPxv7jkKoaBZK8lGwBaGv5qMYLHUt4JCjw4TM1WgW4O3d3nY0Z4RkByr556J++PGVdosB6uay0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784073941; c=relaxed/relaxed;
	bh=6LEb67q5/JkYZPKqcsplxK8kOatO/+OxOClDLJ4Zb/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S5I7jy4iJlzokL3E4s/hn4raU5jqRGhP3aTVOHu1aBkkegOeZrasbTdpyrLK9VUsVpVBiu733Jsd0V+h2bbmIW0ebws/J0X92z0CS3iTH2JMRJdy1DXFSQS2ZAbf3TQM4f+bMfPvoxenXPxb8C8lwpN0rlD2c3bA4nUI21ppGY8Mf0RfYRAOajeAut4QFNI2AbBU0UzNGqnF64cYR/SjFF0WS0LcHKZsd+NZaLsavKXgCVspz1UzaH/4Bomk1FrXYx2z1pGGILhtN5NN3QMiYZ4cNsE4/eSvMQOTNeG2u/ZvcZJlCGTdJ8KzQxI8Aru9H7pXyooL8f2BC1BXs1+aww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fME9jogK; dkim-atps=neutral; spf=pass (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fME9jogK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=rdunlap@infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h0GfB3Z08z2yZf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 10:05:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6LEb67q5/JkYZPKqcsplxK8kOatO/+OxOClDLJ4Zb/Y=; b=fME9jogKjb3zt4rtxtFeXVoQKY
	tvqklxgtHF+XIxR1AmO3oDOBZmmG6VtXBPeDfdLEeQ7TNzI4Y9SSqwTg+ZiMdPSS3XDVteqdLCGVO
	HQZoWjJMxmMaHUOsgGW3TkhUdltedeSVKgsWVU5CqSSt6tPNDIWNuH9VwGlrs0SWybWzAu4gt5yIg
	c60iMuh+wD6q4agDumdJrTsAgEw7szHA0K2x+yZ2uQwx+snbJ9pxACrAbzSGsLaxsMVkR8jViYRV2
	4sk5MuDCWkii9+PISt2sWmFLtGf+I/Uk6P33HHAk4SLObiGMSzZ5WSmFiQntEnXnpZqQPCli9At5H
	6CH9n/Iw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjn7w-0000000DTcu-08Si;
	Wed, 15 Jul 2026 00:05:28 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-sound@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	patches@opensource.cirrus.com,
	Srinivas Kandagatla <srini@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 00/14 v2] ASoC: clean up kernel-doc warnings
Date: Tue, 14 Jul 2026 17:05:11 -0700
Message-ID: <20260715000525.739874-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.55.0
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

Clean up a bunch of kernel-doc warnings in the ASoC code.

v2: add Mark and Liam to the cover letter email

[PATCH 01/14 v2] ASoC: codecs: NeoFidelity: repair the kernel-doc format
[PATCH 02/14 v2] ASoC: fsl_asrc_common: fix all kernel-doc warnings
[PATCH 03/14 v2] ASoC: fsl_asrc: avoid kernel-doc warnings
[PATCH 04/14 v2] ASoC: fsl-dma: fix all kernel-doc warnings
[PATCH 05/14 v2] ASoC: fsl_easrc: use struct keyword on structs
[PATCH 06/14 v2] ASoC: fsl: mpc5200_dma: use the struct keyword for kernel-doc comments
[PATCH 07/14 v2] ASoC: fsl: mpc5200_psc_i2s: avoid kernel-doc warnings
[PATCH 08/14 v2] ASoC: fsl: p1022_ds: repair kernel-doc short descriptions
[PATCH 09/14 v2] ASoC: uniphier: don't use "/**" for non-kernel-doc comment
[PATCH 10/14 v2] ASoC: SDCA: correct enum names and add a missing struct field
[PATCH 11/14 v2] ASoC: soc-acpi: fix all kernel-doc warnings
[PATCH 12/14 v2] ASoC: Intel: Skylake: convert SKL_TKNS to kernel-doc format
[PATCH 13/14 v2] ASoC: qcom: audioreach: use C-style "/*" comment
[PATCH 14/14 v2] ASoC: wm8904: don't use "/**" for non-kernel-doc comments

 include/sound/sdca_function.h       |    6 
 include/sound/soc-acpi.h            |   23 +--
 include/sound/wm8904.h              |    4 
 include/uapi/sound/snd_ar_tokens.h  |    2 
 include/uapi/sound/snd_sst_tokens.h |  165 +++++++++++++-------------
 sound/soc/codecs/ntpfw.h            |   11 -
 sound/soc/fsl/fsl_asrc.h            |    6 
 sound/soc/fsl/fsl_asrc_common.h     |    8 -
 sound/soc/fsl/fsl_dma.h             |    4 
 sound/soc/fsl/fsl_easrc.h           |    4 
 sound/soc/fsl/mpc5200_dma.h         |    4 
 sound/soc/fsl/mpc5200_psc_i2s.c     |    8 +
 sound/soc/fsl/p1022_ds.c            |    4 
 sound/soc/uniphier/aio.h            |    2 
 14 files changed, 136 insertions(+), 115 deletions(-)

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: patches@opensource.cirrus.com
Cc: Srinivas Kandagatla <srini@kernel.org>
Cc: linux-arm-msm@vger.kernel.org

