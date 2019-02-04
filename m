Return-Path: <SRS0=Z4Cu=QL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA843C282C4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 09:52:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05BA62147A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 09:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="Ma5rR66u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05BA62147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43tNKH2BYPzDqH6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 Feb 2019 20:52:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=sirena.org.uk
 (client-ip=2a01:7e01::f03c:91ff:fed4:a3b6; helo=heliosphere.sirena.org.uk;
 envelope-from=broonie@sirena.org.uk; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="Ma5rR66u"; dkim-atps=neutral
X-Greylist: delayed 2584 seconds by postgrey-1.36 at bilbo;
 Mon, 04 Feb 2019 20:50:30 AEDT
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43tNHV2RwXzDqDB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Feb 2019 20:50:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=3Dq+g6lR0JWV+AnlTj24dxl1gWoTDQj222HSXcEWh0w=; b=Ma5rR66u/2Sf
 QtW4I8S4yNJLqRBfUBGTG76/QFi0CHORPq4fxqK60x9CCOXz0VFgUpooN7AhAWpFc+dNrwHIELsi2
 2W+Uf/gu+KqDV4gtF29MsT8dJ4uRNwJ5n6+V9B4hyUKsf79Qz1w3+jKzRNI/0tHKFmw1oWcL8WdCW
 7JTg4=;
Received: from 53.97-247-81.adsl-dyn.isp.belgacom.be ([81.247.97.53]
 helo=finisterre.ee.mobilebroadband)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.89)
 (envelope-from <broonie@sirena.org.uk>)
 id 1gqaDe-0000gd-Dn; Mon, 04 Feb 2019 09:07:10 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
 id C90F1440082; Mon,  4 Feb 2019 09:07:08 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: wen yang <yellowriver2010@hotmail.com>
Subject: Applied "ASoC: fsl-asoc-card: fix object reference leaks in
 fsl_asoc_card_probe" to the asoc tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190204090708.C90F1440082@finisterre.ee.mobilebroadband>
Date: Mon,  4 Feb 2019 09:07:08 +0000 (GMT)
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
Cc: alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wen Yang <yellowriver2010@hotmil.com>,
 Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patch

   ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From 11907e9d3533648615db08140e3045b829d2c141 Mon Sep 17 00:00:00 2001
From: wen yang <yellowriver2010@hotmail.com>
Date: Sat, 2 Feb 2019 14:53:16 +0000
Subject: [PATCH] ASoC: fsl-asoc-card: fix object reference leaks in
 fsl_asoc_card_probe

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Signed-off-by: Wen Yang <yellowriver2010@hotmil.com>
Cc: Timur Tabi <timur@kernel.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl-asoc-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 81f2fe2c6d23..60f87a0d99f4 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -689,6 +689,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 asrc_fail:
 	of_node_put(asrc_np);
 	of_node_put(codec_np);
+	put_device(&cpu_pdev->dev);
 fail:
 	of_node_put(cpu_np);
 
-- 
2.20.1

