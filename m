Return-Path: <linuxppc-dev+bounces-24549-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BA2C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 22:25:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3w8K1F25z2xLg;
	Tue, 21 Jul 2026 08:25:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784586353;
	cv=none; b=T0YX5qG5ryNrAzv2IfZM6wQ9XmN02t/lR8vR+tVw6vFL1qWS8yz//ZlwAFSo+Bhy34VdCSEZdSb6Mfciq403JdxVixDztHXZCihMQub6X5GMOCalsA1saRBrkgwSrAI/icQDNPl1+VnetdL725jl9uV2AcDH4JxOE2zSxNI/FKtvSguBFxJvf4jqg+YX0BezFirHQxZO7uGdiyZGXna4IbTqdRbDVldUSDH5WTYcBmqnBkWzGNsN+9ZZ/oedtz/LtBKRkG/nz0SNwk3SXxQMabD3fJFIHwzVlMKHIG8QKyEtHucVMuaqgaBP8nhlJWvsRKkWMncR95cVKCv6o/uUdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784586353; c=relaxed/relaxed;
	bh=IWT7sQbDCR4XLXeKp4NYDqpAhz9/ASiFjxzmoi2BPCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aSWgd7YH5Ee/hYdF4m9okgo5Rc7RSMJxctfroJRdiPi3+gdKwutmrq5sXTMxIM6xymfsOB6VTrYY7bi6t8ZB2PIzIkLbIJOufAGz+414Ia3TgjGMwSwgS2x13GJ9UamD+/yOIu+C34YB4JRB29qBLWtMpJdk/KHKua0kQ+8+3nspW29/HEzkdsJVtiYWuSmRFYcJ+8/Mi3hD5pzO4omGw1eE9Y6hRD7sAlMnVhvinN0UaF1SUxxQWV+vCUdwvw6Ea7KdZCIzIwYrJ1T/4qwhmE9gQq+2dpVBflyK1o01OsjrM9H7jbOPrRI+hzpW6ecI4wW0EmESWNl9V0QZKR3/8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cQyPpV/+; dkim-atps=neutral; spf=pass (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cQyPpV/+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.9; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3w8H2GCbz2xJR
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 08:25:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784586351; x=1816122351;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aQaapGffcvOYYZ1UrRA2bMN8GdVvJwcDNLSYCZzmY6A=;
  b=cQyPpV/+upQFpuv3kdFzg22O7ww//uIitpszs0p1rolXX/+EEpLOoqdx
   XveBxxQWGWb3ozAl4ARss6lIqGIQgfbwjQVTc0ddhKJL8bku/ss+LodCl
   aihU+O5aM6ZluA8/UCaHpzVf8JUGSDPO/Ci7w0VlFHULwEA7gI9bnWkt8
   8DS4SZr5nF7QAedHNVlHryDCeeuuctVsaLbng01of5FpfyfQCUfdzoJhI
   Y0XNCApGr89V6kaXxSv3j49bjcUs4hgKTUjbtwMjrkcEIgf+m1ccJsUde
   V8s7W+fMJVPgS7uX2Th+Kf99AqwekEpg9cxwe0RqWCZtyD0ZpuUotQZix
   w==;
X-CSE-ConnectionGUID: OhKpYdDgQNuthqHnBkYTzg==
X-CSE-MsgGUID: wmOYRVMYR5uW2WMaW8H1MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95830210"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="95830210"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:25:35 -0700
X-CSE-ConnectionGUID: NJlKNz+DSYC/FokOqWlk9g==
X-CSE-MsgGUID: eAHOkX6dS0iYqnFwKRU9Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="255803396"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 15:25:33 -0700
Message-ID: <aa1831f8-8808-4f41-a3d7-da511fe60ce9@intel.com>
Date: Mon, 20 Jul 2026 15:25:31 -0700
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
Subject: Re: [PATCH v18 09/13] cxl: Update CXL Endpoint AER handler
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
 <20260717222706.3540281-10-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:27 PM, Terry Bowman wrote:
> Rename cxl_error_detected() to cxl_pci_error_detected() and rename
> the struct pci_error_handlers instance to cxl_pci_error_handlers to
> avoid shadowing the struct type tag.
> 
> Document the unconditional CXL RAS read policy: on a dead link,
> readl() returns 0xFFFFFFFF which is interpreted as UCE bits set and
> triggers a panic. If RAS registers are not mapped the read is
> skipped and the frozen/perm_failure switch cases defer to AER
> recovery for devices without active CXL.mem traffic.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> 
> Changes in v17->v18:
> - Fix cxl_pci_error_detected() to use find_cxl_port_by_uport() and port->uport_dev
> - Read CXL RAS unconditionally; panic on UCE regardless of channel state
> - Document unconditional read policy and 0xFFFFFFFF behavior in comment
> - Drop guard removal paragraph from commit message (not in this diff)
> - Drop Reviewed-by tags pending re-review after message change
> 
> Changes in v16->v17:
> - Rename pci_error_handlers struct instance to cxl_pci_error_handlers to
>   avoid shadowing the struct type tag.
> - Restore scoped_guard(device) and dev->driver check around AER read.
> - NULL-check find_cxl_port_by_dev() before deref of port->uport_dev.
> - Updated commit message. (Terry)
> - Add scope cleanup for port variable in cxl_pci_error_detected() (Terry)
> - Drop cxl_uncor_aer_present(), rely on AER state
> 
> Changes in v15->v16:
> - Update commit message (DaveJ)
> - s/cxl_handle_aer()/cxl_uncor_aer_present()/g (Jonathan)
> - cxl_uncor_aer_present(): Leave original result calculation based on
>   if a UCE is present and the provided state (Terry)
> - Add call to pci_print_aer(). AER fails to log because is upstream
>   link (Terry)
> 
> Changes in v14->v15:
> - Update commit message and title. Added Bjorn's ack.
> - Move CE and UCE handling logic here
> 
> Changes in v13->v14:
> - Add Dave Jiang's review-by
> - Update commit message & headline (Bjorn)
> - Refactor cxl_port_error_detected()/cxl_port_cor_error_detected() to
>   one line (Jonathan)
> - Remove cxl_walk_port() (Dan)
> - Remove cxl_pci_drv_bound(). Check for 'is_cxl' parent port is
>   sufficient (Dan)
> - Remove device_lock_if()
> - Combined CE and UCE here (Terry)
> 
> Changes in v12->v13:
> - Move get_pci_cxl_host_dev() and cxl_handle_proto_error() to Dequeue
>   patch (Terry)
> - Remove EP case in cxl_get_ras_base(), not used. (Terry)
> - Remove check for dport->dport_dev (Dave)
> - Remove whitespace (Terry)
> 
> Changes in v11->v12:
> - Add call to cxl_pci_drv_bound() in cxl_handle_proto_error() and
>   pci_to_cxl_dev()
> - Change cxl_error_detected() -> cxl_cor_error_detected()
> - Remove NULL variable assignments
> - Replace bus_find_device() with find_cxl_port_by_uport() for upstream
>   port searches.
> 
> Changes in v10->v11:
> - None
> ---
>  drivers/cxl/core/ras.c | 24 +++++++++++++++---------
>  drivers/cxl/cxlpci.h   |  8 ++++----
>  drivers/cxl/pci.c      | 12 ++++++------
>  3 files changed, 25 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 6f4a3c1b0bb85..d5dc2c22565da 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -328,10 +328,8 @@ bool cxl_handle_ras(struct cxl_port *port, struct cxl_dport *dport, void __iomem
>  	return true;
>  }
>  
> -
> -
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t state)
>  {
>  	struct cxl_port *port __free(put_cxl_port) = find_cxl_port_by_uport(&pdev->dev);
>  	bool ue = false;
> @@ -349,10 +347,18 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		}
>  
>  		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> +		 * The CXL RAS read is unconditional regardless of channel
> +		 * state.  Any uncorrectable error bit set in the CXL RAS
> +		 * status register triggers a panic because CXL.mem cache
> +		 * coherency is already lost; continuing risks silent data
> +		 * corruption across interleaved HDM regions.
> +		 *
> +		 * On a dead link readl() returns 0xFFFFFFFF which sets all
> +		 * UCE bits and also triggers the panic - this is intentional.
> +		 * If RAS registers are not mapped the read is skipped, the
> +		 * panic is not reached, and the frozen/perm_failure switch
> +		 * cases below handle AER recovery for devices without active
> +		 * CXL.mem traffic.
>  		 */
>  		ue = cxl_handle_ras(port, NULL, to_ras_base(port, NULL));
>  	}
> @@ -380,7 +386,7 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	}
>  	return PCI_ERS_RESULT_NEED_RESET;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_error_detected, "CXL");
>  
>  static void cxl_handle_proto_error(struct pci_dev *pdev, struct cxl_port *port,
>  				   struct cxl_dport *dport, int severity)
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 06c46adcf0f6c..8aeb80a4e5732 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -89,13 +89,13 @@ struct cxl_dev_state;
>  void read_cdat_data(struct cxl_port *port);
>  
>  #ifdef CONFIG_CXL_RAS
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state);
> +pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +					pci_channel_state_t state);
>  void devm_cxl_dport_rch_ras_setup(struct cxl_dport *dport);
>  void devm_cxl_port_ras_setup(struct cxl_port *port);
>  #else
> -static inline pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -						  pci_channel_state_t state)
> +static inline pci_ers_result_t cxl_pci_error_detected(struct pci_dev *pdev,
> +						      pci_channel_state_t state)
>  {
>  	return PCI_ERS_RESULT_NONE;
>  }
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 5c21db36073fe..6cf1db7b85020 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1000,18 +1000,18 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	}
>  }
>  
> -static const struct pci_error_handlers cxl_error_handlers = {
> -	.error_detected	= cxl_error_detected,
> -	.slot_reset	= cxl_slot_reset,
> -	.resume		= cxl_error_resume,
> -	.reset_done	= cxl_reset_done,
> +static const struct pci_error_handlers cxl_pci_error_handlers = {
> +	.error_detected		= cxl_pci_error_detected,
> +	.slot_reset		= cxl_slot_reset,
> +	.resume			= cxl_error_resume,
> +	.reset_done		= cxl_reset_done,
>  };
>  
>  static struct pci_driver cxl_pci_driver = {
>  	.name			= KBUILD_MODNAME,
>  	.id_table		= cxl_mem_pci_tbl,
>  	.probe			= cxl_pci_probe,
> -	.err_handler		= &cxl_error_handlers,
> +	.err_handler		= &cxl_pci_error_handlers,
>  	.dev_groups		= cxl_rcd_groups,
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,


