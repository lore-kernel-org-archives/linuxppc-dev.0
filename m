Return-Path: <SRS0=R24o=OB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A2DC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 20:42:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A0FB20989
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Nov 2018 20:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A0FB20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431BFz4VWfzDqNV
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 07:42:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=202.103.147.172; helo=mxct.zte.com.cn;
 envelope-from=wang.yi59@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
X-Greylist: delayed 955 seconds by postgrey-1.36 at bilbo;
 Thu, 22 Nov 2018 18:04:38 AEDT
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 430r6G0hQDzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Nov 2018 18:04:37 +1100 (AEDT)
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id D3A7C766606A3F58CF19;
 Thu, 22 Nov 2018 14:48:29 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id wAM6mKqD096199;
 Thu, 22 Nov 2018 14:48:20 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2018112214484957-12265950 ;
 Thu, 22 Nov 2018 14:48:49 +0800 
From: Yi Wang <wang.yi59@zte.com.cn>
To: qiang.zhao@nxp.com
Subject: [PATCH] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
Date: Thu, 22 Nov 2018 14:49:45 +0800
Message-Id: <1542869385-48337-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2018-11-22 14:48:49,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-22 14:48:08, Serialize complete at 2018-11-22 14:48:08
X-MAIL: mse01.zte.com.cn wAM6mKqD096199
X-Mailman-Approved-At: Fri, 23 Nov 2018 07:40:29 +1100
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
Cc: wang.yi59@zte.com.cn, zhong.weidong@zte.com.cn,
 linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
 Julia Lawall <julia.lawall@lip6.fr>, linuxppc-dev@lists.ozlabs.org,
 Wen Yang <wen.yang99@zte.com.cn>, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Wen Yang <wen.yang99@zte.com.cn>

Currently there are 2 problems with the ucc_of_parse_tdm function:
1,a possible null pointer dereference in ucc_of_parse_tdm,
detected by the semantic patch deref_null.cocci,
with the following warning:
drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.
2,dev gets modified, so in any case that devm_iounmap() will fail even when
the new pdev is valid, because the iomap was done with a different pdev.
This patch fixes them.

Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Zhao Qiang <qiang.zhao@nxp.com>
---
 drivers/soc/fsl/qe/qe_tdm.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index f78c346..9a29f0b 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -47,7 +47,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	struct resource *res;
 	struct device_node *np2;
 	static int siram_init_flag;
-	struct platform_device *pdev;
+	struct platform_device *pdev_si, *pdev_siram;
 
 	sprop = of_get_property(np, "fsl,rx-sync-clock", NULL);
 	if (sprop) {
@@ -129,16 +129,16 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	if (!np2)
 		return -EINVAL;
 
-	pdev = of_find_device_by_node(np2);
-	if (!pdev) {
+	pdev_si = of_find_device_by_node(np2);
+	if (!pdev_si) {
 		pr_err("%pOFn: failed to lookup pdev\n", np2);
 		of_node_put(np2);
 		return -EINVAL;
 	}
 
 	of_node_put(np2);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	utdm->si_regs = devm_ioremap_resource(&pdev->dev, res);
+	res = platform_get_resource(pdev_si, IORESOURCE_MEM, 0);
+	utdm->si_regs = devm_ioremap_resource(&pdev_si->dev, res);
 	if (IS_ERR(utdm->si_regs)) {
 		ret = PTR_ERR(utdm->si_regs);
 		goto err_miss_siram_property;
@@ -150,8 +150,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 		goto err_miss_siram_property;
 	}
 
-	pdev = of_find_device_by_node(np2);
-	if (!pdev) {
+	pdev_siram = of_find_device_by_node(np2);
+	if (!pdev_siram) {
 		ret = -EINVAL;
 		pr_err("%pOFn: failed to lookup pdev\n", np2);
 		of_node_put(np2);
@@ -159,8 +159,8 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	}
 
 	of_node_put(np2);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	utdm->siram = devm_ioremap_resource(&pdev->dev, res);
+	res = platform_get_resource(pdev_siram, IORESOURCE_MEM, 0);
+	utdm->siram = devm_ioremap_resource(&pdev_siram->dev, res);
 	if (IS_ERR(utdm->siram)) {
 		ret = PTR_ERR(utdm->siram);
 		goto err_miss_siram_property;
@@ -174,7 +174,7 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	return ret;
 
 err_miss_siram_property:
-	devm_iounmap(&pdev->dev, utdm->si_regs);
+	devm_iounmap(&pdev_si->dev, utdm->si_regs);
 	return ret;
 }
 EXPORT_SYMBOL(ucc_of_parse_tdm);
-- 
2.9.5

