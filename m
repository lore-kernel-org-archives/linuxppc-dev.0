Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B7D606A31C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NDeNazzc
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQBdD4CTLz2yKn;
	Thu, 12 Nov 2026 18:21:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.92
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794468064;
	cv=none; b=T/oYtOVZrI7gbRcHYgqVasA+inGfG/aABDDJYR+bbtGaw3ATIlNoCIXog6/wb0sLy2JkU5f8mwgOYu697g57Uhl6c5+N3nr2u9i9VzXgvWjqVXRcMKwSrfwZeA74N/j8HxYDDmwlPAPKTLKiPDE1jhulwJrid5UyKNEY0/BUOwuBtLVQ2X150BWTgSACpVvcM6fSrf59JOuh2U9ZQ5qrJhyp5p9UYoCqARnyTTgD9jttc6g8z6EU7k64nn930GOrHet9nkxvQAz5YnmE2/vwmQe1zVZsqnClHenB6B2X8+AD4LQIStHGLKiccVVjFDlBuvmRRLHX99FuPavR/1lQeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794468064; c=relaxed/relaxed;
	bh=3GObAzVicUC769Ed2LFARvtfjPhGbRDsMG32aEyAYQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaQUozhudodLdZ6+uQ81pH5pMwVCtoIfENBAek62j9YnX0D0p3P/Ai+TIJT4/svdhpQ3sAD6/0nlQbQE4qO2IC/i1qyVqJHSyf2rW4JyNgk6HIucEvD2SAyID3Mop5qdnxDiK+9Cou4mx5sY31HifEvp952W12AF1Er39X94HCrNkauchYO0wGoVQXm8JSiarRBb94pOIjRkXWy/78RHiEtryPlV/pnRQj2i4yZXCkIa0cA5CsWA/id8niTqswpG7CWZFMt7BRVW7mOeE5J7BcQwruydclZpfAlW5/sWBuK0hVsJTnYCsOy63bHw0nPKSJPe1kLAQU2qxEBTM9+RZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NDeNazzc; dkim-atps=neutral; spf=pass (client-ip=95.215.58.92; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NDeNazzc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.92; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-92.mta1.migadu.com [95.215.58.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQBd95M41z2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 18:21:00 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=dkOG8X97iyUWtRioal1Da3kor1MkKGE54K5m2vTuMmA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794468042; v=1; x=1795072842;
 b=NDeNazzc2NYXl5wHgkaQxUQ8AjB919HVNYVIb4QbDNHsxv6amVa2cSA00BbntsYsk5cJpkhG
 OJ2C61F0wX2KXAmZL8ZoveY/bZJb47ZUEf0J457Blm9rK99LD3+KE5jdKJHOps6k3nxE7PEcVJ0
 y4tsagCneKvin0hJCa1mXR8M=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 93c8f31eebf66027;
	Thu, 12 Nov 2026 07:20:37 +0000
X-Mizu-Trace-ID: 93c8f31eebf66027
X-Migadu-Flow: FLOW_OUT
Message-ID: <5f5e05bc-fdde-45c0-9034-75ae576ebdc9@linux.dev>
Date: Thu, 12 Nov 2026 15:22:02 +0800
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
Subject: Re: [PATCH v4 4/9] mm/vmalloc: BUG_ON() on an unaligned range in
 vmap_pages_range_noflush_walk()
To: Suren Baghdasaryan <surenb@google.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>,
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
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-5-hao.ge@linux.dev>
 <CAJuCfpGMtHZSUhUra9rp5xGvD+L6reopCMb3qXgRSctQ7wnYFg@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpGMtHZSUhUra9rp5xGvD+L6reopCMb3qXgRSctQ7wnYFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Suren

On 2026/11/12 08:16, Suren Baghdasaryan wrote:
> On Tue, Nov 10, 2026 at 11:24 AM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> The pte loop of vmap_pages_pte_range() maps whole pages and stops
>> only when addr lands exactly on end.  An unaligned end lets addr
>> jump over it and the loop keeps mapping into whatever follows the
>> range.  An unaligned start maps the page below the range with its
>> first pte.  That corruption is impossible to debug afterwards, so
>> bug out on addr and end at the entry of
>> vmap_pages_range_noflush_walk().
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/vmalloc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 27f2674a5556..86fbb1d2b27a 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -698,6 +698,8 @@ static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
>>         pgtbl_mod_mask mask = 0;
>>
>>         BUG_ON(addr >= end);
>> +       BUG_ON(!PAGE_ALIGNED(addr) || !PAGE_ALIGNED(end));
> 
> Instead of BUG_ON() here can we error out early in this function's
> callers (with or without a warning)? This is a static function with
> only 2 callers. vmap_pages_range_batched() uses it in a loop but I
> believe if we check the original address alignment then consequent
> calls are guaranteed to have aligned addresses.
>

One thing that worries me about checking in the callers, a new caller
of the walk can simply forget. 

If we take the approach raised after my patch 3, handling the
unaligned range with WARN instead of BUG, I am happy to do the WARN
here. Even the BUG_ON(addr >= end) above it can become WARN, because
it only fails this mapping. If the module is not that important, we
can ignore it and let the system keep going.

Thanks
Best Regards
Hao

>> +
>>         pgd = pgd_offset_k(addr);
>>         do {
>>                 next = pgd_addr_end(addr, end);
>> --
>> 2.25.1
>>

