Return-Path: <linuxppc-dev+bounces-17100-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0211E9B24C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Feb 2026 10:09:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKtkS0br8z3cLg;
	Tue, 24 Feb 2026 21:09:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771927792;
	cv=none; b=SbUb9O4my44iN3EBEHgirPS+f+OIzk3W59+fJJabwnwbwMg31P0jp6EwSKOp60T/UkIMbC1Y5raTxTypeCHl4rBG2CoXEm2tsqmaGplZr8NGhe6XJmu8ScEbphEMsDSSFBlQ2p6wWO3iw/F0lUUTzYSyp+E33A1vA3grf3rYWshM6xtTk8AibswspjYNzR5GipRqHzop3Vj0/zyTT+kjnY4bXBMzZfsWee1T8/szBIvotFNyUNO8HN/aR63P1xVbO4nUKi1zn/9H0zgP6Q7CufdoVXfQVZ5XAS9routfcYtm4LlFUQCuBqGpqHDHAzx/LmhIrCTJ5NNzgOCnN1/KPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771927792; c=relaxed/relaxed;
	bh=amCVEVpiZceKS/9PaKZY/D7hzY7M3HXHMAkJsrFiw4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iP00sQg5mdVSqBK4Bdms2FAKTyJMItq3EEt8VAKESkqW38JrvrOQ5n9Yi5GOepLRmRLYZhRRNb53QWAO/54KO5DfGzt9SQwhteRvWJ95SHFtWg9zezCdQf68og/ofmcf7RhJeBa4HWvPTqNxOlN6Uba0M30oLnx5qlSIzF6TEv4bpIrxFylIwXtpbRh8oFpMwJ0Z0Su0qmBdXFDGzM8SqW6AZtpPwZlWVTuqqlac48daS36qJVnmZwpEy8ZuMyINb/f3gUPJv9Wv/FITHj1xKYVyCgssUlQh34+rsk8h6cXfId6ZePhW0S6jBQcsCPU/Vc25kAuAF2v+mq/e6ccTxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Jfg8+cOl; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Jfg8+cOl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKtkQ706Vz3cLR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Feb 2026 21:09:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A1FC6445AE;
	Tue, 24 Feb 2026 10:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D6DC2BCAF;
	Tue, 24 Feb 2026 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771927788;
	bh=hsCQhGflSwjmOOlm9wV6+2iHnF8xoCeNa3HV8QtpTIo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jfg8+cOl4ZROIlq75g/zbRWA5RZsKZFwCLFu9ML0xh3yavj7Gr9gC49zC+9v6eMJY
	 pqesAKHcmJbcbGTRx3DuY5Ult7dqQ/Af8fI8zFCeeTIxG/s/9PjRN1T5TbsPuj+zgd
	 qYo4TbIAAc7L6aOi6odjUa7Pt6RFUIibW1ol8phLKXEPdF8uuGxFNilEGSj/E+SoTo
	 Kj4c+dFwBDiN0dNYQ5neqwt1sux5h4ewMdsHxh+VbBlngelziRXFArZ5UdD2ePYKRZ
	 P+NOOoMrcRUSXzPyT2xnLLZ8bIATh/Dx4cDU3Z+CRRHnG1PTtHuW0lhWZBacnEM5of
	 FrAoGZHVj2gyw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vupMQ-0000000DIa5-1EUE;
	Tue, 24 Feb 2026 10:09:46 +0000
From: Marc Zyngier <maz@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Sascha Bischoff <sascha.bischoff@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/6] irqchip/gic-v3-its: Add fsl_mc device plumbing to the msi-parent handling
Date: Tue, 24 Feb 2026 10:09:33 +0000
Message-ID: <20260224100936.3752303-4-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224100936.3752303-1-maz@kernel.org>
References: <20260224100936.3752303-1-maz@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: ioana.ciornei@nxp.com, tglx@kernel.org, chleroy@kernel.org, sascha.bischoff@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Make the ITS code aware of fsl_mc devices by plumbing the devid
retrieval primitive.

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com> # LX2160ARDB, LS2088ARDB
Tested-by: Sascha Bischoff <sascha.bischoff@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-its-msi-parent.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
index a832cdb2e6978..d36b278ae66c5 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -5,6 +5,7 @@
 // Copyright (C) 2022 Intel
 
 #include <linux/acpi_iort.h>
+#include <linux/fsl/mc.h>
 #include <linux/of_address.h>
 #include <linux/pci.h>
 
@@ -187,9 +188,11 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 {
 	struct msi_domain_info *msi_info;
 	u32 dev_id;
-	int ret;
+	int ret = 0;
 
-	if (dev->of_node)
+	if (dev_is_fsl_mc(dev))
+		dev_id = fsl_mc_get_msi_id(dev);
+	else if (dev->of_node)
 		ret = of_pmsi_get_msi_info(domain->parent, dev, &dev_id, NULL);
 	else
 		ret = iort_pmsi_get_msi_info(dev, &dev_id, NULL);
-- 
2.47.3


