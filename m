Return-Path: <linuxppc-dev+bounces-17934-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93D96FCA192
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Mar 2026 21:35:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fV9KV3Q44z2xNg;
	Tue, 10 Mar 2026 08:35:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::ba"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773092126;
	cv=none; b=eRmShSXmWpvngFo7VE/1Uh1g2SshrZV8Bds5Q3iyMBeRfNGcO1ag6gWZgul9GQNm9k7ZFvGEu9eFqXkigs+1+o1yZ80W5HnPq6g9uGi6eaHyCO0Xm8VPrNs3xkXAMi9W5iVz7+9atYGthX3BhPif50Wu75GM1cmWENH6Rj5eTit8+55JjmHHUKp6QPChyM4G5hif/VVULSD+UtNmXjAQh8FnMSjSbEMynmNdbJKG3Qy5LeR70Ily6aM05Gr17pIi57ccBkzh3kRzxWyXkiBYFXnd36zIbsCySbOy57TXIFr/l/BbBbV7u0tfL0tVYORk7+Nm5zc5kJjjBpmI1Pr+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773092126; c=relaxed/relaxed;
	bh=9Z89Z0CbGlfYyK9enL1aU6uEk1uYUJc2hi9of77FKCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzxZygrDFGcM5qGolkWctig5E0NEw9YO6+HTnkmh9pEs0UZXz4mVGa8KFHZ06cTNoJCyMrngB9I+kksopJopEjMbwJC2jiGD9gOaTXReIV/l4Ny2nKiU4+FOIT9ROv+AAWpSJIdAybHiDfvMP/QGwXjr3AVLGZ0enVbyyh9nxmEYjz/LDDtz2LssLWeNLzGjT25I4DY3Ez/pLEDFZCHKu/SplyrkMTN+SkVkGZprnt+7d7/drra9RYZygMhw5IGz/wR67sEqPPEzsx3tTwlewqHSibRre+2eH9LW3xRE5DqNncM4wRfGVu66qSEpEHTOOFiBLv9bTWIgg4X+MNTGTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UfIiuqUj; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::ba; helo=out-186.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UfIiuqUj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ba; helo=out-186.mta0.migadu.com; envelope-from=usama.arif@linux.dev; receiver=lists.ozlabs.org)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ba])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fV9KR3K61z2xNT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 08:35:22 +1100 (AEDT)
Message-ID: <de0dc7ec-7a8d-4b1a-a419-1d97d2e4d510@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773092101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Z89Z0CbGlfYyK9enL1aU6uEk1uYUJc2hi9of77FKCc=;
	b=UfIiuqUj5RN4OnUp4DNTD94bNDfHXU/WZAsxKKJI+0HRS89NtQj96WZrCoQLc2+MRaJK9s
	E3IB3pqneljaxU6hi6H97Os7emjBXks+52uiFFqGOY8CELSXzuwd1DUHfPtD1cG6LsElAj
	bpL91EN1nFg/AuG8ETeRKDtWEndcmAs=
Date: Tue, 10 Mar 2026 00:34:39 +0300
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
Subject: Re: [RFC v2 12/21] mm: thp: handle split failure in device migration
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
 <20260226113233.3987674-13-usama.arif@linux.dev>
 <CAA1CXcDyqPPwf_-W7B+PFQtL8HdoJGCEqVsVxq7DhOUB=L4PQA@mail.gmail.com>
 <6982e9fc-cc17-4d4f-b26e-83997c4bf070@linux.dev>
 <CAA1CXcCb6aZnjgtunEuwL380S-2re9N-AEjZUB+XO9G6gkrHQw@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <CAA1CXcCb6aZnjgtunEuwL380S-2re9N-AEjZUB+XO9G6gkrHQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 09/03/2026 18:09, Nico Pache wrote:
> On Thu, Mar 5, 2026 at 9:55 AM Usama Arif <usama.arif@linux.dev> wrote:
>>
>>
>>
>> On 02/03/2026 21:20, Nico Pache wrote:
>>> On Thu, Feb 26, 2026 at 4:34 AM Usama Arif <usama.arif@linux.dev> wrote:
>>>>
>>>> Device memory migration has two call sites that split huge PMDs:
>>>>
>>>> migrate_vma_split_unmapped_folio():
>>>>   Called from migrate_vma_pages() when migrating a PMD-mapped THP to a
>>>>   destination that doesn't support compound pages.  It splits the PMD
>>>>   then splits the folio via folio_split_unmapped().
>>>>
>>>>   If the PMD split fails, folio_split_unmapped() would operate on an
>>>>   unsplit folio with inconsistent page table state.  Propagate -ENOMEM
>>>>   to skip this page's migration. This is safe as folio_split_unmapped
>>>>   failure would be propagated in a similar way.
>>>>
>>>> migrate_vma_insert_page():
>>>>   Called from migrate_vma_pages() when inserting a page into a VMA
>>>>   during migration back from device memory.  If a huge zero PMD exists
>>>>   at the target address, it must be split before PTE insertion.
>>>>
>>>>   If the split fails, the subsequent pte_alloc() and set_pte_at() would
>>>>   operate on a PMD slot still occupied by the huge zero entry.  Use
>>>>   goto abort, consistent with other allocation failures in this function.
>>>>
>>>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
>>>> ---
>>>>  mm/migrate_device.c | 16 ++++++++++++++--
>>>>  1 file changed, 14 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>> index 78c7acf024615..bc53e06fd9735 100644
>>>> --- a/mm/migrate_device.c
>>>> +++ b/mm/migrate_device.c
>>>> @@ -909,7 +909,13 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
>>>>         int ret = 0;
>>>>
>>>>         folio_get(folio);
>>>
>>> Should we be concerned about this folio_get? Are we incrementing a
>>> reference that was already held if we back out of the split?
>>>
>>> -- Nico
>>
>>
>>
>> Hi Nico,
>>
>> Thanks for pointing this out. It spun out to an entire investigation for me [1].
> 
> Hey Usama,
> 
> I'm sorry my question lead you down a rabbit hole but I'm glad you did
> the proper investigation and found the correct answer :) Thanks for
> looking into it and for clearing that up via a comment!
> 
> Cheers,
> -- Nico
>

Thanks for the review! There is a need for folio_put in this patch
specifically for split_huge_pmd_address which I wouldnt have figured out
without your comment, so really appreciate it!

Usama

