Return-Path: <linuxppc-dev+bounces-18277-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77000F013FA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Mar 2026 21:52:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZTNJ6p9lz2xb3;
	Tue, 17 Mar 2026 08:52:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773697968;
	cv=none; b=Xd7Q+aRGks+oYYuyi4sIT/b85D9g5twSU2WQ21CPcbS0BVHXQbogd8fItOEpnaC9le7PTRYXNTx5ZGJfley0a8x+wuga+VyjHMQJ3SqBSAGEImFDwSVbFNPz6e+hMVqi99oQVO/4L8n89fOtaavZioKxH4u+qKkT5zwcVcNPblCjmmeEvIjIJEFRdDD42oHUdBf0rBV5FxjvPMFOtveI6uLrxX7kZ95t2g8nmbLnh8bQfADvOz/MJi6t4+ntCywDQ3jV471XXT1XeM/AabDyWpy250Bx2IUFgbyqRKmqAH33JEdRzikOu8TXqlU9zfz2WKpOV1D6yMvohQxpgLfs9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773697968; c=relaxed/relaxed;
	bh=NLYWWyxBpliLX/WbFT9s4qr1UYD1s1as3mcfLNUZKAI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VgchvVbwIgC3Sr4dvy4X6YDO3ZFl5al1I7Jf3hGUCXE91ea285ZO/Mly29mMs7o0KFbQZJXMhhDCPjM7QjgtLcLiEJvJIZY4SDj0bh9lLeV2uSK+4Tqvo5W/0TlRb/kRDVHsASwNyEaaPJu9BnOGUcR4ys8Nmhlhz2K2TDbKAUYSuGL/lQxIFt+/CUuTFu9vEuYqwltGfKei7vYi0uygwFEKwaTBZL2nwuFm0dESugKDYomKunvlu0aPOru/j9Lx/QJMtqsXN5L+l8rau4XLnpd6jZeUjbfWA0cex0r3gSefGXnjrNh+Q/6s0O0JbAf8PeEdIdqFVO1iMpzIdy2drg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P5xteh2K; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P5xteh2K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZTNH6n6Lz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 08:52:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0DF8D60097;
	Mon, 16 Mar 2026 21:52:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0951C2BC9E;
	Mon, 16 Mar 2026 21:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773697964;
	bh=Hf3ptVHHm6wjAGUPr/MchsVO9sY2kg6t6o9OKhcopA0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=P5xteh2KfFnfpDcZfj3kgNrmoW9Ve8Oc6bzdVqC0v/fx5E9qSGs0g0gnNYnYsj8ti
	 OePtFlFJGA+d/1hMBOCO4sXs8BTy3LIIPpeavpNwjd0ciilE1Ui5nUTSowKmBa3TMY
	 JhHgiKX8/Iju7HEORujpuCTjQnD/uVM80qH07uCroIGGxNVVsqV+805vHzyRavYM4C
	 pHOQT9d0x/Ds2A3t8pGpmqC0smcUcYS3LDK5yXyNqwkU8SIMAeT5NghdI2qj1Y+xRT
	 Vh66JAo+8bLyhJrd6AtCwhmFXXFQBR9FK55PTjCBTZ9vDMIdjZECYf4gOrsWW7LQTn
	 YRvbd5C2jbJDw==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, linux-sound@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260316180545.144032-1-joseph.salisbury@oracle.com>
References: <20260316180545.144032-1-joseph.salisbury@oracle.com>
Subject: Re: [PATCH] ASoC: fsl_easrc: fix comment typo
Message-Id: <177369796246.303411.7440078882832498896.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 21:52:42 +0000
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
X-Mailer: b4 0.15-dev-f420f

On Mon, 16 Mar 2026 14:05:45 -0400, Joseph Salisbury wrote:
> The file contains a spelling error in a source comment (funciton).
> 
> Typos in comments reduce readability and make text searches less reliable
> for developers and maintainers.
> 
> Replace 'funciton' with 'function' in the affected comment. This is a
> comment-only cleanup and does not change behavior.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_easrc: fix comment typo
      https://git.kernel.org/broonie/misc/c/804dce6c73fd

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


