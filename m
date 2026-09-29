Return-Path: <linuxppc-dev+bounces-28489-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA14CCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:30:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvGFD4kYmz30PJ;
	Tue, 29 Sep 2026 21:30:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790681424;
	cv=none; b=X8684YYdlajz707bwtVKMAgQz4SqnUDdh/qhIzkWaSh52oVRiw/yEK5HlGdj+umEyg/5bEI6zpdEt62u7LKi0Q6fFr/m7rskzdaBussmDVjvICuGm4vyifJlVtDsw3+AWPEWZMI12X6XuDOldGdhhoxLxgnZM4aA39PrDCp0pO9UpHrORvNIlXXjy3rsrUlR/8IyyhEsln1Zx6B2ov0RDA7hme65fqlA0WmwpaUEICbMLrJB0FOVFvLOshQxWYH31aVzmWF9hsmlj3v060RWLrsagWt8g3wv/F3ZNQXrIOIJuUNbsrLY8EgfbLmPHQCZGrcZ8rTWaP0EF6IqvH+c8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790681424; c=relaxed/relaxed;
	bh=202PceNA4mgm+8gsK0Krd58dlYSUB37NGsnHorEd2N8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AP0Y+Z7Vx+FlugeHKgaL6LfuvOdZPZ4Agsy7oiADBHKsbbyYpM6Ngc73ghkUKtPIch90quGIr70nNo7FxjyU8aVylPopQSghQLtWr4LlDdbCA8c5U7qrwE6RD0d02tQ5bqA+VNH4D6VxM4+wxP4xYCj4o69nPZgwdicRPdlqXpfc5wjqluQ1KhkhXNPn92oM5N/tSzmfdvW/WWFNYNZ0T822u0HVCKIAF/lJ7tn+6YtX5pDX/C6TEOFhARgVhwyY4mknItCTisfnbfNKwTOhi5SAx2cuX+qDNyY0xVRdk233nNJTBPHkJDSdUcyjpnGGkLkahKrfP+IdWtLaNRimQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hItW585s; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hItW585s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvGFC6DdGz2yvy
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 21:30:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 650CE60008;
	Tue, 29 Sep 2026 11:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0741F000FF;
	Tue, 29 Sep 2026 11:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790681421;
	bh=202PceNA4mgm+8gsK0Krd58dlYSUB37NGsnHorEd2N8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hItW585slob3QBS6P5xzCMG0vw8GN3aNzq2Z9nwKqB70HAFmlvYeJoHa1y7vBgRqo
	 OLtNP5J/MRh83pTwAtZ4oMw4/zd5Gi03Wq7eiu5vo9GRhmWlLx72irxw5RkiOCoZXp
	 bo1Td7MUryU94GRk+v2UHvSUJzru2IZafFaepdF/VGpf/tSzhFO5RNJ9IfmlWWVwCo
	 NR+qLbPqjj1QGzm7uMYFGAbYftl0YakmkfWN0C5Q6t4OQOsUL731uaAmGNkqR6aas0
	 3ULbHCvTT1gCCNoffSHe6LTG9JPF6iurs4u8yPdb14IgCPA3wSXmGCSQXnIwvSI12H
	 gEeZJLf4JNVYQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, shawnguo@kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, 
 nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linuxppc-dev@lists.ozlabs.org, shengjiu.wang@oss.nxp.com
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Chancel Liu <chancel.liu@gmail.com>
In-Reply-To: <20260928061727.1844167-1-shengjiu.wang@oss.nxp.com>
References: <20260928061727.1844167-1-shengjiu.wang@oss.nxp.com>
Subject: Re: [PATCH v6 4/5] ASoC: fsl_asrc: expose individual DAIs per
 conversion path
Message-Id: <179068141537.159801.4072628732064323719.b4-ty@b4>
Date: Tue, 29 Sep 2026 12:30:15 +0100
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

On Mon, 28 Sep 2026 14:17:27 +0800, shengjiu.wang@oss.nxp.com wrote:
> The i.MX ASRC hardware supports three independent conversion pairs
> (A, B, C). The driver previously registered a single DAI with generic
> stream names "ASRC-Playback" and "ASRC-Capture", which prevents
> multiple independent conversion paths from being used simultaneously.
> 
> Replace the single fsl_asrc_dai instance with an array of three DAI
> drivers to allow up to three independent conversion paths to be active
> at the same time:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[4/5] ASoC: fsl_asrc: expose individual DAIs per conversion path
      https://git.kernel.org/broonie/sound/c/6aef9cb5c797

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


