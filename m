Return-Path: <linuxppc-dev+bounces-21370-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94A0CD4F5B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 06:51:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMGCt16ngz2xSN;
	Fri, 22 May 2026 16:51:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779432714;
	cv=none; b=OMCHpmYd/aLObvonaPciFo9qqxifknfiXWx09FRY1XRYdvIdOSev2mteCo9DYC1bhgHg7aQmA4VoVsiLecoPSQmHoiP/+5DZueA4yHEGecvjHVcjRan/XGjwOf/erYBibny2e+cyuSA5/SdmFkxv2ZceRGGj490nI+8SFOO0VjppES3gCCSw8koRcFyT3enahcHhoM5FL2up64Drp2Ng6mPa4iDj1ZYPVhbVzJrvHj8TI/zLhFZzph47cLXuJkmCAMeJbSLrVxWKJeDZo4zIta+xeImOmFaqLtgfW2/xlTxnl+dvb22a48eEXCSa6Om9fNQX/38fO63RPrDQ1WUVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779432714; c=relaxed/relaxed;
	bh=IbXyWQ5T5tgl83yU5MLVm4r8uYyUNSyUC9g+Wz/2rFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cKTvIf7MVAqWZolZCI94/nE4BW/f4pKXTV1ZhRJ90HaIRlLnqoWVHg9/0fO3avZc8i5i434K9nSSKBUUHmjuRELF1vLlhQ/RCq0EaiabhefmSUL+k9XpLNRxKKdTwyBoeSyapeAZO70OK/ffmXt78XJeHBu//l66VDTv54gG/1EEV++9vWSyM6681DFQMXS8UHHuhfjkwqixuy9kdrdsZVt49KZwyQ/1ldXcIaF37i8gLCcICo0yB472wnCtdIgzmjK01p5IuYHXFEfvIs1WpUaMjXUO0ibIKw8kr9DADP/MFGn0Fh1K/ZdgFJ39mXuR3BqazIlGA8GGorkT7Tg9fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeAKmcy9; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YeAKmcy9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=mpe@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMGCs0h0jz2xGY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 16:51:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B8B66601D9;
	Fri, 22 May 2026 06:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AE01F000E9;
	Fri, 22 May 2026 06:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779432710;
	bh=IbXyWQ5T5tgl83yU5MLVm4r8uYyUNSyUC9g+Wz/2rFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YeAKmcy9A6+AkfcUKSjQZC4fx/dRV+9epVeo32VcYbcU/aRIPMoorMPxL27IHN40D
	 vrS6gAKTbxi9TK0g3IPBfneVhbvDnlrIzVtllROisLvqZE79VAzSlFyPLFHRbleale
	 jZd450gTmPpaucAqiYPJZ5Du0smwP5mMcxiiW8a9x3aE0TRmmWZZzaKrmB5SJVTooO
	 3QiKZOaGu8AMN13QWzpxrBUOVzSgXBkBhUCcfPbh7yXX1m2vBCeNfaqd+qmm8A5p6X
	 2+qmAlkefwQS6SXmDARSZGZQR8vR+MM0pdO+GpYNiv3eB5USNTUsmb5aovFdYUr7wv
	 aNXjwV2jIbmuQ==
Message-ID: <f8cdb51e-d329-4472-b7a1-68ab80b3f199@kernel.org>
Date: Fri, 22 May 2026 16:51:46 +1000
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
To: Ard Biesheuvel <ardb@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20260520085423.485402-1-ardb@kernel.org>
 <d4690d12-77d5-4575-9a79-484a919d3203@kernel.org>
 <3e63e2eb-30b3-4377-9331-41445d9c8720@app.fastmail.com>
 <757318e3-91df-4e39-ba44-5130626d38b8@kernel.org>
 <bc13fc3e-96eb-4aa9-a8d8-f7cf0c4cd505@app.fastmail.com>
Content-Language: en-US
From: Michael Ellerman <mpe@kernel.org>
In-Reply-To: <bc13fc3e-96eb-4aa9-a8d8-f7cf0c4cd505@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/5/2026 20:16, Ard Biesheuvel wrote:
> 
> On Wed, 20 May 2026, at 11:59, Christophe Leroy (CS GROUP) wrote:
>> Le 20/05/2026 à 11:40, Ard Biesheuvel a écrit :
>>>
>>> On Wed, 20 May 2026, at 11:36, Christophe Leroy (CS GROUP) wrote:
>>>> Le 20/05/2026 à 10:54, Ard Biesheuvel a écrit :
...
>>>>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
>>>>> index f84e0337cc02..13a8acf851f1 100644
>>>>> --- a/arch/powerpc/lib/code-patching.c
>>>>> +++ b/arch/powerpc/lib/code-patching.c
>>>>> @@ -60,7 +60,7 @@ struct patch_context {
>>>>>     
>>>>>     static DEFINE_PER_CPU(struct patch_context, cpu_patching_context);
>>>>>     
>>>>> -static int map_patch_area(void *addr, unsigned long text_poke_addr);
>>>>> +static int map_patch_area(unsigned long text_poke_addr);
>>>>>     static void unmap_patch_area(unsigned long addr);
>>>>>     
>>>>>     static bool mm_patch_enabled(void)
>>>>> @@ -117,7 +117,7 @@ static int text_area_cpu_up(unsigned int cpu)
>>>>>     
>>>>>     	// Map/unmap the area to ensure all page tables are pre-allocated
>>>>>     	addr = (unsigned long)area->addr;
>>>>> -	err = map_patch_area(empty_zero_page, addr);
>>>>> +	err = map_patch_area(addr);
>>>>
>>>> I would get rid of map_patch_area() completely and just do:
>>>>
>>>> 	err = map_kernel_page(addr, __pa_symbol(empty_zero_page), PAGE_KERNEL_RO);
>>>>
>>>
>>> I think retaining the symmetry of map_patch_area() and unmap_patch_area()
>>> makes sense too.
>>
>> Could also drop unmap_patch_area() and use unmap_kernel_page() instead.
>>
> 
> Good point. That way, we'll end up with
> 
>   arch/powerpc/lib/code-patching.c | 52 ++--------------------------------------
>   1 file changed, 2 insertions(+), 50 deletions(-
> 
> I'll spin a v2 with those changes once everyone on cc has had the opportunity
> to chime in.

That diffstat is definitely attractive.

I do like that unmap_patch_area() is more defensive with the page table 
walk, but it's probably overly paranoid. If page table levels have 
vanished since we just mapped them then the system is probably toast anyway.

So OK by me.

cheers

