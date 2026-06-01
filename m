Return-Path: <linuxppc-dev+bounces-21810-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCD2CD6E56
	for <linuxppc-dev@archiver.kernel.org>; Mon,  1 Jun 2026 10:44:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTVvJ21plz2ydQ;
	Mon, 01 Jun 2026 20:44:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780310652;
	cv=none; b=j9m4Qb+Mu3LLvn8C+nt/09C4Sttkdkmi41hm3FbS4uGu9OKtD6h0gwz0i9vgF+Rrf7dSuHJssSLsQDeHdQ2sFFn0gxCHp+bW3PsHgRfQ/RGBEswWtnjCiSzyxe8MiJSzUvRWCM+pxf7dc0BD9hW1VJJZ4hsLG6FlKH62G/AB/V415nF+8dDClp0Uu7ZhCDlFPeGwLXvMhM3eyBLUKYjrOX0o/vcgFv70/0TDtr6jbY3dnpuuiu5vW9FMJBJv5BDwoYb6W0NPa8pf/fGVR353wWVF9J7QG6TndMlUQ6t8yzidxqa+ZvjlDPysD4EPeugpj/TGnDLSaFP8zjaShzdthw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780310652; c=relaxed/relaxed;
	bh=BdxzfLXr6/G/k/tGtVLcYYbC4QvrQHAxO2smMCOSTy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AV0gNB1rifyg0d+CHjBOdm9p/I2e157v0uM7UTMm6L83rXQjgl/QcSoYTDcuqT9un1mvFmbf9AsKDaI8MdW1RTNVDtRnFLhnhZx1rH+mIinn43g//bnNA+cxMW0Lg03dXvObCAqrPGG95x79IwwMH6A/nH+QhvQtGxncrx1V/s/78yDMmrk6WG+1AuwouvrL2iIc1aQuLTYehmItSNj4dB5RboPghz++IHmys9U2mwRF/MpBgDyDAoIRFcNJCxXkoKsq+H8uBqjS78wUaBVf/1UeXuAmjJOkvnCrX3y/EUhNAJuBY/jO1d2q3u35GcN6KtRYCEi6250HRvwSR+znqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ATGD2KEF; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=ATGD2KEF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gTVvH2Krlz2xdb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2026 20:44:11 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB1D41516;
	Mon,  1 Jun 2026 03:43:34 -0700 (PDT)
Received: from [10.57.94.8] (unknown [10.57.94.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38E4D3F905;
	Mon,  1 Jun 2026 03:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780310619; bh=C3+Nupy9epvTU9YJN+UUOeTEoo2XErmrS9cELXLEaTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ATGD2KEFk9zH6A/3/wbmsLo8Bk16zruKAja2MWpstRHrcKrUHTc7cCqmaTsy1kze4
	 vG+kAYpgRYGrfxsVM+k07lFcID8aETdcpIWAaY6POEOlyHhT7SAbyCaNPXgf688bb2
	 NWAccF9tR54IJl/TxpZC5Vs/Yx5VmFz06QrmL7VQ=
Message-ID: <e9187fdb-b4dc-4b82-8783-fe1eb221d885@arm.com>
Date: Mon, 1 Jun 2026 12:43:29 +0200
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
Subject: Re: [PATCH v7 15/15] arm64: mm: Unmap kernel data/bss entirely from
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
References: <20260529150150.1670604-17-ardb+git@google.com>
 <20260529150150.1670604-32-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260529150150.1670604-32-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/05/2026 17:02, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> The linear aliases of the kernel text and rodata are also mapped
> read-only in the linear map. Given that the contents of these regions
> are mostly identical to the version in the loadable image, mapping them
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
> map/unmap the region as needed.

s/so map/to map/? Also not sure what "initially" is referring to here.

Otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

I don't know much about hibernation though, would be good for someone
knowledgeable to have a look.

- Kevin

> Doing so is required because pages covering the kernel image are marked
> as PageReserved, and therefore disregarded for snapshotting by the
> hibernate logic unless they are mapped.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/mmu.c | 45 ++++++++++++++++++--
>  1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 7b18dc2f1721..07a6fa210171 100644
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
> +static void mark_linear_data_alias_valid(bool valid)
> +{
> +	set_memory_valid((unsigned long)lm_alias(__init_end),
> +			 (unsigned long)(__bss_stop - __init_end) / PAGE_SIZE,
> +			 valid);
> +}
> +
> +static int arm64_hibernate_pm_notify(struct notifier_block *nb,
> +				     unsigned long mode, void *unused)
> +{
> +	switch (mode) {
> +	default:
> +		break;
> +	case PM_POST_HIBERNATION:
> +		mark_linear_data_alias_valid(false);
> +		break;
> +	case PM_HIBERNATION_PREPARE:
> +		mark_linear_data_alias_valid(true);
> +		break;
> +	}
> +	return 0;
> +}
> +
>  void __init mark_linear_text_alias_ro(void)
>  {
>  	/*
> @@ -1064,6 +1088,21 @@ void __init mark_linear_text_alias_ro(void)
>  	update_mapping_prot(__pa_symbol(_text), (unsigned long)lm_alias(_text),
>  			    (unsigned long)__init_begin - (unsigned long)_text,
>  			    PAGE_KERNEL_RO);
> +
> +	/*
> +	 * Register a PM notifier to remap the linear alias of data/bss as
> +	 * valid read-only before hibernation. This is needed because the
> +	 * snapshot logic disregards PageReserved pages (such as the ones
> +	 * covering the kernel image) unless they are mapped in the linear
> +	 * map.
> +	 */
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
> @@ -1193,10 +1232,8 @@ static void __init map_mem(void)
>  			       flags);
>  	}
>  
> -	/* Map the kernel data/bss read-only in the linear map */
> -	__map_memblock(init_end, kernel_end, PAGE_KERNEL_RO, flags);
> -	flush_tlb_kernel_range((unsigned long)lm_alias(__init_end),
> -			       (unsigned long)lm_alias(__bss_stop));
> +	/* Map the kernel data/bss as invalid in the linear map */
> +	mark_linear_data_alias_valid(false);
>  }
>  
>  void mark_rodata_ro(void)

