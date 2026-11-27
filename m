Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660F8606A32E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Nov 2026 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHom19kF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jbHg04F3kz2xqh;
	Fri, 27 Nov 2026 13:39:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795747148;
	cv=none; b=fWr/ljLb7xe4SchM/eKW3aMAjzue5ahQ8F5yIijTx+BzYwNCEyBYD4hW9PZdn9qdJWTm4l4x8L9Mo0DmNLKAjWA9PjX5ujb/ZGgxR/bm+7EqFbMELEuA3czwPPWKwgaPot0Oh6GHSfjOZvGzPHkKYmq67tBEejt80SG72tU3qQF+spCgqC8IDC6GcAqFgc6OT5q0CaS1VMwaCRB6p/D73UyoBuQTwBj1CibnK1OJ11VzHb57s+wqtkjGTW8HXwwrNma5epD/6eDfhA1P/k3VlT/L7lJ/JOc67CjhNbQ/z/tnaqpdxMNkRlQwrv/aSoh0K+dd80vUMnDtkB7y9svcgA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795747148; c=relaxed/relaxed;
	bh=oGd50g5o08JPxcNGE0WIJIlu9E1Y0uUS2DPxcUBSf60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CzlgM1TtGDhVUTzzT4YIEJXVQTp/nCtL47bOviymypPuzVVp9JvmEYRewLhVU4fslUDDpUNea27lYp3acoDuitQ7iCKZlDbkrjZeZRgEntH2rJOEw6/KCqzB/INdUfR5rIvDGxd9cTCUAMkg/Nk83JMghjYBdM2CEpd1GM5IkzK3qtgylwCxKG9ktHh3oMZzXzVoZftkPD8R9VvloYhUfx8LO433otL7Xe0wnZwp0u0W3sfLiX3OPRtcSto7mKOdxjzbHAryxoJ9t8TmefpOpfQEFH+m4gohfetHhY3Ecu6kupNMEZrKvBmNlyzhS5C1LN6gpyW2xUNcrq0oZGsQSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHom19kF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VHom19kF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jbHfz2ZmMz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Nov 2026 13:39:07 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D511961190;
	Fri, 27 Nov 2026 02:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04AE1F000C1;
	Fri, 27 Nov 2026 02:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795747143;
	bh=oGd50g5o08JPxcNGE0WIJIlu9E1Y0uUS2DPxcUBSf60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=VHom19kFh9mS7761/vdL+Jkeb7YmQspR9FrQTkJcnoHYbec4daq38/AAYG5e/pjoC
	 a82gU1ClCudXRW9ugz8yWiV43y4Azpws6cyN1vISiVqyeCMJ9PNBdiTOvqiu3zuJMr
	 l4iq9sZePePxmXbK/WCzE/LrlC2i4qXqzPo7Bbx8OaLNrqvUVIOW4HX8zGTa0sgAFx
	 TE4Cg39YYY01rHdGYNFURdf/nqYHXIe7RGZPLhUSd3YalWDCSZnftqkI+HBMa7SLmN
	 iJb9JKhIiN94BdGuwgiyZ6yfyovWSca/zDyzPvBsvrgBBQOne6aRid55gie44bD1ja
	 +d4u3ejUwXPwQ==
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Manuel Ebner <manuelebnerli@mailbox.org>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261126203039.1777085-2-manuelebnerli@mailbox.org>
References: <20261126203039.1777085-2-manuelebnerli@mailbox.org>
Subject: Re: [PATCH] ASoC: imx-pcm-rpmsg: fix kernel-doc
Message-Id: <179574323628.838304.16154354505846881981.b4-ty@b4>
Date: Fri, 27 Nov 2026 01:33:56 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1088; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aYCkCEky3OrVydiPJIsbcM5fL1XrqTwwc6hTqbmIseQ=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI53jofNYptM21xz7088UhV6VrfsMKjLMEZ25a2nvwfy
 PDJqsCxo5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABPxvs/IsLJz4ZNXqa2Vaq5y
 zl+EP/zY/mOV9MGAO1mGL5PP7BNM+cLIcOzhpf702U++zZuXkqbqs89p+59bWRfdYzX+uy00fBO
 Uyg0A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 26 Nov 2026 21:30:39 +0100, Manuel Ebner wrote:
> ASoC: imx-pcm-rpmsg: fix kernel-doc

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: imx-pcm-rpmsg: fix kernel-doc
      https://git.kernel.org/broonie/sound/c/2d69cae40cf6

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


