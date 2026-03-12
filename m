Return-Path: <linuxppc-dev+bounces-18127-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB10106ACCD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 17:35:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWvrR617Pz3cLG;
	Fri, 13 Mar 2026 04:34:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773336887;
	cv=none; b=avR6xRURxxH/sIRu4FdyyHh6d+QUOzLAn3whNVuF0s/+H9bWux8eOD2iXR9r3HcN/JdGMsQ92oSDiT5oh+9sgk0Bz/7Tn/nUObohxTK2p/aSswcB5d/BIrA3rjAQmkj41m9BY6IhRG7i+PnPVb5M6NIpZTqXCtck4LL655VuwDsT4gIeGiAKc5JmvQ4TOIOK8OzVVJ4tlJUhkEFgcQlhtSAzoNnwgYsJgyew1IHi/TSLgUzzvvfzPY7Ga0vOg5+UQ3DBe1G7V8B46MFrv5KLpI9rzNyDRGz3Gy5j3XH3DRJzFk3auJFvH9kaiapPrr3IZlw9NF8j4/pm6QYpPQo1mA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773336887; c=relaxed/relaxed;
	bh=W/f6m3Ignvfm/TI4XOSQpU1tAUFYssuKTKydcCYvkug=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=B5G+cgGj3Gn69r/tsgFf/CLghLxASXnJZ7j5yY4oV4A/3QkiQQH97hz4vQq/uPT0BxasDZ9tOflW+p0+eA8czJlRfz1JXcngKRw4NFCQK6JsT6rqfbU9wIKgg2RWy9/wbpWss0w2pRO72xz5KWeS6QkxN8EeJYdwNz8+Ys/PaZIBhswop+w0ndMJCevxkXp5vNGWvl1r7FodvPb3iixTCUPGoLAWbRK0okJ6Qgvyy1J9BfR8+iOPdKrQnCoLGpG5+gsEOpPUE0bSSdLzP0GhdZPDi5cbP905Y7A/ZWnwYuJC+aqN1bDAt3btq5leWIEpKt4zd3CQA1gKMNTRCHpcGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ObhSNXY8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ObhSNXY8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWvrR1Ypzz3cH4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 04:34:47 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E76CA4426D;
	Thu, 12 Mar 2026 17:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22EAC116C6;
	Thu, 12 Mar 2026 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773336884;
	bh=MUa7DRBVFoO81wEfsHpcvITgOYtf8fWifxP9N3J/Fz8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=ObhSNXY8ZVDNmsPYN0pGf8KKgIgZPobeEzg5JVcu0+cUhAeCiDtHv9RhUfktm0MRK
	 zETgf42oZUi/dB7EDm7wavQr1rxs0kw0mNjzd0Qy+K0IezrhNQV4pyXmBpfgYFym1b
	 N6TB5M4xx+fOYXocsr+/n59LYfyqkwhYvsyglXfPWFVpKH5E2Z81gtX85sCylbtSK9
	 9S2U0XkLkL+Y0356qx+JUC/mRm102YiikBJbkmFYWpEs+bevexkP/wI8PMVzvLwvYu
	 HzXLvjwNKGy5HfNcXCGwan5gU9Q/XkGgqxRFX9MKPBIti3P5iwMN0yZKn12QyNQd/q
	 OOO/Hb/UBiHIg==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260309083530.2977163-1-shengjiu.wang@nxp.com>
References: <20260309083530.2977163-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v5 0/3] ASoC: fsl: add bitcount and timestamp controls
Message-Id: <177333688260.302961.12179311060278151580.b4-ty@kernel.org>
Date: Thu, 12 Mar 2026 17:34:42 +0000
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

On Mon, 09 Mar 2026 16:35:27 +0800, Shengjiu Wang wrote:
> The SAI and XCVR have the timestamp counters and bit counters, which can
> be used by software to track the progress of the transmitter and receiver.
> They can also be used to calculate the relative frequency of the bit clock
> against the bus interface clock.
> 
> changes in v5:
> - use EXPORT_SYMBOL_GPL to replace EXPORT_SYMBOL in patch 1/3
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


