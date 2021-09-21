Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A18C433EF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 15:27:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60D261184
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 15:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C60D261184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HDQJx3VrBz3bj6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Sep 2021 01:27:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CBumJ/Lm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CBumJ/Lm; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HDQHj2n6wz2yQM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Sep 2021 01:26:09 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4739061186;
 Tue, 21 Sep 2021 15:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632237966;
 bh=jDRQXGf7gbvv7glyWY+HfhW+JY8gbICqnGlh6IrImGk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=CBumJ/LmMXYS/Jzmek/MV0s4+Xwfg0CJ8SyfnLbcsNpGDlsevkr0K99DhGs3Z69dp
 MZrtXjdv4Iij9RLyIvguQObHDWPXZ8XVgr3kTdfYagbQbM+AulWv8mazC/fsN5+//q
 FgzL1cDEPBFRn859E4MboMinZNwQBCuPZ3D1VMhcPL8aylsIlcEfGn2y7UqU34B2f9
 2rJ6AIsAZR5/TW3ZCZMPq0hSLm7OKFaOehrDmUQm7fTHbkSC8A9ptvL4QEFMHeJi+J
 tRfBXErO17G3sP7evr6LTSEMWWvnJHPfEMuF1eSIAlbPAHeBd59Tk6Pmam2mDNHM7b
 d19KCuXHe8UJQ==
From: Mark Brown <broonie@kernel.org>
To: Xiubo.Lee@gmail.com, festevam@gmail.com, tiwai@suse.com, perex@perex.cz,
 alsa-devel@alsa-project.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: Fix channel swap issue with ARC
Date: Tue, 21 Sep 2021 16:25:11 +0100
Message-Id: <163223651319.32236.15669372544555545964.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1631265510-27384-1-git-send-email-shengjiu.wang@nxp.com>
References: <1631265510-27384-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Mark Brown <broonie@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 10 Sep 2021 17:18:30 +0800, Shengjiu Wang wrote:
> With pause and resume test for ARC, there is occasionally
> channel swap issue. The reason is that currently driver set
> the DPATH out of reset first, then start the DMA, the first
> data got from FIFO may not be the Left channel.
> 
> Moving DPATH out of reset operation after the dma enablement
> to fix this issue.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: Fix channel swap issue with ARC
      commit: 74b7ee0e7b61838a0a161a84d105aeff0d042646

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
