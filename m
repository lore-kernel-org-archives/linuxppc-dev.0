Return-Path: <linuxppc-dev+bounces-21697-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E2ECD6E45
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 08:33:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc7J4757z2yrX;
	Fri, 29 May 2026 18:33:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780043580;
	cv=none; b=HsXbsUVj7NuBDNKUZNojwdreT7tUL98XXW1ahij/XQh/1pm2gzKvYqEHzPa0avubbQcR3FffRzNLVAulARjjVycSTfX5ThqxQ3i3sADcmFf5t5Y5zIxcBk71hmMqAMGBtL7zQgn7dE8kQdozayn/F5VGkDD2gkDqZG1bt5jrWD6+WdfLRCIu2VEnT/sqa81paSEAuO5/hTvfhKgoAa70g5nqjFc0ZW7nhJXYBRx0KroNsv3Y5MyxIfVw3fJMLG/5YVkSl21w4nA+6leu7EbQEGLRvTYktjDC/geVZR7zu6W7yzz+9WI0/Ey7rVzPiin4tAUJEYPdDuUHGN2IHId5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780043580; c=relaxed/relaxed;
	bh=O9W/ydPv1rdqzqLveu863U04ADFNJiE8EEANHLM3s+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i40RbiaeQXYfnpEmwHEyyASXbS2/vRHcnhbWLeP2/yQy2ONuriZ4VcJTx5FttCw38dikum+WeZKmsFJZq8UTTjznj9s7JR1ZOks+HKokygzmPhuMx4FER2KiVAnUzuT/4tIY5FWAXgBK4hfWNbHJX4g4T3aK/sX5rKCwdgvYijyQnMtOWUIjgSnAtMa7AdwLDPy6yajY52u9kslLgJCmGiMG4I0oPzWZub5FWK3cyLFfPRPHdFi5LYcUOt595fkRrvKExjWOkbfCmvztQwaQN36FCNWA3f2RqMw+yHi9Cf6MQ2tYaPNnrkJASuFSCEN3FUUOomzVEactt+C+9t8X0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nLeLgcyf; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nLeLgcyf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc7H29JCz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 18:32:59 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26BB920E3;
	Fri, 29 May 2026 01:25:41 -0700 (PDT)
Received: from [10.57.91.162] (unknown [10.57.91.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB3B03F632;
	Fri, 29 May 2026 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780043146; bh=XELYFuViuZqrLLxfdD4PGyPtxf/Au3oWznf3FJ0ages=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nLeLgcyf0k0ldux0TFh1jZXIYKRbC8G2USuqOmM/9EmYadwJutsqHi6rAS3wJ4LeP
	 LQ0tUrmOO60rTr/DJhKXdMc6ZEjfiLBQ3YU7iRkmjIzZx6xkLa0FfaMwWkTN/fTA4l
	 YY6GEpLN1I96rm5mjpzFJBCMsGNrpegHKxst0bvg=
Message-ID: <9493da99-3476-4fdd-818b-19e424b46f8e@arm.com>
Date: Fri, 29 May 2026 10:25:39 +0200
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
Subject: Re: [PATCH v6 08/15] arm64: mm: Permit contiguous attribute for
 preliminary mappings
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
 <20260526175846.2694125-25-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260526175846.2694125-25-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2026 19:58, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> There are a few cases where we omit the contiguous hint for mappings
> that start out as read-write and are remapped read-only later, on the
> basis that manipulating live descriptors with the PTE_CONT attribute set
> is unsafe. When support for the contiguous hint was added to the code,
> the ARM ARM was ambiguous about this, and so we erred on the side of
> caution.
>
> In the meantime, this has been clarified [0], and regions that will be
> remapped in their entirety, retaining the contiguous bit on all entries,
> can use the contiguous hint both in the initial mapping as well as the
> one that replaces it. Note that this requires that the logic that may be
> called to remap overlapping regions respects existing valid descriptors
> that have the contiguous bit cleared.
>
> So omit the NO_CONT_MAPPINGS flag in places where it is unneeded.
>
> Thanks to Ryan for the reference.
>
> [0] RJQQTC
>
> For a TLB lookup in a contiguous region mapped by translation table entries that
> have consistent values for the Contiguous bit, but have the OA, attributes, or
> permissions misprogrammed, that TLB lookup is permitted to produce an OA, access
> permissions, and memory attributes that are consistent with any one of the
> programmed translation table values.
>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> ---
>  arch/arm64/mm/mmu.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 55bb40348a47..04cc579c7a15 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1016,8 +1016,7 @@ void __init create_mapping_noalloc(phys_addr_t phys, unsigned long virt,
>  			&phys, virt);
>  		return;
>  	}
> -	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
> -				 NO_CONT_MAPPINGS);
> +	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, 0);
>  }
>  
>  void __init create_pgd_mapping(struct mm_struct *mm, phys_addr_t phys,
> @@ -1044,8 +1043,7 @@ static void update_mapping_prot(phys_addr_t phys, unsigned long virt,
>  		return;
>  	}
>  
> -	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL,
> -				 NO_CONT_MAPPINGS);
> +	early_create_pgd_mapping(init_mm.pgd, phys, virt, size, prot, NULL, 0);
>  
>  	/* flush the TLBs after updating live kernel mappings */
>  	flush_tlb_kernel_range(virt, virt + size);
> @@ -1191,10 +1189,8 @@ static void __init map_mem(void)
>  	 * alternative patching has completed). This makes the contents
>  	 * of the region accessible to subsystems such as hibernate,
>  	 * but protects it from inadvertent modification or execution.
> -	 * Note that contiguous mappings cannot be remapped in this way,
> -	 * so we should avoid them here.
>  	 */
> -	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, NO_CONT_MAPPINGS);
> +	__map_memblock(kernel_start, kernel_end, PAGE_KERNEL, 0);
>  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
>  }
>  

