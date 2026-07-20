Return-Path: <linuxppc-dev+bounces-24543-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F18C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 21:41:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3v9Y0nGmz2y8m;
	Tue, 21 Jul 2026 07:41:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784583713;
	cv=none; b=ZZxC4IKLVcYTj16DBjm0xO1at33K7LmdA4cvaaxxSKGoWr0viJ9GJzkqCO94P15U9D3EOdcPuZIQ6X3h99WCs7eEVZVZAiJ6yJkv4Ia2x3KRt8s9s7RMl2cknnig+C3AE+V8aieq6hBj0MpMNkQ3sGMss90pSeSgdOIkueSyZGM+Xz8uLNJDMyln3gkZOFURugUt5mb4bAImklu5Jqg44LzK2HfogLObt8m346sUfv3WwkXNk0ssv8ms0SNbTd57x1rrX4NNRog3JrQAceY/eyMnI6gSGyL4wofxrVz6m92Hpo339TxDfUJ0ZUhZmBSJSFge1/jIdBj0PgzBiyaO6w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784583713; c=relaxed/relaxed;
	bh=fWcUPsyXo4056HmNFVTUlyo9oMkuuiS2NGmShS5RkaI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LifqlI1eLlWAAA90lR8vWsk7D5vFlwrxDg2EPnGZeURSnS+3TM5hBBdxR8hNS4YeA+pA8cqbzamnpl8c0vxEhqn3rflA1YjY5ElrX6QmP6dPN75TAL1cr9XTO+r9XkTKB5MdjtZj+nFc61//vw96UfKiWkt0oUKawcVsFrUQ0XgHx16nnOT4kRMqAkRVUHwUJu1HJWgUQoZ41g+5fHI5LLjjDvqdRZhbd9naU+Ghtjuy+FdX+n9Tumg4jYX8tCmZ85MV1kddN27eIWX6Ll1SPlTHPuhvsiMt2orARudWdIO4mW1QJdebg4WVvBjEI3VjZowzzSsI4AaB36sf5Fk+HQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX1J3mJL; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KX1J3mJL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3v9X1WHFz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 07:41:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B574041635;
	Mon, 20 Jul 2026 21:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7BD1F000E9;
	Mon, 20 Jul 2026 21:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784583709;
	bh=fWcUPsyXo4056HmNFVTUlyo9oMkuuiS2NGmShS5RkaI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KX1J3mJLKUHxixPMFae2NTST8vElssz3kdmKwuW653uSDbNmkZV7VYpXksozBEHHG
	 GDaxKNLxKcbaK0IJXYOEV8yLfyAaqF+tUV1PRCJJPcs4R2l7xhc9Gte9D4x8PvHDm/
	 f5a3iTSpCGeKxrva+Y679wtus9e7fLRTjFZOEW1DGVHf+Er3MvdR7kyKt9mhF4U24J
	 edBJfVJKFPqcBRViqVyhuNoHXEXcL/iK9mam9tkJfS1+q5kbvo59rYCeajWhYPY4hM
	 NYR8aOoNeYsFQ00fhKorhAjVlDn/xUAWNfzCpLNRY9TlozIigBgekeYlkw1av8rq7y
	 wga4tRDjY8mJA==
Date: Mon, 20 Jul 2026 22:41:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Terry Bowman <terry.bowman@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <djbw@kernel.org>,
 "Dave Jiang" <dave.jiang@intel.com>, Ira Weiny <iweiny@kernel.org>, Len
 Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Robert
 Richter <rrichter@amd.com>, <linux-acpi@vger.kernel.org>,
 <linux-cxl@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "Alejandro Lucero" <alucerop@amd.com>,
 Alison Schofield <alison.schofield@intel.com>, Ankit Agrawal
 <ankita@nvidia.com>, Ard Biesheuvel <ardb@kernel.org>, "Ben Cheatham"
 <Benjamin.Cheatham@amd.com>, Borislav Petkov <bp@alien8.de>, "Breno Leitao"
 <leitao@debian.org>, Davidlohr Bueso <dave@stgolabs.net>, "Fabio M . De
 Francesco" <fabio.m.de.francesco@linux.intel.com>, Gregory Price
 <gourry@gourry.net>, Hanjun Guo <guohanjun@huawei.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Kuppuswamy Sathyanarayanan
 <sathyanarayanan.kuppuswamy@linux.intel.com>, Li Ming
 <ming.li@zohomail.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Oliver O'Halloran <oohall@gmail.com>,
 Shiju Jose <shiju.jose@huawei.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuai Xue <xueshuai@linux.alibaba.com>, Smita Koralahalli
 <Smita.KoralahalliChannabasappa@amd.com>, Tony Luck <tony.luck@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH v18 02/13] acpi/apei/ghes: Use raw_spinlock_t for CXL
 CPER work locks
Message-ID: <20260720224140.4e592134@jic23-huawei>
In-Reply-To: <20260717222706.3540281-3-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-3-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 17:26:55 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

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

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

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


