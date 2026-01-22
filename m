Return-Path: <linuxppc-dev+bounces-16129-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8000DC44500
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 09:00:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxZlc0LJzz2yFm;
	Thu, 22 Jan 2026 20:00:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769072427;
	cv=none; b=EonnzQb6qLQNLqyAmgZIWZg7580Aj5JXVu1Yjzrvseas7euS+mYf1cOmKihWS8nQe/rdRatUNo9nDIHshh+lDHOPKcPrFcGb6FKZB7TY0YLmQ+1hNK6q07r9J7bxmheXcGw0J6VpBFRFRDV4d6c8WCd3+5bq3vseNKlqrrdZljX6YL/HhLM0dQLGIxT2hF9b6ie/5nJgVkgDsiNzSg65Yih5xh1Cb+Ow1dR4vg/2fJ2BKOLTfzBkk1DwvfgOGNyu/xKOngTzSKjjhr+xGAB7Ear+ivuszbl7fBVFw9JAqNYqM/Jj93xxYZXA2xRZi6jrCEYqprtAEL+VgWPRGr0dcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769072427; c=relaxed/relaxed;
	bh=O69fvAcg0CcdfclIDOUGR4yRfQYhZ4TApHh5YakhXRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kybOeUEOkXYzdKn+g3+bwi/1QvBFIMMLTD/3JV52++mHrCX5oG4YBcZrlFSPMEpoAGtndoHxYj+7brU5eGx8bFgkiTMZhxhPiDkRFaCzb8a5TtigyTgrvd6CX/4vuotZmeV3jx+bNKYD5XxppuEhpDObc+nlu3vNJO6av/wlabLc7hcJfp1MafWp8RdZncXcxYURQIqLbWc5Ar6+SMS078tsCe3o1kbTSQGooQnMpkvAhuJOY35VFY1x4iZpagiWAZBuaPoCowmmmljW9nyQPuQAcmvF7d6Eew2Fi0jostLoO4k2bE0fKjHtz9wzgXUrR9UEBJH+eJO1ZbDZv5lOYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mp8ENmYQ; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Mp8ENmYQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxZlb37G1z2xS5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2026 20:00:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6449A4189B;
	Thu, 22 Jan 2026 09:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C6BC116C6;
	Thu, 22 Jan 2026 09:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769072425;
	bh=AZFYl95tZw83k2fEE48wfdvR4CXEcLULoc8pMv1G/Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mp8ENmYQVtJ1EMYz0X8bkcVxWU+gCr8Fgt+QaEj8GkJ+34FS+nBT+LQC9OkGsQezu
	 5MApqwdB08KOLxvl+IburfuHXNQwD8Hy3mGkN83wSQCKFWXy8QOF21LPMxQAnImFrV
	 SkRbS529Iy5egC5SypGHdJ0kyuctrmmCIyqot1zcplQxuH6Qlu5SFF+stcyxOJXr5c
	 uzdOee9LlPwxuBMCk/ODtg5TSEF4vV4AqMSBKNX0vNQbRYxGG7YWc/VADSk+i4tTdb
	 9OPXRV7NVJwsOJhuvpYlIs4O+x+cHQX67sgm2Pis2uH67qGA4dAmdBaLXIBiD1b50T
	 DVt46F3Vf1GSg==
Date: Thu, 22 Jan 2026 10:00:11 +0100
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
Subject: Re: [PATCH v9 3/5] PCI: dwc: Advertise dynamic inbound mapping
 support
Message-ID: <aXHnFskw9InGNuuR@ryzen>
References: <20260122084909.2390865-1-den@valinux.co.jp>
 <20260122084909.2390865-4-den@valinux.co.jp>
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
In-Reply-To: <20260122084909.2390865-4-den@valinux.co.jp>

On Thu, Jan 22, 2026 at 05:49:07PM +0900, Koichiro Den wrote:
> The DesignWare EP core has supported updating the inbound iATU mapping
> for an already configured BAR (i.e. allowing pci_epc_set_bar() to be
> called again without a prior pci_epc_clear_bar()) since commit
> 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update
> inbound map address").
> 
> Now that this capability is exposed via the dynamic_inbound_mapping EPC
> feature bit, set it for DWC-based EP glue drivers using a common
> initializer macro to avoid duplicating the same flag in each driver.
> 
> Note that pci-layerscape-ep.c is untouched. It currently constructs the
> feature struct dynamically in ls_pcie_ep_init(). Once converted to a
> static feature definition, it will use DWC_EPC_COMMON_FEATURES as well.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

