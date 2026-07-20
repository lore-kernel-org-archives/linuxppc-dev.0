Return-Path: <linuxppc-dev+bounces-24534-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FB2C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 20:15:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3sFb4MXxz2yYd;
	Tue, 21 Jul 2026 06:15:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784578515;
	cv=none; b=iOmYZ+FWS6YkpKc/QsGWxjaEwb8JD66ysGBAbtwYT9fp8yJxwKxBYukbb27KgDyLESP/JF0N/Ak0yWkqfarRRIif13VgMC6GMF6itHUjHrys/S8F9NBFhgKqD4KZjxKnzawvEj1rBrDAT6ntNVLsjVB8E22EGweH8wYTqIgcQGW2jGgZjWAnJoL2ZVdBZSd6w3qEgdZGkJnVPg3UTMQw9woqsw7W9KuM2ZUwSHsUtxf3FXugj3BwzJBggRcIEN5YYbHTcVNas07TkvNVlwFH6Yo6xPfpbJNJ0o+4Y37hZkbQIMB9rrsPlo/HuoDJiq850g4kOTxKB8KS2Rbnip7RdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784578515; c=relaxed/relaxed;
	bh=WH4V8M79ivcjU0nV0nad/BU+q/jDciqRKgjq1bsg6oA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2pzU+a30m11BL6TIaR6y4Y81ocTBpeeUkMB5jqA1ruhkkDvx+ApaCYYgzxmE4/8sG4yOK9ARRtEpJ7BUTDa/hBq+hBGElaAQJgvyvg5npJIS6Ne4r7QrzDrI3RCbMJak9z8YqZPS474e/EqjIWSUhAao4KJsm4mJVCY7kdkTyH9ve2yGfB1HieWCz4aUd8Wh4xYdUpXh7tcC5tf7Ea4c+bdQImZK4GnBWiWKV8Iw1sl39lneTipeN50hz1sRiSkVT65VH+XRLliN73muK2/8YeZDKpfyWFWFly93DMd/zZg7aT3m1iSgYU8VxS0T9KtTZKGR/vT4fOA8lAuqb5zwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bjvX2Tft; dkim-atps=neutral; spf=pass (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bjvX2Tft;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3sFZ1jPpz2yYK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:15:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784578514; x=1816114514;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0hnK/Ai0roATsG/MvaT7ATrdhaK8EcCQmK3Am/WHN2U=;
  b=bjvX2TftqdNEsIgtl2GhfOXsOc9XQ7tN7ptDSiMo0YSMuGIHAz29/l5H
   l1a2wFRGzrPHLdAHo/Sa24QiLFlqvN41eD1A/fnf71wFmEibgJeqy0XTu
   Ltizo0l0l5oW2MS+8KZVEpLB85xxTIYCaUgppaOgHHkQtsQ//qxIUA6LU
   XOSqgkXgxbtmENV1hJBlmCiaAt+ITTRbWQpvNJYYCDWBwqeuYWRAmwpj3
   Bvgjdz5CMcfmnfS6xT9Z7UO7SFMTeXdQYTQpUYHwV9s8BHCXWCVjglf4Q
   cdEDK1ktsH0t05pXPlWAX6zyC6QGO9P7QjaSHdFOuRyHlAmMONcJYWpF2
   g==;
X-CSE-ConnectionGUID: 1BEEKVlxTm6wiRwq02AXlw==
X-CSE-MsgGUID: 0CHylXCxQUqyQN1Ijgw6SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="88992794"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="88992794"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:15:10 -0700
X-CSE-ConnectionGUID: Qd7z6zTPTjCBz5TYtir27A==
X-CSE-MsgGUID: sc+seRlZR8KZbstpZyQcyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="259547795"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:15:07 -0700
Message-ID: <424b2409-fee7-44f5-bfe9-b67b22facb9b@intel.com>
Date: Mon, 20 Jul 2026 13:15:06 -0700
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
Subject: Re: [PATCH v18 03/13] cxl: Tighten CPER kfifo registration API and
 symbol visibility
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
 <20260717222706.3540281-4-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-4-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:26 PM, Terry Bowman wrote:
> From: Dan Williams <djbw@kernel.org>
> 
> Tighten the CPER protocol error kfifo registration API and symbol
> visibility.
> 
> Use EXPORT_SYMBOL_FOR_MODULES() instead of EXPORT_SYMBOL_NS_GPL() for
> the CPER kfifo registration symbols. This names the consuming module
> explicitly and gives compile-time enforcement.
> 
> Drop the work_struct argument from the unregister path. Change the
> WARN_ONCE condition to a NULL check since there is no caller pointer
> to compare against anymore.
> 
> Change register/unregister return types to void. Flag double registration
> with WARN_ONCE() inside the lock instead of returning an error.
> 
> Change cxl_ras_init() to void because there is one consumer and one producer
> so the error return was unnecessary. Remove the now-dead error check in
> cxl_core_init().
> 
> Add a diagnostic log when the driver is not bound in
> cxl_cper_handle_prot_err().
> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> 
> Changes in v17 -> v18:
> - New patch.
> ---
>  drivers/acpi/apei/ghes.c | 32 +++++++++++++++-----------------
>  drivers/cxl/core/core.h  |  7 ++-----
>  drivers/cxl/core/port.c  |  6 +-----
>  drivers/cxl/core/ras.c   | 12 +++++++-----
>  include/cxl/event.h      | 17 ++++++-----------
>  5 files changed, 31 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index ca7a138c1ff2e..187f54e31c33e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -778,41 +778,41 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  #endif
>  }
>  
> -int cxl_cper_register_prot_err_work(struct work_struct *work)
> +void cxl_cper_register_prot_err_work(struct work_struct *work)
>  {
>  	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
>  
>  	if (WARN_ONCE(cxl_cper_prot_err_work,
>  		      "CPER-CXL kfifo consumer already registered\n"))
> -		return -EINVAL;
> +		return;
>  	cxl_cper_prot_err_work = work;
> -	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
> +EXPORT_SYMBOL_FOR_MODULES(cxl_cper_register_prot_err_work, "cxl_core");
>  
> -int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> +void cxl_cper_unregister_prot_err_work(void)
>  {
> +	struct work_struct *old;
> +
>  	scoped_guard(raw_spinlock_irqsave, &cxl_cper_prot_err_work_lock) {
> -		if (WARN_ONCE(cxl_cper_prot_err_work != work,
> -			      "CPER-CXL kfifo consumer mismatch on unregister\n"))
> -			return -EINVAL;
> +		WARN_ONCE(!cxl_cper_prot_err_work,
> +			  "CPER-CXL kfifo consumer not registered on unregister\n");
> +		old = cxl_cper_prot_err_work;
>  		cxl_cper_prot_err_work = NULL;
>  	}
>  
> -	cancel_work_sync(work);
> +	if (old)
> +		cancel_work_sync(old);
>  
>  	/* Discard stale entries so they are not replayed on next module load */
>  	kfifo_reset(&cxl_cper_prot_err_fifo);
> -
> -	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
> +EXPORT_SYMBOL_FOR_MODULES(cxl_cper_unregister_prot_err_work, "cxl_core");
>  
>  int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
>  {
>  	return kfifo_get(&cxl_cper_prot_err_fifo, wd);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
> +EXPORT_SYMBOL_FOR_MODULES(cxl_cper_prot_err_kfifo_get, "cxl_core");
>  
>  /* Room for 8 entries for each of the 4 event log queues */
>  #define CXL_CPER_FIFO_DEPTH 32
> @@ -867,12 +867,12 @@ int cxl_cper_register_work(struct work_struct *work)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
>  
> -int cxl_cper_unregister_work(struct work_struct *work)
> +void cxl_cper_unregister_work(struct work_struct *work)
>  {
>  	scoped_guard(raw_spinlock_irqsave, &cxl_cper_work_lock) {
>  		if (WARN_ONCE(cxl_cper_work != work,
>  			      "CXL CPER kfifo consumer mismatch on unregister\n"))
> -			return -EINVAL;
> +			return;
>  		cxl_cper_work = NULL;
>  	}
>  
> @@ -880,8 +880,6 @@ int cxl_cper_unregister_work(struct work_struct *work)
>  
>  	/* Discard stale entries so they are not replayed on next module load */
>  	kfifo_reset(&cxl_cper_fifo);
> -
> -	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
>  
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 07555ae638594..23fe40ddf4c6b 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -183,7 +183,7 @@ static inline struct device *dport_to_host(struct cxl_dport *dport)
>  	return &port->dev;
>  }
>  #ifdef CONFIG_CXL_RAS
> -int cxl_ras_init(void);
> +void cxl_ras_init(void);
>  void cxl_ras_exit(void);
>  bool cxl_handle_ras(struct device *dev, void __iomem *ras_base);
>  void cxl_handle_cor_ras(struct device *dev, void __iomem *ras_base);
> @@ -192,10 +192,7 @@ void cxl_disable_rch_root_ints(struct cxl_dport *dport);
>  void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
>  void devm_cxl_dport_ras_setup(struct cxl_dport *dport);
>  #else
> -static inline int cxl_ras_init(void)
> -{
> -	return 0;
> -}
> +static inline void cxl_ras_init(void) { }
>  static inline void cxl_ras_exit(void) { }
>  static inline bool cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  {
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1215ee4f40351..f90f899c31d07 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2531,14 +2531,10 @@ static __init int cxl_core_init(void)
>  	if (rc)
>  		goto err_region;
>  
> -	rc = cxl_ras_init();
> -	if (rc)
> -		goto err_ras;
> +	cxl_ras_init();
>  
>  	return 0;
>  
> -err_ras:
> -	cxl_region_exit();
>  err_region:
>  	bus_unregister(&cxl_bus_type);
>  err_bus:
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 99fb00949c2fa..135f1997e6f4f 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -104,8 +104,11 @@ void cxl_cper_handle_prot_err(struct cxl_cper_prot_err_work_data *data)
>  	}
>  
>  	guard(device)(&pdev->dev);
> -	if (!pdev->dev.driver)
> +	if (!pdev->dev.driver) {
> +		dev_warn_ratelimited(&pdev->dev,
> +				     "Device is unbound, abort CPER error handling\n");
>  		return;
> +	}
>  
>  	struct device *mem_dev __free(put_device) = bus_find_device(
>  		&cxl_bus_type, NULL, pdev, match_memdev_by_parent);
> @@ -129,15 +132,14 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>  }
>  static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  
> -int cxl_ras_init(void)
> +void cxl_ras_init(void)
>  {
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
>  }
>  
>  void cxl_ras_exit(void)
>  {
> -	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
> -	cancel_work_sync(&cxl_cper_prot_err_work);
> +	cxl_cper_unregister_prot_err_work();
>  }
>  
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index ff97fea718d2c..3471d4f75c025 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -287,10 +287,10 @@ struct cxl_cper_prot_err_work_data {
>  
>  #ifdef CONFIG_ACPI_APEI_GHES
>  int cxl_cper_register_work(struct work_struct *work);
> -int cxl_cper_unregister_work(struct work_struct *work);
> +void cxl_cper_unregister_work(struct work_struct *work);
>  int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd);
> -int cxl_cper_register_prot_err_work(struct work_struct *work);
> -int cxl_cper_unregister_prot_err_work(struct work_struct *work);
> +void cxl_cper_register_prot_err_work(struct work_struct *work);
> +void cxl_cper_unregister_prot_err_work(void);
>  int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd);
>  #else
>  static inline int cxl_cper_register_work(struct work_struct *work)
> @@ -298,21 +298,16 @@ static inline int cxl_cper_register_work(struct work_struct *work)
>  	return 0;
>  }
>  
> -static inline int cxl_cper_unregister_work(struct work_struct *work)
> -{
> -	return 0;
> -}
> +static inline void cxl_cper_unregister_work(struct work_struct *work) { }
>  static inline int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
>  {
>  	return 0;
>  }
> -static inline int cxl_cper_register_prot_err_work(struct work_struct *work)
> +static inline void cxl_cper_register_prot_err_work(struct work_struct *work)
>  {
> -	return 0;
>  }
> -static inline int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> +static inline void cxl_cper_unregister_prot_err_work(void)
>  {
> -	return 0;
>  }
>  static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
>  {


