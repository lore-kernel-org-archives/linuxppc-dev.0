Return-Path: <linuxppc-dev+bounces-19513-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CEF10F994B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 15:07:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frRHT64YPz2yDk;
	Thu, 09 Apr 2026 01:07:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.173
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775660821;
	cv=none; b=a0GG3G4rrcy/hZoj8mDwqWWYWcMCQTZDoY4pb0H6mIJVuAiBEWgVh8vks8iMtd62ovxtBGCzwqE5xH8dzT+wwM0zWedrijNwGOY9ljAMciP9BW5BpNg/X/f29GDLqhzYLoeMNGW6KCL6tz0/hTmuwRN0ECodyv+3HsiMyzrdFBIK4+BHrMDCQd7RYgrBwWn6845roH9VvKpY/RHLkdXilZOAX2vg0hlgcNgsbDR4QyGH3A4BqPRZYEEhSZvicYigXEi9hlQ9xzHPSTE6RGaBjQq3oB1yQCuOcD2vLCfUQNV2pMrNJ1BGMq7hITVrWvuR92Rpinjq+YCjcyEnCIlOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775660821; c=relaxed/relaxed;
	bh=1+VU8UBRdEVEeyiV4+aPbi7V4ANQswood2btwWC7W10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfnTSX67fWzuhyVKJhUJ2crsr693NNd3Yeq8Pb7WGkFNIUYoASPNnX3/vhogdsjGJiRJ+QFuUs+g8H4HsLrRUFVd6onnBwl5IZGD+IhxdSIxL6XpnSKzSwsem0kdOpAheAQYZa27kKRd2Z8v2WfWFw66UbfRuH0fSkRaULY6585L4IdQwlBNEte51V1iC75jxtEDzEwwGL7TIG8sZJGQ3LF+KKaD4JTvVPefSSQA3Im06ba77N7OWJcgWz/YDmAspTkVbnE+FB4jg+gdpgaLxPn0f/IOsWxShZzPuaESQmm6wcG2cBvDbKXw+FhljjbwgFYMcwapVll4gKrwdLjukw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nce/YT8h; dkim-atps=neutral; spf=pass (client-ip=91.218.175.173; helo=out-173.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nce/YT8h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.173; helo=out-173.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frRHQ1skdz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2026 01:06:57 +1000 (AEST)
Message-ID: <3f9e8e12-2d51-4f2a-ada1-994ed24df284@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775660796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1+VU8UBRdEVEeyiV4+aPbi7V4ANQswood2btwWC7W10=;
	b=nce/YT8hy0RDyIldhTyZu273O+IC+4lreKGHKqWJoK3qIW7bVWBVi0LDO0W3lmX0H16Zbp
	2j0OvnNTiosCwvyEbTE3/t2vJHMqme6LCCCV3xImTBLdUhG0DAWay2mblTf9uccqXFl8OC
	AexvCrHBe5xG29n0GcZSuslUwx11Dow=
Date: Wed, 8 Apr 2026 16:06:29 +0100
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
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>, willy@infradead.org, linux-mm@kvack.org,
 fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <6869b7f0-84e1-fb93-03f1-9442cdfe476b@google.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <6869b7f0-84e1-fb93-03f1-9442cdfe476b@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 06/04/2026 00:34, Hugh Dickins wrote:
> On Thu, 26 Mar 2026, Usama Arif wrote:
> 
>> When the kernel creates a PMD-level THP mapping for anonymous pages, it
>> pre-allocates a PTE page table via pgtable_trans_huge_deposit(). This
>> page table sits unused in a deposit list for the lifetime of the THP
>> mapping, only to be withdrawn when the PMD is split or zapped. Every
>> anonymous THP therefore wastes 4KB of memory unconditionally. On large
>> servers where hundreds of gigabytes of memory are mapped as THPs, this
>> adds up: roughly 200MB wasted per 100GB of THP memory. This memory
>> could otherwise satisfy other allocations, including the very PTE page
>> table allocations needed when splits eventually occur.
>>
>> This series removes the pre-deposit and allocates the PTE page table
>> lazily — only when a PMD split actually happens. Since a large number
>> of THPs are never split (they are zapped wholesale when processes exit or
>> munmap the full range), the allocation is avoided entirely in the common
>> case.
>>
>> The pre-deposit pattern exists because split_huge_pmd was designed as an
>> operation that must never fail: if the kernel decides to split, it needs
>> a PTE page table, so one is deposited in advance. But "must never fail"
>> is an unnecessarily strong requirement. A PMD split is typically triggered
>> by a partial operation on a sub-PMD range — partial munmap, partial
>> mprotect, COW on a pinned folio, GUP with FOLL_SPLIT_PMD, and similar.
>> All of these operations already have well-defined error handling for
>> allocation failures (e.g., -ENOMEM, VM_FAULT_OOM). Allowing split to
>> fail and propagating the error through these existing paths is the natural
>> thing to do. Furthermore, if the system cannot satisfy a single order-0
>> allocation for a page table, it is under extreme memory pressure and
>> failing the operation is the correct response.
>>
>> Designing functions like split_huge_pmd as operations that cannot fail
>> has a subtle but real cost to code quality. It forces a pre-allocation
>> pattern - every THP creation path must deposit a page table, and every
>> split or zap path must withdraw one, creating a hidden coupling between
>> widely separated code paths.
>>
>> This also serves as a code cleanup. On every architecture except powerpc
>> with hash MMU, the deposit/withdraw machinery becomes dead code. The
>> series removes the generic implementations in pgtable-generic.c and the
>> s390/sparc overrides, replacing them with no-op stubs guarded by
>> arch_needs_pgtable_deposit(), which evaluates to false at compile time
>> on all non-powerpc architectures.
> 
> I see no mention of the big problem,
> which has stopped us all from trying this before.
> 
> Reclaim: the split_folio_to_list() in shrink_folio_list().
> 
> Imagine a process which has forked a thousand times, containing
> anon THPs, which should now be swapped out and reclaimed.
> 
> To swap out one of those THPs, it will have to allocate a
> thousand page tables, all with PF_MEMALLOC set (to give some
> access to reserves, while preventing recursion into reclaim).
> 
> Elsewhere, we go to great lengths (e.g. mempools) to give
> guaranteed access to the memory needed when freeing memory.
> In the case of an anon THP, the guaranteed pool has been the
> deposited page table. Now what?
> 
> And the worst is that when the 501st attempt to allocate a page
> table fails, it has allocated and is using 500 pages from reserve,
> without reaching the point of freeing any memory at all.
> 
> Maybe watermark boosting (I barely know whereof I speak) can help
> a bit nowadays.  Has anything else changed to solve the problem?
> 
> What would help a lot would be the implementation of swap entries
> at the PMD level.  Whether that would help enough, I'm sceptical:
> I do think it's foolish to depend upon the availability of huge
> contiguous swap extents, whatever the recent improvements there;
> but it would at least be an arguable justification.
> 
Thanks for pointing this out. I should have thought of this as I
have been thinking about fork a lot for 1G THP and for this series.

I am working on trying to make PMD level swap entires work. I hope
to have a RFC soon.




