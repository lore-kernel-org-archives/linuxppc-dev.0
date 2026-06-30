Return-Path: <linuxppc-dev+bounces-23223-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7DE2C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 15:48:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqSHQ1djKz2ygW;
	Wed, 01 Jul 2026 01:48:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782834530;
	cv=none; b=B1jMoSQndO9HNH1ITVzLDFlq/CTqnQZafxKEabTimvEzarRO1qERqjCdkdpy2Zr01+PjH+4IevUW78VRruHSZ8TxmSx7x4aHmxojgttI09E1RFFZHm4DdCNmjvSsAdzael1q5Q5i6Fw2jP5K5hkDm+tAGRneJmTrD2dnsp2eMFPAzGH0UUj+W0NvxvhV0/qZ0RKYK/rJF59Zt+4hjyKh3hMPGLeHez2TMcWcvjoBOIpdCcZbU42JMkqI+U0jOnpZvYQmdZFUhskoxMKhriSgNVR+nxf48N9ZsCTL4cGi+0n0O7/tpc4C7G/eS60TFW//0z3yJyQqw10ILEgCiSaVGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782834530; c=relaxed/relaxed;
	bh=JEdAb7i3p9jcNPTGjq59Gx81l9oGmp3CfR/lob9t6b0=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JHCct/6RkjbF+CqivkytuT6sa0q7G3IUUDEWK4ZxYiL0irviPRosdZ9S3eDe1AJGau2H5J9ZAF3lZp4grZFZR6+ApC9LNpoTaov48w1P29+K8XfMYocpZrEv9Nc0FWB7QDQJNpyJfLEf86HWYOShMn2DUucIxE7xzQP8czMkP8Ijka19inGvXPUDFvK3NZjk2rSn50lI+6p39aStenqDBAqq9/xGZ6JssiuH1IJ0172w57OUEAx5rrtEYel5dycXN07yjMGFov/nf52dX57bsGaf8RqCfAQbtFHZa+Uknd96FShdzqAOfwYQ7WL07ghGNNAjDQMDpd3Wa39REmYfXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwuIfhQY; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PwuIfhQY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqSHP3Xtgz2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Jul 2026 01:48:49 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 84BC843EE1;
	Tue, 30 Jun 2026 15:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563351F000E9;
	Tue, 30 Jun 2026 15:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782834526;
	bh=JEdAb7i3p9jcNPTGjq59Gx81l9oGmp3CfR/lob9t6b0=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=PwuIfhQYn+oGld/V+jRk3xsLNzI8bNAFWxJlR7K+EBy4uSefqDaMqfNLyEd/qX08I
	 Wmpyolexj/uS3hFcwpz/c/YInNWjqWdfrKu8sGSN1Z8gGgL2FhDtRdMhUE4YO8sAkp
	 DFq+hdi6c2Z8hF5Yc3o7q6y7d7/fGJogKo/ehs7jfOV2cOyWftvOajjB+GVfHe22Xc
	 b9x906fcC3K49QJaozPVaIwmKgR7qfwp7fF6YdwdB71jnbtdwmQ0h36IYT9LUQIR0j
	 P86PE/xEAxIyfenqcuU7Mm2EZ9MgmCrrs8EDhpwuUW5a1KOMDJvuvouTuE8rQZYYkg
	 KT7IXvcqcpSKw==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@oss.nxp.com
In-Reply-To: <20260618023818.31618-1-shengjiu.wang@oss.nxp.com>
References: <20260618023818.31618-1-shengjiu.wang@oss.nxp.com>
Subject: Re: [PATCH V2] ASoC: fsl_audmix: rework runtime PM handling in
 probe
Message-Id: <178281881655.79320.11807000273254095957.b4-ty@b4>
Date: Tue, 30 Jun 2026 12:26:56 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=broonie@kernel.org;
 h=from:subject:message-id; bh=wrgw7PEI2SME0SIe+/+sf3Pgi5LbBZiVWr3BFIpyt80=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ+VbSQ0f1/l/eNXE/WsYXI8ysXU8AzJYP76Gx
 qvq40ZQy8SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakPlWwAKCRAk1otyXVSH
 0JjBB/4/XirGMLI4edb7qrYmO0Fvcu+gMGCaxbbH6s7GFxHarKHpo30waD5sDH5ZPNgHMmUc8MA
 qvAcjn0+8HPkdB1y+4nySvW8XIb7d/cNpARrAHiq+J003dquAkaRVdPfYCUmIK2zvMTfLsowAbM
 MyHqIfN+EzDUL1vEBjs9M2wMvNhDfLYtLOYuFHrpRu8XPMhb4/D/wZGTyzC+OQ9SRIPR2yc9xY/
 YHyoVDATs+nIKZ+gv4nJKuesZ6UkrHU1FaOqaIzV5T8ugGe9++1C806e3+Lt2L4rcTdNCg6ol1h
 bXSbkrlc+rX7XU7fmvBprqPH00qgAZYhpolFT/6khTk6f3Cz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 18 Jun 2026 10:38:18 +0800, shengjiu.wang@oss.nxp.com wrote:
> ASoC: fsl_audmix: rework runtime PM handling in probe

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: fsl_audmix: rework runtime PM handling in probe
      https://git.kernel.org/broonie/sound/c/3359ba93d01a

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


