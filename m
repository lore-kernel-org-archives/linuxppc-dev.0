Return-Path: <linuxppc-dev+bounces-18202-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC341F3026D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 15 Mar 2026 16:38:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYkS53nRHz2yYy;
	Mon, 16 Mar 2026 03:38:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773592709;
	cv=none; b=AZuf4zR+UHLU5Zkzh1KA9MOjJUWrLMW8ewvSaj263k4w2YNPpJapKFhYV48/gpPk6r8iyhsdC7QbZmPpSvJbhdoxHzaMLPUuPVdoqcgBY2RXe01MQ3iWb0pdVbnd6IXZwXSlEFT8tdcNqiyGHP6+1iQIaf5peUUZ00bfjuJZ+bu2N7SHPuCnv/UUA740MtTV7SvNJ3r2SCg54xW6KR07UHCcGnlbfLcZl8Eh+WegjMaeUZ0b+50+nl7W0nDY0SiiNs6z+DdO+MtTkV+j31cOfzT2+zkn70fKaM2ZpQZUXTfyRPKw+AhS9ESvqKmK8KlM/OAT8rg11ThrIRgv73Wa2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773592709; c=relaxed/relaxed;
	bh=XUkhvXHpb7XQFGjW3OshHIHAFOoHGp14cCTXJnKMwRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvGjoYRKzqT1/8lhKrxxk07ptGj8ysmXp0ZTDPgv1d2lRJO894686UoYD4DXKB/zZGGWJ1oF4duAq5F+JsI0X/W9Hc4P6TsPiu+DRN9H/xcrjftdiqmxjZEJd0yf2fGbCA3WtZrLvpG22atOmokSlAboaM1JSnOt5NtEXMTAQNtzpVVII4EGOSbwwGT0mVt0JCRszzXr9wqTW4y3zW9j2iKoEo8f1fqlJXDnGKw8OhsBUooOeYc6QsJX0NcLBb1BhrlVCDzPgykiU8kl5jf/F/Qd62s+F0SS1waZw9XSBI4pjh3OXbUYcz4GZzUA0O/60dVlFHHtzoTyWEUWY4bYxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ODlndx/l; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ODlndx/l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYkS41nXxz2yF1
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Mar 2026 03:38:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 64AD2600CB;
	Sun, 15 Mar 2026 16:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A308C4CEF7;
	Sun, 15 Mar 2026 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773592705;
	bh=WrNeMYsAA03DHVECs98FC7knzVMNjLmWyKvwlzN4Krw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODlndx/l2BTSbPjRspV9GLT7+5T3/4XNm1uJzTAR5k+bHedYGFbm7JcgrzbAMgwWW
	 h3t+0iwi22VFwi/vk45Kz2w9HYLdExgXOq8xBGIQKNkp/kZKGRqwYWpyQfSimyVgB7
	 WrKPZMlYKJl6FxwhgiR9lK+Hi0KC8ofixzUzYoWcVFS2xLl6FqTtVBCdp6trj9wHFZ
	 G1cjoMWJmWsNxRMB0F4r6FJFjTbPCymS+hka/0zDBbmt7PBcrnAvIG9To3of5IcfVp
	 JWhdazvUhIMZ2QhFYQA0dxWVuzXyQyBnyelMGJ1ME9cZe/XmLRTuJJVXnFz+VDnPI7
	 1D2bXfJj7EFFg==
Date: Sun, 15 Mar 2026 22:08:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
	Jesper Nilsson <jesper.nilsson@axis.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Heiko Stuebner <heiko@sntech.de>, Srikanth Thokala <srikanth.thokala@intel.com>, 
	Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Christian Bruel <christian.bruel@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>, Koichiro Den <den@valinux.co.jp>, 
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 00/10] PCI: endpoint: Differentiate between disabled
 and reserved BARs
Message-ID: <skfqxnugt4t7eidfny5ojczq3wpu4u5yjfd6wdk3ikjmbgru7t@63nfqvrl5mvs>
References: <20260312130229.2282001-12-cassel@kernel.org>
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
In-Reply-To: <20260312130229.2282001-12-cassel@kernel.org>

On Thu, Mar 12, 2026 at 02:02:28PM +0100, Niklas Cassel wrote:
> Hello all,
> 
> This series was originally written in response to the patch series from
> Manikanta Maddireddy that was posted here:
> https://lore.kernel.org/linux-pci/291dab65-3fa6-4fc8-90a2-4ad608ca015c@nvidia.com/T/#t
> 
> Manikanta has reviewed this series and will send a small series on top of
> this one.
> 

Applied to pci/endpoint, thanks!

- Mani

> 
> Changes since v3:
> -Modified patch 1 to simply drop BAR_RESERVED for a BAR following an
>  only_64bit BAR (Manivannan).
> -Added a patch from Manikanta, to make his follow-up series smaller,
>  since this series touches the same lines anyway.
> 
> Link to v3:
> https://lore.kernel.org/linux-pci/20260302095913.48155-11-cassel@kernel.org/
> 
> 
> Koichiro Den (2):
>   PCI: endpoint: Describe reserved subregions within BARs
>   PCI: dw-rockchip: Describe RK3588 BAR4 DMA ctrl window
> 
> Manikanta Maddireddy (1):
>   PCI: endpoint: Allow only_64bit on BAR_RESERVED
> 
> Niklas Cassel (7):
>   PCI: endpoint: Do not mark the BAR succeeding a 64-bit BAR as
>     BAR_RESERVED
>   PCI: endpoint: Introduce pci_epc_bar_type BAR_DISABLED
>   PCI: dwc: Replace certain BAR_RESERVED with BAR_DISABLED in glue
>     drivers
>   PCI: dwc: Disable BARs in common code instead of in each glue driver
>   PCI: endpoint: pci-epf-test: Advertise reserved BARs
>   misc: pci_endpoint_test: Give reserved BARs a distinct error code
>   selftests: pci_endpoint: Skip reserved BARs
> 
>  drivers/misc/pci_endpoint_test.c              | 21 ++++++++-
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  4 --
>  drivers/pci/controller/dwc/pci-imx6.c         | 22 +++------
>  drivers/pci/controller/dwc/pci-keystone.c     | 12 +++++
>  .../pci/controller/dwc/pci-layerscape-ep.c    |  6 ---
>  drivers/pci/controller/dwc/pcie-artpec6.c     |  4 --
>  .../pci/controller/dwc/pcie-designware-ep.c   | 24 ++++++++++
>  .../pci/controller/dwc/pcie-designware-plat.c | 10 ----
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 23 ++++++----
>  drivers/pci/controller/dwc/pcie-keembay.c     |  3 --
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     | 12 -----
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c   | 16 ++-----
>  drivers/pci/controller/dwc/pcie-stm32-ep.c    | 10 ----
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 19 ++------
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c | 19 +-------
>  drivers/pci/controller/pcie-rcar-ep.c         |  3 --
>  drivers/pci/endpoint/functions/pci-epf-test.c | 24 ++++++++++
>  drivers/pci/endpoint/pci-epc-core.c           |  5 +-
>  include/linux/pci-epc.h                       | 46 +++++++++++++++----
>  .../pci_endpoint/pci_endpoint_test.c          |  4 ++
>  20 files changed, 154 insertions(+), 133 deletions(-)
> 
> 
> base-commit: 0b74f7d72399d4c4422ed3d68ef28b3612f71e74
> -- 
> 2.53.0
> 

-- 
மணிவண்ணன் சதாசிவம்

