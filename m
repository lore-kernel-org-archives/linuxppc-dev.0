Return-Path: <linuxppc-dev+bounces-28206-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E074AC9830E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Sep 2026 17:10:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrxzY10lQz2yQl;
	Sat, 26 Sep 2026 03:10:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790356233;
	cv=none; b=GcDFhd0pp+GMwXPOsP5tvRDAqT8iVwUBStqRi2JS2X0fyl7nTvOaUS5m8ZORFECT1VL+Bg71C7ihKanfG7D++PVqo7ef1sm6i8ZHYrtruKGWbiTeNKKYKI2l+/Gk6IUxejE3rcMOMwmnhbUePxC/ZY4kmPn8CG/E2gHawfSAi6S8EDLMJnQ0jzkASSZ0MlLaR6Cl96LbAM9JobngLC7FTa6TNjU19A4aEcI1ruHf6UCPZ+dY8pDt+xqNk0M7adgDTMsvlu/46SuX9NXfRAXyUvHl6el888sWT0keKvdRA5V5WmXOMT5BNKRrh9BWzG8+UP2pml9Enyl+YssowdcXGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790356233; c=relaxed/relaxed;
	bh=a947lQXWFeadyoA8ZzQD//GcVJNTHZjVpoL9FHAmVxs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kALBKA6YxGnkZ5s+s6xb8EtzL83ao3m3XGrANVbRmz1erd2af2YbdOxCGt4OoIPDhWwRfxuGYrwI8wjpS7+2aQlMClAivrfn1B+RmMVUp+fACQp4v5rcTOdQQDi1wYyOeetskd/G+JmzkXnn2NWhEaa40Jv0zGyjwwbFUfN0lNnYYR0cWqjIhVWBUSX8uswYR3h0cXZ/i3sAQtkLTL7CNW0yTN5TBY7vMWZIyNzYNfU6BlMd7lZ96ZiRODE269kmY1mL7rDKdezd26+qB4SHPaNWEFz97WectdxXp2+5FxHEAWY2FXRkofrHdYiWgB+LMn8OudB8OQB1P7hgz+u9EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgjFgC2H; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgjFgC2H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrxzX2YM5z2y2L
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 03:10:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C8A4F400A4;
	Fri, 25 Sep 2026 17:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC601F00898;
	Fri, 25 Sep 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790356229;
	bh=a947lQXWFeadyoA8ZzQD//GcVJNTHZjVpoL9FHAmVxs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JgjFgC2HUqN2PMD4+bvirjfcFsiUzN39k6I60NkYatuLekMqxaF9EsIiz+C8VBkt+
	 gxiXaP5cKcNuCn4JhNZ9htRAUNaO2PvWAaZE0vQDTFm4v6k67usU/mDV917Kn7zz01
	 S7i+tUVdMOwsQPWRItY3E/YA5sFE5jvlmHD8WKAny+qYbsP6d5MS4dq94gsMcEuPw7
	 E6M/M/0oos84V3FRZorLESVuMISKyAlADDWe89u1x5sz7L5vcjAwQodnBmTJT1C9rV
	 YQyDH4s1FfmjxziNdhmGFnRbms1aZC3HVrZ9RCoeFTKR/Ho+M0LhtTvQr62s1oi2Gg
	 oR0lQASVozmKw==
From: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, phucduc.bui@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260917121136.32527-1-phucduc.bui@gmail.com>
References: <20260917121136.32527-1-phucduc.bui@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_asrc_m2m: fix pm_runtime usage counter leak
 on error
Message-Id: <179029056919.149798.2550909245601802568.b4-ty@b4>
Date: Thu, 24 Sep 2026 23:56:09 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ygqvb0nlPaV2Tf1xs/WFIsuhcdBhupvBv4nz9MxBXLM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtqsBpL0yr2I9clwK5nMo5F794PRyhj5Ua/Pbt
 1Q7dQ9nrNCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCararAQAKCRAk1otyXVSH
 0CWmB/9jIMqCR7aRiebLCWUIMbe5eD8fiaUTAANBQCOUYWiCn+butoMhZ0tyJiLpJu+m135EaPl
 axwFLp/zKBFgI0Sp2aP/PIVF0rxjvjfCJVhh19i4hh1CxKML1dUYUlal2SmyY9JA6AthEzLki1e
 HjwlFKE1MKJZnCPjNTJ+08dIpvTAxxvII5biSU5UAiEo4/6lM2UT6W3DRqapieQnnteZnS0b2fs
 0Tf4iJYIt3OH3WIjwXQ20hzrMlDCyf0t9O8X46svIISDe25yzlju/gYNZTmDqnBtAjx3Jrhwzwx
 c8Bu2WcEb+2AnptGzWj5oOmPFFHBtm8WzmIDP94gvuZN8EkG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 19:11:36 +0700, phucduc.bui@gmail.com wrote:
> ASoC: fsl_asrc_m2m: fix pm_runtime usage counter leak on error

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: fsl_asrc_m2m: fix pm_runtime usage counter leak on error
      https://git.kernel.org/broonie/sound/c/5626653a4bdf

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


