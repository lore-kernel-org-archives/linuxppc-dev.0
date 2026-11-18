Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F40C606A32F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 16:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EmrAHXWb
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV5sj6mjwz2xSl;
	Thu, 19 Nov 2026 03:00:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795017625;
	cv=none; b=XIYJfOlbftDXXmZQIKmMZeVatGtzZMnoJHhQWyzZSR1mbnaAfsVsLUS4QsaYx7TRkRpYol90JMVZn0J36RaNcAsG/6Jn8mYNLRjbEebAdwSVxNjl5F83PfQqgQhVBakvlwihv2JFOMHqCS1ffSxIhoePAiBqt/E0HZPvbNU5sMQkRcxEmiQ+7t8GuMvH+D+AgpA47skGL4LfVnC6RKxWNjORnHBqO1mLRu8JxcC/VHN5tOxVNFGVNJQfckHyVpSDY1/3uiEu0aPY0xPfKdTty0DllgXNHdAxe35EEmvMOH88aoyY2PZG3BqIjwI830fKioS8APq8OGRG0bjQ4PXrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795017625; c=relaxed/relaxed;
	bh=D5QooVbmJyeiQEll/kH3Qhk5QICli5VfsBBRXwpoM1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iFLTqkLXXS03iv8iIR56BWFl2ub7VpM/H6mh3NvMv4UYh/klGhS/ivRiQEvexo/KyIKC/lZk/WT/qJMDHiF0t2M/fDHOKtv2NmWl1JJT6l7ZiR774OTzeacOYcZZJS6ZFfdD92zAvsPHGCXv7RnJqJ9Ulwg+dlQJsM4tLMCSxGsAtH64T2taStv+SBO7D4WK48JtLnvcpl/Ox1n9tDu6oENwg+pOwyJ4C2bP/mpey4I5+fyAHCI9ajtiSq00GR2SVQ7sNidrDpjuGcqAbTJ+bw3mlyfOKtR53OANH68pW+2gzO+o31Zn2adgXXXmb4rk/kaX8lnD7qMIGHUgMJ6XLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EmrAHXWb; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EmrAHXWb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV5sg0FWTz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 03:00:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795017624; x=1826553624;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bDErzl9kuTyesy6CIPye94cbiZqZje+huoOSfq3HhSc=;
  b=EmrAHXWbfGlPpoUYSnRNim/yiYBDM3II/Gf8w8n8k3cRH+lyWDs5urRP
   2mcGfEgUbRRJGAhSQu+voKPTZSpUWnbzWpel5giGLNAi1DCXM1Pr0yl3p
   M5vBqlZzqHH4L8VtDWidgxk0r0eOTo0ZFAC1Gz+bhksiUKE77TPQOa/h0
   4hatZy2BFxzlrPGFrIYZlXAwI6bh5EBV98BSNZh/SO2EpfSNB09y0+tiy
   gfrvqS/GOdkQ/IQbAx4dEehpdIoJz/iFSrj2pxNWWY6t9bqtMBU4eRzHy
   511+M2qKLl+KCO2N6+EXWVt3P7ksomrefU5aFfoAxUyULUfsrQ45EnzXG
   g==;
X-CSE-ConnectionGUID: LuI1isouSomH14cauiZBTQ==
X-CSE-MsgGUID: 4b0tc0x3Tem62vllTKtotw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3727132"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3727132"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:00:18 -0800
X-CSE-ConnectionGUID: wqyLjkTzROerMGSk0YUqvQ==
X-CSE-MsgGUID: n2FzSOcXQwqiFJvXuof08Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10539829"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:00:16 -0800
Message-ID: <62178920-f5e9-4d0b-8fc6-0bf0e2a53fd8@linux.intel.com>
Date: Wed, 18 Nov 2026 08:00:16 -0800
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] PCI/DPC: Avoid access to non-existent AER
 capability
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Raag Jadav <raag.jadav@intel.com>, linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Darshit Shah <darnshah@amazon.de>,
 Jason Perlow <jperlow@gmail.com>, Riana Tauro <riana.tauro@intel.com>,
 Yury Murashka <yurypm@arista.com>, Matthew W Carlis <mattc@purestorage.com>
