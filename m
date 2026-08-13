Return-Path: <linuxppc-dev+bounces-25790-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76887C5CFEB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:06:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLFHT5msZz2ybQ;
	Thu, 13 Aug 2026 16:06:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786601205;
	cv=none; b=aqprj+94/kj17oc4fkOGf1k2UhNlpIB55RB53pgPSVC2Wuw2Yj6eXWWwTJXX2xFRLskMArhynqQcVzdGwrovpRHn1NvZTOcC96QIPvjclRe6wdA6pNYj7CGptQISLctpGu9SxHFq8LRylDQHg3tae7S7XPCOqoVlkRAi3ZgCwBu7ilb+HUyOQX6t/PNnzWXA+EqdTEa+gb15YHfBH16LA3DD9dXqi+RdRxRbPSc56ADbSwbJxOSTcXG42uFXTdjBId+6CiYhwi4GlHybl1e9oSXsRPq6Tx+5412n4jgh/rzGYGO6tO16r19aCVNfZlsuxp7mBh3Uef28iAUt5B/A0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786601205; c=relaxed/relaxed;
	bh=2bRU4db2xtFcGOhDIJOKkQ4ShBGU9e2BMEUZzod3loM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bq4LBHFWhdhdLVo85K421B1XMlO7em6ABqvOu13OQGMFSquZMLjT+pwRivx2TaTIZCw/L01JqiG1m568/Tt1VczRLITPpo3wlt2IJxpoGtXieUxGcWwXDvm+mlJ/IEngVAOEdbO1baCtqIEo7NW4AUJSDvTYc2GBPwIpnRFMHDmgWhp6ghrP/i5hMLhLBVsMXvD5+CPdDiE+HQiTRMJ6e5VJlGuiLwSu1JtmCH18aa0nwVjU+WKS/Gw4/sUCz+QrhzsO5z0PcjxYNbCa+q2q9/mToBt1buGu23rRB66/Ww9xAmcH3EbE7yPQj2paoiTnDpAkhbl+5NH8LBgkn+/iPQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WepnVrP8; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WepnVrP8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLFHR4K48z2yXj
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:06:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 2042F41649;
	Thu, 13 Aug 2026 06:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2EA1F000E9;
	Thu, 13 Aug 2026 06:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786601201;
	bh=2bRU4db2xtFcGOhDIJOKkQ4ShBGU9e2BMEUZzod3loM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WepnVrP8FwDHztG5a+pL5+vdR+Cg8T4y90PcZBh/rlnZNWLRLfnDWWRxVJvS0+crZ
	 lh7fpDVlbqh/6qvpmhacKyRBEAArsqvbDDRNZsTZ84+InSYC+LQE/2ApqTgrggsNhH
	 YhxB5J0+AVZSQsk4LoO4+RjU9GDi4VJ7LjJUaYY3sLwr0c5vz/7/bRPur4asCQDR1r
	 cNVYLKjWL4z4LWF+Z0JghcCDVi9WN26c7VGLvxJXgFSrnHhF5fGl1dbGiWnRcm8sU1
	 SI1/W2qha+159VhpFETiKxPs27GXkyYyN7ajSyXNSy7VOA36iIT+UpNy1PI2kQZa1m
	 WhxFEX5ERcXyQ==
Date: Thu, 13 Aug 2026 08:06:31 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	jingoohan1@gmail.com, imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/16] PCI: dwc: Use cached PCIe capability offset in
 core
Message-ID: <ps2qzgcb5lixkoqz2xbofdurkgmsiojg7e5ueqfdhyissqvzf2@tuderrjgzg6b>
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-3-18255117159@163.com>
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
In-Reply-To: <20260720150619.24733-3-18255117159@163.com>

On Mon, Jul 20, 2026 at 11:06:05PM +0800, Hans Zhang wrote:
> Modify the DWC core functions to use the cached pcie_cap offset instead
> of calling dw_pcie_find_capability() each time.
> 
> In the DWC core, dw_pcie_find_capability() is called at several locations:
> - dw_pcie_ep_init_non_sticky_registers()
> - dw_pcie_wait_for_link()
> - dw_pcie_link_set_max_speed()
> - dw_pcie_link_get_max_link_width()
> - dw_pcie_link_set_max_link_width()
> 
> The cached offset is initialized after hardware is ready:
> - In host mode: dw_pcie_host_init() calls pp->ops->host_init() (enables
>   clocks/resets), then dw_pcie_get_pcie_cap() caches the offset.
> - In endpoint mode: the core no longer caches automatically. Instead,
>   drivers must call dw_pcie_get_pcie_cap() after hardware is enabled
>   (e.g., after PERST# deassert).

But you didn't modify all DWC EP drivers to call dw_pcie_get_pcie_cap(). This
can lead to pcie_cap being 0.

> dw_pcie_ep_init_non_sticky_registers()
>   is called after that point, so it can safely use pci->pcie_cap.
> 
> dw_pcie_ep_init_non_sticky_registers() now assumes pci->pcie_cap is
> valid. if not, it prints a warning and skips the operation.

Where is this warning printed?

These are already pointed out by Sashiko. You should go really go through all of
them (not the pre-existing issues) and comment whether the issues are valid or
false positive. For a series touching many controller drivers, this is necessary
to avoid introducing regressions.

I'm not going to merge this series until you fix the real issues Sashiko
reported or mark them as false positive if not valid.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

