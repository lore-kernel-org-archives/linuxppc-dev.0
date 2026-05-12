Return-Path: <linuxppc-dev+bounces-20763-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD0BCCD4F35
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 May 2026 08:45:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gF9CD4N3Vz2yZc;
	Tue, 12 May 2026 18:45:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778575512;
	cv=none; b=UzPXebnD3WrJgG0NCC18nU1rlZlvTgEo4VY/AafwRZcGZqBwD4F828g6N+iKrfzwVef8Yf/Ra/QogDuHgTinnsx205StNAYZuB1VktzW7glfYLjpO2DIHanNtQlff+u/1sNo3C5pdM6Wc8VxXqD7IIgjO3whjd0NJeGwcb5kzDTDUMGW2TgqvmIOlRRvY354DPLBBV8CBQB3GXj9dT8n+H8w1qCLAkNbBNBIZIiMJIH+tJjKA70btOKgG1SzN86Lw+03rSs5wKcYVyz9LNPnBvFFf3wHEnBfRfOtx1FCA649zjK4D/bWXWIpllYGlctadrEwxesiNiKJDrBeDJbSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778575512; c=relaxed/relaxed;
	bh=GhZDGLrqA0RMRHfvgJ0WVkUHleupN5cnWPNepexFB/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gX0TSu6MjtY/38D/2z0GPgzIlgSlng0LxWTGaa/YBOhhpEU3jvVMLV+vvqR1XrobipnznVSfBip1yt2J8TST4TMfPlCQwTSWOt/CHrCWYgqh7/pF3dPwjPZsHL2xrEyTmHG5C/k58KMD3WV8OdxoaD0dTliar6OYgtMyC85RE3UBLa2+HKVVX+bnew2nNDr6JWL15mWPG5hgG1prv/pT9CYSQE/y8gHYcTCXzVUh3pSn6fcJFTNvcARtiDpsUnoCZAHcZRRV6+2HBwGwg67c2cHLVHEfdMaMLAi7LzcYxCDZLKfEPULZ5ZbKvX0aQzYt5Wk+MnAHIzfL4dpzDtdZ5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rmGlIY7P; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rmGlIY7P;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gF9CC4LPxz2yYs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2026 18:45:11 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C766242A85;
	Tue, 12 May 2026 08:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8BCC2BCB0;
	Tue, 12 May 2026 08:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778575509;
	bh=x5sv3cUvc0EnVzqsB5pARpKxSMhXeMprjYxwjLxFI4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rmGlIY7PfdC6lhhdT+wXAUp3cD6jQUc2MfcH1Hzz4FK42KP1SS+duKfUDwwVzJYjt
	 jCGQUdxWw834Vsk4Ca/+iynRSICvsqKqidNB3PjY2hIewrgmlQvVvP900Lj55EDCbF
	 YNkPyUVnwIxqbg3/FI8+UsFbgb8hpQebDYN+B/SciBNi0BitAZ4peUHMXShauEyxHT
	 YAF7JZ4lzb9YPaKjNIB6PIKGi8r/LxZmLABNTGeJ3/LmTeT+a9CZsPzftd2JWj97sv
	 7uCTS5qmpKR7YKLsghY2KbIEDDRnq1acHacCNvAnkAsIC1gbgyvCfhAMKAlWYXTLbP
	 hKJiPIvYP9g1g==
Message-ID: <b2a8e918-7ed2-46b4-bf59-e65dc9359310@kernel.org>
Date: Tue, 12 May 2026 10:45:03 +0200
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
Subject: Re: [PATCH 4/8] mm/bootmem_info: remove call to
 kmemleak_free_part_phys()
To: Oscar Salvador <osalvador@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-4-3fb0be6fc688@kernel.org>
 <agLmKu3IpGS3FtmX@localhost.localdomain>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <agLmKu3IpGS3FtmX@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/12/26 10:34, Oscar Salvador wrote:
> On Mon, May 11, 2026 at 04:05:32PM +0200, David Hildenbrand (Arm) wrote:
>> The call to kmemleak_free_part_phys() was added in 2022 in
>> commit dd0ff4d12dd2 ("bootmem: remove the vmemmap pages from kmemleak in
>> put_page_bootmem").
>>
>> In 2025, commit b2aad24b5333 ("mm/memmap: prevent double scanning of memmap
>> by kmemleak") started to use MEMBLOCK_ALLOC_NOLEAKTRACE when allocating
>> the memmap to skip the kmemleak_alloc_phys() in the buddy.
>>
>> So remove the call to kmemleak_free_part_phys(). If this would still
>> be required for other purposes, either free_reserved_page() should take
>> care of it, or selected users.
>>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
>> ---
>>  include/linux/bootmem_info.h | 1 -
>>  mm/bootmem_info.c            | 1 -
>>  2 files changed, 2 deletions(-)
>>
>> diff --git a/include/linux/bootmem_info.h b/include/linux/bootmem_info.h
>> index 492ceeb1cdf8..f724340755e5 100644
>> --- a/include/linux/bootmem_info.h
>> +++ b/include/linux/bootmem_info.h
>> @@ -82,7 +82,6 @@ static inline void get_page_bootmem(unsigned long info, struct page *page,
>>  
>>  static inline void free_bootmem_page(struct page *page)
>>  {
>> -	kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>>  	free_reserved_page(page);
>>  }
>>  #endif
>> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
>> index 6e2aaab3dca9..74c1116626c8 100644
>> --- a/mm/bootmem_info.c
>> +++ b/mm/bootmem_info.c
>> @@ -32,7 +32,6 @@ void put_page_bootmem(struct page *page)
>>  
>>  	if (page_ref_dec_return(page) == 1) {
>>  		set_page_private(page, 0);
>> -		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
> 
> A bit odd that kmemleak_free_part_phys() did not complain if we never
> did kmemleak_alloc_phys() for these pages?

delete_object_part() calls __find_and_remove_object() and essentially just skips
if it didn't find anything.

Maybe the kmemleak_warn() would trigger, but it's guarded by "#ifdef DEBUG" ...

-- 
Cheers,

David

