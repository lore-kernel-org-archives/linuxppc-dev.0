Return-Path: <linuxppc-dev+bounces-21159-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6CB1CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 13:58:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKbq23LFGz2yFP;
	Tue, 19 May 2026 23:58:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779199086;
	cv=none; b=d+R3RrpB9dUJqJHN9KTcdqm0n52+olxbbVp5xfNHVd2mV94ApzLw41y9JcYofhXqSS76bXbalWu7kL7H8UTdz11HWwj6uLH5PSykwZuQ6NLKyd6lyY16kZm4uVN34+flyXJOXpi4i3hO1WiL0sf3I2toODITYqBRO7WXXriXeEzxnW1lGcd+4KrWKIekr6U4VyTKR2iy/4yd1oTBmRyOuW82Hu+CESUrFoII8/yGocWci03XOjCU6vwMAMu8N5T4MqZc+h1y00tCRyvjbioSLBTc8XcC0vdkIzzyGb6R6gvnBN47iFomNBaduA/pds/5QAKJLgh5bdm9u4BPVF6HHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779199086; c=relaxed/relaxed;
	bh=/W4oxpzN1d7sPekN8lVKIaETlbzMCmju1+8WOS6FrPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQlJvqd+A+YM8gOFp8Y02plrVB/s7QgxfbxZMTjL69in+nvxy7D7ika7HOXdaDAYy9/OD6hHZGyULvwXV4lKaY12tPyc0dwz64kUNGZBoSVr5kz15A9uYSl4MzJaTR01WNKoDjgYR0snkTKsdwhYjlhUYxxl1NCcKTXIoeQz466JAYfICZ2l8Qg2NvYz2Iv2bf46SAglcs2RKArG0gf9/IO37jKnD9iCij6qf5w8Eb9lrIBG9YsHp15TSIJVnpsHd0pcGeQenIwD1jvJ4ZQLyfoPLHxU/8R1KZKl3NrF0Zs7QEoNYwjHwCbZTZzNdEPHMRMRyCVhnfrhG5UpY9Lnkw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IjXyKLC6; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=IjXyKLC6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKbq13cd7z2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:58:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E04B160121;
	Tue, 19 May 2026 13:58:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AC3C2BCB3;
	Tue, 19 May 2026 13:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779199082;
	bh=nfEX+4aODCvAUv+wyKcqPTid35QTc5cD/VwXCz3ADcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IjXyKLC6RnfU2IV5vALZIj8Ip/8qoyK/R3psuwMTG3JXO9BTcuOc3el0D8NNI8chT
	 s0gGRepmdjn02maEMVKdztKHkmL0PIRI1De0REdgunGfSBH+Jxn7oMMz0xGiu00Bnm
	 V2FTqeNiIYu+Dh6VViDLtkb4Ds0j2QzD96R1MrZyXxs7u8yH5s+l1TzD4x35lylgJ3
	 9/G+prDp/+eIrDIqw6OrAJVNIFWXJr5E3BqmCHSGMhvHJnGYTvBoElvWGf0y8kqAcN
	 2Iq5THM2nomRkDRaKihObdG6sjEnVdNnX2RH/YlaWNy/FEJXedmSno2xWIrD0A4HU7
	 zfFdSHFaj+oqg==
Date: Tue, 19 May 2026 19:27:53 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	jingoohan1@gmail.com, mx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, sophgo@lists.linux.dev, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI: dwc: Cache PCIe capability offset and simplify
 drivers
Message-ID: <beqy5ykxgo4ianya6r4mahkkyujs6lly475u26vqaemgqsdnhp@2pn5ipczwc34>
References: <20260509135152.2241235-1-18255117159@163.com>
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
In-Reply-To: <20260509135152.2241235-1-18255117159@163.com>

On Sat, May 09, 2026 at 09:51:49PM +0800, Hans Zhang wrote:
> The DWC PCIe core and its many platform drivers repeatedly call
> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
> PCI Express Capability structure. This is wasteful and makes the code
> verbose. And some even search for the PCI_CAP_ID_EXP offset value within
> the suspend/resume functions.
> 

Sashiko has flagged some real issues with this series in accessing DBI space
very early and 'pci->pcie_cap' being 0.

Those needs to be fixed.

- Mani

> Add a cached pcie_cap field in struct dw_pcie and a helper
> dw_pcie_get_pcie_cap() to initialize it once at probe time. Then replace
> all explicit capability searches with the cached value across the
> entire dwc subtree.
> 
> Hans Zhang (3):
>   PCI: dwc: Add pcie_cap field and helper in designware header
>   PCI: dwc: Use cached PCIe capability offset in core
>   PCI: dwc: Simplify platform drivers using cached capability offset
> 
>  drivers/pci/controller/dwc/pci-imx6.c         |  6 +--
>  .../pci/controller/dwc/pci-layerscape-ep.c    |  4 +-
>  drivers/pci/controller/dwc/pci-meson.c        |  4 +-
>  .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  4 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 16 +++---
>  drivers/pci/controller/dwc/pcie-designware.h  | 17 +++++++
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++---
>  drivers/pci/controller/dwc/pcie-eswin.c       |  3 +-
>  drivers/pci/controller/dwc/pcie-fu740.c       |  2 +-
>  drivers/pci/controller/dwc/pcie-intel-gw.c    |  2 +-
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     | 11 ++--
>  drivers/pci/controller/dwc/pcie-qcom.c        | 24 ++++-----
>  drivers/pci/controller/dwc/pcie-sophgo.c      |  8 ++-
>  drivers/pci/controller/dwc/pcie-spacemit-k1.c |  5 +-
>  drivers/pci/controller/dwc/pcie-spear13xx.c   |  6 +--
>  drivers/pci/controller/dwc/pcie-tegra194.c    | 51 +++++++------------
>  17 files changed, 85 insertions(+), 97 deletions(-)
> 
> 
> base-commit: 70390501d1944d4e5b8f7352be180fceb3a44132
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

