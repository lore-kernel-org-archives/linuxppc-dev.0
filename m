Return-Path: <linuxppc-dev+bounces-25859-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D135C5DF67
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Aug 2026 11:38:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hM0bk2LxFz2y8f;
	Fri, 14 Aug 2026 21:38:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786707506;
	cv=none; b=QKcIrS3HbEhAftzxfPU9mHVxTEBT+N3IaVB6Y7uzv3dR+G87OtiCWSifetS+iFs9Nbsorabe+YL1s78JNJpPZork3IjZvSskRfakU43bolKp3SuBZNBchk6XjziH4RiPT1Ti50kfEoNBUfYOObhO8HoUP23Fo+VtU4TwdWbuEs18TxVcpRSLFZj9kPjaCwvGxXDHl6y7UsRryVyqvg57OT2wFieHw2EtO8qC9ZAPUJg7pCwj/q/WGgSXri4hUOqRW6ouoS9CRDqIgtVx1eG1La4Gr835utFfLLG8n4l156GMd6ZZKqH2rnn/5rNtBX3BMnt2ODDDEWT+o0llfH62Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786707506; c=relaxed/relaxed;
	bh=j9SSgfVEi1vM89znQUmODgOus89Y5kuqP5ErzT8yGwI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ijSQ+K4Ys0f3M67wLx7Eb/D49doFZdS4FQlhugW3M+aJbPkXjGJHYhw0YlKNfvPXcOqWqK5Z8e2EY4O1C9c9AP0Vw/PpeI7Zx0V6QkKOrCJwG7kjUJU2r3NkDB+phapmb2kX1vHkHCHGtI17p/JqUpThe9dWaca3vWgpY55KpNS9t9Eg+NVC1eYw7wHHXpCg1hc3LZ3J3iP58IVm3TOCTNeBLBTkoNTIDNJQouqpMjhXNuYo6zoButcK5RmICSiBLHtg3KvsCvUliry7dL98qGbe+NyX2SxGyInjvL97tVf6N+64PlVngJPDOrsGGIiZpDJpNQkpWG0lKsn/aeOYFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWtoCM7H; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CWtoCM7H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hM0bj0HpXz2y8G
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2026 21:38:24 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 03265601E0;
	Fri, 14 Aug 2026 11:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841F81F000E9;
	Fri, 14 Aug 2026 11:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786707500;
	bh=j9SSgfVEi1vM89znQUmODgOus89Y5kuqP5ErzT8yGwI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=CWtoCM7HA6fwwRqJM9tk2/lXweInJuVzgexG2BtGQ1ubIVR7ZHy7M+Sy6uPmGkROq
	 LDfjo1udV5FUVQgIyppXcWYAEmluhCKZpnEQ0fPHYxr3oYUUedVWl8tS7W8WoLhFDn
	 VotkkpOTlvQCPV/QPQ+jItawaeJqj6etqfajp3b73r2h0/BN3rF80+fvO5ANrD8MBu
	 ULBQFPjo3A6Jce7+p9jiXkI5NtUZSyd1WXV/WGXQBnEjf3LIu5b0B+fk482hW79uGp
	 YFcwzTrttR3iEeBQrKh8r/C6tfSyD/d1ULabRiLnaWs4gGzkV6MNk4qQ9nkY5z6yXP
	 XcJUUNMa6GX2A==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Chancel Liu <chancel.liu@oss.nxp.com>
Cc: hui.wang@canonical.com, linuxppc-dev@lists.ozlabs.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260810093834.1511749-1-chancel.liu@oss.nxp.com>
References: <20260810093834.1511749-1-chancel.liu@oss.nxp.com>
Subject: Re: [PATCH 0/3] ASoC: fsl-asoc-card: Restructure to support
 deferrable card binding
Message-Id: <178663259608.110398.10677098110931666958.b4-ty@b4>
Date: Thu, 13 Aug 2026 15:49:56 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1951; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/zHLYQSI4R4jNfkJnN0lpe2m4CYSoK7MZtGL3F7WzFg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqfv4oJGTz+OlIQjenOGXYeUenggQ/tuAFV1Uk7
 SqGjcz4RQ+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCan7+KAAKCRAk1otyXVSH
 0MUuB/9f4IPXJOVo2DMEnZrv+v9vZKzwkv+FwtAvGOJ3u6GHdzPhfDFsgry26eWVxzMZFqf4nZA
 QXBynbca1mEZQj1QwAcsWiCvclnt84uud1tP98j/9wS6Vw3OKPAdi5V2BPIH0hx2Y/ivcWIE/ar
 yXInRPw78NM6xAu2RCm1ckmN03QsjYJVk4o8SCtyDsrS0HfLJg3DIvivqdVsElyZZlsDWpT0chI
 113r3MHTeFFReXshkfb7t6fCtk+9Qc+zGrMxBl5qxxMOlcvPQu5zFBXErv3xZeEZm1HcL9C2uIR
 MPI8T7FTIUm0eHOMwE6x/+NHPYeOna/xIu82/94V76e/dTbr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 10 Aug 2026 18:35:28 +0900, Chancel Liu wrote:
> ASoC: fsl-asoc-card: Restructure to support deferrable card binding
> 
> From: Chancel Liu <chancel.liu@nxp.com>
> 
> The ASoC core has evolved over several kernel releases to support
> deferrable card binding: when a component is not yet available,
> devm_snd_soc_register_card() no longer propagates -EPROBE_DEFER back to
> the machine driver. Instead the card is placed on an internal deferred
> list and rebound automatically once the missing component registers.
> As a result, registering a sound card no longer guarantees that all CPU
> and codec components have already probed successfully.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/3] ASoC: fsl-asoc-card: Drop mclk management for nau8822
      https://git.kernel.org/broonie/sound/c/4c51a83a4fe8
[2/3] ASoC: fsl-asoc-card: Move static compatible data to platform data
      https://git.kernel.org/broonie/sound/c/76408e27e60f
[3/3] ASoC: fsl-asoc-card: Move bound-component setup to late_probe
      https://git.kernel.org/broonie/sound/c/de27e0cadcce

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


