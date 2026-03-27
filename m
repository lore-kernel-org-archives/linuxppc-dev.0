Return-Path: <linuxppc-dev+bounces-18927-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 134CE10ED674
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 14:40:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fj3GY3vBZz2xmX;
	Sat, 28 Mar 2026 01:40:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.179
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774622437;
	cv=none; b=CY4QVkGezWp42K2lVUMYfRHUNZlLdJWislQAl/TXWUKRbRbR/ZGjfpHWdKgUwd8hhQdn/zV5UURdHNhKP9U13mDfyMg+gQj0VTRdx9rcYUq5Tm5UlrR0cTspoMqEX/v4bhkCTTkvFD8O+nGgAjY78QgBhxEU5HksUKEy9H3gASS8HZ8VTP5O7efyKPi1Gi6v67+ru9F7xE3yK+u8XOxWkXFsSl7LlScu30/iDJpZDMv8XS3v5dqWHzJrrOBOCNxKpHaAPi6CgSXd+aENF1n0b8X8toa3PnyR4Ohg3NhXBjIYPWp0cfBM7IRBzQ+x7WUqIRRDekqv6BBo0c/mkma7Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774622437; c=relaxed/relaxed;
	bh=rPmy7VWivg5YsRBSBaIcdTmp91XPK0irR3iwfLEb4tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKbHB0TlolaYqgJB5b3JtxeDCQYnma/8LIXRwJkFkwv/XeO8nzqVf+7+97ITIhZKlmNHlPPDGgnbaDONAQYGDwTBfOLeBHIw3GM/NVSjQXBuSWEDAtVNtjoimnQA2HeteM2KkCt/nWoh1YDI6VrG+bGTgNm1wtBuCaJM4aV2n5GpyzNsmTvL4j3pqnTzo+oSBTEHgxGa+giTxWdMvRChWR2u2n263fkwcIubvxYWNlxfkSCc/wGTPryU9NvEEhNONa/KH5Ixks0oTWX/A9+Ccl+S0WrkCC7aTBo0Av7zFbOySctSJF8WfXSUjuw9ABTlxZXkIIdPMtixn2hQnqRvYw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FpoH38ed; dkim-atps=neutral; spf=pass (client-ip=91.218.175.179; helo=out-179.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FpoH38ed;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.179; helo=out-179.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fj3GX30plz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2026 01:40:36 +1100 (AEDT)
Message-ID: <a5efef0a-8d68-4c8c-b8ae-09a6a33e37cd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774622416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rPmy7VWivg5YsRBSBaIcdTmp91XPK0irR3iwfLEb4tM=;
	b=FpoH38edCQ9PPpFsGYVuORz7UGKbAz3vOE8SC863R9H33+lGVW2wozoOwesf39+5QTJLZ6
	YMLDpHYRZPlLmWXmfHEsd2JK00Icpo84ITAZklijT4H3nM+WPbh5CLzikqON6bRdbSd6yH
	4h/88ILAJinto+ZbCJD1S1MPuXXTASM=
Date: Fri, 27 Mar 2026 10:40:10 -0400
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
Content-Language: en-GB
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
 linux-mm@kvack.org, fvdl@google.com, hannes@cmpxchg.org, riel@surriel.com,
 shakeel.butt@linux.dev, kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <48d7c810-d219-4346-9e8b-d70243445a91@kernel.org>
 <cf36f821-8285-4b9f-b1fd-e080292f4204@lucifer.local>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <cf36f821-8285-4b9f-b1fd-e080292f4204@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 27/03/2026 12:25, Lorenzo Stoakes (Oracle) wrote:
> On Fri, Mar 27, 2026 at 09:51:31AM +0100, David Hildenbrand (Arm) wrote:
>>>
>>> RFC v2 -> v3: https://lore.kernel.org/all/de0dc7ec-7a8d-4b1a-a419-1d97d2e4d510@linux.dev/
>>
>> Note that we usually go from RFC to v1.
>>
>> I'll put this series on my review backlog, but it will take some time
>> until I get to it (it won't make the next release either way :) ).
> 
> Yeah, please update to v1 from RFC because I'm looking at this and wondering
> where v1, v2 was and why I didn't see them...

Ah yeah I included the previous version link in the coverletter [1].
> 
> Generally I'd also advise un-RFC'ing a biiiig series IDEALLY be done early in a
> merge window :)
> 
> We've pretty much shut the door to new series this cycle, but being so late in
> the window at -rc5 would mean no way for this one anyway.

ack

> 
> But in general it's going to be a rebase pain this, 

Yeah rebasing from previous version [1] wasnt fun. But yes happy to rebase when
needed!

> and I'd rather not see it
> land in mm-unstable at this point, because that's supposed to be 'what's in the
> next release' and it's stuff like this that leads to 'I am not sure what
> mm-unstable represents any more' being a thing.
> 
> I think in an ideal world we'd ONLY see this in mm-new.

ack, I will try and send the next revision on top of mm-new. I do believe
this will apply cleanly on mm-new at the moment as well but ofcourse that can change.

> 
> I wonder if we need some process for un-RFC'ing really, where somebody kinda
> asks rather than it being a vibes thing as it is now (or a 'people don't reply
> to my RFC' which yes I'm guilty of :)
> 
> Anyway this is more general points and not about you Usama, because - hey - all
> this stuff is pretty unclear generally.
> 

No worries and Thanks for reviewing!!

>>
>> --
>> Cheers,
>>
>> David
> 
> Cheers, Lorenzo


[1] https://lore.kernel.org/all/20260226113233.3987674-1-usama.arif@linux.dev/


