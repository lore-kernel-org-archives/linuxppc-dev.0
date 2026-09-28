Return-Path: <linuxppc-dev+bounces-28488-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CEDCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:28:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvGBg33FHz2yvy;
	Tue, 29 Sep 2026 21:28:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790681291;
	cv=none; b=ZxQdmQ3cvXxRLepuLILicMR9vAEAirfTEIjDp3dwPWoBIZPvjZJ1bbiJB51SXwQ6ouL3o/oU+skSgbiS9f86lQ8kryAQT33j0UytteMrg/BUzCG/kCRBI1lyZDVfMDqIrOtexIvodRP58qEE8VWdebBQokX254X/wwgQw6RnT5aefVERa3CE3u0Qgk7ZVFDI8ywUrWsgGWP1+tAe1DNzpY4oZi93MMpk9oc/mdR2alHJqRd2J5CurxAm3VY7DBsNH11lY0W1q/3M5CULb4HabWDX1a6TOGTexrJd7GrlL7jzhGYy9XecK5OPApOQmUtYR4sj22MJeuEs+Dr4dQaATg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790681291; c=relaxed/relaxed;
	bh=SF264KM1xpFJ+Dj32T5xIH7ajqAgZoHjgLRWkmxYRhc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lCDHyfZFsw0bVYqpI/pvFG7oXU9N7/pDRS0LccrmMRlWf9qej+w7hQ3+yFoB+9QTdmIrfYE27CzZstyisW5Xt7JXpZfB3TH8WNlJ802kb0vwD3GmTz3+LXdZhcV5zLx6N0Y14xFQRm2hrpPlmm7TH80TFtKxXa3FWEBdmrUMBe9gNWg9+nPdKe6+4jg67eU+O9gnImcNkzfBItKHunWNRGwdMKaZ9PhiPSWDj70CYVb1aauzwLgAK9EYk5BP6oCY73NNe0SMencg6rxdq/wY9+F7SGl/f9iqO4tRXk/IK1+TrzD4rP3PAfICDclS/I0VF2cUsAw1ilukxra/24C3RQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TaCp7VF+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TaCp7VF+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvGBf2XTYz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 21:28:10 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A496460008;
	Tue, 29 Sep 2026 11:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 662A91F000FF;
	Tue, 29 Sep 2026 11:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790681285;
	bh=SF264KM1xpFJ+Dj32T5xIH7ajqAgZoHjgLRWkmxYRhc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TaCp7VF+ghdsIp8cbipLsnUrlK+ZaDq8YiaIQrIBXgYISNADu3VqQXzhrtGHmJvKc
	 gqNRx7/AWc6hUzZat0ZHRcHXBQAfQLCHhZbYQ+TBItz/hnJAROL1dtRJWoCMj5VSLn
	 PGHAOZzUpzR07eJbxG0rE4LtGrC8McPTuXCymW7/UylISSKk6FS84ojbF2UZAZPbGL
	 4frOBfmowYCl1oOF+um/befHzNptb9WK/2o21k5ktEX+ie3OuNlQLnDAW2s11Bgmm4
	 W4a3rmWYqGWgQGv2XUrE4EZz/9i7k9IjtmyPAuPnbLE+8R4IVVtHl7l90NFS4Bjo11
	 BD1u50XOXB1cg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, shawnguo@kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, 
 nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linuxppc-dev@lists.ozlabs.org, shengjiu.wang@oss.nxp.com
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260928061149.1844121-1-shengjiu.wang@oss.nxp.com>
References: <20260928061149.1844121-1-shengjiu.wang@oss.nxp.com>
Subject: Re: [PATCH v6 0/5] ASoC: fsl_asrc/fsl_easrc: expose
 per-pair/context DAIs and fix DMA race
Message-Id: <179062040693.139547.920625432189790512.b4-ty@b4>
Date: Mon, 28 Sep 2026 19:33:26 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1969; i=broonie@kernel.org;
 h=from:subject:message-id; bh=08vNLIXx98Yrj1IvpKudnUztu+PDLXSe1G9EqUOPitU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqu6C+CJwhLDtBYODaVPjpkxT4PasDIRnK4w0LF
 qkt5qH1jyCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarugvgAKCRAk1otyXVSH
 0N3fB/48ng38Yw1sNvkBArrecRxtJTVGTny+M/NNSSBoHgs1Q2g59SsOpMpPi5/8WH9Zzm0ODkZ
 QFs9Cj7cSSPA7i4+F2GgfrDJ/QpeEiGOrKo8q8TAXf3WTh91WusidXAocvUW0sah9doz5UrTlCA
 RcaR6XQK2KuuOVVvFtVdw7QmCnx8NEjSQk6yL/AohbCjc+vhSMZgEBWF1ko4w3H6RciZlvVEYQv
 Nkezy980RanQ9pcSvy8hBDTeACiphO1eJQz6ACFyl1btGd9HO6/lhDqtmpumJYS5fwFlGJ6qR6K
 qiLD6kKgTbzYrLA4jePspvzHJRO+5aXY1oRKVpogY5rxv7Km
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 28 Sep 2026 14:11:44 +0800, shengjiu.wang@oss.nxp.com wrote:
> ASoC: fsl_asrc/fsl_easrc: expose per-pair/context DAIs and fix DMA race
> 
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> This series extends the i.MX ASRC and EASRC drivers to expose one DAI
> per hardware conversion pair/context, allowing multiple independent
> conversion paths to be active simultaneously.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/5] ASoC: dt-bindings: fsl,imx-asrc: update port binding to support multiple paths
      https://git.kernel.org/broonie/sound/c/7845324094fc
[2/5] ASoC: dt-bindings: fsl,easrc: add ports binding for multiple conversion paths
      https://git.kernel.org/broonie/sound/c/33598785b31c
[3/5] ASoC: fsl_asrc/fsl_easrc: move DMA params into pair/context struct
      https://git.kernel.org/broonie/sound/c/76915128bde2
[4/5] ASoC: fsl_asrc: expose individual DAIs per conversion path
      https://git.kernel.org/broonie/sound/c/6aef9cb5c797
[5/5] ASoC: fsl_easrc: expose individual DAIs per conversion path
      https://git.kernel.org/broonie/sound/c/788e893edb6a

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


