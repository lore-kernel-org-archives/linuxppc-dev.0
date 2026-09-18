Return-Path: <linuxppc-dev+bounces-27663-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77185C982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 07:04:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmNs42Yqmz2y2W;
	Fri, 18 Sep 2026 17:04:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789715048;
	cv=none; b=TGOEAy65vgeODB0/A9GrvF+4BXrAoXEufKWMg5KKTycwRFe0UGlLVvGOq48359P1Wd00nffGCl1OdKidn0rykNxpFiDlYGAruhMZTzLb9C/B+O1xPsqGKC0BAwrvBsRxxS1Rx9YzrnWKWhrnAAH4DgGIa/sGMGNkvlHSL7bV8f9x0/3o3iLaST5sHLIpZPjCbEBv6O3UTd4dPumTOqLU613DxkVw8KolROOIKvwq+wlais0SHl7Sy8B1JqPJ3HmA/fSHN97Omd5XvolrwzcjweqcGh6dzps6+XbXDmckqo1+gqWMtIpoff6hTXctXrXPu9w4Wl1pUhokU8Mn3g4ttA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789715048; c=relaxed/relaxed;
	bh=C99qchwVmIf8eGzA2KZRAlNCqTMDn2E/1eNOjto5V1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMDgWUXFow3LQxwfbvtti3nQwZe+DolBxqvtFgQ1xEhTYTaBAlp4348xruaMFGMFSKUbi9GfIlxPvIV+CVIwCi9YjJ4GJmgeIMgzTKnCX9bOENwZxSNpCe/k1gcs/YHX9e1v2naHmjA3V6REoGIvx2aCXE3Nb01fpN6NNdqc34GucM5XTbA+M6PBsCpig+9hYpk4fYGrJU4jMIEwPrrDZslo2hTfePGHBl9uoddPxsmqUwdMFyCTxZqCPsZtWeN1lERudnHIZbvI3ao54k0RcLDnE7IRwPPd9ULJvBNaDctdhdfIbzFNdgiatRdgxVn2Li1vX+lBaqbbSnGdwit02w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWKDEaWg; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWKDEaWg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmNs21Z4Wz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 17:04:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D0D1941842;
	Fri, 18 Sep 2026 07:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136851F000FF;
	Fri, 18 Sep 2026 07:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789715043;
	bh=C99qchwVmIf8eGzA2KZRAlNCqTMDn2E/1eNOjto5V1g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jWKDEaWgQ8tOV8amlp5t9MgYwzBijBFVifWz9yuQo8X4L5EFh32Flzu4XXAbDfnGm
	 UDL93p7kB9G3Rd42nYwUtj6uT0m3roRBv2y8vs/mC/hhbavAalLWNzIamZ9CawgJa5
	 pHnOvDOLIlc6CP9lOwT216XgLvfodA7hkiX+FB/0Ct+bfDmyj/AqncmimtUagrt8Eb
	 oF0sbTAHHKTDObi0AO6aHDc2FHQ2Fy45mE5vliTDkO5ZU6YC6Yt14abrG5j+Mj0rNr
	 Yjv8AMXd9/oiS5ceTffHmQV+p3xP+CkZLZuUIpC2CQ619hXKr9pxjr41fijo1ig8F1
	 DgCMlNLI1L+8Q==
Message-ID: <24aedc8c-a5c6-418b-a37e-051f0d6d9fa7@kernel.org>
Date: Fri, 18 Sep 2026 09:03:55 +0200
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
Subject: Re: [PATCH v8 03/10] mm/vmalloc: use pte_set_huge()/pte_clear_huge()
 for PTE-level block mappings
To: Barry Song <baohua@kernel.org>
Cc: Wen Jiang <jiangwenxiaomi@gmail.com>, akpm@linux-foundation.org,
 catalin.marinas@arm.com, linux-mm@kvack.org, urezki@gmail.com,
 will@kernel.org, Xueyuan.chen21@gmail.com, ajd@linux.ibm.com,
 anshuman.khandual@arm.com, david@kernel.org, dev.jain@arm.com,
 jiangwen6@xiaomi.com, leo.yan@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, rppt@kernel.org,
 ryan.roberts@arm.com
References: <20260917052933.188679-1-jiangwenxiaomi@gmail.com>
 <20260917052933.188679-4-jiangwenxiaomi@gmail.com>
 <27072d94-13bf-4bea-948a-d8a67976601e@kernel.org>
 <CAHKocdE_zyUQT459AiTBDzQHk0jh+VpXuSMDdgHjkg-dAkgBNg@mail.gmail.com>
 <CAGsJ_4yJ-KCHbJ9S2GKXfO51KB8g-y2Q_MikqE9-6VesR-RC9Q@mail.gmail.com>
 <2462f67c-f7d3-4eb3-a093-6a338ef49f14@kernel.org>
 <CAGsJ_4zMG6v-ioi8-NhveqowPVAnsHkFCNy_c7+KHDMRW3JH-Q@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAGsJ_4zMG6v-ioi8-NhveqowPVAnsHkFCNy_c7+KHDMRW3JH-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/09/2026 à 08:14, Barry Song a écrit :
