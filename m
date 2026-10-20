Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA61606A319
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2026 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Eu5CzCZv
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7x9c2ws2z2yjp;
	Tue, 20 Oct 2026 13:26:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::9a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792463172;
	cv=none; b=QqKwnyR12t5uoWhZhIm1mKYlaS6WXSlrMuMWwp7Ftbi1Yu0lmgryc6EdJJdHW8fIOOHwmei1A9bGvfvGWZVoFq4HFJXSsxxHU2IzxzWRVANpEudzLfwFYkb+m0LStsvEgz1U6VOF5xRSYjRLzDFGLRSIXrGkCgFVKh5V0T8ibr6l7RRifvLPCk9CENyPHujw+02Qm1US++b5IY3THfEjBL6I14c+1W45Q1fOY2GX2/jrrCnLetTce5n1NWkj8UDt7MmEJZV0ORS92IUk2QaEMcABNiMtphxRPwX1vE9wIRRdXTfjZtPgw+ZgBJZZ8iA6RKVlV771KffqNCEsEcmQXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792463172; c=relaxed/relaxed;
	bh=qkEnDwBugjwZfgs/RO2JOZXA4QXBERjlTcHQBq6IyoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EqDLMJOioELcpNnVp+aebjbo1O8D0gfdDPzDhqDWb6Cjl9F+98CGaYUi3V7NAjE6U+o8HGj2wzx1tfXj/5KtYgc4BPItEqW4ekVCPYNXLDe1/O8k65aueC57wMlhSn+NxfXtDaxodNRZ+ShrNQHFXthH5wSz9C6Uq76FLwfQcLtdXlwbidAycNl8kt4slYs09Aul9hRqh2DO0HQ7Vr3YfE99k7D926kVtV6AIqaeJOnSdtHAyoDfrRcJpzk7IrenmdBZSTuD+EJpc3DjKZDwYkfBztbJ/Xm+au3y1nvxBnl6JV/jWOJHIOkXIVBuUGx3WKjRmXcfcCVxNqLVUCVn/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Eu5CzCZv; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::9a; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Eu5CzCZv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::9a; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-154.mta0.migadu.com [IPv6:2001:41d0:1004:224b::9a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7x9X604yz2yRn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2026 13:26:06 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=ntRwUSpnw+xfJNy+369eirj2tCJL/FP5kPFnotn1kaE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792463147; v=1; x=1793067947;
 b=Eu5CzCZvzQRuuCA4jfdags9tIDsCpkho05xTr2bk25NTRylCoWFFZqCdb74tCez1dfqXk84q
 tgTmzMKC43zv9NP6sLhL3AIRUHbkLEMLC3urYJ0LR4W7AArVMfTJYhRpYT2Ptn9m09VoCsXi1f9
 3Ya8E92vFRKlQukG0nRQFpiQ=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 5b8ad6c55f67365a;
	Tue, 20 Oct 2026 02:25:47 +0000
X-Mizu-Trace-ID: 5b8ad6c55f67365a
X-Migadu-Flow: FLOW_OUT
Message-ID: <b0d303c5-4ca5-4ccf-9e24-499a9719a50e@linux.dev>
Date: Tue, 20 Oct 2026 10:26:55 +0800
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
Subject: Re: [PATCH v2 2/5] mm/kmsan: skip vunmap_range_noflush when KMSAN is
 disabled
To: Dev Jain <dev.jain@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org,
 Suren Baghdasaryan <surenb@google.com>, Uladzislau Rezki <urezki@gmail.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>
References: <20261019054531.87652-1-hao.ge@linux.dev>
 <20261019054531.87652-3-hao.ge@linux.dev>
 <3cbb17e3-e201-4138-a070-0c64289a12bb@arm.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <3cbb17e3-e201-4138-a070-0c64289a12bb@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dev

On 2026/10/19 23:22, Dev Jain wrote:
> 
> 
> On 19/10/26 11:15 am, Hao Ge wrote:
>> kmsan_vmap_pages_range_noflush() returns 0 when kmsan_enabled is
>> false.  The unmap side does not, so it still walks the shadow and
>> origin page tables even though KMSAN never installed any metadata
>> there.
>>
>> Add the matching early return.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Cc: stable@vger.kernel.org
> 
> Cc stable without fixes?

Oops, my bad. The Cc stable was added mistakenly.

> 
> I guess without the fix nothing is actually wrong, except doing
> wasteful work?
> 
>
That was true before, but not anymore after Patch 3
(mm/vmalloc: undo partial mappings inside the mapping functions).
vmap_pages_range_noflush() now does:

int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
                pgprot_t prot, struct page **pages, unsigned int page_shift,
                gfp_t gfp_mask)
{
        int ret = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
                                                page_shift, gfp_mask);

        if (ret)
                return ret;

        ret = __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
        /*
         * The page tables undo themselves on failure. Tear down the
         * metadata that was fully set up before the mapping failed.
         */
        if (ret)
                kmsan_vunmap_range_noflush(addr, end);

        return ret;
}

Sashiko report: with !kmsan_enabled and a caller passing an empty range
(addr >= end) the flow is:

1. kmsan_vmap_pages_range_noflush() returns 0 at its first check, it
   never looks at the range.

2. __vmap_pages_range_noflush() hits the new WARN_ON_ONCE(addr >= end)
   and returns -EINVAL.   

3. ret is non-zero now, so the rollback calls kmsan_vunmap_range_noflush(addr, end),
   which unconditionally does

	__vunmap_range_noflush(vmalloc_shadow(start),vmalloc_shadow(end));

   vmalloc_shadow() is a fixed offset, so the shadow range is empty too, and
   __vunmap_range_noflush() starts with BUG_ON(addr >= end). Panic. 

So the guard is not about the empty range itself: a caller passing an
empty range is buggy, and on today's kernels it already BUG_ON() in
vmap_small_pages_range_noflush() on the small-page path. Patch 3                                                                     
deliberately turns that into WARN_ON_ONCE() + -EINVAL, and this patch                                                                
makes sure the new metadata rollback does not turn that recoverable                                                                  
error back into a panic when KMSAN is disabled.     

But it's only theoretical. We haven't hit this case in real usage.
We add this guard merely to reduce unnecessary work, and incidentally
harden Patch 3.

Thanks for pointing this out.

Best Regards
Hao

>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/kmsan/hooks.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
>> index a706666db097..107f66841274 100644
>> --- a/mm/kmsan/hooks.c
>> +++ b/mm/kmsan/hooks.c
>> @@ -138,6 +138,9 @@ static unsigned long vmalloc_origin(unsigned long addr)
>>  
>>  void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
>>  {
>> +	if (!kmsan_enabled)
>> +		return;
>> +
>>  	__vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
>>  	__vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
>>  	flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
> 

