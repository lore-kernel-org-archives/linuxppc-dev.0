Return-Path: <linuxppc-dev+bounces-6466-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBE4C021BB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2025 13:39:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2Jbk4k6pz30Vq;
	Wed, 26 Feb 2025 00:38:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740490738;
	cv=none; b=AUuovWt32zLoHSmiQx/ApFD1vC46783ptLCvPY+lKBoN6elk+/9b8qdjVSBJVKtwogcZ91CbspD9uHsH4e2LnrnDnMlZw2gBYWdN8eM8DI7xm4FmPX1J6G53EB9+2yYFsDHJ7PN7UEiqikTjCv9UcMp62U/kPhSNz4REZkg4G8tWZhCauJ28FHLCZOJ21vZYgC7fICylWO8cIwN6Bdi52JaMpJeyo1WqIHYH1xaiWm8fgCYTvxbUEnSiz53G/cX9yJIbG++2ElRjv+6WqTCDGxgIpt4kbAdZrdEIM8hHyUqKKHlsm7GuYG6P0RRAb0m8OlbdixbrrXTbomBrOYWRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740490738; c=relaxed/relaxed;
	bh=yggVenFpBagb/lG9e4fp/x+vcE0JF4JOtXXaLNdwj/Y=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=owVM5WgMFwL2IY6i0TI/ni02drBbgZgSfzSDUSBs1Hzz6XgTNJsuzbhvKZpFMKDYgnLcEENdSmdqKS/1sH/+rZpmLr+l+xrwW5NO7V0bcuqRBMICr8qD8ugwecxFZpMJfNm+aYPRD6HUyhhrF86wQYbzVVdjpIi8zUj27Vd+C6X0P3FLHu1HkO42KJ2UX+YHfAq4JetBz4O9riRs8fodSgzY7Zb9Syxx4/qrGsjhxTV2X2/NInba4jtUhsFJN1nKFUAyhZ/4NU7SGWTSTXSRUSZGd1+E+y6sK5MvJLSy0FV0eeXf3c6nSJPUCPTCwHyoOgBwC88DEsZkZfo8dkY8lQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AuVH1J1i; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AuVH1J1i;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2Jbk0Slmz2y8W
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2025 00:38:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4A7545C1036;
	Tue, 25 Feb 2025 13:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFBDC4CEEA;
	Tue, 25 Feb 2025 13:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740490735;
	bh=w7BtHlDsE/wNj/6FsWMNUTOpXSl/xAGx5czTS7gbsro=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=AuVH1J1i9uyNpC5b4VeLzwaHmMLldiBmSCC+XM4hylJmAvWmBRRxMG/rZdTTy1mFo
	 pjQQteuXqSRlEL+q4WaijfPkoSOmsVTMjZfGh/keTQ+rG3M95RIDCTd2mpsr1HyqWN
	 FpUpMYqcJ1RflInsQvQIQdFLmwEhgHlWr3algs8xZzUOWyy/RNDVUbw82fZtwzMFci
	 l1UaRLq9tjSm7m4XzZE25WzL6jtlUf7Xcq2KgA5dHRRmltm+tpLbhcxYO0MWFx78MU
	 qT2pEbjXbhRJFKwnPZ7YgBYINfqizVk8XYQuyMDAleCxcUHbvImltKmuYWXb42CVqs
	 tFtP2v1jzEabA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, Chancel Liu <chancel.liu@nxp.com>
In-Reply-To: <20250217010437.258621-1-chancel.liu@nxp.com>
References: <20250217010437.258621-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v3] ASoC: fsl: Rename stream name of SAI DAI driver
Message-Id: <174049073341.42497.16361417560871466113.b4-ty@kernel.org>
Date: Tue, 25 Feb 2025 13:38:53 +0000
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 17 Feb 2025 10:04:37 +0900, Chancel Liu wrote:
> If stream names of DAI driver are duplicated there'll be warnings when
> machine driver tries to add widgets on a route:
> 
> [    8.831335] fsl-asoc-card sound-wm8960: ASoC: sink widget CPU-Playback overwritten
> [    8.839917] fsl-asoc-card sound-wm8960: ASoC: source widget CPU-Capture overwritten
> 
> Use different stream names to avoid such warnings.
> DAI names in AUDMIX are also updated accordingly.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl: Rename stream name of SAI DAI driver
      commit: 0da83ab025bc45e9742e87c2cce19bff423377c8

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


