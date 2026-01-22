Return-Path: <linuxppc-dev+bounces-16131-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15081C44536
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Jan 2026 09:07:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxZwC4nhkz2yql;
	Thu, 22 Jan 2026 20:07:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769072875;
	cv=none; b=hWAdHZo0jPww5ualDeGdVuA+uAOLI1xbCGDTnxCNxvGal0OmzPOkQOC76Qju8uT6vUgvfL9dZJaLHnpCsMUkxAKn1vYt7tZ6skfu9BbM+mHs7p0pme7U7/IyrPsonolNtw/9CtdrSUGsWCoJx/9+t2QqXDgAlLX+IeduVkHchid6mabrFplKEcaAU7t3mYRmO66idLfusDEXKATilaHH65zewYwb4PfzEUJB9ljHT+yVWTYsCYOdq8tL3U7LvQR1Zs+kbXNJGRytUPapX3zhC/S4RQ2ERrCi8FFdSaCKPZeyVKIIpXK1N2YjLlcd60tcxZM7Kq8XH5Kwf5DCOv5HiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769072875; c=relaxed/relaxed;
	bh=ibUasVZFzxkcMxQFTPnZMyZGIxSAFw73I56MfsiwU3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9c+8IImZsIDUmg5Yacr1vi+fre5ju/eNYOR0oLNxowbitCM34cH2eg7SAk677J8x9zt6/QAbjaRGiUKWF1IDpwVCvdejZdEZ/e0LJgC7Hvjf0hRj07/FV3swirtFCEwu925oUpR7rAv5eLsbqFgJ4H3VVDYXcWNxosncJ2c986qnPpLsNTwOJGljcazxzsR8uJ8NPVsYCy87NPmCZL2NY8h7GkYWCnOKbjHtCR1h2gnSHQeE1txpy5HxZBfIRHC3oIDAjKdc9dzsdqPUtmZAVCCgve12V2nB0tqWszd2BNHuuZfDhlY0jUuAwnrTCC+LHY/qlv8hc10KxDesQQ4qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hgCpabng; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hgCpabng;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxZwB6y0sz2xS5
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2026 20:07:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 034DC600C4;
	Thu, 22 Jan 2026 09:07:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850BEC116C6;
	Thu, 22 Jan 2026 09:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769072871;
	bh=AgonMyAfa9uiPAYfh9C/Bgq2TL9WZTm/OGzex9FWfw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgCpabng6JJHn8xRpFIZe3jTHR9hU+5UBwyWFBOynni6OUUO5/1LoqwoNeWABlfHH
	 gFmvsu+Ub6HroBHFQTsKy+WnxPMz/gQd32yzv35wwosxYpo/r5KPPNHf3S8poDZQ1t
	 HISyuOKpUtPye2gQr26v0sinjWCgnIQYxi5rUZ8wg/pqcqs5ipg8mXkbJumpMhnWR7
	 EXBy2GsYM/M4JjzUfFP3ECw10Z7D8Bfohlp4OSOeSOPVyRSQRir/Lo2mT1CUbha70Z
	 A3+ca+pqctDTrEzrRZ1OKIfJYqzm2ukB26n/6MxUMKSJjmcRWe9D5UpYHAncWnxW3r
	 TwSzrWaOtE4jA==
Date: Thu, 22 Jan 2026 10:07:37 +0100
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
Subject: Re: [PATCH v9 5/5] Documentation: PCI: endpoint: Clarify
 pci_epc_set_bar() usage
Message-ID: <aXHo2YDMkMnFb2LI@ryzen>
References: <20260122084909.2390865-1-den@valinux.co.jp>
 <20260122084909.2390865-6-den@valinux.co.jp>
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
In-Reply-To: <20260122084909.2390865-6-den@valinux.co.jp>

On Thu, Jan 22, 2026 at 05:49:09PM +0900, Koichiro Den wrote:
> The current documentation implies that pci_epc_set_bar() is only used
> before the host enumerates the endpoint.
> 
> In practice, some Endpoint Controllers support calling pci_epc_set_bar()
> multiple times for the same BAR (without clearing it) in order to update
> inbound address translations after the host has programmed the BAR base
> address, which some Endpoint Functions such as vNTB already rely on.
> Add document text for that.
> 
> Also document the expected call flow for BAR subrange mapping
> (pci_epf_bar.num_submap / pci_epf_bar.submap), which may require a
> second pci_epc_set_bar() call after the host has programmed the BAR base
> address.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>

