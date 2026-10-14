Return-Path: <linuxppc-dev+bounces-29466-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A196ECC6B27
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 09:01:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4QDl6qM2z2yLY;
	Wed, 14 Oct 2026 20:01:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791968503;
	cv=none; b=P3Uerc1NpZ0A7He3TPn9O2FG5VWQ7CmSzdO6H03VjwZVkptyQ1tnYjz57v6D55vEi8dXtF6CUA2PkZ6LZn/WD49EbID0YW3CjGatY7g2vT8ixOlasctxWslPLn2zBibUKsyHatZLFmGOYYVX9KmXdEHC0cXXQw7XyE/DCc2cQhtZj+LxjGxQKVOQQd4jQHJv02t7NFDhT8hemIPozoSAG8HSc9/xED+lSByWe+qypyYEpE7MzDH/lTaf3RuSAO7cRCPntmRkYvgg++Dz5l+0+xlM1wfUE4+XGgFIkletoBTmG8TdiSKbGLaGmdWSYYIlJ689MJTzfCyIayBYMp7paQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791968503; c=relaxed/relaxed;
	bh=w6d1ZGliYPhieSuvjGZO3kxTg3x67TSdLveb34MEzAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3scGQS927+/B06rtvW08sIjV7V4h/amvTfK8tL97fJ7X9O+Mzo93V1oOKdR3p5zpF2ThYkMHV8WXbs7Rhepr4M0meDqmcQ0xAlh0TRM4iM3AxFNYFzhOsu/esCRlkK7yEY0LgmD1oxkNvxmLe+TLDVRTGDjoL2QGAhtxpDmZJSigGH/1YGGob9fda9i9B7szjzX6oGZgser9yfGaraF/7XM/ZiAapE5q4JZQTUnW1WOQePypx4rNeQvTUiB0+vYx3mTkk64xG0mfbGA9J0ePKfrIIFSU1aVYqUREtm7vwOTmxys3ZbzwS0ByPjSSJ5WjzbX7wgPG3tby4aBy2YF8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com; dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=pQFtufiM; dkim-atps=neutral; spf=pass (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org) smtp.mailfrom=arm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=pQFtufiM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arm.com (client-ip=217.140.110.172; helo=foss.arm.com; envelope-from=dev.jain@arm.com; receiver=lists.ozlabs.org)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4QDk6Gdlz2yK7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 20:01:42 +1100 (AEDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 865661596;
	Wed, 14 Oct 2026 02:01:07 -0700 (PDT)
Received: from [10.164.19.62] (unknown [10.164.19.62])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9B7A3F7B4;
	Wed, 14 Oct 2026 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791968470; bh=rara4mkQth8pYyWlFJvWmDaJu5z0cXsBOp7HoWDPrJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pQFtufiMGehtJM9AcAsnwXLGqTJECDqjyuBHqaMUB/gJ0L3WUOI5EUTEsk2dHjdsf
	 R99tb64LVgVWafMjWaPf3mdnd4dVDS58qabNcRdPk/FvmuqeNwUiGSRcWLC3RtnKhS
	 UFcMMAZVO7L2zOSVKereOgmlQX/zL1pbdiQBv3Ng=
Message-ID: <e0354457-8ca4-474d-b8cc-0ba843be8897@arm.com>
Date: Wed, 14 Oct 2026 14:31:02 +0530
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
Subject: Re: [PATCH v10 01/10] arm64/mm: add pte_set_huge() and
 pte_clear_huge()
To: Wen Jiang <jiangwenxiaomi@gmail.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, linux-mm@kvack.org,
 urezki@gmail.com, will@kernel.org, Xueyuan.chen21@gmail.com,
 ajd@linux.ibm.com, anshuman.khandual@arm.com, baohua@kernel.org,
 chleroy@kernel.org, david@kernel.org, jiangwen6@xiaomi.com, leo.yan@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, rppt@kernel.org, ryan.roberts@arm.com
References: <20261002090947.869220-1-jiangwen6@xiaomi.com>
 <20261002090947.869220-2-jiangwen6@xiaomi.com>
 <7b3c3a39-4cf3-430d-9fd3-ba83e5175e72@arm.com>
 <CAHKocdFOoDhjcuWXJatQ-AbSXyXuV+Q=sA1-iGiGrp7vhHZMBQ@mail.gmail.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <CAHKocdFOoDhjcuWXJatQ-AbSXyXuV+Q=sA1-iGiGrp7vhHZMBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 14/10/26 2:16 pm, Wen Jiang wrote:
> On Wed, 14 Oct 2026 at 14:03, Dev Jain <dev.jain@arm.com> wrote:
>>
>>
>>
>> On 02/10/26 2:39 pm, Wen Jiang wrote:
>>> vmap installs PTE-level block mappings (PTE_CONT on arm64) by reusing
>>> set_huge_pte_at() and huge_ptep_get_and_clear(), which are HugeTLB
>>> helpers gated by CONFIG_HUGETLB_PAGE. This makes the feature silently
>>> unavailable on CONFIG_HUGETLB_PAGE=n kernels and couples mm/vmalloc.c to
>>> HugeTLB internals it does not otherwise need.
>>>
>>> Add pte_set_huge()/pte_clear_huge() to arm64, joining the existing
>>> pmd_set_huge()/pud_set_huge() family in mm/mmu.c. They build on
>>> __set_ptes() and __get_and_clear_full_ptes() directly, so they do not
>>> depend on CONFIG_HUGETLB_PAGE.
>>>
>>> There is no caller yet: mm/vmalloc.c is converted later in this series,
>>> once the generic fallbacks are in place.
>>>
>>> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
>>> Reviewed-by: Barry Song <baohua@kernel.org>
>>> ---
>>>  arch/arm64/include/asm/pgtable.h |  6 ++++++
>>>  arch/arm64/mm/mmu.c              | 23 +++++++++++++++++++++++
>>>  2 files changed, 29 insertions(+)
>>>
>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>> index 6000905a2e865..9b762eb68cff0 100644
>>> --- a/arch/arm64/include/asm/pgtable.h
>>> +++ b/arch/arm64/include/asm/pgtable.h
>>> @@ -1978,6 +1978,12 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
>>>
>>>  #endif /* CONFIG_ARM64_CONTPTE */
>>>
>>> +#define __HAVE_ARCH_PTE_SET_HUGE
>>> +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
>>> +               pgprot_t prot, unsigned long size);
>>> +#define __HAVE_ARCH_PTE_CLEAR_HUGE
>>> +pte_t pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size);
>>> +
>>>  #endif /* !__ASSEMBLER__ */
>>>
>>>  #endif /* __ASM_PGTABLE_H */
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 79d90226fd5dc..ae2f15618c97d 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -1912,6 +1912,29 @@ int pmd_clear_huge(pmd_t *pmdp)
>>>       return 1;
>>>  }
>>>
>>> +void pte_set_huge(pte_t *ptep, unsigned long addr, phys_addr_t phys,
>>> +               pgprot_t prot, unsigned long size)
>>> +{
>>> +     unsigned long pfn = __phys_to_pfn(phys);
>>> +     pte_t pte = pte_mkcont(pfn_pte(pfn, prot));
>>> +     unsigned int nr = size >> PAGE_SHIFT;
>>> +
>>> +     VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));
>>> +     VM_WARN_ON(!IS_ALIGNED(addr, CONT_PTE_SIZE));
>>> +     VM_WARN_ON(!IS_ALIGNED(pfn, CONT_PTES));
>>> +
>>> +     /* For vmap, there is no valid -> valid transition */
>>> +     VM_WARN_ON(pte_valid(__ptep_get(ptep)));
>>> +
>>> +     __set_ptes(&init_mm, addr, ptep, pte, nr);
>>> +}
>>> +
>>> +pte_t pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size)
>>> +{
>>> +     return __get_and_clear_full_ptes(&init_mm, addr, ptep,
>>> +                                      size >> PAGE_SHIFT, 0);
>>> +}
>>
>> I think we should have the same VM_WARN_ON() checks here, as for
>> pte_clear_huge(), in addition to also warning for
>> current->mm != &init_mm.
>>
>> We should make it clear that pte_clear_huge() gets called only for
>> kernel mappings, and the range we operate on is definitely an aligned
>> CONT range - which is why we do not go through get_and_clear_full_ptes ->
>> contpte_get_and_clear_full_ptes, and possibly contpte_try_unfold(), but
>> directly use __get_and_clear_full_ptes.
>>
> 
> Hi Dev,
> 
> I'll add the alignment VM_WARN_ON() checks to pte_clear_huge() to
> match pte_set_huge().
> 
> Regarding the current->mm != &init_mm check: these functions don't take
> an mm parameter -- &init_mm is hardcoded in the function body.
> current->mm would never equal &init_mm in practice: for user processes it
> points to the process's own mm, and for kernel threads it is NULL.
> So VM_WARN_ON(current->mm != &init_mm) would always fire.

Right.


> 
> The existing hugetlb helpers that vmalloc used before this decoupling
> (huge_ptep_get_and_clear -> get_clear_contig) also take mm as a
> parameter
> and don't check current->mm either -- the caller simply passes &init_mm.
> 
> How about adding a comment to make the "kernel mapping only" intent
> more explicit?
> Something like:

I think then we should just call the functions vmap_pte_set_huge and
vmap_pte_clear_huge. In arm64 we have init_pte() which sets the cont bit
at init time for kernel mappings. So to differentiate I think we should
prefix the function name by vmap.


> 
>  pte_t pte_clear_huge(pte_t *ptep, unsigned long addr, unsigned long size)
>  {
> +       /* Kernel mappings only */
> +
> +       VM_WARN_ON(!IS_ALIGNED(size, CONT_PTE_SIZE));
> +       VM_WARN_ON(!IS_ALIGNED(addr, CONT_PTE_SIZE));
> +
>         return __get_and_clear_full_ptes(&init_mm, addr, ptep,
>                                          size >> PAGE_SHIFT, 0);
>  }
> 
> Thanks,
> Wen


