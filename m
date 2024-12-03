Return-Path: <linuxppc-dev+bounces-3743-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31FCE74AC3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Dec 2024 17:51:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y2p9T1R39z30PF;
	Wed,  4 Dec 2024 04:51:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1733248269;
	cv=none; b=Fyxt+d4K3zzaI48mfiy4HQNX+MW5l3XP2Inmi+GQOeRJn2MozV04QT+B5YS9J7jdDQfTyCOxqYK9I0HoXmJtdArwrWRea79GcE6NqMz0FFHPx2lXALe04duyPgbDNkCs+5d+vDvV6LfFXrVTHSFKD9JyH9fyH/nIbw0LPNra3h92hEX3Yu688VSQ8eV94NIG3voZlbx6Q+ALAwjsCEr6ftxKMI6YiiyDFXYUnfK9hFQk2OrGQOjMew70wF83nZm8FSLoFBaqZKCbhjGRgag/8hHG9aUCtrlanrL/CHTAebn4SBRnHsz3Lpz8CsOAbTbyVwxDBpOFdvTX2nHgHc3TLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1733248269; c=relaxed/relaxed;
	bh=4lD+QzjC1y7nMj9hC12wE3MPmoqOmJi5oopNVEZ1KjQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nmChEbHalHx0SdBaZJnzzg3s2lmj6Ji1rGnmS+VRwefSfBdIJUeoAsOEjFGTQfZ0HN7dgNdzfDYwACLgJr3nfgy1WzGAUntT1vvLtCz8XB7Pmy/e82Cr/MxMUweX2SdFpU7WhFubb3oLjtd3x17DgZNxtDhWPnqwphXrIT/YlaKQqBCPFy93E7l+48bv/SHlE8g4pm89dDNq+hwqIpFYSmGFoyrmUom7vnN7m+ymMWCsruUgHkLyOPHMllbePX2wqCi4eeu4/vtZP6MNr3SErFf/EmE46JWAlK6pYilb/elBncS3bSKPa9lBlTtY8J5klfDX+cO/MD7LjuMcEM8TfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OZaKw8/c; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=OZaKw8/c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y2p9L6yYNz2yVG
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Dec 2024 04:51:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BF910A4160D;
	Tue,  3 Dec 2024 17:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B243C4CED6;
	Tue,  3 Dec 2024 17:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733248259;
	bh=YJ511IzmxEx1Uc7jnWrD+86VGyWywPsi35FQg9sTMLc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=OZaKw8/c/LLTsLjErPsytZFVwE8X0k6XxNzWOecHfhy+t9iG2KINkTGUERrTTuQaB
	 SWwBoziIoXBgUc4vpDzQ4QmbmXdLcCFMb2sQokqI97O61SiaHW4ryNaeP3P9GfVe/T
	 tGipqSL9o8n1bPal9rXw2R7/2p688An+8bOCUn1m0jfCu5YO4V0ldwYulfzTLwmoZl
	 biTGFB99Jd3HYXRmzOFEhPiikcwRWJ8zqPSHMaBA0Ww7STuhmcnPpNIP/wNnIBnP2p
	 XvNmCc82b6tV8ajw3Hz0uPrj1+kUJ7uOX32Bdw8Kg3e0bRjR31v4dwPpo/I3caCo7u
	 tBP/G4+nQU23Q==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20241127030035.649219-1-shengjiu.wang@nxp.com>
References: <20241127030035.649219-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH 0/2] ASoC: fsl_xcvr: Add suspend and resume support
Message-Id: <173324825736.459040.7211694275678808457.b4-ty@kernel.org>
Date: Tue, 03 Dec 2024 17:50:57 +0000
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 27 Nov 2024 11:00:33 +0800, Shengjiu Wang wrote:
> Define regmap for PHY and PLL registers, the PHY and PLL
> registers are accessed by AI interface in controller.
> Then  driver can use regcache to recover registers
> after suspend and resume.
> 
> Shengjiu Wang (2):
>   ASoC: fsl_xcvr: Use regmap for PHY and PLL registers
>   ASoC: fsl_xcvr: Add suspend and resume support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/2] ASoC: fsl_xcvr: Use regmap for PHY and PLL registers
      commit: 5a8b4785cddabfad348a96ca38eb0c3d735202df
[2/2] ASoC: fsl_xcvr: Add suspend and resume support
      commit: 297711ba0282abef38824b1e08c0ad6dcb6c4a53

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


