Return-Path: <linuxppc-dev+bounces-16338-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C717D35668
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Jan 2026 03:02:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f16Wc26K3z2xT6;
	Wed, 28 Jan 2026 14:02:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769569340;
	cv=none; b=PHrsZ8NxecC+SWoF4oE6qPjArAOq7M1/lIk58KcB0sq64ZHg73+u34f7o2CLsSSkuyQLfMuTnMKokcYARntj/+iurI9FyipyJSafrfg7s92VtII/r6iJKaUPfsghIUyQevmnNFjiupgelkh3dOfvvy2u+zOdNGP2mS1S4yIsRvVhawJhRpfCNVIW3CzioXch0OaOo3+Cct13d7QruR+mrI/NdoZEtR6SlCk5lXeMSMPsAqRwaAIanRjRfdiPKiChxc8xUWser5P7wh7JJnmNTHdKNFxPvHrQ00o54XVFgwfAjfWEye3DiIGBJtC2SmG7PHojuTVQ15p6EQ2Vt5WdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769569340; c=relaxed/relaxed;
	bh=11LjQZs7Jg6KN/lPD+EdYnoLZC1e/r9eYLPs7UXOZ/0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f90bd6XKPYvastKLguKX12djCCwRmr1Q+H5spLfL9rG26pA7DYVdMxynpTUGNQorJe9wQSVYp0Lu6bcsnhBIzxcbSjnatTok5MKCYh9wUZiz1H9Qi3YHQUTlnNbMMuMMu7Pa4kHWhHDxz3487mHxSmrGPFqRIayjrfNcd+j7IIxg5EDnsh4J20nrp7aEY7D3IDq/ITXYmSlq6MjSMGsLWBvRvKVB9xSZxrC1Sz6Kn2SFGmDdENt1EBSPTorQ/G8EMtJE9K/SJebIT20krIwffehQc9PwbA1zz3SRxjfFmN/P212pOfoPycjMfF2k71KT7MNEoGBUlYwZmx3JM1hkTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SEK4aTxJ; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SEK4aTxJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f16Wb2h6Bz2xHt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2026 14:02:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8B7EA60007;
	Wed, 28 Jan 2026 03:02:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E8DC116C6;
	Wed, 28 Jan 2026 03:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769569336;
	bh=i0/csCwZU0v5d+zAzQkM4cSs7zUQWkjnC/H7rL+YtSo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=SEK4aTxJAdkH8SyjzWKmABDtsz0stSBCdthsCALme8UvCk/GoSLBvbL36/0OFY1dU
	 RF/5q8H70kJBqVapBYJ7W6K4kzPqh2c9TnMd3/EIChExsfU5V4bG5y4AxjrFAqv+W8
	 rIs+e8fVIThjD6m2A2PoTynujyeBIxbICAuzPb/RgME48DfnObUMUOw7woHea9N4++
	 1fc5IT1HkRh9jZom0LP3uUDWp5DzepIX0FhMFZSwT2qvVmsKrLlP6i9A5Rxkv/ae5F
	 0iDTGj7ISTgeaCuguRFJgz/WLZNNYImV/p9Pl2C+WX8z7lOhCn8B2M2PFJTaXXiEFy
	 qjBMQbcj835nw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, devicetree@vger.kernel.org, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, kernel@pengutronix.de, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260123082501.4050296-1-shengjiu.wang@nxp.com>
References: <20260123082501.4050296-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 0/4] ASoC: fsl_audmix: Support the i.MX952 platform
Message-Id: <176956933264.1515833.4946244987105746224.b4-ty@kernel.org>
Date: Wed, 28 Jan 2026 03:02:12 +0000
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
X-Mailer: b4 0.15-dev-47773

On Fri, 23 Jan 2026 16:24:57 +0800, Shengjiu Wang wrote:
> Enable AUDMIX on i.MX952 platform, update dt binding document and
> driver.
> 
> SAI is connected to AUDMIX, and the AUDMIX can be bypassed, so
> add 'fsl,sai-amix-mode' property in SAI binding document for this
> case.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: fsl,audmix: Add support for i.MX952 platform
      commit: 7550d6263b9b2015a806f66bf7ad356b6f25d050
[2/4] ASoC: dt-bindings: fsl,sai: Add AUDMIX mode support on i.MX952
      commit: 4d3b56b8a3504dab98d5f9a91ed9091431749863
[3/4] ASoC: fsl_audmix: Add support for i.MX952 platform
      commit: 291f2f908823832e932582500816ad614631d568
[4/4] ASoC: fsl_sai: Add AUDMIX mode support on i.MX952
      commit: 19b08fd23b20593ebe43708308dbddb02507877d

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


