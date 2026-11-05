Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD64606D83F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlzrjAG6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL0vk4LJ9z2y8F;
	Thu, 05 Nov 2026 22:49:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793879346;
	cv=none; b=YiUWaH8tYzWJN6jggzBAmD5x5c481cbloHw+rFswSVbzE6rJ6K1B8F4kwLoMZpH4rhGVQa5UPCzQFQEGsJ0WOpz32z9rA4cLcRy32GMptUxNQ+5+j66XQrckt0FUJsH5MunE1TZEb9VRoGDgY/BEeJ0naI+wNa8vUZeZA38KHq6Fp0pIG6ycJPWjRbxWoaDga9rJtvJ8vtLAcrSEIcV9x8rKQoMUSSHSKpqbrHVJ1woBfv3LpUpJhe6eYDoarRNWGJiETudhUPz1hSQ5+8rSp8NMzl/i3SWtSE5IANLoO6aZajtMAuMfYrCRO/koVJ79vV33deulGlLrZ6cvyugeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793879346; c=relaxed/relaxed;
	bh=uaayokCbVv4A1cXEEvxZH+uDqBX0dAowaGyg2mb9XGE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KDzwrSHjDMSavkyE+cnk/GJycUQ9si1RJvRxMxKuC1qbekKyairalUQnF2HuGaK/s977jsJ5NjYfyIwOV7ri5dGELPh0OVEJ1pP2qMqqo3ZNR4fWP8s/AfV2al6xu68fNbgxFV2dzzXrfdWrzJ58IcHXc1odouypLywql7FxFooXTuJr1CL1WPGk0x2V/3z2R/mfJ6IMRJHOuEilZYwbFiDOyXZsxi2dHJlvazwlJPzloh5Ul9CDIalM7hMfRHAe9mN8ggIzjN3xUaG/Na8HGoSTdrcUTtrSNwok9pJu9kIjcbnOpxqE89IcL21qu1n2eTlx8HIDHQ/bn9mNJdFwKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlzrjAG6; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VlzrjAG6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL0vj726Nz2xyh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 22:49:05 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DCFCF41B1C;
	Thu,  5 Nov 2026 11:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DD61F00919;
	Thu,  5 Nov 2026 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879342;
	bh=uaayokCbVv4A1cXEEvxZH+uDqBX0dAowaGyg2mb9XGE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VlzrjAG6sSMU6/B47taid7cNtATcwGb/YZBNLb0kTEkIovnLvfxXJZ5AaFkpyQAWR
	 ERalTfZ7mReUasMFW32jlz8YwIh4pLflfSXW9g2QmhqoLtn9cUnvSX3Vx+NYy0/qsN
	 jwXijCNswfFXXAy7UA3K3HlC2dMXrHTXiJUii+IIqR7rn/QEVcE+EnxyQKUtYnUxCd
	 ADYMeWP4s+/BxFUEmy3y2cJog62v4I2dVnEhLXHIcpToQihMLSXs1A752aZ681njzv
	 OY/B9S7IFjn5xOGebzsDV9Phw+jw4fdS59ZL3ueglFJtyVDRgqFownDiEeKJ5750Zc
	 IHzEnFgOIgVGg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id E4842272EB49;
	Thu, 05 Nov 2026 11:49:00 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261104113228.1634005-1-peng.fan@oss.nxp.com>
References: <20261104113228.1634005-1-peng.fan@oss.nxp.com>
Subject: Re: [PATCH] ASoC: imx-audmux: Convert to subsys_platform_driver()
Message-Id: <179384086702.2186205.11117953235004783694.b4-ty@b4>
Date: Thu, 05 Nov 2026 01:07:47 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dsgrxpy2KP6cvgFm7+hbIpNnopwMFJSlB/+wS/jcktA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLe5OqEc28Rqo8MWMv8aadtytRZQvO/HDeev/z8jnn3z
 hW9byid0FHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJcDQx/FMMedHTplIk+11d
 Sycw7LCUhuT0Wu/v4u5ZD17plMzfyc7wT7/S+ehC2XM6DD4T1jpU+zt3fnJ82/T7rM0zkR/htzp
 k+QE=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 19:32:28 +0800, Peng Fan (OSS) wrote:
> ASoC: imx-audmux: Convert to subsys_platform_driver()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: imx-audmux: Convert to subsys_platform_driver()
      https://git.kernel.org/broonie/sound/c/aa56acd47629

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


