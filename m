Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13307606A332
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CGRQTKoi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV5yx5RF6z2xSl;
	Thu, 19 Nov 2026 03:04:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795017897;
	cv=none; b=MxJ8IcaZsrF2//dTklx84msZaK1QB5bpEzda1S41ND/FWEqEwcCBoe8KYcaMZ9LKnimZ3FvMUr2EmVLowLuy5x34RuT6GLDiRjZR+V+JOqSPnanXR1uop8sW+105eAt8qtWmgS4I4KamZoVzYygeMBE+r6y36sv/rmiza02jZJoWWyTfXmrv2ceJu+w1rBuKtAq9NbQUKHPwNM2GEG93IfFhSmUSNG9LDPbsjSsPk73UMtvsp12LtipO9bLyTTTATxXJh9dV/xpWDwmERWOK2qDpzp3ezW+1WNczaHwwd/tQPed+Y0BcYZt15DDSJ6mJLowrk8ibsfh36dAdHEq+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795017897; c=relaxed/relaxed;
	bh=qNdQCu46JN+AvdW92yL/KhzoPvPF7o18pJEDv6Keoe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrhfxCSVtL42744BULXZEsStfeqkGB6NnNhIlxFFGGIy6eytf8ufDTY5lQsxZluom5kG7M00eZZvr47kwblGioLf67nEVE25DOKVhS6NyKvr6oQdOSjVNrvd4AA0F6czsMnVrXVPKuSRjiSX6oxW6m8FJyNa0h9iGdeRC2PbRAIIyASOxFoahhTzz1MZklDGkNz8gC0cYNvVc808SjfNLDBam5Ed4ASKBxyj1iD5rc+LFz9IPKZHiZdrfVS41mcbZXA21rrKt8Ap2Kh/Mwl8H/UiRBg6mHfj0bO5Un9ykPrNugIp1+atbPBsaL5WIU2xtbtomguYLOahXIj5/5o5oQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CGRQTKoi; dkim-atps=neutral; spf=pass (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CGRQTKoi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV5yw2p0fz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Nov 2026 03:04:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795017896; x=1826553896;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HlGntMaTXfG5rGmcaRF+1287Rm/VarsPSDTRNOZC8FQ=;
  b=CGRQTKoibn9ld2WYvCYjzV0bUJA9PfW7WLSaLW8XozuAG5cHzoGUT83o
   sXP4oco1QJRX8VftCWTPrujFVb6z/8Ns+Q8ES1tVtUZDNtmhOYOVd2QFL
   ZLpgSKUSFYi0TJ7EtYEGPwUBodjgZF48LkOdPEQ5NXlaip8cljiH/HkRd
   JR32np6IiI3H1Rp6MYKKmiXcgCq7wJfp7drMPedh7uM2EvhRB516F8gAT
   4ucfnzQr/E/OaPA0NcsgDWE0uz6aarBwfqAsVcf0kfBLMFYN1WssFjFh1
   NkRJbqd1CDPhSZja5et0g/gBVz0/Iyx6l1YqgTCKOySNXbTwC97mtDxqd
   A==;
X-CSE-ConnectionGUID: qesN6+wWQ2uHo2p3TEukyQ==
X-CSE-MsgGUID: itjAwN/YR6C4WdLivm+xsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3727465"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3727465"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:04:52 -0800
X-CSE-ConnectionGUID: GMqOpEkEQZqhGqmE8CouQA==
X-CSE-MsgGUID: 4MI+bbhVQnWNScobLRH2MA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10540463"
Received: from skuppusw-desk1.jf.intel.com (HELO [10.24.80.125]) ([10.24.80.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:04:52 -0800
Message-ID: <5cc37811-961a-43a7-8c87-278572c91ad5@linux.intel.com>
Date: Wed, 18 Nov 2026 08:04:51 -0800
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
Subject: Re: [PATCH v2 3/7] PCI/ERR: Clear error status bits more selectively
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
 <8ab33b2307e9136719f72ccc2d9f946417651eab.1794997749.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <8ab33b2307e9136719f72ccc2d9f946417651eab.1794997749.git.lukas@wunner.de>
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
> After recovery from a PCIe error, all of the error status bits in the
> Device Status register are cleared indiscriminately, regardless of the
> error's severity.
> 
> So when a Correctable Error occurs simultaneously to an Uncorrectable
> Error, after the former is handled, it is cleared alongside the latter.
> As a result, the Uncorrectable Error isn't handled at all.
> 
> Conversely, an Uncorrectable Error occurring shortly before a Correctable
> Error may cause the latter to be cleared and thus ignored.
> 
> Avoid by clearing only the error bits corresponding to the error severity
> being handled.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


> Changes v1 -> v2:
>   * New patch to clear error status bits more selectively (sashiko).
>  
>  drivers/pci/pcie/aer.c | 20 +++++++++++++++++++-
>  drivers/pci/pcie/err.c |  7 ++++++-
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 6f2460231422..51cf2ff8c85a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -141,6 +141,12 @@ struct aer_info {
>  					PCI_ERR_ROOT_MULTI_COR_RCV |	\
>  					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
>  
> +static const u8 severity2devsta[] = {
> +	[AER_NONFATAL]    = PCI_EXP_DEVSTA_NFED,
> +	[AER_FATAL]       = PCI_EXP_DEVSTA_FED,
> +	[AER_CORRECTABLE] = PCI_EXP_DEVSTA_CED,
> +};
> +
>  static bool pcie_aer_disable;
>  static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>  
> @@ -1314,6 +1320,17 @@ bool is_aer_internal_error(struct aer_err_info *info)
>  }
>  #endif
>  
> +static void pcie_clear_device_status_sev(struct pci_dev *dev, u8 severity,
> +					 u32 uncor_status)
> +{
> +	u16 devsta = severity2devsta[severity];
> +
> +	if (uncor_status & PCI_ERR_UNC_UNSUP)
> +		devsta |= PCI_EXP_DEVSTA_URD;
> +
> +	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, devsta);
> +}
> +
>  /**
>   * pci_aer_handle_error - handle logging error into an event log
>   * @dev: pointer to pci_dev data structure of error source device
> @@ -1344,7 +1361,8 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>  			if (pdrv && pdrv->err_handler &&
>  			    pdrv->err_handler->cor_error_detected)
>  				pdrv->err_handler->cor_error_detected(dev);
> -			pcie_clear_device_status(dev);
> +			pcie_clear_device_status_sev(dev, AER_CORRECTABLE,
> +						     info->anfe_status);
>  		}
>  	} else if (info->severity == AER_NONFATAL)
>  		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 1a7fc71c79d8..24a8a8263c2e 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -21,6 +21,10 @@
>  #include "portdrv.h"
>  #include "../pci.h"
>  
> +#define PCI_EXP_DEVSTA_UNC_MASK	(PCI_EXP_DEVSTA_NFED | \
> +				 PCI_EXP_DEVSTA_FED | \
> +				 PCI_EXP_DEVSTA_URD)
> +
>  static pci_ers_result_t merge_result(enum pci_ers_result orig,
>  				  enum pci_ers_result new)
>  {
> @@ -274,7 +278,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  	 * signaling device may not even be visible to the OS.
>  	 */
>  	if (host->native_aer) {
> -		pcie_clear_device_status(dev);
> +		pcie_capability_write_word(dev, PCI_EXP_DEVSTA,
> +					   PCI_EXP_DEVSTA_UNC_MASK);
>  		pci_aer_clear_nonfatal_status(dev);
>  	}
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


