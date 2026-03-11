Return-Path: <linuxppc-dev+bounces-18010-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA71FD0620
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 06:36:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW1H82B72z30hP;
	Wed, 11 Mar 2026 17:36:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773210980;
	cv=none; b=RnkMqu+cMY3rPngjFfCqRJ7qn9VxCs+Up7z9YPOqZebWwIyRNZOycQWCZQon44lFOq57d7naDNOUyeCQ/9FNUFu/8urGy+TB4/iR+1i4iu57yW1hPV1d5J+/gaFNROnWoV3kPKn9SjHiszCQmddXESL7Sv3n1Jk5k8IJ1Ueg290mD/DtGTwGWUnMzofgpl1zy4Q+IwdsJ2YUoK0DRiTTfbKkJgXO/5GdaVlG7pJxgaEAn0AJe2dDzNfKAfPSUwHOnADd7LVYi6CHvhBWhZp/8IcMGR64kW3pcwTCJbC3mWMi7x4WH4Ql5PDPwHNWNERHwLNDPGJr6NVXDvdeXHyUaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773210980; c=relaxed/relaxed;
	bh=dy9KuQEbVQgzbwRcGgVxm/f+pSuLtPsEG/8Re2owlSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2pu2ZNeCh2hN2XiPtAWEamS01hc2/je1Dmm0KvWrsrEEhsNgfeTdYGQsmUK+4yOo/gd/vDMFmL1p1TgmJj47A6TIieH/Rl+duy5mO8aTafG8wboXAGYWI3xDuZTXQC5DYZJoKRrC/iTQvyhola3EOSbA/UwT4kZlbs2olXTYAc5IAomzUsh142fsrEJHZYl+gsSikS/wGeilXES0WSma3fEqC50hLvD4huCJ00ElWJss2S+s3SX8d8Esf27qti/0WOdOwIxLf5eglqF3wPddW2lfXPJMOImgqztgGY96xYGCI2XJPEFcfydpYesIDnZp+wHYupaLzqmGVNf/r7A6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fJYnITz2; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=fJYnITz2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW1H71yThz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 17:36:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4CB9F43C2C;
	Wed, 11 Mar 2026 06:36:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B7FC4CEF7;
	Wed, 11 Mar 2026 06:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773210977;
	bh=AaTYLl8pCEA3iXBWjihENeLR+q/W7z4IGa5dYA772EQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fJYnITz2osAqv0HH//ILVmEPzzOf8UT4nPZBKqx+knGPqv1f6TRUA7INVPTOtfYNK
	 IHjDdoKMq+rQ544yAK1id8Ee6ZsB/exdPnLaFhET8oE574S0L8gaMeBlbV+5zD1brD
	 cAe0fcMTGl75c4tXnpOWH3rRvl/11IPJrgaD3cC9Afin7LOJ88FCUAm9bFg4hEKj80
	 8tpfoCkdZB7aFKkwCPC1yJwEf0+NuWUVID9a9HjqZL09Ql9ZO2InbKNq21PYiPTN4w
	 F4QPa6cWdA69B5knnhLRvTN4ot63Na+2vyccxLuTRkqeYKUnN3txDXUJpRTRvrtUYF
	 Ecc8eG//9Vlng==
Date: Wed, 11 Mar 2026 12:05:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
	Roy Zang <roy.zang@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Srikanth Thokala <srikanth.thokala@intel.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Manikanta Maddireddy <mmaddireddy@nvidia.com>, 
	Koichiro Den <den@valinux.co.jp>, Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v3 1/9] PCI: endpoint: Introduce pci_epc_bar_type
 BAR_64BIT_UPPER
Message-ID: <dtxdgxrewfby5hu3cu3pu5kljylm627uc43sw75gk7loimmm6r@ei4w6wmqgd6a>
References: <20260302095913.48155-11-cassel@kernel.org>
 <20260302095913.48155-12-cassel@kernel.org>
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
In-Reply-To: <20260302095913.48155-12-cassel@kernel.org>

On Mon, Mar 02, 2026 at 10:59:13AM +0100, Niklas Cassel wrote:
> Add a pci_epc_bar_type BAR_64BIT_UPPER to more clearly differentiate from
> BAR_RESERVED.
> 
> This BAR type will only be used for a BAR following a "only_64bit" BAR.
> 
> This makes the BAR description more clear, and the reader does no longer
> need to check the BAR type for the preceding BAR to know how to interpret
> the BAR type.
> 

