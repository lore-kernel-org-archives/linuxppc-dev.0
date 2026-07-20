Return-Path: <linuxppc-dev+bounces-24552-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44EEC44520
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 22:45:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3wZb1rRjz2xRs;
	Tue, 21 Jul 2026 08:45:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784587511;
	cv=none; b=il/OV1PAYNXBjpZyfGu/8Q2/XeB/wHy4Dz3tmBHYKChS0JHt/k5aRx+R7J+EzVkh4wdkclEQ9h2XeB2rpL78qKfJnSJSJACPb0BCZEODOLT1x4cqj8RJAT7716Zx4KfJkm+kRLAPiqbZa83834G5Sv2CF4D40Hbf5W9z0BP7E9sWQ80UWFRqx3gw9vAGHg/9eyxY7Tp9ju48u7fW9aNntQ35//mslYl0oSC/sTZVesxsDqG1GlfYtWXZLYbRBfYmbsImbygqj+uXc9s34kypiAH4UH7K0Z5stKphCj0TB9MOCbaw/4029+E4kPxYCEZh4IUpqNirQCWP13wbPurfVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784587511; c=relaxed/relaxed;
	bh=wdNaYHzW0NvJZX6X6+gPbt1adZWkKLRn2LkNFWsyBYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hQP1hqnnltPRNEM/rC3MvQFBs3RCBUVHCM5jPD1f98kBFkGqrn/HCE2v7m04fK/PsJCjJVexOo+QCXVhdPryt4fMAK+FFOgVLOwWgBNkUFSFJhBMmQSCsWAtDrBBY3h9RS84newc8M7s/DWl7Wo8fsJ/WaQkpKuno+D6TEnVfqhcpyr8ePAi44YRcUI6jA6kLJpQF0drVQ2CXiQ6aifdfXXmEUEwWjM2VbOzl0gIvz1z7AV25GoRDjxtN444gwkcKoKhiZXgh0NXXNb5Efw9rrQO8kgY0alMjcHbMcxFEKri/Kxe3eBeRu5Lp1T9wzrEg1SK4+OI2V0LtScbrzAXbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cN7EAg6K; dkim-atps=neutral; spf=temperror (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cN7EAg6K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=temperror (SPF Temporary Error: DNS Timeout) smtp.mailfrom=intel.com (client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3wZV5qyMz2xLg
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 08:44:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784587507; x=1816123507;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hN3QLclt/wA7p1TWUWcesju1Am7yODcgDg8piiTGwAc=;
  b=cN7EAg6KOjAhy2LdEdD/A60nWG+q6QTJ+J09T7X6+VaQUGSd9JvwXc/h
   bu+fVkqVVfPQmV4EJTgLQhP6ToQmFy/cDzyMBTPtokT10F75Ca0PgzFGX
   6oHMp8rjgpaesGC56zejsTT1BelgpIc2gq1F8dSr1g1QYhLCwpOHuX+m/
   saZCcXXKOiO3KKTU1LloOWRJnicFAP/UAYvS/6v/s7qGI7ESOPLmRYpEx
   LGQLsrs5uI5rTfQrit9aX9UB07g3zKtNZ2nrori1nztvSmaOatAphTH5w
   6svOENSGesoquiXZYaRJcL/bLA4FhxhQRR6eH3gF3EA7IOSAqUcvgGLjD
   g==;
X-CSE-ConnectionGUID: gHmKtoKeSx6DbBKXmz38FQ==
X-CSE-MsgGUID: eONZUvWMRhex+Gd3/Gcijg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="87719390"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="87719390"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:44:41 -0700
X-CSE-ConnectionGUID: xV61v8kBT0K1qdA7Rghk3Q==
X-CSE-MsgGUID: nBhCtkolRYO3Vvuzwg6txA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="254175385"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:44:38 -0700
Message-ID: <bcb2bbdf-59d4-4ca2-bcb3-7e7be71c691c@intel.com>
Date: Mon, 20 Jul 2026 15:44:37 -0700
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
Subject: Re: [PATCH v18 10/13] cxl: Add port and dport identifiers to CXL AER
 trace events
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
 <20260717222706.3540281-11-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-11-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:27 PM, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> Pass struct cxl_port * and struct cxl_dport * to the cxl_aer_*
> trace events instead of a plain struct device * derived at the
> caller. The trace event helpers then derive the right strings for
> endpoints, switch ports, root ports, and RCH downstream ports
> consistently across the CPER and native AER paths.
> 
> The unified cxl_aer_* events keep "memdev" as the legacy field
> (endpoint events populate it with the memdev name; non-endpoint
> events emit memdev="") and add new "port" and "dport" string fields
> populated for all CXL device classes. Updated userspace can key
> off "port" and "dport" without a parallel set of events.
> 
> Remove the separate cxl_port_aer_uncorrectable_error and
> cxl_port_aer_correctable_error trace events. All CXL AER events now
> use the unified cxl_aer_* events with port and dport fields.
> 
> Rework cxl_cper_handle_prot_err() to use find_cxl_port_by_dev() and
> the unified trace helpers, replacing the per-port-type branching and
> bus_find_device() memdev lookup.
> 
> The TP_printk format string places "port=%s dport=%s" between
> "memdev=%s" and "host=%s", changing the text-mode field order from
> the pre-patch output. This does not affect consumers such as
> rasdaemon that use libtraceevent to parse fields by name rather than
> by fixed text position.
> 
> For non-endpoint events (switch port, root port, RCH dport),
> "memdev" is empty and "port"/"dport" carry the topology information.
> 
> The serial number is retrieved via pci_get_dsn() which performs live
> PCI configuration space reads. A following patch ("PCI: Cache PCI
> DSN into pci_dev->dsn during probe") replaces these with a cached
> serial number to avoid config space access in error handlers and panic
> paths.
> 
> Below are examples of the different CXL devices' error trace logs
> after this patch:
> 
>      ---------------------
>      | CXL RP - 0C:00.0  |
>      ---------------------
>                |
>      ---------------------
>      | CXL USP - 0D:00.0 |
>      ---------------------
>                |
>      --------------------
>      | CXL DSP - 0E:00.0 |
>      --------------------
>                |
>      ---------------------
>      | CXL EP - 0F:00.0  |
>      ---------------------
> 
> Root Port:
> cxl_aer_correctable_error: memdev= port=port1 dport=0000:0c:00.0 \
>    host=pci0000:0c serial=0: status: 'Memory Data ECC Error'
> 
> cxl_aer_uncorrectable_error: memdev= port=port1 dport=0000:0c:00.0 \
>    host=pci0000:0c serial=0: status: 'Cache Address Parity Error'  \
>    first_error: 'Cache Address Parity Error'
> 
> Upstream Switch Port:
> cxl_aer_correctable_error: memdev= port=port2 dport= host=0000:0d:00.0 \
>    serial=0: status: 'Memory Data ECC Error'
> 
> UCE NA - Upstream Switch Port UCE's are handled in the portdrv driver's
> PCI AER callbacks that are not CXL aware.
> 
> Downstream Switch Port:
> cxl_aer_correctable_error: memdev= port=port2 dport=0000:0e:00.0 \
>    host=0000:0d:00.0 serial=0: status: 'Memory Data ECC Error'
> 
> cxl_aer_uncorrectable_error: memdev= port=port2 dport=0000:0e:00.0 \
>    host=0000:0d:00.0 serial=0: status: 'Cache Address Parity Error' \
>    first_error: 'Cache Address Parity Error'
> 
> Endpoint:
> cxl_aer_uncorrectable_error: memdev=mem1 port=endpoint4 dport= \
>    host=0000:0f:00.0 serial=0: status: 'Cache Address Parity Error' \
>    first_error: 'Cache Address Parity Error'
> 
> cxl_aer_correctable_error: memdev=mem1 port=endpoint4 dport= host=0000:0f:00.0 \
>    serial=0: status: 'Memory Data ECC Error'
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> Changes in v17->v18:
> - Consolidate double find_cxl_port_by_dev() in cxl_cper_handle_prot_err()
> - Add comment noting dport is NULL for Endpoint and Upstream Port devices
> - Add cxl_trace_* helpers
> - Add CPER refactor
> 
> Changes in v16->v17:
> - Replace cxlds->serial with pci_get_dsn()
> - Change 'memdev' to 'device' (Dan)
> - Updated Commit message
> 
> Changes in v15->v16:
> - Add Dan's review-by
> - Incorporate Dan's comment into commit message:
> "Add the serial number at the end to preserve compatibility with
> libtraceevent parsing of the parameters."
> 
> Changes in v14->v15:
> - Update commit message.
> - Moved cxl_handle_ras/cxl_handle_cor_ras() changes to future patch (terry)
> 
> Changes in v13->v14:
> - Update commit headline (Bjorn)
> 
> Changes in v12->v13:
> - Added Dave Jiang's review-by
> 
> Changes in v11 -> v12:
> - Correct parameters to call trace_cxl_aer_correctable_error()
> - Add reviewed-by for Jonathan and Shiju
> 
> Changes in v10->v11:
> - Updated CE and UCE trace routines to maintain consistent TP_Struct ABI
> and unchanged TP_printk() logging.
> ---
>  drivers/cxl/core/core.h    |   8 +--
>  drivers/cxl/core/ras.c     | 131 +++++++++++--------------------------
>  drivers/cxl/core/ras_rch.c |   3 +-
>  drivers/cxl/core/trace.c   |  35 ++++++++++
>  drivers/cxl/core/trace.h   |  91 ++++++++------------------
>  drivers/cxl/cxlmem.h       |   7 ++
>  6 files changed, 113 insertions(+), 162 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 5ca1275fd8f35..a55a4e409feda 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -186,11 +186,11 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>  void cxl_ras_init(void);
>  void cxl_ras_exit(void);
>  bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> -		    void __iomem *ras_base);
> +		    void __iomem *ras_base, u64 serial);
>  void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  		     struct cxl_dport *dport);
>  void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> -			void __iomem *ras_base);
> +			void __iomem *ras_base, u64 serial);
>  void cxl_dport_map_rch_aer(struct cxl_dport *dport);
>  void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>  void cxl_handle_rdport_errors(struct pci_dev *pdev);
> @@ -200,14 +200,14 @@ void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>  static inline void cxl_ras_init(void) { }
>  static inline void cxl_ras_exit(void) { }
>  static inline bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> -				  void __iomem *ras_base)
> +				  void __iomem *ras_base, u64 serial)
>  {
>  	return false;
>  }
>  static inline void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport) { }
>  static inline void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport,
> -				      void __iomem *ras_base) { }
> +				      void __iomem *ras_base, u64 serial) { }
>  static inline void cxl_dport_map_rch_aer(struct cxl_dport *dport) { }
>  static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>  static inline void cxl_handle_rdport_errors(struct pci_dev *pdev) { }
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index d5dc2c22565da..acf40b2396c3b 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -12,69 +12,37 @@
>  static_assert(CXL_HEADERLOG_TRACE_SIZE_U32 == 128,
>  	      "rasdaemon ABI requires exactly 128 u32s");
>  
> -static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> -					      struct cxl_ras_capability_regs ras_cap)
> -{
> -	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> -
> -	trace_cxl_port_aer_correctable_error(&pdev->dev, status);
> -}
> -
> -static void cxl_cper_trace_uncorr_port_prot_err(struct pci_dev *pdev,
> -						struct cxl_ras_capability_regs ras_cap)
> +static void cxl_cper_trace_uncorr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
> +					   u64 serial, struct cxl_ras_capability_regs *ras_cap)
>  {
>  	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
> -	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> +	u32 status = ras_cap->uncor_status & ~ras_cap->uncor_mask;
>  	u32 fe;
>  
>  	if (hweight32(status) > 1)
>  		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> -				   ras_cap.cap_control));
> -	else
> -		fe = status;
> -
> -	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
> -	trace_cxl_port_aer_uncorrectable_error(&pdev->dev, status, fe, hl);
> -}
> -
> -static void cxl_cper_trace_corr_prot_err(struct cxl_memdev *cxlmd,
> -					 struct cxl_ras_capability_regs ras_cap)
> -{
> -	u32 status = ras_cap.cor_status & ~ras_cap.cor_mask;
> -
> -	trace_cxl_aer_correctable_error(cxlmd, status);
> -}
> -
> -static void
> -cxl_cper_trace_uncorr_prot_err(struct cxl_memdev *cxlmd,
> -			       struct cxl_ras_capability_regs ras_cap)
> -{
> -	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
> -	u32 status = ras_cap.uncor_status & ~ras_cap.uncor_mask;
> -	u32 fe;
> -
> -	if (hweight32(status) > 1)
> -		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> -				   ras_cap.cap_control));
> +				   ras_cap->cap_control));
>  	else
>  		fe = status;
>  
>  	/*
> -	 * ras_cap.header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
> +	 * ras_cap->header_log[] holds CXL_HEADERLOG_SIZE_U32 (16) hardware
>  	 * dwords.  Copy them into the front of a zero-filled
>  	 * CXL_HEADERLOG_TRACE_SIZE_U32 (128) u32 staging buffer so the trace
>  	 * event memcpy sees a full 512-byte source and the userspace ABI
>  	 * (rasdaemon) is preserved.
>  	 */
> -	memcpy(hl, ras_cap.header_log, CXL_HEADERLOG_SIZE);
> -	trace_cxl_aer_uncorrectable_error(cxlmd, status, fe, hl);
> +	memcpy(hl, ras_cap->header_log, CXL_HEADERLOG_SIZE);
> +	trace_cxl_aer_uncorrectable_error(port, dport, status, fe,
> +					  hl, serial);
>  }
>  
> -static int match_memdev_by_parent(struct device *dev, const void *uport)
> +static void cxl_cper_trace_corr_prot_err(struct cxl_port *port, struct cxl_dport *dport,
> +					 u64 serial, struct cxl_ras_capability_regs *ras_cap)
>  {
> -	if (is_cxl_memdev(dev) && dev->parent == uport)
> -		return 1;
> -	return 0;
> +	u32 status = ras_cap->cor_status & ~ras_cap->cor_mask;
> +
> +	trace_cxl_aer_correctable_error(port, dport, status, serial);
>  }
>  
>  
> @@ -109,47 +77,34 @@ static struct cxl_port *find_cxl_port_by_dev(struct device *dev, struct cxl_dpor
>  
>  void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  {
> +	struct cxl_dport *dport;
>  	unsigned int devfn = PCI_DEVFN(data->prot_err.agent_addr.device,
>  				       data->prot_err.agent_addr.function);
> -	struct pci_dev *pdev __free(pci_dev_put) =
> -		pci_get_domain_bus_and_slot(data->prot_err.agent_addr.segment,
> -					    data->prot_err.agent_addr.bus,
> -					    devfn);
> -	struct cxl_memdev *cxlmd;
> -	int port_type;
> -
> -	if (!pdev)
> -		return;
> -
> -	port_type = pci_pcie_type(pdev);
> -	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
> -	    port_type == PCI_EXP_TYPE_DOWNSTREAM ||
> -	    port_type == PCI_EXP_TYPE_UPSTREAM) {
> -		if (data->severity == AER_CORRECTABLE)
> -			cxl_cper_trace_corr_port_prot_err(pdev, data->ras_cap);
> -		else
> -			cxl_cper_trace_uncorr_port_prot_err(pdev, data->ras_cap);
> -
> +	struct pci_dev *pdev __free(pci_dev_put) = pci_get_domain_bus_and_slot(
> +		data->prot_err.agent_addr.segment, data->prot_err.agent_addr.bus, devfn);
> +	if (!pdev) {
> +		pr_err_ratelimited("Failed to find CPER device in CXL topology\n");
>  		return;
>  	}
>  
> -	guard(device)(&pdev->dev);
> -	if (!pdev->dev.driver) {
> -		dev_warn_ratelimited(&pdev->dev,
> -				     "Device is unbound, abort CPER error handling\n");
> +	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_dev(&pdev->dev, NULL);
> +	if (!port) {
> +		dev_err_ratelimited(&pdev->dev,
> +				    "Failed to find parent port device in CXL topology\n");
>  		return;
>  	}
>  
> -	struct device *mem_dev __free(put_device) = bus_find_device(
> -		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> -	if (!mem_dev)
> -		return;
> +	guard(device)(&port->dev);
> +
> +	/* dport is NULL for Endpoint and Upstream Port devices */
> +	dport = cxl_find_dport_by_dev(port, &pdev->dev);
>  
> -	cxlmd = to_cxl_memdev(mem_dev);
>  	if (data->severity == AER_CORRECTABLE)
> -		cxl_cper_trace_corr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_corr_prot_err(port, dport, pci_get_dsn(pdev),
> +					     &data->ras_cap);
>  	else
> -		cxl_cper_trace_uncorr_prot_err(cxlmd, data->ras_cap);
> +		cxl_cper_trace_uncorr_prot_err(port, dport, pci_get_dsn(pdev),
> +					       &data->ras_cap);
>  }
>  EXPORT_SYMBOL_GPL(cxl_cper_handle_prot_err);
>  
> @@ -240,14 +195,14 @@ void cxl_do_recovery(struct pci_dev *pdev, struct cxl_port *port, struct cxl_dpo
>  		return;
>  	}
>  
> -	if (cxl_handle_ras(port, dport, ras_base))
> +	if (cxl_handle_ras(port, dport, ras_base, pci_get_dsn(pdev)))
>  		panic("CXL cachemem error");
>  
>  	dev_dbg(&pdev->dev,
>  		"CXL UCE signaled but no CXL RAS status bits set\n");
>  }
>  
> -void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
> +void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base, u64 serial)
>  {
>  	u32 status;
>  	void __iomem *addr;
> @@ -259,12 +214,7 @@ void cxl_handle_cor_ras(struct cxl_port *port, struct cxl_dport *dport, void __i
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		if (is_cxl_endpoint(port))
> -			trace_cxl_aer_correctable_error(to_cxl_memdev(port->uport_dev), status);
> -		else if (dport)
> -			trace_cxl_port_aer_correctable_error(dport->dport_dev, status);
> -		else
> -			trace_cxl_port_aer_correctable_error(port->uport_dev, status);
> +		trace_cxl_aer_correctable_error(port, dport, status, serial);
>  	}
>  }
>  
> @@ -289,7 +239,8 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem *ras_base)
> +bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport,
> +		    void __iomem *ras_base, u64 serial)
>  {
>  	u32 hl[CXL_HEADERLOG_TRACE_SIZE_U32] = {};
>  	void __iomem *addr;
> @@ -316,12 +267,7 @@ bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	if (is_cxl_endpoint(port))
> -		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(port->uport_dev), status, fe, hl);
> -	else if (dport)
> -		trace_cxl_port_aer_uncorrectable_error(dport->dport_dev, status, fe, hl);
> -	else
> -		trace_cxl_port_aer_uncorrectable_error(port->uport_dev, status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(port, dport, status, fe, hl, serial);
>  
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
> @@ -360,7 +306,8 @@ pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
>  		 * cases below handle AER recovery for devices without active
>  		 * CXL.mem traffic.
>  		 */
> -		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
> +		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL),
> +				    pci_get_dsn(pdev));
>  	}
>  
>  	/*
> @@ -392,7 +339,7 @@ static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport, int severity)
>  {
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport));
> +		cxl_handle_cor_ras(port, dport, to_ras_base(port, dport), pci_get_dsn(pdev));
>  	else
>  		cxl_do_recovery(pdev, port, dport);
>  }
> diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
> index f4b98f2c11a1c..0385d2f4a2f66 100644
> --- a/drivers/cxl/core/ras_rch.c
> +++ b/drivers/cxl/core/ras_rch.c
> @@ -118,7 +118,8 @@ void cxl_handle_rdport_errors(struct pci_dev *pdev)
>  
>  	pci_print_aer(pdev, severity, &aer_regs);
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_cor_ras(dport->port, dport, to_ras_base(port, dport));
> +		cxl_handle_cor_ras(dport->port, dport, to_ras_base(port, dport),
> +				   pci_get_dsn(pdev));
>  	else
>  		cxl_do_recovery(pdev, dport->port, dport);
>  }
> diff --git a/drivers/cxl/core/trace.c b/drivers/cxl/core/trace.c
> index 7f2a9dd0d0e3f..df42d119c53dd 100644
> --- a/drivers/cxl/core/trace.c
> +++ b/drivers/cxl/core/trace.c
> @@ -2,7 +2,42 @@
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  
>  #include <cxl.h>
> +#include <cxlmem.h>
>  #include "core.h"
>  
> +const char *cxl_trace_memdev_name(struct cxl_port *port)
> +{
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +
> +		return dev_name(&cxlmd->dev);
> +	}
> +
> +	return "";
> +}
> +
> +const char *cxl_trace_host_name(struct cxl_port *port)
> +{
> +	if (is_cxl_endpoint(port)) {
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
> +
> +		return dev_name(cxlmd->dev.parent);
> +	}
> +
> +	return dev_name(port->uport_dev);
> +}
> +
> +const char *cxl_trace_port_name(struct cxl_port *port)
> +{
> +	return dev_name(&port->dev);
> +}
> +
> +const char *cxl_trace_dport_name(struct cxl_dport *dport)
> +{
> +	if (dport)
> +		return dev_name(dport->dport_dev);
> +	return "";
> +}
> +
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index d37876096dd7c..910aceb2ca3ab 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -48,44 +48,15 @@
>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>  )
>  
> -TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> -	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(dev, status, fe, hl),
> -	TP_STRUCT__entry(
> -		__string(device, dev_name(dev))
> -		__string(host, dev_name(dev->parent))
> -		__field(u32, status)
> -		__field(u32, first_error)
> -		__array(u32, header_log, CXL_HEADERLOG_TRACE_SIZE_U32)
> -	),
> -	TP_fast_assign(
> -		__assign_str(device);
> -		__assign_str(host);
> -		__entry->status = status;
> -		__entry->first_error = fe;
> -		/*
> -		 * Embed headerlog data for user app retrieval and parsing,
> -		 * but no need to print in the trace buffer. Only
> -		 * CXL_HEADERLOG_SIZE_U32 (16) dwords are hardware data;
> -		 * the remaining entries preserve the 512-byte ABI layout
> -		 * rasdaemon depends on and are zero-filled by the caller.
> -		 */
> -		memcpy(__entry->header_log, hl,
> -			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
> -	),
> -	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
> -		  __get_str(device), __get_str(host),
> -		  show_uc_errs(__entry->status),
> -		  show_uc_errs(__entry->first_error)
> -	)
> -);
> -
>  TRACE_EVENT(cxl_aer_uncorrectable_error,
> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
> -	TP_ARGS(cxlmd, status, fe, hl),
> +	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport,
> +		 u32 status, u32 fe, u32 *hl, u64 serial),
> +	TP_ARGS(port, dport, status, fe, hl, serial),
>  	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
> +		__string(memdev, cxl_trace_memdev_name(port))
> +		__string(port, cxl_trace_port_name(port))
> +		__string(dport, cxl_trace_dport_name(dport))
> +		__string(host, cxl_trace_host_name(port))
>  		__field(u64, serial)
>  		__field(u32, status)
>  		__field(u32, first_error)
> @@ -93,8 +64,10 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	),
>  	TP_fast_assign(
>  		__assign_str(memdev);
> +		__assign_str(port);
> +		__assign_str(dport);
>  		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__entry->serial = serial;
>  		__entry->status = status;
>  		__entry->first_error = fe;
>  		/*
> @@ -107,8 +80,9 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  		memcpy(__entry->header_log, hl,
>  			CXL_HEADERLOG_TRACE_SIZE_U32 * sizeof(u32));
>  	),
> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
> -		  __get_str(memdev), __get_str(host), __entry->serial,
> +	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld: status: '%s' first_error: '%s'",
> +		  __get_str(memdev), __get_str(port), __get_str(dport),
> +		  __get_str(host), __entry->serial,
>  		  show_uc_errs(__entry->status),
>  		  show_uc_errs(__entry->first_error)
>  	)
> @@ -132,42 +106,29 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>  )
>  
> -TRACE_EVENT(cxl_port_aer_correctable_error,
> -	TP_PROTO(struct device *dev, u32 status),
> -	TP_ARGS(dev, status),
> -	TP_STRUCT__entry(
> -		__string(device, dev_name(dev))
> -		__string(host, dev_name(dev->parent))
> -		__field(u32, status)
> -	),
> -	TP_fast_assign(
> -		__assign_str(device);
> -		__assign_str(host);
> -		__entry->status = status;
> -	),
> -	TP_printk("device=%s host=%s status='%s'",
> -		  __get_str(device), __get_str(host),
> -		  show_ce_errs(__entry->status)
> -	)
> -);
> -
>  TRACE_EVENT(cxl_aer_correctable_error,
> -	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
> -	TP_ARGS(cxlmd, status),
> +	TP_PROTO(struct cxl_port *port, struct cxl_dport *dport,
> +		 u32 status, u64 serial),
> +	TP_ARGS(port, dport, status, serial),
>  	TP_STRUCT__entry(
> -		__string(memdev, dev_name(&cxlmd->dev))
> -		__string(host, dev_name(cxlmd->dev.parent))
> +		__string(memdev, cxl_trace_memdev_name(port))
> +		__string(port, cxl_trace_port_name(port))
> +		__string(dport, cxl_trace_dport_name(dport))
> +		__string(host, cxl_trace_host_name(port))
>  		__field(u64, serial)
>  		__field(u32, status)
>  	),
>  	TP_fast_assign(
>  		__assign_str(memdev);
> +		__assign_str(port);
> +		__assign_str(dport);
>  		__assign_str(host);
> -		__entry->serial = cxlmd->cxlds->serial;
> +		__entry->serial = serial;
>  		__entry->status = status;
>  	),
> -	TP_printk("memdev=%s host=%s serial=%lld: status: '%s'",
> -		  __get_str(memdev), __get_str(host), __entry->serial,
> +	TP_printk("memdev=%s port=%s dport=%s host=%s serial=%lld: status: '%s'",
> +		  __get_str(memdev), __get_str(port), __get_str(dport),
> +		  __get_str(host), __entry->serial,
>  		  show_ce_errs(__entry->status)
>  	)
>  );
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ed419d0c59f2f..f1ef8b78db18a 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -125,6 +125,13 @@ static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>  #endif
>  
>  struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
> +
> +/* trace-event helpers */
> +const char *cxl_trace_memdev_name(struct cxl_port *port);
> +const char *cxl_trace_host_name(struct cxl_port *port);
> +const char *cxl_trace_port_name(struct cxl_port *port);
> +const char *cxl_trace_dport_name(struct cxl_dport *dport);
> +
>  struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>  					 const struct cxl_memdev_attach *attach);
>  int devm_cxl_sanitize_setup_notifier(struct device *host,


