Return-Path: <linuxppc-dev+bounces-16713-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B07EF06EC
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Feb 2026 21:21:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f8LP14v1Pz2xKh;
	Mon, 09 Feb 2026 08:21:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770585701;
	cv=none; b=E9mb1hXKtaHAzXg0w9U6zV77umnQXNprVEPt17Nl37UY7O7AXS6yqTAAIDl5tBGIUk7LthVGUpBv52S1Cvtz4hcBGLe/4iT3K4Ug9ULjC9rrGYgXplyyHHI5LSm0ZydnjiRS0pTZfAlrErwi28muFz4ay2roK97F/++C2FAFr1gx6Fd/ay844CJLfxnPms93X1mLiVqjP4esuA5aTpvXX57Q5E70h5Dl0JHBhVlVvyaTI2VJvkcZxpOsB4j8TB0+HVpNVOM1uRfnB30DZLWB87+KRfK3NZGo1YsWaSamzvi2LLro+zEX65iMcEbvo56Ejxs6AygIeJkYv/Uo1JgQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770585701; c=relaxed/relaxed;
	bh=3BrKi9yIdPU93oR5n7QCpvPkIx8nOF7iBBagrv0ShfY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fcvusXB/XpcwT6ZOLqgLjFSkgxga4eUJCPX3UimjpY6uQyi4cx0ZqGB4B2sonwp2Ud9cdjOv+CkwmdJd8gUmRIrEnl4yNTzrVnO8EXnZBCYUq2fbm52mro9l9OE1BWnYl5xinlzVmsqpVu6YInAEjU40FQLy9XAc1Bo+8Mt2/fUlIJnt5ddIaEKuqtryU1FiWmpdfAMVH406hpbmGOisnm4ozXlqxQKKCPwxgWOG9HdX40NDIO3ude1HU+5NQF3rWKnNFKz85u9FyD4ToPmFwxN3uwelaSdpjDRj6SUqZ5wQuuDZEekYwl+cKcLg4i/gtKJzhLjuHGhlig8bOBcEpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OL0cmPMG; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OL0cmPMG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f8LP04G05z2xJF
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Feb 2026 08:21:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id DA8F4440B4;
	Sun,  8 Feb 2026 21:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A8BC4CEF7;
	Sun,  8 Feb 2026 21:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770585692;
	bh=WniId9rylPyWCg6DYb8OFQ8yG1Mf1fld/+NjW0lsf8k=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=OL0cmPMGq5hb4ML2UnBGJ7XL+Cd2QuvbF2LHCwzNxbt2D5NdVfL1HUi1K2BJFm7qe
	 FO6ErvhzO/VPNdM00QJdKkXJThRqPgNp7pgtPAQo/is0wG00tWKu3YsT/8AmKsB/1W
	 Zi1lF6Y52pNAoJeqjcGO58ozFPqmmkB78ZPpN5gF7Rm4ov7vZt63BXQhH90d9GhH+x
	 H91figU7ZpSIpGrvLTiHduM/rwS4K7YyONIs7mDupxe+jsBe89IhoDPyt9tfHYoH1B
	 st2sf9XgeYYZK0mZpaXpkvQ6oZ9d6j8K+a05oJGBzVFy/Pwc3s2M24i/5M6I0M6eHX
	 rdhZtuE3oXrrg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, nicoleotsuka@gmail.com, 
 perex@perex.cz, tiwai@suse.com, linuxppc-dev@lists.ozlabs.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260206014805.3897764-1-shengjiu.wang@nxp.com>
References: <20260206014805.3897764-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v4 0/4] ASoC: fsl_asrc: support the i.MX952 platform
Message-Id: <177058568882.654564.1085917355716546232.b4-ty@kernel.org>
Date: Sun, 08 Feb 2026 21:21:28 +0000
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

On Fri, 06 Feb 2026 09:48:01 +0800, Shengjiu Wang wrote:
> Update dt binding document and update driver to suppot ASRC on i.MX952.
> 
> Changes in v4:
> - add Reviewed-by from Daniel in patch 2/4, 3/4
> - add Reviewed-by from Frank in patch 4/4
> - update the commit message for patch 4/4
> - remove 'retry' in patch 2/4, reduce the threshold for timeout.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: dt-bindings: fsl,imx-asrc: Add support for i.MX952 platform
      commit: 37bb773b4a5a5107b92beda3447a7c6c0cfc1237
[2/4] ASoC: fsl_asrc_m2m: Add option to start ASRC before DMA device for M2M
      commit: 83447a38ba9abac52bc110566d3e117753899f69
[3/4] ASoC: fsl_asrc: Add support for i.MX952 platform
      commit: 6a8c6f5587337eceb387812b6f47bc16c125b883
[4/4] ASoC: fsl_asrc_dma: allocate memory from dma device
      commit: b010c782341b79edbeb80706360b772db908daa6

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


