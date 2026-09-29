Return-Path: <linuxppc-dev+bounces-28490-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC3DCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 11:30:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvGFK0Hmtz30Yb;
	Tue, 29 Sep 2026 21:30:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790681428;
	cv=none; b=dgOyEK+JrZ8olxRcNuX4L+0GjnKG2E2HfupvFBPh2nrwLMMB7d90m3csb3Nd+o1pmfh0xakXNL1BA14ILNj4y5L6P5qyjFBxEIJUz7QZJkyi8KND3dxqvH1ePQgoRS1sILu8K1Rwk+/ym6v/ZaRqGQGfFk4EG6vtpg3Bsv+6El9QCa0Wq3FBloFaV0LSVbSiSjSEejuo1jjVYtQ+13Z6JEc7smQtBLnf28EpRz+2u2dkX7iYEwKsy16e1emnTQahe8xdxNtyy+uMgHX1VoMFSe9dLJPQLOuZNTf7k8UN43oE1DgjFQ/tkE45vm/vQwMgzNaw8pElUoIW+6DhNJilDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790681428; c=relaxed/relaxed;
	bh=2COO99V3tWZkY2vKSP/RcAXFdKtCl9Xe902JMrRqT08=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C2+7Edpej38xxd/Y+p52QmaZPnAUhiMs6RFUA8JBeoHC1kXCJgkExSCoxZyBqFYgpZvIVF8IIUbLset9V/QtoHpwke1e+gWQe3R8Tmw9BXGbbALnuqzxzt+ENs96Kdd+KrwTjehB3FWs+ZiIz1e+12Sq8J3iHsw3opkHiZ9Cz4DxepCO/7vk3lUKhf0iGfrJs/NEkUvZ2pvxBUztyvfW4HOE0/J6p/SCQU7RB58yrmRZqVXbjtFd+rRpDlLZoGso0KmNjbX37gz7VM2TSIL/7NBpd1dY0WyBGmvuaEpIjtJgc2YnXgTqRMUE6QFx5iii20GAOkqSZflMiLVKSryKAA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhIScCCD; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YhIScCCD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvGFJ2mLGz2yvy
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 21:30:28 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 0C86943E9E;
	Tue, 29 Sep 2026 11:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923971F00893;
	Tue, 29 Sep 2026 11:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790681425;
	bh=2COO99V3tWZkY2vKSP/RcAXFdKtCl9Xe902JMrRqT08=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YhIScCCD2hrldStzzqLVcyZE5j66LQO/qOfz4sFArIpQ2PaLnC5+1+qAN7m54zyB/
	 SG2CxllzCp8opF3hCLOn6KCFj96YcUsRkUlqI4cUSQsfmEzSs4K62HgSck/Eb8HXEW
	 wM1ucBZoYMRH/fPM0icbvi1Gk6zp6oXT3/gvFG+OKOabKJI8AggI4JrV+yYpqsJzpq
	 CoC9LA9YZ0TsWHlXpkoaFOgDKUje/X8QcWk+N+cctaO8xPf8vf9g3CflreSPsDzJDa
	 Eq5Nv71xnMnY2XqkEHwOURk6ysX7vtPuTJrEKfjJYO634tKTV1/EnTQO0skRm0Fdpw
	 EHGG4uYFM7N0A==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
 kernel@pengutronix.de, festevam@gmail.com, shawnguo@kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, 
 nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linuxppc-dev@lists.ozlabs.org, shengjiu.wang@oss.nxp.com
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Chancel Liu <chancel.liu@gmail.com>, Daniel Baluta <daniel.baluta@nxp.com>
In-Reply-To: <20260928061756.1844185-1-shengjiu.wang@oss.nxp.com>
References: <20260928061756.1844185-1-shengjiu.wang@oss.nxp.com>
Subject: Re: [PATCH v6 5/5] ASoC: fsl_easrc: expose individual DAIs per
 conversion path
Message-Id: <179068142132.159801.7683706041383677671.b4-ty@b4>
Date: Tue, 29 Sep 2026 12:30:21 +0100
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

On Mon, 28 Sep 2026 14:17:56 +0800, shengjiu.wang@oss.nxp.com wrote:
> The i.MX EASRC hardware supports four independent conversion contexts
> (A, B, C, D). The driver previously registered a single DAI with generic
> stream names "ASRC-Playback" and "ASRC-Capture", which prevents
> multiple independent conversion paths from being used simultaneously.
> 
> Replace the single fsl_easrc_dai instance with an array of four DAI
> drivers to allow up to four independent conversion paths to be active
> at the same time:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

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


