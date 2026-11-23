Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40F606A31E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WTrfVq08
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY3jM3f4vz2xyj;
	Mon, 23 Nov 2026 22:33:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::46"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795433607;
	cv=none; b=CIap5pI36TenbPrfLhgbVDQ30Vhusd/sCRQHCHCgcxRkPaEsYzBuZNVWRbn1xOfwS+4XT2VjNDx5088j4M5/VxtB918iqIG8NxjS0krfLLdfX8HGk66Z/DTn4qEOdrfWVspPnyYX6oWaJPj/JW3cIXjbGZZEOkt7fgwO9M4BpHcP/LporVJEif/lWl3mEDamUUwsW5nTGEbWzhpQp5SlAAqARNngZA1xZAIPedFJgcK/DqWhMHR6++F4ZD8x7i23FCFw9HP6HiIscC9HmcYhsKf+XmR9gnxjVq1HoBHZatrljYxVlgJ2ppwPWq5biTkZ+raciiCceUUZYx72TGWuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795433607; c=relaxed/relaxed;
	bh=g/yjtbcg5So+54TQQrwZaOAyU8C7v2qrotK0MDLGBlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L/LqoDtFTTmsclmn6C0fnNytjxUO7uKO4y3dux/cs6WEGi5PIZMIYJlA29NYfLmVPhKgn7QwhrOBy5gXwx+42jP95tO4+Zx5ti2NKuRtjSL/1Zch5l3ikXU5R+nUWOz+gVJOf4BK8JQP7qr7lBJQmbhPIJm2yidTfpZrDdD4/HPdTO55AYo6/5ifbrqsE+fa/8TQWD52X8tSTjvZtFydp/cCzeshAimAnpi/7wKUsQ14y/k4oYR6tm0f6al0TEBDEZ09Q/YO8WR557IXJ+pnhI0zl6Z6QiAjKOeenb1RHEzl137Rcxq9tXK1ZDQKW5HiFwHxNJJcoIi2zjVtFyRpvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WTrfVq08; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::46; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WTrfVq08;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::46; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-70.mta1.migadu.com [IPv6:2001:41d0:203:375::46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY3jH2SpRz2xwP
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 22:33:16 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=EJgnsJKgFUNVuWQixFdvu+2zJ14nbsStpxGkd+Wpnts=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795433577; v=1; x=1796038377;
 b=WTrfVq08LkZEOI1ZPNilLy/If0IKJhvvY/gDlg1LlJiC047SiyuW7EevjWWerKUAaXJb20BW
 cnQQ5/ESEek/bGeynjCYTAHQulDaSQ+WXJU1qH+7/+981YeFj8iUirRy0V1hvXtHOB3ex+OHPgn
 r96lyXxIb4XkD4p51F62HMNc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 6b58d3fb24c8c492;
	Mon, 23 Nov 2026 11:32:57 +0000
X-Mizu-Trace-ID: 6b58d3fb24c8c492
X-Migadu-Flow: FLOW_OUT
Message-ID: <0e30c5c2-b9d0-40ea-b7f9-af9a8854bd58@linux.dev>
Date: Mon, 23 Nov 2026 19:32:48 +0800
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
Subject: Re: [PATCH v5 09/11] mm/vmalloc: undo what vmap_pages_range_batched()
 mapped on failure
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
 kasan-dev@googlegroups.com, linux-mm@kvack.org
References: <20261116071325.263682-1-hao.ge@linux.dev>
 <20261116071325.263682-10-hao.ge@linux.dev>
 <CAJuCfpF_=KV3ArFO5LtMjc4EGMr79tX_tX2K=YCG_JTvC51OfQ@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpF_=KV3ArFO5LtMjc4EGMr79tX_tX2K=YCG_JTvC51OfQ@mail.gmail.com>
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


On 2026/11/22 12:13, Suren Baghdasaryan wrote:
> On Sun, Nov 15, 2026 at 11:14 PM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> vmap_pages_range_batched() maps the range batch by batch. When a
>> batch fails, the batches before it are installed, and the failing
>> one may have installed some of its pages. mapped_end follows the
>> end of the last installed page, and the error path undoes
>> [addr, mapped_end), never past the point where the walk stopped.
>>
>> The KMSAN metadata is set up for the whole range up front, so it is
>> torn down as a whole when the mapping fails, like in
>> vmap_pages_range_noflush(). The only caller, vmap(), also calls
>> vunmap() on its error path; the double teardown only walks over PTEs
>> that are already cleared.
> 
> As I mentioned before I think this patch should be merged with patch 7.

Ack.

> 
>>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/vmalloc.c | 22 ++++++++++++++++------
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 28e65073624a..aa80bc273ec0 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -3748,13 +3748,14 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
>>         const unsigned int nr_pages = (end - addr) >> PAGE_SHIFT;
>>         unsigned int prev_shift = 0, batch_idx = 0, nr_mapped;
>>         unsigned long batch_start = addr, batch_end = addr;
>> +       unsigned long mapped_end = addr;
>>         int err;
>>
>>         err = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
>>                                              PAGE_SHIFT, GFP_KERNEL);
>>
>>         if (err)
>> -               goto out;
>> +               return err;
>>
>>         for (unsigned int i = 0; i < nr_pages; ) {
>>                 unsigned int shift = PAGE_SHIFT +
>> @@ -3764,9 +3765,10 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
>>                         prev_shift = shift;
>>
>>                 if (shift != prev_shift) {
>> -                       err = vmap_pages_range_noflush_walk(batch_start, batch_end,
>> -                                       prot, pages + batch_idx, prev_shift,
>> -                                       &nr_mapped);
>> +                       err = vmap_pages_range_noflush_walk(batch_start,
>> +                                       batch_end, prot, pages + batch_idx,
>> +                                       prev_shift, &nr_mapped);
>> +                       mapped_end = batch_start + (nr_mapped * PAGE_SIZE);
>>                         if (err)
>>                                 goto out;
>>                         prev_shift = shift;
>> @@ -3786,13 +3788,21 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
>>         }
>>
>>         /* Remaining */
>> -       if (batch_start < end)
>> +       if (batch_start < end) {
>>                 err = vmap_pages_range_noflush_walk(batch_start, end, prot,
>>                                 pages + batch_idx, prev_shift, &nr_mapped);
>> +               mapped_end = batch_start + (nr_mapped * PAGE_SIZE);
>> +       }
>>
>>  out:
>> -       if (!err)
>> +       if (err) {
>> +               /* Undo the part the batches installed before they failed. */
>> +               if (mapped_end > addr)
>> +                       __vunmap_range_noflush(addr, mapped_end, true);
>> +               kmsan_vunmap_range_noflush(addr, end, true);
> 
> So, you are unmapping (addr, mapped_end) range but removing KMSAN
> metadata for the entire (addr, end) range. Is that intended?

Yes, that is intended. The metadata for the whole range is set up
before the mapping starts, kmsan_vmap_pages_range_noflush() at the top
of vmap_pages_range_batched() installs the shadow and origin pages for
the entire [addr, end) in one go. So on failure the metadata is fully
installed and has to go as a whole, while the page tables only reached
mapped_end and are undone up to there.

I know this looks somewhat awkward. The asymmetry comes from the metadata
having to be set up before the mapping starts, I don't see a way to avoid it.
Maybe add a comment explaining this?

WDYT?

Thanks
Best Regards
Hao

> 
>> +       } else {
>>                 flush_cache_vmap(addr, end);
>> +       }
>>         return err;
>>  }
>>
>> --
>> 2.25.1
>>

