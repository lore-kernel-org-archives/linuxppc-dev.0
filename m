Return-Path: <linuxppc-dev+bounces-16222-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2E1D72354
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Jan 2026 08:51:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dyBVx0BTWz2yFK;
	Fri, 23 Jan 2026 19:51:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769158296;
	cv=none; b=Ic302C3jwsK2mN5IHLR7SVgDjg7Q3RpFgA1Aw4gsUPrGFaOXjbC7ieoIuwdqKHA9NpomJsjIdhtHGpwkZ39+6HFNsnceS4wDrzrL7DpdVWJi86WthMByT5UGTtrFEpXK/s0XpiPUS1cEn2i7N3hjgVkfbWxny6aWRWkXN3twyQjcd0Ybb7brqMTWmgaZOhnWrLzfiZLBV4WcmViN0WoNz/ftIPMIuD8DvZC4piCp7e1AiJ4FtLOZ54IkbQlDtlErYGrQbfcDJE0lecnPLW8mbLDz/TD7G/krJDq86aKTZ0lOiqVYpSFMX1L4deAuBSqw2TVqNGW06llWIbAmFb0s7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769158296; c=relaxed/relaxed;
	bh=nCWti0sH4cLf+A438VhiEo6h1/WcLMhMyAZK/wQD0Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klAVD2nEgKB5wQh0Hs9sq5m2uv8EdtK1LhJGmv5Ra0SMzWa0KCZPV63edP/TmQmjVMoJzCZFrWeGMz4/49FmR5R2glP8+lhbmY+pP/BvcY7Z6L7694gQryGPSK718o/BjtDSL6AkMI0kNum+712YQgEQAWEQXHPiGOp1ORs8IkNP9nAVK70BMQKpewXlCr+V7slXhb1i7x+e1cI+qEnyHt+pNvJRgyaTzDecu1w7nYIi4nIeURlfGpomTKJKxpBc22jnYORkV7xGG/2hslPRuTuqiDH+kL+7DYzTCBr7uTu9Ups8Xpttc1I/YqkfEIT3768rMTuHCZukmu1lKbVaWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P2x/rDF+; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P2x/rDF+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dyBVw05Tyz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jan 2026 19:51:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4B7E143891;
	Fri, 23 Jan 2026 08:51:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F06FC4CEF1;
	Fri, 23 Jan 2026 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769158292;
	bh=uHLu75YU3d5LFuDqYhNdrTluLj4QmEkgMjijx82wFVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P2x/rDF+V1S8nsKTuKOnD9QTwc41mF+XW6CEW4Lczf+0Sd6Nq5HQYPZljIkT06Qsr
	 wIpsWwJl7SNWJGjLv6Eul2oOhcXM+uSeslFw7p/fqlD351FGaNP7tTEeORpdakVZ2x
	 TqvkKLgYvEcqDaF0pIhEqdOwsfBiNwfz73XPMMzNpH57FqZjOmS6Ef5yIk1U5pEv3/
	 sDhbSopJR642hfZEnALQcni3Jw5qQtapD3e7lk65oHsqDb0Bur+Ix0+UDcHnBGwPU1
	 //bi+O56i4qSkHisywxprWy1WySWG064VdIew5tpiaTSmeiHZoS4N3KNcwNWuzGqID
	 JclBA/sfEIjRQ==
Date: Fri, 23 Jan 2026 09:51:19 +0100
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
Message-ID: <aXM2hwCrziK2I8OL@ryzen>
References: <20260122084909.2390865-1-den@valinux.co.jp>
 <20260122084909.2390865-5-den@valinux.co.jp>
 <aXHsd7-WWAGyhy_w@ryzen>
 <s6bnqkbuugi7oio7ybekdbk3dokpbe2bui2wjltdwajxix2app@wosgmhrfsriv>
 <19D609EC-F850-4B43-A83C-0B8C70E641B5@kernel.org>
 <l7wknbayighcczjkqfwhbaqrepjtbgxxstgkntoqvnrs7dnm6g@wvmy67ky37pv>
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
In-Reply-To: <l7wknbayighcczjkqfwhbaqrepjtbgxxstgkntoqvnrs7dnm6g@wvmy67ky37pv>

On Fri, Jan 23, 2026 at 10:16:21AM +0900, Koichiro Den wrote:
> >
> > There might be other EPC drivers that don't disable all BARs in their .init(), so I would say that simply checking if the BAR has an address is not sufficient to guarantee that an EPF driver has called set_bar().
> >
>
> Even if an EPC driver does not reset the BAR in their .init() and some
> default translation is left exposed, wouldn't it be safe as long as
> dw_pcie_ep_ib_atu_addr() succeeds in programming inbound mappings for the
> entire BAR?

For e.g. on RK3588, the default HW configuration of the DWC controller has
all 5 BARs as enabled, with a size of 1 GB.

There is no inbound address translation for these BARs by default.

So for it to be safe, the size of the set_bar() call would have to
match the current size of the BAR, but how should the EPF driver know
that when it has not called set_bar() yet?

dw_pcie_ep_read_bar_assigned() does not return the current size of the
BAR. So you can't verify that the set_bar() call has the same size as
the BARs "default size".


>
> That said, such usage apparently contradicts the documented usage (1st
> set_bar with no submap, then with submap) described in the docs and commit
> messages in this series, and allowing it would make things unnecessarily
> complicated. So I agree that adding such a safeguard is the right approach.
>
> >
> > I think the safest option is my second suggestion because then we know that we will only call
> > dw_pcie_ep_ib_atu_addr()
> >
> > When:
> >
> > 1) If ep->epf_bar[bar] is set:
> > https://github.com/torvalds/linux/blob/v6.19-rc6/drivers/pci/controller/dwc/pcie-designware-ep.c#L363
> >
> >
> > 2) All the other requirements to dynamically update a BAR is also met:
> >
> > https://github.com/torvalds/linux/blob/v6.19-rc6/drivers/pci/controller/dwc/pcie-designware-ep.c#L368-L370
> >
>
> That makes sense, and it ensures that the behavior always accords with the
> docs and commit messages in this series.

I think it makes most sense to put the "use_addr_translation = true"

after the check:

		/*
		 * We can only dynamically change a BAR if the new BAR size and
		 * BAR flags do not differ from the existing configuration.
		 */
		if (ep->epf_bar[bar]->barno != bar ||
		    ep->epf_bar[bar]->size != size ||
		    ep->epf_bar[bar]->flags != flags)
			return -EINVAL;


So we know that dw_pcie_ep_ib_atu_addr() is only called when the size is the
same.


Kind regards,
Niklas

