Return-Path: <linuxppc-dev+bounces-24787-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19623C531C9
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2026 15:04:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h6B9G228lz2yFg;
	Sat, 25 Jul 2026 01:04:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b6"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784905474;
	cv=none; b=b6+4xo3l2l+HaR9E7kShknBDCXbRKext6iHKoWZ8AK/zRLC7dggK6VZb+1X9DhUYLSRtEy4thRoYSwKRSdHz4IYYdHIcUo1DMK/FStF/yv1+RnD6MOR0SP+VMCEtaRrb59eN/yK2nosn6+WAhtSZE09Z+BeOHOr8bUhK996rKhBd6qzHA1Gsoq3nCA4xL7s5CYjxBXtHoke2rpcRzFf5mozC+diXZ24nxRef2576w8uoadk6pzujLXeV4F1yISbbIemd88I4HfqtFPeUGhD15MR8itPUplCBiJFqEsf7vKAr2SIdQNZoU/y3aAb/zkRJcsjSkuNHKPenIvGfTPkjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784905474; c=relaxed/relaxed;
	bh=CdO7KCyyIro+bfenb1xkDQljGGt5dLLkhErcCFsE/Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nsGUu9IKpLoVJQ4+K51vcfsUn6fPNHY2pXRNnO6ubkdDP2yP1f1zaN1JgC0zttiTjclExdq796Vuk/TjQKCEGf2F+iL1RA0d088zHlIRd1pehQ+5852H9YzwJCZfDk4wKbo5pWxpFeoEKiLw0oqdf1WOW1rTVq9F3XWiCuNopGovyGm2ceGWcqKJw0e2FwXuvCHn0PNRFO8QL8i/qqGtQCOB3sXso9ME8KpxSKiIT2z+M3c2QO74fvi85dcD6wN2NrI48GOPay/arbhuuHD9SFvYINnLG7+nuoL2RXNS7UxJunMAqfZ/OZDdb3/tDgxqVLKaji6CDPHBRiXh66fPjA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=n5/Rd4ev; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b6; helo=out-182.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=n5/Rd4ev;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b6; helo=out-182.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h6B984WVSz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2026 01:04:26 +1000 (AEST)
Message-ID: <253f7ac0-205b-42f1-9fb5-d19eceb581b6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784905439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdO7KCyyIro+bfenb1xkDQljGGt5dLLkhErcCFsE/Qg=;
	b=n5/Rd4evPANGbx1Hmm1azC85wU0nheG46FNmmGZJPiYVUUuGaxBTO3RHHaSsxBQmXrEiYH
	w9WBY2Cs+toTZTVSry5TJuqptsIkQ9usv7g3oI2qlLAi3yC1kjAzyk0KK+DRltA6b8/OHH
	0wfJYfPBAYVBhVVxrB7ixiXxNmqIs70=
Date: Fri, 24 Jul 2026 16:03:44 +0100
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
To: Matthew Wilcox <willy@infradead.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <amNzLXuwflIZFKtI@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 24/07/2026 15:14, Matthew Wilcox wrote:
> On Fri, Jul 24, 2026 at 02:36:59PM +0100, Usama Arif wrote:
>>
>>
>> On 24/07/2026 11:20, Pedro Falcato wrote:
>>> ptep_get() does not need write access to the PTE.
>>>
>>> Signed-off-by: Pedro Falcato <pfalcato@suse.de>
>>> ---
>>>  arch/parisc/include/asm/pgtable.h | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>> hmm I think you might break build bisectibility if
>> you separate out the patches, you should squash patch 3 and 4,
>> with patch 1.
> 
> I don't see how this breaks bisectability.  Can you elaborate on what
> you think would break?

Patch 1 does:

-static inline pte_t ptep_get_lockless(pte_t *ptep)
+static inline pte_t ptep_get_lockless(const pte_t *ptep)
 {
 	return ptep_get(ptep);
 }


ptep_get() takes a non-const arg till patch 3 for example for parsic.
I don't think you can pass a const variable to non const function arg?

So parsic won't compile in patch 1 and 2, powerprc wont compile
for patches 1, 2 and 3..





