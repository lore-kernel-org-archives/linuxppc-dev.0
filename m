Return-Path: <linuxppc-dev+bounces-16133-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311C7C44536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 09:23:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxbG06KHyz2yFm;
	Thu, 22 Jan 2026 20:23:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769073800;
	cv=none; b=YJz0DWCweA3YgpInMZSVIIb5F3bbl+dQuisrOfw51NKBRPqub9xA3iTnZAQhAcDxQc+zfKp5btifepCZG/JfWnnkpChfouR542YJtKiTSlqKy430SjJ2qLTgP/OhchZ+CcbUi3/s63k/ZnKi9BAjIYENF1uML+mlAytKAaGH5CFerOhTMqtJBlc+qJcoRROr+xKamEcrIkvRBSTsZzq/HPfS0Ou+AyiEA+cipNcH2G85Q5TM23XWlnRo8w/G89S4WCkWw3H7y7wphumx/p+m2O/ynOvE950pOzC672A/Usvvn4fNFnl+v0CNqtmr1d0u7inPIrkoiSI88h2cNoJ3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769073800; c=relaxed/relaxed;
	bh=ram8+9i3Koc+jvtAoNYL0Z1nqbzjVDqnFE4zkDDmXLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYReQ+ydF7sKTbzs7xmpthkhfyxh34Y3F+hLk3Eurt4mZLzJLhUGYpPl3jCDxKIe9mcG5g6AqkbS90eJNccUmgv+v0TP1tkqF/jCO/B2eQejHES/vHYFw9aL+aaHI1Q3a8bNygYMrKNDRkE1gEFGjH71UqqqP1f1So65VTFTImY9m7/FC0wlLhwXlIOwxYUcOb9mB3HcNOtjs/cK+77l6JCqsJR3veLQNOD394t2SLGqtnF02KF47gQ44xowLE5sQtXq8YemHQMGRsiujmueYPKSstBEJBXD3A7E57a87e1ANsVed6iQV0daKibHikk/kZfVsjib5KtrPrU3wcs4Ew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i/d07n/X; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=i/d07n/X;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxbFz6Hd3z2xS5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2026 20:23:19 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D6B5E44191;
	Thu, 22 Jan 2026 09:23:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884DDC19423;
	Thu, 22 Jan 2026 09:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769073797;
	bh=yJdKxIhYOUpUaBpsLGMKL4pD24z5wQ6BB3Ktu++YZqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/d07n/XiyO/GYZA1Yd61IttxQ1mcR7bpCASWYbyei4lGJrH3PzHwefIKkxhhG09v
	 s9iROZk+AcPE1TdQ6wq2CuzVLOdZLG00uls+kKsGdO7o2a835s1hR7nfr3lHNKxahc
	 WInb/vUcRfD54E3+d9LLeGUTAFbeRlunWUOAe7Sg475DZoOrmt5E9Y11BEfWsTnxEA
	 jcCrYjAyE3xNwG+HYbDG5Sk3kA5856FxsG5fQfOuOxTSCbemYdcpjucRZIE2C2vRE4
	 iENgMKmwOc/YEnCZixdTiAK1LlKU1woO2U5+vPN+6Mvz69683ULDROGOXRqdESB3gr
	 dFtW0t7lKni2Q==
Date: Thu, 22 Jan 2026 10:23:03 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com,
	l.stach@pengutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com, minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com, roy.zang@nxp.com, jesper.nilsson@axis.com,
	heiko@sntech.de, srikanth.thokala@intel.com,
	marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	christian.bruel@foss.st.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, hayashi.kunihiko@socionext.com,
	mhiramat@kernel.org, kishon@kernel.org, jirislaby@kernel.org,
	rongqianfeng@vivo.com, 18255117159@163.com,
	shawn.lin@rock-chips.com, nicolas.frattaroli@collabora.com,
	linux.amoon@gmail.com, vidyas@nvidia.com, Frank.Li@nxp.com,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v9 4/5] PCI: dwc: ep: Support BAR subrange inbound
 mapping via Address Match Mode iATU
Message-ID: <aXHsd7-WWAGyhy_w@ryzen>
References: <20260122084909.2390865-1-den@valinux.co.jp>
 <20260122084909.2390865-5-den@valinux.co.jp>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122084909.2390865-5-den@valinux.co.jp>

