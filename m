Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10701606A31A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Oct 2026 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G808FfGj
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jGHDF4k4kz30Vm;
	Fri, 30 Oct 2026 21:20:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1335"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793355629;
	cv=none; b=aFXNCC1Nj2fn0yRGQ+GrvFhWJR7RdykZG9QNnE8yrKppjyNAsY+5mqblh2Rs9iCNjXRdCI4sS2T2LTlIFhXaqbr5vXDZaTZOTssmPYK7v9K7Ah/PH/xVi7GQ/ohqFH/wlby5xok80fNrRQ0up9ZJpDgxovki3yolxiVYbPAR1QIVhD5zGKxQNsZTyeO4roXQm1tXaY00xbCkbOl7G3+2hCIUINTGfb/LH6ZoW11FtE7Lt5IESf9i4gKUFzWBlG+CdGeWgj4myj41li3sqwkW+68gWnHTRZDklNny5vHOCeF2PxVqfP4zKCGGjNvFMQv54B2KgEqIs++mVHUaw8v4RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793355629; c=relaxed/relaxed;
	bh=47HRSEMYaHZPzJWzqw3IojT1EDL4QQpT831/3j+yFnA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Z6B+jlRs0IIqZnjltyD7buvpdW1mHaA38kijBkqfWLuuLFn5jjG3d1NH1gbRRcaJGsESmmxWoQ2W86+11SVg4r+RA+HBKVw3En1qLQ4fsIvzbmG1nybndNhuB/329rCFAkv8cfnw6o9aXjp0yuIdBDrs9H55FPCJF1jIrgOuW/3cz9tPurVwPY731XA1CxI4HzTnBMX+oK1WFoW4+plYJJE2iEeO4csidhrppfk3XUdhU26aRjU3Stilx6ra+6spGjle1XVVdKdyxUjH2ORBSQ4QDRtzS9E02A5F33x9WuMIT7jO1T1ANkpurqGIFmUCzSO4g/j+X6MiCOATlz6xWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G808FfGj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G808FfGj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1335; helo=mail-dy1-x1335.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1335.google.com (mail-dy1-x1335.google.com [IPv6:2607:f8b0:4864:20::1335])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jGHDC576Bz30Vd
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 21:20:27 +1100 (AEDT)
Received: by mail-dy1-x1335.google.com with SMTP id 5a478bee46e88-36661f953e4so874345eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2026 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793355624; x=1793960424; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=47HRSEMYaHZPzJWzqw3IojT1EDL4QQpT831/3j+yFnA=;
        b=G808FfGjZuelX7gT1j7D8AYq4DYhnra9gQkHVsq8NF1gj4LLtGe+DAD3yea6ElcF8I
         SqB62mjJwI4SBODI8Mstck7HmWh1cEpalvSAfHJ9RSJKPBAfuG819u25MKkf7OQaYJPo
         LXmPKywPpSSX6lZDQAbYqeyqqJ5OZalmDq2YXozyHUHFfBn/SwwaqqshyiuyHs1SnHpm
         OeAYn4AM81dXQ8VULHPvqjrQFN0T7054C/WP0m+UI6fplPJBaHWhCcoiSxh7WlQeJw9X
         jcgArayMil3XW7RWQ2rBei8QTvmPC5oWrI4+0dLq0FjYEUHyHP6ssraSOoSWF5ff53a9
         CLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793355624; x=1793960424;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=47HRSEMYaHZPzJWzqw3IojT1EDL4QQpT831/3j+yFnA=;
        b=r0fpG6W+xYiicByxbqTbqHx0pDlikFWDse8mK5cMqOPjSIdClqISN0fP6/ZJ/L8o3W
         6ZFFOFzK5itedmBNFmGLYs+GEXtDIVtn8svPdYoMa8ka41LY2nGVwawXpbxv+TEGOnFl
         giO2jNU41Ltv4a0XRPXLK3N28XpPX8RthgSoMLew3lIXQgFb2fLZ/5p8KijIkiUdblfF
         WmvXMA6tE2uU4N3Y9T4MGdYLZITJJLGDrC7ye46bgy5gOSJLIff4GkAYXbrJyqCGoK2C
         4aCzLoA+xoJbZa6QAghgktXfmly9uLkPlx8N3Q8v4EKs8/JRoRH2BajT9p5i4Ry4DtAl
         PFhw==
X-Forwarded-Encrypted: i=1; AKwUvBwuLFSN3/5RYVZoj8P7DcSGKPOSvJ5tXkvn9y0FzWJllVLR7kQPvXPXSdMjvcUN2KAye+DqUZQSK+Ng5aA=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLsg4ydifY6DCnV5a9WsvDugBfARB9K8aE36bsmx+1TM7qvRugX
	cR9dw38/vTQ8SXBG+ZGj06+JU0dnwgheV6otU63PiNZD7eardjD+cHDV
