Return-Path: <linuxppc-dev+bounces-22597-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3243CD98CF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 22:18:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcYnn6G3rz2xdb;
	Sat, 13 Jun 2026 08:18:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781302733;
	cv=none; b=a/BRlAKdlkxjFXCE6rpocPloeYObbfkaWkB3p/TYlEgcV7B60+t1RxfuqYHaMBSneUpSk4jXL+H2HIH9JLk/71Ewsy749QGKpN/1t0AgSucHqZEM9r9UUnv17BzzOIP4+gDdlf/m3uosvgZjQIpXE45VD8ufk6sW/9QDewQ4RVjPNzwk/hIsLEAlYYtiUJzJy04NjaYdcAepDzjO+44rEESg3zaB3XGggKW9aPkmvilLkT7P5P5xc+gCYbNlFvQazxgyykwWnNcDQLpUh0gXAUoHFjVtd4D8fYD4Gpe+vxDeuMZHIycMeGknXqNCYaApxidS6Ue7w8LsDJYUEqB3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781302733; c=relaxed/relaxed;
	bh=+EaqxrR/sV3bOU1Rowx551pwQAzOjjox3enBFC+z/Nc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JW2q/9MiJdrBAhkKJT9IB3sZKOcLa4ahCbuHThjRpstGnOIyo/dZbQ7y7OZr40vy+cQomqjhoz5dN2N9x/4tAKYhd3gfF88t+DeIqC87wxWwNXV+L2WW14Ox9jH1Pl8Kitq5JsOdogo+usAjyYYC8KzqwyD8SlQf9YCjvqWbSs1TFrH0wriuKLw4rgi7bNUEJzqg1YCS4yL4EMRhL4sZsdmmDPDrNscvjnX7YQhSAx7k0Q+ewYPqCxEWo3H7LUkOQGXS/ffNpH2w4HVyC8oX3Tsax9r9Bac69PGNB7Rdoh3LeE+OyRkI00T6f0jF/lLtJc0qAajtkwOlrI82NOYm9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCcjGVU5; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MCcjGVU5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcYnl60Nzz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2026 08:18:51 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4E08243B79;
	Fri, 12 Jun 2026 22:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BC71F000E9;
	Fri, 12 Jun 2026 22:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781302728;
	bh=+EaqxrR/sV3bOU1Rowx551pwQAzOjjox3enBFC+z/Nc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MCcjGVU5k6xblfjlm0hOAQ0LxniK+ioRseQAbGr0sTWq5Lvyq/kScY4vYXkb/bfHt
	 whIPFKbPmP/Ai80uaaYsLEKZdkge2EV9bFQJ8FpSqRvTekmxqA2m4ENfJ45lDWb23x
	 JRoKEzD8PwT3Gi7LFaSUE3fz9rV7bdQPQh8T50fB+l9V4vBBBVOZgZTotMERGRI2j+
	 J/RNWyA2lumXc+UcKfnTHysZq0b5GRmfgSBSt73C0Kqcl+lcjT3N2TQ99nImUGUNVm
	 X4iMalO4cRwCX3tnuh50dZRQ0NYuJVlja1KFyzwDKG4daTUmWSEXpYwa0KIMhdlG+8
	 YIrtwz6f2NHEA==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>, Takashi Iwai <tiwai@suse.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, notify@kernel.org
In-Reply-To: <20260608-asoc-of-node-scoped-cleanup-v1-0-9e3ac518dc2e@gmail.com>
References: <20260608-asoc-of-node-scoped-cleanup-v1-0-9e3ac518dc2e@gmail.com>
Subject: Re: [PATCH 0/3] ASoC: use scoped OF node handling in manual
 cleanup paths
Message-Id: <178127725305.48375.17603847447471691265.b4-ty@b4>
Date: Fri, 12 Jun 2026 16:14:13 +0100
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
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1663; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6NdJ1oXu8X+yrUyYOh3BVEt16gq7UD6K3TfA3IfrptY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqLIXBRNPXenH0pNh+GaHTYt582SCRLiGDStmcX
 CIiqu8x+JmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaiyFwQAKCRAk1otyXVSH
 0KzSB/9EIxR68YF4xkDdQc5qt3LLq490icnYLlz3hS/NZYEltakjL8njExuQ3zcTJBfIUrJCoZe
 V1ON3uZ3j1Ea91FUKsiBqIRNWpfU9cOfYwKdezXVTXFbrtH8oYaas6j/H0fm3C3KFDrcx6OV62E
 veBD3U/6ovNL+EL/marF53J8tw5ujOw6s6ht+U6oO7M/aQqxpT59X0xh0pYOSN8xvvbEC0RIO14
 nE1lO2wTJVHs2UYC1pLy0fuJyexr2jtykNji0JTzLDnobKjHMfIwxzCmM7fiCMq9aeTTzznCM7k
 IlTzJifQ4K3OWu56FdA49audNwYAbb6FUZGz2hV7qyC9/1jV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 08 Jun 2026 10:39:10 -0300, Cássio Gabriel wrote:
> ASoC: use scoped OF node handling in manual cleanup paths
> 
> Some ASoC drivers still manually release child OF nodes
> when leaving child-node iteration loops early.
> 
> Convert these focused cases to scoped OF node cleanup
> so early returns and normal loop exits keep the same node
> lifetime handling without explicit of_node_put() calls.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/3] ASoC: qcom: common: use scoped OF node handling
      https://git.kernel.org/broonie/sound/c/22aed576add0
[2/3] ASoC: fsl: fsl_qmc_audio: use scoped child node loop
      https://git.kernel.org/broonie/sound/c/065df02692f0
[3/3] ASoC: bcm: cygnus: use scoped child node loop
      https://git.kernel.org/broonie/sound/c/9741aad24432

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


