Return-Path: <SRS0=kNGO=H7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 313EFC433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 23:36:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E6BC60C41
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Mar 2021 23:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6BC60C41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DqGr2602pz3d6b
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 10:36:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Q6kuBlTm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Q6kuBlTm; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DqGqb5qwRz3bPK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Mar 2021 10:36:27 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CACBA61481;
 Mon,  1 Mar 2021 23:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614641785;
 bh=VvLYvJ0aIkonlcmlC5Homj2udF5HvWgNbKU0ABVOuPE=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=Q6kuBlTmclg6ZJDHh3R6WSs/uy43Oa/PTlEJEx62NxwJ6Hrg1wlfZYD6aITbK8Lmx
 pkvRlbXq2zRqDqiOYSGzlLOUq+OQKbhlDSPsgS9bycF2EW+92KnzaCytniLiZDsQv1
 IJ8V6ZR56rVb1iXjpBirW86Ts48pR2fRf3oEEFP9wePKKxQFAk0+FGUn5jSwc7XrIF
 Dvyj4DXIDwaT/mrjZQjDbQOb8LZ8BMXwsswpUb9nQ003v5KM9etA5vzNl+PmzjEuxK
 yyzE6hW+liY5NW1Zc8uQt4B+uf4ViIxo+aPFuQd6fQphQTrZT/BWV11SaLVi98mlcO
 ctf8/ua2IXiWw==
From: Mark Brown <broonie@kernel.org>
To: timur@kernel.org, Xiubo.Lee@gmail.com, tiwai@suse.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, nicoleotsuka@gmail.com,
 festevam@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org
In-Reply-To: <1613984990-5534-1-git-send-email-shengjiu.wang@nxp.com>
References: <1613984990-5534-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: move reset assert into runtime_resume
Message-Id: <161464168098.31144.2631005760387940700.b4-ty@kernel.org>
Date: Mon, 01 Mar 2021 23:34:40 +0000
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 22 Feb 2021 17:09:50 +0800, Shengjiu Wang wrote:
> Move reset assert into runtime_resume since we
> cannot rely on reset assert state when the device
> is put out from suspend.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: move reset assert into runtime_resume
      commit: 0f780e4bef4587f07060109040955d6b6aa179a2

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