On Thu, Jan 22, 2026 at 05:49:08PM +0900, Koichiro Den wrote:
> Extend dw_pcie_ep_set_bar() to support inbound mappings for BAR
> subranges using Address Match Mode IB iATU when pci_epf_bar.num_submap
> is non-zero.
> 
> Rename the existing BAR-match helper into dw_pcie_ep_ib_atu_bar() and
> introduce dw_pcie_ep_ib_atu_addr() for Address Match Mode. When
> num_submap is non-zero, read the assigned BAR base address and program
> one inbound iATU window per subrange. Validate the submap array before
> programming:
> - each subrange is aligned to pci->region_align
> - subranges cover the whole BAR (no gaps and no overlaps)
> - subranges are sorted in ascending order by offset
> 
> Track Address Match Mode mappings and tear them down on clear_bar() and
> on set_bar() error paths to avoid leaving half-programmed state or
> untranslated BAR holes.
> 
> Advertise this capability by extending the common feature bit
> initializer macro (DWC_EPC_COMMON_FEATURES).
> 
> This enables multiple inbound windows within a single BAR, which is
> useful on platforms where usable BARs are scarce but EPFs need multiple
> inbound regions.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---


> @@ -331,6 +503,13 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  		    ep->epf_bar[bar]->flags != flags)
>  			return -EINVAL;
>  
> +		/*
> +		 * When dynamically changing a BAR, tear down any existing
> +		 * mappings before re-programming.
> +		 */
> +		if (ep->epf_bar[bar]->num_submap || epf_bar->num_submap)
> +			dw_pcie_ep_clear_ib_maps(ep, bar);
> +
>  		/*
>  		 * When dynamically changing a BAR, skip writing the BAR reg, as
>  		 * that would clear the BAR's PCI address assigned by the host.
> @@ -369,8 +548,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  	else
>  		type = PCIE_ATU_TYPE_IO;
>  
> -	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
> -				     size);
> +	if (epf_bar->num_submap)
> +		ret = dw_pcie_ep_ib_atu_addr(ep, func_no, type, epf_bar);
> +	else
> +		ret = dw_pcie_ep_ib_atu_bar(ep, func_no, type,
> +					    epf_bar->phys_addr, bar, size);

If someone calls set_bar() with a submap, without having called set_bar() first
without a submap, we will still call dw_pcie_ep_ib_atu_addr() here.

To make sure that dw_pcie_ep_ib_atu_addr() cannot be called without already
having a BAR configured, to we perhaps want something like:

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0567552b784c..fe26b7f7b212 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -487,6 +487,9 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
        if ((flags & PCI_BASE_ADDRESS_MEM_TYPE_64) && (bar & 1))
                return -EINVAL;
 
+       if (!ep->epf_bar[bar] && epf_bar->num_submap)
+               return -EINVAL;
+
        /*
         * Certain EPF drivers dynamically change the physical address of a BAR
         * (i.e. they call set_bar() twice, without ever calling clear_bar(), as


or


diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 0567552b784c..8aeaa6fe53f9 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -475,6 +475,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
        struct dw_pcie_ep *ep = epc_get_drvdata(epc);
        struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
        enum pci_barno bar = epf_bar->barno;
+       bool use_addr_match_mode = false;
        size_t size = epf_bar->size;
        enum pci_epc_bar_type bar_type;
        int flags = epf_bar->flags;
@@ -510,6 +511,9 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
                if (ep->epf_bar[bar]->num_submap || epf_bar->num_submap)
                        dw_pcie_ep_clear_ib_maps(ep, bar);
 
+               if (epf_bar->num_submap)
+                       use_addr_match_mode = true;
+
                /*
                 * When dynamically changing a BAR, skip writing the BAR reg, as
                 * that would clear the BAR's PCI address assigned by the host.
@@ -548,7 +552,7 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
        else
                type = PCIE_ATU_TYPE_IO;
 
-       if (epf_bar->num_submap)
+       if (use_addr_match_mode)
                ret = dw_pcie_ep_ib_atu_addr(ep, func_no, type, epf_bar);
        else
                ret = dw_pcie_ep_ib_atu_bar(ep, func_no, type,

