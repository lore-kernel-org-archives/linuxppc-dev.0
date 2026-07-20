Return-Path: <linuxppc-dev+bounces-24531-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C020FC44529
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 20:09:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3s6p4XjYz2yDs;
	Tue, 21 Jul 2026 06:09:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784578162;
	cv=none; b=jL/e8pl58gK5OY1Euk6tw7ixNVgASGyCKc0pcuznflE0ZbUeMwAWhZLygYSgYDy05DFR/b+naXqiq3kfdOTWK20PFjRDzAXz30TAKse+7cuElzAvfCTJqXhu4448PhOGYWYK2IsTt+0NWddWPK6xPaLSURYFafzTb0ttKEuzxclcxC+HYUiiHv0AQgmndR7UKH0BsC+6vVSWCsnhmACetclKBcr5ZSlkEPRtPr900f9qY/os8ZOLXLv7DkJzTkBVZoRoRFEKRFZ82r5Jb9YAzyTdUtHNe34c7ypd5cuhx4UjQ0jLYtrTVnHDnts7uHf4ZthnVSEG8ewzYib0q68Ipg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784578162; c=relaxed/relaxed;
	bh=U/+EfaISD/OuTDTd3FeBLHM2iob4iyve/vqxe3Vo1Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHYLCdv1MKlRZ+gn33HRpsryGWuEnxWJxvzPSVpx4hOtsC7mE7niETY2I29Y9HUSF4eCSuC8T5EHfzCvm+MjpcfL+v7yBf28nbA6lhXdcujUKrPdaJcb0LrIidc3G5+ImnntwUnMrSyv4197Ecn+ifAESDe1eMbPtI51iBo2sxT6JSoopfgOHmIfkBmanOqrfwn9jIWcbxSTZC0LoDvTXkRlaOhtsgWmS4REo2HPs5ZUvhAsGEexAGq2wB3SJSf48JZ+LJc/lU0RzrxC9dK9Lf3MRDdT3E3604e7SoWWFUEiBWfF5yiVG2/pkC8OB9mBwnzwMZX+SyUkC0nsEnsktw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kaKCx3DK; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kaKCx3DK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3s6l3c74z2xlb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:09:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784578160; x=1816114160;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sFOpv2kA+FwJCaEso+qENIiQ1hBBWw24vR/Se27HPGs=;
  b=kaKCx3DKZ//Ozv3PbcKBTfWmVJ6uV9R+yGlPpu67v4fxWLbStbSC20wk
   7SP43conxay8FP33s4QOIzq+79P2DN/EpyscSz8lmKOFNtZKc9hk1j0Fv
   Db4hHqTf2Lzc10RvH6xoR3CtJ04fyzMZr+kAocNtpUknYrPHXbuUJApPq
   Y/Di1Hpfz2CK+cF/vuOhDv6AGL+K+lWQfduGgNh+QzFO6iL0+GU41/QOf
   PfN7DIG9gfTZvn95nGim5jWCJDTZ6Z4qiBZvX72wbl/jYtAwSRPh442l9
   chBe7pqSnOxyrAgnypTYdTf90+KzS74Z0R/Xh4Wozc6g0vcFtWGm5sY5J
   w==;
X-CSE-ConnectionGUID: 2CEHrJK3S7iLNsAjraHmTg==
X-CSE-MsgGUID: fa/9hpOYRk6Lv/SCGJM+vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84298321"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="84298321"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:09:13 -0700
X-CSE-ConnectionGUID: H4x5cj83RbqFt5QQqpUxGA==
X-CSE-MsgGUID: pA3maaPWTcelrKWA5o3qPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="256365696"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:09:10 -0700
Message-ID: <9c371c59-c871-4988-83d7-2aa780d8e6c4@intel.com>
Date: Mon, 20 Jul 2026 13:09:09 -0700
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
Subject: Re: [PATCH v18 01/13] cxl/ras: Fix cxl_rch_get_aer_severity() wrong
 severity register
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
 <20260717222706.3540281-2-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:26 PM, Terry Bowman wrote:
> cxl_rch_get_aer_severity() classifies RCH Downstream Port uncorrectable
> errors as fatal or non-fatal by ANDing uncorrectable status with
> PCI_ERR_ROOT_FATAL_RCV. This is wrong because PCI_ERR_ROOT_FATAL_RCV is a
> Root Error Status register bit (bit 6), not a severity bit. ANDing it
> against uncorrectable status tests a reserved bit and produces incorrect
> severity classification.
> 
> Fix by ANDing the unmasked uncor_status against uncor_severity. Per
> PCIe Base Spec r6.0 Section 7.8.4.4, each bit in the Uncorrectable
> Error Severity register indicates whether the corresponding error is
> fatal (1) or non-fatal (0).
> 
> Fixes: 6ac07883dbb5 ("cxl/pci: Add RCH downstream port error logging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

This can be picked up ahead looks like?

> 
> ---
> 
> Changes in v17 -> v18:
> - New patch.
> ---
>  drivers/cxl/core/ras_rch.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index 0a8b3b9b63884..44b335d560708 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -80,7 +80,8 @@ static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
>  				     int *severity)
>  {
>  	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +		if ((aer_regs->uncor_status & ~aer_regs->uncor_mask) &
> +		    aer_regs->uncor_severity)
>  			*severity = AER_FATAL;
>  		else
>  			*severity = AER_NONFATAL;


