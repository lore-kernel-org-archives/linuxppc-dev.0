Return-Path: <linuxppc-dev+bounces-28945-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51818CA5FF0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Oct 2026 04:48:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hzP0G3NsVz2yKn;
	Tue, 06 Oct 2026 15:48:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791262110;
	cv=none; b=IVIDvMaWb9EazFJoJKMQ7zvBBqyCROo99dDFRwwOVp2lNEcHHGTVgtjTg0fwaFWD8V0nHFu+OcHGjTmOsxFtY3cSuHyxhJFIuOT1qdnouu1Y0Z3iXyXxsjO1xRAscfLXbK3nozG3XjYLJiSZLyghylV5dqhSK5N9q6Td0+2C2Ux6+byRYY0u2JmP6owmN6LTKwM5iQHsXJw+lH/PjsaaD916yYPDxhA+hWYQIrnsLwc+xpF/jieQEJn2qLe4owYlxTLRIlnkZiq2VZ3aYj30Fjuz6L7Yeb5ihDTeB/TObEbeyLZI05aqqQSqp9KUlSp2ceDr6wjlypd26Lmf5JkrbA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791262110; c=relaxed/relaxed;
	bh=tUGgZYKffjWTe3V1ODHloSUeuNia8mWQRgDKRJsPR88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9emEQIkRns7RHOI3z0/TdQXZ3gm9WKBc65N5619UNykjbCeDUkrRESpLQ1lhcdZIKKI7jzFRg+UPWbnAAXZGjeuc5FXIYc6433c/XsW5p6nNYzRyKaSu4qLy/wsJNFnV5kdCisYHoEfj9R4gqq8hBfAULUlhoeB/f1hO7Jc4IjMS0iwe7M4wmvIQby96B+CmVgSqQFedbHAnn7acvwdbg+/MeOGH0CqqPXeRqFtPYvWuAY6ne5jx07/ZN4PxfBa6vUGeANAR7dz3LnPr9RUPd58n/tH0tT4qmx5YkfFiPpSq0fHPiDUgmz0e2rK4oNBX/zLlL8amXyW9Rl7yABDOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsEA5ZIq; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsEA5ZIq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hzP0F1Kynz2xnv
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Oct 2026 15:48:29 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 960574011D;
	Tue,  6 Oct 2026 04:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED441F000FF;
	Tue,  6 Oct 2026 04:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791262106;
	bh=tUGgZYKffjWTe3V1ODHloSUeuNia8mWQRgDKRJsPR88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OsEA5ZIqc/mPpRuhVowK4aw5jZ8eghvG7y0Pp/YXBR799iq/5qLtwCKODGdbYAjzM
	 mMXUwyZf8+0AyuHCOc9vOWN9viyle94GLCVlRkWzUvi4zF21a9PSK3aJ30kTwgcLoL
	 ZZhZfsMaHYTn+Ck7xOGxLqIF4KxoC54rxa/LhhG/yTxa1XWlKlSf37XVww0D+W5SUA
	 D+VqK62OHKXSYn7pfH1ldc0KsdhaMoM+FG6g1vW1gUX1JDaH/VXzVKDeLpCG6xqUPz
	 TibpvnDRZdCfT7m93htEvTZBXn4mc1H9WcjWwqJozM8WDuSjmZi2c9RZzrGvx8TGAX
	 ggrfME3ZVs2Qw==
Message-ID: <3d358c88-e0a9-47c5-a7a9-74edcf5e4cfb@kernel.org>
Date: Tue, 6 Oct 2026 06:48:05 +0200
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
 <802564f8-1376-451e-8308-6f98d1efb099@kernel.org>
 <9adb6aaf-6e50-4ab0-a021-2529807dff02@redhat.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <9adb6aaf-6e50-4ab0-a021-2529807dff02@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/10/2026 à 22:40, Luiz Capitulino a écrit :
