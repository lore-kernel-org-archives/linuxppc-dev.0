Return-Path: <linuxppc-dev+bounces-28512-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE18CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 18:49:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvS0K3jMlz30WF;
	Wed, 30 Sep 2026 04:49:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790707793;
	cv=none; b=b7QDTh2BhFfwIMT/AlvQ1wVPSjd2GbiTx091Lg4awg6lOkVfPmfVLS9v0DnZys+alsKlVVmG6M9NEZoiR5Vsy2VmhoSJAwi1I2nS8gFVxeNZsAsW0UJn0O6fotC5NacOiS5u4MN6hPDe+yFQDxeoKQImFIYZfQV/wn+3sAOmyX96vx43I7jMX2o9149wTGE36hGkPM44MhtZmsLrmlO+1apwc8rfe00aSROjcMS33cZEO7JZbVBbYq6BRhuy99jBZY6CNWJEbfIki/i81XpGMtUJ0vZ5uMNUXWiKvj9o5pdEZz9AZfL2W+vGoOTAgFJ/kNFrgOpc7wyA8arcuMI/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790707793; c=relaxed/relaxed;
	bh=UBhVKtwX7WLqeFRo0t609N75+bDk+kGYx9V9TmdksTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juIOdxfcJu6RUQQm+rFxAWOGjKGokmrx1a9toM3eeXloXO/m7TLnvoQc4vlHRfNYGI5Xoi9gHpDR5qFoQ9aoHWow3htWY5RTQi86jwtr+P/OnSDJhIRoEsmeOFPSM90oTqOBF4hfFcVOGxsMDZX5mD8rL9e+lNl8aHnGQUdCA9HcuSdPR8a23R3UpL1Sjhu/6APvQ3pzVKSkBCCRXWUaek5RNga6EfTQ5IXAOQfZEux6wZNPw6B8aRQGIMlvTKIARUCfTxAj8D0gxyBJXWkNB4L3ryuGNoUmVndE9YskqEKvwk9PQvhaXAcWyXXGKvttDYPyZU5M/zRm44Zagpk8yw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WQ3fFzxn; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WQ3fFzxn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvS0C2tHDz30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 04:49:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790707788; x=1822243788;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A9lnM5UgM8WdmSiwmMwVw6F61nGdTBk9C5OI8pXmGOQ=;
  b=WQ3fFzxnCjVZ9aaE/cQ7mF5AUFpXJjb1PuV8XcRh6VLIoPMhUcGiWnlj
   UW8QWCKIA/I8nBSs+eRlwaoRfgYRx77Yw2j2m0roESuMY87vik+M/JN+Y
   AtHkuiHkFeYZ4t+l5Cbb34Z7QtXTsz5POKKLDYbipH2ZnUgpSY57AFYQ4
   9xbnq51qcnAEZputQOyhfio48wL1A1d1FliZJcMuB4tBaBC2Y18wHCdMH
   v4l0fg5GhvgXIk+POpAn1HJ6mLj6hQjqe5UbA0HA9JLMNKA5YFBmg80ib
   F/3Hu8enOIjrWeFVuRDymb7D6cSC3lrqXj2fwoj7Bs30y1wA6mb/4bqhE
   g==;
X-CSE-ConnectionGUID: g2+YXBkFS3ibg7aaUt0UKQ==
X-CSE-MsgGUID: TgCOiZ9LRnm+mCX484tORg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="93925983"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="93925983"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 11:49:41 -0700
X-CSE-ConnectionGUID: JrwSPjuyRmi5j3//KF+/4g==
X-CSE-MsgGUID: YQxjY82/TkC2nRZvAsIz/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="304964106"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 11:49:40 -0700
Message-ID: <74fe0d79-dc90-4c05-ba9c-9a0eec1ada48@linux.intel.com>
Date: Tue, 29 Sep 2026 11:49:40 -0700
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
Subject: Re: [PATCH 1/7] PCI/DPC: Avoid access to non-existent AER capability
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
 <ae05fe2df3a3182594c4a9638daba1c72cf40358.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ae05fe2df3a3182594c4a9638daba1c72cf40358.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
