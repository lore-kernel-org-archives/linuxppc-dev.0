Return-Path: <linuxppc-dev+bounces-25556-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC79C5AC7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Aug 2026 11:23:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGhbt60mdz3c2h;
	Fri, 07 Aug 2026 21:23:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786101818;
	cv=none; b=owqZ/QTtGrrsbUe4piVVegBQ+9VzgkWiGPOFLcU3bhj5gSB6atad7hpzjbt6PIxhuNX6adBZJIYjxd0sUYmHX0kG1aO5NDLd6tTS8LjWRxePBTZA/OGfby2fxRR/y0m5EyjMom+gX46rcwNcTDoun9a+COELDNShIDX+mqxCzt8M0gavAPo22cc8yEiwKaWAZroLdDBD4CI2gx9DGD3heDCibSWqDqRWWEsd0upK+EyOauHNNzUVROcLwFMDGGG1KdFl5yieITMI3Vab0CV5zFlrgamwYWFnw8IlcPCOqpDe8BqvdUIFpkbx6Q/2LefOrsjsrHzNKOBrSfVqjsIisg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786101818; c=relaxed/relaxed;
	bh=699H45A2iPpxasY+wnOMwM5tjBzqlO4RpGKZzkJ5rJU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tu6tNHBClZcClGKCCgoTkb9xBBNnh12Db81mDMqDQkxsj1x3OyDQpxr81/qUYzbNc+4zSeQGFlxnsg/mhDdzVWEHgHe6c/pTekUIuauOvgBVzG4LduS7ssfve8kJJQeZ950Gb2stAMLx0cmuah/VlVDrGOQfGq/H71yah3cAtC+ktEhrwpvp6XHFbmEbaUcYR3zYQICQJntHPHALoF4yt+8FLeS+ynHHe3QX0bCGm6BgExecpp0hD25Ws+Uj7PsoNRsSgcn66rLI8eCdjd39WoyrIljsLwSynB8NKtlCoNotTYVhb9Ysk1vA4SaLwgUlEMLO8r2f2DsogSidluFfhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0JNvV6h; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N0JNvV6h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGhbn4Cp2z3c2P
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Aug 2026 21:23:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2282440F23;
	Fri,  7 Aug 2026 11:23:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE161F000E9;
	Fri,  7 Aug 2026 11:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786101807;
	bh=699H45A2iPpxasY+wnOMwM5tjBzqlO4RpGKZzkJ5rJU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=N0JNvV6htGawT/B5vayTpYkFpbe3BQ+nDMpdIksAGMgnFF9fyhfXP7wb1CdLhR7Tc
	 PXRMdzkEcrmGwkbSlLjIAERokzhXpeL4JFUn5ffe8jhafnFihbOzLtPZzl3tI264Vi
	 J4y67LOPmAQZTGXRWGrjpYcgdWKk4A4y2p8aScCWQidykYgCJ52hPHJQe2GIQmAf04
	 XfpH8XvXRoExVwm9lMqJN4L5fOuyO/ifvBkmupdB44U7c80s9Ix9NcAEVjXDtWp1B6
	 Vp78kl3DCBWCAIn1OX1MEJUo848IaoOYIbDRIMg3SCsWoCQZwprNyLBnZJGVZ0y1fA
	 s1RVu8VmwQqVg==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Shengjiu Wang <shengjiu.wang@gmail.com>, 
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
 Nicolin Chen <nicoleotsuka@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
 Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Maciej Strozek <mstrozek@opensource.cirrus.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 patches@opensource.cirrus.com, Srinivas Kandagatla <srini@kernel.org>, 
 linux-arm-msm@vger.kernel.org
