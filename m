Return-Path: <linuxppc-dev+bounces-28940-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B350CA5FF5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 21:47:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzCfr72Gtz2xwP;
	Tue, 06 Oct 2026 08:47:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791232833;
	cv=none; b=WcsQEg6h3t36IrMzFtbH1+/7x/dvw8fNXXEm1VGBt42LvNEVlaUtJeN9JH9gGp/P0cDxyBkm/GnARGhnbcDW4TRQXNgxsQVDHWUVLEaG5AL+Fga8By8FoN9B+9479J7MFlRoGCynQa44dJuiuwtYo4Rdj0T8EDJf+eh45wR+qCFO3S9kYyI7cBjQhV5X/byu4i1fR4qgV1jPn1orFOMTOUjuEpYIGZy3QTH4cIA/JnXvsB5EaTqo70tQN3LCxUQ6hvekHpkr3F0tHF97CWmGo0u7H7v5AYO5bBj3hVH44vL6XJCzhYrRYZW8F3tt78Pw+1gX5z6Cn1cZoE3ywETB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791232833; c=relaxed/relaxed;
	bh=hW5P4NCcHfyGHbJZF1DNl1NQBu8IkdsCT0CTDVEsdgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WY6X/NtsAQyMM95RVpJgSBFnF1RPHcynNoHGnwgPKXSq8z6NdiM9PotW03RKbGsfAJFeH34eKzFB4+AZSI/8RWKTSJLVN6bJij7jKCNjB7YEshN3twFq58VkYUIPSs92z4ZqFdrpMrrjbuMgo3omPxiNRU4XtfVY6xW1EP99yFIytmTUAHLHGby7DClxDecI0sfOUa9vzvXmqa92yoiLvHldnbUCL59LtVyWTgWAKtmcIrqBt0xzumIKYz8wAUSCPPDc1slt43IDxaU66OCfATcDPM/L3SfIY5CMLESRM7PGU0D+to+8NcuDzManLrX8WEbKN74mcbvvH4p6v6Jghg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eiJZdfPl; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eiJZdfPl; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eiJZdfPl; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=luizcap@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eiJZdfPl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eiJZdfPl;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eiJZdfPl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=luizcap@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzB9D2VXYz2yY0
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 07:40:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791232826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hW5P4NCcHfyGHbJZF1DNl1NQBu8IkdsCT0CTDVEsdgw=;
	b=eiJZdfPlK/vFaLtLo/M3S93+Kh+rLYhvjB6TjcyHGaFnB4zPCbX8AtgpGnJ3HRzV+z2qE5
	BLlPysAa7d7flJW68K4gL3eEcDEmB5j3gE1cYWnLgCHb8yrqL5x71XHsWOnKDjAxjO+u7y
	T0qDO9HTjzwUF+HoY4LiIsBHL7kGNi0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791232826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hW5P4NCcHfyGHbJZF1DNl1NQBu8IkdsCT0CTDVEsdgw=;
	b=eiJZdfPlK/vFaLtLo/M3S93+Kh+rLYhvjB6TjcyHGaFnB4zPCbX8AtgpGnJ3HRzV+z2qE5
	BLlPysAa7d7flJW68K4gL3eEcDEmB5j3gE1cYWnLgCHb8yrqL5x71XHsWOnKDjAxjO+u7y
	T0qDO9HTjzwUF+HoY4LiIsBHL7kGNi0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791232826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hW5P4NCcHfyGHbJZF1DNl1NQBu8IkdsCT0CTDVEsdgw=;
	b=eiJZdfPlK/vFaLtLo/M3S93+Kh+rLYhvjB6TjcyHGaFnB4zPCbX8AtgpGnJ3HRzV+z2qE5
	BLlPysAa7d7flJW68K4gL3eEcDEmB5j3gE1cYWnLgCHb8yrqL5x71XHsWOnKDjAxjO+u7y
	T0qDO9HTjzwUF+HoY4LiIsBHL7kGNi0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-DhkrObnoOe-JpFjT2VaKAQ-1; Mon, 05 Oct 2026 16:40:23 -0400