I find the naming a bit confusing. How about BAR_64BIT_UPPER_BASE? This also
brings the question, do we really need to mark the preceding BAR? Why can't we
let the PCI EPC core to always assume that if the previous BAR has 'only_64bit'
bit set, next BAR cannot be used as a standalone 32bit BAR?

I find it weird or redundant to mark both BARs.

- Mani

> No functional changes.
> 
> Tested-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Tested-by: Koichiro Den <den@valinux.co.jp>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pci-layerscape-ep.c |  4 ++--
>  drivers/pci/controller/dwc/pcie-keembay.c      |  6 +++---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c      |  4 ++--
>  drivers/pci/controller/dwc/pcie-tegra194.c     |  2 +-
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c  | 10 +++++-----
>  drivers/pci/controller/pcie-rcar-ep.c          |  6 +++---
>  drivers/pci/endpoint/pci-epc-core.c            |  3 ++-
>  include/linux/pci-epc.h                        |  5 ++++-
>  8 files changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> index a4a800699f89..5a03a8f895f9 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> @@ -251,9 +251,9 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
>  	pci->ops = pcie->drvdata->dw_pcie_ops;
>  
>  	ls_epc->bar[BAR_2].only_64bit = true;
> -	ls_epc->bar[BAR_3].type = BAR_RESERVED;
> +	ls_epc->bar[BAR_3].type = BAR_64BIT_UPPER;
>  	ls_epc->bar[BAR_4].only_64bit = true;
> -	ls_epc->bar[BAR_5].type = BAR_RESERVED;
> +	ls_epc->bar[BAR_5].type = BAR_64BIT_UPPER;
>  	ls_epc->linkup_notifier = true;
>  
>  	pcie->pci = pci;
> diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
> index 2666a9c3d67e..5a00b8cf5b53 100644
> --- a/drivers/pci/controller/dwc/pcie-keembay.c
> +++ b/drivers/pci/controller/dwc/pcie-keembay.c
> @@ -313,11 +313,11 @@ static const struct pci_epc_features keembay_pcie_epc_features = {
>  	.msi_capable		= true,
>  	.msix_capable		= true,
>  	.bar[BAR_0]		= { .only_64bit = true, },
> -	.bar[BAR_1]		= { .type = BAR_RESERVED, },
> +	.bar[BAR_1]		= { .type = BAR_64BIT_UPPER, },
>  	.bar[BAR_2]		= { .only_64bit = true, },
> -	.bar[BAR_3]		= { .type = BAR_RESERVED, },
> +	.bar[BAR_3]		= { .type = BAR_64BIT_UPPER, },
>  	.bar[BAR_4]		= { .only_64bit = true, },
> -	.bar[BAR_5]		= { .type = BAR_RESERVED, },
> +	.bar[BAR_5]		= { .type = BAR_64BIT_UPPER, },
>  	.align			= SZ_16K,
>  };
>  
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 18460f01b2c6..e55675b3840a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -850,9 +850,9 @@ static const struct pci_epc_features qcom_pcie_epc_features = {
>  	.msi_capable = true,
>  	.align = SZ_4K,
>  	.bar[BAR_0] = { .only_64bit = true, },
> -	.bar[BAR_1] = { .type = BAR_RESERVED, },
> +	.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
>  	.bar[BAR_2] = { .only_64bit = true, },
> -	.bar[BAR_3] = { .type = BAR_RESERVED, },
> +	.bar[BAR_3] = { .type = BAR_64BIT_UPPER, },
>  };
>  
>  static const struct pci_epc_features *
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 06571d806ab3..31aa9a494dbc 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1993,7 +1993,7 @@ static const struct pci_epc_features tegra_pcie_epc_features = {
>  	.msi_capable = true,
>  	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = SZ_1M,
>  			.only_64bit = true, },
> -	.bar[BAR_1] = { .type = BAR_RESERVED, },
> +	.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
>  	.bar[BAR_2] = { .type = BAR_RESERVED, },
>  	.bar[BAR_3] = { .type = BAR_RESERVED, },
>  	.bar[BAR_4] = { .type = BAR_RESERVED, },
> diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> index d52753060970..f873a1659592 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
> @@ -426,9 +426,9 @@ static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {
>  		.msix_capable = false,
>  		.align = 1 << 16,
>  		.bar[BAR_0] = { .only_64bit = true, },
> -		.bar[BAR_1] = { .type = BAR_RESERVED, },
> +		.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
>  		.bar[BAR_2] = { .only_64bit = true, },
> -		.bar[BAR_3] = { .type = BAR_RESERVED, },
> +		.bar[BAR_3] = { .type = BAR_64BIT_UPPER, },
>  		.bar[BAR_4] = { .type = BAR_RESERVED, },
>  		.bar[BAR_5] = { .type = BAR_RESERVED, },
>  	},
> @@ -445,11 +445,11 @@ static const struct uniphier_pcie_ep_soc_data uniphier_nx1_data = {
>  		.msix_capable = false,
>  		.align = 1 << 12,
>  		.bar[BAR_0] = { .only_64bit = true, },
> -		.bar[BAR_1] = { .type = BAR_RESERVED, },
> +		.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
>  		.bar[BAR_2] = { .only_64bit = true, },
> -		.bar[BAR_3] = { .type = BAR_RESERVED, },
> +		.bar[BAR_3] = { .type = BAR_64BIT_UPPER, },
>  		.bar[BAR_4] = { .only_64bit = true, },
> -		.bar[BAR_5] = { .type = BAR_RESERVED, },
> +		.bar[BAR_5] = { .type = BAR_64BIT_UPPER, },
>  	},
>  };
>  
> diff --git a/drivers/pci/controller/pcie-rcar-ep.c b/drivers/pci/controller/pcie-rcar-ep.c
> index 657875ef4657..9b3f5391fabe 100644
> --- a/drivers/pci/controller/pcie-rcar-ep.c
> +++ b/drivers/pci/controller/pcie-rcar-ep.c
> @@ -440,13 +440,13 @@ static const struct pci_epc_features rcar_pcie_epc_features = {
>  	/* use 64-bit BARs so mark BAR[1,3,5] as reserved */
>  	.bar[BAR_0] = { .type = BAR_FIXED, .fixed_size = 128,
>  			.only_64bit = true, },
> -	.bar[BAR_1] = { .type = BAR_RESERVED, },
> +	.bar[BAR_1] = { .type = BAR_64BIT_UPPER, },
>  	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = 256,
>  			.only_64bit = true, },
> -	.bar[BAR_3] = { .type = BAR_RESERVED, },
> +	.bar[BAR_3] = { .type = BAR_64BIT_UPPER, },
>  	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256,
>  			.only_64bit = true, },
> -	.bar[BAR_5] = { .type = BAR_RESERVED, },
> +	.bar[BAR_5] = { .type = BAR_64BIT_UPPER, },
>  };
>  
>  static const struct pci_epc_features*
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index e546b3dbb240..1ad2f62963c8 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -104,7 +104,8 @@ enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
>  
>  	for (i = bar; i < PCI_STD_NUM_BARS; i++) {
>  		/* If the BAR is not reserved, return it. */
> -		if (epc_features->bar[i].type != BAR_RESERVED)
> +		if (epc_features->bar[i].type != BAR_RESERVED &&
> +		    epc_features->bar[i].type != BAR_64BIT_UPPER)
>  			return i;
>  	}
>  
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index c021c7af175f..c22f8a6cf9a3 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -192,12 +192,15 @@ struct pci_epc {
>   *		   NOTE: An EPC driver can currently only set a single supported
>   *		   size.
>   * @BAR_RESERVED: The BAR should not be touched by an EPF driver.
> + * @BAR_64BIT_UPPER: Should only be set on a BAR if the preceding BAR is marked
> + *		     as only_64bit.
>   */
>  enum pci_epc_bar_type {
>  	BAR_PROGRAMMABLE = 0,
>  	BAR_FIXED,
>  	BAR_RESIZABLE,
>  	BAR_RESERVED,
> +	BAR_64BIT_UPPER,
>  };
>  
>  /**
> @@ -207,7 +210,7 @@ enum pci_epc_bar_type {
>   * @only_64bit: if true, an EPF driver is not allowed to choose if this BAR
>   *		should be configured as 32-bit or 64-bit, the EPF driver must
>   *		configure this BAR as 64-bit. Additionally, the BAR succeeding
> - *		this BAR must be set to type BAR_RESERVED.
> + *		this BAR must be set to type BAR_64BIT_UPPER.
>   *
>   *		only_64bit should not be set on a BAR of type BAR_RESERVED.
>   *		(If BARx is a 64-bit BAR that an EPF driver is not allowed to
> -- 
> 2.53.0
> 

-- 
மணிவண்ணன் சதாசிவம்

