Return-Path: <linuxppc-dev+bounces-28515-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FECCA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:20:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvSgf0zdkz2xnn;
	Wed, 30 Sep 2026 05:20:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790709630;
	cv=none; b=Ubqb+qz9SJdvbfpqSjmuihogqo6RVdZyw8HhnePqfkNx0+01Y64G4mQAEyR++5tHlhUsU2DKOGH5QWg8WkDg5Qb0++LZKVg4Ds0aAPSHaUfravyfeOZjAdbedvhKKu6QVS47D0cfafhbCdcKD/8jcu0um1QJwhQ2o87lTmfGp7kFWB7qtGdf7XMU66nlNUqP5TNL2mSSewzzaBaq6M/Q5mwUEaDcHjjJjXm/j4wtMinhVOmfLC7Jh82YrtlGz6WuHztZoevyEzUfr6clt2I5lwuGjsBicKEMDVNSVPXD0sdPmUoUFnFAfRnNfGf95PTnHHEG1kvAjNp4oknC9KNZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790709630; c=relaxed/relaxed;
	bh=4tdPzWVksIW176U1QOY4Tzf/4SyVKYK0sz7H6ggn2mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kYpo1rYzsnJTjCOgctdr/Dr2FTZqUUknzHTetfZWAuXRbJiceB5miNt2l8ACdMq6+Th4vvfp1DadNxCVmMw36La9ZRgXoVNvbac5E1lE2CKJYHWqdO7JRIkkowIMXDmixKmc6UJa8+Jlkb5cdliTnx1ayAdinPKProHOsTcco05dBVxVnUCZLgDOwvw5bRugKcavsRvpvADGcpCY9gUpv+c/K4UHbcbZniNiePHqDAzHUlf8JReKX2pjBCgrnFh2D805l5y83o5dzoScqy418Zsq4AStIGOkLuclLNgv776oPy7W7D+EClFMl7lVD3Qntm7wTFbfZfjTKosgBRD5xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SYsRQl2e; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SYsRQl2e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvSgZ6qCtz2xSg
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:20:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790709627; x=1822245627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lsJW8PoLoWwqdXMo/RBv2iqDlvjNOGyT8FfkT6mX9r8=;
  b=SYsRQl2eYGAm+LdntKLacmg+Hu1VGA9ta+sRlKWr2jt8eSfHcd3XAswd
   KYnUy4GpCv3Op08YpXajc2coIIa0pbOhm1LzGV6IBMpDBOkemziIjX/nh
   l58jyzoFETL5f/S3Rqm9+haYR9ZLjdozcp59E4s3MgzaRcdHqQKbE/Oc9
   Z5gVv48as2E47nL1sIWHjrkf4FIUO9aASed9383QfUde5I7e8EXmSfji9
   0ecRfAlfUs8x1AD+6nRi//DB1bZJoFh6rAsoWt0iWdaoC+An2qrT+LI76
   txyKXnTihN2Ct7L5GIpOxLOVgX2/0tYvuzAujz+OdrEOmfXB/GtRilR9L
   w==;
X-CSE-ConnectionGUID: fg+wfKaLQZWuw0DY84vlpw==
X-CSE-MsgGUID: CEWG8+gbSaCQMriIq/3wyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102112350"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="102112350"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:20:22 -0700
X-CSE-ConnectionGUID: R1BEhrwJT1ek6egCvPxHSA==
X-CSE-MsgGUID: XfbfVqTCQeKlR5yhZza6aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="278655075"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:20:22 -0700
Message-ID: <8af8a1ee-69bc-4819-a9dc-b3321dc4e30d@linux.intel.com>
Date: Tue, 29 Sep 2026 12:20:21 -0700
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
Subject: Re: [PATCH 3/7] PCI/ERR: Avoid stale error status bits on recovery
 failure
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
 <c7048e7dafe470f1f85709169c31b5aafe7ad59f.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <c7048e7dafe470f1f85709169c31b5aafe7ad59f.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> From: Yury Murashka <yurypm@arista.com>
> 
> pcie_do_recovery() only clears the error status bits of an error-reporting
> device if recovery succeeds, but not if it fails.  (E.g. because reset
> failed, drivers are missing pci_error_handlers or those handlers failed.)
> 
> One undesirable consequence is that the AER driver may subsequently
> identify a wrong device when searching for error-reporting devices in
> is_error_source(), due to stale bits on an unaffected device.
> 
> Avoid by clearing error status bits on recovery failure.
> 
> Link: https://lore.kernel.org/r/CAPzpGcRCTCZtaX1EVaJNZ103THZKsoszZduY7=gwfYdcrMo-SQ@mail.gmail.com/
> Signed-off-by: Yury Murashka <yurypm@arista.com>
> [lukas: drop cmdline param, rewrite commit msg, tag for stable]
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org
> ---
>  drivers/pci/pcie/err.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index d77403d8855b..cfcfc7e4f10d 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -284,6 +284,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	return status;
>  
>  failed:
> +	if (host->native_aer || pcie_ports_native) {

If Bjorn takes AER cleanup patch before this series, we can avoid sprinkling
pcie_ports_native checks everywhere.

https://lore.kernel.org/linux-pci/20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com/


> +		pcie_clear_device_status(dev);
> +		pci_aer_clear_nonfatal_status(dev);

This only clears Non-Fatal status bits.  On the success path, Fatal
status bits are cleared by pci_restore_state() -> pci_aer_clear_status(),
which drivers call from their ->slot_reset() callback.  On the failure
path, that may not happen (e.g. if the reset failed or the driver lacks
pci_error_handlers).

> +	}
> +
>  	pci_walk_bridge(bridge, pci_pm_runtime_put, NULL);
>  
>  	pci_walk_bridge(bridge, report_perm_failure_detected, NULL);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


