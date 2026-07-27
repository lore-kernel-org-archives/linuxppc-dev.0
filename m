Return-Path: <linuxppc-dev+bounces-24906-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5139DC531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 16:18:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h83gZ6G8Qz2yhD;
	Tue, 28 Jul 2026 02:18:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785169130;
	cv=none; b=P65PtxtbVcR/p9z9YvAwAvKw9lcWor9F9hD+td+USP0TYiFQPw7fqbocSWxJIWoWmFJG5fNrZG5oda32DBy9XIPA3TUBmzf1F7q/W5fKizJU9vG1Yn8wUHPGAKwKYLjlZUmd3tUsGfAa5CVt0iM3W0NSUqPXL4E7hw5SEEdtrRPQeI0+xYhMOiw0EBxu+pFrEgntpQOKgzwZWfKvcNFSRzJHF0PhfhQ6rJJPpL9gi+tAdkUEjVY/VETlVj176aHxf9P4VY79gDNO0OFehVlBkX40DH5NjQuRvhLQ/I7mTLWLjo+RAZKgTFjpGzWmVtmr0clYaNcjLE+/pZzBQMFfUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785169130; c=relaxed/relaxed;
	bh=06M4KFqCz6SAPpTAamw98wDkXyr1xHgX4OA2w7xESWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geyh2cAStX6Uqd61ZcywBLphHtrxBpY+rgzpABsJ6fJytm7Jcf+m50JmVAp59AlU1aPX5E+mezJmtqnQARipVJAHukZnQ5qRABOmC849kFLx+Ex8VZ5cDEHajnea0JcmOEPRpD650kkHEC/9kQtMwPFiOmx0vV/f8BIn/6qX4/POulBnkHXUi0/E0pxmexgIBcbgB6INaQqbSoJDsamlGjQOgLubcpX07WIebTzbmnVHfQLzut7IwEViCwWdcE07QAq06vk7exCUdH+cvk9EL6CdcX59nRyK3I2xkHMmbQnaXahbDgyoEkRTsAcRY2hX/c+WuGV+dKYSMjjr5dHxjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enBAogfo; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=enBAogfo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=cassel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h83gW1PjSz2xll
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 02:18:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B01E743A04;
	Mon, 27 Jul 2026 16:18:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF391F000E9;
	Mon, 27 Jul 2026 16:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785169124;
	bh=06M4KFqCz6SAPpTAamw98wDkXyr1xHgX4OA2w7xESWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=enBAogfoOEeCgerqwKDnan2rG4kdIvWwu5OsTjW/wsCXONxI+Bxyz9sJbEtytivK8
	 W1SqHqHvtq5WHHEK8pozmnV/fjtAOJ8Wm72Kan0GUdbUeCASEsYxW3vc5BenWRIMEG
	 lDXafmL0aZzu3g+7qWVcNf4LOmO2bLLgquj2Gs2ImTXhNTokgQQLfD0ltjtKbsQZQ2
	 mUw/5A6qsbsEkCYKXoJMPQiIErI8hUQDkDMbJjJWean18YnrfA/U+G9xH5CpfNEy76
	 rE+vwgin8bbdBr69LnNzDX2/qneNSP4745BhviSWn4t4dXZPaTNN4+N+TE4kNNiDHg
	 Ej8WBel57HFGQ==
Date: Mon, 27 Jul 2026 18:18:37 +0200
From: Niklas Cassel <cassel@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>,
	Brian Norris <briannorris@chromium.org>,
	Wilson Ding <dingwei@marvell.com>
Subject: Re: [PATCH v8 1/5] PCI: dwc: ep: Clear MSI iATU mapping in
 dw_pcie_ep_cleanup()
Message-ID: <ameE3SBWqbiE8PJp@ryzen>
References: <20260518-pci-port-reset-v8-0-eb5a7d331dfc@oss.qualcomm.com>
 <20260518-pci-port-reset-v8-1-eb5a7d331dfc@oss.qualcomm.com>
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
In-Reply-To: <20260518-pci-port-reset-v8-1-eb5a7d331dfc@oss.qualcomm.com>

On Mon, May 18, 2026 at 08:29:13PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> The MSI iATU mapping is currently only cleared when the endpoint is
> stopped via configfs or when the host updates the MSI address/size.
> This avoids redundant iATU reconfiguration every time the endpoint
> raises an MSI interrupt.
> 
> However, a fundamental reset triggered by PERST# assert/deassert
> resets all iATU inbound/outbound registers without going through the
> configfs stop path. If the host also retains the same MSI address/size
> after PERST# deassert, the driver never clears the stale MSI iATU
> mapping. It then continues using this stale mapping to raise the MSI
> interrupts, which can cause IOMMU faults and MSI failures on the host.
> 
> Fix this by clearing the MSI iATU mapping inside dw_pcie_ep_cleanup(),
> which is already called as part of the PERST# assert/deassert sequence.
> This unmaps the MSI iATU region and sets the msi_iatu_mapped flag to
> false, ensuring that dw_pcie_ep_raise_msi_irq() performs a fresh iATU
> mapping on its next invocation, regardless of whether the host changed
> the MSI address/size.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Doesn't this need a Fixes tag?


Side node: It seems like this series does no longer apply on pci/next.

Perhaps need to rebase and resend?


Kind regards,
Niklas