X-MC-Unique: DhkrObnoOe-JpFjT2VaKAQ-1
X-Mimecast-MFC-AGG-ID: DhkrObnoOe-JpFjT2VaKAQ_1791232822
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3a1fa5bb969so12210201fa.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 13:40:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791232822; x=1791837622;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hW5P4NCcHfyGHbJZF1DNl1NQBu8IkdsCT0CTDVEsdgw=;
        b=f2XQWo+1n9rbmAXgIoqJIlCdrWUXigZhhmZTyRU8zM9lsa5jw6RjjC5S6n5YgKKzc1
         BzXQOu96tP9zLOeKomEMcVAHTHIoQV59IFnQqNOVrr+6poiqjfQJVxZN4g6UwWMSpgDr
         cWTfeGSdBtbHFMiPHhxREfa1NGW5xCreWB+Ots2tTCT/nyzZbr0CSj+h1I+JCZXAom6O
         IEoFDyVreqGLEvu7qqebHX0TZyfg4Sl996tGBhwHJPOKuo5hDHgmgLIg1Y8dVFqSogJ/
         2n7u/1hQMuS6tZaJg+AOVKRpIIC2xDN30OTVjShaYI5IUds07RrlQb1ygA9T5I/GsFUC
         AXPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmP9zGijrPBUWAxz1ubvlLpvF3Q9mbWn8acpAjGXbiSNTZu9KGN8kTPBF84ykv/zg29IK+F3O0sXUfPjY=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYJ40H7aAtUma4lHKZLwhE3VkqBCRF8eQy8aj4FiOXcaVPYic4eF
	hhhqXE1YUY3rqqVfvydRH9vOZbp79iT/o7MKcsNs99y2xJXMMQJWZsGGZ0uMEwYAI1/DWxT4MxF
	Ol5awthbwZ29quiDHOK1DNRgHRCXcAu8h+3ZcI57v+Rz3WrO3CjuUh2y0FtpdDzwzZdE=
X-Gm-Gg: AYBFou0F6c75TGImYjWxgNZH6dLwEh3kpRpKHdbOERnl5TLsK/mRifpVN0fW/aI9wGQ
	DeYaSsoZjPPgKJM7LXSEKB7P+vo1N8L78ud5TigsXzFznaneKt1DnTGbcd/23OwF5MnO8kHuliK
	thWx64ovheU0TyCEbpmXFVmgm6voUX0d0hf0+Lvz3iLV+NKXnHR5k8ENnfMghienPhAxFv/I11n
	0w03ZhXR9hKFnctP4vKvCQo9ucdHIIr/CueWIIpWz+ts/3eELHeQ6zbnIrvhS+OekPm3tPydHeL
	61N3zRmJ8m2SlU41k1hOvumQPgB/uB8HbA0f3hbJqneXvJiZCc8hzYRSCzYzLqNJQhwuWuS4xbW
	/B0k=
X-Received: by 2002:a05:651c:1602:b0:3a5:b1f7:a7bf with SMTP id 38308e7fff4ca-3a974f64065mr22350621fa.21.1791232822112;
        Mon, 05 Oct 2026 13:40:22 -0700 (PDT)
X-Received: by 2002:a05:651c:1602:b0:3a5:b1f7:a7bf with SMTP id 38308e7fff4ca-3a974f64065mr22350491fa.21.1791232821598;
        Mon, 05 Oct 2026 13:40:21 -0700 (PDT)
Received: from [192.168.2.110] ([142.172.30.162])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a87e28b131sm45437081fa.1.2026.10.05.13.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 13:40:21 -0700 (PDT)
Message-ID: <9adb6aaf-6e50-4ab0-a021-2529807dff02@redhat.com>
Date: Mon, 5 Oct 2026 16:40:14 -0400
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
Subject: Re: [PATCH v8 09/14] powerpc: move has_transparent_hugepage() out of
 THP guard
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, baolin.wang@linux.alibaba.com, ziy@nvidia.com,
 lance.yang@linux.dev,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Cc: corbet@lwn.net, tsbogend@alpha.franken.de, maddy@linux.ibm.com,
 mpe@ellerman.id.au, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, x86@kernel.org, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, hughd@google.com,
 dave.hansen@linux.intel.com, djbw@kernel.org, vishal.l.verma@intel.com,
 dave.jiang@intel.com, akpm@linux-foundation.org, yintirui@huawei.com,
 dev.jain@arm.com, usama.arif@linux.dev
References: <cover.1789695931.git.luizcap@redhat.com>
 <05a71b6011a6eab7b096f262485fcb8b4987976f.1789695931.git.luizcap@redhat.com>
 <f54d5d75-5cc1-488b-b640-76163419cf4d@kernel.org>
 <25bb02df-a795-4e48-9de6-99f1ca799176@redhat.com>
 <802564f8-1376-451e-8308-6f98d1efb099@kernel.org>
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <802564f8-1376-451e-8308-6f98d1efb099@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k_D8V7XngBX2qaaHZNC4yXPLEvKllXGMW4ncZs6GedE_1791232822
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/5/26 12:52 AM, Christophe Leroy (CS GROUP) wrote:
> Hi,
> 
> Don't forget <linuxppc-dev@lists.ozlabs.org> when you address powerpc architecture.

Will do.

