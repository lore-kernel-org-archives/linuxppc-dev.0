Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABAAC07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 08:30:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34F620850
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 08:30:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C34F620850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43B5Jh16wWzDrQg
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 19:30:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=osadl.org
 (client-ip=62.245.132.105; helo=www.osadl.org; envelope-from=hofrat@osadl.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=osadl.org
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43B5G74TVyzDrQc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Dec 2018 19:28:29 +1100 (AEDT)
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at
 [178.115.242.59])
 by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wB78PpRI010223;
 Fri, 7 Dec 2018 09:25:51 +0100
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Li Yang <leoyang.li@nxp.com>
Subject: [PATCH] soc: fsl: guts: us devm_kstrdup_const() for RO data
Date: Fri,  7 Dec 2018 09:22:43 +0100
Message-Id: <1544170963-8386-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Nicholas Mc Guire <hofrat@osadl.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

devm_kstrdup() may return NULL if internal allocation failed, but
as  machine  is from the device tree, and thus RO, devm_kstrdup_const()
can be used here, which will only copy the reference.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: a6fc3b698130 ("soc: fsl: add GUTS driver for QorIQ platforms")
---

Problem located by experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies FSL_GUTS=y)

Patch is against 4.20-rc5 (localversion-next is next-20181207)

 drivers/soc/fsl/guts.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..15071ec 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -157,7 +157,8 @@ static int fsl_guts_probe(struct platform_device *pdev)
 		of_property_read_string_index(root, "compatible", 0, &machine);
 	of_node_put(root);
 	if (machine)
-		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		soc_dev_attr.machine = devm_kstrdup_const(dev, machine,
+							  GFP_KERNEL);
 
 	svr = fsl_guts_get_svr();
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
-- 
2.1.4

