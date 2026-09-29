Return-Path: <linuxppc-dev+bounces-28514-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B59DECA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:04:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSKM03gCz2xlw;
	Wed, 30 Sep 2026 05:04:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790708678;
	cv=none; b=JOWZ3vVzqM6T5CeyCrchm+MsJ24lg+9VFH1rLu6X8Xd3pbkY3P/4ztfKUxpyG23FCMX13XWGgSU8DIv3uDL/+YO2NyBOUTEN+da0VTEdDeFdzsiJeWmsPT72AmgAXopxYH0lNvHXESsBXQ1rSJYs32pBQkkRVOwCeG/Bq2lNmFiEOu6K4YikT7CTT59FWqD/qQnwH54EXs20iwl9b+3oxr0zXWUwqHCq+8j91tlYxFNyzgiIn6TtVBSm6G+SCo36/hgT6XAOrdAQABzzEQREyOKkEyBlJbjg1wEeKshR+0g/6j4EenHlfm5GKjL8QuFU1nZx5QfegwKjs4r0MFFeUw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790708678; c=relaxed/relaxed;
	bh=ejaGWXKzZBXr4gkyq4brb8NlSPet4Nw8J6WOapfuci4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSie+i9EY55sgzk+rvctibew56inYfu+LO67OZKiTrtleI8F0+/ajObDEvDygWwfm10sdZB3SVMkxRCaADBjT2/W+io3DY8hvBSN5xL+eOOVByf7T5xAMkPv6rYzK7CTXcQdiz0Q+rEdjIcNPMJhQYFT5IIZPl54XYQtyjrzOJxCloOyCuouvhNAws8lG8Rw3/hjpHfiDd+Nz85X4kiEQYI8i9b+DB2BTHNmL5QXk9IHtykiIGLsRigwGJapuP/Y44iWK4OkDk2U7Y+8Rr9fezWjDxYRjh8WNYgo3qokZltu4awtnZshls+CCwyYpRw3NJlJL2ZesTY9Gk0DBA/+7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G8sPVyAE; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G8sPVyAE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSKK4NPNz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:04:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790708678; x=1822244678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f1c3sUGqi+deJ+NQMwk/OC4eFoFzb20BlqMUp5oX7gc=;
  b=G8sPVyAEqGIFY0eiG8Z8E2lt0wsh5tWRM+jZDnBmD0/FOQKVBQZENrNU
   YBtir90aGwhNCuA86eWeY6RBoRkqx0nR/9yUkNNNNiSOkCnk7mwnUXrP2
   tEiN8YpoyRVsFlxW9FwLr3Rl3sFKB0P2vVZ2u4aMuslNySV3k4+UG5bzG
   FXvkd5NK5kgscTBT/gWq34aQ39gBrxOzrDyO/N4SVDfwvryzV99u8Y0ts
   34M/iQyDoxgdK4mO/wVdOy02D0Mc54IkZ/ZqShkC7alvptgMqEgXwBuP0
   3BCjlIJKPTXyqowpuXPdeQIbQR7AiuCPopJTk3cGINATkotXqeIiv4s3J
   w==;
X-CSE-ConnectionGUID: xUkvSOVtQrStqXmb6f/+gQ==
X-CSE-MsgGUID: /3n42t9ESymTSH2tVaiHaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="101602103"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="101602103"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:04:33 -0700
X-CSE-ConnectionGUID: WUP40NglQyinD+BUi9cmJw==
X-CSE-MsgGUID: nKfrBZ80R6yk9u2fSDFk5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="303418463"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:04:32 -0700
Message-ID: <02a33171-b901-400b-921a-c40fe167b424@linux.intel.com>
Date: Tue, 29 Sep 2026 12:04:32 -0700
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
Subject: Re: [PATCH 2/7] PCI/DPC: Reinstate support for AER-incapable ports
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
 <2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <2ce502e5caa57db01e0a7bbc781210b66b73bec8.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
> 
> Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
> ownership") seemingly inadvertently constrained DPC to AER-supporting
> Downstream Ports by inserting a call to pcie_aer_is_native() in
> dpc_probe(), which implicitly checks for presence of an AER capability.
> 
> Drop the call.  It is superfluous because it duplicates the conditions
> applied by the PCIe port service driver when it decides whether to
> instantiate a DPC port service (see get_port_device_capability()).
> If the conditions are not met, no port service is instantiated and
> dpc_probe() isn't executed.
> 
> The only difference between the conditions in dpc_probe() and the ones in
> get_port_device_capability() is the check for the AER capability, so by
> removing the checks from dpc_probe(), DPC is supported on AER-incapable
> Downstream Ports again.
> 
> Fixes: 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER ownership")

I don't think 708b20003624 changed behavior here.  At the time,
get_port_device_capability() only instantiated the DPC service if
pcie_ports_dpc_native was set or the AER service was instantiated,
and the latter required dev->aer_cap and native AER control:

	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
	    pci_aer_available() &&
	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
		services |= PCIE_PORT_SERVICE_DPC;

So without dpc-native, the pcie_aer_is_native() check in dpc_probe()
could never fail, and with dpc-native it was bypassed.

The check only became effective with 97ca178c899d ("PCI/DPC: Allow DPC
on all Downstream Ports when OS controls AER"), which replaced
"services & PCIE_PORT_SERVICE_AER" with "host->native_aer".  Since then
a DPC service is instantiated on AER-incapable ports, but dpc_probe()
rejects it.

So I think this should rather be:

  Fixes: 97ca178c899d ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")

Also, for stable kernels, is there any way to note that this patch needs
to be picked with patch 1. Otherwise DPC driver might access AER config
without aer_cap.

Otherwise it looks good.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.8+
> ---
>  drivers/pci/pcie/dpc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 793a799053f1..104ff2b91f1f 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -474,9 +474,6 @@ static int dpc_probe(struct pcie_device *dev)
>  	int status;
>  	u16 cap;
>  
> -	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
> -		return -ENOTSUPP;
> -
>  	status = devm_request_threaded_irq(device, dev->irq, dpc_irq,
>  					   dpc_handler, IRQF_SHARED,
>  					   "pcie-dpc", pdev);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


