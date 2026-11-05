Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7540B606A329
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 14:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hr3V0onR
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jL4lF0z3zz2xN4;
	Fri, 06 Nov 2026 01:42:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793889721;
	cv=none; b=nvRcikqAac9OuT8mSHvFSagFKWlL5YWL9BHaJiy0Mm3Msk60J2+21OOJolnA96bynjFPRYf0zms78O242STWE/T8TCITgkwPkjMADPLJNmNNYXnwK2YY5g9GZRROoNd+/spv0sk67X8D0xyFaq27niD6+G32wQii+Y5wUD24uPawI+HujB/RcmHCIf8w8uX93u8afEjz2vjIN8kY72ZdYtLR6/ecTaP5EbAVU46ZMClUzAnEkjBvwvMIlSeGHsJ/tS27xg8F7tBFLYPdC8s67y3q8eJUQjobggMd34/6M5TqkKaYUv1iNFVRaGgl8U5xZyBbZpxUYsdxJCkTty2A9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793889721; c=relaxed/relaxed;
	bh=FM0GXu6K3ywCewrFLfc/Mlz2IYTQV7GkWoeDvvAVApY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RyOYEigUZnL6D+bza77hEHGZCp5EkS3AjN2QGq3LR64sw9/Fqm9AIdcZczsk8dn0xEARKCn6L95vqEIHuVueNIUqPbO67Xh9YtIUKuWQVCLXjy/AnZGcMFiir4FIwY8x9RVULRYcFEP9+1xPu0iJv4PNdHQok0fdoTEHGlN4rT7iQhe55klCYDy2CQ5D12pmtWiC7yt2sA4MEY++b92qtSlMLhFSb+h+z28Z5F+SgQpvtwr8IMyb0yi7W0p77c/fjDUdBPV1KU93aooQ+NGDBpQFt/RzcilqldP1yWY2Ghtnp8FZX3cXSqZ2jUUnN7oajcYo5Um0agEC5CNQGNS70g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hr3V0onR; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hr3V0onR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jL4lD2LfRz2x9c
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Nov 2026 01:42:00 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2518D43212;
	Thu,  5 Nov 2026 14:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D741F00919;
	Thu,  5 Nov 2026 14:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889718;
	bh=FM0GXu6K3ywCewrFLfc/Mlz2IYTQV7GkWoeDvvAVApY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hr3V0onRTktBtJzR21B6OPO3ER33IJufrxsPFAG8sRVMqmOCiXBqVEwwJV4mYFmrb
	 csJXkI1xRPkFDlI2k732vjzz4WUQUSVwSBjQTfioNJS36BTkmymF0Vyjt1NsvqBTU4
	 bppwtb37sSiq6LRK8pboFm7Ldr1cehSi2hGHkAUfPagiM3FWq8/fAj5Sig1tRMdAd3
	 EfwDk46IBN/Ac7QzSb3WCoGhQZCdqLT/JXnM2cy9weebFW+tdUk2cTiAXOWrPJh7hZ
	 G2AcL0I29/fuLkhmCzd2Zxlk/vRQClpRLmDXtZ9lpbVL7U7VRSntf5QYPhkDpdrChK
	 4Pd10GbX06qPw==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id E139A2795E7B;
	Thu, 05 Nov 2026 14:41:55 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Valerio Setti <vsetti@baylibre.com>
Cc: linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261104-imx-sgtl5000-cleanup-v1-1-62739fbb4a25@baylibre.com>
References: <20261104-imx-sgtl5000-cleanup-v1-1-62739fbb4a25@baylibre.com>
Subject: Re: [PATCH] ASoC: fsl: imx-sgtl5000: release codec clock right
 after reading its rate
Message-Id: <179388475372.2912885.15403731696986720392.b4-ty@b4>
Date: Thu, 05 Nov 2026 13:19:13 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eKulEu67eFyz/ko+paAxBSfq+R8JXOGf+PgSzd22/sk=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLeTN1cv2BWZszG7LU3G+0+vzsn9DyYTd6Z8WAFr/fht
 7dnZ5182FHKwiDGxSArpsgSl8X9sr7k9Rq+gwvbYOawMoEMYeDiFICJqJ5h+Ge7aWFf+pdNaldP
 inCx5FZ0cSc+Y9ixznK3pNQFyStudSmMDAfOrlilOztjJduNMz9CwmaencU7+dNqoSSDW7bRlSV
 ccxkB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 04 Nov 2026 11:48:35 +0100, Valerio Setti wrote:
> ASoC: fsl: imx-sgtl5000: release codec clock right after reading its rate

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: fsl: imx-sgtl5000: release codec clock right after reading its rate
      https://git.kernel.org/broonie/sound/c/4ab9e4ccfaf7

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


