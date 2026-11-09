Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC13B606A31C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2026 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8veV+sm
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNf5167Jbz2xWt;
	Tue, 10 Nov 2026 05:51:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794250277;
	cv=none; b=Hy2+iApImsHwvASPHIxMjVea8ZxZrGK9rpti0PAJ72xrnm5qXWpL8ZVNNDNL1tw4D9b9bmq5goF1eVrukG0sFHT5FAVpODjO+N4n05qFoVX89KD6rw07vpfd3VI5p/n3LUx5VqvuxQ782d7o0tD9cPReKfNHBx10XGBA317kfzHExn/yJmOvr4JLQbE3l1yGc1rQl6v5RXknL5HqnnTxax+v21yRU69TQmd5qyCzWBKbkUwFNNz5vSWGCzsMz0YSzZGkQtj4yOj3TxhBMzQZfBjGegmAORHut/O/bH6KJPyocT6+IoBVJ1eImwA84Hkqt+CjrLYLyFzBIAV+/+PV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794250277; c=relaxed/relaxed;
	bh=04MCtVZmlwiBs9vcUce/ObNuwxitxH4kYS6YKmZb4Gc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VxL1aCuNs52xA28FSBvoUdR1eSabEDOparVoDMU93RENTvJ8KsK8QB9j2gbi3nWKlwWroy0jwot4kFA4RdJBCacbsPD5bR4Z9y/JuUm9aVONNOXz8mQ06p/BtMjx4yfx+GxgNX0KPnIYY6pFk0PIRlpD1bSxk0mf0I9rAa01pBhU60zZRFEnHIqhtqSF8gfT2rBuYJvaJuliYX77FFfEjopBEt/RQleheYi7KAwABIUjItbPno2tTNxsyG//czqkt7/xzeQAOuYs+yVhZwPbG1LbaTvuPrcrLPqleHX3xyDrDvVWfSjSaWysc4w1tEAhIcAyMjUxZAe0sI63yPuejg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8veV+sm; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d8veV+sm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNf505W18z2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 05:51:16 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EE21744DC8;
	Mon,  9 Nov 2026 18:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985B11F008A1;
	Mon,  9 Nov 2026 18:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794250273;
	bh=04MCtVZmlwiBs9vcUce/ObNuwxitxH4kYS6YKmZb4Gc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=d8veV+smqgRDY2qvU6Op9/CWZdLUa7sLQFe8thMfU8j7JpTS3XIpYvacf+PJUxM8L
	 tWS2S+MBjVbz17OU7C7tvtq8bli0Wr8Hdm/38c67HqXqQzPnRxPI1sW9s5a8b3d/Dp
	 gVA7qzmIH0JBPwuJykppspgKyT9y4jAKuqIAEkwywwvXGhLGSKqoCmAh8bsBUOkvmO
	 lOB+HbJS6XCKpIxYZ6tY687kF8Tzt+AstzfcmsGwx9WHA68p3Q22M7d20SHHBVau2C
	 SUQpheOXC4xJ61pxiOEUCv7lOb8m1gRipRrll+QHJVIhdR0f0EC9cKQ32tj+nWvGYn
	 UC52+ARXsDrlw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id E87A22F535A8;
	Mon, 09 Nov 2026 18:50:34 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Sen Wang <sen@ti.com>, 
 Frank.Li@oss.nxp.com
Cc: asahi@lists.linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-renesas-soc@vger.kernel.org, imx@lists.linux.dev, vkoul@kernel.org, 
 Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20261106-dma_sound_cleanup-v1-0-5eb8a7b81e87@nxp.com>
References: <20261106-dma_sound_cleanup-v1-0-5eb8a7b81e87@nxp.com>
Subject: Re: [PATCH 0/4] ASoC: Use dmaengine API instead of
 chan->device->dev
Message-Id: <179422835746.3711751.8137830978577011930.b4-ty@b4>
Date: Mon, 09 Nov 2026 12:45:57 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2033; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Dr9RhZEz40c3IT2UO7hdspYOyzkFqwQqUdbRqgdf+l0=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+iX4LexY0TcB2UobJ81PrtwTUFv3+N9lx/9Nzp4/rT
 iifknHlXUcpC4MYF4OsmCJLXBb3y/qS12v4Di5sg5nDygQyhIGLUwAmsvsaI8N357WnxbJUo725
 C2fKPOV57MnzLvbjxYt3Mr+duhjwZnccI8MKCU47ZWnnVTfVBO9+mLRy2sX1C39s8ZBuyLKpO/H
 s01sGAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 06 Nov 2026 15:13:44 -0500, Frank.Li@oss.nxp.com wrote:
> ASoC: Use dmaengine API instead of chan->device->dev
> 
> Replace open-coded chan->device->dev accesses in ASoC drivers with
> the proper dmaengine accessor APIs:
> 
>   - dmaengine_get_dma_device(): returns the device used for DMA
>     mappings; may return a per-channel device if the dmaengine
>     supports per-channel IOMMU mapping.
>   - dmaengine_get_provider_device(): returns the dmaengine provider
>     device that carries the of_node, used for device-tree based
>     channel filtering.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/4] ASoC: apple: mca: Use dmaengine_get_dma_device() instead of chan->device->dev
      https://git.kernel.org/broonie/sound/c/69d9cfe10445
[2/4] ASoC: fsl: asrc: Use dmaengine API instead of chan->device->dev
      https://git.kernel.org/broonie/sound/c/5aacfc0388c4
[3/4] ASoC: renesas: rcar: Use dmaengine_get_dma_device() instead of chan->device->dev
      https://git.kernel.org/broonie/sound/c/77c4d4f760d3
[4/4] ASoC: ti: davinci-mcasp: Use dmaengine_get_provider_device() API
      https://git.kernel.org/broonie/sound/c/2a2c53477627

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


