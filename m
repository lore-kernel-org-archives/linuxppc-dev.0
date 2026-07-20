Return-Path: <linuxppc-dev+bounces-24535-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADC3C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 20:25:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3sTY0YZvz2yLY;
	Tue, 21 Jul 2026 06:25:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784579136;
	cv=none; b=USb+Txrss1KvCj4sv9H8U/n8e5IoSqkaGg1h5RffHXZ+0cgXNXq1S5WUwiIWevd1BZOFiGGMWAXRpjgomGz+XxafpxChtxBZzfN6qXWb2F6T+4SKH0Gvt1sm4sds5aQZzKp1mJrmjBy23cO/pjROh3sPRL1gA1Dns9eCTjKsJP2GPZKU0XrPJI5UlufcLE4QynUDWdTxrgrtP1CSTD7AALn17wO3w3EB6pRlo8rPH30qMnB7vTEH9TOxa6YtxUXpwCAhQWcR0hCoL5tni+f6R6yebctQRZqLoMtaX4pSYLVsr00Wt2KBmrIQkgDWXCxOMqA9PfxW5/2m5TbOEBeO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784579136; c=relaxed/relaxed;
	bh=upzH52gl2nd/fMGeicXjjv4E+Lxu7x+uvt3dFOBdnbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVbIW06CUz1GWgzY6EEpeyMTsH0nvGZSTVOM8IZ/syA7Unupfoz9SX246jgjmdFGggR0kYN8MI018fCRBgyT6I9mFIBDXTlJk4yJLtQ3FOoPuJLSjcXo4YElWU41iCvEIm0L1p3um95VU/Fx9pOnChIA7dZcSgcXcuJF3cRlvCGx/Ll69y2X5fuAe5BWdPUbQE3bxxRfdu9xXWwsh9FQRUV8UkSRswlG6Pt8LvJfSV0l1OoC6VJKgna8h/WDYuuCtZymYiz/AhHv57ZbBfunMuLgWw8mXOYknyqIBw/Tui8Gdij/VLeHZI2AKLi+IVKf0JzWXej/QqtqFcq3/i7DYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SCMKGr4v; dkim-atps=neutral; spf=pass (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SCMKGr4v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3sTV1C0Vz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:25:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784579134; x=1816115134;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Lfc8ES4RaxKThEhEsV6WScyH14eDYM7+mOtzgzv1vic=;
  b=SCMKGr4vlW8OvwG6jlffB3upqupE2sFwd2wB6KloLuDgSLE7NFg+NfW9
   SOzf88vvG/BzECZQipSzXzEda5wBVcOGUFyDeQz5bT8oNXBBpTAFaTZE/
   HblOcXmY+HPwqnbaDWBUibemlefvjElXnAltnIKVHsUtSPaXCCtjSsD5j
   Qi+8M+o94U1QP0g3jbAmfsKuGICvGK+3vB27xdsUfZEAnLOz3pzVASwcu
   cshsGLkIFxi6LkvfaTD3ytAh8wcwRBePkOcdHxPAAlelTN4Sf2MsInYKD
   wXsuqFeAVF6ZxjS9QWcZvkJ3d4/TjMMYueFVdKJFOUcML+L+dRSipzKUT
   A==;
X-CSE-ConnectionGUID: GrLNGRK0R2exfkG/7FJxEg==
X-CSE-MsgGUID: WBRYgJ06SzqavmCtO9xv+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87709270"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87709270"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:25:27 -0700
X-CSE-ConnectionGUID: FQ3gppGmTgqMnyy5lXezCQ==
X-CSE-MsgGUID: G/FdKpsqTWarRCSztogosg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="280832117"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:25:24 -0700
Message-ID: <c3184061-58d1-4c93-b644-eef30d95d13e@intel.com>
Date: Mon, 20 Jul 2026 13:25:22 -0700
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
Subject: Re: [PATCH v18 04/13] cxl: Rename find_cxl_port() to
 find_cxl_port_by_dport()
To: Terry Bowman <terry.bowman@amd.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Len Brown <lenb@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Robert Richter <rrichter@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Alejandro Lucero <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Ankit Agrawal <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>,
 Ben Cheatham <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>,
 Breno Leitao <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>,
 "Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Gregory Price <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Li Ming <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Oliver O'Halloran <oohall@gmail.com>, Shiju Jose <shiju.jose@huawei.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>,
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
 Tony Luck <tony.luck@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
 <20260717222706.3540281-5-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:26 PM, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> find_cxl_port() and find_cxl_port_by_uport() are internal port lookup
> functions that search the CXL bus by dport and uport respectively, but
> their names do not make the lookup method clear.
> 
> Rename find_cxl_port() to find_cxl_port_by_dport() to make the lookup
> method explicit and consistent with find_cxl_port_by_uport(). Both
> functions remain static to port.c; the upcoming patch that adds the
> first cross-file caller will widen their scope.
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v17 -> v18:
> - New commit
> ---
>  drivers/cxl/core/port.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f90f899c31d07..cadb51f70f854 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1379,7 +1379,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
>  	return dport != NULL;
>  }
>  
> -static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
> +static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
>  {
>  	struct device *dev;
>  
> @@ -1392,8 +1392,16 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +/**
> + * find_cxl_port_by_dport - find a cxl_port by one of its targets
> + * @dport_dev: device representing the dport target
> + * @dport: optional output of the 'struct cxl_dport' companion of the @dport_dev
> + *
> + * Return a 'struct cxl_port' with an elevated reference if found. Use
> + * __free(put_cxl_port) to release.
> + */
> +static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
> +					       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> @@ -1401,7 +1409,7 @@ static struct cxl_port *find_cxl_port(struct device *dport_dev,
>  	};
>  	struct cxl_port *port;
>  
> -	port = __find_cxl_port(&ctx);
> +	port = __find_cxl_port_by_dport(&ctx);
>  	return port;
>  }
>  
> @@ -1895,14 +1903,14 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, "CXL");
>  struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
>  				   struct cxl_dport **dport)
>  {
> -	return find_cxl_port(pdev->dev.parent, dport);
> +	return find_cxl_port_by_dport(pdev->dev.parent, dport);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, "CXL");
>  
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>  				   struct cxl_dport **dport)
>  {
> -	return find_cxl_port(grandparent(&cxlmd->dev), dport);
> +	return find_cxl_port_by_dport(grandparent(&cxlmd->dev), dport);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, "CXL");
>  


