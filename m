Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D21F606A339
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2026 12:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeCTTP4F
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jWDs748jXz2xpt;
	Fri, 20 Nov 2026 23:18:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795177131;
	cv=none; b=GBzJ5DI2HH+LyHZ4VAUq2SVFw6lrecAYqysB0FkwpC5lFIJfvk+hkPv6QS5KzP5K8dkOAQNENcpHxUv5Dz2wL6X2Ylo5pHm/Ozmi3xz3gw1QjWoCXHB5sLGMuIagQ/u6ciBetdwtcQSt9jRvB8LFh5zLP+UeqMo/YJWott9pI5wu8MHKKlLxrNJWki6WZlWxvnf+aXSBC+S9W6NRdR8OduPdHd9J+1ZTCkA70/GXrgMxVUEQzHVW2Xwhud8f6H8uCou2DXQv8SbJCbPn5FO1gEJxYRqQB2dTX5RoM1+RI0BrpiEyI0RBXOkCEARjvP7YF02wl3gZ5PifSODLFooNEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795177131; c=relaxed/relaxed;
	bh=cA8saSYay4O62VLhItjcTnPnaKWV/uIH+1+8IXsCJuU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BR+49UoFcNBH9qKu6zqEq8V4cKb+rX1hfWiQc9N/nO6aErXIhYENZVbhe/Mya5RiMSd4nSn0LrNKMUB65p17M+lQvIz9X9qCqT762SVJt/Tswn9G85hA6XA5O37043RxZ/2qPhniXeCQGGiMUNNJnODEaqSOg1FX5gpYeVZp146BZyvzPDb2INgfHsd56WNBly4naZUV4EBUMed/cfXZCT1ZAtu65Eoi9BunO1Dh/LenN5k0NJyeApMll04i+877t8egzMAoSIhu6mx7YNza5d6ZL8xMnKPxzvzRaMtwRHfZ99xjZi3NLp7X4u5P3+3MvqDEMc24bgiOjRi+YLhQCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeCTTP4F; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XeCTTP4F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jWDs645jyz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2026 23:18:50 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 18EB9620E6;
	Fri, 20 Nov 2026 12:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E05C1F000E6;
	Fri, 20 Nov 2026 12:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177127;
	bh=cA8saSYay4O62VLhItjcTnPnaKWV/uIH+1+8IXsCJuU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XeCTTP4FWXT3t0Kn7Pi1xq8HViAEJ5FWX0qXxFkvFgUlnVx1c3bdsdeXh4YImotyG
	 j7MMWThHSQAyn7YO0K6vL4bPpz7HD6ErAKrBJScnrgAPoBoRjjgT27W6znzPMPJUzz
	 0wfCedgnAS+/xcLQge5ZP2Uv0OCtVqe5oC72LzVRyGELrFFB6jgFRMX+6Ymuu8qw61
	 a6gl05msN62ARQvUAdkMp6OS+MjWcXgmXmdCgOb8ZKehsFczHbsCSbXGFzq/wVdxBE
	 0Fa+EccjRxXjt4CrahoEdJNbdMKSXnQ8HemjUiWK3J3HUKlEEt5VJJjLx0KzYGqPfC
	 qmXntngfxQqMQ==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 phucduc.bui@gmail.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261113050727.14053-1-phucduc.bui@gmail.com>
References: <20261113050727.14053-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH v2 0/6] ASoC: fsl_asrc: Fix probe and resource
 management issues
Message-Id: <179511198046.116416.8935610392478261011.b4-ty@b4>
Date: Thu, 19 Nov 2026 18:13:00 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2064; i=broonie@kernel.org;
 h=from:subject:message-id; bh=m5L1WGT7TXUgQ6jeBh7IUm7S6AegHVPNO7DGGKjH3yk=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIZrBbfu3hl2pmnj7oDYw8s41Jd/e68OP/2o8vWrag/s
 zW36aXCno5SFgYxLgZZMUWWuCzul/Ulr9fwHVzYBjOHlQlkCAMXpwBM5GULwz/tc8r55tHVDpdb
 vy7jtzMRq1nOP3Xz3lX9cW5vV3E+yHjAyLCZ/y/PzXUVa9NK5/6I/ahYIXZ6feb/teGn3PPX7vh
 rJc0MAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 13 Nov 2026 12:07:21 +0700, phucduc.bui@gmail.com wrote:
> ASoC: fsl_asrc: Fix probe and resource management issues
> 
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Hi all,
> 
> This series improves error handling and resource management in
> the fsl_asrc probe function. It fixes deferred clock handling and
> runtime PM usage count, ensures the IRQ is requested after device
> initialization, and moves runtime PM cleanup to devm.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/6] ASoC: fsl_asrc: Improve probe error handling
      https://git.kernel.org/broonie/sound/c/c41412f46219
[2/6] ASoC: fsl_asrc: Fix handling of deferred spba clock
      https://git.kernel.org/broonie/sound/c/a16853bece06
[3/6] ASoC: fsl_asrc: Fix runtime PM usage count on init failure
      https://git.kernel.org/broonie/sound/c/dcb503f01380
[4/6] ASoC: fsl_asrc: Request the IRQ after the device is initialized
      https://git.kernel.org/broonie/sound/c/ab7cfd1b36a2
[5/6] ASoC: fsl_asrc: Use devm for runtime PM cleanup
      https://git.kernel.org/broonie/sound/c/b4b22bdc2572
[6/6] ASoC: fsl_asrc: Use devm for m2m cleanup
      https://git.kernel.org/broonie/sound/c/0f8ea2391e29

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


