Return-Path: <linuxppc-dev+bounces-18128-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D80106ACCD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 17:35:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWvrT5Hw9z3cM4;
	Fri, 13 Mar 2026 04:34:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773336889;
	cv=none; b=ieaRmVu0eY1JaD6yvRxwBQrYD6FDZVrfHFT1dUfLJhuA3SpR80/x5OlxEQyM7w66l0x1ck/LcCh2PRt4eW9QBNhggXgz03lfwuoG/jSqljtPefM9l0eDgAwweV8ZQxV/YgR/SwdxzgOEuu4rZDUjhtuN2NoT8SXCMWSzqjcvCHAylCSs+VVRDzq8zUjTpHqrLX533QCH3avg7UgLFkvT/RBEu8M8QWZtoOUZmMJ1E8bSSzaGBskeKahog9G3T3gOxndxHwU7f7ozyFhNjZpLT6qDJGx2ol4MhBF72vRakwA2xuCWtt6eS21LSJxCTwlJBw7cBOeepdNrUlVGqhZ4fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773336889; c=relaxed/relaxed;
	bh=sjBRZPBfPtxn/CCRDfk1DaRPxCe/fVxqblUBFgX45ew=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IgCZLZ0NMJmJPZy3I+rnoZ363JM6u0F8WDiNJUESiA0EmUH4dxafyQMZGP+rbSFOXW2rxgFeHtmGMMzPHzOjdm7kQZHKSFW/51iiB97748sirfPf37WLlT/wWyTfzpLYBeqBruG+LFvIW8dg2Zc7VzetOarCbcX4qlnGIkGV1E9cfwOpxTqpm97//MPETX30er/5teTa5ml4OOiomr7FrRBWffbD2dNbDlG3rorBP5xSnJJnmL2Fct4g2zO4BTHHrTAqQepC9sEPExpw9iR/dFt52+wetco08AkHMhaDFPKZGzTLvfB5a29dHGEbnj6QcOiBLRbfElKn3gxtCYq0Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WKb+WTyh; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WKb+WTyh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWvrT2157z3cH4
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2026 04:34:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 788AE61337;
	Thu, 12 Mar 2026 17:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BCDC4CEF7;
	Thu, 12 Mar 2026 17:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773336887;
	bh=+sDX0nZTz7G3iewP7byXnUpGAi/xcHABbYOl+PvDl7w=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=WKb+WTyhLLO226hEa7IxsGIegwpL6r5ihWpMvvgkVAzW5WEHXo/TZn5EDmvOJNHjp
	 TQ3IuMXMwWZ+jKzPTNhKB90YJ7yKK8pRFnIj5rlLISZT9aG+gjSIgx6kArfugmX7qX
	 yjVPVF1BqoUntZVDhrlgkEKJbyvg5mHKyL70fCHnsWgk/OXiZLY3ld3HnSE8ASr/89
	 uqy7OCwcDHQS1/buno8xP0DCUhRbTrvCn239+Q0DzUiE9zWo8yKDwQV6CT4F3UBCNW
	 kWBrFM6FsIS/tuFrgygguYgO8SSUAGa/B2+0IpSXrBnRR1zKY92ZlM3w9vtMIsEkhz
	 +nxEda8vB2ACQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <20260310104235.1234569-1-shengjiu.wang@nxp.com>
References: <20260310104235.1234569-1-shengjiu.wang@nxp.com>
Subject: Re: [PATCH v6 0/3] ASoC: fsl: add bitcount and timestamp controls
Message-Id: <177333688509.302961.7348877736206320073.b4-ty@kernel.org>
Date: Thu, 12 Mar 2026 17:34:45 +0000
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
X-Mailer: b4 0.15-dev-68380

On Tue, 10 Mar 2026 18:42:32 +0800, Shengjiu Wang wrote:
> The SAI and XCVR have the timestamp counters and bit counters, which can
> be used by software to track the progress of the transmitter and receiver.
> They can also be used to calculate the relative frequency of the bit clock
> against the bus interface clock.
> 
> changes in v6:
> - define FSL_ASOC_SINGLE_EXT and FSL_ASOC_ENUM_EXT, which are
>   SNDRV_CTL_ELEM_ACCESS_VOLATILE.
> - return 0 in fsl_asoc_put_volsw, fsl_asoc_put_enum_double and
>   fsl_asoc_put_xr_sx to avoid control event notification.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: fsl_utils: Add snd_kcontrol functions for specific cases
      commit: 819cf1dc01ce66b6906d403a6925c4bd754a7a1d
[2/3] ASoC: fsl_sai: add bitcount and timestamp controls
      commit: 8e27987a208029c39da7a787bd9f1217d42011a5
[3/3] ASoC: fsl_xcvr: add bitcount and timestamp controls
      commit: 7b3f8db159f710d432c4edc024fcefa9e62e8b4b

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


