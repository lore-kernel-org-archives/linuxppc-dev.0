Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC4AC77B73
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Apr 2023 18:26:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q1q4g1XMRz3fSj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Apr 2023 04:26:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CDQvHa09;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CDQvHa09;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q1q3f3QWTz3cf0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2023 04:25:50 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 3AC5F6417A;
	Wed, 19 Apr 2023 18:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADE1C433EF;
	Wed, 19 Apr 2023 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1681928745;
	bh=2P38Dw70hIslqESCsP4xROGp7y6M/3NfsY5sjrm73kc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CDQvHa098OUr1TV+UYmGrjfxifLo/RGveTTYnTeR6EbI4whpre6POiH8WZIEoYCUs
	 SbKSYpcb7j0Ovj8KoEu2B/SQcXoRCQxCvJE9OlhofYZEMW4Ov0km+NRxLoGAZm9Sh3
	 L0S7b2F0fH1KvR692twl6VSdpPcnJo5Fa7mQHGrxhLoXsLDXFjvynHtGSqDPqo3s9o
	 xIV5+PwIaZM9bKV7S/r0c28xMBBLGgW44usD9vNJHeTKlTLhNC/mYXtngjQBTGOFwU
	 2zinwSVQbf5Higgr0d7Gr+wkVA1CWh8RbyBjwgziBfRYOltTtMJ60clU3rOGcUABFK
	 9i7F+w/0JL5ug==
From: Mark Brown <broonie@kernel.org>
To: kuninori.morimoto.gx@renesas.com, shengjiu.wang@gmail.com, 
 Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com, 
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com, 
 alsa-devel@alsa-project.org, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1681900158-17428-1-git-send-email-shengjiu.wang@nxp.com>
References: <1681900158-17428-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] Revert "ASoC: fsl: remove unnecessary
 dai_link->platform"
Message-Id: <168192874180.115075.9783971012630228095.b4-ty@kernel.org>
Date: Wed, 19 Apr 2023 19:25:41 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00e42
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 19 Apr 2023 18:29:18 +0800, Shengjiu Wang wrote:
> This reverts commit 33683cbf49b5412061cb1e4c876063fdef86def4.
> 
> dai_link->platform is needed. The platform component is
> "snd_dmaengine_pcm", which is registered from cpu driver,
> 
> If dai_link->platform is not assigned, then platform
> component will not be probed, then there will be issue:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] Revert "ASoC: fsl: remove unnecessary dai_link->platform"
      commit: 09cda705860125ffee1b1359b1da79f8e0c77a40

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

