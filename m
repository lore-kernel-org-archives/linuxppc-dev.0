Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC20606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LS5XszJi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTVtB1W50z2xl0;
	Wed, 18 Nov 2026 03:43:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794933826;
	cv=none; b=XSR4a1iNS66GU7ZnDklg1GZJGMGvJHGRgVmGAwr2+d/lXOxcQBI7h5Y4enm3HHwKUjrDHcWMJ5PU9A7gKOiX32iDIahtYzfZwKMhucIjuZYRxtI6kyUuZf+/YC1XZw7fFODDO3IF79mH6nvMEfr3BYTkMd44n8yzRPdQv8AqBK0wY2zto0+4ooLi/gD/VQXcZu7C59pSma2epjIpE/T31TDUq94I+6nI5yIcKI4qZ2ERJ7jSKlSa6TGLf0Qu4GRlno0uVf8pXFFwtnkFKj/vwo2IjevdrCNftLe2OMbbWpARsXjdxMsAWH6NdR1pLOMUomF1e0scD4ktq1/imJhpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794933826; c=relaxed/relaxed;
	bh=ZTHwNVFWZLgXt2unt2sBi2B/rMYxeErvHfpuelqEzts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lmwSu6NFnBp6TZucCYwV9yeQxswXwUN03mczFXwrwTi075JHsIe+FZ40+V8L5Q7Al3BFnGP59rvFp6Nj+xWLN3p8PS7XdnFZp/xhnrKt2yjDyLj2WbWEGbwsvjnPMGRj3K/Th0evfuCotyELSnmnulEcIeYRfNVJSRW/oMAWcOzekq8EpN8M+j6nRPpafjidrzJB67zXh24rMxzEM6n4q7JhyVWSHobBcvCba550mYFTzmF4WTArDHJ0uPBft+40fEeHoYcJmTNBFJ6aw5KA/5jxXNOTKynItFDcpj1DZo7n7WJoFfCEFt5bYs8PDL+NeOU80YFb6m2lwoXkrfHZpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LS5XszJi; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LS5XszJi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTVt92J91z2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 03:43:45 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3D31061256;
	Tue, 17 Nov 2026 16:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0041F000C8;
	Tue, 17 Nov 2026 16:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933821;
	bh=ZTHwNVFWZLgXt2unt2sBi2B/rMYxeErvHfpuelqEzts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LS5XszJiRCQq12tLhYFW9XoELb+ayrhWFUzIjRgwbEEM+HXtG5NWYfzScy9fHajIO
	 QTkrxhxM+CJBXBnfguXKOR069mkrEtbkjD8Y3reNQszDYNbIxDD7bKDKK2y5zclCi5
	 gNkDBJ78Rs8g4NIn1WMYp7PqwXma4rceLKNplVI2Y+hKmbf6nDCKb3AKDDXzEQxiM7
	 BfP+/6IYGhGnM0Mvt6E22uE3q1dSBXWfxTNKQyojkTt+Ae1S6WmJ8xKUieZM/dg7Bp
	 Q2TxkkV4d3RchaJwdZOwXMCAlzM9z06OmctVNnMaG/aKsiXIGf4Kg1ZS5pYjQ6VdlX
	 nh1sulooRi0vQ==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 phucduc.bui@gmail.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261110075841.12104-1-phucduc.bui@gmail.com>
References: <20261110075841.12104-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: fsl_sai: Improve error handling
Message-Id: <179492781045.77896.18198371225516958659.b4-ty@b4>
Date: Tue, 17 Nov 2026 15:03:30 +0000
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; i=broonie@kernel.org;
 h=from:subject:message-id; bh=1rSLxismt1EO+6tSoslxFlG+H3uyXURGnUef1APXImU=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+tFiyW0pEqR+YuubCoZN+7hvTAuI2VwqcFTfNa8lP3
 878v9ayo5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABM58Zvhr8yipV9s1tjf5j/r
 tLnyx0OZ6fZbGI9dX5h1YnrF7JTTfqcYGfoCnk+9Ynrhwp/VjbeMt28/skul+OzvqQbRLpXaksa
 XtdgB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 14:58:39 +0700, phucduc.bui@gmail.com wrote:
> ASoC: fsl_sai: Improve error handling
> 
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Hi all,
> 
> This series includes two follow-up changes for the FSL SAI driver,
> covering hardware reset handling and dataline configuration
> error reporting.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/2] ASoC: fsl_sai: Make fsl_sai_reset_hw() return void
      https://git.kernel.org/broonie/sound/c/7192f1a8cb6d
[2/2] ASoC: fsl_sai: Report dataline configuration read errors
      https://git.kernel.org/broonie/sound/c/6616554f4166

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


