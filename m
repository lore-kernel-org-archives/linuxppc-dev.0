Return-Path: <linuxppc-dev+bounces-7448-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC24C36010
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Apr 2025 04:51:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZTR5b6kPCz2yfF;
	Fri,  4 Apr 2025 15:51:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=176.9.242.62
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743742291;
	cv=none; b=lCv1yMr/zainatp08oqFlSMCJi+nplmpIATj71pzQ4eu+UVSqemR70xtN2IdXgaJdo/NGy8/poY2905fg6X0H3ZjEadAqowtKACxHuStzg0Y5RwfFDgMDEKFtU0WmmMMRvbo5f34VBs9MYF51sTh+MnM3t0kcVi6qgtr0DwF+JZdvKhOZbFpTnpE2+ixkJOdvA9OuKv45Za5POiBgkEdPgBNhvxUXLCo2/o8DS+C6qgNeJPsC2D5Sw9HHXYa8MymRvpWx3JZW4JvnszOoKiuQRMe0hsTeenKVKpvPIAUUB+tbPF7stQmCZjnFwayoCHDlZtwkY88tR9o7KGWSP1kHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743742291; c=relaxed/relaxed;
	bh=1MYkHqc/nP/fGBQIUNI2OfmIg7gHypOzq7R4zOWYFdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEi4WAu9WU9GxXpd30lSXl4jQc9S5m+eAW6vaUpowuMUAwgp7VLio9uLi+m6gpDXEC0Zh+ISFSOWyFmONFfhrYzZT+ttFMmApx+9TSU/aNidSP7ucdvW6hvQsIcllpAoufPXtjlSkNAU70js8faKBXhc0mBtoX4yQQKGq3dJcrXlJmvML65tXw5QkBAf5cuX/anKzHOyHU49IIVwIXOKvVfcjq3Rab9u+TFYwRNkU+yzlPBEwWzWYrfJOFgXnCmhGCumoys13YBfzL+jZNHZTqR7aRlOR65zAICMeR/aNI/qDhJWuOBNKKZPmSH6BMN4y2MsdjsWa9guvqo9Zwuydw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass (client-ip=176.9.242.62; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org) smtp.helo=bmailout3.hostsharing.net
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=bmailout3.hostsharing.net (client-ip=176.9.242.62; helo=bmailout3.hostsharing.net; envelope-from=foo00@h08.hostsharing.net; receiver=lists.ozlabs.org)
X-Greylist: delayed 525 seconds by postgrey-1.37 at boromir; Fri, 04 Apr 2025 15:51:30 AEDT
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZTR5Z4qVxz2ydx
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Apr 2025 15:51:30 +1100 (AEDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 84EE52C06E55;
	Fri,  4 Apr 2025 06:42:29 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id BD8EF1143F; Fri,  4 Apr 2025 06:42:32 +0200 (CEST)
Date: Fri, 4 Apr 2025 06:42:32 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Shawn Anastasio <sanastasio@raptorengineering.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, tpearson@raptorengineering.com,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] pci/hotplug/pnv_php: Work around switches with
 broken presence detection
Message-ID: <Z-9jOFiPaxYAJwdm@wunner.de>
References: <20250404041810.245984-1-sanastasio@raptorengineering.com>
 <20250404041810.245984-3-sanastasio@raptorengineering.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404041810.245984-3-sanastasio@raptorengineering.com>

[cc += Krishna]

On Thu, Apr 03, 2025 at 11:18:09PM -0500, Shawn Anastasio wrote:
> The Microsemi Switchtec PM8533 PFX 48xG3 [11f8:8533] PCIe switch system
> was observed to incorrectly assert the Presence Detect Set bit in its
> capabilities when tested on a Raptor Computing Systems Blackbird system,
> resulting in the hot insert path never attempting a rescan of the bus
> and any downstream devices not being re-detected.
> 
> Work around this by additionally checking whether the PCIe data link is
> active or not when performing presence detection on downstream switches'
> ports, similar to the pciehp_hpc.c driver.
[...]
> --- a/drivers/pci/hotplug/pnv_php.c
> +++ b/drivers/pci/hotplug/pnv_php.c
> @@ -390,6 +390,20 @@ static int pnv_php_get_power_state(struct hotplug_slot *slot, u8 *state)
>  	return 0;
>  }
>  
> +static int pcie_check_link_active(struct pci_dev *pdev)
> +{
> +	u16 lnk_status;
> +	int ret;
> +
> +	ret = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnk_status);
> +	if (ret == PCIBIOS_DEVICE_NOT_FOUND || PCI_POSSIBLE_ERROR(lnk_status))
> +		return -ENODEV;
> +
> +	ret = !!(lnk_status & PCI_EXP_LNKSTA_DLLLA);
> +
> +	return ret;
> +}
> +

This appears to be a 1:1 copy of pciehp_check_link_active(),
save for the ctrl_dbg() call.

For the sake of code-reuse, please move the function into the
PCI library drivers/pci/pci.c so that it can be used everywhere.

Note that there's another patch pending which does exactly that:

https://lore.kernel.org/r/20250225-qps615_v4_1-v4-7-e08633a7bdf8@oss.qualcomm.com/

So either include that patch in your series (addressing the review
feedback I sent for it and cc'ing the original submitter) or wait
for it to be respun by the original submitter.

Thanks,

Lukas

