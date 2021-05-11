Return-Path: <SRS0=9biP=KG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C952C433B4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 May 2021 08:28:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86AF561947
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 May 2021 08:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AF561947
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FfWJt0yFcz3067
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 May 2021 18:28:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Jk/YdMVZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=broonie@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Jk/YdMVZ; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FfWJN16Wfz2yYK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 May 2021 18:27:47 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91A6E61107;
 Tue, 11 May 2021 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620721664;
 bh=aIbKrZTp+E6EVIDHCNWvzoJpW7zVJeecbnlZyRKFuck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Jk/YdMVZ7Q5F4MdPuwZwTMDGhDedzAF3Uo4XIes00YTrJwb0XrjDrHlpKmk84n/aR
 xegkHek9ygsElz5tUP5BuVytq09QhG5kx249XL7QsPoGO6e653eQu/cgyS0jTX/MRh
 /wSPtlVWPG679y8pa8Bv4ES8Suo3UKobYQxGov3Km70EXsQ3rIzshR+IiTQk0g5yjs
 tbQml0CbcfEj7FowDU4KCz2ff31xi+YZAKnXGKWiFmpMTh9Pu0xFrVlGdGj4xktsOV
 wZBim14CTApR5Apquoih+LyUIfTdD8VoFG569CWfG2siHzt40OHYQ+JVxyHsrsHtbE
 ZtrhJNEu0hmvA==
From: Mark Brown <broonie@kernel.org>
To: festevam@gmail.com, alsa-devel@alsa-project.org,
 Shengjiu Wang <shengjiu.wang@nxp.com>, perex@perex.cz,
 nicoleotsuka@gmail.com, timur@kernel.org, Xiubo.Lee@gmail.com,
 tiwai@suse.com
Subject: Re: [PATCH] ASoC: fsl_spdif: add support for enabling raw capture mode
Date: Tue, 11 May 2021 09:25:50 +0100
Message-Id: <162072058167.33157.3402941285699720192.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1619425444-8666-1-git-send-email-shengjiu.wang@nxp.com>
References: <1619425444-8666-1-git-send-email-shengjiu.wang@nxp.com>
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

On Mon, 26 Apr 2021 16:24:04 +0800, Shengjiu Wang wrote:
> Since i.MX8MM SPDIF interface is able to capture raw data.
> Add support in SPDIF driver for this functionality.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: fsl_spdif: add support for enabling raw capture mode
      commit: 604e5178444ea1d8053cf073e2c68fbc73a4e142

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
