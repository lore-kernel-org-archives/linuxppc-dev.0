Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB957C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 14:24:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEDAC20693
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 14:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEDAC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W3rZ0ZWczDqWL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 01:23:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=laurentiu.tudor@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W3WM4RtCzDqTd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:09:02 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7FBE21A0290;
 Fri, 29 Mar 2019 15:00:20 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7362D1A0289;
 Fri, 29 Mar 2019 15:00:20 +0100 (CET)
Received: from fsr-ub1864-101.ea.freescale.net
 (fsr-ub1864-101.ea.freescale.net [10.171.74.120])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CE04220606;
 Fri, 29 Mar 2019 15:00:19 +0100 (CET)
From: laurentiu.tudor@nxp.com
To: netdev@vger.kernel.org, madalin.bucur@nxp.com, roy.pledge@nxp.com,
 camelia.groza@nxp.com, leoyang.li@nxp.com
Subject: [PATCH 05/13] soc/fsl/bqman: page align iommu mapping sizes
Date: Fri, 29 Mar 2019 16:00:06 +0200
Message-Id: <20190329140014.8126-6-laurentiu.tudor@nxp.com>
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

Prior to calling iommu_map()/iommu_unmap() page align the size or
failures such as below could happen:

iommu: unaligned: iova 0x... pa 0x... size 0x4000 min_pagesz 0x10000
qman_portal 500000000.qman-portal: failed to iommu_map() -22

Seen when booted a kernel compiled with 64K page size support.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/soc/fsl/qbman/bman_ccsr.c   | 2 +-
 drivers/soc/fsl/qbman/qman_ccsr.c   | 4 ++--
 drivers/soc/fsl/qbman/qman_portal.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/fsl/qbman/bman_ccsr.c b/drivers/soc/fsl/qbman/bman_ccsr.c
index b209c79511bb..3a6e01bde32d 100644
--- a/drivers/soc/fsl/qbman/bman_ccsr.c
+++ b/drivers/soc/fsl/qbman/bman_ccsr.c
@@ -230,7 +230,7 @@ static int fsl_bman_probe(struct platform_device *pdev)
 	/* Create an 1-to-1 iommu mapping for FBPR area */
 	domain = iommu_get_domain_for_dev(dev);
 	if (domain) {
-		ret = iommu_map(domain, fbpr_a, fbpr_a, fbpr_sz,
+		ret = iommu_map(domain, fbpr_a, fbpr_a, PAGE_ALIGN(fbpr_sz),
 				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
 		if (ret)
 			dev_warn(dev, "failed to iommu_map() %d\n", ret);
diff --git a/drivers/soc/fsl/qbman/qman_ccsr.c b/drivers/soc/fsl/qbman/qman_ccsr.c
index eec7700507e1..8d3c950ce52d 100644
--- a/drivers/soc/fsl/qbman/qman_ccsr.c
+++ b/drivers/soc/fsl/qbman/qman_ccsr.c
@@ -783,11 +783,11 @@ static int fsl_qman_probe(struct platform_device *pdev)
 	/* Create an 1-to-1 iommu mapping for fqd and pfdr areas */
 	domain = iommu_get_domain_for_dev(dev);
 	if (domain) {
-		ret = iommu_map(domain, fqd_a, fqd_a, fqd_sz,
+		ret = iommu_map(domain, fqd_a, fqd_a, PAGE_ALIGN(fqd_sz),
 				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
 		if (ret)
 			dev_warn(dev, "iommu_map(fqd) failed %d\n", ret);
-		ret = iommu_map(domain, pfdr_a, pfdr_a, pfdr_sz,
+		ret = iommu_map(domain, pfdr_a, pfdr_a, PAGE_ALIGN(pfdr_sz),
 				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
 		if (ret)
 			dev_warn(dev, "iommu_map(pfdr) failed %d\n", ret);
diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
index dfb62f9815e9..bce56da2b01f 100644
--- a/drivers/soc/fsl/qbman/qman_portal.c
+++ b/drivers/soc/fsl/qbman/qman_portal.c
@@ -297,7 +297,7 @@ static int qman_portal_probe(struct platform_device *pdev)
 		 */
 		err = iommu_map(domain,
 				addr_phys[0]->start, addr_phys[0]->start,
-				resource_size(addr_phys[0]),
+				PAGE_ALIGN(resource_size(addr_phys[0])),
 				IOMMU_READ | IOMMU_WRITE | IOMMU_CACHE);
 		if (err)
 			dev_warn(dev, "failed to iommu_map() %d\n", err);
-- 
2.17.1

