Return-Path: <linuxppc-dev+bounces-28903-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643DECA5FF5
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Oct 2026 04:52:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyn7b2xF1z2yf9;
	Mon, 05 Oct 2026 15:52:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791175963;
	cv=none; b=jGi7yPwf1kQcAYnLpWeJAF0FpPv3ly7yQsquM0DdQsTu7YtSQ5B3BMdaDs617ehvel8xTvyffFWDEQU9u7KooRvPeRvbyIWia7sjJQFJbL/+toHc3PgjVDwWQ11MBWicxwH9hhbll6eB4v3uqHsx1hjKxNgBzuxbUPwQFUDA2BGDan7lPkvnkWtTnsrrYbskxKKMirZf+nHhY58N5LMpqoXrmHXMI/SlSUMzvCdLyNb4CRaXWtXCRJ1g1FakPGzjwsAozQmRi/vWw3PbLUEeyr5BBWtUIOj5h04PInachQh96TLp4nvZtV2JdGepqwmVKxCNJ9GO5NC2b1Pv/EyltA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791175963; c=relaxed/relaxed;
	bh=tgeHzxHQ5p6pOK3o0bpbw4gdkXFbQVK+Bxib4DUA518=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lpv68asDPIPzUbxGhpi3ibne37xbc9kBrMudieUaFceJlwJDe0qezwBPqH2mHd6yb9DsYgljRkc00c1pCXLI8Y056INwUeXa7uZxRXJPJYvtyKM8aFGnqY3KfBLMzzCknrf9hhuRb4Il+8P86gesINoERT0Le5ldBexLnxNn9Ww/HFBNTDvIq4hGFXiAJZ9SfDE7FMoxKjeaTlFiOmGH7eByJxvpnj/EQbyRAjo6GcYy+VfJTwjDpNZ0WyLnxfGLoWjXIoNII6QDBZL8RjfAtJL8ftRIu1f1+x0WvBXRvQHd0/cCgpOxHaCFzBH55dvBKdOFeUMkzxp547qysnIC/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LhZ6DkPv; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LhZ6DkPv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyn7Z0nCDz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Oct 2026 15:52:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 203E16022A;
	Mon,  5 Oct 2026 04:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5D41F000FF;
	Mon,  5 Oct 2026 04:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791175957;
	bh=tgeHzxHQ5p6pOK3o0bpbw4gdkXFbQVK+Bxib4DUA518=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LhZ6DkPvu/CoOBPRzNG1DhOEHHqlaVdsmXRzBnLlEWnqCFfpAYuceGVUNQJZHlMuw
	 gkb/KIz5DgdHFfKYiBPx8QuVQNXYD8LSlJ5OK6ropaAG1n2cCrJgVtuXxTj9UGkDGY
	 d00j8TypicLptK30ZVNnCZ2jX5SXvK3pcVZ51LPYkHFhFP0Ze+emPMgtSYd7G16iJt
	 RnGJh0g0MDV/SMpvPWhceAou17U6VDzcQ0cW8VS/qk0g8elN6DSO5TICcWZ0EHI5OE
	 BE7c+JgxsEYYhR+ukWXBWPn4i3yuYyrKmgx7HBJFbmzU2HQ1BvceG9BrIQ3Gg5akks
	 ac6+o05tU/D+w==
Message-ID: <802564f8-1376-451e-8308-6f98d1efb099@kernel.org>
Date: Mon, 5 Oct 2026 06:52:26 +0200
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
To: Luiz Capitulino <luizcap@redhat.com>,
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
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <25bb02df-a795-4e48-9de6-99f1ca799176@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Don't forget <linuxppc-dev@lists.ozlabs.org> when you address powerpc 
architecture.

