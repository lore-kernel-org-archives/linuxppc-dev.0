Return-Path: <SRS0=LJle=LI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A69C2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jun 2021 19:55:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E1E611CA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jun 2021 19:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E1E611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G3hyJ1y2Vz307f
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 05:55:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ODI9FQJY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ODI9FQJY; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G3hxY0Vjsz3015
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 05:54:57 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F76061166;
 Mon, 14 Jun 2021 19:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623700493;
 bh=9BrKXrQD+oi74tGWcEiEkzvbIWYd6bnHC+gYS3fPliA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ODI9FQJYo22izIiQbHH8d6ufa0jnMTDljnAEcK2Gg/EfeOm2dKocNuE4FPZzNqT1T
 zUNVWg/lm/3+dYg+EKEI1+gu2873WF7ksIHhIP2gEoR5mxwhgJELN33pgEvUtcyyyT
 C/k1zOIVX2vg4uOjc3MfDWaztg80AQe0KTFm1I4YJBeDMYKk7eJ4gTMCoVlkJfIhlM
 BP7z6GjNQI4JLzuA5tt+QCOHfSPSgPoQCLyttWfNG1EDwv0eHCUwiWV8eZm0LAylPS
 fCnT+mVnAYx1WPWPVmIme5CVTCPG8nF5Qbo3/kG3f7AYMKBx23RjYeYNXJvV6JgqJs
 OLgERF4IEGRmw==
From: Mark Brown <broonie@kernel.org>
To: timur@kernel.org, tiwai@suse.com, Shengjiu Wang <shengjiu.wang@nxp.com>,
 alsa-devel@alsa-project.org, nicoleotsuka@gmail.com, festevam@gmail.com,
 perex@perex.cz, Xiubo.Lee@gmail.com
Subject: Re: [PATCH] ASoC: fsl_spdif: Fix error handler with pm_runtime_enable
Date: Mon, 14 Jun 2021 20:53:44 +0100
Message-Id: <162369994009.34524.13362380080934583613.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1623392318-26304-1-git-send-email-shengjiu.wang@nxp.com>
References: <1623392318-26304-1-git-send-email-shengjiu.wang@nxp.com>
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

On Fri, 11 Jun 2021 14:18:38 +0800, Shengjiu Wang wrote:
> There is error message when defer probe happens:
> 
> fsl-spdif-dai 2dab0000.spdif: Unbalanced pm_runtime_enable!
> 
> Fix the error handler with pm_runtime_enable and add
> fsl_spdif_remove() for pm_runtime_disable.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: Fix error handler with pm_runtime_enable
      commit: 28108d71ee11a7232e1102effab3361049dcd3b8

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
