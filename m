Return-Path: <linuxppc-dev+bounces-18126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCAC106ACCD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 17:34:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWvrP2XBGz3cHx;
	Fri, 13 Mar 2026 04:34:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773336885;
	cv=none; b=e9hwiqlXqZb7CSFsTiP5dOzaLEPX1xXIiHmkvaDvQr345Fc5x9++L5cn6IosGz0RGvgl4AoxOuFiDJSZbZP34LH80CyDdJCcg5ubO7sxXPZUPMNyNI2vlujmjAEtU/jRvzxhEdykv1DvKW5J058syY7IRyCXlnPWcIXBfljFHQjmBkk1erH4/rK8god6JLp0+QdUSrZr5B5ARFoBqTxYL8D26MrjD9yxldLvl60shSukVfKN4z53PMmkMiV/DljtGvxlmDQzLWgc7B8TtfwzvrPRIeU9/aGJZhZ922gz+8mqrDOYR/TZNJcyQQ7E6WPC0kAuDMKXzNSr/5zFsgukSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773336885; c=relaxed/relaxed;
	bh=LyXpclF+PVAmwl9EDzFLQtQmLgkHJcga9lO8uYj60hY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gunb3/2DH8j0ufbClaICYJMC9kDYLkBE1rlpiP6WBpc5CdgzJfZrY/DoDOHXNvO5UtVfcEI9sknnP8UObHqUCO/lsj+H2svfcBl25O61BgdS79DXBdoWRUqqwKEc34QP6CqXBl9b8FvR5CuoTtXLZUeeEUxHGN3fn/m/rzwWToIj4xBxOht50P/06M4es1xAf85/k+RGZKFR/wMfYNqGLNOXr4gJ+KpaFdUMW1DlEqS/qN3qlo+rLd7jWmJeqCTKYnBiJtB3BB9lKuiNlW722htbD0jQLNBPqR2pnjIm5BL+Ytis5koMNY37tMA7//vYDA7pJ0xBWxDebnazX77PrQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JBqmO1JV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JBqmO1JV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWvrN59cKz3cH4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 04:34:44 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 98F8761335;
	Thu, 12 Mar 2026 17:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C54C2BC86;
	Thu, 12 Mar 2026 17:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773336882;
	bh=zw3cr2qq6lr+v/dNp9FkVhjLNPzy9fxCO/01+wJ2BN0=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=JBqmO1JVA8JLh9PSlomi9mqjECeo1WXNyxh5CeQOyXTW+OuQIhaaKH1QZzEcRFXDM
	 fOyNaOZRjz7f85yKASxIp97RuHQpGXCV6jZYGyXpVctt+cBuexoaF4ylI40uJCq4K2
	 2IbWLtMpRLJ00GW2RfuRhkkgg4qW+I2CsXSwVbD7uYZErjIxEO7sE5HMFW5uzj1xcw
	 wKUHoDQ45H/SZcaL8eMnSJmL9uvvqM2Un20stylDSbtyy5Fsq9lwHTH49Vkal31ZD1
	 d4uZxU2O7HvaiLaO2PchWA4Dw9gHrRbOJYgPDO5ZifinnFYQOuX2lPD0iaK3iXe/bM
	 K44hjdE226UPA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260305031031.3808182-1-shengjiu.wang@nxp.com>
References: <20260305031031.3808182-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 0/3] ASoC: fsl: add bitcount and timestamp controls
Message-Id: <177333688010.302961.9163999310224372779.b4-ty@kernel.org>
Date: Thu, 12 Mar 2026 17:34:40 +0000
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
X-Mailer: b4 0.15-dev-68380

On Thu, 05 Mar 2026 11:10:28 +0800, Shengjiu Wang wrote:
> The SAI and XCVR have the timestamp counters and bit counters, which can
> be used by software to track the progress of the transmitter and receiver.
> They can also be used to calculate the relative frequency of the bit clock
> against the bus interface clock.
> 
> changes in v3:
> - define own functions which check the pm status before accessing the
>   registers to avoid -EBUSY error reported by mixer-test.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: fsl_utils: Add snd_kcontrol functions for specific cases
      commit: 819cf1dc01ce66b6906d403a6925c4bd754a7a1d
[2/3] ASoC: fsl_sai: add bitcount and timestamp controls
      commit: 8e27987a208029c39da7a787bd9f1217d42011a5
[3/3] ASoC: fsl_xcvr: add bitcount and timestamp controls
      commit: 7b3f8db159f710d432c4edc024fcefa9e62e8b4b

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


