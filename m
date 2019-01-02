Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B4DC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 08:07:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8BB121019
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 08:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BB121019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43V3YR3H49zDqHp
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Jan 2019 19:07:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=zte.com.cn
 (client-ip=202.103.147.172; helo=mxct.zte.com.cn;
 envelope-from=peng.hao2@zte.com.cn; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=zte.com.cn
Received: from mxct.zte.com.cn (out1.zte.com.cn [202.103.147.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43V3W54hK2zDqCR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Jan 2019 19:05:03 +1100 (AEDT)
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
 by Forcepoint Email with ESMTPS id 7BD6B711B2E03792D48B;
 Wed,  2 Jan 2019 16:04:58 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
 by mse01.zte.com.cn with ESMTP id x02808QX044007;
 Wed, 2 Jan 2019 16:00:08 +0800 (GMT-8)
 (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2019010216002997-20033780 ;
 Wed, 2 Jan 2019 16:00:29 +0800 
From: Peng Hao <peng.hao2@zte.com.cn>
To: qiang.zhao@nxp.com, leoyang.li@nxp.com
Subject: [PATCH v5] soc/fsl/qe: fix err handling of ucc_of_parse_tdm
Date: Thu, 3 Jan 2019 00:23:43 +0800
Message-Id: <1546446223-17184-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2019-01-02 16:00:30,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-02 16:00:00, Serialize complete at 2019-01-02 16:00:00
X-MAIL: mse01.zte.com.cn x02808QX044007
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wen Yang <wen.yang99@zte.com.cn>, Julia Lawall <julia.lawall@lip6.fr>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Wen Yang <wen.yang99@zte.com.cn>

Currently there are some issues with the ucc_of_parse_tdm function:
1, a possible null pointer dereference in ucc_of_parse_tdm,
detected by the semantic patch deref_null.cocci,
with the following warning:
drivers/soc/fsl/qe/qe_tdm.c:177:21-24: ERROR: pdev is NULL but dereferenced.
2, dev gets modified, so in any case that devm_iounmap() will fail
even when the new pdev is valid, because the iomap was done with a
 different pdev.
3, there is no driver bind with the "fsl,t1040-qe-si" or
"fsl,t1040-qe-siram" device. So allocating resources using devm_*()
with these devices won't provide a cleanup path for these resources
when the caller fails.

This patch fixes them.

Suggested-by: Li Yang <leoyang.li@nxp.com>
Suggested-by: Christophe LEROY <christophe.leroy@c-s.fr>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Zhao Qiang <qiang.zhao@nxp.com>
CC: David S. Miller <davem@davemloft.net>
CC: netdev@vger.kernel.org
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-kernel@vger.kernel.org
---
 drivers/net/wan/fsl_ucc_hdlc.c | 62 +++++++++++++++++++++++++++++++++++++++++-
 drivers/soc/fsl/qe/qe_tdm.c    | 55 -------------------------------------
 2 files changed, 61 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 839fa77..f30a040 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1057,6 +1057,54 @@ static const struct net_device_ops uhdlc_ops = {
 	.ndo_tx_timeout	= uhdlc_tx_timeout,
 };
 
+static int hdlc_map_iomem(char *name, int init_flag, void __iomem **ptr)
+{
+	struct device_node *np;
+	struct platform_device *pdev;
+	struct resource *res;
+	static int siram_init_flag;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, NULL, name);
+	if (!np)
+		return -EINVAL;
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev) {
+		pr_err("%pOFn: failed to lookup pdev\n", np);
+		of_node_put(np);
+		return -EINVAL;
+	}
+
+	of_node_put(np);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -EINVAL;
+		goto error_put_device;
+	}
+	*ptr = ioremap(res->start, resource_size(res));
+	if (!*ptr) {
+		ret = -ENOMEM;
+		goto error_put_device;
+	}
+
+	/* We've remapped the addresses, and we don't need the device any
+	 * more, so we should release it.
+	 */
+	put_device(&pdev->dev);
+
+	if (init_flag && siram_init_flag == 0) {
+		memset_io(*ptr, 0, resource_size(res));
+		siram_init_flag = 1;
+	}
+	return  0;
+
+error_put_device:
+	put_device(&pdev->dev);
+
+	return ret;
+}
+
 static int ucc_hdlc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1151,6 +1199,15 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 		ret = ucc_of_parse_tdm(np, utdm, ut_info);
 		if (ret)
 			goto free_utdm;
+
+		ret = hdlc_map_iomem("fsl,t1040-qe-si", 0,
+				     (void __iomem **)&utdm->si_regs);
+		if (ret)
+			goto free_utdm;
+		ret = hdlc_map_iomem("fsl,t1040-qe-siram", 1,
+				     (void __iomem **)&utdm->siram);
+		if (ret)
+			goto unmap_si_regs;
 	}
 
 	if (of_property_read_u16(np, "fsl,hmask", &uhdlc_priv->hmask))
