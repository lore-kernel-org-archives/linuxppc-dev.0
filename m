Return-Path: <linuxppc-dev+bounces-21225-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E962CD4F54
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 09:59:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL6TY6McZz2xqv;
	Wed, 20 May 2026 19:59:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779271185;
	cv=none; b=XhPENvw08rf6mw9FLRB/p4/x/aZNR/1OPnHqSZfG6pZaY8FY22qDPwecPNLPpeUTjXzupi+eOdce1PWlIrZCgyuQWCI1a77clIR6m0Rar33dTYm3/cZbR6H8CHbQDabbDh2RoIvucPqVTmY24TbT54SyHtAm+E0oCEE65lvIIU7Suv63HPjcZRd64cGhfxYk52hlcQO4otOs967qpHOPikpIJEjLXPUlh6Dnf/BGWgdwOTClH0Un0dcOcaHHwycQYfZQGQJ6MfjTB+bEy0miNP5vcJvY9tvOvT4g5ggtBMFPB/PzfJokh8mCsAcjDnoLj7mBCANeBvM8PSVPagykow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779271185; c=relaxed/relaxed;
	bh=p91ID7ZSzXqugYcRdarh8oWFAzscV9Mfd+6vAnBXmOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mV3v3bQ6ivI7I9Ilc1+a0O1PKbaXXZImI+Sr6PZXQVyhkqijOAEHSpORGRNcaZycV8D8KiqmBug/0H/J0bRnROpMkH2qRfq5FI9b5Xam6/RMVKRMlR4ci+2wd+LxL5gcU1ZVcYh4wJoIydHQGC9u7/18ldgE1GBwb2370pmyNiOW9Oh3PGrdf5nplduN1+8tNqq5R19RM4RIa2ZeBFhwTIpDriQnie7BHmfcOgXlHA+mc6FsZ5UZQLgahVMqyTETYa/3601cZx5hiIlE9a6a/5R9bmbB/xx3rbWtAYG/SUyL9GGVSxKUWTEEO8YxLYClHRFtSzbR2krCtN7B1HtaXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qc7NIX3+; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qc7NIX3+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL6TY0vChz2xfB
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 19:59:45 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E85F340AB7;
	Wed, 20 May 2026 09:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1ACF1F000E9;
	Wed, 20 May 2026 09:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779271182;
	bh=p91ID7ZSzXqugYcRdarh8oWFAzscV9Mfd+6vAnBXmOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Qc7NIX3+owrcApCTEwgmL7sVS5fJfjitxdcB+v7YDB97Z6I43/IvuFni5msmksvOx
	 CG4zR3Z83/b5ofSitLfBJ+3jb3wTvGCsDHBMqH5aZa3c6OMrmEgAXlsJgVoGU+jABK
	 1WYFTU35zhYEX1kTf++ob/L3KFx19un/D7gqvuhrlYtyT4+l9JufHREzPtifYHx4fF
	 b1AoSNpx8SMGpYn3/OCtjf7mgDDwwWt4/Ev+jlX4iMfCf2/+Qe7LPJF9+sk0D2FFnP
	 CmD3Lqv8bSgN3oW8GUjX1MiF1qVlo0hQhUyQfI9Yg85F+kHEmKowNFmzTF+AK6+YHp
	 qZuCM6p4HEc3g==
Message-ID: <757318e3-91df-4e39-ba44-5130626d38b8@kernel.org>
Date: Wed, 20 May 2026 11:59:39 +0200
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
Subject: Re: [PATCH resend] powerpc/code-patching: Avoid r/w mapping of the
 zero page
To: Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
References: <20260520085423.485402-1-ardb@kernel.org>
 <d4690d12-77d5-4575-9a79-484a919d3203@kernel.org>
 <3e63e2eb-30b3-4377-9331-41445d9c8720@app.fastmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <3e63e2eb-30b3-4377-9331-41445d9c8720@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 20/05/2026 à 11:40, Ard Biesheuvel a écrit :
> 
> On Wed, 20 May 2026, at 11:36, Christophe Leroy (CS GROUP) wrote:
>> Le 20/05/2026 à 10:54, Ard Biesheuvel a écrit :
>>> The only remaining use of map_patch_area() is mapping the zero page, and
>>> immediately unmapping it again so that the intermediate page table
>>> levels are all guaranteed to be populated.
>>>
>>> The use of the zero page here is completely arbitrary, and not harmful
>>> per se, but currently, it creates a writable mapping, and does so in a
>>> manner that requires that the empty_zero_page[] symbol is not
>>> const-qualified.
>>>
>>> Given that this is about to change, and that map_patch_area() now never
>>> maps anything other than the zero page, let's simplify the code and
>>> - take the PA of empty_zero_page directly
>>> - create a read-only temporary mapping.
>>>
>>> This allows empty_zero_page[] to be repainted as const u8[] in a
>>> subsequent patch, without making substantial changes to this code
>>> patching logic.
>>>
>>> Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>> Cc: Nicholas Piggin <npiggin@gmail.com>
>>> Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>> ---
>>> Build tested only (Clang)
>>>
>>> Resending from my non-Google email. Apologies if you are receiving this
>>> twice.
>>>
>>>    arch/powerpc/lib/code-patching.c | 11 +++++------
>>>    1 file changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
>>> index f84e0337cc02..13a8acf851f1 100644
>>> --- a/arch/powerpc/lib/code-patching.c
>>> +++ b/arch/powerpc/lib/code-patching.c
>>> @@ -60,7 +60,7 @@ struct patch_context {
>>>    
>>>    static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
>>>    
>>> -static int map_patch_area(void *addr, unsigned long text_poke_addr);
>>> +static int map_patch_area(unsigned long text_poke_addr);
>>>    static void unmap_patch_area(unsigned long addr);
>>>    
>>>    static bool mm_patch_enabled(void)
>>> @@ -117,7 +117,7 @@ static int text_area_cpu_up(unsigned int cpu)
>>>    
>>>    	// Map/unmap the area to ensure all page tables are pre-allocated
>>>    	addr = (unsigned long)area->addr;
>>> -	err = map_patch_area(empty_zero_page, addr);
>>> +	err = map_patch_area(addr);
>>
>> I would get rid of map_patch_area() completely and just do:
>>
>> 	err = map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KERNEL_RO);
>>
> 
> I think retaining the symmetry of map_patch_area() and unmap_patch_area()
> makes sense too.

Could also drop unmap_patch_area() and use unmap_kernel_page() instead.

> 
>>
>> By the way I don't know how vital it is to map in read-only but in case
>> it is see commit da3a3b0a0e38 ("powerpc/32s: map kasan zero shadow with
>> PAGE_READONLY instead of PAGE_KERNEL_RO")
>>
> 
> In the end, it doesn't make any difference, given that the mapping is removed
> again immediately. It is just neater to use _RO to map a const object, rather
> than explicitly creating a read-write mapping of something that should really
> never be written to.
> 

Ok

