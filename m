Return-Path: <linuxppc-dev+bounces-24545-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F6EC44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 21:59:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3vZM4rrbz2yLY;
	Tue, 21 Jul 2026 07:59:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784584795;
	cv=none; b=I48jI3JvHfxy9IXHmrmdf41HMsosDWzGnLGkp08aBxfhkUiCE3tc0yBH/D3Evc8wqoIOfFjoOV8A9FL7P1Zc9X0x/C8Wc1sn4bLBEZMiY3XMS9LGxJIgFTHg40g7KkwuYYnJW/P2VPBSG5Rh2G2nQyI/ZavJt3Cbynui9yNgwYlAUQFUuXP/y6OnSlTYzakTraGktkjXmLbFwEc4p9s0B+DkrkRaMT5HUVgCYua+qEe8H3zTzOMn3txGu3ZH2zI173z9FKF9JqjQHyMQxafZaFMQrF/J4tq1rEgVV6Niwt3LvGWwmcMHQ4X+mOA4mr8PjeYZWIr2wmGkDR180RGHpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784584795; c=relaxed/relaxed;
	bh=a6WrH1AIy+EK4Fw2+FOXO+vq75HdWci5vwL+qT5Ta4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9KWTFfaqw2OBYARByGnQ50ihh0opw0ZJWQjoKK4sedASET5WcCvzziWt47S40DoAbWeqEg9ITfpZ1T6RL+mkRZ5lTlrjBNeXQFssFCbuJ5I80pvOMxex9xKz07SRw0vbA0574klvdgIIQ25ENfUOxy3srG3g/Pr3K3Vkf04dmiJEha5w4tgvd/X6PTGGIC0VwllqRkueNbAn/x3Rjv3nnIVky/W0vRQGDsBG/za+yNPcn8D989Akxw+5+Do2nUavUbZfUoKph0o/rPLzAjt1cb+jGFLFMDF4M3SeXe8yaUG/AxCDUP/Ij8+URQGMBQsyijUhYIaGKaER83IC1qrxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HovYPW6f; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HovYPW6f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jic23@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3vZL5T9Jz2y8m
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 07:59:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 67B6B42B94;
	Mon, 20 Jul 2026 21:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54BDE1F000E9;
	Mon, 20 Jul 2026 21:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784584792;
	bh=a6WrH1AIy+EK4Fw2+FOXO+vq75HdWci5vwL+qT5Ta4Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HovYPW6fiGWU66tFqNtu10vR52vWnoSaRI54L1LrC4I0aVd0QRg+vUmQ6KiDtwjvZ
	 TO0PAWlZsD7CMYmkyByMojv4kkBywjFyKfnIFf6XjlHTQL3slD56ml8qapzjClmrYB
	 YzG2nKCgab0hIvV9d/PMc1TW867aJRarEZvrWwC5lFJzXZ7JxejAoRn+vBYRzT70lW
	 9OegIrsEsQVmSHl/qYhSIrqpBfs0u9tKN4DQsAHY/BpMukSI5G59QOS13hx3b8KcvK
	 buuADXN5TGdAsb0lWmfcBDqebyBB+EegeKhn8uQTzYZNR/Uox5nVmN9jCI2nimSKmQ
	 kfmWnzUy9zPQg==
Date: Mon, 20 Jul 2026 22:59:43 +0100
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
Subject: Re: [PATCH v18 03/13] cxl: Tighten CPER kfifo registration API and
 symbol visibility
Message-ID: <20260720225943.0415d43c@jic23-huawei>
In-Reply-To: <20260717222706.3540281-4-terry.bowman@amd.com>
References: <20260717222706.3540281-1-terry.bowman@amd.com>
	<20260717222706.3540281-4-terry.bowman@amd.com>
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

On Fri, 17 Jul 2026 17:26:56 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Dan Williams <djbw@kernel.org>
> 
Hi Terry, Dan,

There are a few different things in here. Having them all together
may make it a little harder to keep track of the different changes.

> Tighten the CPER protocol error kfifo registration API and symbol
> visibility.
> 
> Use EXPORT_SYMBOL_FOR_MODULES() instead of EXPORT_SYMBOL_NS_GPL() for
> the CPER kfifo registration symbols. This names the consuming module
> explicitly and gives compile-time enforcement.
To me this is one patch.
> 
> Drop the work_struct argument from the unregister path. Change the
> WARN_ONCE condition to a NULL check since there is no caller pointer
> to compare against anymore.

This is one.

> 
> Change register/unregister return types to void. Flag double registration
> with WARN_ONCE() inside the lock instead of returning an error.
Another change.

That covers why for the register, for unregister maybe mention it was
unchecked anyway.

> 
> Change cxl_ras_init() to void because there is one consumer and one producer
> so the error return was unnecessary. Remove the now-dead error check in
> cxl_core_init().
This is change

> 
> Add a diagnostic log when the driver is not bound in
> cxl_cper_handle_prot_err().
Unrelated really to all the rest. 

All nice changes and maybe a few of them can be combined but to me this
is too many in one.  Anyhow I might be letting perfect be enemy of
good and all that so if others think it should go in as one then
I'm fine with that.

Trivial thing inline todo with formatting consistency.

> 
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>
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
> diff --git a/include/cxl/event.h b/include/cxl/event.h
> index ff97fea718d2c..3471d4f75c025 100644
> --- a/include/cxl/event.h
> +++ b/include/cxl/event.h
> @@ -287,10 +287,10 @@ struct cxl_cper_prot_err_work_data {

> -static inline int cxl_cper_register_prot_err_work(struct work_struct *work)
> +static inline void cxl_cper_register_prot_err_work(struct work_struct *work)
>  {
> -	return 0;
>  }

I'd go a bit long and move { } up.  Compact stubs are always nice!


> -static inline int cxl_cper_unregister_prot_err_work(struct work_struct *work)
> +static inline void cxl_cper_unregister_prot_err_work(void)

This one is shorter than the one you did it for above!

>  {
> -	return 0;
>  }
>  static inline int cxl_cper_prot_err_kfifo_get(struct cxl_cper_prot_err_work_data *wd)
>  {


