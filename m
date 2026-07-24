Return-Path: <linuxppc-dev+bounces-24795-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA596C531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 15:49:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6C8z2gRXz2yYf;
	Sat, 25 Jul 2026 01:49:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784908163;
	cv=none; b=BU8kYsSTu0fAc4M+CDvebzWtrMdNjtbiCyJf3iXVklKIVpQosQWH3QtprodHWdptJ07Er8p+ArR/5No+a46qGxE8pmDtNjdTck8IK34zzAof9qDjRXK7YDmAjr5bNUwOiICeb/KIzZWOEAGc52t5tMcAc88nmB1RjyzDboc77bIUacvOgGVFmOCwN91Cfl9XesPYozvcDbRFyyGv+3mJKNpp1zPualg6L1WIHJ9yVAMga7ml9Z6DatBL1LkJ6naea0xsDw0uyflT0pv6wOmPBZg+71DSd6tLTUN/7vV6O9cAYf64iJQSpnQKzCDhHCxcWvo2qI/e1rHqZXh5nHW8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784908163; c=relaxed/relaxed;
	bh=Wpu1gJe0sM1zpg7qn6uKI6n3VZyrOevD5zqeBPXBfwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evfzD3Jc5lD1VRAlTOHlc9WCU2GVpl3cDk6J8y+Bi6FO8NUVjmx2t8KXRr4BwpXmWLYitPEp/YJcpLYFHowXIdeq3Jm2hM4z7HszRxlNZkCMFYnnVPAyupDilJbLe1L6d9aWRq7hhIb+HmnMUIpD7iAV7nBkTGu6MnKKyhgLto8zZ7bMvyzvyEA5hmV9dymbL5fHc6xtTtkKmkm4ZyzJ240L3GlVvEd+kYuFkTHS9dfgvl4CUTWhM6JHHwkrz3G4nconAbKdVgDCwDvpWBDTa/P+sZqQkrJuU4culsrtpMIEhom3XM5dbhU7kHqck9qeUjGuvN4w6ISuGVZ/I8RcVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Nwts4fjd; dkim-atps=neutral; spf=pass (client-ip=91.218.175.170; helo=out-170.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Nwts4fjd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.170; helo=out-170.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 7909 seconds by postgrey-1.37 at boromir; Sat, 25 Jul 2026 01:49:20 AEST
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6C8w60d3z2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 01:49:20 +1000 (AEST)
Message-ID: <fd239383-dcbe-4daf-b337-32facef07076@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784908138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpu1gJe0sM1zpg7qn6uKI6n3VZyrOevD5zqeBPXBfwE=;
	b=Nwts4fjdNhRkKoiWWgZb1pTyJfagzBgyAnhKRuaoRCtBx7aSslbqFtzy/tsaZj6SPePbPj
	+h8333InKBjxMVvWvd3VZk65pWaNGEHdIfYDP0nvTh3PcpkutNlEUvY2oMMCgrEm5Igfrr
	HnNV1rKdfXh4xzFXjakZOI0RjFHt+wk=
Date: Fri, 24 Jul 2026 16:48:50 +0100
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
Subject: Re: [PATCH 3/5] mm/parisc: constify ptep_get() argument
To: Pedro Falcato <pfalcato@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Kevin Brodsky <kevin.brodsky@arm.com>,
 Muhammad Usama Anjum <usama.anjum@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
References: <20260724102017.141532-1-pfalcato@suse.de>
 <20260724102017.141532-4-pfalcato@suse.de>
 <0fd713a8-e4ab-4c07-b36e-79dd138b4a86@linux.dev>
 <amNzLXuwflIZFKtI@casper.infradead.org>
 <253f7ac0-205b-42f1-9fb5-d19eceb581b6@linux.dev>
 <amOEUZlp1BxYh6_t@pedro-suse>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <amOEUZlp1BxYh6_t@pedro-suse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 24/07/2026 16:32, Pedro Falcato wrote:
> On Fri, Jul 24, 2026 at 04:03:44PM +0100, Usama Arif wrote:
>>
>>
>> On 24/07/2026 15:14, Matthew Wilcox wrote:
>>> On Fri, Jul 24, 2026 at 02:36:59PM +0100, Usama Arif wrote:
>>>>
>>>>
>>>> On 24/07/2026 11:20, Pedro Falcato wrote:
>>>>> ptep_get() does not need write access to the PTE.
>>>>>
>>>>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>>>>> ---
>>>>>  arch/parisc/include/asm/pgtable.h | 2 +-
>>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>
>>>> hmm I think you might break build bisectibility if
>>>> you separate out the patches, you should squash patch 3 and 4,
>>>> with patch 1.
>>>
>>> I don't see how this breaks bisectability.  Can you elaborate on what
>>> you think would break?
>>
>> Patch 1 does:
>>
>> -static inline pte_t ptep_get_lockless(pte_t *ptep)
>> +static inline pte_t ptep_get_lockless(const pte_t *ptep)
>>  {
>>  	return ptep_get(ptep);
>>  }
>>
>>
>> ptep_get() takes a non-const arg till patch 3 for example for parsic.
>> I don't think you can pass a const variable to non const function arg?
>>
>> So parsic won't compile in patch 1 and 2, powerprc wont compile
>> for patches 1, 2 and 3..
> 
> Aha, yes, nice catch! I'll have to rethink that. Maybe squashing the patches
> would be the cleanest way forward.
> 

Yes, squashing is the simplest way forward.

> FWIW, the vast majority of architectures aren't doing funny things on
> ptep_get(). E.g PA-RISC, loongarch only define these so they can use it in
> their own asm/pgtable.h. I'd really like to delete these but I can't tell
> if they are *actually* required.
> 

Ah maybe there is something in git history on why it was needed?

If not, hopefully someone from the arch lists could clarify..

> With those gone only PPC 8xx and generic would need to be squashed (arm64 also
> defines its own version of ptep_get_lockless()).
> 
> 


