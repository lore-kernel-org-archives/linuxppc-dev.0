Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7582CC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 16:25:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B843E20834
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 16:25:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B843E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43609C44LRzDrPj
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Dec 2018 03:25:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=lorenzo.pieralisi@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 43606K0zkczDr40
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Dec 2018 03:22:30 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1659BA78;
 Fri, 30 Nov 2018 08:22:28 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com
 [10.1.197.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 887E03F5AF;
 Fri, 30 Nov 2018 08:22:24 -0800 (PST)
Date: Fri, 30 Nov 2018 16:22:15 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv2 5/6] pci: layerscape: Add the EP mode support.
Message-ID: <20181130162214.GA23332@e107981-ln.cambridge.arm.com>
References: <20181105084653.26597-1-xiaowei.bao@nxp.com>
 <20181105084653.26597-5-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105084653.26597-5-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: mark.rutland@arm.com, roy.zang@nxp.com, linuxppc-dev@lists.ozlabs.org,
 arnd@arndb.de, devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
 kstewart@linuxfoundation.org, niklas.cassel@axis.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com,
 minghuan.Lian@nxp.com, robh+dt@kernel.org, cyrille.pitchen@free-electrons.com,
 linux-arm-kernel@lists.infradead.org, pombredanne@nexb.com,
 bhelgaas@google.com, leoyang.li@nxp.com, shawnguo@kernel.org,
 shawn.lin@rock-chips.com, mingkai.hu@nxp.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Nov 05, 2018 at 04:46:52PM +0800, Xiaowei Bao wrote:
> Add the PCIe EP mode support for layerscape platform.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
> v2:
>  - remove the EP mode check function.
> 
>  drivers/pci/controller/dwc/Makefile            |    2 +-
>  drivers/pci/controller/dwc/pci-layerscape-ep.c |  147 ++++++++++++++++++++++++
>  2 files changed, 148 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/pci/controller/dwc/pci-layerscape-ep.c
> 
> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
> index 5d2ce72..b26d617 100644
> --- a/drivers/pci/controller/dwc/Makefile
> +++ b/drivers/pci/controller/dwc/Makefile
> @@ -8,7 +8,7 @@ obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
>  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone-dw.o pci-keystone.o
> -obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> +obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o pci-layerscape-ep.o
>  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
>  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
>  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> new file mode 100644
> index 0000000..289618b
> --- /dev/null
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -0,0 +1,147 @@
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

I am not really sure why you need an additional struct.

> +#define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)

Unused.

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
> +	}
> +
> +	return 0;

So if it falls through to the default, we log an error but return 0 ? This
does not make much sense.

I know you probably copy/pasted code from DWC platform, that code must
be fixed too I suppose.

Lorenzo

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
> -- 
> 1.7.1
> 
