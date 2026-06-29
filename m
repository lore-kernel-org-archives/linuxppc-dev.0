Return-Path: <linuxppc-dev+bounces-23187-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86460C43638
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 11:16:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqLFS6B0fz2yYs;
	Tue, 30 Jun 2026 21:16:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782818204;
	cv=none; b=eFueDoCBtsr6bZSS+PZMyxVTY/ntSv+JEN5D8Ov7fgd6vdXgEHFVeJghOM0C5a/G2PCIcpBPnokDGjCy4mvYgu2Uez/fnXs2xLdXlMfaE39Onh0u6itde3pSzD6Ob1QjZTo0c7cadlrqz6C+BIq7tcHzY7RSEgpquEGKL/2rGrxVEkmF8p10aF7SRAD3WdjXt2fkXSIprpHVILztyKiN40uaqgibySvrve5/CkBeJEX1Uj1fxs9EvVCc0fdj6Eo4phbU5jR2283Qqx/Iq4t1aMIRfbf/Vn7bTeW7xFE/STBnjoBNkfCUFMdc+eUCnWnBjC8CgsxTcGSRzE92nUL6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782818204; c=relaxed/relaxed;
	bh=1JPnrdxJvL0WFN5wrOSvEBToBxSFJluscDvZ5wP//rQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U9phbKBgrXmO7CK0gpBjdnJ3QKPa+28lwhDfDjPRlo+DDLPoi6NwnBe6g2JT4ComWYHeRzFG1DDvwz5qnENQer7YMo2/3rXk0RRh2kXRSudD1+tEB//02l3mRAYdQcJix2BnRBgrEMwbzOfaHpIOu3g3eOq8x/54u8wNl9bla1nRYtVUjxzbPaBlLP8uOUCbd5KQhTdnuslkH/h+0IaZraUW8LCqNyqS7C1F9u7m2PezsgYfhUreAbwH+MeUaNlnNjzYrJ81xbzJiGUgmuXCYDim0yrJUOGlYMYV7hdr1r6GTtdVARyr1QmPEwpTjPHvPmhqR2yBypnOTCPq5Ax0xA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/b/6v/G; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a/b/6v/G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqLFR4p31z2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 21:16:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DB13641450;
	Tue, 30 Jun 2026 11:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD70C1F000E9;
	Tue, 30 Jun 2026 11:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818199;
	bh=1JPnrdxJvL0WFN5wrOSvEBToBxSFJluscDvZ5wP//rQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=a/b/6v/GIOOHx3mkurLDiSwCYEV+FaF40ZarjWBYs9LAk/x2Dab1vbwzWPBbXumSY
	 qCL/R4hpI/xR+csPkyDFeDvW4uWAciPLePWgJiybdXppe5u25pNrNFO4tn1dzd3v3v
	 kC6+KrIIGd52n54CP2TaUk1hT7OeTv7S2pKHfi+YAo9wHuuiDJxubujr9JwfkcthuH
	 qCTk6N3IiLNlrXU3sJcZR+gK9/ZuSgJY1RV8MfARE0y6eRBx9npsHpyXb96vPKEeik
	 8JCRbFXSCYsoI7lIBSyw4rxO1bn3/GJeaS+q+zB4cPOZNcw+UUdVipomdASSnvbce1
	 t6tWQb7qzWNGQ==
From: Mark Brown <broonie@kernel.org>
To: phucduc.bui@gmail.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Xiubo Li <Xiubo.Lee@gmail.com>, Frank Li <Frank.Li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20260615093824.115751-1-phucduc.bui@gmail.com>
References: <20260615093824.115751-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH v2 00/11] ASoC: fsl: Use guard() for mutex & spin locks
Message-Id: <178275717908.47562.6018027459951398381.b4-ty@b4>
Date: Mon, 29 Jun 2026 19:19:39 +0100
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
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551; i=broonie@kernel.org;
 h=from:subject:message-id; bh=suxmd7hBx6haxwfUYdAMlT9JDpZz5886NYdo7Mep1MA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ6WTVpXn+QGYzZVDWj262eDQ3hIPy1Vgt4Fm/
 PIjKaF1pxuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakOlkwAKCRAk1otyXVSH
 0AIZB/9pCqWJBKcMORA4HBEEOe7lHfNBdFAzXulEYYl+5A2SiJEdEPvc4Ga9EUUxHrNPS5I4j+P
 deSVsyW0G3OLOTfvVl532NgIvjBtFV3RUjyR4wbrfKtabENJsnxhC0WD40xWSRfVA4ZuzoFc7Zi
 f0qBGcqMWEpTLSdNMPURlZEfhPDctucv4ocZA8ajy/rGXo8Uy+dxI5D+VZq/04pUhz08nU0DCSJ
 +ZIRf3WapsbVH1DdZhOGB6IevhavBKBK84tajirZ6/6E/qraFYdDhGzKHXSOhsqshuzC796HZX0
 WXOBmsq8g0rx9F6D5E+sms6w0i+dK0mbimBO9/HarTYFVEPS
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 15 Jun 2026 16:38:13 +0700, phucduc.bui@gmail.com wrote:
> ASoC: fsl: Use guard() for mutex & spin locks
> 
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Hi all,
> 
> This series converts mutex and spinlock handling in the FSL sound drivers
> to use guard() helpers.
> The changes are code cleanup only and should have no functional impact.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[01/11] ASoC: fsl_asrc: Use guard() for spin locks
        https://git.kernel.org/broonie/sound/c/d7e261b7ad1b
[02/11] ASoC: fsl_audmix: Use guard() for spin locks
        https://git.kernel.org/broonie/sound/c/58712476dee2
[03/11] ASoC: fsl_easrc: Use guard() for spin locks
        https://git.kernel.org/broonie/sound/c/48d84310be60
[04/11] ASoC: fsl_esai: Use guard() for spin locks
        https://git.kernel.org/broonie/sound/c/cb87bdabd341
[05/11] ASoC: fsl_spdif: Use guard() for spin locks
        https://git.kernel.org/broonie/sound/c/a1b865cff274
[06/11] ASoC: fsl_ssi: Use guard() for mutex locks
        https://git.kernel.org/broonie/sound/c/4d748e7082ec
[07/11] ASoC: fsl_xcvr: Use guard() for spin locks
        https://git.kernel.org/broonie/sound/c/94b0cb1dd6d9
[08/11] ASoC: imx-audio-rpmsg: Use guard() for spin locks
        https://git.kernel.org/broonie/sound/c/929d412fdb0d
[09/11] ASoC: fsl_rpmsg: Use guard() for mutex & spin locks
        https://git.kernel.org/broonie/sound/c/11ce4dd4e7be
[10/11] ASoC: fsl: mpc5200_dma: Use guard() for spin locks
        https://git.kernel.org/broonie/sound/c/caed9fb2e428
[11/11] ASoC: fsl: mpc5200_psc_ac97: Use guard() for mutex locks
        https://git.kernel.org/broonie/sound/c/8a2d7e46317a

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


