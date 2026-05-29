Return-Path: <linuxppc-dev+bounces-21691-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE57CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 May 2026 08:28:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc1x2vPvz2xnZ;
	Fri, 29 May 2026 18:28:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780043301;
	cv=none; b=VhHSMxsVjP/bYjfB/iRUUhN62avnmhNkSFj9g2reoeaUhKqzU5htpZePaiEGQ4ka8SbugF0Xt/2dZaI4/nZThwHMhanJvxWkVY6udJgV71GyygOJxzn7ogIpq6WEZd6L2XscwvuCe0xJ4/chI6WnVxFGYs8jhVmC1Gw89Wa9g7KYel9YYwFKvfS2YfesxK9ULR4EYt1AB2FpphoabIgIxbNxvATlcSdPXe8XP7++WRbGalJgu/Rlh5fSbupnPDMfFXoM5ALiJKmA+H51f75Iri1CbhZCBj0Ka/dX03XP1m8Wv2MRK+OAsFEMfjTaqrmNkMWc+QZhJxfYi+9THzU3/w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780043301; c=relaxed/relaxed;
	bh=CH0z2W4yhgf/tO2JKbxj0lz1C+rTr91+0P7YFlO3hzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCsweBVOjkRxpqL+ivceoDWNEO/EVlccCS76B7t1ci1sCmyADD0CkTqoND076ZpxKPnNoJ1ZPKq5fuVhhiN2giuhDSbdD2TQ4rkVLNsHyJIRszysdvygKUKjqKnDCp9Mn0NQVWQ959JaXpiwazuXRZ4+wW5q590t+8cs/yWjj1IqcAankxmzY9tDF7qMDubReYi+a7nGxy4SJQ0o/dy4kaEU0pGtQ0RrfB1QfghaSx8ySNvmSuJNs3QwaOcHV3eVQPr61GwbtChdHi7Qc78hOgGVAhHjVQl4qjaKrQHp8y/QPF5+wylpSZ+D5wuNc/NWt+C5v/fIyam0S3nKA9fFEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sZLc3D9c; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sZLc3D9c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=kevin.brodsky@arm.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 146 seconds by postgrey-1.37 at boromir; Fri, 29 May 2026 18:28:18 AEST
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gRc1t4M2cz2xLs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2026 18:28:18 +1000 (AEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2265201B;
	Fri, 29 May 2026 01:27:41 -0700 (PDT)
Received: from [10.57.91.162] (unknown [10.57.91.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F36E3F632;
	Fri, 29 May 2026 01:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780043266; bh=vGqKwtowp8PNMRvBO7niOdxzr80Af+Ycpil33LSytq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sZLc3D9chfT7SLPciBg3CzU4tEgQd2MgnitSwynPVzMJkASztCzaS8U6eG48NlXUj
	 NjlYJAnCst9GC7POcH6vB4eJQPJcLzWDvzqPHQrCfUmthlePWs5wgYHTV4sko2IV+Z
	 aIr2mh8cXNbx5h2aQZIulPua6F09KFpwA+oUzHNk=
Message-ID: <2a6f9f05-ac57-4ef8-9328-74cc8ccfea16@arm.com>
Date: Fri, 29 May 2026 10:27:37 +0200
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
Subject: Re: [PATCH v6 09/15] arm64: Move fixmap and kasan page tables to end
 of kernel image
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
 <20260526175846.2694125-26-ardb+git@google.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260526175846.2694125-26-ardb+git@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2026 19:58, Ard Biesheuvel wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Move the fixmap and kasan page tables out of the BSS section, and place
> them at the end of the image, right before the init_pg_dir section where
> some of the other statically allocated page tables live.
>
> These page tables are currently the only data objects in vmlinux that
> are meant to be accessed via the kernel image's linear alias, and so
> placing them together allows the remainder of the data/bss section to be
> remapped read-only or unmapped entirely.
>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/mmu.h    | 2 ++
>  arch/arm64/kernel/vmlinux.lds.S | 8 +++++++-
>  arch/arm64/mm/fixmap.c          | 6 +++---
>  arch/arm64/mm/kasan_init.c      | 2 +-
>  4 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> index 5e1211c540ab..fb95754f2876 100644
> --- a/arch/arm64/include/asm/mmu.h
> +++ b/arch/arm64/include/asm/mmu.h
> @@ -13,6 +13,8 @@
>  
>  #ifndef __ASSEMBLER__
>  
> +#define __pgtbl_bss __section(".pgdir.bss") __aligned(PAGE_SIZE)
> +
>  #include <linux/refcount.h>
>  #include <asm/cpufeature.h>
>  
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index e1ac876200a3..2b0ebfb30c63 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -349,9 +349,15 @@ SECTIONS
>  	_edata = .;
>  
>  	/* start of zero-init region */
> -	BSS_SECTION(SBSS_ALIGN, 0, 0)
> +	BSS_SECTION(SBSS_ALIGN, 0, PAGE_SIZE)
>  	__pi___bss_start = __bss_start;
>  
> +	/* fixmap BSS starts here - preceding data/BSS is omitted from the linear map */
> +	.pgdir.bss (NOLOAD) : ALIGN(PAGE_SIZE) {

Do we actually need the NOLOAD type here?

Aside from that:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> +		*(.pgdir.bss)
> +	}
> +	ASSERT(ADDR(.pgdir.bss) == __bss_stop, ".pgdir.bss must follow BSS")
> +
>  	. = ALIGN(PAGE_SIZE);
>  	__pi_init_pg_dir = .;
>  	. += INIT_DIR_SIZE;
> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
> index c5c5425791da..1a3bbd67dd76 100644
> --- a/arch/arm64/mm/fixmap.c
> +++ b/arch/arm64/mm/fixmap.c
> @@ -31,9 +31,9 @@ static_assert(NR_BM_PMD_TABLES == 1);
>  
>  #define BM_PTE_TABLE_IDX(addr)	__BM_TABLE_IDX(addr, PMD_SHIFT)
>  
> -static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __page_aligned_bss;
> -static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
> -static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
> +static pte_t bm_pte[NR_BM_PTE_TABLES][PTRS_PER_PTE] __pgtbl_bss;
> +static pmd_t bm_pmd[PTRS_PER_PMD] __pgtbl_bss __maybe_unused;
> +static pud_t bm_pud[PTRS_PER_PUD] __pgtbl_bss __maybe_unused;
>  
>  static inline pte_t *fixmap_pte(unsigned long addr)
>  {
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index abeb81bf6ebd..dbf22cae82ee 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -214,7 +214,7 @@ asmlinkage void __init kasan_early_init(void)
>  		 * shadow pud_t[]/p4d_t[], which could end up getting corrupted
>  		 * when the linear region is mapped.
>  		 */
> -		static pte_t tbl[PTRS_PER_PTE] __page_aligned_bss;
> +		static pte_t tbl[PTRS_PER_PTE] __pgtbl_bss;
>  		pgd_t *pgdp = pgd_offset_k(KASAN_SHADOW_START);
>  
>  		set_pgd(pgdp, __pgd(__pa_symbol(tbl) | PGD_TYPE_TABLE));

