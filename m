Return-Path: <linuxppc-dev+bounces-29498-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51377C3DA7A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 17:13:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4d8H3fJzz3btP;
	Thu, 15 Oct 2026 04:13:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791998015;
	cv=none; b=NqTAA7z7vhmY9L1LnaReg0BV1QAnHGe81salk+worD+XBLJrvnZWcYKcPuYM+2T9WayEgnQSe1HqrmJTIsIpZ0GcSxqjBgh2tfh6CA8TBfAz+a8p9P/PY8hz7NHy22ployL2pW1isjIYqYq8w5H94gyD/1ytUsGl3MwELXcxVC/oVO0mjuk+/sHrXdKaLfjoCzJq1/MPr0+gssVzMbJV5DJsyonQt2jAHa5pHZiKOhK+MBajF5WWIqa019gvd3cw+FGGSG5GEmkmma2IWEYpCDJGcwpXrMirhziBDh7p+8b+OZjzByFuCNQcfLwaZy6H9zTl8PTMfCBf+zw391b9AA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791998015; c=relaxed/relaxed;
	bh=TIXKZ1EmqWU/VUc5XZWDJM5gBsBtYEI+Xauv3IN18ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NP3mDJmkwHv88buxA7Pe1ePjgXrbOdigvaxMW7rGmI5C7l41glDcMDym6g15VgQLdoGMRiG1dcL6Ml3UatS+kK7uHJTIqb6wVZpfJoeH0CFNb6RSm8EsWa2x2ojRN+ZvSFCsKpBenvfW/GanMDGofhFskD9mDk09+3vkZbeN0ke11wcat9GGYzYt6XlBz0X9vJUCAOAG7OBTjulFfbMBE+ZqSAgLlwNZCK1KmJ60L1G+vfYVwQHJWorKHILKdX1oCXPdXwRXcx+ENdOBXS28cJK+DfzfKwRYEGCJlUpAvLNOWcz3VxljzDvJH4vZ3sbJVfDiBjqbG8Rx2potOAQztw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3551b1+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X3551b1+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4d8G4CQvz3br2
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 04:13:34 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C421860098;
	Wed, 14 Oct 2026 17:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0391F000C4;
	Wed, 14 Oct 2026 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998011;
	bh=TIXKZ1EmqWU/VUc5XZWDJM5gBsBtYEI+Xauv3IN18ZA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=X3551b1+kerHLKkgoLyynluZRnT89nmMlG9rlmLWW8V9C4QCUneI15E6Pz3rcKqf9
	 mHnyjzbkFavDjWlFHf3RQCcLasCJq9HAfrPjw3hWkHHxXB/PP60RQaugTlwBPfl59b
	 pouU/CIq0JT/xXxfgqJ8zi10vGqVshJB/NPqD4ah7IwicwPdAhINXhJbu3uBmxBBWH
	 0eoTAFzK4Rtfqjsqm1ipr19biNYZmoLMgRC76IWxb4YPVFWDAFGMFWxDgGABfGSWKF
	 jUMX9Z2ufQqTXjt7hhXt2o9rt+9NtBSFpf0Cr2/CbUP18y1wdK41b5qjpg8KBgtQSP
	 ipexh62I4hXbQ==
Date: Wed, 14 Oct 2026 12:13:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Andreas Larsson <andreas@gaisler.com>, linux-pci@vger.kernel.org,
	sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Tony Rodriguez <unixpro1970@gmail.com>
Subject: Re: [PATCH] PCI: Set supported_speeds in set_pcie_port_type()
Message-ID: <20261014171330.GA1640628@bhelgaas>
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
In-Reply-To: <20261007131304.309511-1-stian@itx.no>

[+cc Tony]

On Wed, Oct 07, 2026 at 03:13:04PM +0200, Stian Halseth wrote:
> sparc64 and powerpc create PCI devices from the device tree in
> of_create_pci_dev(), which calls set_pcie_port_type() but not
> pci_setup_device(). Since d2bd39c0456b, supported_speeds is only set in
> pci_setup_device(), so it stays 0 for these devices.
> pcie_get_speed_cap() then returns PCI_SPEED_UNKNOWN, max_link_speed
> reads "Unknown", and the failed link retraining quirk passes
> PCI_SPEED_UNKNOWN to pcie_set_target_speed(), which warns on a SPARC
> T7-1:
> 
>   WARNING: drivers/pci/pcie/bwctrl.c:125 at pcie_set_target_speed+0x284/0x2e0
> 
> Set supported_speeds in set_pcie_port_type(), which all three paths
> call.
> 
> Fixes: d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds")
> Closes: https://github.com/sparclinux/issues/issues/109
> Signed-off-by: Stian Halseth <stian@itx.no>

Applied with Tony's Tested-by to pci/enumeration for v7.4, thanks!

I added a stable tag since d2bd39c0456b appeared in v6.13.

> ---
> Tested on a SPARC T7-1: before, max_link_speed reads "Unknown" and the
> warning above appears with CONFIG_PCIEPORTBUS; after, all 23 PCIe
> devices report their real speed and the quirk lifts the 2.5GT/s
> restriction without a warning. Not tested on powerpc.
> 
>  drivers/pci/probe.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..52a79b033b069 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1651,6 +1651,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>  		pdev->aspm_l1_support = 1;
>  #endif
>  
> +	pdev->supported_speeds = pcie_get_supported_speeds(pdev);
> +
>  	parent = pci_upstream_bridge(pdev);
>  	if (!parent)
>  		return;
> @@ -2074,9 +2076,6 @@ int pci_setup_device(struct pci_dev *dev)
>  
>  	set_pcie_untrusted(dev);
>  
> -	if (pci_is_pcie(dev))
> -		dev->supported_speeds = pcie_get_supported_speeds(dev);
> -
>  	/* "Unknown power state" */
>  	dev->current_state = PCI_UNKNOWN;
>  
> -- 
> 2.43.0
> 

