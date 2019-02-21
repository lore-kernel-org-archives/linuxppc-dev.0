Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B8FC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:27:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414D82086D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414D82086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444fzN2xtPzDqNk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 14:27:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=92.121.34.13; helo=inva020.nxp.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444ft90GsxzDqGT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 14:22:40 +1100 (AEDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 08B1B1A0055;
 Thu, 21 Feb 2019 04:22:38 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C0D861A0322;
 Thu, 21 Feb 2019 04:22:28 +0100 (CET)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 42AF840309;
 Thu, 21 Feb 2019 11:22:17 +0800 (SGT)
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
 shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
 lorenzo.pieralisi@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
 kstewart@linuxfoundation.org, pombredanne@nexb.com,
 shawn.lin@rock-chips.com, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv7 3/4] pci: layerscape: Add the EP mode support.
Date: Thu, 21 Feb 2019 11:16:19 +0800
Message-Id: <20190221031620.43554-3-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190221031620.43554-1-xiaowei.bao@nxp.com>
References: <20190221031620.43554-1-xiaowei.bao@nxp.com>
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
Cc: Xiaowei Bao <xiaowei.bao@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add the PCIe EP mode support for layerscape platform.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Reviewed-by: Minghuan Lian <minghuan.lian@nxp.com>
Reviewed-by: Zhiqiang Hou <zhiqiang.hou@nxp.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
---
depends on: https://patchwork.kernel.org/project/linux-pci/list/?series=66177

v2:
 - remove the EP mode check function.
v3:
 - modif the return value when enter default case.
v4:
 - no change.
v5:
 - no change.
v6:
 - modify the code base on the submit patch of the EP framework.
v7:
 - fix up the compile warning issue.

 drivers/pci/controller/dwc/Makefile            |    2 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c |  156 ++++++++++++++++++++++++
 2 files changed, 157 insertions(+), 1 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pci-layerscape-ep.c

diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 7bcdcdf..b5f3b83 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -8,7 +8,7 @@ obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
-obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
+obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o pci-layerscape-ep.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
new file mode 100644
index 0000000..a42c9c3
--- /dev/null
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe controller EP driver for Freescale Layerscape SoCs
+ *
+ * Copyright (C) 2018 NXP Semiconductor.
+ *
+ * Author: Xiaowei Bao <xiaowei.bao@nxp.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/of_pci.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+
+#include "pcie-designware.h"
+
+#define PCIE_DBI2_OFFSET		0x1000	/* DBI2 base address*/
+
+struct ls_pcie_ep {
+	struct dw_pcie		*pci;
+};
+
+#define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
+
+static int ls_pcie_establish_link(struct dw_pcie *pci)
+{
+	return 0;
+}
+
+static const struct dw_pcie_ops ls_pcie_ep_ops = {
+	.start_link = ls_pcie_establish_link,
+};
+
+static const struct of_device_id ls_pcie_ep_of_match[] = {
+	{ .compatible = "fsl,ls-pcie-ep",},
+	{ },
+};
+
+static const struct pci_epc_features ls_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+};
+
+static const struct pci_epc_features*
+ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
+{
+	return &ls_pcie_epc_features;
+}
+
+static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar;
+
+	for (bar = BAR_0; bar <= BAR_5; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+}
+
+static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+				  enum pci_epc_irq_type type, u16 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
+	case PCI_EPC_IRQ_MSI:
+		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+	case PCI_EPC_IRQ_MSIX:
+		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
+	default:
+		dev_err(pci->dev, "UNKNOWN IRQ type\n");
+		return -EINVAL;
+	}
+}
+
+static struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = ls_pcie_ep_init,
+	.raise_irq = ls_pcie_ep_raise_irq,
+	.get_features = ls_pcie_ep_get_features,
+};
+
+static int __init ls_add_pcie_ep(struct ls_pcie_ep *pcie,
+					struct platform_device *pdev)
+{
+	struct dw_pcie *pci = pcie->pci;
+	struct device *dev = pci->dev;
+	struct dw_pcie_ep *ep;
+	struct resource *res;
+	int ret;
+
+	ep = &pci->ep;
+	ep->ops = &pcie_ep_ops;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
+	if (!res)
+		return -EINVAL;
+
+	ep->phys_base = res->start;
+	ep->addr_size = resource_size(res);
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dev, "failed to initialize endpoint\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init ls_pcie_ep_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci;
+	struct ls_pcie_ep *pcie;
+	struct resource *dbi_base;
+	int ret;
+
+	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
+	if (!pcie)
+		return -ENOMEM;
+
+	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
+	if (!pci)
+		return -ENOMEM;
+
+	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	pci->dbi_base2 = pci->dbi_base + PCIE_DBI2_OFFSET;
+	pci->dev = dev;
+	pci->ops = &ls_pcie_ep_ops;
+	pcie->pci = pci;
+
+	platform_set_drvdata(pdev, pcie);
+
+	ret = ls_add_pcie_ep(pcie, pdev);
+
+	return ret;
+}
+
+static struct platform_driver ls_pcie_ep_driver = {
+	.driver = {
+		.name = "layerscape-pcie-ep",
+		.of_match_table = ls_pcie_ep_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+builtin_platform_driver_probe(ls_pcie_ep_driver, ls_pcie_ep_probe);
-- 
1.7.1

