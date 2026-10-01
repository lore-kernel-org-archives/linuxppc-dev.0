Return-Path: <linuxppc-dev+bounces-28670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A43CA5FCF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 17:44:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwfS74np4z30DY;
	Fri, 02 Oct 2026 03:44:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790876679;
	cv=none; b=m8eVsT3QPo7aUJuHqlA+J8TT3x0TvpNUXi6O5SWlGLKNdnfgirtTc/xa2hNMIIVosKqJMf6ckP13pdc+cmGgRGD2jPMPMf3i4mmjHBx+vLrtsMkWimEkxGNlSt0FpxIvhkEbnB40mYVdUJkkWLavSJ2frKo5HsW/e0FSqOE49GlHjV/8Kcokf8eumFLIdyBT4fY1fG5SZoAJi/GacVzxGINiupSTiOPsZHFkTltKf9tWRrPuCM1uFIoGr7AtM/mX1fXBfCp6BTt4ILcFLZMqyHdIUoZ08A6ECGN9CN5mhY13hLVl1FxeOCgWm/qUDKo0Vq5ZdBEJ3RhjwS0A424QRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790876679; c=relaxed/relaxed;
	bh=4GJQix+nS6qV4ve4WXqqeNyn333jh7FFSjmmmSV4GVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ek7/ilgt3b2QwTaUiNDSshHUuRJoEXg0gikyTzG4UcGDEINqRm10EUuiBKOQnV/UPEsezsRTTau5Jpk3vrMSjyePD+gdx+ue68NyGDwoG14lBlehJSsD+bpTBQU49pMHEmJ2PU/YtQT4AkaNW7tkaNFfcSfQjD2bjY6nGLbeA+0Tm0lSPMWkyzkCQLVj00Yh2S5fZgPNcSe9EgUqdRupfuDPc+bjAuGFyex69senoQLuroo9W2XgaZdUc44tBT0GzHPpcUXMwuz0269cVtorGctSkuK5cANhXyq2rc6Ukm2zhiNgpFp/3itXTd5Q6h2eGUsBEPB4Oig712CZJ8H98g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kg+Aztf4; dkim-atps=neutral; spf=pass (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kg+Aztf4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwfS32wVqz2xfq
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 03:44:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790876675; x=1822412675;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Twb6N8pORvQhUso+rgRS/3XAVmHuq8mR+uy8ifhs+lM=;
  b=kg+Aztf4WuiCP4dfLMAzQfOJIzhCKQSmnNqWkFPrUxRayOTSuHnr1WBk
   FNbNDfdCNdzUMTrRgnANo66XzSMV2gC3VSdKj9RWcW/9NaprCCbJrJZHP
   ZdtjwayChL7jQCzg79zgselvD1sPyNj6M+lgM5HLu2c6BiiY1CyDAFZds
   AwxXC6GK0EiTO/qrKWmHaSIoNHPoaew9IWYV6fRm/fysPtrqzO5cticlC
   89MWjIYuhV87bMwAoISdyosQHHowkWXoTPPtga5E9C68qfaLp8Q0tY74r
   KFIDYAJGpYxHNzy0228wVaDybDJdLj3vaWCN6l4yKx3fsV3Y5SM4jWi2N
   w==;
X-CSE-ConnectionGUID: G3DAHYqPTweufHod34Vhww==
X-CSE-MsgGUID: zO4xJ7RhREybi61eejM2wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="100978212"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="100978212"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:44:29 -0700
X-CSE-ConnectionGUID: w3M8pq+0TxK8Jn1A3nMY9w==
X-CSE-MsgGUID: jOHd42/bSSyopPSjJICU0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="303985532"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:44:29 -0700
Message-ID: <faf9a756-2682-49f7-a6a1-2a46515f773d@linux.intel.com>
Date: Thu, 1 Oct 2026 10:44:27 -0700
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
Subject: Re: [PATCH 7/7] PCI/AER: Enable baseline capability error reporting
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Raag Jadav <raag.jadav@intel.com>,
 Riana Tauro <riana.tauro@intel.com>, Yury Murashka <yurypm@arista.com>,
 Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Aravind Iddamsetty <aravind.iddamsetty@intel.com>,
 Srinivasa Adatrao <srinivasa.adatrao@intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Keith Busch <kbusch@kernel.org>
References: <cover.1790531238.git.lukas@wunner.de>
 <42a76bec58f9a844ef8d8405abafd6680b7f2ecc.1790531238.git.lukas@wunner.de>
 <510d0d71-f7b3-4988-befa-34ca91d92e77@linux.intel.com>
 <ary1aMGD-hqf78L9@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ary1aMGD-hqf78L9@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas,

On 9/30/2026 12:08 AM, Lukas Wunner wrote:
> On Tue, Sep 29, 2026 at 02:01:42PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> On 9/27/2026 11:02 AM, Lukas Wunner wrote:
>>> @@ -431,6 +432,9 @@ void pci_aer_init(struct pci_dev *dev)
>>>  					       PCI_ERR_COR_ADV_NFAT, 0);
>>>  
>>>  	pci_aer_clear_status(dev);
>>> +enable:
>>> +	if (pcie_aer_is_native(dev))
>>> +		pcie_clear_device_status(dev);
>>>  
>>>  	if (pci_aer_available())
>>>  		pci_enable_pcie_error_reporting(dev);
>>
>> This also enables error reporting below AER-incapable Root Ports, where
>> no AER service handles the ERR_* Messages.  The Root Control System
>> Error enable bits are only cleared by aer_enable_rootport(), which
>> doesn't run on such ports.  If firmware left them set, the newly
>> enabled Messages could result in System Errors.
>>
>> Should reporting be enabled only if an AER service (or DPC) is above
>> the device?
> 
> Excellent observation.  This is a pre-existing issue but I think you're
> right.  However it's non-trivial to fix because just checking for DPC
> capability in the ancestry or AER capability at the Root Port isn't
> sufficient:
> 
> For RCiEPs, we'd need to check whether an RCEC exists which has
> AER capability.  There's an "rcec" pointer in struct pci_dev which
> allows discovering the RCEC responsible for an RCiEP.  But the pointer
> is only set when portdrv binds to the RCEC (pcie_link_rcec()).
> That's much later than when the RCiEP and its capabilities are enumerated.
> 
> When enumerating an RCiEP, we'd need to walk the entire set of PCI devices,
> check if it's an RCEC, check if it's responsible for this RCiEP and assign
> the rcec pointer.  We could try to avoid that by running pcie_link_rcec()
> already on enumeration of the RCEC (and not on probing of portdrv),
> but the RCEC may be enumerated after the RCiEP.  User space could also
> force an unset rcec pointer by issuing remove/rescan of the RCiEP.
> 
> Also, right now when firmware does keep System Error Enable bits in the
> Root Control register set, there's a window between endpoints being
> enumerated (which enables sending of ERR_* messages) and Root Ports
> being bound to portdrv (which clears System Error Enable bits).
> 

Agreed, the RCiEP case makes this hard, and the window already exists.

Could you add a sentence to the commit message noting that reporting
is now also enabled on AER-incapable devices below AER-incapable Root
Ports?  That way, if someone bisects a new System Error to this
commit, the reason is obvious.


> Any errors that occur during that window will cause a System Error
> right now.
> 
>> Or alternatively, clear the Root Control System Error
>> enable bits on AER-incapable Root Ports?
> 
> I'm worried that users may deliberately enable System Error bits in
> BIOS on such systems precisely because there's no other way to catch
> them.
> 

Fair point, let's leave them alone.


> Thanks for the thoughtful review, much appreciated!
> 
> Lukas

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