> On Fri, Sep 18, 2026 at 2:05 PM Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
>>
>>
>>
>> Le 17/09/2026 à 23:44, Barry Song a écrit :
>>> On Thu, Sep 17, 2026 at 10:41 PM Wen Jiang <jiangwenxiaomi@gmail.com> wrote:
> [...]
> 
>>>>>>
>>>>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>>>>> index cdd68ed3ae1a9..349ced999f959 100644
>>>>>> --- a/include/linux/pgtable.h
>>>>>> +++ b/include/linux/pgtable.h
>>>>>> @@ -2134,6 +2134,35 @@ static inline int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>>>>>>     }
>>>>>>     #endif      /* CONFIG_HAVE_ARCH_HUGE_VMAP */
>>>>>>
>>>>>> +/*
>>>>>> + * PTE-level block mappings for vmap.
>>>>>> + *
>>>>>> + * pte_set_huge() only has to be implemented by architectures whose
>>>>>> + * arch_vmap_pte_range_map_size() can return a size other than PAGE_SIZE.
>>>>>> + */
>>>>>> +#ifndef __HAVE_ARCH_PTE_SET_HUGE
>>>>>> +static inline void pte_set_huge(pte_t *ptep, unsigned long addr,
>>>>>> +                             phys_addr_t phys, pgprot_t prot,
>>>>>> +                             unsigned long size)
>>>>>> +{
>>>>>> +     WARN_ON_ONCE(1);
>>>>>
>>>>> BUILD_BUG_ON() would be better here.
>>>>>
>>>>> It should be possible because fallback arch_vmap_pte_range_map_size()
>>>>> will constant-fold PAGE_SIZE so pte_set_huge() will never be called.
>>>>>
>>>>
>>>> Agreed. These fallbacks exist only to keep the build working on
>>>> architectures with PTE-level block mappings and should never actually
>>>> be reached, so BUILD_BUG_ON() is right. I'll make that change in v9.
>>>>
>>>
>>> I am not quite sure. It won't be called at runtime because
>>> `vmap size`/`unmap size` return `PAGE_SIZE`, so the code won't
>>> reach this branch. But it will still be built.
>>
>> The fallbacks are defined as:
>>
>> #ifndef arch_vmap_pte_range_map_size
>> static inline unsigned long arch_vmap_pte_range_map_size(unsigned long
>> addr, unsigned long end,
>>                                                           u64 pfn, unsigned int max_page_shift)
>> {
>>          return PAGE_SIZE;
>> }
>> #endif
>>
>> #ifndef arch_vmap_pte_range_unmap_size
>> static inline unsigned long arch_vmap_pte_range_unmap_size(unsigned long
>> addr,
>>                                                             pte_t *ptep)
>> {
>>          return PAGE_SIZE;
>> }
>> #endif
>>
>> Therefore in:
>>
>>                   size = arch_vmap_pte_range_unmap_size(addr, pte);
>>                   if (size != PAGE_SIZE) {
>>
>> GCC knows 'size' is const and its value is PAGE_SIZE, so it won't emit
>> the branch at all.
>>
>> It is call constant folding, some explanation here:
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FConstant_folding&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C869dac21f28d45988a3d08df154c225a%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639253088878897551%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Dvtz1%2FAHvAbVYO%2BRaHTOizcD%2FclJ9FqTcWXKMhIFVyw%3D&reserved=0
>>
>>>
>>> So, would a `BUILD_BUG_ON()` trigger a build failure here?
>>
>> It shouldn't, if it does it is a compiled bug or this is because someone
>> has redefined arch_vmap_pte_range_map_size() and not pte_set_huge()
>> which we'd better know at build time rather than at runtime.
> 
> Thanks, Christophe. I was also thinking about compiler optimization. I
> was just a bit worried that we're touching the common MM code, which
> affects almost all architectures, so I'm not quite sure whether this is
> supported by all GCC versions used by those architectures.
> 
> If it is supported by all of them, I agree that `BUILD_BUG_ON()` is a
> perfect approach.

AFAIU this is the assumption made by the kernel, see 
https://docs.kernel.org/process/coding-style.html#conditional-compilation

This is the same compiler, I see no reason why ability to constant-fold 
would be dependant on architecture.

Christophe

