Return-Path: <linuxppc-dev+bounces-28528-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B87CA5FA7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 19:55:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvTRY1qYDz2yD3;
	Wed, 30 Sep 2026 05:55:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790711705;
	cv=none; b=RzPXKJ6/SWRZ49APSaWWhl1PFEz4Wm9QfVxTfehIMF+WDvRcf5tcHXiqxGAA2m4WhL/QI+C8ATUWjC1xhLCAYz0QxotL066slyUfIs0iQ6Plg54HHdasX44inNcbobaZp/QFqDOjkZxV2tLn2aB9VnKnQfkp5JYimrgBZeM/S+71Dp5M4RDB9LrDLNFe0w4KvdwoEbFG2MQCN45qVJpkwakqsx8Vsieg+MT5ufKLKDRsEEgBP4ckqz1kiWHXBqCCu7qbTda9MTD3Q4QkvJTwu2bm2ehtAJgiExfOb/GrwZl7+Redc+FFfA3J3gHAq5wTKeQc/CkJstytrynhYjFHwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790711705; c=relaxed/relaxed;
	bh=FjRJqFwC9RnBXym/Keapmz0sxN4yjX99D293dYKD6WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhS+PrthTeuvdXxY2oOBLGAH93HYcSDyBvWxQAzEcqSuUEkv8EXYqUBNhgPyZoO1TuWNnuFa15bt0X0H5vbRqqE5CmXpYTfkMMsJa+9zkX6DcX5CWjR+njWqdCyNHG+U/MR2Y8V04fVBscStRtkxBpabM9s7NLYLBKE2VE/uBnZ2LlTExuKRwfvGkyVMwhos3HTudxa/fzzwdjZ1mdBd/fY/gkXuVYRriU5X4LLmWaS2YFH3BQIFQiYQ/DdI23yb6WbIIs4FGBPRSva2MPEaOTnY+dfpmjUrw0qoy8WDIKyhadm8Jm3ydQ2LFODwi+WdVeIBbAzDuaTMAkGP4DZ0IA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fwlB076K; dkim-atps=neutral; spf=pass (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fwlB076K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvTRX1DYVz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 05:55:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790711704; x=1822247704;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dUjNyb1h3b94BZyQ3gAJU25yty+v8AyaGD3/bgCbkkg=;
  b=fwlB076Kr8K01jfxtzFO74EnMLgG+3x73czXq+GRrTG5p6sbCaAxKOoX
   TFGULbJPueiXsTTKd9Hij+HS7n8DqBojuf+exKak3TeUZi6EH6n9lvHBN
   /CrXeJv0tMASTxvFiHoe+a+/0gYGrSMSwn1OIsq/ViE+gmGB8YFUDFFXh
   idhLQwaEok/sE9Py9QDgIJ3xAlsRbVUF5H0Ce5awGUQfz3/nF6KDf14U1
   xZQ3vMbtgN6ohIAY5fooepCXfJimD6vNDAOwistVMBhgi2Mq9JTCPgtDd
   NOGJ4VG6NhrsjTAKogTqQejPXfwggofiXmqrHXZsTfXAZS6xBqN5ifpy1
   A==;
X-CSE-ConnectionGUID: ASH8NO6ORB6YltRYCzCl1w==
X-CSE-MsgGUID: IgxzbhLtRtaFs1u49mszCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="79005337"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="79005337"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:55:02 -0700
X-CSE-ConnectionGUID: i8ZCpWykR/2DwbpUOjV67Q==
X-CSE-MsgGUID: P7temBsESBCAIKsBwjEizQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="274673188"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 12:55:01 -0700
Message-ID: <ad14dd46-851d-4caf-a877-50e53c60e661@linux.intel.com>
Date: Tue, 29 Sep 2026 12:55:00 -0700
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
Subject: Re: [PATCH 6/7] PCI/AER: Renumber severity constants
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
 <244713dea3786099e9ad4eb10ff9f2f430cd7ad3.1790531238.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <244713dea3786099e9ad4eb10ff9f2f430cd7ad3.1790531238.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas,

On 9/27/2026 11:02 AM, Lukas Wunner wrote:
> The AER driver uses constants for Correctable, Non-Fatal and Fatal Error
> severity which look as if they match something in the spec, but are
> actually just made-up numbers.
> 
> Use the bit number in the Device Status Register instead (PCIe r7.1 sec
> 7.5.3.5).  A subsequent commit takes advantage of this by using BIT() to
> conveniently compute the register bit corresponding to a given severity.
> 
> While at it, drop the DPC_FATAL constant which was introduced by commit
> b09803b5e546 ("PCI/DPC: Use the generic pcie_do_fatal_recovery() path")
> but never saw any use in 8 years.
> 

This changes the raw severity value in the aer_event tracepoint, which
may break userspace.  rasdaemon relies on the current numbering
(enum hw_event_aer_err_type in core/ras-events.h), so it would
misclassify error.


> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
>  drivers/pci/pcie/aer.c  | 2 +-
>  include/linux/aer.h     | 8 ++++----
>  include/ras/ras_event.h | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 34a8eddc427a..6bc843ab9b37 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -504,9 +504,9 @@ void pci_aer_exit(struct pci_dev *dev)
>   * AER error strings
>   */
>  static const char * const aer_error_severity_string[] = {
> +	"Correctable",
>  	"Uncorrectable (Non-Fatal)",
>  	"Uncorrectable (Fatal)",
> -	"Correctable"
>  };
>  
>  static const char *aer_error_layer[] = {
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index df0f5c382286..795c55132008 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -11,10 +11,10 @@
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  
> -#define AER_NONFATAL			0
> -#define AER_FATAL			1
> -#define AER_CORRECTABLE			2
> -#define DPC_FATAL			3
> +/* Must match bit number in Device Status Register (PCIe r7.1, sec 7.5.3.5) */
> +#define AER_CORRECTABLE			0
> +#define AER_NONFATAL			1
> +#define AER_FATAL			2
>  
>  /*
>   * AER and DPC capabilities TLP Logging register sizes (PCIe r6.2, sec 7.8.4
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index fdb785fa4613..1e03ade99386 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -302,7 +302,7 @@ TRACE_EVENT(non_standard_event,
>   *			([domain:]bus:device.function).
>   * u32 status -		Either the correctable or uncorrectable register
>   *			indicating what error or errors have been seen
> - * u8 severity -	error severity 0:NONFATAL 1:FATAL 2:CORRECTED
> + * u8 severity -	error severity 0:CORRECTED 1:NONFATAL 2:FATAL
>   */
>  
>  #define aer_correctable_errors					\

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


