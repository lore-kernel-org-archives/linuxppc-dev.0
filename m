Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A3606A320
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2026 13:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CxDtlnbt
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jVfvl5k37z2xNT;
	Fri, 20 Nov 2026 00:49:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795096147;
	cv=none; b=Mx6yLP7oT4btjmUYazjQXCb9Wgf0WqwBLBgnAPz/HwpZrwrSWrYhrO9czQ0rHkkiaJDIi0WQqskO0ubkAeK/+ZoQSPe1KDDqaRDUMRIp919+zGrJTa1vqKn+ebJn8NGbE2ugcXtciOzC1dcyUWVudLbEE91iC6cH0GDHSVIb8MOA1lBZsSrU1kcflXGTgaP4SN8jlawUg/09jcFOQi4EkFPbH5Oe5d4dydlTvxbjuxblYIPOOgC5tPydAHPkfmIe/2vkXQrGk7MAyHWzeZlK2E2S1BPfQSxjNtVclyYAEaWETs7ez3a4vBdOArchXta3oVKM33wLrutQCBbcVzT8yA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795096147; c=relaxed/relaxed;
	bh=RHIJc1ZvM5IUGhVoXeitNJ89r1xtXyRqYi3xvQXKSls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TAlhne7y0nqvrNwHK5nXVTBw5vQSzZxpKrHamtGbanjRGW3GfsE2zZVYvNDeCH3ceA7fDG7ZKUKrrrXrpfu49yGeUoX3XB1UcDrlaCh/QLkB+SumTRJGAEAG+lLKuX/+9EUdohfYFFybzO7QE3i0CsIbmgSsmkBURUeGeAGEhyoX5Kblh6H3D+O3D2UT+f6VeZbQxCe/sdCOxozymNa9KZch+EqcueXepMA9Cnuk5gV1LxuYG69uW6+J7sAFRACD036v/Re3IM6OJEY8rqedi5AU3kjxL7V0uoBfQmZdFWpcDNWA8LCn+ZoiTDebzkFkkgy8YGofKOsW5Ymr3raG3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CxDtlnbt; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CxDtlnbt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jVfvl0kjfz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 00:49:06 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 2CEB36129D;
	Thu, 19 Nov 2026 13:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C2D1F000C4;
	Thu, 19 Nov 2026 13:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795096143;
	bh=RHIJc1ZvM5IUGhVoXeitNJ89r1xtXyRqYi3xvQXKSls=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CxDtlnbtdf3FiIrpS01bif1eJxVD739dNZI/DLLPKAcX2/DFt4CScsFalKfdzYq5e
	 TyrN+ijXr2Xz19d6b8Ol2HKMu+c/dr9SM+bC7jd4h4zCiNaRa/0ZZfa6L9d/oTsw8H
	 9ikigWXxN3/c2Vy1uIpSCMebHfmfzpNfxON0BkWWxXq+nc9TvesCJzk2tBXSJFWk5L
	 VMe3xwrNhL7l5NuSFlHzvPwLIS8YLmx6Z/nps3YLnWLGSa18P84CYO0eNLp3DZvE07
	 6fYD2Q2lVh5ahyN3eIP9NdObvojPD2P+r2GvMtEcglhgXM0+WSNMzyDBjzAhAo7BMu
	 BWgYENtJ0Oaxw==
From: Mark Brown <broonie@kernel.org>
To: phucduc.bui@gmail.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, jonathan.downing@nautel.com, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20261118100631.26658-1-phucduc.bui@gmail.com>
References: <20261118100631.26658-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: fsl: lpc3xxx-i2s: Fix error handling and DMA
 configuration
Message-Id: <179501192655.349622.2821526031939514716.b4-ty@b4>
Date: Wed, 18 Nov 2026 14:25:26 +0000
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1425; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UtT14b3aDsCNas90DxDGlsVK8Y57ng2BypyV6PRZCHg=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+/fMRrl7HyBCzT+DPilnTpLq+neFTeisoHMuvoBfc5
 ef/rFa3o5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABMJkGH4p17w6/XxrQXvjNQM
 RCL3nJxXP1P76oaLX9c+mrT1OuvyA78ZGe5f3Gh26l923YKlh5q+eD3Zt1xiWm7ilaNpbH+LzoQ
 IsvABAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 17:06:29 +0700, phucduc.bui@gmail.com wrote:
> ASoC: fsl: lpc3xxx-i2s: Fix error handling and DMA configuration
> 
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Hi all,
> 
> This series simplifies error handling and fixes incorrect
> DMA depth macro usage.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/2] ASoC: fsl: lpc3xxx-i2s: Simplify error handling
      https://git.kernel.org/broonie/sound/c/f8b9931f96c0
[2/2] ASoC: fsl: lpc3xxx-i2s: Fix DMA depth configuration
      https://git.kernel.org/broonie/sound/c/239eb443bf6c

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


