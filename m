Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EAFC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 10:04:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32A032067C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 10:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="LL/aGA19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32A032067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r8mn28j3zDqgb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 20:04:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="LL/aGA19"; dkim-atps=neutral
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r8kz6BPdzDq9G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 20:03:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=D1CkM3YHEnUB2EMTId45/y5anrnTf+wW5OWbCq4uHs4=; b=LL/aGA19sryg
 4cflUSf9PAuJgTwBSyTFb5DBsoZf2z0pqZbwyBXJrRavz7UW2wULMwZT5JTyOhvo7rAg95kHvOEwT
 aMhNQfw0+pqb4ldwuYHH6EflTkrqcPhVWJrgkrl3VYq70f7GgEkgQV7NsECLyWjDUe1hECB0fiWeC
 tm5ck=;
Received: from [37.205.61.202] (helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1hJxhJ-0003km-5o; Fri, 26 Apr 2019 10:03:13 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id 7D977441D3B; Fri, 26 Apr 2019 11:03:09 +0100 (BST)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Applied "ASoC: fsl_sai: Add missing return 0 in remove()" to the asoc
 tree
In-Reply-To: <1556248850-3748-1-git-send-email-nicoleotsuka@gmail.com>
X-Patchwork-Hint: ignore
Message-Id: <20190426100311.7D977441D3B@finisterre.ee.mobilebroadband>
Date: Fri, 26 Apr 2019 11:03:08 +0100 (BST)
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org,
 timur@kernel.org, Xiubo.Lee@gmail.com, daniel.baluta@nxp.com,
 linuxppc-dev@lists.ozlabs.org, lgirdwood@gmail.com,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, tiwai@suse.com,
 perex@perex.cz, festevam@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patch

   ASoC: fsl_sai: Add missing return 0 in remove()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

From b46ea8f4d23807e41be86bf214618e4fd4682b9b Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Thu, 25 Apr 2019 20:20:50 -0700
Subject: [PATCH] ASoC: fsl_sai: Add missing return 0 in remove()

Build warning being reported:
    sound/soc/fsl/fsl_sai.c: In function 'fsl_sai_remove':
    sound/soc/fsl/fsl_sai.c:921:1: warning: no return statement in
    function returning non-void [-Wreturn-type]

So this patch just adds a "return 0" to fix it.

Fixes: 812ad463e089 ("ASoC: fsl_sai: Add support for runtime pm")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_sai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 26c27dc0781f..8593269156bd 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -918,6 +918,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 static int fsl_sai_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
+
+	return 0;
 }
 
 static const struct of_device_id fsl_sai_ids[] = {
-- 
2.20.1

