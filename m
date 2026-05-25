Return-Path: <linuxppc-dev+bounces-21477-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16C25CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 May 2026 15:38:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPKld5mzbz2xfB;
	Tue, 26 May 2026 01:38:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779723485;
	cv=none; b=LXQm4Q/KkCHpGd3abftl4TIO4m131BzrvGaGVb0bDxrEt7kLlRBjkHIuA6SpBI1nDODRXlj955KJxgYsf2yvhK2aR39XWhQkU7Wkvt9uy26c4LJ4ZWE0mOvLMuD8W096AZJ9bpitulP7AInjj/JMl7HmoY90zmMBa23FYZJvrG/VWVPUHl8ctwbwHC7Kzfw6Z6CPLvM3oQHZZKgq9twESjCNEqmOuphzzjwzpyCNqTiuzCJxRfbPeH6Aq8ha9PIARNY8CWZzlmnSWeO6dY2U6KEgfdZFe5Ye6N3mYN5xq1PfN1u7O3YrPWbwN2pAX8/GwH4ocr95R3VxWmEcC84uvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779723485; c=relaxed/relaxed;
	bh=Rlh+oYV+P/+1/m8THqzUSHnl6pvPwf9k2pk0kwC/skM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=E2HfY6MLKRYqZuZHp1U3s20Q7eKJPAvgkrcCwwLBaQhe2LW/KtmrlkfxO79aLqBLQclTV8cGj3/bUNPxwcYk212CE+quwwOzY6+DgMi8RODk1WCQgcTVVTBZKIn9Xig/2CtCuYS8n39Nwha30tn3iqRNxydZzng0AElyK2QJSFp7k/F2HDJ77ENsqiVWrEHqZeiA/Rthxf5K5oiSZg0cdlV0uZf20QZDNh6U08zwNMCQShMVHtdQxUbYKCARk8eupa8N79L3I3lY6fWEtdgLrFOlJW0DbPEfjE9pL/PKDXtS7eaMw/s2sVhfTP7FSkEmiZ/pbkszQ9CJJshyl2Z9NA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPbQoCK8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CPbQoCK8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPKld02g2z2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 01:38:04 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9F6866008A;
	Mon, 25 May 2026 15:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1F51F000E9;
	Mon, 25 May 2026 15:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723482;
	bh=Rlh+oYV+P/+1/m8THqzUSHnl6pvPwf9k2pk0kwC/skM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CPbQoCK85r7KVUyfv4U3p2wcqp9owjOmyyO5fAqYM2oPq1FvX/QfiYrcOu+6W1AM6
	 UFXIpvmpla6okI91+txKBJ71yoCQi1BdW2gPI873OlOou83eA/4uOJsY/6EUvIbMTe
	 WyMJRvI5im7SPPs7bIx2eD6O4AHuYgB9Bczn7wN+LA52Fae4HIWthuD0huHKBMV24k
	 bEncvArhH8VmdBHA6Qacw4ZsAvNHA3V+Mm1K8qTxLy/qFdt/8RETG5aGikb+aNinRs
	 qoxwhCyF911HpF7YSpddwUDmZREhFaD+Ibsgpp/Gc/fAYbAEu9brD7RZ9XfUKSBmnl
	 lwAXCSo8nnZKw==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, Frank.Li@nxp.com, s.hauer@pengutronix.de, 
 Chancel Liu <chancel.liu@nxp.com>
Cc: kernel@pengutronix.de, shumingf@realtek.com, 
 pierre-louis.bossart@linux.dev, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260507013654.2945915-1-chancel.liu@nxp.com>
References: <20260507013654.2945915-1-chancel.liu@nxp.com>
Subject: Re: [PATCH v4 0/3] ASoC: soc-core: Add core support for ignoring
 suspend on selected DAPM widgets
Message-Id: <177971268540.58460.7539013149269437135.b4-ty@b4>
Date: Mon, 25 May 2026 13:38:05 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mfakf2KSCdA6oLTC+W7ozYHLNIjtRk6O1EZB6UlOvIQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqFGzWus3H0DiqbvYsMNr6AhAn2YhKG9F0iSV+B
 32wu4npHTKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCahRs1gAKCRAk1otyXVSH
 0KcuB/93oLl8Dd37RwlCi7zKXZ0udVgDD24fhItx7pWfOYBluGwUA3VTRlqk9uLajf0/rCnks2L
 x9cGZE2Yc44RmIsPZH7pjx8YRINcTUTnPYeAZzZ11pKZbIyEXofmxlGuullQ943JHpvSPmAfpBO
 pZzP/ksFkeSGl+hejU+Akib6DfjYbibr21CuVMf4aepOEfYIQeHub25jopsyAPWNIhSgdkfxqsg
 OxlHe7xIKOqgpD37K6zXN/LcsDJdNn7aEl6/hFg7185XVZdRKT/7aeJbRxTEjmpeOWUmFDuXfX1
 Q/Fu1mdF+RWX0wrtIVCNhCjnZxtgz52tMLU6dlP2rF4QRTFF
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 07 May 2026 10:36:51 +0900, Chancel Liu wrote:
> ASoC: soc-core: Add core support for ignoring suspend on selected DAPM widgets
> 
> Some audio systems require specific DAPM widgets to remain powered
> during system suspend. Introduce a generic and reusable mechanism in
> the ASoC core to mark selected DAPM widgets as ignore_suspend.
> 
> The unified mechanism consists of two parts:
> 1. Parse and store the name list of widgets to ignore suspend in
> struct snd_soc_card
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/3] ASoC: dapm: Fix widget lookup with prefixed names across DAPM contexts
      https://git.kernel.org/broonie/sound/c/8468c8aafe8b
[2/3] ASoC: soc-core: Add core support for ignoring suspend on selected DAPM widgets
      https://git.kernel.org/broonie/sound/c/51271184a06d
[3/3] ASoC: fsl: imx-rpmsg: Switch to core ignore-suspend-widgets support
      https://git.kernel.org/broonie/sound/c/68bb9a7f557a

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


