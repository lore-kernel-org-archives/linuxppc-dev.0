Return-Path: <linuxppc-dev+bounces-24533-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D80C44529
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 20:13:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3sC74hkcz2yWK;
	Tue, 21 Jul 2026 06:13:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784578387;
	cv=none; b=bSnoSKGxIAVsgD6xm/xleEyoXi5puYbreD0XP2vd10dyvdohoxhymFQNVMXsCSDC6y+LttHaLpapK0AK8EBeYovAbqZTYOAua6QngqsO8CgSSi7C6dr5psILFd+V+cavdflmdJqXIhOQ+zyibr16KZY1e2QdLK0qHpDtxSqIr+BG/QTYrapkUi0saNP8efmna3HymSrALDUdR+4HC0A45wBvbKcXX8lK1Sf9fmL8617kQuWxC/KtTQNFkyRhHGxnycA5aTcXNqpX8hx9m/TfpeQu45DikRop7Zf94/N+s1eeWfVOE1WR4xbkzLo/EoFm6JiUDSnmT7L2tSsMeRaTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784578387; c=relaxed/relaxed;
	bh=uvGS591vYLD2w156APqzTDbL2M9gxJDQleq0jpacJp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gT98GpeX4SyfViZgzLk/7kIquOpa0nh7g6azvOYO3uxx8rtwE5d4O5qFSP/WHXWHgeRPTmenXkYTnqrPRYS2U5XgJy8iu9Rmo8ZqRGuitWYwyoKXO2xC89KAEpIv8fmQ8+qF2k73a3OmYCwgAg1au1D4VrymGpUU2ksPq/j+s7znBUW3hjc0zJZsyyFiTagF6rWOGjldI0N6LiJ+CVyFG2MkTYE13L8UqDRQzDghMvDMOwfWHc2OvTqvshzNs4UzFwj5jLBDyVMXf7QkK0ie6Vh2KTLa+o/zshAsaEBG46Bk8rYp7JnRDJ4Ux9uA6luesnne/LV8Cp8J0xKWa2yEEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B76jk9jF; dkim-atps=neutral; spf=pass (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=B76jk9jF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=intel.com (client-ip=192.198.163.18; helo=mgamail.intel.com; envelope-from=dave.jiang@intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3sC62xGlz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:13:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784578387; x=1816114387;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xcAVPct/+9KlKdvAyc/SOsyTjNWB9w0sRxwTOwAnYEs=;
  b=B76jk9jFu/75J4Aj3uaOBQAoODKTSGlqOrWJXHsOk3tnomfjxSo0uXFG
   kkzlQSmYRH+Hkt0y8B+Ft7M31TBpVkjAoD2JhefohomUOyilkOMWG0cvc
   axt5ZiJSe0iigGrc0B6GIodA/H+DWgVUZJAnG3L0aZ5Hj4djtW2aw6YBB
   1S2e9FbESMsHhuqtUVfuyl1HiYuuAJknnI+ZMMvCHEB/OMZ/7aPzrrStv
   2pdUwixKP56jVM97Zq5b45oG9OzQeaZnFxfz7skMF96s8VChvz/j8vnc+
   idGtjdXZTtaZwMvGyfGd+SoynUblowrgtuRCQ/9zd70vmG16VHVm1P9BB
   w==;
X-CSE-ConnectionGUID: 7VvrXuJ5SSiRlgQgvodPWw==
X-CSE-MsgGUID: IZZ5pGZkSM+bGxpXey9KRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="84298653"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="84298653"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:13:03 -0700
X-CSE-ConnectionGUID: eIOvwnw6Qo6qnGLyFscaXg==
X-CSE-MsgGUID: 54+EvrjdRqiaaHZWUh0Pcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="256366066"
Received: from cooperst-gp83.amr.corp.intel.com (HELO [10.125.109.176]) ([10.125.109.176])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 13:13:01 -0700
Message-ID: <e66c4a00-53e4-4f5a-bc07-edd9c92beb96@intel.com>
Date: Mon, 20 Jul 2026 13:12:59 -0700
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
Subject: Re: [PATCH v18 02/13] acpi/apei/ghes: Use raw_spinlock_t for CXL CPER
 work locks
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
 <20260717222706.3540281-3-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260717222706.3540281-3-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/17/26 3:26 PM, Terry Bowman wrote:
> The CXL CPER work registration and unregistration helpers in
> drivers/acpi/apei/ghes.c acquire cxl_cper_work_lock and
> cxl_cper_prot_err_work_lock with guard(spinlock), which leaves local
> interrupts enabled. The corresponding post paths
> (cxl_cper_post_event(), cxl_cper_post_prot_err()) execute in hard IRQ
> context (they are called from the GHES error notification path) and
> acquire the same locks via guard(spinlock_irqsave).
> 
> If a CPU is holding one of these locks via guard(spinlock) when a
> GHES interrupt arrives on the same CPU, the IRQ handler spins on the
> held lock waiting for it to release, while the lock holder is
> preempted by the IRQ. The result is a deadlock.
> 
> Convert both locks from spinlock_t to raw_spinlock_t and use
> guard(raw_spinlock_irqsave) at all call sites. On PREEMPT_RT kernels
> spinlock_t is backed by rt_mutex and sleeping from hard IRQ context is
> not permitted; raw_spinlock_t is safe in both contexts.
> 
> Add WARN_ONCE to both register functions to surface double-registration
> bugs at runtime.
> 
> Restructure both unregister functions to clear the global work pointer
> under the lock before calling cancel_work_sync(), closing the window
> where a CPER interrupt could schedule work on a pointer about to be
> freed. Add kfifo_reset() after cancel_work_sync() so stale entries
> are not replayed on next module load.
> 
> Both kfifos are single-consumer: only one work_struct is registered at
> a time, enforced by the WARN_ONCE guard in the register functions.
> kfifo_reset() is safe outside the lock because cancel_work_sync() has
> already quiesced the consumer, and no new consumer can register until
> the current module exit completes and a fresh module init runs.
> 
> Remove the now-redundant cancel_work_sync() call from
> cxl_pci_driver_exit() - cxl_cper_unregister_work() handles quiescing
> internally.
> 
> Reported-by: Sashiko <sashiko@linuxfoundation.org>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Fixes: 5e4a264bf8b5 ("acpi/ghes: Process CXL Component Events")
> Fixes: 36f257e3b0ba ("acpi/ghes, cxl/pci: Process CXL CPER Protocol Errors")
> Cc: stable@vger.kernel.org

With the minor sashiko issue addressed,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

This can probably be picked up ahead of the series.


> 
> ---
> 
> Changes in v17 -> v18:
> - New patch.
> ---
>  drivers/acpi/apei/ghes.c | 50 ++++++++++++++++++++++++++--------------
>  drivers/cxl/pci.c        |  1 -
>  2 files changed, 33 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 3236a3ce79d6b..ca7a138c1ff2e 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -749,7 +749,7 @@ static DEFINE_KFIFO(cxl_cper_prot_err_fifo, struct cxl_cper_prot_err_work_data,
>  		    CXL_CPER_PROT_ERR_FIFO_DEPTH);
>  
>  /* Synchronize schedule_work() with cxl_cper_prot_err_work changes */
> -static DEFINE_SPINLOCK(cxl_cper_prot_err_work_lock);
> +static DEFINE_RAW_SPINLOCK(cxl_cper_prot_err_work_lock);
>  struct work_struct *cxl_cper_prot_err_work;
>  
>  static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
> @@ -761,7 +761,7 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  	if (cxl_cper_sec_prot_err_valid(prot_err))
>  		return;
>  
> -	guard(spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
> +	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
>  
>  	if (!cxl_cper_prot_err_work)
>  		return;
> @@ -780,10 +780,11 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  
>  int cxl_cper_register_prot_err_work(struct work_struct *work)
>  {
> -	if (cxl_cper_prot_err_work)
> -		return -EINVAL;
> +	guard(raw_spinlock_irqsave)(&cxl_cper_prot_err_work_lock);
>  
> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> +	if (WARN_ONCE(cxl_cper_prot_err_work,
> +		      "CPER-CXL kfifo consumer already registered\n"))
> +		return -EINVAL;
>  	cxl_cper_prot_err_work = work;
>  	return 0;
>  }
> @@ -791,11 +792,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_prot_err_work, "CXL");
>  
>  int cxl_cper_unregister_prot_err_work(struct work_struct *work)
>  {
> -	if (cxl_cper_prot_err_work != work)
> -		return -EINVAL;
> +	scoped_guard(raw_spinlock_irqsave, &cxl_cper_prot_err_work_lock) {
> +		if (WARN_ONCE(cxl_cper_prot_err_work != work,
> +			      "CPER-CXL kfifo consumer mismatch on unregister\n"))
> +			return -EINVAL;
> +		cxl_cper_prot_err_work = NULL;
> +	}
> +
> +	cancel_work_sync(work);
> +
> +	/* Discard stale entries so they are not replayed on next module load */
> +	kfifo_reset(&cxl_cper_prot_err_fifo);
>  
> -	guard(spinlock)(&cxl_cper_prot_err_work_lock);
> -	cxl_cper_prot_err_work = NULL;
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_prot_err_work, "CXL");
> @@ -811,7 +819,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_prot_err_kfifo_get, "CXL");
>  DEFINE_KFIFO(cxl_cper_fifo, struct cxl_cper_work_data, CXL_CPER_FIFO_DEPTH);
>  
>  /* Synchronize schedule_work() with cxl_cper_work changes */
> -static DEFINE_SPINLOCK(cxl_cper_work_lock);
> +static DEFINE_RAW_SPINLOCK(cxl_cper_work_lock);
>  struct work_struct *cxl_cper_work;
>  
>  static void cxl_cper_post_event(enum cxl_event_type event_type,
> @@ -831,7 +839,7 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  		return;
>  	}
>  
> -	guard(spinlock_irqsave)(&cxl_cper_work_lock);
> +	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
>  
>  	if (!cxl_cper_work)
>  		return;
> @@ -849,10 +857,11 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  
>  int cxl_cper_register_work(struct work_struct *work)
>  {
> -	if (cxl_cper_work)
> +	guard(raw_spinlock_irqsave)(&cxl_cper_work_lock);
> +	if (WARN_ONCE(cxl_cper_work,
> +		      "CXL CPER kfifo consumer already registered\n"))
>  		return -EINVAL;
>  
> -	guard(spinlock)(&cxl_cper_work_lock);
>  	cxl_cper_work = work;
>  	return 0;
>  }
> @@ -860,11 +869,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_cper_register_work, "CXL");
>  
>  int cxl_cper_unregister_work(struct work_struct *work)
>  {
> -	if (cxl_cper_work != work)
> -		return -EINVAL;
> +	scoped_guard(raw_spinlock_irqsave, &cxl_cper_work_lock) {
> +		if (WARN_ONCE(cxl_cper_work != work,
> +			      "CXL CPER kfifo consumer mismatch on unregister\n"))
> +			return -EINVAL;
> +		cxl_cper_work = NULL;
> +	}
> +
> +	cancel_work_sync(work);
> +
> +	/* Discard stale entries so they are not replayed on next module load */
> +	kfifo_reset(&cxl_cper_fifo);
>  
> -	guard(spinlock)(&cxl_cper_work_lock);
> -	cxl_cper_work = NULL;
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_work, "CXL");
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 267c679b0b3c2..7c6faee7f85ed 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1083,7 +1083,6 @@ static int __init cxl_pci_driver_init(void)
>  static void __exit cxl_pci_driver_exit(void)
>  {
>  	cxl_cper_unregister_work(&cxl_cper_work);
> -	cancel_work_sync(&cxl_cper_work);
>  	pci_unregister_driver(&cxl_pci_driver);
>  }
>  


