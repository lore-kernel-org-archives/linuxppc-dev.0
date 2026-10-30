Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACA1606A329
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fqKiRN/U
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGDmb4rSFz30V6;
	Fri, 30 Oct 2026 19:29:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::59"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793348991;
	cv=none; b=SjQBdUXhulGbBdvtsxLf8Qd0fSLo0EEei9/RmGLSwX53QLMdKesxJK/Zc4Dks2myi6Ak09KmkNoHeXfoWn0k1ec4Nil9eTc6lCpxzy4HFQu/FndH/IrR4zlKqFKbx444voEajAhZvD7w3YZrM+M5hGoA/zopYTKt5nrnXD/prGNwoiXJ0i7pKGsTJ1dI/NV8m9jktrbVkJaF6c3HD/4v+99dNnuuI6NendaG2fdxnFLirdO4S85c/J1eKuhOZB4SkB4n/R/7x4vPs0c2Of5xLveu1zKYLPAMosCb/CerbY8QH51LC30DeLfGUbX1IiDoi8F/X4zfy8aBBI79fzOHbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793348991; c=relaxed/relaxed;
	bh=NUOdiWftstkdjD3ldYV9jARRTLumRPJOziIdFVy1jPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgbVeT8Asc58YgpL7pJqFTpX+xx1L6H/8u+JCcDyXtLOBt/tizrbu5DuQeLoJPvwYNm2EpNBhdj6IowNBfT3ZQYIpjR5np6nY7MDPytOWj2bn6xp/FQ2Kja76hGnhBVh2YNdoIpLnVY46zaZ/S4tGnO5SfeIM12b5Zmq5V7Ynm2L/njM5e1xNW8LdfPcAoQk2i5kbjUD0eVXz18izOS56eD60tABTxwNhZtJUOuU0yth0rEufh2FDY5RActQdcya3wOXYjqO7vPRoB5qjjd8chX0Aa3MxlIuDQOTS3Wb3+nTapAVOQqpWqowunQT1mn1qg4fX5Ct8dHtF4+5/5JEpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fqKiRN/U; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::59; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fqKiRN/U;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::59; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-89.mta0.migadu.com [IPv6:2001:41d0:1004:224b::59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGDmX2fBkz30RN
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 19:29:46 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=VKj6jsUT5uPNz0z5oNidKhqpMpX0J7TlgAePRZwWgdE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793348967; v=1; x=1793953767;
 b=fqKiRN/UWK5/JcParJ41wz4YZ4Fe+A1Je8557uA4EXUOJ9X7fXcFcxGNnqjDKz8dWO8TPU7x
 veqV0xxp5FUsHNvLMgtE3+Lgy89WpZ8ofP2bdREG1OuTvGTOw+JOfvnqcXOAijgEgnDXIgzhsRo
 fKaokF2/fJvBs+rd0TujjgWI=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id f6353d09bda43725;
	Fri, 30 Oct 2026 08:29:27 +0000
X-Mizu-Trace-ID: f6353d09bda43725
X-Migadu-Flow: FLOW_OUT
Message-ID: <5452d555-82f9-45a6-b443-ee732b1874ba@linux.dev>
Date: Fri, 30 Oct 2026 16:30:39 +0800
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/10] mm/vmalloc: clamp an unaligned range in
 vunmap_pte_range()
To: Dev Jain <dev.jain@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Uladzislau Rezki <urezki@gmail.com>, Suren Baghdasaryan <surenb@google.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
References: <20261026080329.140244-1-hao.ge@linux.dev>
 <20261026080329.140244-4-hao.ge@linux.dev>
 <99f529e8-06f7-4a20-a60b-0330c5d3d91c@arm.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <99f529e8-06f7-4a20-a60b-0330c5d3d91c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dev

Thanks for your review.

On 2026/10/30 15:14, Dev Jain wrote:
> 
> 
> On 26/10/26 1:33 pm, Hao Ge wrote:
>> commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
>> PAGE_SIZE aligned") made vmap_pte_range() warn and bail out when the
>> size is not a multiple of PAGE_SIZE. That loop steps in page
> 
> Why are we checking the alignment so late into vmap_pte_range? Why not
> simply do
> 
> if (!IS_ALIGNED(addr, PAGE_SIZE) || !IS_ALIGNED(end, PAGE_SIZE))
> 	return; (or return -EINVAL);
> 
> at the start of vmap_range_noflush and vunmap_range_noflush?

I think adding that check at the entry of vunmap_range_noflush()
goes against its design intent. Its job is to tear down the mappings
of the given VA range, so even when the caller passes a size that is
not page-aligned, we still have to unmap whatever is mapped within
that range.

So the patch clamps end down to the last full page and keeps
clearing. A buggy caller still gets its mapping torn down as far as
it goes, and nothing is left behind. The check here is just for
protection. 

This is just my preliminary understanding; I may be mistaken.

Thanks
Best Regards
Hao


But that's just my understanding, happy to be corrected.


> 
> 
>> multiples and stops only at addr == end; with an unaligned size addr
>> never lands on end, so the loop cannot terminate and walks off the
>> end of the page table.
>>
>> vunmap_pte_range() has the same loop without any guard, so an
>> unaligned range would clear PTEs past end without ever stopping,
>> walking off the end of the page table.
>>
>> Add the check there too. The range is clamped down to the last full
>> page rather than dropped, and the loop is skipped when nothing is
>> left, so a buggy caller still gets its PTEs cleared as far as they
>> go.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/vmalloc.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 44e0eb32708f..7131f60d1a8e 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -393,6 +393,11 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>  	pte_t ptent;
>>  	unsigned long size = PAGE_SIZE;
>>  
>> +	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
>> +		end = addr + PAGE_ALIGN_DOWN(end - addr);
>> +	if (end == addr)
>> +		return;
>> +
>>  	pte = pte_offset_kernel(pmd, addr);
>>  	lazy_mmu_mode_enable();
>>  
> 

