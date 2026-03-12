Return-Path: <linuxppc-dev+bounces-18095-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 492D1105A588
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Mar 2026 11:24:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWlcg3smrz3cFN;
	Thu, 12 Mar 2026 22:24:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773314643;
	cv=none; b=jPSV2QdYn9I0EO77ljByrC68QgFc6YO4Pqmq89gIlqkCpLRvAxOyk74UPXxZ5RJyVjeft9BlFIhZsbaBAJEQI6agyRBeiNJmlMauxTxAYeTVBJjuvk+nIsEmwFs6uI2VhMJVZXmJNWb9z5f9hgQ7qTlRsXyIrBoRPC+eNRZcruSoJJjNPKxOk5Vzhhul2R6lroEQNGJ6e5vcObN9iv/I0X8Ejzw+Xbss47txwJVVQnpBuSnNHuFgDlPTv2O/nVbTsvMBXEobv+JY5w4DlffA3c0QHl0+1QgXqL2gLYHTwL3yEOk+1slbrTOXqkxLpANbc2MoWfqbbSSlgBi/MfwxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773314643; c=relaxed/relaxed;
	bh=lHgPc4c+EM1wDk0QatI4ONB6TYrHc3Tzig8f9b6Zjag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZWL3eS7vj1z65cGY5+qR9fqfxmeS0MkDoJtuOkMXePxiLwpSk1vsNDQ8LGUMyrz+uP8MjDuzRhh5IPgJ2/8TQ+wbpejoNjMyGeL6mJAFKgWCC0dPSUPASmAzxd1PPI4vfsAD0Q4wEnQbJPNP08PENy3tEMEDJd8l1emRN/rWu7H1fIbDdjCQvdI7lgpDqo67iUf2RfnVumym/2vHODGVKabzSSW4wCQXiUg3xTUsV3K1FidNzTa2UOl42LKHxpJjjhG+azWcuJev1/DIYv4yN0CczbZNjM4W+uYVLkF+H5+e4FfdJLXblHkYW8pmQmLr8PQ1lyrJziDANYIdvjtGxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gddxThvu; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=gddxThvu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWlcf3Q8bz3cCJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 22:24:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 88FA9403C8;
	Thu, 12 Mar 2026 11:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32B8C4CEF7;
	Thu, 12 Mar 2026 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314639;
	bh=QmUndoWKkvGu15ytPgiNk/W/zfIzuga6NPM0kq37X6g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gddxThvuN8nEkxb1oe2xYVqYBPcAGoZjE0JamctgWmvcBJC+2RXK4H1Oaf+f3JOwW
	 fxwH+WLkxZbJY0MknBkur5pI7FCchUtXNdDKsThu5lMuoBANKs+UeoyfTMkJ1sO3+r
	 4hpyJwTo29UlAt3cBAFFMBFuxc1orHcop3iw89T3rJ87yz2VKPaAXnDxEi2c/fTd87
	 eJ/zbtp6tA8W/XODS6RYQsmWksPaTPRpOv5PRjQnkFFww5eYDtX/ErhgfeDObPX20h
	 SEdGEgkqgOZOHOJQuURbLLXig62kg6JD5Fx4CH2RFeTqabIPhh1ARDfQqZ3yTDKMjS
	 /FQjMq5HRAp3w==
Message-ID: <0bc30137-3f1d-4a4a-8573-8f26866fcc26@kernel.org>
Date: Thu, 12 Mar 2026 12:23:50 +0100
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
Subject: Re: [PATCH v5 09/15] arch/powerpc: don't initialize kasan if it's
 disabled
To: Sourabh Jain <sourabhjain@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
 kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org, andreyknvl@gmail.com, ryabinin.a.a@gmail.com,
 glider@google.com, dvyukov@google.com, linux-kernel@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, x86@kernel.org, chris@zankel.net,
 jcmvbkbc@gmail.com, linux-s390@vger.kernel.org, hca@linux.ibm.com
