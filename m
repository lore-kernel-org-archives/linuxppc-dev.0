Return-Path: <linuxppc-dev+bounces-24488-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BCAC4452A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 13:20:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3h2T46Mvz2y8F;
	Mon, 20 Jul 2026 23:20:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784553601;
	cv=none; b=g4nuFS2Vdwvkrmn6z+1L/KZrlyqmlZeYG9k+V20jQfHKSt9j1Wd/01Eb+P4qBEXIZPfvNYTdTpajB/qbtZ6JMqSRz1T9modCnO/dNkXF9tzn0+efsrzWHvg+J4JObIjJHucQnc4X3Xiq75C8SmX2gGtQ5eOINmth5sr5aTFOa+qqfLslSHhDtljkvNhzF4Eb/Q4xTdMvXWag44yaruPOFkmhQqYc9x+tYIwINKF7RpF7ZnRXojDl4urmp4M1DRwKZX6NkQmOxnZQI/28OmxA73FlY+5YWcEzaUyVgBvgCqMrXARuXFLMaa/kBfuTB5TXgPFlwnVRQjaevy0Bw8tsIw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784553601; c=relaxed/relaxed;
	bh=2t+YL248Mr9Z837045als8fjyHNXIgMDrmnmORlfQTg=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O1ugH+q0p5+v2JSvlreRhxhVrJToQFurSquiN4y6wyodGa/0Ae3I/FRrNcm4PeDvRqBo0/58k8F3VE1scLM2WU6l0UJDs74dUyuf1F1v7U/FngMp/taG/3Ic1k2GZRQtZSQMTkQAbibo17SDH4JtQSgUQEx4n3XDvMmVhf9bQN9LzbOFxOwgWz/yjhUAgplHFkRBs63wd6wH73drk4dFUowEkFhNYRkCR6qwrqjB+IjGnvk5p8Dn5U1eQ7BDS+FMz0dEMLKfWaWINSx6y/fp8qTnBJZKVC5k86l5cZuelmTY/SMm2ocfiYrjN+Nrxn+t7FAGxgUm+FIGwjKS5VmFKg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxwwIgUR; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxwwIgUR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3h2S44cmz2xlZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 23:20:00 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D4F4C43D9D;
	Mon, 20 Jul 2026 13:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF811F000E9;
	Mon, 20 Jul 2026 13:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784553597;
	bh=2t+YL248Mr9Z837045als8fjyHNXIgMDrmnmORlfQTg=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=jxwwIgURoVT8Vrae3qlAaW7LcR5o7PVIobD/XdPOTz4CM2tSwtqXPABMRe+UVdqwF
	 pUcqxT/2nNlONdKdhaqDKlMHnjuhLvA3FqvL5rl6a5+RHxBQqR3rAYKeYcDsBUhZdE
	 MpLGg9V4n/9UYbomqmqO3jZAhtrDPW504pFmhRD+MCd9auQImkYuo7OPCh7lgaqc8n
	 fL+QCVDIibhy4AT+jLR+ZRqiqB4n4NG6kyqmVtRROS62Ww042ITn063b82W4q4B0qX
	 Po1+UBiL8RUYm54XxyNx4ZI1KEjY++8jnWNW1j3Tg6yJMoHiR5C6gNEh1WnIt+030e
	 7D2osucdgf0ZQ==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, shengjiu.wang@oss.nxp.com
In-Reply-To: <20260715024758.1252801-1-shengjiu.wang@oss.nxp.com>
References: <20260715024758.1252801-1-shengjiu.wang@oss.nxp.com>
Subject: Re: [PATCH 0/2] ASoC: fsl: fix m2m_init error path cleanup in
 fsl_asrc and fsl_easrc
Message-Id: <178449635293.33801.10581976168356848104.b4-ty@b4>
Date: Sun, 19 Jul 2026 22:25:52 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1720; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oQe+beuZjmzwnLK52btt31QnTUNpwWyqi/eN8PscjeM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqXiB6pTfeH6LNKoV/iC6ikxYYZkr8eFjIcm1vW
 jimlyAMHGWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCal4gegAKCRAk1otyXVSH
 0MLBB/9JAkDcAmUamcu/Wge21/eVrvdIpnQ8tAwrM5i7U+Ds2xqzyaqDTKGglD3VbmNdFBtKvtz
 0q7rFGmqGV+BTz50CTgQf+j3Id4WNYRs89CdXnygWTDOYMI8ntCcAuhmWbPu1Y7dz2th727DbLl
 +xYI7lXEmcctUKCYNLUp6xkHR3YACxgX7DKAR3n2NBXkRZEQI9itk2EsJ0euZg6z6eH8Sok2GHt
 O8Q1QgBXtEb5PoYPsYhMagymhcFVavxAZtVQGV/6Tu6MN1jIrtHLkMReXAG65Ojn9YJYFCpqO0B
 yQKtLhAePAL/Qmls3zhQn3psd0+sBuB5ay5VDLGgF30/u2JX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 15 Jul 2026 10:47:56 +0800, shengjiu.wang@oss.nxp.com wrote:
> ASoC: fsl: fix m2m_init error path cleanup in fsl_asrc and fsl_easrc
> 
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> Both fsl_asrc_probe() and fsl_easrc_probe() call fsl_asrc_m2m_init()
> near the end of their probe functions. On failure, the original code
> did a bare return ret, bypassing the existing error labels that call
> pm_runtime_disable(). This leaves runtime PM enabled and the device
> in an inconsistent state after a failed probe.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/2] ASoC: fsl_asrc: fix m2m_init error path to use goto instead of bare return
      https://git.kernel.org/broonie/sound/c/890b4253134f
[2/2] ASoC: fsl_easrc: fix m2m_init error path to use goto instead of bare return
      https://git.kernel.org/broonie/sound/c/a54bc0eef90e

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