@@ -1159,7 +1216,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	ret = uhdlc_init(uhdlc_priv);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to init uhdlc\n");
-		goto free_utdm;
+		goto undo_uhdlc_init;
 	}
 
 	dev = alloc_hdlcdev(uhdlc_priv);
@@ -1188,6 +1245,9 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 free_dev:
 	free_netdev(dev);
 undo_uhdlc_init:
+	iounmap(utdm->siram);
+unmap_si_regs:
+	iounmap(utdm->si_regs);
 free_utdm:
 	if (uhdlc_priv->tsa)
 		kfree(utdm);
diff --git a/drivers/soc/fsl/qe/qe_tdm.c b/drivers/soc/fsl/qe/qe_tdm.c
index f78c346..76480df 100644
--- a/drivers/soc/fsl/qe/qe_tdm.c
+++ b/drivers/soc/fsl/qe/qe_tdm.c
@@ -44,10 +44,6 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	const char *sprop;
 	int ret = 0;
 	u32 val;
-	struct resource *res;
-	struct device_node *np2;
-	static int siram_init_flag;
-	struct platform_device *pdev;
 
 	sprop = of_get_property(np, "fsl,rx-sync-clock", NULL);
 	if (sprop) {
@@ -124,57 +120,6 @@ int ucc_of_parse_tdm(struct device_node *np, struct ucc_tdm *utdm,
 	utdm->siram_entry_id = val;
 
 	set_si_param(utdm, ut_info);
-
-	np2 = of_find_compatible_node(NULL, NULL, "fsl,t1040-qe-si");
-	if (!np2)
-		return -EINVAL;
-
-	pdev = of_find_device_by_node(np2);
-	if (!pdev) {
-		pr_err("%pOFn: failed to lookup pdev\n", np2);
-		of_node_put(np2);
-		return -EINVAL;
-	}
-
-	of_node_put(np2);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	utdm->si_regs = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(utdm->si_regs)) {
-		ret = PTR_ERR(utdm->si_regs);
-		goto err_miss_siram_property;
-	}
-
-	np2 = of_find_compatible_node(NULL, NULL, "fsl,t1040-qe-siram");
-	if (!np2) {
-		ret = -EINVAL;
-		goto err_miss_siram_property;
-	}
-
-	pdev = of_find_device_by_node(np2);
-	if (!pdev) {
-		ret = -EINVAL;
-		pr_err("%pOFn: failed to lookup pdev\n", np2);
-		of_node_put(np2);
-		goto err_miss_siram_property;
-	}
-
-	of_node_put(np2);
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	utdm->siram = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(utdm->siram)) {
-		ret = PTR_ERR(utdm->siram);
-		goto err_miss_siram_property;
-	}
-
-	if (siram_init_flag == 0) {
-		memset_io(utdm->siram, 0,  resource_size(res));
-		siram_init_flag = 1;
-	}
-
-	return ret;
-
-err_miss_siram_property:
-	devm_iounmap(&pdev->dev, utdm->si_regs);
 	return ret;
 }
 EXPORT_SYMBOL(ucc_of_parse_tdm);
-- 
2.9.5