> 
> Le 03/10/2026 à 17:44, Luiz Capitulino a écrit :
>>
>>
>> On 10/2/26 3:28 PM, David Hildenbrand (Arm) wrote:
>>> On 9/18/26 03:45, Luiz Capitulino wrote:
>>>> A future commit will introduce a kernel API to allow for checking if the
>>>> CPU supports PMD-sized pages. This API will be based on the
>>>> has_transparent_hugepage() implementation but will be orthogonal to THP
>>>> and therefore must work when CONFIG_TRANSPARENT_HUGEPAGE=n.
>>>>
>>>> Move its definition out of the THP guard.
>>>>
>>>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>>>> ---
>>>>   arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 +-
>>>>   arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 +-
>>>>   arch/powerpc/include/asm/book3s/64/pgtable.h  | 18 +++++++++---------
>>>>   arch/powerpc/include/asm/book3s/64/radix.h    | 14 +++++++-------
>>>>   arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 ++--
>>>>   5 files changed, 20 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/ powerpc/include/asm/book3s/64/hash-4k.h
>>>> index 8e5bd9902bed..79511e6abfca 100644
>>>> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
>>>> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>>>> @@ -165,9 +165,9 @@ extern void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
>>>>   extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
>>>>   extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
>>>>                          unsigned long addr, pmd_t *pmdp);
>>>> -extern int hash__has_transparent_hugepage(void);
>>>>   #endif
>>>> +extern int hash__has_transparent_hugepage(void);
>>>>   #endif /* !__ASSEMBLER__ */
>>>>   #endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
>>>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/ powerpc/include/asm/book3s/64/hash-64k.h
>>>> index 7deb3a66890b..a4a44a112ff9 100644
>>>> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>>> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>>> @@ -278,9 +278,9 @@ extern void hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
>>>>   extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
>>>>   extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
>>>>                          unsigned long addr, pmd_t *pmdp);
>>>> -extern int hash__has_transparent_hugepage(void);
>>>
>>> Without some of these helpers in place, I assume actually using PMD leafs
>>> without THP would require some more work. (which is not the goal of this series,
>>> just asking).
>>
>> Yes, you're right.
>>
>>> I do wonder whether the architecture should instead simply say "not supported"
>>> if !CONFIG_TRANSPARENT_HUGEPAGE?
>>>
>>> That should still enable your series: using mTHP without PMD support.
>>
>> Yes, it would. However, I think this introduces an inconsistency.
> 
> powerpc has two types of MMU (HASH and RADIX) with different page layout. MMU type is selected at boottime based on the capabilities of the CPU. For transparent page you have:
> 
> static inline int has_transparent_hugepage(void)
> {
>      if (radix_enabled())
>          return radix__has_transparent_hugepage();
>      return hash__has_transparent_hugepage();
> }

Right and, unless I'm misunderstanding your comment, this supports my
position that the new arch_has_pmd_leaves() API is all about reporting a
hardware capability and not tied to THP support.

> 
>>
>> In in its current form, arch_has_pmd_leaves() should always report a hardware
>> capability. This is true even for the default case where
>> arch_has_pmd_leaves() defaults to
>> IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE) in the assumption that
>> archs supporting PMD-sized pages by default will have this config
>> enabled.
>>
>> Your suggestion will change this and for some archs
>> arch_has_pmd_leaves() may have different behavior depending on the user
>> configuration. Additionally, I intended to decouple the base API
>> implementation from THP.
>>
>> If you feel strongly about this I can implement your suggestion, but I'd
>> still vote for keeping the API about consistently reporting the hardware
>> capability. Even if the only user is THP code today, new use cases can
>> be added incrementally.
>>
>>>
>>> [...]
>>>
>>>> -static inline int radix__has_transparent_hugepage(void)
>>>> +static inline int radix__has_transparent_pud_hugepage(void)
>>>>   {
>>>> -    /* For radix 2M at PMD level means thp */
>>>> -    if (mmu_psize_defs[MMU_PAGE_2M].shift == PMD_SHIFT)
>>>> +    /* For radix 1G at PUD level means pud hugepage support */
>>>> +    if (mmu_psize_defs[MMU_PAGE_1G].shift == PUD_SHIFT)
>>>>           return 1;
>>>>       return 0;
>>>>   }
>>>> +#endif
>>>> -static inline int radix__has_transparent_pud_hugepage(void)
>>>> +static inline int radix__has_transparent_hugepage(void)
>>>>   {
>>>> -    /* For radix 1G at PUD level means pud hugepage support */
>>>> -    if (mmu_psize_defs[MMU_PAGE_1G].shift == PUD_SHIFT)
>>>> +    /* For radix 2M at PMD level means thp */
>>>> +    if (mmu_psize_defs[MMU_PAGE_2M].shift == PMD_SHIFT)
>>>>           return 1;
>>>>       return 0;
>>>>   }
>>>
>>> You are swapping both implementations, which might create some unnecessary churn
>>> I think.
>>
>> I suspect this was done by git diff as I just moved the functions, but
>> I'll take a better look.
>>
> 


