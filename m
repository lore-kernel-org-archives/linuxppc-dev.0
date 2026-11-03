Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012D7606A326
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kpDPeG05
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJtmX4S9mz2xSZ;
	Wed, 04 Nov 2026 03:09:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793722140;
	cv=none; b=bZGFn7snljpGRxSVmdC3eR6gvCnxXoJs9DI56QazODlohMzOduoK+NatoG/EDbzOJcMmBKaOQWdh8PN2tqxk9rojGdHulreAOqYnfkGMGbWh1QCO534vQwazdS3r6SERaidl5d8OBOE+TvbKxb3OhLzPfPgQZo3Bt8o1Y1u4b0OmF5Tx3I4JMl8zDaAGh8/OVdWb5YY3cyH0g6I+1CMDQJRRvsKS0AzQI+e5+hb/UALm0MIMBpmDFIM2b0rqF99z81tl0mwgND0IMGaabclr8y8p0HeU66nWRhGD3pZ3aqGr4zKqb4lY9s3eMEnihTjymLjHwcz8P/BUdRTZAw+0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793722140; c=relaxed/relaxed;
	bh=Rc07ArdQvFh+ft5vlXAchmesZ95OF36366xbM/Kgcjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKTfAn7gAWcsd9mFegDoxZWdfZYmAiqf6Om5M1sj/6EGGoP+RjBWJjL2znhqBiKXPOX49Yg5SmgtssTtHbfwzbwjA6H1hE0Lgx5+zIXqjoRhwBYEmw8KtWy6+yWmF/etBxxRjgAnO6ZDRfmP8ZLT9QBFb8YR/mvvHzGCeihU4UwIvnDVMJNluWNXT7P6oldZIky9pQRUioNDHKxiO9Q/lxUs/dCaUxuyNyBc2csZ+Fzcqr2nJZb7RmNHh2yR1z+tUUm9CZ69p9ZIp29bQCooUyxlqTXszYTldstR8P6F12lk8RijYeuOcl1SCwIQd5lGkDOpXLY9hQcN2ExgDXOd9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kpDPeG05; dkim-atps=neutral; spf=pass (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kpDPeG05;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=sathyanarayanan.kuppuswamy@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJtmV030Nz2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 03:08:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793722138; x=1825258138;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8pQlpQpDC9jLiJmdWIqN0LUbmYhioNBj7jR8j2FrOyc=;
  b=kpDPeG05FbcOPh+Oyd6Irxgsi0utn6L2kL8tNxOgZ130vA3pl+lEaL6K
   XWBNHTShZ4IaTk8O48kDn9rkaBh5gsMKy9b80sOH6LDTpPgD8zWVaZSUf
   mz5TT6WKg09W1GxeEI/6wDlVCqKJ1YRc/DOuoLV/j4L9myObgrRgqe5oB
   /LvcTa5QfODhWdGW9I7skM/wVF7nN9Je1ds35wN4medmJBzgJdnj+IE5c
   YFHEiTL9fPQlIChAeKmmFv5bC+MoEX91yEQfFamI8tqLk1l5egYPujw4p
   A+0pSIYPEcabJCgGNcC6bpZjNyZDvG1APUDmV97X1zuCZNkiI7jlKYfiP
   A==;
X-CSE-ConnectionGUID: OBHqX9j+Q9+GWy3LxHO3ag==
X-CSE-MsgGUID: M4Wxp9G5SNe3myw1sq9SnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2446211"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2446211"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:08:53 -0800
X-CSE-ConnectionGUID: uGjADqWgSpOzMTcRDilLrw==
X-CSE-MsgGUID: M51pzQjCSG+Mh6jTN8qQOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6572925"
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.80.90]) ([10.24.80.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:08:52 -0800
Message-ID: <7ce177a6-e03e-419c-8af0-027b8b21ab1a@linux.intel.com>
Date: Tue, 3 Nov 2026 08:08:52 -0800
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
Subject: Re: [PATCH 1/2] PCI/AER: Avoid NULL pointer deref on search for Error
 Source
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 Alex Deucher <alexander.deucher@amd.com>, Keith Busch <kbusch@kernel.org>,
 Maciej Grochowski <Maciej.Grochowski@sony.com>
References: <cover.1793697480.git.lukas@wunner.de>
 <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <6de42407246d270c75126baa338761e6f21ab067.1793697480.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/3/2026 1:45 AM, Lukas Wunner wrote:
> A Root Port's subordinate bus may be NULL if the PCI core runs out of bus
> numbers on enumeration.  Yet when the AER driver searches for the source
> of an Error Message, it dereferences the subordinate pointer without
> checking for NULL.  Fix it.
> 
> Fixes: 28eb27cf0839 ("PCI AER: support invalid error source IDs")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v2.6.31+
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/pci/pcie/aer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index db4f607f889c..d492c7ce01e1 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1251,7 +1251,7 @@ static bool find_source_device(struct pci_dev *parent,
>  
>  	if (pci_pcie_type(parent) == PCI_EXP_TYPE_RC_EC)
>  		pcie_walk_rcec(parent, find_device_iter, e_info);
> -	else
> +	else if (parent->subordinate)
>  		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>  
>  	if (!e_info->error_dev_num)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


