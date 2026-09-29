Return-Path: <linuxppc-dev+bounces-28516-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E726CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:24:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSmj5Zn3z2xnn;
	Wed, 30 Sep 2026 05:24:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790709893;
	cv=none; b=e3/DfavKk8Lo1NNU1/s3OTIxjwRiB+7nDQNLvmsVxOD7p6n1oI6tnv9WKwYpY7Ts1KwreLcJkHecjyxcnnaHAUCdXUsfs2UHNPZ5unFihQlbI358oJVJLQ5/Qk6JDoKQUhc1ZWQQ3v/6lsgpxS0BRuf41C1Xi53djBOw5RzHIqqduVimEWP5CkuWrecW8bzJDMXQzjrURU21fD+98GvKSYM1auCvzGd0yBHjWz2XTYHA9yOGXRzLaOc8/ZTJGrPlrM6qAXj3gvd/9FJCJr97TdcVOg3woi0VqeRPr4EbjJpg+YJOdai3hG2YBpih64PoYSYQAv9j/yWmvftJGQdqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790709893; c=relaxed/relaxed;
	bh=cTY4ILyCOv9D8irR84wJglos0NjEijuSe3KJTStqeVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYX/tlUXRxrYcfYOvnAHwbeEVQOd9f/haP06IF2qpVxHcTPOwhVMGlNa7bQrDsPIKY/n+P090Z68yXDe/a8ypU/WaeFJVteYzvhJTxVE6/NX09X3sQ5nXvWyJCg5fXzFcxPM4eHTXG6Wl0EAEjXaj2TrURniLUslcYBgJL2ztdIG4xJdsLobokoMhjs0K4hwFuj7mGH1Jcyqgs4TSnY8EXLFlbIBb61sZL2bsy9+DOLEPT5yVpVS6gz4JQ16eTYIIB35cVpgCNvvqanxgEzWXAEATCTv8vSxrsL0kih1DtaOILKN+Ue0dsV7LGewS9a/bWMnvWQnkUbYLFtBzhJrcg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T2xd3Mxg; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T2xd3Mxg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSmh5vm4z2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:24:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790709893; x=1822245893;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TLlPtwM9+jBoyZmH2gCTAvCqM903Ko9m2ipWHJKM4D0=;
  b=T2xd3MxgpvA4u4UEwIStdrb0sde1J570tZ126jdDkIejiOg+bdG6fFun
   8N28vULjL+H1JFZNAbHLxF4V4KjNBnataqQOjUF6OrP/uPzjZDhkY2waP
   Q9UfDgcmreKfky6EbB1MdAOcZYdZ91PNR3NVJlj19hTBFzGanXWB0EkCy
   uOqTWhjctXPPuajCHohLpR40Sh5dxjRk/3inRBe9/HFTfNF9n5cJbt0Jh
   2ymJosn4gG3ftDQH7A1tpt/pQQyZneM2qI8tzdcjCWv20zf4qyUm93/Zs
   +rrWNZOaTKNJqmaLvk7+PxMkj6H5/Kvxbt8CpLKvIfNSdl68owZkQGdtc
   A==;
X-CSE-ConnectionGUID: l8SAbYvwS7KBZ8pHN6KuEw==
X-CSE-MsgGUID: C51pFYgrTL+FXYLhYVK4vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102112642"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="102112642"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:24:50 -0700
X-CSE-ConnectionGUID: RkhCk2BbSSeE/Rr+qQDZ/A==
X-CSE-MsgGUID: h2sXK3lORbWX61B578fp4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="278655597"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:24:51 -0700
Message-ID: <b857cc94-2624-4478-ae06-a3512dde948a@linux.intel.com>
Date: Tue, 29 Sep 2026 12:24:50 -0700
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
Subject: Re: [PATCH 4/7] PCI/AER: Drop AER native check from
 handles_cxl_errors()
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
 <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <1a00e832eab9539f7328f5d547f11b67e17bd0da.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> Drop a superfluous call to pcie_aer_is_native() from handles_cxl_errors().
> 
> The call is superfluous because the function is only called from:
> 
>   aer_probe()
>     cxl_rch_enable_rcec()
>       handles_cxl_errors()
> 
> ...and aer_probe() is only invoked if an AER port service was instantiated
> in get_port_device_capability(), which is conditional on:
> 
>   (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
>    pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
>   pci_aer_available() &&
>   dev->aer_cap && (pcie_ports_native || host->native_aer))
> 
> ...and the last line of those conditions is equivalent to
> pcie_aer_is_native().
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


>  drivers/pci/pcie/aer_cxl_rch.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index e471eefec9c4..9cc2d5749b9d 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -87,8 +87,7 @@ static bool handles_cxl_errors(struct pci_dev *rcec)
>  {
>  	bool handles_cxl = false;
>  
> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> -	    pcie_aer_is_native(rcec))
> +	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC)
>  		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
>  
>  	return handles_cxl;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


