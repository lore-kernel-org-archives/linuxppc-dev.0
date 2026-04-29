Return-Path: <linuxppc-dev+bounces-20254-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B68FF885A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 03:03:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g52FJ3p5zz2ySW;
	Wed, 29 Apr 2026 13:03:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777431828;
	cv=none; b=IopZCg/w1LURDUw3TJF1xSNXOmuh7jGqLbknrJ/53c+2jZu5kX9BK0eSCVAfvAPi+EDTVJqOt4lhczwo3uo0uRxU2wj0Bbqq9fKEQ3/2lhSLokcxXpwliHalK06cQ8q1GQYYMgIcXTHZO4Vjg0huHgRIiwjWBeApqTTwYJBWnmbEDuye6TzuHAj4GNv6MLVtiwpOrTTBKoC5O5wcaeYdbPLAO0YD2tnGxs+2YJ5Uf6zgdp2D11/AIiqFq4XlI3yVdanJCaTNZ1wme2Xmnih088F+j1jtil1Da+wYmpZuiIEFKD5lCA1IIYYKtI/9HW0RCiLX/PWFayB526GL5wj5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777431828; c=relaxed/relaxed;
	bh=rVdIF5xMMbMuztmqCdOg6Gne4HRwdJsr6QDFaBOJNgA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=At7Jl05efQNgTc9eXPbFSWBoOYLyToWrFP8D23THhQQ1iht8ENeTGe8cIKOjC6tRtVeFFdTXPbBzjdSGELQ+M/QoNxx032c3n6wQ8/beraGfmuaTaZTRHso9aOx37SFMiF2QTLGMx5X/lvt6s9sR7IdSfk9b59CLrRumNU6NlqZV4bMQ+N4IJXp3ZQBMD3aDvctCqEPXB18OhFMPnU0QIjMCCMsqncOccHeenbEoxTY1HPO5sTmbX4U5gm3oCUMUo1+uvPi4KLLBF4MVFxs5YIxOG/Ok2Oi92on6TrSskkfkKJHPuehQ1SbRxB3n6VtXMnRXbVBQBp6HVDMBrP6Dzg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DGEDJbIp; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b3; helo=out-179.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DGEDJbIp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b3; helo=out-179.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g52FH5t9zz2xTh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 13:03:47 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777431808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVdIF5xMMbMuztmqCdOg6Gne4HRwdJsr6QDFaBOJNgA=;
	b=DGEDJbIpy7JGrpJ59uRvmyWQ/+oc4LxI28LHP8B9Ra69Qv+7lS7boZ1Xzep4QMP9B6i/OW
	BFhKEhdpsJ6o+T2i8BGqENxPbqRMQh1DnhZg2CUpl2lTelQMthpw207HvXyrmA10mtWizu
	UQzVlpvn0F4A0q5MBdSB0nfKcttgSTE=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 11/49] mm: defer sparse_init() until after zone
 initialization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <afBepGBqlKTyOFob@kernel.org>
Date: Wed, 29 Apr 2026 11:02:42 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <DB04EB19-B371-497D-B2D3-C8564B127CD0@linux.dev>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-12-songmuchun@bytedance.com>
 <afBepGBqlKTyOFob@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 28, 2026, at 15:15, Mike Rapoport <rppt@kernel.org> wrote:
> 
> On Sun, Apr 05, 2026 at 08:52:02PM +0800, Muchun Song wrote:
>> According to the comment of free_area_init(), its main goal is to
>> initialise all pg_data_t and zone data. However, sparse_init() and
>> memmap_init() are aimed at allocating vmemmap pages and initializing
>> struct page respectively, which differs from the goal of free_area_init().
>> Therefore, it is reasonable to move them out of free_area_init().
>> 
>> Call sparse_init() after free_area_init() to guarantee that zone data
>> structures are available when sparse_init() executes. This change is a
>> prerequisite for integrating vmemmap initialization steps and allows
>> sparse_init() to safely access zone information if needed (e.g. HVO case).
>> 
>> Also, move hugetlb reservation functions (hugetlb_cma_reserve() and
>> hugetlb_bootmem_alloc()) to be after free_area_init(). This allows
>> hugetlb reservation to access zone information to ensure that contiguous
>> pages are not allocated across zone boundaries, which simplifies the
>> hugetlb code. So this is a preparation for subsequent changes.
>> 
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> mm/mm_init.c | 15 ++++++++-------
>> mm/sparse.c  |  3 ---
>> 2 files changed, 8 insertions(+), 10 deletions(-)
>> 
>> diff --git a/mm/sparse.c b/mm/sparse.c
>> index c7f91dc2e5b5..5fe0a7e66775 100644
>> --- a/mm/sparse.c
>> +++ b/mm/sparse.c
>> @@ -406,9 +406,6 @@ void __init sparse_init(void)
>> pnum_begin = first_present_section_nr();
>> nid_begin = sparse_early_nid(__nr_to_section(pnum_begin));
>> 
>> - 	/* Setup pageblock_order for HUGETLB_PAGE_SIZE_VARIABLE */
>> - 	set_pageblock_order();
>> -
> 
> This does not seem related to this patch. Otherwise

Right. I will move this to the following patch as you suggested.

> 
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks.

> 
>> for_each_present_section_nr(pnum_begin + 1, pnum_end) {
>> int nid = sparse_early_nid(__nr_to_section(pnum_end));
>> 
>> -- 
>> 2.20.1
>> 
> 
> -- 
> Sincerely yours,
> Mike.



