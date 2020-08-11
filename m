Return-Path: <SRS0=HEEy=BV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A29C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 10:19:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2C02054F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 10:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2C02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BQphw0LwgzDqWS
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Aug 2020 20:19:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.21; helo=inva021.nxp.com;
 envelope-from=zhiqiang.hou@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BQpKR216vzDqRZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2020 20:02:19 +1000 (AEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DCC70201EED;
 Tue, 11 Aug 2020 12:02:15 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6EECD201EFC;
 Tue, 11 Aug 2020 12:02:08 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8601C4031C;
 Tue, 11 Aug 2020 12:01:59 +0200 (CEST)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org, bhelgaas@google.com,
 lorenzo.pieralisi@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
 kishon@ti.com, gustavo.pimentel@synopsys.com, roy.zang@nxp.com,
 jingoohan1@gmail.com, andrew.murray@arm.com
Subject: [PATCHv7 09/12] PCI: layerscape: Add EP mode support for ls1088a and
 ls2088a
Date: Tue, 11 Aug 2020 17:54:38 +0800
Message-Id: <20200811095441.7636-10-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
References: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
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
Cc: minghuan.Lian@nxp.com, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Xiaowei Bao <xiaowei.bao@nxp.com>, mingkai.hu@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add PCIe EP mode support for ls1088a and ls2088a, there are some
difference between LS1 and LS2 platform, so refactor the code of
the EP driver.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V7:
 - Rebase the patch without functionality change.

 .../pci/controller/dwc/pci-layerscape-ep.c    | 72 ++++++++++++++-----
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index bfab1c694f00..84206f265e54 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -20,27 +20,29 @@
 
 #define PCIE_DBI2_OFFSET		0x1000	/* DBI2 base address*/
 
-struct ls_pcie_ep {
-	struct dw_pcie		*pci;
-	struct pci_epc_features	*ls_epc;
+#define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
+
+struct ls_pcie_ep_drvdata {
+	u32				func_offset;
+	const struct dw_pcie_ep_ops	*ops;
+	const struct dw_pcie_ops	*dw_pcie_ops;
 };
 
-#define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
+struct ls_pcie_ep {
+	struct dw_pcie			*pci;
+	struct pci_epc_features		*ls_epc;
+	const struct ls_pcie_ep_drvdata *drvdata;
+};
 
 static int ls_pcie_establish_link(struct dw_pcie *pci)
 {
 	return 0;
 }
 
-static const struct dw_pcie_ops ls_pcie_ep_ops = {
+static const struct dw_pcie_ops dw_ls_pcie_ep_ops = {
 	.start_link = ls_pcie_establish_link,
 };
 
-static const struct of_device_id ls_pcie_ep_of_match[] = {
-	{ .compatible = "fsl,ls-pcie-ep",},
-	{ },
-};
-
 static const struct pci_epc_features*
 ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
@@ -87,10 +89,39 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 }
 
-static const struct dw_pcie_ep_ops pcie_ep_ops = {
+static unsigned int ls_pcie_ep_func_conf_select(struct dw_pcie_ep *ep,
+						u8 func_no)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct ls_pcie_ep *pcie = to_ls_pcie_ep(pci);
+
+	WARN_ON(func_no && !pcie->drvdata->func_offset);
+	return pcie->drvdata->func_offset * func_no;
+}
+
+static const struct dw_pcie_ep_ops ls_pcie_ep_ops = {
 	.ep_init = ls_pcie_ep_init,
 	.raise_irq = ls_pcie_ep_raise_irq,
 	.get_features = ls_pcie_ep_get_features,
+	.func_conf_select = ls_pcie_ep_func_conf_select,
+};
+
+static const struct ls_pcie_ep_drvdata ls1_ep_drvdata = {
+	.ops = &ls_pcie_ep_ops,
+	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
+};
+
+static const struct ls_pcie_ep_drvdata ls2_ep_drvdata = {
+	.func_offset = 0x20000,
+	.ops = &ls_pcie_ep_ops,
+	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
+};
+
+static const struct of_device_id ls_pcie_ep_of_match[] = {
+	{ .compatible = "fsl,ls1046a-pcie-ep", .data = &ls1_ep_drvdata },
+	{ .compatible = "fsl,ls1088a-pcie-ep", .data = &ls2_ep_drvdata },
+	{ .compatible = "fsl,ls2088a-pcie-ep", .data = &ls2_ep_drvdata },
+	{ },
 };
 
 static int __init ls_add_pcie_ep(struct ls_pcie_ep *pcie,
@@ -103,7 +134,7 @@ static int __init ls_add_pcie_ep(struct ls_pcie_ep *pcie,
 	int ret;
 
 	ep = &pci->ep;
-	ep->ops = &pcie_ep_ops;
+	ep->ops = pcie->drvdata->ops;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
@@ -142,20 +173,23 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	if (!ls_epc)
 		return -ENOMEM;
 
-	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
+	pcie->drvdata = of_device_get_match_data(dev);
 
-	pci->dbi_base2 = pci->dbi_base + PCIE_DBI2_OFFSET;
 	pci->dev = dev;
-	pci->ops = &ls_pcie_ep_ops;
-	pcie->pci = pci;
+	pci->ops = pcie->drvdata->dw_pcie_ops;
 
 	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
 
+	pcie->pci = pci;
 	pcie->ls_epc = ls_epc;
 
+	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	pci->dbi_base2 = pci->dbi_base + PCIE_DBI2_OFFSET;
+
 	platform_set_drvdata(pdev, pcie);
 
 	ret = ls_add_pcie_ep(pcie, pdev);
-- 
2.17.1

