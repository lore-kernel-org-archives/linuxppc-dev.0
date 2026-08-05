Return-Path: <linuxppc-dev+bounces-25401-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3ADDC561E6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 05:58:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFKTL5zdzz2xqM;
	Wed, 05 Aug 2026 15:58:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785909494;
	cv=none; b=BrpkKzbsjg0FxHrNjqxNCSYW1BxplrYrzpYSDY74hnMcZccXFMmRGOccIKZb/Mx1FhvB/4BHtyP+YP1oJD2KwI+09PVpn0Ytr0Ccbvf8rKhZ3Si/++Text1kU0RDovGCDoEbG7xKm3C6ASrh/S6kOGGrqcnnB7e8ZaDFyZMDO32DD+zz3WY7KXz9zjyxDu/15ByWGGUXT3j/A0in7K/kSaDJgrPHoVhpZWk0pdTCFqSi7mkVxKQwuis/BYWQGA1y9Yf8UPXvr73+WqCdF70uIRhZLE+O4bpyvK3Bwc0tBI3hFI+/Sze5vz5hK02fo75m8u4Fg3KgEfB793GyiHYOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785909494; c=relaxed/relaxed;
	bh=v7zCWK++jNfxfhEt8Y8jIgML8WXQN15ZQy6uHyDnBnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bNwqvWRQGQxjP8SybUqTcxY43M3TRWYdvJ1a33dI1xKjYGrzVbPxvV45RKDhrsQH7vNbvI7I1Bwr5GpzSsZKo/CXLQyZkzNbf1T1JbNg/sZ9Z1ZfC/ZObCwxZfqj2fbv7lPuxY4fzmMkopgiDjBcwEWT0b+tjv9ZYY6FmDBFn7/NsPXaYRw74CD9X0Bary0+ZcSoMMNXDXs6eo1IKTnjgAWLV9QwkP/7ZeWc4CGB3pbnJpD19h6u5Q30AmDIhA1i+I+VnwQPsNY0TxdTwUAyBndc+V4nw8GKV7ZmeJsaquLYjWhT6p4YQFaX8oBARgq5RUyf8CsnP0Xw9BDrHeJkAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WpTfVY+g; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WpTfVY+g;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFKTK5VN4z2xl5
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 15:58:13 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 12245403D2;
	Wed,  5 Aug 2026 05:58:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 574631F000E9;
	Wed,  5 Aug 2026 05:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785909490;
	bh=v7zCWK++jNfxfhEt8Y8jIgML8WXQN15ZQy6uHyDnBnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WpTfVY+gis0GaZ8Ilij2iuNXtip1yECYuuQNUlYVo6jVc87VSMT30kmNOwPl/ZTao
	 7oJbpElLKRYZM/H9E3uzPA0m2dDs7qxBrWfUSWeNQgVusyFJAB0zhgsb3CndB3eLBl
	 oVx+8kJVKo/dvCnEjFd77EC7hbxP5rQoI682riTb93MQ9TfiRSWCb3g5JOckn0oZli
	 58e+xTR7r2M3llPSRy5MrzI9rSBdgu2K2JYrZI3FiSOydblbfVLAtbSKgrhbcozdEM
	 SIQIBRN5owC9lJ1/5UdzSc5P9So3/Y8YL+DvqEaETnFE51wJndUFjamNuiFbFR2lzb
	 lLGJvpl87Db5A==
Message-ID: <595fe323-59d3-4f4a-92a3-ac5d67b7461b@kernel.org>
Date: Wed, 5 Aug 2026 07:58:02 +0200
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
Subject: Re: [PATCH v2 6/6] mm: constify the pte_offset_map_ro_nolock() return
 value
To: Pedro Falcato <pfalcato@suse.de>, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
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
 <20260803164400.531199-7-pfalcato@suse.de> <anHJ48Glq8EdHatd@lucifer>
 <anI6BEyTJFzQY-N9@pedro-suse.lan>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <anI6BEyTJFzQY-N9@pedro-suse.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 04/08/2026 à 21:22, Pedro Falcato a écrit :
> On Tue, Aug 04, 2026 at 12:22:19PM +0100, Lorenzo Stoakes (ARM) wrote:
> 
>>
>>>   			if (!pte) {
>>>   				mmap_read_unlock(mm);
>>>   				result = SCAN_NO_PTE_TABLE;
>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>> index b91b1a98029c..2cfc6e608ef4 100644
>>> --- a/mm/pgtable-generic.c
>>> +++ b/mm/pgtable-generic.c
>>> @@ -308,8 +308,8 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
>>>   	return NULL;
>>>   }
>>>
>>> -pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
>>> -				unsigned long addr, spinlock_t **ptlp)
>>> +const pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
>>
>> Can pmd be const too?
> 
> I was going to say "yes but then pmdp_get() also needs to be constfified" but
> actually no, it can't:
> 
> pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp) {
>          if (unlikely(pmd_bad(pmdval))) {
>                  pmd_clear_bad(pmd);
>                  goto nomap;
>          }
> }
> 
> so PTE mapping actually needs to write to the pmdp if the pmd looks bad.
> Tricky stuff :)

But if pmd is const, can it be bad at all ?

Christophe



