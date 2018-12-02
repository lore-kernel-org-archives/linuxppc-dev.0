Return-Path: <SRS0=NHc8=OL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D17DC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Dec 2018 10:00:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A86206B7
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Dec 2018 10:00:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A86206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4373Xk3xB3zDqR0
	for <linuxppc-dev@archiver.kernel.org>; Sun,  2 Dec 2018 21:00:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=osadl.org
 (client-ip=62.245.132.105; helo=www.osadl.org; envelope-from=hofrat@osadl.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=osadl.org
X-Greylist: delayed 3116 seconds by postgrey-1.36 at bilbo;
 Sun, 02 Dec 2018 20:58:40 AEDT
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4373VS3JffzDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Dec 2018 20:58:39 +1100 (AEDT)
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at
 [178.115.242.59])
 by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wB2942Us005968;
 Sun, 2 Dec 2018 10:04:02 +0100
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Li Yang <leoyang.li@nxp.com>
Subject: [RFC PATCH] soc: fsl: guts: handle devm_kstrdup() failure
Date: Sun,  2 Dec 2018 10:00:58 +0100
Message-Id: <1543741258-17433-1-git-send-email-hofrat@osadl.org>
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

devm_kstrdup() may return NULL if internal allocation failed.
soc_dev_attr.machine  should be checked (although its only use
in pr_info() would be safe even with a NULL). Therefor
in the unlikely case of allocation failure, fsl_guts_probe() returns
-ENOMEM as this allocating failing is an indication of something
more serious going wrong at system level.

As  machine  is from the device tree which I assume to be RO - if
that assumption is always correct - a better alternative would be
to use devm_kstrdup_const() here. That would then simply copy the
reference to the RO data and not perform any allocation at all.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: a6fc3b698130 ("soc: fsl: add GUTS driver for QorIQ platforms")
---

Problem located by experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies FSL_GUTS=y)

Patch is against 4.20-rc4 (localversion-next is next-20181130)

 drivers/soc/fsl/guts.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..a0c751b 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -156,8 +156,11 @@ static int fsl_guts_probe(struct platform_device *pdev)
 	if (of_property_read_string(root, "model", &machine))
 		of_property_read_string_index(root, "compatible", 0, &machine);
 	of_node_put(root);
-	if (machine)
+	if (machine) {
 		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);
+		if (!soc_dev_attr.machine)
+			return -ENOMEM;
+	}
 
 	svr = fsl_guts_get_svr();
 	soc_die = fsl_soc_die_match(svr, fsl_soc_die);
-- 
2.1.4

