Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98A3606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Nov 2026 12:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nNTMQvVV
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jP5WT115Tz2yQJ;
	Tue, 10 Nov 2026 23:27:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.50
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794313637;
	cv=none; b=STz4xssgAEC90zVN0U6K+2xkPx0whizgGNwaU5s0oQj1wfqHkqA2cyc7vVceP0cEwUGYJNJODjQ/N1CldO7jEGeNws8kWv8UcTV2uRhKfVcFB1G7oPURbofeuT4+P4VhXyByI2fJpIXnCdAewDCDC4lNiVuPOIMiyESLplNlGTMi1MTsoq3wgU4ne4kUHrt8O92yfvbzH/vc2LCZEyiwoxkuYwDTJyeDFnFn3ttUYkJ/q9dtJqnRPR1hYIXBm0DHe5kYhRzVkB0CVMqSgmkVvem5nXeDjloxJ02vbXCfURMu8ScdSiupc7kqkHsLIjn5WADSDIn6Hxy5Y6rlzSp/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794313637; c=relaxed/relaxed;
	bh=28sGp94tB7+IhB+9l8EsVNP6ycTUbA9Myz4BYRq9KRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PATzlSZdebYznJOYimY9NVP/xJtc1DBgK7kMAfMw8F3kR71yShYpjHHgA0s6p95PDhGUufHShrFLf6wkTnhxiGyzcm9wdceKba8q6Rh71VAGmkJKx9SG8RA+AYxN7OXdpGL0HbxABbX+AjUNsjb0crQV1wz/rrPZm+3hrEOgoFX7IjAbztfOwHvZO8N6OOborHz70/T6jxs8jfc6On/QOqWwCEwTKt9C1SPS3qVEVtj7kxF7TToCQCoSWe5ravnplc0ntz0lCm4ZZi6PT3g6LvNlE0pG71Vz5u9a2yCFHRcYWKM+E8X4MPZaJGd/Z99hVmqveLihDCim4EZobk4rBA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nNTMQvVV; dkim-atps=neutral; spf=pass (client-ip=95.215.58.50; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nNTMQvVV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.50; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-50.mta1.migadu.com [95.215.58.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jP5WM0Yjzz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Nov 2026 23:27:09 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=NCdTdpmEhDXCpYswlDrvsbAlShAGzLjABHUDQP5sSb0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794313610; v=1; x=1794918410;
 b=nNTMQvVVeAC1i8sMsLB+5AuP2lG1OvGYeMqJVvCmO6SPtecc/lBQtR5V4LIlzFQVnTNM0Gqg
 FesuNJUQAdp5Ox6Dg874N2rEpRQNUywOXcTw4giN1HEdkqGjSRrzBq5W7SEnPPzDf71iUAqB+Gq
 cjR6XazRuoFObP9EEclN38as=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 554be337fc97911a;
	Tue, 10 Nov 2026 12:26:50 +0000
X-Mizu-Trace-ID: 554be337fc97911a
X-Migadu-Flow: FLOW_OUT
Message-ID: <f416f84a-03de-49fd-ab67-d86ed4dec633@linux.dev>
Date: Tue, 10 Nov 2026 20:28:10 +0800
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
Subject: Re: [PATCH v4 3/9] mm/vmalloc: BUG_ON() on an unaligned range in
 vmap_range_noflush()
To: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Dmitry Vyukov <dvyukov@google.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Tejun Heo <tj@kernel.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@gentwo.org>
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-4-hao.ge@linux.dev>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20261110112546.261415-4-hao.ge@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/11/10 19:25, Hao Ge wrote:
> commit a739e6b557af ("mm: vmalloc: WARN_ON if mapping size is not
> PAGE_SIZE aligned") put the check in vmap_pte_range(), which is too
> late, because the upper levels may already have installed page
> tables for a range that is rejected anyway.
> 
> The pte loop maps whole pages and stops only when addr lands
> exactly on end.  An unaligned end lets addr jump over it and the
> loop keeps mapping past the range.  An unaligned start maps the
> page below the range and usually misses end too.  Such a range is
> never a legitimate request, and the corruption it leaves behind is
> hard to attribute to the caller afterwards, so bug out on addr and
> end at the entry of vmap_range_noflush() and drop the check from
> vmap_pte_range().
> 
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/vmalloc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 093b8d5f7b0e..27f2674a5556 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -125,9 +125,6 @@ static int vmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	unsigned long size;
>  	unsigned int nr_pages;
>  
> -	if (WARN_ON_ONCE(!PAGE_ALIGNED(end - addr)))
> -		return -EINVAL;
> -
>  	pfn = phys_addr >> PAGE_SHIFT;
>  	pte = pte_alloc_kernel_track(pmd, addr, mask);
>  	if (!pte)
> @@ -347,6 +344,7 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
>  	 */
>  	might_sleep();
>  	BUG_ON(addr >= end);
> +	BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));

I know BUG_ON() is ugly and it was not my first choice either, but I
have not figured out a better way to handle __vunmap_range_noflush().

If an unaligned range is passed to it, the pte loop may clear PTEs
adjacent to the range. Say a caller passes [3, 12) while [0, 3)
belongs to somebody else. The loop operates on whole pages, so it
starts at the page containing 3 and clears [0, 3) with it. That
silently corrupts a live mapping, and the corruption is not detected
until the owner touches the page. Bugs like that are nearly
impossible to debug afterwards.

It is not feasible for __vunmap_range_noflush() to just return an
invalid-argument error upfront. Its job is to clear PTEs, and an
early return leaves the residual PTEs behind.

I also thought about warning and returning -EINVAL on the map side
and keeping BUG_ON() only in __vunmap_range_noflush(), but the
rollback kills that idea.

int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
                pgprot_t prot, struct page **pages, unsigned int page_shift,
                gfp_t gfp_mask)
{
        int err;

        if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
                return -EINVAL;

        if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC))
                page_shift = PAGE_SHIFT;

        err = vmap_pages_range_noflush_walk(addr, end, prot, pages, page_shift);

        /* Undo the PTEs installed before the failure. */
        if (err)
                __vunmap_range_noflush(addr, end,
                                       gfpflags_allow_blocking(gfp_mask));

        return err;
}

If the walk WARNs and returns -EINVAL for a bad range, the undo
above passes that same range to __vunmap_range_noflush(), and we
BUG right after the WARN. vmap_page_range() runs into the same
thing on its error path.

So the map side cannot warn while the unmap side BUGs, the rollback
drags the rejected range into the unmap anyway. And the unmap side
cannot warn and skip either, that leaves the stale PTEs.

Also, these checks are the last line of defense. All in-tree callers
pass page aligned, non-empty ranges, and I am not aware of anyone ever
hitting this line. So for correct code the BUG_ON never fires at all,
no user will ever see it. The only one who can trip it is the developer
who just passed the bad range, and for him a stack trace right at the
spot is much better than chasing a silent corruption afterwards.

I settled on BUG_ON here. It may not be an ideal solution, but if anyone
has a better idea or alternative approach, please let me know.
I would greatly appreciate it.

Thanks
Best Regards
Hao

>  
>  	start = addr;
>  	pgd = pgd_offset_k(addr);

