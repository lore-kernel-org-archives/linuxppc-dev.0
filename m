Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51538C27C65
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2024 22:07:36 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a/NzRHHA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VzN860rn8z3fsP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Jun 2024 08:07:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=a/NzRHHA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VzN7C51jFz3fnN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2024 08:06:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F10EE60E88;
	Tue, 11 Jun 2024 22:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDC81C2BD10;
	Tue, 11 Jun 2024 22:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718143604;
	bh=2z2T09bcbzfwexUZ5T7jD1TkbLjspNsoiYHpZ3OkpCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=a/NzRHHA81Kr/n5nwF8wLMmpSxDwQFBG1tf3wJl/ZX5qrZu3LoF/n38c1RQWAS3to
	 9PF0iBa1/cYKwSVYTUUEyS/nclJFBX6lIO5eO0x1Az0PTI0ZwlAsdX/khbFtfebn6E
	 YXiFVo4lds+SLiDkmm+nUPE/ZqefCzy2l8jaKYjZeHRpo24owJwxwC2tQwf1lgcI1s
	 jSWMaN02nOnAzTwxwp8JNo1/Rsd/DRVvo/SgDh50CtfMf0VE9bi5/DnHDINTWd02UU
	 HtDL2EuqVAPEfbwNIt35YzWTA4zlII6G6PiSRavH22Rynv/chO+GKlSJqnxKZZ2/Mp
	 +OmyobALds0Jg==
Date: Tue, 11 Jun 2024 17:06:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 2/5] PCI: endpoint: Introduce 'epc_deinit' event and
 notify the EPF drivers
Message-ID: <20240611220640.GA1001976@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606-pci-deinit-v1-2-4395534520dc@linaro.org>
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Vignesh Raghavendra <vigneshr@ti.com>, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, imx@lists.linux.dev, linux-pci@vger.kernel.org, Lorenzo Pieralisi <lpieralisi@kernel.org>, Minghuan Lian <minghuan.Lian@nxp.com>, Thierry Reding <thierry.reding@gmail.com>, Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-tegra@vger.kernel.org, linux-arm-kernel@axis.com, Jonathan Hunter <jonathanh@nvidia.com>, linux-arm-kernel@lists.infradead.org, Siddharth Vadapalli <s-vadapalli@ti.com>, Richard Zhu <hongxing.zhu@nxp.com>, Srikanth Thokala <srikanth.thokala@intel.com>, linux-arm-msm@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, Niklas Cassel <cassel@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, mhi@lists.linux.dev, linux-renesas-soc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jun 06, 2024 at 12:56:35PM +0530, Manivannan Sadhasivam wrote:
> As like the 'epc_init' event, that is used to signal the EPF drivers about
> the EPC initialization, let's introduce 'epc_deinit' event that is used to
> signal EPC deinitialization.
> 
> The EPC deinitialization applies only when any sort of fundamental reset
> is supported by the endpoint controller as per the PCIe spec.
> 
> Reference: PCIe Base spec v5.0, sections 4.2.4.9.1 and 6.6.1.

PCIe r6.0, sec 4.2.5.9.1 and 6.6.1.

(Not 4.2.4.9.1, which no longer exists in r6.x)

> Currently, some EPC drivers like pcie-qcom-ep and pcie-tegra194 support
> PERST# as the fundamental reset. So the 'deinit' event will be notified to
> the EPF drivers when PERST# assert happens in the above mentioned EPC
> drivers.
> 
> The EPF drivers, on receiving the event through the epc_deinit() callback
> should reset the EPF state machine and also cleanup any configuration that
> got affected by the fundamental reset like BAR, DMA etc...
> 
> This change also warrants skipping the cleanups in unbind() if already done
> in epc_deinit().
> 
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
