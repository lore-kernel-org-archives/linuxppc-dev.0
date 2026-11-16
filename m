Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A72C606A335
	for <linuxppc-dev@archiver.kernel.org>; Mon, 16 Nov 2026 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uMldimwF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSdhq5Ndsz2xjv;
	Mon, 16 Nov 2026 17:47:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::9d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794799296;
	cv=none; b=BxzAKkwhvgm/BXWPM6jlCPh84Y82MdroYyZ/0wUhH0xWXyoOxZttD80x82vCf6SNsJV6nxlHStNr/0UX6nHtrXF6JOA6Q9+ti6VDTffkximOi0BT9h4BD51/VGxi6PQKCDc7kTJRN8lfhwEFNPGeP5WTTda1Q1jQvchMMN97xNqlxXB2vDzLciZLEe8KzNauLQWF+Pi8+1wQlZpuq6rKyUq++z/WRyjMh3kS4MGWcvMbGFm24rTqF4ZZW2CtzidpLpqZkMyfbeOmxSCTwUu6SUFObpW7gCurfOIvuIY3ROmVlc8T8Rfp1fGrwV9LM67BnVnc7TrbBVnapjLHKB3E6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794799296; c=relaxed/relaxed;
	bh=aAugIPzNpC7UMbhZOYH201v2ZVOiEbosgCIzwR+ppz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIqP3VGjl9jnwVs46yDz1yyha0XkQV8xrnvY1nnkG2yCDy4yfpEp7jOeNQAUPU29e56wk6NHRU17a3TtJqJ8P7C7cDeggQ8uxGh+d3LNXEPHVqQXPDOiIYyoPGO/Yy4pJUIG7GgpgRM9b/66j5OLIGqSL+YtCgpyBJXbINL9XxLJedj3YNvQjCEFGLPYse1AJ44chyClMsx1n8SIcDTuXZmiU5SxKPt2locLHdaD+yAnVbmgqI4VNrAfx2itP8KQCLq/TBJPI9w+8KEd3TFNmB7ey0M5DYcrJtQp5pMcIyKCQL+2uY8mS7vkkWEC/3hHGR95JJfpK9TlwVUia0cWpg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uMldimwF; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::9d; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uMldimwF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::9d; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-157.mta1.migadu.com [IPv6:2001:41d0:203:375::9d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSY7328Rnz2x9N
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2026 14:21:34 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=eG80WsiqYoqypFBVkKs72E/ZaOBrPv9KsimpXVqkwp4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794799274; v=1; x=1795404074;
 b=uMldimwFuJe18c9JmMxJwFGOdfVfOQ/pgBsZaVthuSV6o13lx4wQyI6S8vZD1RfgQLgehT70
 HvuCogiYy2hxbXFxnMxCVsJlqplqxRYLDeJAZgVOxeSkRfoOUbtKcKerqTG02dDLeFq6GbhWfch
 f229Iw2XkO02ce1C8BSHn6dE=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 7d2cc37c894a39c5;
	Mon, 16 Nov 2026 03:21:12 +0000
X-Mizu-Trace-ID: 7d2cc37c894a39c5
X-Migadu-Flow: FLOW_OUT
Message-ID: <cea5d9af-435a-4708-a937-59c7cbcb169e@linux.dev>
Date: Mon, 16 Nov 2026 11:21:06 +0800
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
Subject: Re: [PATCH v4 5/9] mm/vmalloc: BUG_ON() on an unaligned range in
 __vunmap_range_noflush()
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Dev Jain <dev.jain@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-6-hao.ge@linux.dev> <avWtxcH2mKw7dgbp@milan>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <avWtxcH2mKw7dgbp@milan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/11/12 20:15, Uladzislau Rezki wrote:
> On Tue, Nov 10, 2026 at 07:25:42PM +0800, Hao Ge wrote:
>> The PTE loop of the unmap path stops only at addr == end.  With an
>> unaligned end addr never lands on end, so the loop walks past the
>> range and keeps clearing.  With an unaligned start the loop begins
>> in the page containing start, which extends below the range.  Either
>> way the unmap clears the mappings adjacent to the range, and that is
>> nearly impossible to debug afterwards.
>>
>> vmap only installs page-aligned, page-granular mappings, so an
>> unaligned unmap request is never a legitimate teardown, and there is
>> no way to tell which pages the caller meant.  Check addr and end at
>> the entry of __vunmap_range_noflush() and bug out before any PTE is
>> cleared.
>>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/vmalloc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 86fbb1d2b27a..0565cbfe325c 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -518,6 +518,8 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
>>  	pgtbl_mod_mask mask = 0;
>>  
>>  	BUG_ON(addr >= end);
>> +	BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));
>> +
>>  	pgd = pgd_offset_k(addr);
>>  	do {
>>  		next = pgd_addr_end(addr, end);
>> -- 
>> 2.25.1
>>
> I am not sure this is good to stop machine at all. WARN_ON_ONCE()
> and return?

Folks tend to dislike BUG_ON. Dev suggested switching to this when I sent out v3.
That's fine. After all, nobody has hit this so far. I'll switch it to WARN_ON_ONCE
for the next version.

> 
> --
> Uladzislau Rezki