In-Reply-To: <20260715000525.739874-1-rdunlap@infradead.org>
References: <20260715000525.739874-1-rdunlap@infradead.org>
Subject: Re: (subset) [PATCH 00/14 v2] ASoC: clean up kernel-doc warnings
Message-Id: <178603329617.110757.8414658386958684033.b4-ty@b4>
Date: Thu, 06 Aug 2026 17:21:36 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3370; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OV/V973rY2VzoYom28bsLm+SIt8t5Q3Wb7iYo1XMtbE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqdcAquCuKnvC6x5PlSLxAvAOlP6wTV7v0lUvUh
 qUQObxaoQ+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanXAKgAKCRAk1otyXVSH
 0NLNB/kBgCLbkPA+EsR5OBwTXUNge2H1GiZaKAXOYkAeovcKXs2QkjM1XRzTiAp+QkYPrS7gJ2z
 MUKMzWOMot/Zk/gR+Cftn/CVxHl0PWWxE+PuknlEirSF847obfUMWACl73b3CnNipnwoaptfsJc
 aKKY6FE1YO1vL9vLEvZF+uCGw6wx27NycWtNnRm4++hg/eIk3a3UlJR7IHfR30xlpLAC1ngYCpc
 +chyM/MWGb0gnhZjfA9uqwLhXinKiQrPAlI1V0x+Z31PLAFrbep4y0hnYkxmYtw03bL8pFJ2LCK
 EpSSaAxR+9y1aOlfH0CVJ1V2OVmMois/A81DZpwc/mL6Myry
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 14 Jul 2026 17:05:11 -0700, Randy Dunlap wrote:
> ASoC: clean up kernel-doc warnings
> 
> Clean up a bunch of kernel-doc warnings in the ASoC code.
> 
> v2: add Mark and Liam to the cover letter email
> 
> [PATCH 01/14 v2] ASoC: codecs: NeoFidelity: repair the kernel-doc format
> [PATCH 02/14 v2] ASoC: fsl_asrc_common: fix all kernel-doc warnings
> [PATCH 03/14 v2] ASoC: fsl_asrc: avoid kernel-doc warnings
> [PATCH 04/14 v2] ASoC: fsl-dma: fix all kernel-doc warnings
> [PATCH 05/14 v2] ASoC: fsl_easrc: use struct keyword on structs
> [PATCH 06/14 v2] ASoC: fsl: mpc5200_dma: use the struct keyword for kernel-doc comments
> [PATCH 07/14 v2] ASoC: fsl: mpc5200_psc_i2s: avoid kernel-doc warnings
> [PATCH 08/14 v2] ASoC: fsl: p1022_ds: repair kernel-doc short descriptions
> [PATCH 09/14 v2] ASoC: uniphier: don't use "/**" for non-kernel-doc comment
> [PATCH 10/14 v2] ASoC: SDCA: correct enum names and add a missing struct field
> [PATCH 11/14 v2] ASoC: soc-acpi: fix all kernel-doc warnings
> [PATCH 12/14 v2] ASoC: Intel: Skylake: convert SKL_TKNS to kernel-doc format
> [PATCH 13/14 v2] ASoC: qcom: audioreach: use C-style "/*" comment
> [PATCH 14/14 v2] ASoC: wm8904: don't use "/**" for non-kernel-doc comments
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[01/14] ASoC: codecs: NeoFidelity: repair the kernel-doc format
        https://git.kernel.org/broonie/sound/c/6d29372998a3
[03/14] ASoC: fsl_asrc: avoid kernel-doc warnings
        https://git.kernel.org/broonie/sound/c/a4ed0860e3a6
[04/14] ASoC: fsl-dma: fix all kernel-doc warnings
        https://git.kernel.org/broonie/sound/c/11c3fb527b8b
[05/14] ASoC: fsl_easrc: use struct keyword on structs
        https://git.kernel.org/broonie/sound/c/6a59c9a79aa0
[07/14] ASoC: fsl: mpc5200_psc_i2s: avoid kernel-doc warnings
        https://git.kernel.org/broonie/sound/c/728b72e10742
[09/14] ASoC: uniphier: don't use "/**" for non-kernel-doc comment
        https://git.kernel.org/broonie/sound/c/f881c12ca1f0
[10/14] ASoC: SDCA: correct enum names and add a missing struct field
        https://git.kernel.org/broonie/sound/c/ff322994c76c
[11/14] ASoC: soc-acpi: fix all kernel-doc warnings
        https://git.kernel.org/broonie/sound/c/62f85ba4023b
[13/14] ASoC: qcom: audioreach: use C-style "/*" comment
        https://git.kernel.org/broonie/sound/c/c53d7302023d
[14/14] ASoC: wm8904: don't use "/**" for non-kernel-doc comments
        https://git.kernel.org/broonie/sound/c/c185ef7749d1

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


