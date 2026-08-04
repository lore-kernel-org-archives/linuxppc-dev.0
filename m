Return-Path: <linuxppc-dev+bounces-25377-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C8C1C55822
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 13:09:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDv5N1Fzgz2yPR;
	Tue, 04 Aug 2026 23:09:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785848968;
	cv=none; b=RK3FQB57WaEZm55JufP8CEVdeiLHlbK6kCWOyntbnfyqyf9H/fjlw+JiEawNse8Uu9sV1QI3BbXtBhihQHQHTbkARTJd74Z76OlX+Ud9zxkqblEyCaDRxkZRjJ61wGuof3qRxm3UyaWmyu+nODbxJFlwsO0CQfJr6ZVObwHj0Ub0EfkJsSMnuJlKcriAETGql4u3w1kpwAYLVncq7WU5vdEJp0v41ZyT6G84pIR97dlXuqFhSonEL2j5phFIfSEwRj5SZ6vcSRY2SV5AWoH0vaW5gTF7mRhqcqTfeYfhyA3P9Zh3dHARS/PCpyoI7lwcioweFH1wGjRylbnuE81Ztw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785848968; c=relaxed/relaxed;
	bh=4f7ucuIUW8vF4hICwF+LuP1Ke4k5i/LOY8wkqoppgQU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bEpt23vlkFqTEUUALE7+Rm7stfUI1H2U4lCSNqjtpqwG1TTqiBgjtCMuJVPOgg02Bht5PeaiM8BVdabIdXxyizG4J4RDkyP+4276zoYAibIwqvjpZkbinxBry9TR6iIS9MCWsRlcCk4IplwQNFzuJAcQRLhIEHeL9BNYhuaDw8WNL+kOz41OsAcY5krcaPbXf1VunU9nc/aGNs3mTyp4Tee7N2vfkz6WnGvxDv4tw7cbgNU2UOutylOsdCluR4ajK6EO3OCzbRHaDyoThk19H1FBEYSqf0EkapTplk8FnYMEVcvk/95Y9lTANdINR3wH1gb11OLvjQDv8dfogmwelA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ui7t6UYn; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ui7t6UYn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDv5L5hj7z2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 23:09:26 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id C209E60A59;
	Tue,  4 Aug 2026 13:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BCF1F000E9;
	Tue,  4 Aug 2026 13:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785848964;
	bh=4f7ucuIUW8vF4hICwF+LuP1Ke4k5i/LOY8wkqoppgQU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=Ui7t6UYnjDGA7jUXdMOZJ6Axzrun5isfzKVm2Uxl2vfraDeFP2914FnkkgGhu02mt
	 voOMjZW+YQ46kAl40nY5yZAVMVTwc2qmAKmCz9LQhk5ulRqhzZ/m3BmyZQAM9NVgx8
	 FwOD9Y8T/fvcC5vlvAad/UEgX4uXdJMGHYQlatXXVZVZd+jSgiNaUDo3eXIDHUpHPb
	 H9f3aviudsPqRTHHXbL4Vk5hI08JKwkf42AE7BMOT0rqjFGPcbbnzBwf1XrdOxPL93
	 HRXzP9YkSZKmWwWsTd+SDFdFB4YbPaM8pEuJ0zHw4olpd2r+ILT02xSPpdClMWKtk7
	 45CLGnbTDgBTw==
Message-ID: <6bd4f498-6699-4d54-a43a-57c954bff958@kernel.org>
Date: Tue, 4 Aug 2026 15:09:13 +0200
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
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH v2 3/6] mm/powerpc/8xx: constify ptep_get() argument
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)"
 <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-4-pfalcato@suse.de> <anHI4B-lMu6AJJfA@lucifer>
 <dcdb8cab-c18c-4995-ad1d-2f2d4700e7c1@kernel.org> <anHgw2Z-d-OQk9qs@lucifer>
Content-Language: fr-FR
In-Reply-To: <anHgw2Z-d-OQk9qs@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/08/2026 à 14:59, Lorenzo Stoakes (ARM) a écrit :
> On Tue, Aug 04, 2026 at 02:50:19PM +0200, Christophe Leroy (CS GROUP) wrote:
>> Hi Lorenzo,
>>
>> Le 04/08/2026 à 13:13, Lorenzo Stoakes (ARM) a écrit :
>>> On Mon, Aug 03, 2026 at 05:43:57PM +0100, Pedro Falcato wrote:
>>>> There is no need for write access to the PTE.
>>>>
>>>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>>>
>>> With below addressed LGTM so:
>>>
>>> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>>>
>>>> ---
>>>>    arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>>>> index e2ea8ba9f8ca..f2bab31040c7 100644
>>>> --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>>>> +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>>>> @@ -226,7 +226,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
>>>>
>>>>    #ifdef CONFIG_PPC_16K_PAGES
>>>>    #define ptep_get ptep_get
>>>> -static inline pte_t ptep_get(pte_t *ptep)
>>>> +static inline pte_t ptep_get(const pte_t *ptep)
>>>>    {
>>>>    	pte_basic_t val = READ_ONCE(ptep->pte);
>>>>    	pte_t pte = {val, val, val, val};
>>>
>>> Worth making these const too (that {val, val, val, val} horrifies me btw :)?
>>
>> Any suggestion welcome.
> 
> I'm being super nitty, all I mean is:
> 
> -   	pte_basic_t val = READ_ONCE(ptep->pte);
> -  	pte_t pte = {val, val, val, val};
> +   	const pte_basic_t val = READ_ONCE(ptep->pte);
> +  	const pte_t pte = {val, val, val, val};
> 
> :)

I'm fine with that, I was reacting on the "horrifying".

> 
>>
>> powerpc 8xx page table is independant on page size. When you use 16k pages,
>> depending on the address you hit the page for the first time, the HW assist
>> page table walk will fetch one of four 4k cells in page table that need to
>> be identical as they all four define the same 16k page. Not sure I'm clear.
> 
> No that's clear, thanks!
> 
> (I say 'horrifying' because I am looking into RCU page table freeing which this
> may complicate, though perhaps not in practice, to be continued :)

A few more details here if needed: 55c8fc3f4930 ("powerpc/8xx: 
reintroduce 16K pages with HW assistance")

Christophe


