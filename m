Return-Path: <linuxppc-dev+bounces-27688-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC85BC982DA
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 09:11:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmRgl0zl6z2y7r;
	Fri, 18 Sep 2026 19:11:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789722675;
	cv=none; b=eeXbLtcVJcwuPcjt7FoAgP9ioDoDL34FqCPbazVy+B+aVG6ebYnqHr5ECl90vyN891EqsKjXaKFyQx740M9h9K101Kr7RsgOm5yjbQML6CUY3Gze2PJNZCyq4DUVX6HsKEXEbo3FkE7W+oh4R/o6WCJHhziwipGlWAfK1avd1BmxG9Y5JCepsYWabEPGcppXwWzJ2Oupu0TVRV+8CV2i1Ah3irq4Ix7y2Ix0g1lKWP84vi5r8EEi6BuxnQ24gcYXwJltsW3ZwWTdz9gcGZe+xYw6dCCTZdibzG1B66Xy0Yd0CZG1xTYjWuWW+jMmAzbpg/wuCeZt/6GPFvmssInlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789722675; c=relaxed/relaxed;
	bh=dG/NQKkV41YhIgrIyd1kGa7K3ptoEDA2CGGt3WrAYAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZepI2flFugrbHHlOFT+C4oUp4OH3Yl1wfWnwLXSrw1SRY93xaEkdNGFmDeSE65efK9SSOW/egxoJXuu8ylzSNJKge5J1G+9BsciFHokL1jhvakCQ5POnm7/kcfDnHVTqByxfwYjzreoU5tX0Cs9CzSMk+AaVjzhMSa7eNPIvENO+hFS5JMiTh594w7SsDfI3ci165IZ9MMjiTxw72lqu6DbNkeKFx6cvj2UXf7sJ+rQ0D+C4Nc4c5Ra6DyJtFyyGQ1lSG6h9dBGzz3b9gcZ0ty/aJdbbqL5sTAFQkEpNpj51GTEbNsAsj271g4sLSoz7Tf7ypCcuOEAEUYDPRvBPlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcgVFMee; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FcgVFMee;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmRgk1fvVz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 19:11:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id C426E40193;
	Fri, 18 Sep 2026 09:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECAB21F00893;
	Fri, 18 Sep 2026 09:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789722671;
	bh=dG/NQKkV41YhIgrIyd1kGa7K3ptoEDA2CGGt3WrAYAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=FcgVFMee+7sqAMMPEXTmkt4Ce4EqkYw/71EiqfiHMdlyb3ofAgUVEqi1SAGuiQ3IP
	 Z0xlcRWx8VoB9qokS9t1VxTzx+gFGV7kzSxOxWThG/a+ERFdVpq0rr8yxZHwIn13VO
	 Bb1ni3BbkCkjdpaUZ9NQhibPREdVJFxI5PdG4QQsfiEdcTiJtgLkIoYXypHnLI+YJu
	 a0WQ54kX1lr8qictRHrNQUoz5VfQmxDrLrTCuHaabztx3f33sw14YBlKYxpxlu1Leh
	 tYGkxMvWrqr2maFU8Z9S6g1dGkY0GDCwjiP539adNBTTDrEFmRIaQ3qZ5whpL33YE5
	 J8D58mL5RX1Dw==
Message-ID: <930f3db4-9034-4a48-98b2-07a44de3a718@kernel.org>
Date: Fri, 18 Sep 2026 11:11:04 +0200
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
Subject: Re: [PATCH v8 02/10] powerpc/8xx: add pte_set_huge()
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
 <20260917052933.188679-3-jiangwenxiaomi@gmail.com>
 <58e3b456-7389-4752-8de5-1cc82964c3c7@kernel.org>
 <CAGsJ_4wKG91hd1Y3W4mbdh6B8Kq09JyDjyvXeeCmQj+L6bHm2A@mail.gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <CAGsJ_4wKG91hd1Y3W4mbdh6B8Kq09JyDjyvXeeCmQj+L6bHm2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 18/09/2026 à 10:44, Barry Song a écrit :
> On Fri, Sep 18, 2026 at 2:14 PM Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
>>
>>
>>
>> Le 17/09/2026 à 07:29, Wen Jiang a écrit :
>>> From: Wen Jiang <jiangwen6@xiaomi.com>
>>>
>>> vmap installs PTE-level block mappings (SZ_16K/SZ_512K on powerpc/8xx)
>>> by reusing set_huge_pte_at(), a HugeTLB helper gated by
>>> CONFIG_HUGETLB_PAGE. This makes the feature silently unavailable on
>>> CONFIG_HUGETLB_PAGE=n kernels and couples mm/vmalloc.c to HugeTLB
>>> internals it does not otherwise need.
>>>
>>> Add pte_set_huge() to powerpc/8xx, next to the existing
>>> pmd_clear_huge()/pud_clear_huge() in mm/nohash/8xx.c. It builds the huge
>>> PTE and writes it into the backing cells directly, without going through
>>> set_huge_pte_at(), so it does not depend on CONFIG_HUGETLB_PAGE.
>>>
>>> No pte_clear_huge() is needed: 8xx does not implement
>>> arch_vmap_pte_range_unmap_size(), so the vmap unmap path never takes the
>>> block-mapping branch.
>>>
>>> In practice PPC_8xx selects HUGETLBFS unconditionally, so
>>> CONFIG_HUGETLB_PAGE=n does not occur there today; this is a decoupling
>>> cleanup rather than a new configuration.
>>
>> 8xx selects CONFIG_HUGETLB_PAGE because it uses set_huge_pte_at() to map
>> kernel text with large pages. That was added by commit 34536d780683
>> ("powerpc/8xx: Add a function to early map kernel via huge pages")
>>
>> But now pte_set_huge() could be used instead in
>> __early_map_kernel_hugepage() and then CONFIG_HUGETLB_PAGE could be removed.
> 
> Hi Christophe,
> 
> Do you mean the code below? If so, it sounds like a good place to
> clean this up for powerpc as a separate cleanup patch.

Yes this is what I have in mind allthough I have not studied it in details.

> 
> diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
> index 2518d2a6bdb4..830cdb391161 100644
> --- a/arch/powerpc/mm/nohash/8xx.c
> +++ b/arch/powerpc/mm/nohash/8xx.c
> @@ -87,9 +87,7 @@ static int __ref
> __early_map_kernel_hugepage(unsigned long va, phys_addr_t pa,
>          if (WARN_ON(!ptep))
>                  return -ENOMEM;
> 
> -       set_huge_pte_at(&init_mm, va, ptep,
> -                       arch_make_huge_pte(pfn_pte(pa >> PAGE_SHIFT,
> prot), shift, 0),
> -                       1UL << shift);
> +       pte_set_huge(ptep, va, pa, prot, 1UL << shift);
> 
>          return 0;
>   }
> diff --git a/arch/powerpc/platforms/Kconfig.cputype
> b/arch/powerpc/platforms/Kconfig.cputype
> index f0adbf7ecb7f..efba4d960083 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -41,7 +41,6 @@ config PPC_8xx
>          select FSL_SOC
>          select PPC_KUEP
>          select HAVE_ARCH_VMAP_STACK
> -       select HUGETLBFS
> 
>   config 44x
>          bool "AMCC 44x, 46x or 47x"
> 
>>
>>>
>>> There is no caller yet: mm/vmalloc.c is converted later in this series,
>>> once the generic fallbacks are in place.
>>>
>>> Signed-off-by: Wen Jiang <jiangwen6@xiaomi.com>
>>
>> Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> 
> Best Regards
> Barry