X-Gm-Gg: AYBFou2hxGkQ5HwGp7LVkuR+ZT/cY9An53IiaKCUx6xapL+zK3KRIHOgni742Ts8EgC
	aorCgH22+h6X8UJ85+463ApwRbJ6bg9mRJ7OTsQ8yKRQzGJZi+UaCiYcICLX0gw1+qQ2q12kEcj
	syxwXwXaKhWun/7XTpLn5sn3ucaHU6KHNWeXV8wWdOv+l3OXMmyEcedpsi+xpU0o81ApyWfVIBu
	wMvEeW2FQLf6tV6p7mWYW594nt86FDJq3vJbTIuKOwqksCy9vJh43cMCqHhRXLI9Vu3hlT0ByI1
	kspsS7CmwE/enkCMAyU+40t+7j6RCdxInfubNNo3PXWQ1KCGbOEihnr+LfR51orcQLuPNI1Y2yq
	GGgwqkycSwyAiU5i+KXavszLBbus1iGzZvuSOLK0Dh/5ugYIwOlH3xcNX6ENaPl4CRryoqDuZBM
	dReLxDYC5CJoF/STeDV8lMKhzgp51Q/ecM9c31MlhpVnwSQWDkyF7owA6zmxRjpCjnGxF9uoOZW
	YIDWIh9YDRXqdfXKx+9g8gbz14FRTNmzOC7zCctwsL/5L5tkNCkh+E6NhdBQN036NmllG890xUu
	IARwj+fYS/7muSLFBVeZ1mH3Zzo=
X-Received: by 2002:a05:7300:c00f:10b0:36a:1470:da0e with SMTP id 5a478bee46e88-36a423bececmr3563726eec.29.1793355624408;
        Fri, 30 Oct 2026 03:20:24 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42662f23sm7607181eec.2.2026.10.30.03.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:20:23 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Muchun Song <muchun.song@linux.dev>, Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Pavithra <pavrampu@linux.ibm.com>
Subject: Re: [PATCHv2] mm/huge_memory: set the mmu_gather page size in zap_huge_pud()
In-Reply-To: <19012a9f-7a8d-4eb2-a441-cdb04184890b@kernel.org>
Date: Fri, 30 Oct 2026 15:45:04 +0530
Message-ID: <cxsrwl3r.ritesh.list@gmail.com>
References: <8b853e5f9f16145859407b28af654b0f79e12642.1793318297.git.ritesh.list@gmail.com> <19012a9f-7a8d-4eb2-a441-cdb04184890b@kernel.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

"David Hildenbrand (Arm)" <david@kernel.org> writes:

> On 10/30/26 01:07, Ritesh Harjani (IBM) wrote:
>> Unmapping a device-dax mapping with 1G alignment on powerpc radix kernel
>> built with CONFIG_DEBUG_VM triggers this warning on every munmap:
>> 
>>     WARNING: mm/mmu_gather.c:176 at __tlb_remove_folio_pages_size+0x38/0x230
>>     NIP [c00000000063d508] __tlb_remove_folio_pages_size+0x38/0x230
>>     LR [c0000000006fb688] zap_huge_pud+0x1b8/0x2d0
>>     Call Trace:
>>      zap_huge_pud+0x170/0x2d0 (unreliable)
>>      __zap_vma_range+0x1604/0x1e20
>>      unmap_vmas+0xa0/0x1f0
>>      unmap_region+0xb0/0x130
>>      vms_complete_munmap_vmas+0x120/0x310
>>      do_vmi_align_munmap+0x1ec/0x240
>>      __vm_munmap+0x148/0x220
>>      sys_munmap+0x28/0x40
>> 
>> To trigger this - it is enough to mmap() /dev/dax0.0, touch the first
>> byte so that the whole 1G is mapped by a single PUD and then munmap()
>> it.
>> 
>> PowerPC needs MMU_GATHER_PAGE_SIZE in which mmu_gather needs to record
>> the page size for which tlb flush is needed. zap_huge_pmd(),
>> zap_pte_range(), change_huge_pud() etc all do this already. However,
>> since commit:
>>   dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
>> 
>> a device-dax PUD maps a real folio and zap_huge_pud() now hands it to
>> tlb_remove_page_size(tlb, page, HPAGE_PUD_SIZE). At that point
>> tlb->page_size is still whatever the previous user left behind, which is
>> 0 for the fresh gather set up by munmap() and so the check fires.
>> 
>> Fix this in the same way like how other similar paths do.
>> 
>> Fixes: dbe54153296d0 ("mm/huge_memory: add vmf_insert_folio_pud()")
>> Reported-by: Pavithra <pavrampu@linux.ibm.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>> [v1]->v2:
>> =========
>> - Split the 2 part patch series. Patch-1 is now superseded by a different patch
>>   from Muchun which he already posted [2].
>> - No difference in this patch from v1.
>> 
>> [v1]: https://lore.kernel.org/all/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com/
>> [2]: https://lore.kernel.org/all/20261029063601.1961415-1-songmuchun@bytedance.com/
>> 
>>  mm/huge_memory.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index bd44d58e8684..7e589a2fb02d 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -3040,6 +3040,8 @@ int zap_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  	spinlock_t *ptl;
>>  	pud_t orig_pud;
>> 
>> +	tlb_change_page_size(tlb, HPAGE_PUD_SIZE);
>> +
>>  	ptl = __pud_trans_huge_lock(pud, vma);
>>  	if (!ptl)
>>  		return 0;
>> --
>> 2.39.5
>> 
>
>
> Matches zap_huge_pmd().
>
> I will wait a bit  and then queue this shortly.
>

Thanks David, however, looks like Andrew might have queued this up in
his mm tree [1], right?

[1]: https://lore.kernel.org/all/20261030021905.2DCA71F000C1@smtp.kernel.org/

> This sounds like stable material?
>

Sorry, my bad. Yes, we should have this Cc: stable@vger.kernel.org.

Kindly let me know if I should update the tag and send v3, or can it be
taken care? Thanks!

-ritesh

