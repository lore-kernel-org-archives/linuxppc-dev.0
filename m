Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FD0EB64D9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Jun 2023 22:30:09 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CnNz6mVM;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QlPbN1bWBz30ft
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Jun 2023 08:30:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CnNz6mVM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=broonie@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QlPZJ2Hrfz2ykB
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2023 08:29:12 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6854760EA7;
	Mon, 19 Jun 2023 22:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1966C433CA;
	Mon, 19 Jun 2023 22:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687213747;
	bh=H00mx55kuat8LHbKg+m1U0otLiA7SnikJsD1uUzjQeY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CnNz6mVMqm4dIS1eU4ZFW/Lj1epriJPXJzQgcjhAjLLMY9STCAfSL2aqOaZvdbz+4
	 /EYge/j6NomUrA4i70IZ3UcNrsmnHGxVjphVmbuPuetKDtvOMH+EAxZe1qLnyLQKaF
	 ejhq1yZlIkrzlhQpTTe/1yKx16x7sU2u/V86iEfJwRrjbakt8DgNv34i/54d8zl7CD
	 us4GXsjsS5MBCZ2NyiScvuUqGApy1tpElSo+G8kEyYXiBCsGSsCuds20Ibh2okARkK
	 Cte2Q/qilfGHyZCuxah7WRHpRKaBoGLxllOfZnh7ty40pDK4RjeYhtnngeXv0QXPvJ
	 5pEUfGFaNVWpA==
From: Mark Brown <broonie@kernel.org>
To: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com, 
 nicoleotsuka@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 linux-imx@nxp.com, viorel.suman@nxp.com, 
 Claudiu Beznea <claudiu.beznea@microchip.com>
In-Reply-To: <20230614121509.443926-1-claudiu.beznea@microchip.com>
References: <20230614121509.443926-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH] ASoC: imx-audmix: check return value of
 devm_kasprintf()
Message-Id: <168721374438.200161.9016810536762850752.b4-ty@kernel.org>
Date: Mon, 19 Jun 2023 23:29:04 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
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
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 14 Jun 2023 15:15:09 +0300, Claudiu Beznea wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory.
> Pointer could be NULL in case allocation fails. Check pointer validity.
> Identified with coccinelle (kmerr.cocci script).
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: imx-audmix: check return value of devm_kasprintf()
      commit: 2f76e1d6ca524a888d29aafe29f2ad2003857971

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

