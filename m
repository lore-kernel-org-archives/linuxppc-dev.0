Return-Path: <SRS0=gbiG=P5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D045C2F3A6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 13:21:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C4282084C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jan 2019 13:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DF9YKcBF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C4282084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43jsdS4w72zDqby
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Jan 2019 00:21:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ti.com
 (client-ip=198.47.19.141; helo=fllv0015.ext.ti.com;
 envelope-from=kishon@ti.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=ti.com header.i=@ti.com header.b="DF9YKcBF"; 
 dkim-atps=neutral
X-Greylist: delayed 8260 seconds by postgrey-1.36 at bilbo;
 Tue, 22 Jan 2019 00:19:37 AEDT
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43jsbF4JkrzDqTV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jan 2019 00:19:36 +1100 (AEDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0LB1XeP021658;
 Mon, 21 Jan 2019 05:01:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1548068493;
 bh=hhMlffWEnXAfq4XJujl8J/Qv93eZrx3xg3jx0yFJq28=;
 h=Subject:To:References:From:Date:In-Reply-To;
 b=DF9YKcBFXA6+kLbmXwxno3SusuryxTxXrzwpZ4mXj9A9Uimtdx9A6vKwl35/3NuoT
 LgcN6MrbK3MO8NcoNmNSr/qArx1SreI0+YxtKasPA3XA0XFhL+m3eU+fN3aaK3c30Y
 Qqzwlz4V1jFgtGpWhKG0jYaKN2iIn9/V7xjNFLK4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0LB1XcI022472
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 21 Jan 2019 05:01:33 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 05:01:33 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 05:01:33 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
 by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0LB1Rur003956;
 Mon, 21 Jan 2019 05:01:28 -0600
Subject: Re: [PATCHv5 3/4] pci: layerscape: Add the EP mode support.
To: Xiaowei Bao <xiaowei.bao@nxp.com>, <bhelgaas@google.com>,
 <robh+dt@kernel.org>, <mark.rutland@arm.com>, <shawnguo@kernel.org>,
 <leoyang.li@nxp.com>, <lorenzo.pieralisi@arm.com>, <arnd@arndb.de>,
 <gregkh@linuxfoundation.org>, <minghuan.Lian@nxp.com>,
 <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
 <kstewart@linuxfoundation.org>, <cyrille.pitchen@free-electrons.com>,
 <pombredanne@nexb.com>, <shawn.lin@rock-chips.com>,
 <niklas.cassel@axis.com>, <linux-pci@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>
References: <20190121094500.10657-1-xiaowei.bao@nxp.com>
 <20190121094500.10657-3-xiaowei.bao@nxp.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <0791e307-17c5-6f47-ae89-73bb5dc0f232@ti.com>
Date: Mon, 21 Jan 2019 16:31:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190121094500.10657-3-xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Xiaowei,

On 21/01/19 3:14 PM, Xiaowei Bao wrote:
> Add the PCIe EP mode support for layerscape platform.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Reviewed-by: Minghuan Lian <minghuan.lian@nxp.com>
> Reviewed-by: Zhiqiang Hou <zhiqiang.hou@nxp.com>

This patch looks good to me, except for using epc->features which I've tried to
get rid of in [1]. After Lorenzo's review, one of us have to change it to the
new design.

Thanks
Kishon

[1] -> https://patchwork.kernel.org/project/linux-pci/list/?series=66177
> ---
> v2:
>  - remove the EP mode check function.
> v3:
>  - modif the return value when enter default case.
> v4:
>  - no change.
> v5:
>  - no change.
> 
>  drivers/pci/controller/dwc/Makefile            |    2 +-
>  drivers/pci/controller/dwc/pci-layerscape-ep.c |  146 ++++++++++++++++++++++++
>  2 files changed, 147 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pci-layerscape-ep.c
> 
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 7bcdcdf..b5f3b83 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -8,7 +8,7 @@ obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
> -obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> +obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o pci-layerscape-ep.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> new file mode 100644
> index 0000000..dafb528
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * PCIe controller EP driver for Freescale Layerscape SoCs
> + *
> + * Copyright (C) 2018 NXP Semiconductor.
> + *
> + * Author: Xiaowei Bao <xiaowei.bao@nxp.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/of_pci.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_address.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/resource.h>
> +
> +#include "pcie-designware.h"
> +
> +#define PCIE_DBI2_OFFSET		0x1000	/* DBI2 base address*/
> +
> +struct ls_pcie_ep {
> +	struct dw_pcie		*pci;
> +};
> +
> +#define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
> +
> +static int ls_pcie_establish_link(struct dw_pcie *pci)
> +{
> +	return 0;
> +}
> +
> +static const struct dw_pcie_ops ls_pcie_ep_ops = {
> +	.start_link = ls_pcie_establish_link,
> +};
> +
> +static const struct of_device_id ls_pcie_ep_of_match[] = {
> +	{ .compatible = "fsl,ls-pcie-ep",},
> +	{ },
> +};
> +
> +static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct pci_epc *epc = ep->epc;
> +	enum pci_barno bar;
> +
> +	for (bar = BAR_0; bar <= BAR_5; bar++)
> +		dw_pcie_ep_reset_bar(pci, bar);
> +
> +	epc->features |= EPC_FEATURE_NO_LINKUP_NOTIFIER;
> +}
> +
> +static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> +				  enum pci_epc_irq_type type, u16 interrupt_num)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +
> +	switch (type) {
> +	case PCI_EPC_IRQ_LEGACY:
> +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> +	case PCI_EPC_IRQ_MSI:
> +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> +	case PCI_EPC_IRQ_MSIX:
> +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> +	default:
> +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static struct dw_pcie_ep_ops pcie_ep_ops = {
> +	.ep_init = ls_pcie_ep_init,
> +	.raise_irq = ls_pcie_ep_raise_irq,
> +};
> +
> +static int __init ls_add_pcie_ep(struct ls_pcie_ep *pcie,
> +					struct platform_device *pdev)
> +{
> +	struct dw_pcie *pci = pcie->pci;
> +	struct device *dev = pci->dev;
> +	struct dw_pcie_ep *ep;
> +	struct resource *res;
> +	int ret;
> +
> +	ep = &pci->ep;
> +	ep->ops = &pcie_ep_ops;
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> +	if (!res)
> +		return -EINVAL;
> +
> +	ep->phys_base = res->start;
> +	ep->addr_size = resource_size(res);
> +
> +	ret = dw_pcie_ep_init(ep);
> +	if (ret) {
> +		dev_err(dev, "failed to initialize endpoint\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int __init ls_pcie_ep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct dw_pcie *pci;
> +	struct ls_pcie_ep *pcie;
> +	struct resource *dbi_base;
> +	int ret;
> +
> +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> +	if (!pcie)
> +		return -ENOMEM;
> +
> +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> +	if (!pci)
> +		return -ENOMEM;
> +
> +	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> +	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
> +	if (IS_ERR(pci->dbi_base))
> +		return PTR_ERR(pci->dbi_base);
> +
> +	pci->dbi_base2 = pci->dbi_base + PCIE_DBI2_OFFSET;
> +	pci->dev = dev;
> +	pci->ops = &ls_pcie_ep_ops;
> +	pcie->pci = pci;
> +
> +	platform_set_drvdata(pdev, pcie);
> +
> +	ret = ls_add_pcie_ep(pcie, pdev);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver ls_pcie_ep_driver = {
> +	.driver = {
> +		.name = "layerscape-pcie-ep",
> +		.of_match_table = ls_pcie_ep_of_match,
> +		.suppress_bind_attrs = true,
> +	},
> +};
> +builtin_platform_driver_probe(ls_pcie_ep_driver, ls_pcie_ep_probe);
> 
