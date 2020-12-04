Return-Path: <SRS0=tbgD=FI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0487CC4361A
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 23:32:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25DC022C7C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 23:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25DC022C7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CnpsV4tPSzDqwP
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Dec 2020 10:32:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cnppv74xczDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Dec 2020 10:30:31 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: Arnd Bergmann <arnd@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Timur Tabi <timur@kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20201203222900.1042578-1-arnd@kernel.org>
References: <20201203222900.1042578-1-arnd@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_aud2htx: mark PM functions as __maybe_unused
Message-Id: <160712460213.7629.13692802144415827947.b4-ty@kernel.org>
Date: Fri, 04 Dec 2020 23:30:02 +0000
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 3 Dec 2020 23:28:47 +0100, Arnd Bergmann wrote:
> When CONFIG_PM is disabled, we get a warning for unused functions:
> 
> sound/soc/fsl/fsl_aud2htx.c:261:12: error: unused function 'fsl_aud2htx_runtime_suspend' [-Werror,-Wunused-function]
> static int fsl_aud2htx_runtime_suspend(struct device *dev)
> sound/soc/fsl/fsl_aud2htx.c:271:12: error: unused function 'fsl_aud2htx_runtime_resume' [-Werror,-Wunused-function]
> static int fsl_aud2htx_runtime_resume(struct device *dev)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_aud2htx: mark PM functions as __maybe_unused
      commit: 7b153760513cee875515398f4a9ba329a8d426e2

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
