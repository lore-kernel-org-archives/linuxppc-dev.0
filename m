Return-Path: <linuxppc-dev+bounces-24936-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B22CC531F9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 11:56:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8YpZ2P0Cz2xyk;
	Tue, 28 Jul 2026 21:56:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785239798;
	cv=none; b=infAfkfituC5mWc2C3WPLoddJo4nlLgB0a9bl+Hwb9eNrnrFUBfmlZ3vAcWhBSoRtGaTM7WiGtnTaqRyIsWM0PWM+yTWLd/vOlJ/eIEOTW21qim8GXwtWj/DNCEjxBwzncboDGOMIgxNyHZjBZ7AIa2/c8a9Pl/MMctL/pdVRF4FmKGSwVw77mX1N6dV/CQ+0S71lthYJEWiKrzkUm6qO6NnahKGhSNPlRBnOfJW6RxoD4yKeliQdXnmmlC/xDO+t4SwH22pu+5UGsBw27BgWWRmSpErh56wuuxdx9BoCbaF+6q1xDoH1BFUo513f2Als8IdW/cK1HjCrmQhd+JqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785239798; c=relaxed/relaxed;
	bh=eNwZQCkHKwYFKkrNjWZTS93nuqW+VicG7takxDF9Vgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ4l/YAlg22uaNNaz3u4wHP0Ckhc3f+ZV+KvPpu0JqjmU0oFxg8oh2qPefvd3pYbxCo4tG0VaTG7Tvfk53wcYObyB3x1LhIIXCQgXMkUytOKurLziDJCohJann3xLGZL89R8fhXKVGP8Ku2uEYTJwZB0hjF7bYghez6Fx4v4yljh5MbQDlFMtOY2rF+kAjG24gg0YOFq/L/+WArOwVZb1chyBMkdvpgcJ9FFsr4fAO49drbVYIvnRUw9JryHG9UJdkZYYO+ab4IGYQFj1aH6Py++TWOwJLVWCqhdaxRZGp39qFaSTuYHZsBCto4HVLCtROX6zDX0D7GUMZLfgD2WTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eASZFug7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eASZFug7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8YpY0m99z2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 21:56:36 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1407C40E33;
	Tue, 28 Jul 2026 11:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B78B81F000E9;
	Tue, 28 Jul 2026 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785239791;
	bh=eNwZQCkHKwYFKkrNjWZTS93nuqW+VicG7takxDF9Vgg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eASZFug7jzWnrOF3OuHWC4dJIdUSnjJMhAZUEWqUVi4S7MXbtF5ibFVRSy4+s537i
	 XUoY0kXJCaCx8MxtLhr+lrqq7NBntmoWdrBHhwp89a1vo6ad9Be0OIxrxYWGthQELk
	 RqQ0blwKXaXTZmXrJFZgO2OKqLo7ZWy1fBwW1QPIGDXU1mei6Oh2U7348bqhX6Ij1F
	 utV4CnZhplr9TkSvfz0vgnkLdUys67sBj2wznd3JK92mKYhvuAzLwbPqxgom8dj0rh
	 GxzUUzbP6wspjvSYYLHIQ6Tlw8fhCAnoo+ZdRHNGcd1kuoMAUM8GVTYLJ4ROhBtRXu
	 isnidYxLb535g==
Date: Tue, 28 Jul 2026 13:56:18 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
	Oliver O'Halloran <oohall@gmail.com>, Will Deacon <will@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Lukas Wunner <lukas@wunner.de>, Richard Zhu <hongxing.zhu@nxp.com>, 
	Brian Norris <briannorris@chromium.org>, Wilson Ding <dingwei@marvell.com>
Subject: Re: [PATCH v8 1/5] PCI: dwc: ep: Clear MSI iATU mapping in
 dw_pcie_ep_cleanup()
Message-ID: <k5zkz2wnvkb2kzwyazafghgncqefv4cvuzrwwek6xi27vvldej@o4ostebesrbm>
References: <20260518-pci-port-reset-v8-0-eb5a7d331dfc@oss.qualcomm.com>
 <20260518-pci-port-reset-v8-1-eb5a7d331dfc@oss.qualcomm.com>
 <ameE3SBWqbiE8PJp@ryzen>
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
In-Reply-To: <ameE3SBWqbiE8PJp@ryzen>

On Mon, Jul 27, 2026 at 06:18:37PM +0200, Niklas Cassel wrote:
> On Mon, May 18, 2026 at 08:29:13PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > The MSI iATU mapping is currently only cleared when the endpoint is
> > stopped via configfs or when the host updates the MSI address/size.
> > This avoids redundant iATU reconfiguration every time the endpoint
> > raises an MSI interrupt.
> > 
> > However, a fundamental reset triggered by PERST# assert/deassert
> > resets all iATU inbound/outbound registers without going through the
> > configfs stop path. If the host also retains the same MSI address/size
> > after PERST# deassert, the driver never clears the stale MSI iATU
> > mapping. It then continues using this stale mapping to raise the MSI
> > interrupts, which can cause IOMMU faults and MSI failures on the host.
> > 
> > Fix this by clearing the MSI iATU mapping inside dw_pcie_ep_cleanup(),
> > which is already called as part of the PERST# assert/deassert sequence.
> > This unmaps the MSI iATU region and sets the msi_iatu_mapped flag to
> > false, ensuring that dw_pcie_ep_raise_msi_irq() performs a fresh iATU
> > mapping on its next invocation, regardless of whether the host changed
> > the MSI address/size.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Doesn't this need a Fixes tag?
> 

It needs one yes!

> 
> Side node: It seems like this series does no longer apply on pci/next.
> 
> Perhaps need to rebase and resend?
> 

Yep. I'm preparing th next version. Will post it asap.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

