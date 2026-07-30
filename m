Return-Path: <linuxppc-dev+bounces-25125-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47706C55164
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 15:50:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9tvX3yDXz2yMy;
	Fri, 31 Jul 2026 01:50:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785426632;
	cv=none; b=Thya5qybVp9sXHnl7sCyBXI5M64HG6kWHKMyCpQqfLDBHV3eL7vLmdAGhdB3bRRjLnXIxgbKyFFV0n99pD7XPn4fboW6X+sM+3e47BnURfbiAzI0TgyZFzApEwUfCXi8FYk9T4mIKs/l++r8LEa70a40XRpfG0mcYlzvRfx0YBQ5GhquGLpWwIZm5ndu3wR+g2kEBL8t1FH76pug4Wl9svB1toSo68zA6zmplR9Ax1lkyEj0RL8Uk96mWG0yEndaKx87W6CI2aKOKjzZBTfJdkgRXM4S2D5yXsAjoIB5fBLs6yYBe/rg5LUJ6fD+tCa9IMReJH/XiKlcSXnu61Iz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785426632; c=relaxed/relaxed;
	bh=lts3poYN0q+4SuUXzbt8GNf0Q6/wJatHUi0CoDkkUCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UiVwGsSiwTJZLzYjd/4DTsSg7fJZRBp7kInawLwZzNBBRjHnpdiOJAe1GrxefqKtdcvncXEiUu7ZcmvRsTDlTkZaz/V1Adsj1TCDNh5J3a/bJ7BdGo0fMT5Be0mxzHyRqkNfnNo+yAJi4pJgVZlIv4jR/dm89h+FMwUReHLPvNXkorvYtOeafpQ/hCwVj0Z7RGYrtd4gdThoGyRGA/G9b04nlM2O8DVD62BQ4kBQRKS3EiDanOZNSqYns4gkxeX68smAHDwdvZbVf/OqYsVWt2we+O/ftD0kHCgvaFdyunvZWhEXLdqvHC52Lgv1QfmO0E9T49gf1mq50BV4hNtURw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqdKJ40k; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqdKJ40k;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9tvW46Hnz2y8c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 01:50:31 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3D0F4600C8;
	Thu, 30 Jul 2026 15:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 210211F00A3A;
	Thu, 30 Jul 2026 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785426628;
	bh=lts3poYN0q+4SuUXzbt8GNf0Q6/wJatHUi0CoDkkUCg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UqdKJ40kGoFLU+mGv0Z4vmtvxFss4JQO3L74/9gonTut3Uw+U6jPN+13yqIMxTqmM
	 zn+EsxSOrwtygALWZX3UsIubgVky8C2uuL0Km8KcGCK9Jha/DLAUFXyHOFSUejj5Fx
	 u19C83HL+kDuTYDy++DahGOTOwmBBUdVedkNgqcSBh928eWEswzlBwuZan6+raNLyp
	 jPUDZZv3S7xFT9xkzign3IZxpjX00ns6eFpedQh5Nu6loU2VDm+TcXc26hrAsH9Gcc
	 MuUD6zZV5AUbzveii7iGxwssyO67NFwljo5dYVGfAvBXNHTOBekiYmt2kTtxANTCzZ
	 yetTSc/wVpoGQ==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20260721225442.817787-1-rosenp@gmail.com>
References: <20260721225442.817787-1-rosenp@gmail.com>
Subject: Re: [PATCH] ASoC: fsl: dma: use platform helpers and devm cleanup
Message-Id: <178541397313.81171.5927385255562929260.b4-ty@b4>
Date: Thu, 30 Jul 2026 13:19:33 +0100
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

On Tue, 21 Jul 2026 15:54:42 -0700, Rosen Penev wrote:
> ASoC: fsl: dma: use platform helpers and devm cleanup

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: fsl: dma: use platform helpers and devm cleanup
      https://git.kernel.org/broonie/sound/c/522d7baa39e9

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