> 
> In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
> DPC event handling") amended the DPC driver to access the AER capability
> without checking for its presence.
> 
> In May 2020, commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST
> parsing for AER ownership") fixed it by inserting a call to
> pcie_aer_is_native() in dpc_probe(), which implicitly checks for presence
> of an AER capability.
> 
> However already in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
> "pcie_ports=dpc-native" to allow DPC without AER control") made it
> possible to override the check:  The DPC driver may access a non-existent
> AER capability if "pcie_ports=dpc-native" is passed on the command line.
> 
> Fix it by making the DPC driver cope with AER-unsupporting Downstream
> Ports.
> 
> There are two places where the AER capability is accessed:
> 
> - dpc_get_aer_uncorrect_severity() uses it to discern whether a Fatal or
>   Non-Fatal Error triggered DPC.  Access the Device Status Register
>   instead, in accordance with PCIe r7.1 sec 6.2.5.

This changes behavior not only for AER-incapable ports, but also for
the AER-capable ones.  PCIe r7.1 sec 7.5.3.5 says for the Fatal/
Non-Fatal Error Detected bits:

  "For Functions supporting Advanced Error Handling, errors are logged
   in this register regardless of the settings of the Uncorrectable
   Error Mask register."

The old code only considered unmasked errors, the new code also picks
up masked ones.  So a masked Fatal error (e.g. Surprise Down) alongside
the unmasked Non-Fatal error which triggered DPC is now reported as
Fatal.  Stale bits from earlier masked errors can have the same effect.

Since this is tagged for stable, how about keeping the AER-based logic
when dev->aer_cap is present and using DEVSTA only as a fallback?

> 
> - dpc_is_surprise_removal() uses it to detect whether a Surprise Down
>   Error triggered DPC.  Return false on AER-unsupporting devices.  The
>   function works around an AMD-specific quirk and it seems reasonable to
>   assume that all affected products are AER-supporting.  In any case the
>   detection is not possible without AER capability.
> 
> Insert a temporary check for an AER capability after the call to
> aer_get_device_error_info() because the function currently returns false
> for AER-unsupporting devices.  The check will become obsolete and will be
> removed with the imminent baseline capability error reporting.
> 
> Fixes: 35a0b2378c19 ("PCI/DPC: Add "pcie_ports=dpc-native" to allow DPC without AER control")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v5.5+
> ---
>  drivers/pci/pcie/dpc.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b779bd1d861..793a799053f1 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -236,21 +236,15 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
>  static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>  					  struct aer_err_info *info)
>  {
> -	int pos = dev->aer_cap;
> -	u32 status, mask, sev;
> +	u16 devsta;
>  
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
> -	status &= ~mask;
> -	if (!status)
> -		return 0;
> -
> -	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> -	status &= sev;
> -	if (status)
> +	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
> +	if (devsta & PCI_EXP_DEVSTA_FED)
>  		info->severity = AER_FATAL;
> -	else
> +	else if (devsta & PCI_EXP_DEVSTA_NFED)
>  		info->severity = AER_NONFATAL;
> +	else
> +		return 0;
>  
>  	info->level = KERN_ERR;
>  
> @@ -275,7 +269,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
>  			 status);
>  		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
> -		    aer_get_device_error_info(&info, 0)) {
> +		    (aer_get_device_error_info(&info, 0) || !pdev->aer_cap)) {
>  			aer_print_error(&info, 0);
>  			pci_aer_clear_nonfatal_status(pdev);
>  			pci_aer_clear_fatal_status(pdev);
> @@ -353,6 +347,9 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
>  	if (!pdev->is_hotplug_bridge)
>  		return false;
>  
> +	if (!pdev->aer_cap)
> +		return false;
> +
>  	if (pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
>  				 &status))
>  		return false;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


