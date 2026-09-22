Return-Path: <linuxppc-dev+bounces-27899-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2526EC982FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 08:07:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpt465C4Fz2yqw;
	Tue, 22 Sep 2026 18:07:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::dd"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790064438;
	cv=none; b=iClgd4t/kT14kpvum8o/5VSKK5GMnjq1bHlTWF7fj+/72BpmtHXPKsTheFQ3ZPvqIZQ24pNfDnDYGdX19GHRVqo7S1FXzohxlPwvyz4j0Cr9uKA3U52yf4eIjG28MRN8M0ekgxnRrfhAnwDTK9+nmahCBk0znTH6bJh3+yxRZknGvrCkw+0favzzn8/HRgtag2NY8UA/6EnFEB9TqCDv+jZbi1blZ4as0R5QONlIep2fj/n6lG28GMcHpLb7SqYCkfZITpA+GGXX48yqlQm+MEGYkHIoyv9k6bdFBf4xhIFHBvwpFqrpSvegSgTVPdrifuQXj6EP1WJClOdtMjUlcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790064438; c=relaxed/relaxed;
	bh=CDUhekT+dHHEfwUJMas3OBH9JBfvOhivPPlgcZw/Efw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAtrPGcrR5j8ETlDBpfubbrpwFitTsPG7lIHjnC9aJNo49qKDLJ7WOPSUMBMbhlqT1VFRRdwvUqoF3ATRg5y0vh9IYaHL4USC709lYNUVAlauntqUDDY0oZiP3XCSzgLHO1y4inwUfAVcBRgFJDMV4wnpqfMammqNT3k277zYRlIOwTYq/g3Eia2+4yAlTFiQyDiTz0ed9CrXK5TfLwHLddQMbgrLQ7d6Nw+l5DyVaY6WqPxl1lupDCfxL7Tlkb/Rn1gEWdflyYiXRG3OXdemCIV6z+0uzvOOweb38C0Di7Jb3WutsFWcy4OsoIPKB+bwQyrj3siL38jwjiylitAEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=X9WQPZy0; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::dd; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=X9WQPZy0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::dd; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-221.mta0.migadu.com [IPv6:2001:41d0:1004:224b::dd])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpt4274kTz2yHT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 18:07:13 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=L3E1ABTsvQD+v6c+2rBUEff5SSrYDo8CA8Cr1zQwot4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790064414; v=1; x=1790669214;
 b=X9WQPZy0ToRbOJeCCiyLmC7es48vhsJkndgl4xcfVdEtZHJd4lMNfWGclTyrFmgziIxhAY4H
 aNRJfEwsBmXbfFQLgt7NPXqeo1quMAAFAAXK3EPU4OkqjTN9x/HFp2f8N1vS+4FOExJoZORCRJk
 n+NOIkZ1iLy8WxWb9tw5aCMc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 69a7d16cab5036eb;
	Tue, 22 Sep 2026 08:06:44 +0000
X-Mizu-Trace-ID: 69a7d16cab5036eb
X-Migadu-Flow: FLOW_OUT
Message-ID: <8a135fee-1f75-4260-afa0-10f8b522809f@linux.dev>
Date: Tue, 22 Sep 2026 16:06:38 +0800
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
Subject: Re: [PATCH 3/6] mm/sparse-vmemmap: drop Device DAX-specific
 population path
To: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev
References: <20260913083734.86802-1-songmuchun@bytedance.com>
 <20260913083734.86802-4-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260913083734.86802-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/13/26 4:37 PM, Muchun Song wrote:
> The common vmemmap path selects the shared page for optimized mappings
> itself, so Device DAX no longer needs vmemmap_populate_compound_pages()
> to find a shared tail page and pass its backing PFN through the generic
> population helpers.
> 
> Remove the Device DAX-specific population path and let section memmap
> population always use vmemmap_populate(). The powerpc retains an
> architecture-specific compound-page implementation, so select it directly
> from radix__vmemmap_populate() for optimizable sections.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   arch/powerpc/mm/book3s64/radix_pgtable.c |  3 +
>   mm/mm_init.c                             |  2 +-
>   mm/sparse-vmemmap.c                      | 71 +-----------------------
>   3 files changed, 5 insertions(+), 71 deletions(-)

Acked-by: Qi Zheng <qi.zheng@linux.dev>

Thanks,
Qi

