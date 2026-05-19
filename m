Return-Path: <linuxppc-dev+bounces-21176-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340FECD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 16:16:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKftC64g3z2yS4;
	Wed, 20 May 2026 02:16:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779207363;
	cv=none; b=X0XBfm8A0ULGiy+zbICuE8dcalvJCNLFXoUO5+r9cVe2+wbDt7OD1eNVQJX2OD+kD616PnE9VrXpVukuYHZvrnqUFNkcv/OE/XVhNDnMYU1g625JpRno8zMZgc1V10fOcyDBwcFB2wqsjNcmMr2vUhIRTxd6mKG+4c0pJvAy9Vo7PdiWXA0nzIhyOicXjMwloYFvmhdnhOYIxoAqlM9/xFzecOsUmKZR6+xNFiR0hqSYN09652VerEtusKpNXUjcL7cpWkbjRgIIus9pBZwPS1o02JDAVwF0cDjQWmh1SjdmiwzoU1Pj2rzkjiy+Mv8qo7bWzF6pfTh9RqqjIN2Ufg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779207363; c=relaxed/relaxed;
	bh=BAOGZIaPDEYRfNAY8dsVNS1wcsBxJxoSDGRYzDrTh8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmseiRt/xhJMbGao6OiZfMcvk90Xw7Z53jsBmn2MlfTB4Aq+NL8wRt05d2j2MTBuHHyTEkJdvWgXEpp1jeQQGzmo6fTtw0kUgrdnAZ4NAQmG8nttZMZTuow2nhzG63PkeOXEbr5rBzSF5rKOget2GuxHkjk6VWidE6sVMdjS3ja+am6XuI2a7A01mIfyLT+0cAbI+p0YnqS16BBINT5vfakM6V/A6ohbLL1aVN3KcfszviF5rMc4nl7WybVlshDtcSkqDLeKQ/Ol6xcwnPOGwizind6S/6AICd2HU100NeNPSSeKW4VbMOGU3+IOcyPnd+1COJhxm9H7GcadBe0kxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uxLDXn/w; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=uxLDXn/w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKftC19Xnz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 02:16:03 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1015960210;
	Tue, 19 May 2026 16:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E7BC2BCB3;
	Tue, 19 May 2026 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779207360;
	bh=ZvyXX+KsWZ2Bty8hNC/PaNKLRJHR5CsnAEO1Bw4UQRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uxLDXn/wxfxAUg+pVuo7jKn4NkGyioS5jTl2YNmfyEmCsXy5xxDdVtK06YpAswKZq
	 ks7jNsn7Es1zSEJjDfqeg9j6M8qewHMXnjFLxdxUmxGsbY0Uu9E0e5GXeex4QfUCPU
	 GMlCNqWktMub0bBKsVOFNbTOwP2V4BPNw8NleP6fInu0rOSsNv2DcXxoLtSKbrn6cY
	 uV+t38OFIB6jqiz4Lu+fdOd7cHBSU7ekzV/JaZWvxr+HyqG31OvTL0ICP9vnUQBCrK
	 xOsOlW+zW7oYXGb9DiHVb9Zfh25J3E6ZiG5RudqGahGfHIbxSjaCEDCrQXewTuOyug
	 tgK7WlPMFlhkQ==
Date: Tue, 19 May 2026 21:45:51 +0530
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
Message-ID: <bejh7em2a67a6wohtakovbg6wqwhjoxkuqtdompsexfm5bbzrf@yqwcqeg6yugq>
References: <20260509135152.2241235-1-18255117159@163.com>
 <beqy5ykxgo4ianya6r4mahkkyujs6lly475u26vqaemgqsdnhp@2pn5ipczwc34>
 <5cc6fbcc-98eb-4da5-b123-2c04c4d39326@163.com>
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
In-Reply-To: <5cc6fbcc-98eb-4da5-b123-2c04c4d39326@163.com>

On Wed, May 20, 2026 at 12:09:28AM +0800, Hans Zhang wrote:
> 
> 
> On 5/19/26 21:57, Manivannan Sadhasivam wrote:
> > On Sat, May 09, 2026 at 09:51:49PM +0800, Hans Zhang wrote:
> > > The DWC PCIe core and its many platform drivers repeatedly call
> > > dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
> > > PCI Express Capability structure. This is wasteful and makes the code
> > > verbose. And some even search for the PCI_CAP_ID_EXP offset value within
> > > the suspend/resume functions.
> > > 
> > 
> > Sashiko has flagged some real issues with this series in accessing DBI space
> > very early and 'pci->pcie_cap' being 0.
> 
> 
> Hi Mani,
> 
> We have discussed this issue in the Cadence driver. I think it won't cause
> any problems. Specifically as follows:
> 
> https://lore.kernel.org/linux-pci/5823faec-d972-4c77-90ec-a215c686e0a8@163.com/
> """
> As per PCIe r7.0, sec 7.5.1.1.11, Since all PCI Express Functions are
> required to implement the PCI Express Capability structure, which
> must be included somewhere in this linked list.
> """
> 
> 
> 
> Bjorn also responded as follows:
> https://lore.kernel.org/linux-pci/20260505212306.GA744158@bhelgaas/
> """
> It's true that all Root Ports must have a PCIe Capability.
> """
> 

Ok, what about reading the DBI registers very early?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