> 
> 
> On 10/5/26 12:52 AM, Christophe Leroy (CS GROUP) wrote:
>> Hi,
>>
>> Don't forget <linuxppc-dev@lists.ozlabs.org> when you address powerpc 
>> architecture.
> 
> Will do.
> 
>>
>> Le 03/10/2026 à 17:44, Luiz Capitulino a écrit :
>>>
>>>
>>> On 10/2/26 3:28 PM, David Hildenbrand (Arm) wrote:
>>>> On 9/18/26 03:45, Luiz Capitulino wrote:
>>>>> A future commit will introduce a kernel API to allow for checking 
>>>>> if the
>>>>> CPU supports PMD-sized pages. This API will be based on the
>>>>> has_transparent_hugepage() implementation but will be orthogonal to 
>>>>> THP
>>>>> and therefore must work when CONFIG_TRANSPARENT_HUGEPAGE=n.
>>>>>
>>>>> Move its definition out of the THP guard.
>>>>>
>>>>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>>>>> ---
>>>>>   arch/powerpc/include/asm/book3s/64/hash-4k.h  |  2 +-
>>>>>   arch/powerpc/include/asm/book3s/64/hash-64k.h |  2 +-
>>>>>   arch/powerpc/include/asm/book3s/64/pgtable.h  | 18 ++++++++ 
>>>>> +---------
>>>>>   arch/powerpc/include/asm/book3s/64/radix.h    | 14 +++++++-------
>>>>>   arch/powerpc/mm/book3s64/hash_pgtable.c       |  4 ++--
>>>>>   5 files changed, 20 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/ 
>>>>> powerpc/include/asm/book3s/64/hash-4k.h
>>>>> index 8e5bd9902bed..79511e6abfca 100644
>>>>> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
>>>>> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>>>>> @@ -165,9 +165,9 @@ extern void 
>>>>> hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
>>>>>   extern pgtable_t hash__pgtable_trans_huge_withdraw(struct 
>>>>> mm_struct *mm, pmd_t *pmdp);
>>>>>   extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
>>>>>                          unsigned long addr, pmd_t *pmdp);
>>>>> -extern int hash__has_transparent_hugepage(void);
>>>>>   #endif
>>>>> +extern int hash__has_transparent_hugepage(void);
>>>>>   #endif /* !__ASSEMBLER__ */
>>>>>   #endif /* _ASM_POWERPC_BOOK3S_64_HASH_4K_H */
>>>>> diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/ 
>>>>> powerpc/include/asm/book3s/64/hash-64k.h
>>>>> index 7deb3a66890b..a4a44a112ff9 100644
>>>>> --- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>>>> +++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
>>>>> @@ -278,9 +278,9 @@ extern void 
>>>>> hash__pgtable_trans_huge_deposit(struct mm_struct *mm, pmd_t *pmdp,
>>>>>   extern pgtable_t hash__pgtable_trans_huge_withdraw(struct 
>>>>> mm_struct *mm, pmd_t *pmdp);
>>>>>   extern pmd_t hash__pmdp_huge_get_and_clear(struct mm_struct *mm,
>>>>>                          unsigned long addr, pmd_t *pmdp);
>>>>> -extern int hash__has_transparent_hugepage(void);
>>>>
>>>> Without some of these helpers in place, I assume actually using PMD 
>>>> leafs
>>>> without THP would require some more work. (which is not the goal of 
>>>> this series,
>>>> just asking).
>>>
>>> Yes, you're right.
>>>
>>>> I do wonder whether the architecture should instead simply say "not 
>>>> supported"
>>>> if !CONFIG_TRANSPARENT_HUGEPAGE?
>>>>
>>>> That should still enable your series: using mTHP without PMD support.
>>>
>>> Yes, it would. However, I think this introduces an inconsistency.
>>
>> powerpc has two types of MMU (HASH and RADIX) with different page 
>> layout. MMU type is selected at boottime based on the capabilities of 
>> the CPU. For transparent page you have:
>>
>> static inline int has_transparent_hugepage(void)
>> {
>>      if (radix_enabled())
>>          return radix__has_transparent_hugepage();
>>      return hash__has_transparent_hugepage();
>> }
> 
> Right and, unless I'm misunderstanding your comment, this supports my
> position that the new arch_has_pmd_leaves() API is all about reporting a
> hardware capability and not tied to THP support.

Yes my comment was in reaction of comment below, I wanted to say that 
CONFIG_TRANSPARENT_HUGEPAGE is not always enough to tell if a powerpc 
actually has transparent hugepages or not.

 >>>> I do wonder whether the architecture should instead simply say "not
 >>>> supported"
 >>>> if !CONFIG_TRANSPARENT_HUGEPAGE?
 >>>>
 >>>> That should still enable your series: using mTHP without PMD support.


