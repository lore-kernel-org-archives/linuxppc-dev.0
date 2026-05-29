Return-Path: <linuxppc-dev+bounces-21694-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A99DCD6E49
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 08:30:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc4M2dcCz2xnZ;
	Fri, 29 May 2026 18:30:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780043427;
	cv=none; b=GMQ0CwaZ0sQvUFpSKQIZPKprC2plc9DYZ1c1GyYCUydoVJkPO6uJPxFF8z9JLdJxlGOgN63Tg8gioTekUjY31HJf2JpD8CzXuuJ5xbAusaeKxHBwo2v0BiClv5at4pY3kgjeuaDwlj/jmEb+icuIkmaehyWuuwQUTqPXBO1ARRWdO6E0EKaj8+BA5Z7QuONNIVhtsRx6wqgbGs6mq6lABqfmVfgvfBgYYURQ7qtYxjbYDlo1K5v0S5k++creNmk4Z+YAn4R4jCfhTQ49rmtmkI9glw1Dq5WywAJavRZE5Ae+KoyBECDCsMqop8giZqBAwA7HTvs8fRIyp1rHBst/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780043427; c=relaxed/relaxed;
	bh=EQVon7otOC8tUidq6mZ66TIYmxH1F3ZWevqgSsL0xBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+mf0Y3NCQMHj6s8sEH0nftuEuisrtFrY3t/26hzCf12fSr5LBSklKnkjpTHYEExZ6Veo6MPvFa56K9PZ+BAwFaYWoByiQxUbdCVdDN5KGvmD/32LxAzUyabZpi/MwgHviVvOUwHbuUtecJmBAgVKDQEEZu1lAFDWRA5QCL3g+E9csw0RDMaX17FAvdt4Ts9cJQYZz5bX3E9Npq5NUkTVsLSa2c3VqHyXpy5ID7l4Hz3VCvxusYhCeAR73dzCsB/53B0ZLO1nuS2iMCvGMQ0lklZqADSdNjMdT3EvFvB8CXvxQ9qRmbzgruq9ovAyXwi2YTC4MXRZ8e3gtz27qUKqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lsoxhOxi; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lsoxhOxi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc4L3Nqnz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 18:30:26 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4B8632E5;
	Fri, 29 May 2026 01:29:49 -0700 (PDT)
Received: from [10.57.91.162] (unknown [10.57.91.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6892D3F632;
	Fri, 29 May 2026 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780043394; bh=LpGrRJmNWPcHaRlBV5w3lZl9XAW9wUfZkoWTWBy1nFU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lsoxhOxibEyJ5lHCGdr76YlKUY9UPjWMsbTlSjV42xLs3UC50ylcZ0jNiRAuX0LGv
	 ROtFFBK8bd+Dt4HWaxYhwBs7wmthKtbXrEd5RFcjHrtddOa2uIt79pP/Ld+WjmS07W
	 9VlU1fIqvgS6mSD3ptke3Hza5XxLJoHl2kJtRHTA=
Message-ID: <22042b98-cfcc-428e-bb08-ebcfe785eb69@arm.com>
Date: Fri, 29 May 2026 10:29:47 +0200
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
Subject: Re: [PATCH v6 15/15] arm64: mm: Unmap kernel data/bss entirely from
 the linear map
To: Ard Biesheuvel <ardb+git@google.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, will@kernel.org, catalin.marinas@arm.com,
 mark.rutland@arm.com, Ard Biesheuvel <ardb@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Liz Prucka <lizprucka@google.com>, Seth Jenkins <sethjenkins@google.com>,
 Kees Cook <kees@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-hardening@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org
References: <20260526175846.2694125-17-ardb+git@google.com>
 <20260526175846.2694125-32-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260526175846.2694125-32-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2026 19:59, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The linear aliases of the kernel text and rodata are mapped read-only in
> the linear map as well. Given that the contents of these regions are
> mostly identical to the version in the loadable image, mapping them
> read-only and leaving their contents visible is a reasonable hardening
> measure.
>
> Data and bss, however, are now also mapped read-only but the contents of
> these regions are more likely to contain data that we'd rather not leak.
> So let's unmap these entirely in the linear map when the kernel is
> running normally.
>
> When going into hibernation or waking up from it, these regions need to
> be mapped, so map the region initially, and toggle the valid bit so
> map/unmap the region as needed. (While the hibernation snapshot logic
> seems able to map inaccessible pages as needed, it currently disregards
> non-present pages entirely.)

I'm not sure I understand this, is there something wrong with the
kernel_page_present() check in safe_copy_page()?

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/mmu.c | 39 +++++++++++++++++---
>  1 file changed, 34 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index e7ca53d20b87..cb00e42abbe1 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -24,6 +24,7 @@
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
> +#include <linux/suspend.h>
>  #include <linux/kfence.h>
>  #include <linux/pkeys.h>
>  #include <linux/mm_inline.h>
> @@ -1056,6 +1057,29 @@ static void __init __map_memblock(phys_addr_t start, phys_addr_t end,
>  				 end - start, prot, early_pgtable_alloc, flags);
>  }
>  
> +static void remap_linear_data_alias(bool unmap)
> +{
> +	set_memory_valid((unsigned long)lm_alias(__init_end),
> +			 (unsigned long)(__bss_stop - __init_end) / PAGE_SIZE,
> +			 !unmap);
> +}
> +
> +static int arm64_hibernate_pm_notify(struct notifier_block *nb,
> +				     unsigned long mode, void *unused)
> +{
> +	switch (mode) {
> +	default:
> +		break;
> +	case PM_POST_HIBERNATION:
> +		remap_linear_data_alias(true);
> +		break;
> +	case PM_HIBERNATION_PREPARE:
> +		remap_linear_data_alias(false);
> +		break;
> +	}
> +	return 0;
> +}
> +
>  void __init mark_linear_text_alias_ro(void)
>  {
>  	/*
> @@ -1064,6 +1088,16 @@ void __init mark_linear_text_alias_ro(void)
>  	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
>  			    (unsigned long)__init_begin - (unsigned long)_text,
>  			    PAGE_KERNEL_RO);
> +
> +	remap_linear_data_alias(true);

As suggested on v4, something like mark_linear_data_alias_valid(false)
would be clearer.

Also, is there anything stopping us from doing that directly in map_mem()?

- Kevin

> +
> +	if (IS_ENABLED(CONFIG_HIBERNATION)) {
> +		static struct notifier_block nb = {
> +			.notifier_call = arm64_hibernate_pm_notify
> +		};
> +
> +		register_pm_notifier(&nb);
> +	}
>  }
>  
>  #ifdef CONFIG_KFENCE
> @@ -1189,11 +1223,6 @@ static void __init map_mem(void)
>  		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
>  			       flags);
>  	}
> -
> -	/* Map the kernel data/bss read-only in the linear map */
> -	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
> -	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
> -			       (unsigned long)lm_alias(__bss_stop));
>  }
>  
>  void mark_rodata_ro(void)

