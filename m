Return-Path: <linuxppc-dev+bounces-28527-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80150CA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:48:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvTJ6043hz2yD3;
	Wed, 30 Sep 2026 05:48:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790711317;
	cv=none; b=XwEZOxPyWtTwjcywn7U6S9qmsSIwk10xkFBqA0kWP0PV5pZ/tIC0mNZMTTN7EuM/Shp24KfZbbEtA0GGu3Lxv5ZRYoYN9v9VdgpSB1429UESFFcQVeBsyuxVNszltyoIrfEQPZO7uD0jnZn0DqGegMet7bdrVS74yZ7vzKKmOhYhONMzefIX/3SkQ0aj4nFhwaD/tybkeLlffFZSt6LKcj1CSDylhRAhiomSc5qrkAMf+D6pi4uj56ymFUYxRijsvGhDXoRJwGUq8TBEvbeiHH5eK80lfoVFELRPEq2b/GcTUs1CM39Pobwbfbvu8DkoaoQhxEznEApDbag9pVP8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790711317; c=relaxed/relaxed;
	bh=WjwOumvsEsitH6l8x9UcUZSyAGswrgda5CGGqLN3muY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q1GWbPJbkx07lEme37+fidlPq3qoKL+wQqUtTyVMA8g7CR/UkwfqUWkIlnI0tIe6HThOilnqGHVVDAax/emsqG5+0ziLWs9l4R0gNBOoTzf0wZ22bTjXaUWugFP8wIXpDPbwgO7bByHIrTVUVBixihULbVkBBEjsac5jo4wu7b66/7Win6qi3IJJeBn1QnkEYS437QJ+y157Pcy5MbOvNxKgGuJoi8BNygbdFT78JiNuFolhCStlVBbW0yqBWLXftiDbyMXVqHhZG1EpfYdAJrG7sgqcQoGKCQBuM1ZjHOew1e/cDwLEzmpmocfg5kvCVVKXlSB91TxNvthQGvLRxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jEU0vmtM; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jEU0vmtM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 64 seconds by postgrey-1.37 at boromir; Wed, 30 Sep 2026 05:48:35 AEST
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvTJ349c7z2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:48:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790711315; x=1822247315;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3NWf6YzouodGzD9ZeLjDoxA0+aThZPU6xI8Jf36A4ek=;
  b=jEU0vmtMC74kY1P7kycynJFHqMp/nKD0qe8eh39HFxe1QNd6cyo+m7uZ
   dLZ6vnOW+kSm8d56D1muTrGeT7gMJ7x7jLtTosSzc+2iWWe4V6UGERC64
   T9RLgEIw0LAWqgWZr8o9dJMdWCoY3RxMAt6LxU06vwnJLJROdjuEjwb5w
   rIVaxQeJO8ALUTv5xKBwQsyqtnUfqkCimQ7zP5so+j6nVhJO54qlqU6En
   vVcDhVoMvg6TWejSw88JAxwzJC9rQQBtpBpDGfUyLoMVR3qnr0IZLi8IW
   7VV0lW84Ssgg8WpProkqqoDExAe9TVfGdJWray3S4Qu4l80bmFjVbi1Dt
   g==;
X-CSE-ConnectionGUID: k75bv8foRZGEukeEgdg+cQ==
X-CSE-MsgGUID: jCnOQctPTz6UxZxWXznzLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79004655"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="79004655"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:47:27 -0700
X-CSE-ConnectionGUID: FWtVTot8QBGWMFXHZaW26w==
X-CSE-MsgGUID: WiM4jFowQryUdJ7Id+9OhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274672254"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:47:26 -0700
Message-ID: <7d21f908-ea38-4b8c-9646-0aaaa520206a@linux.intel.com>
Date: Tue, 29 Sep 2026 12:47:26 -0700
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] PCI/AER: Move AER capability check out of
 pcie_aer_is_native()
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Raag Jadav <raag.jadav@intel.com>, Riana Tauro <riana.tauro@intel.com>,
 Yury Murashka <yurypm@arista.com>, Matthew W Carlis <mattc@purestorage.com>,
 linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
References: <cover.1790531238.git.lukas@wunner.de>
 <6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <6a21637111397810d75679d1ca597766f3bf5605.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> When firmware grants control of Advanced Error Reporting to the operating
> system, that not only encompasses the AER capability, but also error
> enable/status bits in the Device Control and Device Status registers
> (PCI Firmware r3.3 table 4-6 bit 3).
> 
> PCIe devices without AER capability still support baseline capability
> error reporting through these enable/status bits (PCIe r7.1 sec 6.2.1),
> but the bits must not be modified unless AER control was granted.
> 
> pcie_aer_is_native() is unsuitable to check for control of AER-incapable
> devices because it implicitly checks for presence of an AER capability.
> 
> Move that check to its callers (where needed) to allow using the function
> for the imminent baseline capability error reporting.

Agreed that ownership and AER presence are separate questions, but
changing the semantics while keeping the name may trip up callers that
assume "native" implies "present".  Would a separate ownership-only
helper (e.g. pcie_err_is_native()) be cleaner?  It could also replace
cxl_error_is_native().

I think you also need to fix kernel-doc of pci_aer_unmask_internal_errors().
it says to check AER support with pcie_aer_is_native().  That's no longer
sufficient, and the function has no aer_cap check, Please update the comment
and ideally add an "if (!aer) return;".


> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pcie/aer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index d8dcd238fda1..34a8eddc427a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -257,9 +257,6 @@ int pcie_aer_is_native(struct pci_dev *dev)
>  {
>  	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>  
> -	if (!dev->aer_cap)
> -		return 0;
> -
>  	return pcie_ports_native || host->native_aer;
>  }
>  EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
> @@ -280,7 +277,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  	int aer = dev->aer_cap;
>  	u32 status, sev;
>  
> -	if (!pcie_aer_is_native(dev))
> +	if (!aer || !pcie_aer_is_native(dev))
>  		return -EIO;
>  
>  	/* Clear status bits for ERR_NONFATAL errors only */
> @@ -299,7 +296,7 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  	int aer = dev->aer_cap;
>  	u32 status, sev;
>  
> -	if (!pcie_aer_is_native(dev))
> +	if (!aer || !pcie_aer_is_native(dev))
>  		return;
>  
>  	/* Clear status bits for ERR_FATAL errors only */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


