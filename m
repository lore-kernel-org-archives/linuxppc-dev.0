Return-Path: <linuxppc-dev+bounces-29462-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FA9CC6B1A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 08:29:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4PWk6BnBz2xrC;
	Wed, 14 Oct 2026 19:29:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791966578;
	cv=none; b=ax0kjigizFxp28T0xQ2XuSgrXs8TNsO/UWTFfKlLWFjZMnywrgjtiM1DADXOPse3EW/K9g0CotMUBoQ3CoMLIw7V/ORBxYpvm1o7fVM6t0vfixz1l45ZoR4CQNHKiJED1LJjEWomhscxMbk4O6jxUAw84NL1m1KS8mVh2fMczQw05IhMMntEc26MLjoSx3VJDTx/GhBRgV36prr3sWSFnLtkOzV9ZhEmjFzPLvg/1mtnQkQJz084weImGbrYaOZGHJsZzv1WAm0mU1h9rRPfa4ZwDjWwaYHbXxsXi6X2mNEPuPrwe0tcvn3xmUnOa78MeEKkhkDcertJ+G/KYavR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791966578; c=relaxed/relaxed;
	bh=pLz0WUS0mrx3dTeeDzKSgLGzynaLhzlb5S5tCNSjP/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EViaRAOHY4lZ2/KFA1PFy18lw+apmF9Ga6GX0BJyb8dk2FvBeDD3HO9M3wwx0FyDGjRxaOMjKBKTFqTQaQIrvD5Z+Y72arQmUlCQBJbSRGcDkxgTHutn9mWJtWq03D8PdnH43dKHVEzJ0axFVrZySt/Q9xTLwb3pL2I/cse+yQ9xOtzLk1UZ+NBBuMY9KXbxpjpAapPlE/zSCklF2XLYbUaW2AThvmOkqB2yYVwwmhgYgigE9fMtaJ471EguK4sr9zpLu8dgByQTjo6VVBhMr1NdujCY4Jor6jGtgRMry7FBOuI+7Tneib3OfYAEdlo+sAE6hhYaD7lvequ6ZK7ZBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SOprjAZn; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SOprjAZn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4PWj6LrPz2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 19:29:37 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADB0C1595;
	Wed, 14 Oct 2026 01:29:02 -0700 (PDT)
Received: from [10.164.19.62] (unknown [10.164.19.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DCA23F7B4;
	Wed, 14 Oct 2026 01:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791966546; bh=uqP6rvffea+dKh44Kw66QNsZgkM+k15AAqbFFCdBQzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SOprjAZnLFxQFUNswPjzKV3NyMvAa+cqELDDxOZy/T2dOvzLPhV8MisYlsgcPMyj0
	 QXcwMypubhur4Jr+wLDVasbysZkUEWzY4V2UTmjifL3aIeOBnZTwPI0O/w+IYUUpV3
	 4bepahBapz844zPgcczmYHn0Xjy/RiE8Co1chppI=
Message-ID: <51e80f6f-debe-401d-9e9f-140d31d94033@arm.com>
Date: Wed, 14 Oct 2026 13:58:57 +0530
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
Subject: Re: [PATCH v10 05/10] arm64/vmalloc: allow
 arch_vmap_pte_range_map_size() to batch multiple CONT_PTE
To: Wen Jiang <jiangwenxiaomi@gmail.com>, akpm@linux-foundation.org,
 catalin.marinas@arm.com, linux-mm@kvack.org, urezki@gmail.com,
 will@kernel.org
Cc: Xueyuan.chen21@gmail.com, ajd@linux.ibm.com, anshuman.khandual@arm.com,
 baohua@kernel.org, chleroy@kernel.org, david@kernel.org,
 jiangwen6@xiaomi.com, leo.yan@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
 ryan.roberts@arm.com
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
 <20261002090947.869220-6-jiangwen6@xiaomi.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261002090947.869220-6-jiangwen6@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/10/26 2:39 pm, Wen Jiang wrote:
> From: "Barry Song (Xiaomi)" <baohua@kernel.org>
> 
> Allow arch_vmap_pte_range_map_size to batch across multiple CONT_PTE
> blocks, reducing both PTE setup and TLB flush iterations.
> 
> Previously the function returned a single CONT_PTE_SIZE for an aligned
> range, so the caller mapped one CONT_PTE block per iteration. Now, for a
> CONT_PTE_SIZE-aligned range, it returns the largest CONT_PTE-aligned size
> that fits within both the remaining range and the caller's max_page_shift,
> so a single pte_set_huge() call installs several CONT_PTE blocks at once.
> 
> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> Tested-by: Leo Yan <leo.yan@arm.com>
> ---
>  arch/arm64/include/asm/vmalloc.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index 4ec1acd3c1b34..c29704a19e276 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -23,10 +23,12 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
>  						unsigned long end, u64 pfn,
>  						unsigned int max_page_shift)
>  {
> +	unsigned long size;
> +
>  	/*
> -	 * If the block is at least CONT_PTE_SIZE in size, and is naturally
> -	 * aligned in both virtual and physical space, then we can pte-map the
> -	 * block using the PTE_CONT bit for more efficient use of the TLB.
> +	 * If the range is at least CONT_PTE_SIZE and naturally aligned in both
> +	 * virtual and physical space, return the largest CONT_PTE-aligned size
> +	 * that fits, for more efficient use of the TLB.
>  	 */
>  	if (max_page_shift < CONT_PTE_SHIFT)
>  		return PAGE_SIZE;
> @@ -40,7 +42,9 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
>  	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
>  		return PAGE_SIZE;
>  
> -	return CONT_PTE_SIZE;
> +	size = min(end - addr, 1UL << max_page_shift);

Okay so we have implicit PMD_SIZE capping due to (end - addr) being
clamped due to pmd_addr_end(), so we are safe.

Reviewed-by: Dev Jain <dev.jain@arm.com>


> +	size = round_down(size, CONT_PTE_SIZE);
> +	return size;
>  }
>  
>  #define arch_vmap_pte_range_unmap_size arch_vmap_pte_range_unmap_size


