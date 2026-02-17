Return-Path: <linuxppc-dev+bounces-16905-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADA2E909A5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Feb 2026 14:00:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fFh9v3YR9z3bf2;
	Wed, 18 Feb 2026 01:00:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771336835;
	cv=none; b=TJAZdsP42Hgik+N8EppYK5e2DrqqLO5UolgQ8KOJyrwEiCjNTOn0/+csWji4QFkal8LyApi7GKH6NwF84T8rV4FdZTU02uALQQrRSGnaw7u2MXlZseSDR19GBJlkm8e7EpYSUUgrzeq1k7SFH7BTng6cFaw8Zr7dk/YcHTR9p2IqyVyHdvZRRIrhEfz7iFbTs5ok7YUnKjKlD/JsqzpL/RBXXhNAwimiv0G0YDom+VZdl7s7kSe9dEtv1FoEfvL8tHLz+t5Q7KAf/2pPJDSc9EpUC5AQUcU7Ivgiu0N3xNDMbqEOMan4qfjTlG626jsCIRpVcf6xQSSH1m9RE4O0rA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771336835; c=relaxed/relaxed;
	bh=ZmPrnyv/+FZTH6VDdM2O3zmdqKfG83XfIifD6E7nKFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRd/970eOS7Z9eGL8fVFG1JTxhVwkh0kbSTBIbS4Njnh76pOlirGWFSAYEp04njq+crQ7v9Iub3u6GfP63I7LBQw333JtfQaUwA1pAl3nGtKvvA1qxypS9hLYwHm7p7h1EFIsvDHrUegCP+uAq1ghuTqpZAxFP4tgG/vXLULgmlZ/7GQD+5Hg8o52xQTpN14Wnq+HZ80+JGVi4+a59FAYoxjSJvzf4xGovHXlHcT4gn+yhlswVXKi3Z4mn836scs5m0ahY4Wo03zBRuxUuCeHwk61rcWgXQdXA/HnJRsOFmEPbwpK529IesHQsqx3kWHR6EH2KkPg0TQFZM3cwzSTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jmH4cT3S; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jmH4cT3S;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fFh9t3hFcz30hr
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2026 01:00:34 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1CB4160128;
	Tue, 17 Feb 2026 14:00:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC8CC19423;
	Tue, 17 Feb 2026 14:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771336831;
	bh=yZ7EZjJ35vE1okONnm6nlL8GwNn4qtBojbitFN7sh+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmH4cT3Sx9zCRZQH9kFVGIW5ensgdZJTn4zf48NZ0YIB5BBUVYe/yZsiM/TYW6vwC
	 HZm8v8gds4F9qE+hm3rVhCNougf376hLCEhkLbD1loeG8gWj+hsahepoTD8lB6MGD1
	 cigUXjIg3vvTFDAWpna9VMH2+QrdThxiCuV8wmRPZF+XyKxszSrJVtH3ueDgsyIcTu
	 gseHHGa6vH4aNL2TPSu/iyflRGBzXaabqwa15SbYUlgbezZLNONS9JEXFNYzuLpxTZ
	 ghIWeLYGiXKqgfRTTjKwTr0bdfxQIqmCcAd5wTOHC5HWJrTT7hUgnHGZZHlwbyRPi7
	 pnZxxaNiP6jBA==
Date: Tue, 17 Feb 2026 19:30:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] PCI: layerscape: Allow to compile as module
Message-ID: <a3fn5vt73n6ggnr6euuba7gbmv7uhx4c6wdelxwtkcdzn2dn7e@btqsm5glgffr>
References: <20260112-v6-19-topic-layerscape-pcie-v1-1-1cd863fce50e@pengutronix.de>
 <20260216-mahogany-caterpillar-of-certainty-38b0bc-mkl@pengutronix.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260216-mahogany-caterpillar-of-certainty-38b0bc-mkl@pengutronix.de>

On Mon, Feb 16, 2026 at 10:49:42PM +0100, Marc Kleine-Budde wrote:
> Hello,
> 
> Bjorn can you take this patch?
> 

Will do once -rc1 is out.

- Mani

> On 12.01.2026 20:17:11, Steffen Trumtrar wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >
> > The layerscape pcie host controller could also be compiled as module.
> > Add the necessary infrastructure to allow building as module instead of
> > only as builtin driver.
> >
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > ---
> >  drivers/pci/controller/dwc/Kconfig          |  2 +-
> >  drivers/pci/controller/dwc/pci-layerscape.c | 16 +++++++++++++++-
> >  2 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 519b59422b479..abfa4a6e62c25 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -121,7 +121,7 @@ config PCI_IMX6_EP
> >  	  DesignWare core functions to implement the driver.
> >
> >  config PCI_LAYERSCAPE
> > -	bool "Freescale Layerscape PCIe controller (host mode)"
> > +	tristate "Freescale Layerscape PCIe controller (host mode)"
> >  	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
> >  	depends on PCI_MSI
> >  	select PCIE_DW_HOST
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> > index a44b5c256d6e2..14d6ac4fc53fd 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/init.h>
> >  #include <linux/iopoll.h>
> > +#include <linux/module.h>
> >  #include <linux/of_pci.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/of_address.h>
> > @@ -403,8 +404,16 @@ static const struct dev_pm_ops ls_pcie_pm_ops = {
> >  	NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq, ls_pcie_resume_noirq)
> >  };
> >
> > +static void ls_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct ls_pcie *pcie = platform_get_drvdata(pdev);
> > +
> > +	dw_pcie_host_deinit(&pcie->pci->pp);
> > +}
> > +
> >  static struct platform_driver ls_pcie_driver = {
> >  	.probe = ls_pcie_probe,
> > +	.remove = ls_pcie_remove,
> >  	.driver = {
> >  		.name = "layerscape-pcie",
> >  		.of_match_table = ls_pcie_of_match,
> > @@ -412,4 +421,9 @@ static struct platform_driver ls_pcie_driver = {
> >  		.pm = &ls_pcie_pm_ops,
> >  	},
> >  };
> > -builtin_platform_driver(ls_pcie_driver);
> > +module_platform_driver(ls_pcie_driver);
> > +
> > +MODULE_AUTHOR("Minghuan Lian <Minghuan.Lian@freescale.com>");
> > +MODULE_DESCRIPTION("Layerscape PCIe host controller driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
> >
> > ---
> > base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> > change-id: 20260112-v6-19-topic-layerscape-pcie-9d10b6542139
> >
> > Best regards,
> > --
> > Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >
> >
> 
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung Nürnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



-- 
மணிவண்ணன் சதாசிவம்

