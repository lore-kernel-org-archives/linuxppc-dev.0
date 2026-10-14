Return-Path: <linuxppc-dev+bounces-29508-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213EDC3DA7A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 19:37:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4hKm1Lk2z2yqs;
	Thu, 15 Oct 2026 06:37:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792006620;
	cv=none; b=Nuqiq7frjauYjl6SkEb4D1t0alC0BIWABeYJiuc1jP0dcU9NQIbynFlJUSdDv5iffGQi2cZM+w49GehGftAgRQWyPP5YY5BCNM5drUhi8iNciFeZ+fTzZFwJpV/PJGUr6eQCpEzVjGvN0ZkgBoQgup4cT+f054IJD7yFtM4GbottHH8AL00YLUgbapNzmtMgBx5hhu3HQJASqpIhLvWvKup6r/fIdAemT2I7a002j2gpXgwj6GpVH3yx3Ek5Qkhx1pxaD2oojDdRwEYO4TzkRTxBPOaeILMIiXJRq+aEnfaCMm9TFaXSAFBLtA+HJndOO29h1q5WYs3ka1tPDNRRlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792006620; c=relaxed/relaxed;
	bh=Nwo7fummJ1+6uAUT8/LcA06d2mBN1HNQjSCHgbIgjcU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Wzn8hmhOj7Mer2dn5O9F1s+I9qR35Vxw+a3vhB12AKor3lOlsSJXeLStNxjFPeXJvv1y3ZsbItKu88ip2hV/0zMfOLQyHEfuahdKuuQxaWZm4bOQzm5O9KbegvBEc7eRJ7703igjCZTXhJGsXLFJYtQ49dJOf0LcXasFAYK81wwbu61ZT+WVdA+AVqoG8M9pACDMJJgwycaEjezt93G++mrvrp+CxcMWIXs+tNF2IxkQNj5/mghmhkO0g5O+Aao+EsC3IJ3A/LL4cbjKXCQbqNiPydJkDw5SZc11ZspTddide6pHISyFCM94XGpG1XLdKGxIe02HfnUn4s3mFhPqRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVvcvc7U; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DVvcvc7U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4hKl1Nqdz2ynZ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 06:36:59 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E582B41523;
	Wed, 14 Oct 2026 19:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975291F000C4;
	Wed, 14 Oct 2026 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792006615;
	bh=Nwo7fummJ1+6uAUT8/LcA06d2mBN1HNQjSCHgbIgjcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=DVvcvc7UX80k12qRiHESe3D5qMFFVXrS38E48C9Buz1YyN3x0yyLjfN8PE2O8obfo
	 z1EWyL8sTL4Zx59tmp6xOzDVuU7hCj2hbkXdM89M3tJdnXtlc9u49ZO+Lto+g3BsGu
	 hsyH6xqZqSuHs9uSkr1db02NQdGYUUb5hKuZQNs6e0mShBs1+p9oLvNshC5gBtfnxU
	 5ICHjv7tO8lQQurcDTA1KP612gBPLumtixcyZjH0oDoeejT+40FVxVkP9zTNGRb27e
	 QFXad8keYB8IZ/hC1pkcJr6OqlI6NaCTwLEk0M52Cn+ZuieNdgR4uXGSCl8QqcT2Fo
	 xOB+33S6zENxQ==
Date: Wed, 14 Oct 2026 14:36:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: vjardin@free.fr
Cc: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
	Roy Zang <roy.zang@nxp.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: layerscape: async probe by default
Message-ID: <20261014193654.GA1656473@bhelgaas>
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
In-Reply-To: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>

On Mon, Sep 28, 2026 at 03:48:09PM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> dw_pcie_wait_for_link() polls for up to
>   PCIE_LINK_WAIT_MAX_RETRIES x PCIE_LINK_WAIT_SLEEP_MS (10 x 90 ms)
> per controller.
> 
> The controllers are probed one after the other, so, it leads to slow
> boot time.
> 
> On an LX2160A board with 4 enabled controllers and no link on any
> of them, ls_pcie_driver_init took almost 4s.

"ls_pcie_driver_init" doesn't exist; I suppose this means
dw_pcie_host_init()?

> Probing the 4 in parallel allows to have it down to 1s.
> 
> The controllers are independent, other DWC based drivers are already
> using async probing such as qcom, imx6, s32g, rcar-gen4 or stm32.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 14d6ac4fc53f..7f37a0537159 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -419,6 +419,7 @@ static struct platform_driver ls_pcie_driver = {
>  		.of_match_table = ls_pcie_of_match,
>  		.suppress_bind_attrs = true,
>  		.pm = &ls_pcie_pm_ops,
> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  module_platform_driver(ls_pcie_driver);
> 
> ---
> base-commit: 94e8d4e94266bb9737a5963810a3f9365cb2f39d
> change-id: 20260928-for-upstream-pci-layerscape-async-probe-084cae5d0907
> 
> Best regards,
> -- 
> Vincent Jardin <vjardin@free.fr>
> 
> 