References: <cover.1794997749.git.lukas@wunner.de>
 <34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <34c9ee153876bac953135b4518035194b7c07c6c.1794997749.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/18/26 02:40, Lukas Wunner wrote:
> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
> 
> In February 2019, commit 9f08a5d896ce ("PCI/DPC: Fix print AER status in
> DPC event handling") amended the DPC driver to access the AER capability
> without checking for its presence.
> 
> This did not cause actual problems because in March 2018, commit
> 4e5fad429bd1 ("PCI/DPC: Do not enable DPC if AER control is not allowed by
> the BIOS") had seemingly inadvertently prevented instantiation of a DPC
> port service on AER-incapable ports.
> 
> However in October 2019, commit 35a0b2378c19 ("PCI/DPC: Add
> "pcie_ports=dpc-native" to allow DPC without AER control") made it
> possible to override this:  The DPC driver may access a non-existent AER
> capability if "pcie_ports=dpc-native" is passed on the command line.
> 
> Fix it by making the DPC driver cope with AER-unsupporting Downstream
> Ports.
> 
> There are two places where the AER capability is accessed:
> 
> - dpc_get_aer_uncorrect_severity() uses it to discern whether a Fatal or
>   Non-Fatal Error triggered DPC.  Access the Device Status Register
>   instead, in accordance with PCIe r7.1 sec 6.2.5.
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

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> Changes v1 -> v2:
>   * On AER-capable devices, infer severity from AER Extended Capability
>     instead of Device Status register because the latter also logs masked
>     errors (Sathya).
>   * Fix storytelling in commit message because 4e5fad429bd1 changed
>     behavior, not 708b20003624 (Sathya).
>  
>  drivers/pci/pcie/dpc.c | 45 ++++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b779bd1d861..d02cbbbe3143 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -238,19 +238,35 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>  {
>  	int pos = dev->aer_cap;
>  	u32 status, mask, sev;
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
> -		info->severity = AER_FATAL;
> -	else
> -		info->severity = AER_NONFATAL;
> +	/*
> +	 * Infer severity from AER Extended Capability if present, else from
> +	 * Device Status register.  The latter cannot be used on AER-capable
> +	 * ports because it also logs masked errors (PCIe r7.1 sec 7.5.3.5).
> +	 */
> +	if (pos) {
> +		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> +		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, &mask);
> +		status &= ~mask;
> +		if (!status)
> +			return 0;
> +
> +		pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, &sev);
> +		status &= sev;
> +		if (status)
> +			info->severity = AER_FATAL;
> +		else
> +			info->severity = AER_NONFATAL;
> +	} else {
> +		pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &devsta);
> +		if (devsta & PCI_EXP_DEVSTA_FED)
> +			info->severity = AER_FATAL;
> +		else if (devsta & PCI_EXP_DEVSTA_NFED)
> +			info->severity = AER_NONFATAL;
> +		else
> +			return 0;
> +	}
>  
>  	info->level = KERN_ERR;
>  
> @@ -275,7 +291,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  		pci_warn(pdev, "containment event, status:%#06x: unmasked uncorrectable error detected\n",
>  			 status);
>  		if (dpc_get_aer_uncorrect_severity(pdev, &info) &&
> -		    aer_get_device_error_info(&info, 0)) {
> +		    (aer_get_device_error_info(&info, 0) || !pdev->aer_cap)) {
>  			aer_print_error(&info, 0);
>  			pci_aer_clear_nonfatal_status(pdev);
>  			pci_aer_clear_fatal_status(pdev);
> @@ -353,6 +369,9 @@ static bool dpc_is_surprise_removal(struct pci_dev *pdev)
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


