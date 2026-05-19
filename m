Return-Path: <linuxppc-dev+bounces-21178-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A45CD4F3C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 May 2026 16:49:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKgd60Lt6z2yCM;
	Wed, 20 May 2026 02:49:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779209385;
	cv=none; b=absMy852e7sTgPRokRPxoVqTRf34lWIKfVpZbb2tTaYx/REFTa2tU6LxVZ4wReAaxe3xsV7xPwK8DJ80WTHgIsmptycB8ZYRdck6FOPHnVE/5rsWkewq8UaZUZztJY1e157ztIcaQdACwnRxVKNbZ535YtLNTCngBQXYPGj5Y31ZnzZQDrLEoMkw9GcvcxZj1vi/8r7uWnhqBBG52Ht/p8LCRQKhOsZGeCu02zyqpDl4/rqib3MNb+YtDOuPSCd13Kq3izSyP0F1xxJ92UUgT9jWo8o4JYMQWKqIFLK5LLp3TFYfh9OGArM150t0YhDbHwKR3fZlyNIuHyl/36/K6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779209385; c=relaxed/relaxed;
	bh=qfPmhVhF75gULSlxpYDoX/opTv4/OZ2gM5/hNzgxSTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6Hs9KBecbrn3p1RMiNmdWopqJ2IodjiWlDJagfBSEXL8BkKUJblKWKor4d2tPZoI9bTp4mDFyzQS9Z602dQkj8cXFvhAuob5dZUR1U6AtxbTEcwyum+PTJv9yUUrrjPMIJSoBuAKv9imPRsY95VzjRZEJF6uuPJBjRnceNz6s9iFXWgYfHxNnc123G/FWPrp9AzeIRJyxjp8HU34EmC6jlyxlSvOZJ0zkOAr9vPY7u+eiU3vApLzzyZd2ELZIH+kW0JKcsRagsVjxDnfC5q14HqDIYb3E2cMiQ5KVgrLGCXyCS0UBWu1ERskc/2Ffx3MpUcf3TUxalfa+WrL7uF+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZcJ/m4Me; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZcJ/m4Me;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=mani@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKgd46Zqtz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 02:49:44 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 98D436022C;
	Tue, 19 May 2026 16:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FA12C2BCB8;
	Tue, 19 May 2026 16:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779209382;
	bh=xK7G16bEnZgohr2GyDq+tZifrjDBAqojOxTNLJhUbiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZcJ/m4MeM2e98nnOTWyxvz0J/hHpuy2z+cR32k07YBEdAsrTReXtpj7hfVlMsvGlw
	 yJJYp5kvNjdIqpCwscGHQA56+TjGyzl/dZsVPXAwpVk/HE52dM8WNVt2xHGifb4268
	 ukJWQPCeyERVndgALRGPasfOJTh3aaHh6ONkilTpHGPTz0XWSJ3Rxa62xrSxHMjseK
	 e9TsViLHyP+GvHcE8couHEqJSm2xfg/nxEOorcVP9VnTPlk8LKolVT7rgg0EWrpzpU
	 AeYCgpVNMG7Nn2SNACkuPVj0jHTyxhbuG1qAcXJpBwk+7Mvp/PN3W6YUEaVF7Vm8Up
	 P+3U6rw/fm8ZA==
Date: Tue, 19 May 2026 22:19:33 +0530
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
Message-ID: <m332ocvmmdzcgnzmzxmbn2nmczxuhplt5efh64fd22fagrot42@x3okixj5qjb2>
References: <20260509135152.2241235-1-18255117159@163.com>
 <beqy5ykxgo4ianya6r4mahkkyujs6lly475u26vqaemgqsdnhp@2pn5ipczwc34>
 <5cc6fbcc-98eb-4da5-b123-2c04c4d39326@163.com>
 <bejh7em2a67a6wohtakovbg6wqwhjoxkuqtdompsexfm5bbzrf@yqwcqeg6yugq>
 <3464ded9-721a-4eb2-afb6-bbca6fdc8a46@163.com>
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
In-Reply-To: <3464ded9-721a-4eb2-afb6-bbca6fdc8a46@163.com>

On Wed, May 20, 2026 at 12:27:21AM +0800, Hans Zhang wrote:
> 
> 
> On 5/20/26 00:15, Manivannan Sadhasivam wrote:
> > On Wed, May 20, 2026 at 12:09:28AM +0800, Hans Zhang wrote:
> > > 
> > > 
> > > On 5/19/26 21:57, Manivannan Sadhasivam wrote:
> > > > On Sat, May 09, 2026 at 09:51:49PM +0800, Hans Zhang wrote:
> > > > > The DWC PCIe core and its many platform drivers repeatedly call
> > > > > dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
> > > > > PCI Express Capability structure. This is wasteful and makes the code
> > > > > verbose. And some even search for the PCI_CAP_ID_EXP offset value within
> > > > > the suspend/resume functions.
> > > > > 
> > > > 
> > > > Sashiko has flagged some real issues with this series in accessing DBI space
> > > > very early and 'pci->pcie_cap' being 0.
> > > 
> > > 
> > > Hi Mani,
> > > 
> > > We have discussed this issue in the Cadence driver. I think it won't cause
> > > any problems. Specifically as follows:
> > > 
> > > https://lore.kernel.org/linux-pci/5823faec-d972-4c77-90ec-a215c686e0a8@163.com/
> > > """
> > > As per PCIe r7.0, sec 7.5.1.1.11, Since all PCI Express Functions are
> > > required to implement the PCI Express Capability structure, which
> > > must be included somewhere in this linked list.
> > > """
> > > 
> > > 
> > > 
> > > Bjorn also responded as follows:
> > > https://lore.kernel.org/linux-pci/20260505212306.GA744158@bhelgaas/
> > > """
> > > It's true that all Root Ports must have a PCIe Capability.
> > > """
> > > 
> > 
> > Ok, what about reading the DBI registers very early?
> 
> Hi Mani,
> 
> Yes. I have performed the DBI read register operation at the very beginning
> of the following code.
> 
> 
> dw_pcie_ep_init()
>   dw_pcie_get_pcie_cap(pci);
> 
> dw_pcie_host_init
>   dw_pcie_get_pcie_cap(pci);
> 

These both calls will cause crash on a lot of platforms because these will be
reading the DBI registers while the resources are not enabled.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

