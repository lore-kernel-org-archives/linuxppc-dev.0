Return-Path: <linuxppc-dev+bounces-28142-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6F8C98318
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:46:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLqF0HtKz30TP;
	Fri, 25 Sep 2026 03:46:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271976;
	cv=none; b=MBHyaz0v1B/2GI7AmSlA2RFt2BXPrEq/ivh1TmixSqRl4CLLytYX3Yv6wYsfOf7kkMp3CEwCxXzh4zCUaAwdTeUcGF58u5zYjmD6h47j9MpqhGX8pJb9iq0UFLOldmBWFHPZ8cPAjUjopphYSpWRHW5pJd0ARmwbSuukJffafANpXlqJaHjewYerC/45n0Xz6CxGO5+ut7MnEhs57Z0DhxW1ejkN/1AKMsiMAt2ITq4MZDry6nmrZ6j7/z76VZiRFem6Aofp7ZtdXr5druq6lAjESJpYdkcKOsVVsdjEGALPo3u0y8KB2q/xviU/ZSs7KYAQPZ//i51lQTPpyXdAAw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271976; c=relaxed/relaxed;
	bh=jr52o/MyKxapop4cQtK8c+3adSYTJhdKVLABlleZ+K4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LLmhk5fYsgDILkNngedtla3hXULoT4aid24AlHp+FLOncu/ECsy7lhVc+R6C7yMGiZ2xOKL1t1cYafV0lf0JzvxycH38I7m61+1tSFlD6orshUXtKC2BMoNnFwWvquEL72X7nAEnDDxBbuBW4/RSlu4/V18s14vgTll6eso3jV80seGKWhHwEbC+1KpYr6BshZLM6Sq++9GVjmYAib4kdkFfCFE7/NXufyoBa+Qn35vnyAR0ZHUefm8dyUZvfuh3iAvISB1XMYr7Vo7m6CD76ecXU7sTbkEVTUOCpTG1DfCk0W3DhavJsrugdhnO6QxzbLv6N2WwKDmVCZWGMcz8Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldDps6uo; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ldDps6uo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLqC48cGz30TL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:46:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id DB1534344E;
	Thu, 24 Sep 2026 17:46:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CBE1F000FF;
	Thu, 24 Sep 2026 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271971;
	bh=jr52o/MyKxapop4cQtK8c+3adSYTJhdKVLABlleZ+K4=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=ldDps6uo1ur2QkKdm3dLx9Q0sZpnHLoi8HRzYqfafXxTIjwrRjf6oNW1hxQeTltae
	 2TyXWqeYkaJxIHqddmb3FqXy+rYBP7cgHtYmXnHJJVwxEiG7XrIzA/bF1oFaKQuIov
	 J2g5AxW9vt7nW0RzCvXy79OpKB/Ckp17Qj0YL9YLqbjDalXWIHwe1MYuCilNGZ8Xih
	 pSpR6LBzkiIZFdHV7nLSKB+q0U+5sPVStkjAHaQ35njnGGDSHJYFZcGoTZgiTvUAQT
	 E/3i0cYDYH9GkbLv7x7z5ErB3sqCMOZi6BUiehZRrCE8AcszNzBLqoTSK1JpOfxgVl
	 6OlIU7WZ5oBlw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@oss.nxp.com
In-Reply-To: <20260916094043.1496709-1-shengjiu.wang@oss.nxp.com>
References: <20260916094043.1496709-1-shengjiu.wang@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl_asrc: use regmap_write_bits to update clock
 source registers
Message-Id: <179026940256.149798.11432270140920365951.b4-ty@b4>
Date: Thu, 24 Sep 2026 18:03:22 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cHnIesqzRd3SzWjC4c0j6xgj40PQm3/+Hfd6Bj+Xj/w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtWHWNnP1Di16WOvhFepRkg68S1ErVEn3Jj4E/
 EqJHFMmcPWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarVh1gAKCRAk1otyXVSH
 0DuVB/4rWGF+cpqbPdU+ysLLjAs4Q2D6BtM7HEAdkfFe7MJkwqLr6bt2faqf6a9fCgBOkMaPiss
 pHpHV2ObYKOCCHovB+kbIz9HSnZ/EQvrQKFkY5lwvzpoTVfHA9L1NUWVNLBIsJJYS5o/m/LMT21
 YbPxsbWU5fpMlnNQ3jFi8U7YWqmLd567UK9XlkeRSAzC7+HDuYsN8JEswwVVbNRMJ/wbtJl4K6W
 BbW/OKW0dDg7+jMryBL57PXjKgjBdOVSEyNyOdVGCDu0hy4REUBqveTo1SH0TvO3TiqWPZZCKMb
 zFLrl/WTExcRM5HjGjmfJXfuccE+1UufIba2vSsMDTZdHO57
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 16 Sep 2026 17:40:42 +0800, shengjiu.wang@oss.nxp.com wrote:
> ASoC: fsl_asrc: use regmap_write_bits to update clock source registers

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: fsl_asrc: use regmap_write_bits to update clock source registers
      https://git.kernel.org/broonie/sound/c/92871abc1302

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


