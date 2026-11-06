Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997E1606A336
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Nov 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBxpWpXD
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jMJ1w0M8yz2xwM;
	Sun, 08 Nov 2026 01:13:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794060835;
	cv=none; b=bwCMoIykxCz17uiHUQcj+puD92pePF6gaGAuQhACFI3WnZGeXuJkJaK8rWSafR2sJZn9HbFICuWWoMBVyC5FXsGgeo4fV4S5vhe6qflqYJ4RjkssnJ0xwbG413lJMLnGhk2oY0E5+FlCABVjSmQhdGvLV0lpB8CGUrqg9sqI7IlLDYrBQdMOrdDttanG+lpoAkPyK8GVuz8aFMfdIM5DL8NinrEsQfLq+0z+nJL34KOMOHokGKdZeZAkMS484N3lfKgC2Vgeng5bRYiBlQzxRSpBHrSgTzyauq2+VejNPt2qC7449/f/6U/1K8i1tJeYMl0lZbFLKPZ83i0esxdN9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794060835; c=relaxed/relaxed;
	bh=BjDAo3PfR3trTZ4CT+21HMF0w5JupT1Q/iWjhnR1UgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e995DKwXJeYoOfwCrrRQN/w7/VOHvhsGvZqluBGBI6dfq9RhAN4PMU+JIi3BDJo0u8lUmW3OAGvKQ5Jc4LpalLcqmiysq1MZeSI1Ed4Qkzl7Xcv6Lg/3hAZfzLmVzZCVFQAAKeWTjt5bMtPkwlH/EduKmC4HuqOYcPQvTnzhyBAzgiJAygevO52B+9sukhVNgKQN9XoaGyWM1Gc84mROp3vEHJitb4IV20753atHK/Qhb6U4IZe6oLxOvjCJRHFbz/1uIY3FXs6hzBd79QqmH7uowWF3aR/Apbw9cQD1e8OM53mD+eWf3c2zQVzcXZ0FU//wkAildsmo5itluPex4g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBxpWpXD; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBxpWpXD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jMJ1t1MT4z2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Nov 2026 01:13:52 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 84E0760145;
	Sat,  7 Nov 2026 14:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3741F008A1;
	Sat,  7 Nov 2026 14:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794060829;
	bh=BjDAo3PfR3trTZ4CT+21HMF0w5JupT1Q/iWjhnR1UgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bBxpWpXDc/ka98UhYYRuKTi6hB9mfnPgIDAN9FsGUgOhbi3u8DhOsvekzUpunnH1F
	 skmlwDV5sBsHq7E0qj5+ayegWZML9kTpRRr2+Tlx/4M9tgG3ZziYUuNBdr6AXNPMeS
	 vm0OvDyaJPm3yGkk5j4TD6fenitVLMaOIplVJL3c/dq4c+Ndv10bm1+ZCnMU2L1coP
	 i2efFgFSp5IM1Yr2dYr14sVfJ+wXrVSPMv/l9dMM5biOMdxhWxYwLOqeY8zRIrL8AW
	 vjaQX5dPgzbUuNdJsivC8mDdRY1/u5lKu2lhr5bYP4wcAEZadrK1+9taipIaRTbTJx
	 ImP4avQix+Tsw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id BE93629E6A72;
	Sat, 07 Nov 2026 14:13:44 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, linux-sound@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20261016023912.3658714-1-mhun512@gmail.com>
References: <20261016023912.3658714-1-mhun512@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_esai: Disable reset work before suspending
 on remove
Message-Id: <179397763038.3231166.2110222144709277815.b4-ty@b4>
Date: Fri, 06 Nov 2026 15:07:10 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lNxfmr3kPRt3PVCFU3hjz9tLlDyGlMqmwRteiKLR7nQ=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeGwllqTpnSBf3KK+dduXwzs0/+Ri2JdycGp59+E+27
 a1DxczbOkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRwnaGPzwXxdyCPp1Jm7/j
 u8+dzrnnjPZfTurWi9D5+ziu55zqaW5GhmdTtR/WuAo6L2kVWWcyw/LoF7fsB8nzA2tuXt36/I1
 5GD8A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 15 Oct 2026 22:39:12 -0400, Myeonghun Pak wrote:
> ASoC: fsl_esai: Disable reset work before suspending on remove

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: fsl_esai: Disable reset work before suspending on remove
      https://git.kernel.org/broonie/sound/c/b72f6bb43dec

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


