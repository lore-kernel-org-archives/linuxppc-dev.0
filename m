Return-Path: <SRS0=NZKl=CM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4378AC433E9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 13:54:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 825CD208B3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 13:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRjwlLgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 825CD208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bj2Ng2cgyzDr6P
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 23:54:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=RRjwlLgk; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bj2GM5pb9zDqnD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2020 23:48:59 +1000 (AEST)
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1D3092071B;
 Thu,  3 Sep 2020 13:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599140936;
 bh=JvSw5khXq0xtDTAtXhZfqiB6ak5kwj1ew7cgvmtjRVM=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=RRjwlLgkVyNA1+lGkllIRjLOtghwygdJX88Pp0V8ohS3x9GEn+WOekQARcLnrRwLB
 QR94hCSGT/pKvyVpFhbh0oZBLpeGczIPLNFqkCRML8fF2igkxx4s0mfmBXw9Jolfwd
 KcUgd0tEYZlMnk2Kj0RZ4qS0ZKzewYj0U7rzAEGg=
Date: Thu, 03 Sep 2020 14:48:15 +0100
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, tiwai@suse.com, timur@kernel.org,
 festevam@gmail.com, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 lgirdwood@gmail.com, perex@perex.cz, Shengjiu Wang <shengjiu.wang@nxp.com>
In-Reply-To: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
References: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Support multiple data channel enable bits
Message-Id: <159914089549.45733.4128299430192434595.b4-ty@kernel.org>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 1 Sep 2020 19:01:08 +0800, Shengjiu Wang wrote:
> One data channel is one data line. From imx7ulp, the SAI IP is
> enhanced to support multiple data channels.
> 
> If there is only two channels input and slots is 2, then enable one
> data channel is enough for data transfer. So enable the TCE/RCE and
> transmit/receive mask register according to the input channels and
> slots configuration.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_sai: Support multiple data channel enable bits
      commit: 770f58d7d2c58b8ff31d3694ce14a785c2e75009

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
