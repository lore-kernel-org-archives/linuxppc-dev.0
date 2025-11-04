Return-Path: <linuxppc-dev+bounces-13741-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5346CCFA04
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Nov 2025 13:25:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d18MN1hJXz3bf3;
	Wed,  5 Nov 2025 00:25:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762262704;
	cv=none; b=Tr4t3COQaAlIJB8eIPZL8rbxEIix7lnXKI5r+1PcCOYlaeCjYQoqL5pe+QFkUOzljdPCwzF/hgO72ZlVYrFXDYFv7BEnTdDhYeYYgEuVK4M1Qx/5q1Jnai2cUWeXw04tgGM/NXTFKZhI6M5f9YV2oKQZ8ZopoRaprBH2PuR7e8y6EgYn0t4SB1WbivjvQbcb2wFxoTVdkZFoSi8AWRAWBI+SIyitU8POYvg8G9l0Ii0SJAtd+7IV9reAg3WD+z8i+4dSkJ5Ds1fa1w7GjKaH/UCGGYn3fdDnOyq1R+BlBzwwYpYIqLRBHyWmVo718K9rZ4Hkn0nJwU/2T8SYeKJW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762262704; c=relaxed/relaxed;
	bh=3MzRW0D06OR4N2974hauH4Dpl/DJ3+xwKoYqaTmgbyY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N+jprmryQ4xFeelf59XdYWoY1PihQHo11iBznCSf+imDyDhyN9bFSPzkcbeO4JaKjqB4VNG0+VvN2rzqEQRjJCnJxPliu0EAGVI1P8K1isf8kw0hs/rSJt6nRWsh5nNcffr9fhw2iQrI3z3CaHkdwlZ3zqN/eE1D9UOosHYa3xSOED8HkLITK8RNG+V9VnlTjQOZpF1TpWrB00tW5orDc16N1RUDQM2NmIqmV8kNVTi5thDmiRjkChEkatHsiFd5VZ+cfiI+XFo/HmUHmWGBAiFNJ90LLG8YPMGPVMuL2yXq4mXWwqVu8j+NUkvnZ/CL01qML8cvI6qYjuPWsmJeUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ovtupvph; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ovtupvph;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d18MM43BVz304H
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Nov 2025 00:25:03 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 07017601EE;
	Tue,  4 Nov 2025 13:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E12C116C6;
	Tue,  4 Nov 2025 13:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762262700;
	bh=Y38eEqKX315O/hK8GM4uxaI+ySMw+eyVY1SFmRr/Zgo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ovtupvphRvOwowH9up9y/0B+7TVWAXgjx2SZCYu0TOyZ+UmdQUhkZyMVY03x2m7BX
	 pt6m2CLV6Le+opzwJ0BKV3LE/gQ4+13sbe7EkP58W+GWgytfhYoNYvsZdwbFo4c/wO
	 zzDuk3gcIV/T9bqXHf6GfyeLCXis5mR1s2/AeJsz+20qnXRKKtfyYDfJkDfzDNpNQB
	 tH6E792kgbrxRHYahYlCN1wvFKmuJeeelv/VF6x3FYNW7OEqUka2jsUyseELJX9V/1
	 aWI36NxsQ6n0mWox3WgitZMadExXZQlrsNK/iD4+wPTCN7WbAhWGrx450mgYLDjBhL
	 kzeB1mmTRkyjw==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <5fe08f028395a6c6f50d11eee8fdb4a90b1f68ab.1762151503.git.christophe.jaillet@wanadoo.fr>
References: <5fe08f028395a6c6f50d11eee8fdb4a90b1f68ab.1762151503.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] ASoC: fsl_spdif: Constify some structures
Message-Id: <176226269713.2215600.7013778287587240101.b4-ty@kernel.org>
Date: Tue, 04 Nov 2025 13:24:57 +0000
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
X-Mailer: b4 0.15-dev-a6db3

On Mon, 03 Nov 2025 07:32:03 +0100, Christophe JAILLET wrote:
> 'struct fsl_spdif_soc_data' and 'struct snd_kcontrol_new' are not modified
> in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Constify some structures
      commit: 1a88479436a52452429f6d50ec5bd0a546406485

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


