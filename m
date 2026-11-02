Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22182606A324
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Nov 2026 06:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=opLyUe7j
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jJ1Rp1r5rz2y7p;
	Mon, 02 Nov 2026 17:06:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::2f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793599590;
	cv=none; b=bLyo6dgELHgC3C2vKc7z2Tybipxsb7PBueaXFI8arN9Taf6CLRIAKE/sA5lSloeuHLCQMkrbLWd/rCn2t+tkkm0Baz7A+Am6W5zUdFsq4d96LrDnST34ZDSurNFjTZsQPChX9wL/F7YGVedzm6RlLP5dQZhjDG0MpJ/fHZM1/DqFSAhrFZM1rTfT2+vqPlZ/sokLeLLjH0o/RubycoFS9NfZii3kJE+ysQVgLPavMizWwzCKjWHC2SLk5uNqgynr7PTr2hiJw6/VBEsr9Gm+/sD+QFkYa1pbxCgoh/dcshu2o0ZMjzVD0VxMOCi5KL6epax1tv0KdgKeM8k55Xu1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793599590; c=relaxed/relaxed;
	bh=h1VSrMby2SX5eM2E4NxQctXhVt0Tc6AaUP5veYJ4paM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUHiA6mUp90mwV7dkE0srmw2nFAdk2uOpx93pd3aH/hIleKL6kvslwj17HeNscfsVqmmhQfod2OEwt1aGrKt+1SL2Q8f+ZBkJaMUI5qP8Yf7avsiIkwu5Fp1oGfU/x1XaupHKjxjfCXCErYKLWJMOaCfjuyDD3ydfqk3YmrlCpG2MrHrznNNQ+PPt8GUaXCGaI4EUrDWZoUJRPfXDZAG/8B+R6guhQB96RHaCQRQKuNXMlZ99augdo/I/rTPucykMuLMNZqavn7668DV2eKAjVUsWH/uDCSUP9SSs0azrLGf8JZER/7eZ6qyWUyIcIiAbLwum63lM6g/JO5ZuecAcA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=opLyUe7j; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::2f; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=opLyUe7j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::2f; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-47.mta1.migadu.com [IPv6:2001:41d0:203:375::2f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJ1Rj5GWpz2xb9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Nov 2026 17:06:21 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=m9NFSN0c8k/rqWtXM6UCsQER/s2DqAk40a8du6haVV4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793599558; v=1; x=1794204358;
 b=opLyUe7jGCNX/Ks2Wfw0GvCvGymVCVFY2l4AjF+DjnJkuDGtnq5w8qUxEBVGRbjNMihUgh2p
 N2WbiyMNueHHPSHUSGE/VxojS8kqzm1uSC+IpGtAVRaUN87GTq88H0oOGL1Su97yAdfj0UCXL5R
 lWXN8dhDPTy0Vq7auiEh+2BU=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id b978153f13cb2e16;
	Mon, 02 Nov 2026 06:05:58 +0000
X-Mizu-Trace-ID: b978153f13cb2e16
X-Migadu-Flow: FLOW_OUT
Message-ID: <72d1b1d7-2fb6-402f-a557-0eaa767d6f86@linux.dev>
Date: Mon, 2 Nov 2026 14:07:18 +0800
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
 <5452d555-82f9-45a6-b443-ee732b1874ba@linux.dev>
 <e8a2a42d-e424-4366-8a68-e39167f62276@arm.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <e8a2a42d-e424-4366-8a68-e39167f62276@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/10/30 22:20, Dev Jain wrote:
> 
> 
> On 30/10/26 2:00 pm, Hao Ge wrote:
>> Hi Dev
>>
>> Thanks for your review.
>>
>> On 2026/10/30 15:14, Dev Jain wrote:
>>>
>>>
>>> On 26/10/26 1:33 pm, Hao Ge wrote:
>>>> commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
>>>> PAGE_SIZE aligned") made vmap_pte_range() warn and bail out when the
>>>> size is not a multiple of PAGE_SIZE. That loop steps in page
>>>
>>> Why are we checking the alignment so late into vmap_pte_range? Why not
>>> simply do
>>>
>>> if (!IS_ALIGNED(addr, PAGE_SIZE) || !IS_ALIGNED(end, PAGE_SIZE))
>>> 	return; (or return -EINVAL);
>>>
>>> at the start of vmap_range_noflush and vunmap_range_noflush?
>>
>> I think adding that check at the entry of vunmap_range_noflush()
>> goes against its design intent. Its job is to tear down the mappings
>> of the given VA range, so even when the caller passes a size that is
>> not page-aligned, we still have to unmap whatever is mapped within
>> that range.
>>
>> So the patch clamps end down to the last full page and keeps
>> clearing. A buggy caller still gets its mapping torn down as far as
>> it goes, and nothing is left behind. The check here is just for
>> protection. 
>>
>> This is just my preliminary understanding; I may be mistaken.
> 
> Hmm I get you, but this is very ugly. We are trying to tolerate
> a blatant bug in the caller with not-so-nice code. But see below.
>>
>> Thanks
>> Best Regards
>> Hao
>>
>>
>> But that's just my understanding, happy to be corrected.
>>
>>
>>>
>>>
>>>> multiples and stops only at addr == end; with an unaligned size addr
>>>> never lands on end, so the loop cannot terminate and walks off the
>>>> end of the page table.
>>>>
>>>> vunmap_pte_range() has the same loop without any guard, so an
>>>> unaligned range would clear PTEs past end without ever stopping,
>>>> walking off the end of the page table.
>>>>
>>>> Add the check there too. The range is clamped down to the last full
>>>> page rather than dropped, and the loop is skipped when nothing is
>>>> left, so a buggy caller still gets its PTEs cleared as far as they
>>>> go.
>>>>
>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>>> ---
>>>>  mm/vmalloc.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>> index 44e0eb32708f..7131f60d1a8e 100644
>>>> --- a/mm/vmalloc.c
>>>> +++ b/mm/vmalloc.c
>>>> @@ -393,6 +393,11 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>>>  	pte_t ptent;
>>>>  	unsigned long size = PAGE_SIZE;
>>>>  
>>>> +	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
>>>> +		end = addr + PAGE_ALIGN_DOWN(end - addr);
> 
> For simplicity assume PAGE_SIZE is 4, start is 3, end is 10.
> With your code we will get
> 
> addr = 3, end = 3 + ALIGN_DOWN(10 - 3) = 3 + 4 = 7.
> So the range becomes [3, 7) clearing only two ptes, the one covering
> [0, 3], the second covering [4, 7]. I feel we should rather make
> the range from [3, 10] to [0, 11], clearing three ptes.
>

Thanks for the example. Looks like I nearly introduced a new bug while
guarding against the old one, good thing you caught it.

> So, at the start of vunmap_range_noflush we could basically
> WARN_ON on non-alignment, and then clamp the start down, and clamp
> the end up to PAGE_SIZE.

I'm wondering whether we should simply BUG_ON for non-aligned ranges here.
Because the unmap could silently clear mappings at adjacent addresses, which
may not even belong to the caller, and this kind of problem is really hard to
track down afterwards. Say [0, 3) is in use by someone else, with PAGE_SIZE=4
an unmap starting at 3 still begins with the pte covering [0, 4), since the loop
clears page by page, so that owner loses his mapping without doing anything wrong,
and only sees the damage much later when he touches it again.

WDYT?

> 
> And with this also throw in a patch to bring the -EINVAL bailout
> in vmap_pte_range to the top, in vmap_range_noflush and check
> both start and end alignment.

For the vmap_range_noflush() check, fully agreed.  The current check
is indeed too late, the range is only found to be bad after part of
it has already been mapped. 

Looking forward to your valuable comments.

Thanks
Best Regards
Hao
> 
>>>> +	if (end == addr)
>>>> +		return;
>>>> +
>>>>  	pte = pte_offset_kernel(pmd, addr);
>>>>  	lazy_mmu_mode_enable();
>>>>  
>>>
> 

