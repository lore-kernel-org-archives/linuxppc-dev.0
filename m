Return-Path: <linuxppc-dev+bounces-21692-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A47CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 08:29:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc2v1h5zz2xnZ;
	Fri, 29 May 2026 18:29:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780043351;
	cv=none; b=hH3t9TLgiIOIHh2X4jkMMbp0S1ZjzC5WVNe09vx9sFBHSRZITPMNnbDpIBbNNn+yTPQsHQR6hS74AHFEqa6v0QrrhmM4NiFdN3KQiawmix8ccVNXz4xEmBGERV4BOhvss/U0128hpFlSWltNL/KtAXDZf0lYzd/gf4MXjwRy3ZcfUpQI2ebmwWnw6sy4C/ZIyqCAw8qRKInWXQdfRfWyrEMlIf8ssI+c2hsfE/3GcWWp5iM1/ezS4bSZhIFYcqWjTPxU5oGLaJ9ZiKmbALooJGLv1La91/kURKHRQ+FasF+xHttl46MVP44WihRwMl3vhKGbnxqQ2WLK1blwNTtBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780043351; c=relaxed/relaxed;
	bh=TCFSp7C/E6gmxsu0aTPyzNbuRDQ/RBTaLjuQipPAzPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewBSAyaGlmfRt/HmhY4EiUWKK0yCzMIQu9TZxVw04CKwcpVtWF1ZG0Yr8gcLVwmht1A0MdSe8zVEPcHoePodzPACUvaXgHAKzjcp+ZPWhnJ7lMRSOzctlnPoo/Ahdvym4tCT6GtKvfBg4oPOK2fh/PgN0ebVbFB1RdHatmMr+FKOcQXk/0i0QYng+t03z3foBXKotvgh8fiDGZintS6US9XjD5lbt1sAmgRToaj+XSw2LuyQIMmztlxza7c83+fAHROtSozu20QmUAccdiMHPrf/nwsFrDyQemVSY+FnEsM+v1Ywn+YCQpj6OmDheuMdd3m/lQBNRf44AhfyGV7x+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XYY9kB9G; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=XYY9kB9G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc2t0WBJz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 18:29:09 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A19FE201B;
	Fri, 29 May 2026 01:28:33 -0700 (PDT)
Received: from [10.57.91.162] (unknown [10.57.91.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51F163F632;
	Fri, 29 May 2026 01:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780043318; bh=HxDE/v275kzieWm+smiZqa4yjNgD7FuY1p40zCPFJh8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XYY9kB9GX0DEWsQN+Oj7ZxBosVWDp3/KI3Y5O5DSe8+4geNHXgkk8LulhMaD4MsWA
	 Nccb5VsdP0UL8JIjPxBgRordOXz3Gl/86u7LQqEBCbv412ByXijVU4uD+broFZMSHy
	 cGpZhrwOcstLiYiLOi2GfzJ7aoGgzXegNpL7uRks=
Message-ID: <87ed7239-1622-4cb3-af04-2390f2b549e3@arm.com>
Date: Fri, 29 May 2026 10:28:31 +0200
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
Subject: Re: [PATCH v6 10/15] arm64: mm: Don't abuse memblock NOMAP to check
 for overlaps
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
 <20260526175846.2694125-27-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260526175846.2694125-27-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2026 19:58, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Now that the linear region mapping routines respect existing table
> mappings and contiguous block and page mappings, it is no longer needed
> to fiddle with the memblock tables to set and clear the NOMAP attribute
> in order to omit text and rodata when creating the linear map.
>
> Instead, map the kernel text and rodata alias first with the desired
> initial attributes and granularity, so that the loop iterating over the
> memblocks will not remap it in a manner that prevents it from being
> remapped with updated attributes later.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/mm/mmu.c | 23 ++++++--------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 04cc579c7a15..b20c76b8381d 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1164,12 +1164,14 @@ static void __init map_mem(void)
>  		flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>  
>  	/*
> -	 * Take care not to create a writable alias for the
> -	 * read-only text and rodata sections of the kernel image.
> -	 * So temporarily mark them as NOMAP to skip mappings in
> -	 * the following for-loop
> +	 * Map the linear alias of the [_text, __init_begin) interval
> +	 * as non-executable now, and remove the write permission in
> +	 * mark_linear_text_alias_ro() above (which will be called after
> +	 * alternative patching has completed). This makes the contents
> +	 * of the region accessible to subsystems such as hibernate,
> +	 * but protects it from inadvertent modification or execution.
>  	 */
> -	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> +	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, flags);

Isn't the loop going to remap the range as pgprot_tagged(PAGE_KERNEL)?
Maybe better to use that here as well just to make it look more consistent.

If my understanding is correct, we should also amend the comment to
avoid implying that the permissions we're passing to __map_memblock()
here matter - the linear alias is going to be non-executable regardless
because of the loop below mapping everything RW.

- Kevin

>  
>  	/* map all the memory banks */
>  	for_each_mem_range(i, &start, &end) {
> @@ -1181,17 +1183,6 @@ static void __init map_mem(void)
>  		__map_memblock(start, end, pgprot_tagged(PAGE_KERNEL),
>  			       flags);
>  	}
> -
> -	/*
> -	 * Map the linear alias of the [_text, __init_begin) interval
> -	 * as non-executable now, and remove the write permission in
> -	 * mark_linear_text_alias_ro() below (which will be called after
> -	 * alternative patching has completed). This makes the contents
> -	 * of the region accessible to subsystems such as hibernate,
> -	 * but protects it from inadvertent modification or execution.
> -	 */
> -	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
> -	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>  }
>  
>  void mark_rodata_ro(void)

