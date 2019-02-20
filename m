Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDFEC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 10:07:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA5A20C01
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 10:07:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA5A20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444Cvz0MsYzDqLp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 21:07:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=arm.com
 (client-ip=217.140.101.70; helo=foss.arm.com;
 envelope-from=lorenzo.pieralisi@arm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arm.com
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 444CtB54sqzDq8F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 21:06:09 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB8C1A78;
 Wed, 20 Feb 2019 02:06:07 -0800 (PST)
Received: from red-moon (red-moon.cambridge.arm.com [10.1.197.39])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 497753F575;
 Wed, 20 Feb 2019 02:06:04 -0800 (PST)
Date: Wed, 20 Feb 2019 10:06:14 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCHv6 3/4] pci: layerscape: Add the EP mode support.
Message-ID: <20190220100614.GA27057@red-moon>
References: <20190122063328.25228-1-xiaowei.bao@nxp.com>
 <20190122063328.25228-3-xiaowei.bao@nxp.com>
 <20190219112721.GA15442@e107981-ln.cambridge.arm.com>
 <HE1PR04MB3306890D5A1656EC818521A2F57D0@HE1PR04MB3306.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HE1PR04MB3306890D5A1656EC818521A2F57D0@HE1PR04MB3306.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Roy Zang <roy.zang@nxp.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kishon@ti.com" <kishon@ti.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
 Mingkai Hu <mingkai.hu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 20, 2019 at 03:09:01AM +0000, Xiaowei Bao wrote:
> 
> 
> -----Original Message-----
> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> 
> Sent: 2019年2月19日 19:27
> To: Xiaowei Bao <xiaowei.bao@nxp.com>
> Cc: bhelgaas@google.com; robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; Leo Li <leoyang.li@nxp.com>; kishon@ti.com; arnd@arndb.de; gregkh@linuxfoundation.org; M.h. Lian <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang <roy.zang@nxp.com>; kstewart@linuxfoundation.org; cyrille.pitchen@free-electrons.com; pombredanne@nexb.com; shawn.lin@rock-chips.com; linux-pci@vger.kernel.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCHv6 3/4] pci: layerscape: Add the EP mode support.
> 
> On Tue, Jan 22, 2019 at 02:33:27PM +0800, Xiaowei Bao wrote:
> > Add the PCIe EP mode support for layerscape platform.
> > 
> > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > Reviewed-by: Minghuan Lian <minghuan.lian@nxp.com>
> > Reviewed-by: Zhiqiang Hou <zhiqiang.hou@nxp.com>
> > Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> > depends on: 
> > https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpat
> > chwork.kernel.org%2Fproject%2Flinux-pci%2Flist%2F%3Fseries%3D66177&amp
> > ;data=02%7C01%7Cxiaowei.bao%40nxp.com%7C6f8772ba47c74d8ee0aa08d6965d3e
> > b4%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C636861724572611193&amp
> > ;sdata=b3Acj0fu7c9vSoHe9VzeAkEMbMkpyfYPsXtf6fA8Flk%3D&amp;reserved=0
> > 
> > v2:
> >  - remove the EP mode check function.
> > v3:
> >  - modif the return value when enter default case.
> > v4:
> >  - no change.
> > v5:
> >  - no change.
> > v6:
> >  - modify the code base on the submit patch of the EP framework.
> 
> Can I apply this series to my pci/endpoint branch (where I queued Kishon's EP features rework patches) ? Can you check please ?
> [Xiaowei Bao] of course, in my patch, I found a compile warning, but
> this series patch have approved by you, I don't know how to do, the
> compile warning: " struct pci_epc *epc = ep->epc;" in
> "ls_pcie_ep_init" function, I am so sorry, could you help me remove
> this code, thanks a lot.

If you want me to apply your patches you need to rebase them against
my pci/endpoint branch and make sure the code is correct, I have
applied your previous series but as you know it failed because it
depends on Kishon's clean-up series.

So rebase your code against my pci/endpoint branch, make sure it
compiles with no warnings, test it and send a v7.

Thanks,
Lorenzo

> Thanks,
> Lorenzo
> 
> >  drivers/pci/controller/dwc/Makefile            |    2 +-
> >  drivers/pci/controller/dwc/pci-layerscape-ep.c |  157 
> > ++++++++++++++++++++++++
> >  2 files changed, 158 insertions(+), 1 deletions(-)  create mode 
> > 100644 drivers/pci/controller/dwc/pci-layerscape-ep.c
> > 
> > diff --git a/drivers/pci/controller/dwc/Makefile 
> > b/drivers/pci/controller/dwc/Makefile
> > index 7bcdcdf..b5f3b83 100644
> > --- a/drivers/pci/controller/dwc/Makefile
> > +++ b/drivers/pci/controller/dwc/Makefile
> > @@ -8,7 +8,7 @@ obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
> >  obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
> >  obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> >  obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
> > -obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
> > +obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o pci-layerscape-ep.o
> >  obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
> >  obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
> >  obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o diff --git 
> > a/drivers/pci/controller/dwc/pci-layerscape-ep.c 
> > b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > new file mode 100644
> > index 0000000..ddc2dbb
> > --- /dev/null
> > +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > @@ -0,0 +1,157 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * PCIe controller EP driver for Freescale Layerscape SoCs
> > + *
> > + * Copyright (C) 2018 NXP Semiconductor.
> > + *
> > + * Author: Xiaowei Bao <xiaowei.bao@nxp.com>  */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/of_address.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/resource.h>
> > +
> > +#include "pcie-designware.h"
> > +
> > +#define PCIE_DBI2_OFFSET		0x1000	/* DBI2 base address*/
> > +
> > +struct ls_pcie_ep {
> > +	struct dw_pcie		*pci;
> > +};
> > +
> > +#define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
> > +
> > +static int ls_pcie_establish_link(struct dw_pcie *pci) {
> > +	return 0;
> > +}
> > +
> > +static const struct dw_pcie_ops ls_pcie_ep_ops = {
> > +	.start_link = ls_pcie_establish_link, };
> > +
> > +static const struct of_device_id ls_pcie_ep_of_match[] = {
> > +	{ .compatible = "fsl,ls-pcie-ep",},
> > +	{ },
> > +};
> > +
> > +static const struct pci_epc_features ls_pcie_epc_features = {
> > +	.linkup_notifier = false,
> > +	.msi_capable = true,
> > +	.msix_capable = false,
> > +};
> > +
> > +static const struct pci_epc_features* ls_pcie_ep_get_features(struct 
> > +dw_pcie_ep *ep) {
> > +	return &ls_pcie_epc_features;
> > +}
> > +
> > +static void ls_pcie_ep_init(struct dw_pcie_ep *ep) {
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	struct pci_epc *epc = ep->epc;
> > +	enum pci_barno bar;
> > +
> > +	for (bar = BAR_0; bar <= BAR_5; bar++)
> > +		dw_pcie_ep_reset_bar(pci, bar);
> > +}
> > +
> > +static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> > +				  enum pci_epc_irq_type type, u16 interrupt_num) {
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +
> > +	switch (type) {
> > +	case PCI_EPC_IRQ_LEGACY:
> > +		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
> > +	case PCI_EPC_IRQ_MSI:
> > +		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
> > +	case PCI_EPC_IRQ_MSIX:
> > +		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
> > +	default:
> > +		dev_err(pci->dev, "UNKNOWN IRQ type\n");
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static struct dw_pcie_ep_ops pcie_ep_ops = {
> > +	.ep_init = ls_pcie_ep_init,
> > +	.raise_irq = ls_pcie_ep_raise_irq,
> > +	.get_features = ls_pcie_ep_get_features, };
> > +
> > +static int __init ls_add_pcie_ep(struct ls_pcie_ep *pcie,
> > +					struct platform_device *pdev)
> > +{
> > +	struct dw_pcie *pci = pcie->pci;
> > +	struct device *dev = pci->dev;
> > +	struct dw_pcie_ep *ep;
> > +	struct resource *res;
> > +	int ret;
> > +
> > +	ep = &pci->ep;
> > +	ep->ops = &pcie_ep_ops;
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
> > +	if (!res)
> > +		return -EINVAL;
> > +
> > +	ep->phys_base = res->start;
> > +	ep->addr_size = resource_size(res);
> > +
> > +	ret = dw_pcie_ep_init(ep);
> > +	if (ret) {
> > +		dev_err(dev, "failed to initialize endpoint\n");
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int __init ls_pcie_ep_probe(struct platform_device *pdev) {
> > +	struct device *dev = &pdev->dev;
> > +	struct dw_pcie *pci;
> > +	struct ls_pcie_ep *pcie;
> > +	struct resource *dbi_base;
> > +	int ret;
> > +
> > +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +
> > +	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
> > +	if (!pci)
> > +		return -ENOMEM;
> > +
> > +	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> > +	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
> > +	if (IS_ERR(pci->dbi_base))
> > +		return PTR_ERR(pci->dbi_base);
> > +
> > +	pci->dbi_base2 = pci->dbi_base + PCIE_DBI2_OFFSET;
> > +	pci->dev = dev;
> > +	pci->ops = &ls_pcie_ep_ops;
> > +	pcie->pci = pci;
> > +
> > +	platform_set_drvdata(pdev, pcie);
> > +
> > +	ret = ls_add_pcie_ep(pcie, pdev);
> > +
> > +	return ret;
> > +}
> > +
> > +static struct platform_driver ls_pcie_ep_driver = {
> > +	.driver = {
> > +		.name = "layerscape-pcie-ep",
> > +		.of_match_table = ls_pcie_ep_of_match,
> > +		.suppress_bind_attrs = true,
> > +	},
> > +};
> > +builtin_platform_driver_probe(ls_pcie_ep_driver, ls_pcie_ep_probe);
> > --
> > 1.7.1
> > 
