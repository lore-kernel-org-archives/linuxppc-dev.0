Return-Path: <linuxppc-dev+bounces-16114-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE45C44508
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Jan 2026 23:38:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dxLGp1XWKz2xs1;
	Thu, 22 Jan 2026 10:38:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769038690;
	cv=none; b=KzSXoiAku79H5d7U9lY7vA/WxccjEeUKRwex9AiXr0eAIKfjk6SVqbZo+GphPFepIgE+9agIuPHUlOYR1vZRDF7MbbUQS5GfS46pyk9pIxux4sUglB9USkAFWCMaaU0JnM3Stz5zLll9S+fMD9CZA5Mxs/xVEFuBiH3Fgl0RE7IjtwGGYC7qSC0O2iSeLFQ3TnuW6E1UaZIuCT71rxklvGX4k4WFfRJW1m+J0+i3VTlPewIMrr/dqbURywIv9njN2GaK8WM4AaOhS7RnweMvk6pw7lOmbg5YHfiq/anLKAvO9xLPS6HPvluSQPW7Nl85yxysBerpIFGwn3DBcnFgvg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769038690; c=relaxed/relaxed;
	bh=ELw4AYfB44Z0XQD4NOw9N6lLs0Ghyzdi5aoiaCYEH9o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WnEmEAwq3j9C7ZEZsLEysSxUPUL+JRV/ISRrHZUb2bfl7yHcdxvwRMYlOcS3Ncc+2NKgDPdWluiMhiRxjse60LATKUHBN2uAhMlQBGJTSotVSJVGFKekcijUIMWqVXnMTz35kzjWvHTGy+h5pFfO5j3Gldb+J21jln1iX/DOcJgcjUfvIt/iRPREjtjc6O3yZkxFHDHvSpp8f6aLqF9MVQP4oeMRirXVQSP+KHRdFxzO9hdVG2eS8jhBJY9ejJjSJPnQBKIDzgmyWshcIp9JDS73hTISEYF5c4T2e+cmlZ9LgkFwNz2MpatDHOXMybH7feGqZvn4hcLsu1JldTZjBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BeikHttw; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=BeikHttw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dxLGn0qlzz2xl0
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2026 10:38:09 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A474041697;
	Wed, 21 Jan 2026 23:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54A20C4CEF1;
	Wed, 21 Jan 2026 23:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769038685;
	bh=weaJN1Iequ/ZyzA1DPueH31401FC5DUZbpwwcPNyzmQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BeikHttwrCy8vR2Z2txVC+OK5mggBSlKkHUlak+4qJNsLFrRy2lVin2znkr8uhTQV
	 hDrmRILtEmj7vUJozkGZqTtkC7jUFLFbW93vmaGTVqr/Sn5lqEpjj1cfK583XK2h1W
	 cWE3lMXXh6kONxTUrzilJiZU5A5Y89Zu2yn7RIUyGceGoUtYvSK8Y5rNZvlAy9u9iN
	 R2s2BfJMHAxgIvFEovn2WRV21tJsbeLz8tsu8o8CSDoBDHmaPSHQj2jCW8PFkiE8aJ
	 ocO0pWswC8u3eMGvxOnwCJab2Y+7vdjDnkfCiO1CZLrXf1aJX6D22EoP5AUFp1+EdI
	 qGoPNveHv3RcA==
Date: Wed, 21 Jan 2026 17:38:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	"Creeley, Brett" <bcreeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Han Gao <gaohan@iscas.ac.cn>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-riscv@lists.infradead.org, sophgo@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v2 2/4] PCI/MSI: Check msi_addr_mask in
 msi_verify_entries()
Message-ID: <20260121233804.GA1221537@bhelgaas>
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
In-Reply-To: <20260121-pci-msi-addr-mask-v2-2-f42593168989@iscas.ac.cn>

[+cc Thomas, thread at https://lore.kernel.org/r/20260121-pci-msi-addr-mask-v2-0-f42593168989@iscas.ac.cn]

On Wed, Jan 21, 2026 at 11:49:38AM +0800, Vivian Wang wrote:
> Instead of a 32-bit/64-bit dichotomy, check the MSI address against
> msi_addr_mask.
> 
> This allows platforms with MSI doorbell above 32-bit address space to
> work with devices without full 64-bit MSI address support, as long as
> the doorbell is within addressable range of MSI of the device.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> 
> ---
> v2: No changes
> ---
>  drivers/pci/msi/msi.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 48f5f03d1479..2ecbcd6c436a 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -321,14 +321,17 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
>  static int msi_verify_entries(struct pci_dev *dev)
>  {
>  	struct msi_desc *entry;
> +	u64 address;
>  
>  	if (dev->msi_addr_mask == DMA_BIT_MASK(64))
>  		return 0;
>  
>  	msi_for_each_desc(entry, &dev->dev, MSI_DESC_ALL) {
> -		if (entry->msg.address_hi) {
> -			pci_err(dev, "arch assigned 64-bit MSI address %#x%08x but device only supports 32 bits\n",
> -				entry->msg.address_hi, entry->msg.address_lo);
> +		address = (u64)entry->msg.address_hi << 32 |
> +			  entry->msg.address_lo;
> +		if (address & ~dev->msi_addr_mask) {
> +			pci_err(dev, "arch assigned 64-bit MSI address %llx above device MSI address mask %llx\n",

Use %#llx so it's clear these addresses are hex.  The previous message
did that, not sure why you dropped it.

> +				address, dev->msi_addr_mask);
>  			break;
>  		}
>  	}
> 
> -- 
> 2.52.0
> 

