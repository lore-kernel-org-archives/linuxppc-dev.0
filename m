Return-Path: <linuxppc-dev+bounces-25013-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CEDC54F51
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jul 2026 13:32:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9CtH0qrWz2xwP;
	Wed, 29 Jul 2026 23:32:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785331927;
	cv=none; b=R8N6dYJ+RqN22fOCVnbQA5PjBV1vllKEh/HtN34cBH4lKX7wUgu3VxiLFCQwDOX/5QOsa39nxgKdEv1lMk+x+xUT0VGjt3hQ5zLrgNaYmBskb1QcllP6e5mE+iaz0uRttgLsVGnL0jlAXtin/lHncNA1mHQbLXynURz6qToI9RSz3VjzBo4bQ/k3E8JO7nxiSyfWZUjrApNcm82IgN1Vbnb6GRMyBKnPLkK8tj/Nitzpieep1l8IVs66bE5VfrTYXt1szNSFJFdaoWKo2nPLfM02NfjsE25J5bAqC4eDpaUTkVenmYAQjwrrUHDAm4rkqv4rfSUzudcTOAEPHigh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785331927; c=relaxed/relaxed;
	bh=yyFIEb9z3mB2PIPDau5MQ7dpD90tXnalh+HmIBwM0Nk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fR1HjC1pviQ8LP1uDuV0vEGRo9wGVypNFKC1GBU9Ssf+1+pjRDIHux2P8GqGzVhdBwPqFLLLXnpbrLB4pgrQRAvebBtRTJk2CaEPwlJTwBLW60SRcXKd722oEpKWp1PStXsqWy2MMrxkAy9GolT//8iWxGhF8PxDM9NND0WqzAbymaIx5Qy0fdR01ysNTJQTfjezswPkhCS/mqIR1EH3y+TzRWQWbqARvLqLlRwZeyt1LyH3cz+2CKwhljZ01tgBfNFVTSA1rT2QEF/7qaNLVsU7Gf2dkcu2V4nS+gV92vCiGhazgtHpj664oCfUPC6ytQ5156hzmSw5M8avHF/YWg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhSnNi23; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QhSnNi23;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9CtF6YsJz2xnp
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2026 23:32:05 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7C97540460;
	Wed, 29 Jul 2026 13:32:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928501F000E9;
	Wed, 29 Jul 2026 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785331923;
	bh=yyFIEb9z3mB2PIPDau5MQ7dpD90tXnalh+HmIBwM0Nk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QhSnNi23aTMVPnBHd3PPmBrhLSc19heT9KYS0ZHTsC3ONVxgLBei98oe3pPj2dRHq
	 2WVqe8B2JnPib4yRNsudUB/8/Wpekohz78IYCFU5vCylzyxT7VOsiWrQeBr3XHbovi
	 xmfJUb/j8ai29LfxDihIR4MoVqA2XcfJc7OCImcuGqbA8/egFgOL13ap6IyeDuS7Sz
	 cHquFS6CTfKI3TD0LHARonOrS9MT22QkmDkBaf9iUm+L/spe7XGNIguuQZ77w4EP/P
	 HJf6wFNOEAw+GLcx5oYeEGYxOVt8roPGXi8bNGds3D9iCxAPb7rWaFsYysVWAqrXJL
	 LkDjMjAvfO6oA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 Aaron Ma <aaron.ma@canonical.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
 Hasun Park <hasunpark@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Kees Cook <kees@kernel.org>, Cezary Rojewski <cezary.rojewski@intel.com>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 James Ogletree <jogletre@opensource.cirrus.com>, 
 Fred Treven <fred.treven@cirrus.com>, Ben Bright <ben.bright@cirrus.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Mac Chiang <mac.chiang@intel.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 patches@opensource.cirrus.com, Lars-Peter Clausen <lars@metafoo.de>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 =?utf-8?q?Amadeusz_S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>, 
 linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev
In-Reply-To: <cover.1784528081.git.u.kleine-koenig@baylibre.com>
References: <cover.1784528081.git.u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 0/6] ASoC: Use named initializers for
 platform_device_id arrays
Message-Id: <178519395804.552178.14635881416240705752.b4-ty@b4>
Date: Tue, 28 Jul 2026 00:12:38 +0100
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=broonie@kernel.org;
 h=from:subject:message-id; bh=U0oMIU8K8WmgeLPAyFV6bjpgnTi8C1w/LC1AdtgPXpw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqagDJWXeDjd5kHwd16ukfCKKPN0qkrdOoGH0my
 SlAtyFDD2+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCamoAyQAKCRAk1otyXVSH
 0CfkB/9FMb5uul97pj4GpuHcasO2XkfONSN4R0UJo6cou6C2FFmI8xWge1nLM+AqKOSumscn/Vn
 Au2qfeSLhjcaKupnNJ75pHeM0y38rT7suCWzSLpXeQnFml/R5whX5H9mHp2V4htcPgRK1YFNak6
 wYmqDa9+JWv+I97lnNIDba0EcUOfHzKtw5fpjvstHtZISkKTTX7rMRnUdgwAV3YPUaVH49Y7G/8
 RKad+Se7bFLSn4vl1oXqboKS4pbWXZ8Vg1YSEOgTHEAAmX5tB49vzlkmGF83RwZrRldfTrzGkdS
 rGzce5naN625a9ZxpW5A+2jRZ+WX6wGhL19C6+xi8sgQLUGN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 20 Jul 2026 08:23:44 +0200, Uwe Kleine-König (The Capable Hub) wrote:
> ASoC: Use named initializers for platform_device_id arrays
> 
> Hello,
> 
> the objective of this series is still to prepare making struct
> platform_device_id::driver_data an anonymous union. See
> https://lore.kernel.org/all/cover.1780048925.git.u.kleine-koenig@baylibre.com/
> for the details about that.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/6] ASoC: codecs: mt6357: Drop unused assignment of platform_device_id driver data
      https://git.kernel.org/broonie/sound/c/c7a6909de856
[2/6] ASoC: renesas: fsi: Drop platform probing metadata
      https://git.kernel.org/broonie/sound/c/0ca8f65516a9
[3/6] ASoC: amd: acp: Use named initializers for platform_device_id arrays
      https://git.kernel.org/broonie/sound/c/2b26d06fd3d8
[4/6] ASoC: amd: acp: Unify code style for platform_device_id array
      https://git.kernel.org/broonie/sound/c/4bed1074db1e
[5/6] ASoC: Use named initializers for platform_device_id arrays
      https://git.kernel.org/broonie/sound/c/232725a0e386
[6/6] ASOC: Unify code style for platform_device_id arrays
      https://git.kernel.org/broonie/sound/c/e4dc03df1f71

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


