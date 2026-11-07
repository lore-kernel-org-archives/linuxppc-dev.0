Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B4A606A32A
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Nov 2026 13:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvN+ldnk
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMvJr6qmmz2xwM;
	Mon, 09 Nov 2026 00:43:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794145436;
	cv=none; b=MSDB5R68RDTJvf1jFLXf95Lq12ocbn37z25W86gWz4Y/9GfBlTf0VYNK+ObDLADxUurnE1oc9QAYOdWy9ut2NZQeDwFmUyj85hfrxBp9NyP6hQaggJ8F+5L+hLeqFe9/93WBc+avz6ljzh9MPpUiJaatKuWe5TDKlhgUWLnUu6XHZVtFPFqkXn7SzltmIAwtYlhMNFV5ODtnKGQrjNQMRAAnoXc4LwfQ/k0H2kP1trQTQQ8rYV1UGQXWmeyKvndMMcjgQg3YSOcwnesVkVZE6lku3HzqH+XS9QgJ+IhVXrPbMp2LdIU4BF2giX3+LB5n+xzN7DztQUFwtk1dtKWrPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794145436; c=relaxed/relaxed;
	bh=FiqicRgGFFmdN/zUTJYuWA333LJrRHYqatW2CdxXaWU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HZcIA9l14TVH7ng9Y0ykdwT472YE3m1SAMqcmpx+i9WjxshNexAhyoS2waOjUbT9jgw+iBeoM1GAo2P95TujGKmM5nAwJS10/X170kIl/AEmUSNE/TpMYRXxLzxS0DTCJpfnRas6qh8jTnBgI6ZQUEA4/llhbhVaBknvU05yaFGHP5GWcd4ojCPSujNeahQK3+e/aHFiH62slhTxbo5LVGYL711EzEhLywW4uzfPmd1Dacy8Ep+UDxHrmhuXhEYJEKZTp23PaCHdo8OXUWr3q75df8QPbhkvuus6RrNaDAqmVQvSILS4fiy2DScyZOFuLI+8HLOofyWoduBv48sPGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvN+ldnk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvN+ldnk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMvJr0LKsz2xYw
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Nov 2026 00:43:55 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BA2BE43C0D;
	Sun,  8 Nov 2026 13:43:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC751F008A1;
	Sun,  8 Nov 2026 13:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794145433;
	bh=FiqicRgGFFmdN/zUTJYuWA333LJrRHYqatW2CdxXaWU=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=IvN+ldnklVfjckmSa8v/QBmd3v4Z/h2SyprJcN8nMSkNov+9JghSTnGjC7m+ZqaGK
	 O0pg5F4bG3Y5jc4VumpHbnK2/IpD/J/X2aV0CmRsZkEpCBvJOvqM266hlHvLV7ZrOa
	 TAsJ8h1VKevss4Qsmw6dcJul/Mvtdl9IHnko/5aa+U9bBFvoNJFNgq16xYOXaqBUYP
	 sX0I61z5q+5di8ttgvUA24pTzmXC1ItwZrMKqJSgriNVD1kv3nAjMPVGr936vAaGQX
	 GldAkOxQagVI+UQ5NKRA0UC3KkqmmhEPpsfN4rusG7/rHQT13S2NqbzaP7XvUj8PTH
	 MyIg6naQNStSg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 016582C79261;
	Sun, 08 Nov 2026 13:43:50 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@oss.nxp.com
In-Reply-To: <20261028025921.4155551-1-shengjiu.wang@oss.nxp.com>
References: <20261028025921.4155551-1-shengjiu.wang@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc_dma: fix error handling for DMA channel
 retrieval
Message-Id: <179406738653.3424803.17185079246753708576.b4-ty@b4>
Date: Sat, 07 Nov 2026 16:03:06 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qfnAP/FwyAoEO8cGoqqKsMFVyL4j6Nx5ZrB7pkI4f/8=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+1Ex10njipqc4P6LqndxP3c+KrFMfsVySiJUonaVxz
 TXu2WGmjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEwk7A4jw5mpvguslvEJPwqu
 u3CX/23AlOioh536alK7f/LO271hWTfD/8zr3PsF9+xT+lvMUrO366vSgSUXZmaF2B94LWduaxI
 1iwcA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 28 Oct 2026 10:59:21 +0800, shengjiu.wang@oss.nxp.com wrote:
> ASoC: fsl_asrc_dma: fix error handling for DMA channel retrieval

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: fsl_asrc_dma: fix error handling for DMA channel retrieval
      https://git.kernel.org/broonie/sound/c/1f18d4babdf4

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


