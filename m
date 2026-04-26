Return-Path: <linuxppc-dev+bounces-20155-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CCCFF8861
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Apr 2026 10:20:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g402602TBz2y2B;
	Mon, 27 Apr 2026 20:20:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777285229;
	cv=none; b=lipVscrgxrx9/cLvjXhamdEnfv1Tx2sj1FKktR/9x7EX/JCLf1B6FrwtwmbiudMtiqz1qrtjvo6zLx5FdwGUtTOFCLkVJx4CdQYnB6XNtI4CUlm53JE1XiPng0mfUdT/yESUvzfFlsl52shP78gB++EoqEWCJOGdNzopEw970173wQ87LULL/QS2YhP4YwM84gU3wTajOTg7pxvk0xdgEt8ceE9Oz734VFrAqzr6j0jRh4jejks/c1iDoCCwwbVSEHv4MkUcXGguKsL8NlXpIfAvonCrFlRgkznvWD0PC1D04hOk0wB2PJ11Mtnj5aHtWodyi4dFHFThfQiJHwADFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777285229; c=relaxed/relaxed;
	bh=ZSayQyX7Tizf5qfiGhuQlM5giai/j8rsfBPIITRI19Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c4CCgkZ5+6nndzLIOdMVy5krNZHGpRsxYetZkIaHb52DEEx91GmkR+3bDPXSSFAWp6o8/Uz0bFog+ymLsTOR7LxXHMZEGmnK+43bTeiZT9JzhNa96MnOAUmD1PKaHOn4Sajcv/wbldL183rF3cJKlR7NQmDztg61d37/cKazWFrYPAoycXvKLSkfsnnx3cILVCL/jFpDLflrKOjSIuyEmp8cDPgua9CUhP9pJu8yZED/VihHRSY4dgCbOXXbwCOIqxYa25vp8X2ubmjQR09oOtjsJtITI70702LsYY1DmTPwYDjDw38r0c+kOFSzygHV9ix6HSUERDHYn9HK9mLZhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uwRK+Svw; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uwRK+Svw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g40252SqJz2xcD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 20:20:29 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C19846013B;
	Mon, 27 Apr 2026 10:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72447C19425;
	Mon, 27 Apr 2026 10:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777285226;
	bh=NhCAOaKAon5sq23oNjs0R3LpQS4MmUsU3jGRLCPg8Mo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uwRK+SvwQLoJIqFsCUAvgwb/Vdi1uHTUc/hHXiXV1gtVR1XtcvmntT/gPz0rx3pnQ
	 DDSyLC+zFylgmZaqHBdnPQRnf4p2tLq+fFJugv+lF6QA8aamOc4yoJxBiTSxqGOcCw
	 mx6sRwjOdq78A3An2QIw97NYBeEyFH4lR/E1FVvtimYCE9lazpEvdCaQoxZP3kugzw
	 X6wSRpGa26TlZioqv52Pu8IeiPGCnvhmGpFJPrb8x6XYeVubGbPqpKI1WTe61e7+nW
	 2Ku117QnGsqQAjTkK9+BNwtIo/G0a36XVgss5PwY1VkIgbOUFxQ6Pk40LyEW6p1tPI
	 8bKTF8vJw/fkA==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Marek Vasut <marex@nabladev.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Rob Herring <robh@kernel.org>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Takashi Iwai <tiwai@suse.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20260404183547.46509-1-marex@nabladev.com>
References: <20260404183547.46509-1-marex@nabladev.com>
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl-sai: Document RX/TX BCLK
 swap support
Message-Id: <177724631903.266775.17442968887704831835.b4-ty@b4>
Date: Mon, 27 Apr 2026 08:31:59 +0900
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1246; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NhCAOaKAon5sq23oNjs0R3LpQS4MmUsU3jGRLCPg8Mo=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhsz3FmmneNVOFn7SZNTo0BDX3rxPtyH/1OwlebkH+lUcc
 r5w6Nd2MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQATmSnK/r/6USr3X/7Lmvtt
 Nur2TJnC9ZTJMHFdX2C/ueRL6Ut/9U+IeyaKOuTVeqrP+HvdZfN8vsv/mEoYZUQlNm7wubFwipk
 Cw9pFevWGb2R2z/6UpFJqWjw9msd/BmPvgrcZZv3NQoqMYctz+8/7mtpsijs5U9P/Z07GFM0gj9
 SfxrFTFtj5PpzjeKtmtUVhWkzxHrHtra7yp9d47ZkfbhWXHLs596DeNfOIzBbJ6Fz94wsz+oNmv
 3k2iUXYfkbhgzgbjy7R3703P2wMm7NF4e7qb+H3uAQLEy43+mipyRR01K0RXpcW26ddLphVssu0
 ftX9QxfOHNz175znh0TON3brAro+X++tTlc9xO+yMJ4dAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 04 Apr 2026 20:35:00 +0200, Marek Vasut wrote:
> ASoC: dt-bindings: fsl-sai: Document RX/TX BCLK swap support

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/2] ASoC: dt-bindings: fsl-sai: Document RX/TX BCLK swap support
      https://git.kernel.org/broonie/sound/c/9897a9776681
[2/2] ASoC: fsl_sai: Add RX/TX BCLK swap support
      https://git.kernel.org/broonie/sound/c/dc06cf4268a4

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


