Return-Path: <linuxppc-dev+bounces-16930-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB66E9A04B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Feb 2026 13:52:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGHxq0J5sz3bqh;
	Thu, 19 Feb 2026 00:52:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771422734;
	cv=none; b=CibiunLZYZlGteycu5woANMGpGbR9IGIwj/ErxM3kgLMaW4jjsdFCbkyBhZuBoDiyO8P+9IsO7j6DI3Hwuhl9Yy3rWOPIXkHG3Lh5H1w776VVaNO22B9Hk7L2qdVTB+FaRpCSkey4BWnhYRrdGXT43BYLrj5Dj84qNRdZXNPJ0OjgniCR9mLjgBybq0PpajTWsGllY7yYZvrPhnSpfYu0RhCIu+/EweeY1guxCtd9bwotlPMWgj+s2PHKDmXdv9s07RcTh+aROPNOe1FaZGWeEE54DiT37hUJldzK2a8wDKt1abosu8f1t957s1dmlSzNO/lBRTR6zWBTypvtTyeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771422734; c=relaxed/relaxed;
	bh=lwHvV3fUxmyryw/PpEJ1NHzmL5L4khyPBe01k0wMyW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=brrfhpT2nAHZi7e/6Z+uafPOmnnlPs1e5vpKQknBzsHVGUuzJwVG4F+908fvKs6xNEUYbr77DO83Y9dyMIVPiQgq5p3IBXcdI/c6zeH758YUzZUix5rvrycW2+jfN8Z/duFDIn64HnH4dKHOApf/rCVdmGOfugf20DMVD8PrGHr+CH3vjtTK65L6EehjjYzNntAOzkVNHbaNVC3Hu6ad84Z4MsRoQ+vyvhz/lmSWpesk2ECdH+zLeO9IknUbkCwP46jTunneFCZWhewsEb4h/yNPu+OElQZNyNEs2b/9Jt4kdGTPmF0UfuDRGiWENmytqQtjnEzbTB/NUFH6OWJZ3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sVJIlpnI; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sVJIlpnI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=maz@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGHxm12ywz3bnm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2026 00:52:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7E75F6185D;
	Wed, 18 Feb 2026 13:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D15CC19425;
	Wed, 18 Feb 2026 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771422729;
	bh=jNsv6Mzm6JnU1v2Z2XpH/L+IpXDhwResrBm3y8osrzA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sVJIlpnICiU7Ad7qofR6f5XPQE+PpaTiEs0XIw8Jn2T9r2arLJ2J/UeN5PyTiouJj
	 AQbpDgzS9YxXUP8zK8r7Yb/YXy6Ee2BeXiSReNWfI9NJgpkjzBXKxCBLAnI66Jby+W
	 6ehM8P7L2Q0tav/l0x4XZ4wIfdLswIiMgLKKZK0ti0BAdEESxl2CHzXm0ZAYb7VI15
	 J4xbIgxyGwEGbiFurdq+eOgRK8p/xOJmz7V5r3+uBVqL6a1lXN06eWB6zTAVO5/CWM
	 UmbCXRsD1o3lNdXfip80bs086uNcdUe+FWjxpIlmpnm78xOT6NPeuC273RK76w0875
	 g0LvWTvuRQQXw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1vshyJ-0000000Bu02-189b;
	Wed, 18 Feb 2026 13:52:07 +0000
From: Marc Zyngier <maz@kernel.org>
To: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/6] irqchip/gic-v3-its: Add fsl_mc device plumbing to the msi-parent handling
Date: Wed, 18 Feb 2026 13:52:00 +0000
Message-ID: <20260218135203.2267907-4-maz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260218135203.2267907-1-maz@kernel.org>
References: <20260218135203.2267907-1-maz@kernel.org>
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
X-SA-Exim-Rcpt-To: ioana.ciornei@nxp.com, tglx@kernel.org, chleroy@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Make the ITS code aware of fsl_mc devices by plumbing the devid
retrieval primitive.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-its-msi-parent.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-gic-its-msi-parent.c
index 12f45228c8674..532c0d626ca04 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -7,6 +7,7 @@
 #include <linux/acpi_iort.h>
 #include <linux/of_address.h>
 #include <linux/pci.h>
+#include <linux/fsl/mc.h>
 
 #include "irq-gic-its-msi-parent.h"
 #include <linux/irqchip/irq-msi-lib.h>
@@ -186,9 +187,11 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
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
 		ret = iort_pmsi_get_dev_id(dev, &dev_id);
-- 
2.47.3


