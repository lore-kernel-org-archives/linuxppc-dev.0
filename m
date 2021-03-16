Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C70C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 18:00:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1059650D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 18:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1059650D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F0Lg31XCSz3bnS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Mar 2021 05:00:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oPFo3HEm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oPFo3HEm; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F0LfZ4lGnz303q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Mar 2021 05:00:05 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87EEA65133;
 Tue, 16 Mar 2021 18:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615917604;
 bh=HoSgMtiIiSAkVpHOLGFLlZiBQhF3CTEX630pkOg0tF8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oPFo3HEmTj7fXwVlPAbg2/67boHFQ5fn1riyjzHQVTcmIIJrMvgNBFL7gMO3M/3gk
 OhqnVkWUr+LxO1vWgXl56pTnORZXAzS9SBHed9ZnJVw3uHxKvzIx5MtJeBGY2AObkB
 NlB9edqAUyhPMwjlRdYk653y+ScwnxxDQxSwhoechPZlTpdHXCL5UD8KgPuCgtsjKd
 JjqIlm+yajsnVIjEup91KXVa8fD5P75eo7POnhMqVL7FJCG6tu5RzVUVM92re0+iCL
 0HKUT8AL0T/w3ZwcBBE2QYiKp643CctO1emtQ7vYaG2ecAy2GlVqZkSAaQ6xIex1Uk
 QbCD9IE5jc9NQ==
From: Mark Brown <broonie@kernel.org>
To: Xiubo.Lee@gmail.com, linux-kernel@vger.kernel.org, perex@perex.cz,
 timur@kernel.org, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 Shengjiu Wang <shengjiu.wang@nxp.com>, festevam@gmail.com,
 lgirdwood@gmail.com, nicoleotsuka@gmail.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ASoC: fsl_spdif: use snd_ctl_boolean_mono_info
Date: Tue, 16 Mar 2021 17:59:43 +0000
Message-Id: <161591744696.13544.5081763572355349115.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1615887736-31217-1-git-send-email-shengjiu.wang@nxp.com>
References: <1615887736-31217-1-git-send-email-shengjiu.wang@nxp.com>
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
Cc: Mark Brown <broonie@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 16 Mar 2021 17:42:16 +0800, Shengjiu Wang wrote:
> Remove redundant code and use snd_ctl_boolean_mono_info
> instead.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: use snd_ctl_boolean_mono_info
      commit: 6ad864ed6ac50f11a6d8575fda79991cca8f245c

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
