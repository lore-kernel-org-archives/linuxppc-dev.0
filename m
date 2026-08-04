Return-Path: <linuxppc-dev+bounces-25372-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523D1C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 12:50:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDtgZ65csz2yYs;
	Tue, 04 Aug 2026 22:50:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785847834;
	cv=none; b=aZUOtYdLxcc26izdulecSVw/8lHGvbgkHYblV6uNvUiRn0ukXsjALFwf2qYviV+Qzi8jEwTjvn2YCG+DXreA3c2EjSrSzs/6Sa7SczcOMD6eVgvxiL5x8bAW9+A0WsbbXnyXddFYjemMTPFlJXDiF+09mnC7jH5mfYPKc/3xj3L82l30nCY+4XbGMuhVhnryyXHQuWnTgyeoI1YkPh3H9smUWkN0z9oMoAQUtmtTFgUPk91zR4o3x7IkQw21K9oWGUc3OBhx5rCh8h2iSm7a8W3v3ijNg20NVgCSOpwIW1lm64aQgH432WyPwfd5xZGtjiYYjjvGvSj651G2+QmNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785847834; c=relaxed/relaxed;
	bh=dwIlf/7Evmvt247IE4OinLG+J81ldxUzqSmjbn1lj4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUZg+RBFg7M6WdhaaIRcuM7BXRV5okMEBj9i1jgl7FwYRLAJcPzBeDG1LuezGraw1txD6X1FQOBoLcXYM0066Ni7HQ2Gvh9Ij61/bSpJ8F4ha3/6wzUVeQKc0ye4mPfAnE87NlEzkgFr3Q+uOX/yY+GdelTYTMDMOQlsME+UvREFmxT9jmw6C6qAP3rrhUI1cNsLxpgFyIGsgdkk4Ae+k9QKPh5THcVAYELzOBKL768ZsWz/tki4iUUy2cOFpdiRwQMxickE//M+AaLUIKpCPxTgmu1WYWEEPiOn1nQ7UeyJXAraLU1WW6M4wMVhc/ysC0/Y7O3gxi/zZ8QckkO/eQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YABf4fdg; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YABf4fdg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDtgY4M5kz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 22:50:33 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4524360A77;
	Tue,  4 Aug 2026 12:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA74A1F000E9;
	Tue,  4 Aug 2026 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785847831;
	bh=dwIlf/7Evmvt247IE4OinLG+J81ldxUzqSmjbn1lj4I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YABf4fdg/D3MZ/bWjeLut7tnE92glPPUblZGjARSmDu+SgTZpTVi3WlLm5HquAEGf
	 J2bpoFXvno4uXAcJ7Qo2ETmUHwVx7QaU4Q6WWLBRWh0ptmCIMDZ7RFbr0vY3E7y26f
	 HxBmGepETc20zSML41v9hWk4GYBDyII5UeitdQ7FJ1clvB48Hd99D6tRp7kXQbSc+/
	 XRPUWDoOmZMUHaf+U1rl7d5ImlwquVOEdD/uQN4srP+6xLmPHZhNDl1rgq1RFigrZq
	 Gs2boYFuSu/p89NeE3nlhVrLloKDlGkdWJOQ09Yz3skgBGv9l0vTzQ2rYw7eRih4tx
	 ETPFvsGGDEVUQ==
Message-ID: <dcdb8cab-c18c-4995-ad1d-2f2d4700e7c1@kernel.org>
Date: Tue, 4 Aug 2026 14:50:19 +0200
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
Subject: Re: [PATCH v2 3/6] mm/powerpc/8xx: constify ptep_get() argument
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@kernel.org>,
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
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <anHI4B-lMu6AJJfA@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lorenzo,

Le 04/08/2026 à 13:13, Lorenzo Stoakes (ARM) a écrit :
> On Mon, Aug 03, 2026 at 05:43:57PM +0100, Pedro Falcato wrote:
>> There is no need for write access to the PTE.
>>
>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> With below addressed LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> 
>> ---
>>   arch/powerpc/include/asm/nohash/32/pte-8xx.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>> index e2ea8ba9f8ca..f2bab31040c7 100644
>> --- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>> +++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
>> @@ -226,7 +226,7 @@ static inline pte_basic_t pte_update(struct mm_struct *mm, unsigned long addr, p
>>
>>   #ifdef CONFIG_PPC_16K_PAGES
>>   #define ptep_get ptep_get
>> -static inline pte_t ptep_get(pte_t *ptep)
>> +static inline pte_t ptep_get(const pte_t *ptep)
>>   {
>>   	pte_basic_t val = READ_ONCE(ptep->pte);
>>   	pte_t pte = {val, val, val, val};
> 
> Worth making these const too (that {val, val, val, val} horrifies me btw :)?

Any suggestion welcome.

powerpc 8xx page table is independant on page size. When you use 16k 
pages, depending on the address you hit the page for the first time, the 
HW assist page table walk will fetch one of four 4k cells in page table 
that need to be identical as they all four define the same 16k page. Not 
sure I'm clear.

Christophe


