Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5742C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 22:20:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090B42084C
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 22:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090B42084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43by481K1PzDr3l
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 09:20:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=leoyang.li@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
X-Greylist: delayed 452 seconds by postgrey-1.36 at bilbo;
 Sat, 12 Jan 2019 09:19:01 AEDT
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43by2F1gcjzDr3j
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 09:19:00 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1E9061A0200;
 Fri, 11 Jan 2019 23:11:24 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D891D1A01FC;
 Fri, 11 Jan 2019 23:11:23 +0100 (CET)
Received: from someleo.am.freescale.net (someleo.am.freescale.net
 [10.81.33.49])
 by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id F0C5D40CAF;
 Fri, 11 Jan 2019 15:11:22 -0700 (MST)
From: Li Yang <leoyang.li@nxp.com>
To: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>,
 Scott Wood <oss@buserror.net>
Subject: [PATCH] soc: fsl: guts: reuse machine name from device tree
Date: Fri, 11 Jan 2019 16:11:07 -0600
Message-Id: <20190111221107.952-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Li Yang <leoyang.li@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Reuse the string machine from the device tree data structure instead
of duplicating the data again.  This also prevents a potential memory
allocation failure that was not handled previously.  Also fixes an early
put of root device node.

Reported-by: Nicholas Mc Guire <hofrat@osadl.org>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/soc/fsl/guts.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8d69d9..4f9655087bd7 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -32,6 +32,7 @@ struct fsl_soc_die_attr {
 static struct guts *guts;
 static struct soc_device_attribute soc_dev_attr;
 static struct soc_device *soc_dev;
+static struct device_node *root;
 
 
 /* SoC die attribute definition for QorIQ platform */
@@ -132,7 +133,7 @@ EXPORT_SYMBOL(fsl_guts_get_svr);
 
 static int fsl_guts_probe(struct platform_device *pdev)
 {
-	struct device_node *root, *np = pdev->dev.of_node;
+	struct device_node *np = pdev->dev.of_node;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	const struct fsl_soc_die_attr *soc_die;
@@ -155,9 +156,8 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	root = of_find_node_by_path("/");
 	if (of_property_read_string(root, "model", &machine))
 		of_property_read_string_index(root, "compatible", 0, &machine);
-	of_node_put(root);
 	if (machine)
-		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		soc_dev_attr.machine = machine;
 
 	svr = fsl_guts_get_svr();
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
@@ -192,6 +192,7 @@ static int fsl_guts_probe(struct platform_device *pdev)
 static int fsl_guts_remove(struct platform_device *dev)
 {
 	soc_device_unregister(soc_dev);
+	of_node_put(root);
 	return 0;
 }
 
-- 
2.17.1

