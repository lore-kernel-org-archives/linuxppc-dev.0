Return-Path: <SRS0=uftn=2G=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E024C43603
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 12:10:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E95206CB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 12:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E95206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47c0T42Xz3zDqGG
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Dec 2019 23:10:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=mark.brown@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by lists.ozlabs.org (Postfix) with ESMTP id 47c0P02VWCzDqRG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2019 23:06:25 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEF891045;
 Mon, 16 Dec 2019 04:06:23 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2FEC93F719;
 Mon, 16 Dec 2019 04:06:23 -0800 (PST)
Date: Mon, 16 Dec 2019 12:06:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Applied "spi: fsl: use platform_get_irq() instead of
 of_irq_to_resource()" to the spi tree
In-Reply-To: <091a277fd0b3356dca1e29858c1c96983fc9cb25.1576172743.git.christophe.leroy@c-s.fr>
Message-Id: <applied-091a277fd0b3356dca1e29858c1c96983fc9cb25.1576172743.git.christophe.leroy@c-s.fr>
X-Patchwork-Hint: ignore
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
Cc: devicetree@vger.kernel.org, kbuild test robot <lkp@intel.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The patch

   spi: fsl: use platform_get_irq() instead of of_irq_to_resource()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

From 63aa6a692595d47a0785297b481072086b9272d2 Mon Sep 17 00:00:00 2001
From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Thu, 12 Dec 2019 17:47:24 +0000
Subject: [PATCH] spi: fsl: use platform_get_irq() instead of
 of_irq_to_resource()

Unlike irq_of_parse_and_map() which has a dummy definition on SPARC,
of_irq_to_resource() hasn't.

But as platform_get_irq() can be used instead and is generic, use it.

Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Mark Brown <broonie@kernel.org>
Fixes: 	3194d2533eff ("spi: fsl: don't map irq during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Link: https://lore.kernel.org/r/091a277fd0b3356dca1e29858c1c96983fc9cb25.1576172743.git.christophe.leroy@c-s.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index d0ad9709f4a6..fb4159ad6bf6 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -746,9 +746,9 @@ static int of_fsl_spi_probe(struct platform_device *ofdev)
 	if (ret)
 		goto err;
 
-	irq = of_irq_to_resource(np, 0, NULL);
-	if (irq <= 0) {
-		ret = -EINVAL;
+	irq = platform_get_irq(ofdev, 0);
+	if (irq < 0) {
+		ret = irq;
 		goto err;
 	}
 
-- 
2.20.1

