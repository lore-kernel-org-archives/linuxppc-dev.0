Return-Path: <linuxppc-dev+bounces-28199-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBB4C9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 10:16:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrmnS4mZQz2ygX;
	Fri, 25 Sep 2026 20:16:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790331372;
	cv=none; b=GL9pSuduIBUE63lrQrLOSdAuoE2qHgxK/7R6NGnzkJtQeNrEHl9k+FRzXkxThp4Ku4SKcjHF1FX9SjWMA2FjnxI4IF1nez1IT/CraWB0l8OB0ud9mfeaIzSsqBQNhq22FcuDFQXH61PS7aeg7NffckOBBsVCqOAQ6a3/ocB2/1l7fuElC6EbdPikKGFdUqQdLZlZme5S2/WqBhWoTXkEq7Ri5NsXOjK9tB4U694M6h8ZLIMNGSQQyPsDV8gm7VUJ/Jz7VRkV2zeLviIlXKEA/P+g+FbI+jpFKdI3unbO2jySQn9EL32/BeWOmdW51C5SDx2TLXqoPNTGcbOFlaD/aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790331372; c=relaxed/relaxed;
	bh=M+vBDpkP85SOhgMfPHtkH9MMpFsUvijVL1VAyC6CrHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SyU5T9S0T0aqsZOJExvQ+5P63e+LZu2seCdTja/+ceOg+EUZPukKqj3G3dNTn9IgJ4bJUOhjU9lgCQBwgPQMsp1Fy3d/7rtW72NJVokZUapvxDA0EOonLEsjFExKloO6CKtDBxNWURqQyeAtQ9ynvus8/6t4zAbE1pcPXA9HbjRzAgHnetkpRxR5+jGOtbAJOBH+FY2z2FWybQggjzkoevWpsInhJ7uHZ2j257rKI23iW6EMqBeNdtTuqz//CJaIJWRi/OS8lePmeEdk3dgmGQq1pR7pEAylCHyMw7mPZMPXFyN4Wza+TdTWCQgUZNQWyAUDdDRou3v6/bTDiu90gw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvR8IMlB; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvR8IMlB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrmnR5KfNz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 20:16:11 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C490643CBA;
	Fri, 25 Sep 2026 10:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E7BD1F000FF;
	Fri, 25 Sep 2026 10:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331369;
	bh=M+vBDpkP85SOhgMfPHtkH9MMpFsUvijVL1VAyC6CrHM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fvR8IMlB4je/GfgVEEoXQFbK2Q/DJFuPLuikBHOFtGk9HrrZwvDyBb4DL4oOp5xJw
	 kLNFP+1M5C35wxxe1jPfztcdVes6W8EeKCz83M3cXUvMDg+Sfmj5vvWVKtFWqcJc3W
	 mowmQ482ecFln1yhRn1Id1olv92FWFhugoUV/Fdvs4Pz5V6O38ga8swApzixusZlcI
	 u4JdCxW5eOgiUPfKNqaIxHvPc+YiiiGdQyCqoDvcREO3WebP6gZys7C3SS98iqbp8/
	 Df/0rUd7BhjZye4xzBBubOxpIDl7aZULAwu7qUkV40HEA5zgl3QKPe45xj2GxSE5Gi
	 11Bqe76eEgPsg==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, xiubo.lee@gmail.com, lgirdwood@gmail.com, 
 perex@perex.cz, tiwai@suse.com, Slavin Liu <bolin.liu@seu.edu.cn>
Cc: festevam@gmail.com, nicoleotsuka@gmail.com, linux-sound@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260913125147.109920-1-bolin.liu@seu.edu.cn>
References: <20260913125147.109920-1-bolin.liu@seu.edu.cn>
Subject: Re: [PATCH] ASoC: fsl_asrc: check the second front-end DMA channel
Message-Id: <179028904061.149798.13069346951239387977.b4-ty@b4>
Date: Thu, 24 Sep 2026 23:30:40 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1124; i=broonie@kernel.org;
 h=from:subject:message-id; bh=iUO2JpnXzlAInWi8HTqSgcPDVX5U8rPRjdvAHI4MNHA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtknlTqkxgc8EuTdMZ2N0h1vMz/mdcCdJv8Mxt
 n54N7wtw/aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarZJ5QAKCRAk1otyXVSH
 0NK5B/9Zyjl5+h0lBKOOrT5R1v94ccmhe4sOX94NrIq13oUq34jWwSIhp188KV/FCAizYQ5i2mM
 9sqOKCUUvoNa+MRcpYE/ivCDMZLSiMfz8IDhkXoYOE1B4eFQV0+nIuJaVPu6idvcsnuIyO1MGR8
 ke5xroUf/cT7nBKoAQBblSgzhfbMHVwp7wy5mYVkvemnBz2crtgRAb/Yrc+rf1HU7APXlz8oVz9
 Iuy4EolSzeEUHsQ1efj55CWvjxZoqszxKloNkrtYbEo6lSOq0xbzZf8v7maDt8wd1owXOwfp+Xi
 EW0QY0MjAP9/MPWdJp32nN6Z3xWbi83FJmJ/rUNCqLl/cQUO
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 13 Sep 2026 20:51:47 +0800, Slavin Liu wrote:
> ASoC: fsl_asrc: check the second front-end DMA channel

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: fsl_asrc: check the second front-end DMA channel
      https://git.kernel.org/broonie/sound/c/b4136c0d69ea

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


