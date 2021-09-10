Return-Path: <SRS0=wfsy=OA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3152EC433FE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Sep 2021 16:10:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915616121F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Sep 2021 16:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 915616121F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H5gnP5gwmz2ypR
	for <linuxppc-dev@archiver.kernel.org>; Sat, 11 Sep 2021 02:10:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dxluCGT0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dxluCGT0; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H5gmj56fHz2xtR
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Sep 2021 02:09:25 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8424E61207;
 Fri, 10 Sep 2021 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631290163;
 bh=NAdHDVgWOlnGUIEsitFUU7JyMJqE/TRMT6To3NgX/WY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dxluCGT0bYGZFNFZc85+kqYpMMa0oSSx6DNqXX7YihcTVNTGe7Vdu90gLK4t067S9
 1qqEytrA1vk7vaYdpMp8z2teqlcndAbpD8lbdzuNKJEYlr/MCeGazHlO2XeMoD1Vju
 zqHXBGaR7//552U2lQDB3KA/dFOcTuprLUs4RkHRqK16IfR6Ob6a4FfW2fylcmrtfD
 /D3J8FfVsVTsC4aiDVJvQodQ28gUMa1A40zJM0eF5U8EFJHrEWuHI8rAhUL/Wa0+w6
 dU0qlvOP7IK9SDGA0MVX4bM3v4kN1dcFAwS8ZpbVw96jx2SbJSlthTi6iPfqkdTvuj
 UTvGrdegzUnUA==
From: Mark Brown <broonie@kernel.org>
To: Xiubo.Lee@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, alsa-devel@alsa-project.org,
 tiwai@suse.com, timur@kernel.org, festevam@gmail.com
Subject: Re: [PATCH for-5.15 0/5] ASoC: fsl: register platform component
 before registering cpu dai
Date: Fri, 10 Sep 2021 17:08:43 +0100
Message-Id: <163128974014.2897.9681301071931751805.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com>
References: <1630665006-31437-1-git-send-email-shengjiu.wang@nxp.com>
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

On Fri, 3 Sep 2021 18:30:01 +0800, Shengjiu Wang wrote:
> There is no defer probe when adding platform component to
> snd_soc_pcm_runtime(rtd), the code is in snd_soc_add_pcm_runtime()
> 
> snd_soc_register_card()
>   -> snd_soc_bind_card()
>     -> snd_soc_add_pcm_runtime()
>       -> adding cpu dai
>       -> adding codec dai
>       -> adding platform component.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/5] ASoC: fsl_sai: register platform component before registering cpu dai
      commit: 9c3ad33b5a412d8bc0a377e7cd9baa53ed52f22d
[2/5] ASoC: fsl_esai: register platform component before registering cpu dai
      commit: f12ce92e98b21c1fc669cd74e12c54a0fe3bc2eb
[3/5] ASoC: fsl_micfil: register platform component before registering cpu dai
      commit: 0adf292069dcca8bab76a603251fcaabf77468ca
[4/5] ASoC: fsl_spdif: register platform component before registering cpu dai
      commit: ee8ccc2eb5840e34fce088bdb174fd5329153ef0
[5/5] ASoC: fsl_xcvr: register platform component before registering cpu dai
      commit: c590fa80b39287a91abeb487829f3190e7ae775f

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
