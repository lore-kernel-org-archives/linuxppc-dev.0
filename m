Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74005C433FE
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 May 2022 15:12:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KvHJ23SHtz3c9V
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 May 2022 01:12:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qVTGJpl2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qVTGJpl2; 
 dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KvHHL0m42z3bpy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 May 2022 01:12:13 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 873C261505;
 Thu,  5 May 2022 15:12:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D15C385AE;
 Thu,  5 May 2022 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651763531;
 bh=Y0IuJJqIEp7GuoZ8/5wFaics5bILpDhKmuqI09UXn+4=;
 h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
 b=qVTGJpl21CtUQBcmXS/xmx/XqtlBAbk638DuX90EtnFpySE34rSgEKSkN3MyiXAMe
 vRVDkLuljCq7yUopS4s0z8S31+pcQzQLLaR34Ulm+oNTKPUt3CLhqc0yCCQ/VtuIc6
 BsE9+sdEMBC+6ZqHsro9RKUTt8B3FAemxdYauPpOBRMHwMbenUcr1ONmiRfS+1kz4M
 9OfwHphrwEQH4ItyV4QBRIjlPNOXIJPM17o+Jhn26X6+WqytzcDonQyKQovkZTjTPs
 KS2252mZF/jnZb0rXyPFcGp+MZtPJHXyUv2wi/d/m3OIWlb9yFdmIfJNVOyS0p5E1b
 pZS6vEVqNPuBg==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, tiwai@suse.com, alsa-devel@alsa-project.org,
 nicoleotsuka@gmail.com, Sascha Hauer <s.hauer@pengutronix.de>,
 Xiubo.Lee@gmail.com, perex@perex.cz, festevam@gmail.com, shengjiu.wang@nxp.com,
 shengjiu.wang@gmail.com
In-Reply-To: <1651736047-28809-1-git-send-email-shengjiu.wang@nxp.com>
References: <1651736047-28809-1-git-send-email-shengjiu.wang@nxp.com>
Subject: Re: [PATCH] ASoC: fsl_micfil: fix the naming style for mask definition
Message-Id: <165176352745.543130.8069953691884090444.b4-ty@kernel.org>
Date: Thu, 05 May 2022 16:12:07 +0100
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

On Thu, 5 May 2022 15:34:07 +0800, Shengjiu Wang wrote:
> Remove the _SHIFT for the mask definition.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_micfil: fix the naming style for mask definition
      commit: 101b096bc2549618f18bc08ae3a0e364b3c8fff1

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
