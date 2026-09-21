Return-Path: <linuxppc-dev+bounces-27858-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB7EC982E6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Sep 2026 14:55:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpRB32l6dz2yfH;
	Tue, 22 Sep 2026 00:55:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790002555;
	cv=none; b=CeHGAlu3WBaZSwx6nVAeqE/kcPfE+FYkLFxOXD4Alg2YAsvWC4PesDUcENvkOtIPFKx6rdXlEIdYlfWGQ0IAUx0a8odUF7KvEf5lHXyAFyDzyaddlaoGuGHCUynbK+XmaHs69UMNqif29XiJjpr4uZlaBoCE+tVqb+5xPu0kNKr73OznnOPLUBlA1qE2UMyv9WrPDAzeuK3+/CrFwPstwFdWeEEQdQHV+E7RGMmbsYB5KfxHfC1cl036XCprt2l2J/p3+MTeqse76VrCwRlyvg1UgHyIzFanP2Si66adPqXcC1799aDI7dFfoR7WZfrDLCSNLacpGdXxRsYgUzy8tw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790002555; c=relaxed/relaxed;
	bh=v1GjqGQQoxt79os+ov4EVe4KIwj5vEx0J7/3S3AOIks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LammZ0XtfDt0olNwnVpY+5l56F2Xg3DdzT2QBk/AZfKLTOzfX9wQQB316DoGKIF4htjhnk+ifnot0KGzfWUtGVS+VM7vDgIJzL8GID+dJaBVF5ePoN3zwqY+NXRoI6UUyOTo9ytU+BItICxfG1v4SF62G0/70iC3uldk/qI09FBuGsC0DqgU8eGgsuiNGNomd72lNqXPK3W0qIoJcTcfxtXpXeWiTMpogeWN6pFWPy89dVvCKL8y6V3++OLINnIlTTU3vKNmghZZVGXkDViq0UPSlMPP/6O7nc/AugCAkEEFCvNTN2e9gmsRpu+xhKLBw7vdQ5RsclzSaJD2JV0iXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIMGOq8b; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIMGOq8b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpRB16Dkvz2yVd
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 00:55:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3EC0A600C8;
	Mon, 21 Sep 2026 14:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042A31F000FF;
	Mon, 21 Sep 2026 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790002550;
	bh=v1GjqGQQoxt79os+ov4EVe4KIwj5vEx0J7/3S3AOIks=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IIMGOq8bqQn3iyvrYAg8YT4v4PABW/DOZeC9v0TZbj/Q1hCAM1YTsPaH2pdUEZurl
	 zGP7058SF5MhERAr3+JV22GbPZea09coCO0vGHg2n0ryE5qLyGU25gLI9+wKQp1jtl
	 RkAxddj8QBjH+xGOS2UX4sRlD/ffq6t1ZeoHDfQlMyYMO31yLuGZP1IIJ5RWMrf5tB
	 QkX6F+SZ4TCs4UCGHU8RcheXYc9mTjkXUOW0yUqxcac/cxJ0BwDDLSGKcyhSbI8WGn
	 nvxWJ1qqpLuZtC/OfBkkmD2opIfyTCK9WiUX7nwb7I97zHPEYk8rcOW6EyBKTyD/Bk
	 XtoMaomLfeHgA==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, bui duc phuc <phucduc.bui@gmail.com>, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dave Penkler <dpenkler@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Frank Li <Frank.Li@kernel.org>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
 Robert Jarzmik <robert.jarzmik@free.fr>, 
 Lars-Peter Clausen <lars@metafoo.de>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
In-Reply-To: <20260918113727.1898998-1-andriy.shevchenko@linux.intel.com>
References: <20260918113727.1898998-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 0/7] ASoC et alia: Convert to use dma_request_chan()
Message-Id: <178999208921.228132.383663695123110596.b4-ty@b4>
Date: Mon, 21 Sep 2026 14:01:29 +0200
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; i=broonie@kernel.org;
 h=from:subject:message-id; bh=kSFqLXrCqtYramPo5FETtrEaxmX5mPIc5IINEnzZwmQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqsUVsIh4aMtMKW5FL3/10LMQXsAUka312rSZ1c
 X/NDKHexryJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarFFbAAKCRAk1otyXVSH
 0Nt6B/4ybTg2hVjgxuwO8esnP4BKkcHlg5MfVJu2ojE9IxQLwji7gZzm2RAFiydXjt5y/Ww/Bfo
 ttJHw4aqglMKs/76apulh5YhX5sXEw65LRWXn5h2imWZTNfsdAJdl1An7x1j5FD/EShJ9KQI/Qz
 TEqAK0SrEu32jg2mrsZWuR5ajDHwvvAlplqHnHi0tbD8250AB5gN00bZwn3F6vyzZ9C97qAhW55
 MOGL1mfEPX/XVyD+2tj7+Lc1cp/jOQyurldcWRLgG56zifJpb9hPJV42AA7eZbEyWkHkE1Poxis
 s0wpfOs0+4wgg7UPmZLPFyrI6/cAyOv4p/UG07x6JNVbA7uK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 18 Sep 2026 13:34:04 +0200, Andy Shevchenko wrote:
> ASoC et alia: Convert to use dma_request_chan()
> 
> Convert the last users (mostly in ASoC) to use dma_request_chan() and
> drop deprecated dma_request_slave_channel() completely.
> 
> I think the best is to allow Mark to take the whole lot and provide an
> immutable tag or branch to others (DMAengine and GPIB).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/7] ASoC: stm32: spdifrx: Drop mention of the deprecated and unused call
      https://git.kernel.org/broonie/sound/c/a389c4dd55d5
[2/7] ASoC: sprd: Replace dma_request_slave_channel() by dma_request_chan()
      https://git.kernel.org/broonie/sound/c/08d77e31df21
[3/7] ASoC: soc-generic-dmaengine-pcm: Replace dma_request_slave_channel() by dma_request_chan()
      https://git.kernel.org/broonie/sound/c/77593bbdb8aa
[4/7] ASoC: pxa: Replace dma_request_slave_channel() by dma_request_chan()
      https://git.kernel.org/broonie/sound/c/ca11bc272ab4
[5/7] ASoC: fsl_asrc: Replace dma_request_slave_channel() by dma_request_chan()
      https://git.kernel.org/broonie/sound/c/b045248399d0
[6/7] gpib: fmh_gpib: Replace dma_request_slave_channel() by dma_request_chan()
      https://git.kernel.org/broonie/sound/c/4f846b8b69fd
[7/7] dmaengine: Remove deprecated dma_request_slave_channel()
      https://git.kernel.org/broonie/sound/c/ae710b66c715

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


