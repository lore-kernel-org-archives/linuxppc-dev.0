Return-Path: <linuxppc-dev+bounces-17224-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F84CFD461F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 06:33:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fM1r150Ktz2yFc;
	Thu, 26 Feb 2026 17:33:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772087617;
	cv=none; b=mkSpSBq9mFoHNBzHfkeSffXLPheinRtoCwuckG+J8BHCLNTbe4tsHhsvr5fG3a+lTZgz0ydQJ/KOV24sgIQybYjclaySusH8jJux9DmY1bEgbQC7+fy7SAySQH4IG1CC9IvqWnjkFzjo14RRFrA5mkOdAkoKxJYruZ+vvUG2OPFkTld7v3lo7Pq/RpGRQIOHm+k1YdpWu5JEXrb1RKEOKdI1sYAv8OFOkywx1fK6HAEF48OZmV0t80ZFpQv3LDkvn9UXdiHuYOCQc4M7+zkvGKapNUJlEr4jEbU1RPxBQLidvTmZH+gNeMoL0T/gVQj7YGoGRTMOqLdsnGZP3qzO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772087617; c=relaxed/relaxed;
	bh=GZPmsmFndXQGjcjbVB8WI05coqZ1fJJnbk/j2C0mctg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1WSSDTPlN6kISE882U4cjqJGjGcXkAqh8R+IqL4CqmcdJE/2m6Iu8vxgsxYkpfQHoPUbTBpso9UJ0oQOfisBpBB2wXPBZd9IexdhdyBoE1TYEJJGC8B+YlPZwuTrR31f2O8AArpYOg/yqDF0/EdaVInq4+9lqOBQWpnAHNfA+AijUrudgGI5G0K18Z3YgLAGL0Eyr7LiefTuh+YM5aYZGnDlKTcHuyR30SNg6uk/ZDqVOdjp5KBEK350XlndOcwIWe5e8LVe2kp5sLzS08HKBDZPofnHOFDXhbMt00SmdJuPL/FXkTq6VAwMefJUkq8mE12T4lBppdq87gbAjjxFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hbGSrvcu; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hbGSrvcu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fM1r0427Zz2xMt
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2026 17:33:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B7FF060054;
	Thu, 26 Feb 2026 06:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C6FC19422;
	Thu, 26 Feb 2026 06:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772087613;
	bh=TQcjNDCthRmxoghOT2T0FWsXkA4piqIaaOpYR6a5s4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbGSrvcupcn+h4fSa+L/b7cSolIXGPrRwp3dyI0q9iPQYaqipe3QccDiDR54tHkHW
	 F+4AIwN/JRG5wOv/BWdUi71OGxvlhvmA2Is7wj2VbS3L7yoIZpWN2DNNJNHL4q0TdM
	 dcV1WucverRdKdncs4SYMtwxg800QKxv1DVxsKktYcExupBmWynxOmvBQvt6J+80aW
	 /pOkRY82quk9Y8q9pCTCwGS9oDzcaSTAf4QAHpMtsIFqqt07/OlbDMfTaHUuXxuSC6
	 Y2eVFhzbQB6Y+mdr+k8L8jd4To3IDy0BpTfFJoP/Gavqj0VrJNBHy0lMkBI5mfeFTJ
	 G2owFRTaeTFiA==
Date: Thu, 26 Feb 2026 12:03:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Minghuan Lian <minghuan.Lian@nxp.com>, 
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Jingoo Han <jingoohan1@gmail.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] PCI: layerscape: Allow to compile as module
Message-ID: <6xnmjhwm5mfrff6gyomwrnft3bfuxvun2cxi56lx6qvlugxg6l@yossniactj2r>
References: <20260112-v6-19-topic-layerscape-pcie-v1-1-1cd863fce50e@pengutronix.de>
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
In-Reply-To: <20260112-v6-19-topic-layerscape-pcie-v1-1-1cd863fce50e@pengutronix.de>

On Mon, Jan 12, 2026 at 08:17:11PM +0100, Steffen Trumtrar wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The layerscape pcie host controller could also be compiled as module.
> Add the necessary infrastructure to allow building as module instead of
> only as builtin driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>

Applied to controller/dwc-layerscape, thanks!

- Mani

> ---
>  drivers/pci/controller/dwc/Kconfig          |  2 +-
>  drivers/pci/controller/dwc/pci-layerscape.c | 16 +++++++++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> index 519b59422b479..abfa4a6e62c25 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -121,7 +121,7 @@ config PCI_IMX6_EP
>  	  DesignWare core functions to implement the driver.
>  
>  config PCI_LAYERSCAPE
> -	bool "Freescale Layerscape PCIe controller (host mode)"
> +	tristate "Freescale Layerscape PCIe controller (host mode)"
>  	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index a44b5c256d6e2..14d6ac4fc53fd 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -13,6 +13,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/iopoll.h>
> +#include <linux/module.h>
>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_address.h>
> @@ -403,8 +404,16 @@ static const struct dev_pm_ops ls_pcie_pm_ops = {
>  	NOIRQ_SYSTEM_SLEEP_PM_OPS(ls_pcie_suspend_noirq, ls_pcie_resume_noirq)
>  };
>  
> +static void ls_pcie_remove(struct platform_device *pdev)
> +{
> +	struct ls_pcie *pcie = platform_get_drvdata(pdev);
> +
> +	dw_pcie_host_deinit(&pcie->pci->pp);
> +}
> +
>  static struct platform_driver ls_pcie_driver = {
>  	.probe = ls_pcie_probe,
> +	.remove = ls_pcie_remove,
>  	.driver = {
>  		.name = "layerscape-pcie",
>  		.of_match_table = ls_pcie_of_match,
> @@ -412,4 +421,9 @@ static struct platform_driver ls_pcie_driver = {
>  		.pm = &ls_pcie_pm_ops,
>  	},
>  };
> -builtin_platform_driver(ls_pcie_driver);
> +module_platform_driver(ls_pcie_driver);
> +
> +MODULE_AUTHOR("Minghuan Lian <Minghuan.Lian@freescale.com>");
> +MODULE_DESCRIPTION("Layerscape PCIe host controller driver");
> +MODULE_LICENSE("GPL");
> +MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20260112-v6-19-topic-layerscape-pcie-9d10b6542139
> 
> Best regards,
> -- 
> Steffen Trumtrar <s.trumtrar@pengutronix.de>
> 

-- 
மணிவண்ணன் சதாசிவம்