References: <20260225081412.76502-1-bhe@redhat.com>
 <20260225081412.76502-10-bhe@redhat.com>
 <71921cca-b890-41c4-93e9-957d3f647ffa@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <71921cca-b890-41c4-93e9-957d3f647ffa@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 12/03/2026 à 12:12, Sourabh Jain a écrit :
> 
> 
> On 25/02/26 13:44, Baoquan He wrote:
>> Here, kasan is disabled if specified 'kasan=off' in kernel cmdline.
>>
>> This includes 32bit, book3s/64 and book3e/64.
>>
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> ---
>>   arch/powerpc/mm/kasan/init_32.c        | 6 +++++-
>>   arch/powerpc/mm/kasan/init_book3e_64.c | 4 ++++
>>   arch/powerpc/mm/kasan/init_book3s_64.c | 4 ++++
>>   3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/ 
>> init_32.c
>> index 1d083597464f..0ea2a636c992 100644
>> --- a/arch/powerpc/mm/kasan/init_32.c
>> +++ b/arch/powerpc/mm/kasan/init_32.c
>> @@ -141,6 +141,10 @@ void __init kasan_init(void)
>>       u64 i;
>>       int ret;
>> +    /* If KASAN is disabled via command line, don't initialize it. */
>> +    if (kasan_arg_disabled)
>> +        return;
>> +
>>       for_each_mem_range(i, &base, &end) {
>>           phys_addr_t top = min(end, total_lowmem);
>> @@ -170,7 +174,7 @@ void __init kasan_init(void)
>>   void __init kasan_late_init(void)
>>   {
>> -    if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
>> +    if (IS_ENABLED(CONFIG_KASAN_VMALLOC) && kasan_enabled())
>>           kasan_unmap_early_shadow_vmalloc();
>>   }
>> diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/ 
>> kasan/init_book3e_64.c
>> index 0d3a73d6d4b0..fbe4c9a7e460 100644
>> --- a/arch/powerpc/mm/kasan/init_book3e_64.c
>> +++ b/arch/powerpc/mm/kasan/init_book3e_64.c
>> @@ -111,6 +111,10 @@ void __init kasan_init(void)
>>       u64 i;
>>       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), 
>> PAGE_KERNEL_RO);
>> +    /* If KASAN is disabled via command line, don't initialize it. */
>> +    if (kasan_arg_disabled)
>> +        return;
>> +
>>       for_each_mem_range(i, &start, &end)
>>           kasan_init_phys_region(phys_to_virt(start), phys_to_virt(end));
>> diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/ 
>> kasan/init_book3s_64.c
>> index dcafa641804c..f7906f9ef9be 100644
>> --- a/arch/powerpc/mm/kasan/init_book3s_64.c
>> +++ b/arch/powerpc/mm/kasan/init_book3s_64.c
>> @@ -54,6 +54,10 @@ void __init kasan_init(void)
>>       u64 i;
>>       pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), 
>> PAGE_KERNEL);
>> +    /* If KASAN is disabled via command line, don't initialize it. */
>> +    if (kasan_arg_disabled)
>> +        return;
>> +
>>       if (!early_radix_enabled()) {
>>           pr_warn("KASAN not enabled as it requires radix!");
>>           return;
> 
> Should we log in the kernel log buffer that KASAN is disabled?
> 
> Right now, I don't see the kernel advertising the same.

When KASAN is enabled it is advertised with:

	pr_info("KernelAddressSanitizer initialized (generic)\n");

Isn't the absence of that message enough to understand KASAN is not there ?

> 
> $ dmesg | grep -i kasan
> [    0.000000] Kernel command line: BOOT_IMAGE=(ieee1275//vdevice/v- 
> scsi@30000070/disk@8100000000000000,msdos2)/vmlinuz-7.0.0-rc3+ 
> crashkernel=2G kasan=off
> 
> Tested this series on powerpc Pseries platform.
> So feel free to add:
> Tested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> 
> - Sourabh Jain
> 


