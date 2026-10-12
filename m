Return-Path: <linuxppc-dev+bounces-29231-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1CF7CA9ED2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 07:39:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j38WG1hY5z2yYY;
	Mon, 12 Oct 2026 18:39:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791790794;
	cv=none; b=Emr0JxT6KNcBzYEDKhQeb8B0+dCJbR+EQk8tna0lqxNQ5NKq29UpcViEF28YEJoGiO1H87fSeMgOWQecbiGj+ModZkoxiSZqltzoTeO7kc5LVkcDkRABonSUjOOnle081fUcqQffQk+OWxM5rWakM6fFNACVW/76iq4RNdO/t9Md4xhZ10Sxa7SUetX6jAtaocNyilnSM6DeRH0556wDOC4zibwsp2j7vBSfN1rNtm6gQHgJlALo/sBW9eXkJ2azG1bxO81JZPBse8hwjHU+dSUoqHW5V4T9B73BMwFf41jeBKyJrBkMCyybFYMma/AUWriKqLO7l7HyHnDdCOCtKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791790794; c=relaxed/relaxed;
	bh=ml3XzqnfvkPoJalIiDoqIEaqIWpXPrO+zTg3b+pyBTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iw46jW1yv4QwkjhOsJoHe0+1x2ykYkzPPS2CepFzBHoLmrW2ll/63JD0K3oAZ66D90zw2Ug/16Syv/Vrr7p0JNF5FWUrkWea02K1Xql1duT/iqiDYpThy4+6d9o4qUCogzBZOuy6oeFLASTdnAdpZuQQxXtNnD4gOmsxTEqqixOm/ufbtPM33wAOapTUhfVjaKHWAZG2yHZohAm3xsXAjRxw9iDRGYa7Ap3CdOkHhID03AxOPRA8V0wmhClggmoG93RYKuc64BWTSloiS+C3nWtxOyDQQb7QqzuDvENwlSqA/Q9AKwD+hh3NG5/HXaCcCx56vCgTruzcmWcyPMNqDg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i0lGTdAo; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=i0lGTdAo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j38WD0SQjz2yPR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 18:39:50 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04CB61650;
	Mon, 12 Oct 2026 00:39:15 -0700 (PDT)
Received: from [10.164.19.62] (unknown [10.164.19.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 137743F882;
	Mon, 12 Oct 2026 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791790758; bh=QFylubiAn6XF6+4lXPZWi1iu+KACNJaGKaA1OI3cGV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=i0lGTdAoo7yNW9SwE9EHgLeyVZtho3vPYbLDUzDNLp0AxWuYAdwb5P/QXd71ZeYdL
	 OFHKbtD9gIlK5bb/aEwzvDVLDFJC+bn0oTyJtfKJ13Vjfq7MvuaZfl0HhJzwaQRrAl
	 ULUyyhH0aFG1ImOrjhUsnfRaO5vb7E26yyFrvCc0=
Message-ID: <4f812ef0-ab14-48c5-908b-b7d82ce418b3@arm.com>
Date: Mon, 12 Oct 2026 13:09:10 +0530
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
To: Uladzislau Rezki <urezki@gmail.com>, ryan.roberts@arm.com
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org,
 will@kernel.org, Xueyuan.chen21@gmail.com, ajd@linux.ibm.com,
 anshuman.khandual@arm.com, baohua@kernel.org, chleroy@kernel.org,
 david@kernel.org, jiangwen6@xiaomi.com, leo.yan@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, rppt@kernel.org
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
 <20261002090947.869220-6-jiangwen6@xiaomi.com> <astarANeoldvqBxc@milan>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <astarANeoldvqBxc@milan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/26 3:15 pm, Uladzislau Rezki wrote:
> On Fri, Oct 02, 2026 at 05:09:42PM +0800, Wen Jiang wrote:
>> From: "Barry Song (Xiaomi)" <baohua@kernel.org>
>>
>> Allow arch_vmap_pte_range_map_size to batch across multiple CONT_PTE
>> blocks, reducing both PTE setup and TLB flush iterations.
>>
>> Previously the function returned a single CONT_PTE_SIZE for an aligned
>> range, so the caller mapped one CONT_PTE block per iteration. Now, for a
>> CONT_PTE_SIZE-aligned range, it returns the largest CONT_PTE-aligned size
>> that fits within both the remaining range and the caller's max_page_shift,
>> so a single pte_set_huge() call installs several CONT_PTE blocks at once.
>>
>> Signed-off-by: Barry Song (Xiaomi) <baohua@kernel.org>
>> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
>> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
>> Tested-by: Leo Yan <leo.yan@arm.com>
>> ---
>>  arch/arm64/include/asm/vmalloc.h | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
>> index 4ec1acd3c1b34..c29704a19e276 100644
>> --- a/arch/arm64/include/asm/vmalloc.h
>> +++ b/arch/arm64/include/asm/vmalloc.h
>> @@ -23,10 +23,12 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
>>  						unsigned long end, u64 pfn,
>>  						unsigned int max_page_shift)
>>  {
>> +	unsigned long size;
>> +
>>  	/*
>> -	 * If the block is at least CONT_PTE_SIZE in size, and is naturally
>> -	 * aligned in both virtual and physical space, then we can pte-map the
>> -	 * block using the PTE_CONT bit for more efficient use of the TLB.
>> +	 * If the range is at least CONT_PTE_SIZE and naturally aligned in both
>> +	 * virtual and physical space, return the largest CONT_PTE-aligned size
>> +	 * that fits, for more efficient use of the TLB.
>>  	 */
>>  	if (max_page_shift < CONT_PTE_SHIFT)
>>  		return PAGE_SIZE;
>> @@ -40,7 +42,9 @@ static inline unsigned long arch_vmap_pte_range_map_size(unsigned long addr,
>>  	if (!IS_ALIGNED(PFN_PHYS(pfn), CONT_PTE_SIZE))
>>  		return PAGE_SIZE;
>>  
>> -	return CONT_PTE_SIZE;
>> +	size = min(end - addr, 1UL << max_page_shift);
>> +	size = round_down(size, CONT_PTE_SIZE);
>> +	return size;
>>  }
>>  
>>  #define arch_vmap_pte_range_unmap_size arch_vmap_pte_range_unmap_size
>> -- 
>> 2.34.1
>>
> This is arch/arm64 code. Can you, Jain or Ryan from ARM folk review this change?
> 
> Thank you!
> 

I will come to this soon.


> --
> Uladzislau Rezki


