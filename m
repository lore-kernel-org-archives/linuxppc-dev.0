Return-Path: <linuxppc-dev+bounces-1707-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95524CE7D10
	for <linuxppc-dev@archiver.kernel.org>; Tue,  1 Oct 2024 11:13:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XHwL33w8fz2y7K;
	Tue,  1 Oct 2024 21:13:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727781226;
	cv=none; b=o1y8aoGOhvc0CFc9992frlulE92u/Blls2gtY74Yd2bu/Ut0OqvwQZLIAQuksH98Nk3KzU8OzNEzvzRhKIPRnSvOpCi3AFS+1r8PL3t1ocetMfbKGhpnrvXFDnKJIusMesejuX1/205clGX852YEIfWejLyl6NzZW4BqmI1SHhcfVPpsqARa8CjojwstRvjNTTTuGvHl22RYteDCeOy0zYPLuJ65ZeaxYSEqSKUUFaQhQiSSjtpcavXt4yPG4eXFxolIaJZLYyrl1KpgbHbrD8IeNb6UZ1UW5jNgJKjzmL9m81tX28k0ukX568BFlxEhGUjbyzjvfzCqr+S7BdBG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727781226; c=relaxed/relaxed;
	bh=lKH/B8Ytzb8oQsn8eJcKQj1sUXxkPK+VC9EP+ssoiGU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PocF48V77CYvEAsEDKjG9dVUtVgxUKIjW62XVgD6BWkMkUTvLaQrPilhXQZse+xbbX2bKH+KNHRm6ERMLuFJ5wPKSgYz+t/KiPE9TXvAsLgkZAlU8H4R/kIWX4PPWuO8Es23+Yn2nwXoZ4okwF7hD2SJtOBx2/NZ4D7yPyq6DwmF4Hx5XQqHGT8y/2RYBcPX/w2z6k4QTMCWzR4CUGJKj0ZboLrmVmGSzo6RebS9ldDkybHkKXnFv3ADUAzflao/TGys6nFIef3TDWCNETmuYzJRhW/kaygaaht5b4bTjgZ0A9P4EpX14quH7WfLFrJoxJ2WYg9g7Rlv9HHKpZB2Rw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jiCbGyoL; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jiCbGyoL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XHwL22fF4z2xnX
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2024 21:13:46 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 860AF5C4769;
	Tue,  1 Oct 2024 11:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 522D7C4CED2;
	Tue,  1 Oct 2024 11:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727781222;
	bh=uzylzzEuT8st5r1GDFGho8NGlqZCts0HU6U/XLuQMR8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=jiCbGyoLA/AwlO5tcvz+hWeVL91xgjw+Jv5wABi6oRclBCAnwfxAm3gxrshOY2SJC
	 zK67yNlOoa3lu8gxuxL3d1QODvZjRAMTtz47vNNfXjY5T6ci9gRoDqoTcxK7WSeWDM
	 q831zSyCnXrw983Juyz9MLqlIO4xpNR9dGAeaOdnmaOE1VFSEjY/UHUkosDLqnFuC2
	 T+CSEuNZaIhzv3R6btsjP/rKge9TdCj2WH32Y9z98PKBZymkYeTKDfYQec0vQByJHF
	 HbxLYcz+bsciC2fUZjdjACem+C+23D3t/N/TigYeEl93gc33/fKvj/5VNXddMY6kI7
	 uNleuFTBa+fGg==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1727676508-22830-1-git-send-email-shengjiu.wang@nxp.com>
References: <1727676508-22830-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT
 bit
Message-Id: <172778121960.2280749.6663720660194136965.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 12:13:39 +0100
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 30 Sep 2024 14:08:28 +0800, Shengjiu Wang wrote:
> FCONT=1 means On FIFO error, the SAI will continue from the
> same word that caused the FIFO error to set after the FIFO
> warning flag has been cleared.
> 
> Set FCONT bit in control register to avoid the channel swap
> issue after SAI xrun.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Enable 'FIFO continue on error' FCONT bit
      commit: 72455e33173c1a00c0ce93d2b0198eb45d5f4195

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


