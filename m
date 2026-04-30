Return-Path: <linuxppc-dev+bounces-20350-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B586FF886F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Apr 2026 23:51:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g69tL2fvXz2xwH;
	Fri, 01 May 2026 09:51:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777593082;
	cv=none; b=Ao2lYJD2itL1Yui8os2Kmao5MZgXZlMWqZ/AnjMQqgiypp+kGsRB1ED7alxy25tr8oK5oqrO12ZoY0BUowIONzWxuQfbzI4+CtZ4lmq2SLQz/AK4op5COIF4dJMh6b1Whgcq2NM6bt/JTOLkCRMwwEtsQDuvVQn4Wqyji/bDWaDhWEpgL0Mjb1fgc6sZA+3V5U9Nudnr8kmkbg/8Otz+BbqX1wmYL98YcyceIw1wWy25G9bDJpJOQVbqG0/+LDaLs8KfBv9XIYvYDx21oXmJ7mixktgpwIwlClI4SO6bxDEpzOh9d48cw8+7suzPHtViXmyVv7aAER0073BjehtkVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777593082; c=relaxed/relaxed;
	bh=14xYoFpuwR5otSDhfT9CvCFfzCpLajGdBVkQonsXAPs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G4L4+18EJE01Uey2RfFz53yULUu4UUFQW7/vIM97Lfy/3SoiUX6bsjJxQfRtgO/pem8nVraKfob36+sUncK7ddxu3kz3KubdnxsIHHcuOe8PoXUXF1D3RzTblSfEmuTE1CDhiUwe72kparFnt7QgvtnTA7ab8vP2ZSQB5fTel5h3ktSk5/646E0vvdMEVDtEG/fmfyyH4a1uM1Rtsicesk2KjAsgSpEuplgfycxKVPyn2mpAz40roVcRoj2d2aUB+cSf1Wc6SjnhxTDwv9XehQ9ai78s4qrFKXzmLS2qdYbViQWPBgzOpH5f1iIqpHK47sEYQYB9eHUBM1ljAPbcBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Db15ui54; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Db15ui54;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g69tK1GGSz2xvH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 May 2026 09:51:20 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 5B5B44329D;
	Thu, 30 Apr 2026 23:51:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA70C2BCB3;
	Thu, 30 Apr 2026 23:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777593078;
	bh=JvafTrDOUTNbsv8vnx7ex86phNvggiWY6OT9/LP5/Nc=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Db15ui54483FZjnBZlbUr3eO8etE/4h3okqw9prbMX+bIHls1vUacTn4a5hB2AS1p
	 V+CdHi9+VEsGUJ5hlEeeFYdWiMRMiCko9HT047XU0DjCNu1zv23TOaHiBAoeyne19c
	 WoQy6qm+pRZ13rOvszGCBVNCAjeXizo+lerdRKhy/pypuEUuSMdeRwW2aFzfsrjbcV
	 GttKP0ZmRGoAsq0Aa89wHducoGxsa5KfOzt+JuoGJcbnxy9ihW2/ePliHpMldwUjPH
	 Pd2+lnx+Hgp74Ia6lbuWza2XRDuq5xgjLnl4ALkasLRruTVQIKxQ/gUyUhpIWkb/5O
	 cE8+WkgY1nSZw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260429100028.2739711-1-shengjiu.wang@nxp.com>
References: <20260429100028.2739711-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 0/5] ASoC: fsl-asoc-card: Add some improvements
Message-Id: <177755089814.458539.1076703312564291362.b4-ty@b4>
Date: Thu, 30 Apr 2026 21:08:18 +0900
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
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JvafTrDOUTNbsv8vnx7ex86phNvggiWY6OT9/LP5/Nc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp8+ry5p1Ma8K+HKR46uX6X8vXt0kIWBUXHkhhY
 KgGK69uXYOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafPq8gAKCRAk1otyXVSH
 0NYYB/9uhp3a0I/QRWCOUBDCuS5nPeizCw0iU4HnFAUasL/nl8C7Bsz/LlLkaLndjl7Csw3gvBC
 snPLnSziSlAm8eLfBtY9cv2hZCEpFth22hreez6ipJGeosvgzbGizrk9zG1vDJAPzzUJvT+KIUT
 adzso8aIy6AzOQ7RPBFTZpDjXYtZ+edyByLPx80o9DWzb01nCB3Ohkl82+mvSSU72jJFfWXOa7Z
 JAFlx3MVfvg298MNFLdj51W3ibocimdAf6xpELUQAKsBTpsDkVjtyIZM/IPKrwtZhlBMwBHfDRU
 c8OoJoa3M/j0Oz2M0Kyjwj0K9EwM3MJix9i4nwHzpbyvhWXq
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 29 Apr 2026 18:00:22 +0800, Shengjiu Wang wrote:
> ASoC: fsl-asoc-card: Add some improvements
> 
> This patch series addresses several issues in the Freescale Generic ASoC
> Sound Card driver related to hardware limitations, DPCM path switching,
> and codec-specific constraints.
> 
> The fsl-asoc-card driver provides a generic machine driver for i.MX SoCs,
> supporting various codecs and optional ASRC (Asynchronous Sample Rate
> Converter) for sample rate conversion. During testing several issues were
> identified:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/5] ASoC: fsl-asoc-card: enable dpcm_merged_chan flag for ASRC frontend
      https://git.kernel.org/broonie/sound/c/3b9c088aeabf
[2/5] ASoC: fsl-asoc-card: enable ignore_pmdown_time for ASRC case
      https://git.kernel.org/broonie/sound/c/d611feb52de8
[3/5] ASoC: fsl-asoc-card: add channel and rate constraints for CS42888
      https://git.kernel.org/broonie/sound/c/e78abe395d30
[4/5] ASoC: fsl-asoc-card: exclude S20_3LE format for WM8960/WM8962 + SAI
      https://git.kernel.org/broonie/sound/c/fa7d8ea56c58
[5/5] ASoC: fsl-asoc-card: reduce WM8904 PLL ratio to meet frequency limit
      https://git.kernel.org/broonie/sound/c/99b5316f08f3

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


