Return-Path: <SRS0=IR6y=E7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836DEC5519F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 14:28:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A269206F9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2020 14:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="attU8U+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A269206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ch3C84SgJzDqrX
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Nov 2020 01:28:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=attU8U+1; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Ch2Y72nzvzDqG6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2020 00:58:35 +1100 (AEDT)
Received: from localhost (cpc102334-sgyl38-2-0-cust884.18-2.cable.virginm.net
 [92.233.91.117])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 28D522067D;
 Wed, 25 Nov 2020 13:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606312711;
 bh=Cyu0AkwxzQsIHLMFSvu3ENgdx8wUHEaoXwxzg6oGcxk=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=attU8U+1cTDuzsvE9HmP+erKurMSIQZOrE+O4MxZ2dgulzI8FN7I0xPcWQOSvundg
 aHTZK9hujZTNeyoPXsXy1uSePSW2PLYaWHy+QBEKCDKJbd04TUtQg/qC8b7SDVsZhf
 9us5cwFGC5oHlYnymcfnfTp55S/kbZq//1ESjyVE=
Date: Wed, 25 Nov 2020 13:58:06 +0000
From: Mark Brown <broonie@kernel.org>
To: linuxppc-dev@lists.ozlabs.org, Fabio Estevam <festevam@gmail.com>,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
 Shengjiu Wang <shengjiu.wang@gmail.com>
In-Reply-To: <20201124141957.20481-1-viorel.suman@oss.nxp.com>
References: <20201124141957.20481-1-viorel.suman@oss.nxp.com>
Subject: Re: [PATCH] ASoC: fsl_xcvr: fix potential resource leak
Message-Id: <160631268108.29388.9517071791344841145.b4-ty@kernel.org>
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
Cc: Viorel Suman <viorel.suman@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 24 Nov 2020 16:19:57 +0200, Viorel Suman (OSS) wrote:
> "fw" variable must be relased before return.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_xcvr: fix potential resource leak
      commit: 373c2cebf42772434c8dd0deffc3b3886ea8f1eb

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
