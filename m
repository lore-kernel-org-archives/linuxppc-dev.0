Return-Path: <linuxppc-dev+bounces-17386-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E76DFD7F97
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 11:14:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMm1W6mVKz3bmR;
	Fri, 27 Feb 2026 22:14:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.184
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772190863;
	cv=none; b=mZ7uOlF61xEwO0gvG/CIihGJWVV8w/wAlSr3/LzgUkV01vgJ53pKWzCLfV/hv/duJH5i/0BjoTYT+jnmUyF+X+ggzI6ECeAN0Nk1Dycj+2L0LeiZZIgM4b/nHvh4JNZv1jhNqQU9yWGJH3sUbdao0hfN4rBjY4ta4tEzqPIEqf7gUnvOrYPVnkJnVeF9FUYjOE+lTuMn8QwBW7j89gztBqxhoY77c/HLXjTnxcPct0RV6oG+EzwWyHiSsMuugxvsUzrt++w0dbjJC4cXe+fa7ma5FQ4noyk+rw53AMJ+esW0pGpGjGMGHIg4uFHoYIQxLl6CQSup64vrpaMzy59hJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772190863; c=relaxed/relaxed;
	bh=uXPJJ+uhWU3/FibG5pPc63uoF/bg2b2LZnaOHcLIOXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FD2UiFFKBmyPd/xX5sfnaI6mGZAkbh/MAOSw6RWQgr40S/JoUoKvj462UbF72UXHAgGsofK9YWUW53pUpeDkqCbB2eMyGeJZMcjbvsQB+/7gytYQv3C1vhEQhet8udLt8NeRmUG953UAELuyC/b9m+LJS/Q16n0fCED2Hxz47+u9igWt+nskzqfDSNa4XFJYTb2I92UFam//69pHp71808ooof2tdDQh86gDAmgs+ciLsM6Okn8fZcqCFXnhYfHgCsrVVOqmnLQZC780Rrioen0csSwI4nRes76WNEIFGHswKgCcYjMU7ARpx/SAQ4WN6OtDecwcYwqpRGhehOlKFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fjb+QxCd; dkim-atps=neutral; spf=pass (client-ip=91.218.175.184; helo=out-184.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fjb+QxCd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.184; helo=out-184.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMm1T2gHwz3bZm
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 22:14:20 +1100 (AEDT)
Message-ID: <1d3a4e8e-9ea0-42e7-b8e7-d92fb27f80f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772190839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uXPJJ+uhWU3/FibG5pPc63uoF/bg2b2LZnaOHcLIOXA=;
	b=fjb+QxCdpTD3b4hr6YJTVtQxFdL+ygkZ8Otiw+cAUP2giw6sWDiSAgMSDuqQT6kvToVNoO
	8K59vpmdlkwEvSNRr24BZt7S48RvMyWCLaDD2DvslmD5YU5FO7ZumLMbqR8ln6N1qw/OQO
	ZU+NrOiKyaHHCpYxVLcB1Tyhayipyrk=
Date: Fri, 27 Feb 2026 11:13:55 +0000
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
Subject: Re: [RFC v2 00/21] mm: thp: lazy PTE page table allocation at PMD
 split
Content-Language: en-GB
To: Nico Pache <npache@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org,
 lorenzo.stoakes@oracle.com, willy@infradead.org, linux-mm@kvack.org,
 fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260226113233.3987674-1-usama.arif@linux.dev>
 <CAA1CXcAYt3OfW_uBTYZgr-dBhg99x=5pUs5uvqtpg+PNJ1KxGQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <CAA1CXcAYt3OfW_uBTYZgr-dBhg99x=5pUs5uvqtpg+PNJ1KxGQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 26/02/2026 21:01, Nico Pache wrote:
> On Thu, Feb 26, 2026 at 4:33 AM Usama Arif <usama.arif@linux.dev> wrote:
>>
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
>> mprotect, partial mremap and so on.
>> Most of these operations already have well-defined error handling for
>> allocation failures (e.g., -ENOMEM, VM_FAULT_OOM). Allowing split to
>> fail and propagating the error through these existing paths is the natural
>> thing to do. Furthermore, split failing requires an order-0 allocation for
>> a page table to fail, which is extremely unlikely.
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
> Hi Usama,
> 
> Thanks for tackling this, it seems like an interesting problem. Im
> trying to get more into reviewing, so bare with me I may have some
> stupid comments or questions. Where I can really help out is with
> testing. I will build this for all RH-supported architectures and run
> some automated test suites and performance metrics. I'll report back
> if I spot anything.
> 
> Cheers!
> -- Nico
> 

Thanks for the build and looking into reviewing this. All comments
and questions are welcome! I had only tested on x86, and I had a look
at the link you shared so its great to know that powerPC and s390 are fine.