Le 03/10/2026 à 17:44, Luiz Capitulino a écrit :
> 
> 
> On 10/2/26 3:28 PM, David Hildenbrand (Arm) wrote:
>> On 9/18/26 03:45, Luiz Capitulino wrote:
>>> A future commit will introduce a kernel API to allow for checking if the
>>> CPU supports PMD-sized pages. This API will be based on the
>>> has_transparent_hugepage() implementation but will be orthogonal to THP
>>> and therefore must work when CONFIG_TRANSPARENT_HUGEPAGE=n.
>>>
>>> Move its definition out of the THP guard.
>>>
>>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>>> ---
>>>   arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 +-
>>>   arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 +-
>>>   arch/powerpc/include/asm/book3s/64/pgtable.h  | 18 +++++++++---------
>>>   arch/powerpc/include/asm/book3s/64/radix.h    | 14 +++++++-------
>>>   arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 ++--
>>>   5 files changed, 20 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/ 
>>> powerpc/include/asm/book3s/64/hash-4k.h
>>> index 8e5bd9902bed..79511e6abfca 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>>> @@ -165,9 +165,9 @@ extern void 
>>> hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
>>>   extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct 
>>> *mm, pmd_t *pmdp);
>>>   extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
>>>                          unsigned long addr, pmd_t *pmdp);
>>> -extern int hash__has_transparent_hugepage(void);
>>>   #endif
>>> +extern int hash__has_transparent_hugepage(void);
>>>   #endif /* !__ASSEMBLER__ */
>>>   #endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
>>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/ 
>>> powerpc/include/asm/book3s/64/hash-64k.h
>>> index 7deb3a66890b..a4a44a112ff9 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>> @@ -278,9 +278,9 @@ extern void 
>>> hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
>>>   extern pgtable_t hash__pgtable_trans_huge_withdraw(struct mm_struct 
>>> *mm, pmd_t *pmdp);
>>>   extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
>>>                          unsigned long addr, pmd_t *pmdp);
>>> -extern int hash__has_transparent_hugepage(void);
>>
>> Without some of these helpers in place, I assume actually using PMD leafs
>> without THP would require some more work. (which is not the goal of 
>> this series,
>> just asking).
> 
> Yes, you're right.
> 
>> I do wonder whether the architecture should instead simply say "not 
>> supported"
>> if !CONFIG_TRANSPARENT_HUGEPAGE?
>>
>> That should still enable your series: using mTHP without PMD support.
> 
> Yes, it would. However, I think this introduces an inconsistency.

powerpc has two types of MMU (HASH and RADIX) with different page 
layout. MMU type is selected at boottime based on the capabilities of 
the CPU. For transparent page you have:

static inline int has_transparent_hugepage(void)
{
	if (radix_enabled())
		return radix__has_transparent_hugepage();
	return hash__has_transparent_hugepage();
}

> 
> In in its current form, arch_has_pmd_leaves() should always report a 
> hardware
> capability. This is true even for the default case where
> arch_has_pmd_leaves() defaults to
> IS_ENABLED(CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE) in the assumption that
> archs supporting PMD-sized pages by default will have this config
> enabled.
> 
> Your suggestion will change this and for some archs
> arch_has_pmd_leaves() may have different behavior depending on the user
> configuration. Additionally, I intended to decouple the base API
> implementation from THP.
> 
> If you feel strongly about this I can implement your suggestion, but I'd
> still vote for keeping the API about consistently reporting the hardware
> capability. Even if the only user is THP code today, new use cases can
> be added incrementally.
> 
>>
>> [...]
>>
>>> -static inline int radix__has_transparent_hugepage(void)
>>> +static inline int radix__has_transparent_pud_hugepage(void)
>>>   {
>>> -    /* For radix 2M at PMD level means thp */
>>> -    if (mmu_psize_defs[MMU_PAGE_2M].shift == PMD_SHIFT)
>>> +    /* For radix 1G at PUD level means pud hugepage support */
>>> +    if (mmu_psize_defs[MMU_PAGE_1G].shift == PUD_SHIFT)
>>>           return 1;
>>>       return 0;
>>>   }
>>> +#endif
>>> -static inline int radix__has_transparent_pud_hugepage(void)
>>> +static inline int radix__has_transparent_hugepage(void)
>>>   {
>>> -    /* For radix 1G at PUD level means pud hugepage support */
>>> -    if (mmu_psize_defs[MMU_PAGE_1G].shift == PUD_SHIFT)
>>> +    /* For radix 2M at PMD level means thp */
>>> +    if (mmu_psize_defs[MMU_PAGE_2M].shift == PMD_SHIFT)
>>>           return 1;
>>>       return 0;
>>>   }
>>
>> You are swapping both implementations, which might create some 
>> unnecessary churn
>> I think.
> 
> I suspect this was done by git diff as I just moved the functions, but
> I'll take a better look.
> 



