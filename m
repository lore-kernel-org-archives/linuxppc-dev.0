Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52069606D82E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Nov 2026 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWZwv2VE
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLgSX6WcVz2xJR;
	Sat, 07 Nov 2026 00:46:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793972780;
	cv=none; b=KlzcZMiVeK2+2w5pne2zYEqf9w6xBDAr3M1eiaNGZJyQu8wvzJgsclW4+ZWzXjnKI+dEcnxPbPZ4eMNrhJm0CjWWGUlczqgdIGXCP1Ligjk4IZQLGSSAV7NYWl5eZNlPQX1IfyvNbA+pV7Ldykw8ZCDwpyeSScuT9wtKBfJExBvf5Ufy3L52QvHkhIR0xFOrUm0I3g23tiCRrrVdPQDi79H7Yb4oD+c/t0K1BjEEEhSMkIXXgDdJaYwmiNoqXT6HTYwFdH7R2VvgEJHx7TqHG2APm9OpRHuyK6VPq7/0xKVbQqlXa+zPrrw9kyhc/mYm23xMcR3+vcsJ633nljSgQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793972780; c=relaxed/relaxed;
	bh=iDsyrIN4mZculiTS5AmByyttLMOMNQXJMKtfP25bG1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mueQlI+qUVBue/Sx+sQzAeeWZSobFok4zx1/pcjVBa6Fh/2ZFMhdPivBmRe6wTKI8tFgtkLtYKYP62tpZZrzr5MQoB+EkcjpZYaCCtsmw6AJa6mK/n7kt7AEFDlpMtFYCaH0Eo0f61K4K/mZfUkEuOlqP+vmKeLGRhny7RCNJ7CreoEAHzojdyiDu1NaGYaHuFz/yMrMOhemvMaXjFDVgM4TWp2WDhfEqNJiuqIvGOgjweu0x5LrkIlEB/bJfr+8JD/X/N6nCvdgk+SyMoMM8bEXhOrhPHgx4lnoyIiPQXKk4hM9mc0pTProC5ks9E64TF3Qjjk1uYyuNUTCJEwx0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWZwv2VE; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MWZwv2VE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLgSX2WNpz2xDD
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2026 00:46:20 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5412B60204;
	Fri,  6 Nov 2026 13:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0781F008A2;
	Fri,  6 Nov 2026 13:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972777;
	bh=iDsyrIN4mZculiTS5AmByyttLMOMNQXJMKtfP25bG1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MWZwv2VEGt0XMcOoPqh3mKeGfPDWbCTkigunUTHYeEz39BCNklKppef8h6ZG0QoGB
	 6AqQXA/sUcZXTu4rNfw0U4KGGAplpiFgHMEFY0oZ2Ig+qRQyfuqhW/FYUI3DweE9Ws
	 B7QTcoFXk2aDzPULLckj4wFAgCbrvsIlnhEgk90mEDwr1pDI/2DUs/UVmymXkgS794
	 Fu9JveoYfJKcbMXPSGW8SXs7skziXAJfOkoGsVoFBv2g/UmRernumA7vyC+JogDE6k
	 DZRCFVrk9OcPQX8gzuQHZ38PZ9Qljb3FyJYd9AYKLg49oCOATQqCYbunLwpDh3D8Ux
	 c2wAdcSIeBgcQ==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id D12D2280806D;
	Fri, 06 Nov 2026 13:46:11 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Frank.Li@oss.nxp.com
Cc: imx@lists.linux.dev, vkoul@kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20261102195228.4084438-1-Frank.Li@oss.nxp.com>
References: <20261102195228.4084438-1-Frank.Li@oss.nxp.com>
Subject: Re: [PATCH 1/1] ASoC: fsl_asrc_m2m: use dma_chan directly for
 dma_async_issue_pending()
Message-Id: <179396622411.3073895.524075215689851221.b4-ty@b4>
Date: Fri, 06 Nov 2026 11:57:04 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EVk8b0z1rHRoz3MIB0/Nrsjmt1o79+EPuJj844PKyO8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLe3lI2dmUo6K6b5F0jZSrCy9g5aeJs2bOn2IvzXj+Zs
 cL/v2tDRykLgxgXg6yYIktcFvfL+pLXa/gOLmyDmcPKBDKEgYtTACbyYjYjw12WvMksj+/n33jI
 khW6xfdv84uY1k9Wu9/H9bv1vV51R5PhvxePHkPQnoId+lZJztPuTX+3/eC7zyfXZTKtnno55ZX
 BEyYA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 02 Nov 2026 14:52:27 -0500, Frank.Li@oss.nxp.com wrote:
> ASoC: fsl_asrc_m2m: use dma_chan directly for dma_async_issue_pending()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: fsl_asrc_m2m: use dma_chan directly for dma_async_issue_pending()
      https://git.kernel.org/broonie/sound/c/28c0e86dc8f3

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


