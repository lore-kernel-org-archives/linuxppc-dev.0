Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C97AC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 14:28:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 110AE2173C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 14:28:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 110AE2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W3xQ0sRyzDqSw
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 01:28:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=laurentiu.tudor@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W3WM4V7PzDqWS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:09:02 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 116BC1A027E;
 Fri, 29 Mar 2019 15:00:19 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0520B1A01C1;
 Fri, 29 Mar 2019 15:00:19 +0100 (CET)
Received: from fsr-ub1864-101.ea.freescale.net
 (fsr-ub1864-101.ea.freescale.net [10.171.74.120])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 788E920606;
 Fri, 29 Mar 2019 15:00:18 +0100 (CET)
From: laurentiu.tudor@nxp.com
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
 camelia.groza@nxp.com, leoyang.li@nxp.com
Subject: [PATCH 03/13] soc/fsl/qman: map FQD and PFDR areas in the iommu
Date: Fri, 29 Mar 2019 16:00:04 +0200
Message-Id: <20190329140014.8126-4-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
References: <20190329140014.8126-1-laurentiu.tudor@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
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
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Add a one-to-one iommu mapping for qman private data memory areas
(FQD and PFDR). This is required for QMAN to work without faults
behind an iommu.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/qman_ccsr.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index 12e414ca3b03..eec7700507e1 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -29,6 +29,7 @@
  */
 
 #include "qman_priv.h"
+#include <linux/iommu.h>
 
 u16 qman_ip_rev;
 EXPORT_SYMBOL(qman_ip_rev);
@@ -699,6 +700,7 @@ static int fsl_qman_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
+	struct iommu_domain *domain;
 	struct resource *res;
 	int ret, err_irq;
 	u16 id;
@@ -778,6 +780,19 @@ static int fsl_qman_probe(struct platform_device *pdev)
 	}
 	dev_dbg(dev, "Allocated PFDR 0x%llx 0x%zx\n", pfdr_a, pfdr_sz);
 
+	/* Create an 1-to-1 iommu mapping for fqd and pfdr areas */
+	domain = iommu_get_domain_for_dev(dev);
+	if (domain) {
+		ret = iommu_map(domain, fqd_a, fqd_a, fqd_sz,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+		if (ret)
+			dev_warn(dev, "iommu_map(fqd) failed %d\n", ret);
+		ret = iommu_map(domain, pfdr_a, pfdr_a, pfdr_sz,
+				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
+		if (ret)
+			dev_warn(dev, "iommu_map(pfdr) failed %d\n", ret);
+	}
+
 	ret = qman_init_ccsr(dev);
 	if (ret) {
 		dev_err(dev, "CCSR setup failed\n");
-- 
2.17.1

