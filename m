Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C33C606A321
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Nov 2026 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sq8YyyCq
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZDwK09H6z2xL4;
	Wed, 25 Nov 2026 20:32:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::5f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795599120;
	cv=none; b=cLnaxWLI17eO8BNJRWXOPDglBHUQESAMnNFs0oUIbA4rPSJOsZ67qoARIPGhu9V6Ju3Y2pI6FV8lW8digg2NnSq2pSosTMJGXWFXHEpJ6Yd3H9QLse1TU6st9AfOSVzaAbsY0zac7YFqm32dWm3yGvCk3PqeNN0EkLud03zoHqUZ6/fk0UkATBO5Vlq9ShtnfjP8fdeeHgmGZkOwlRA5FSu0El68mCcNBAitq8luIvRct9kwKpo2rwjxEH9zljinkYueuuaEAHURGTIEnOnjG22B7yRHHXKBLY6WtqY5Q3Afyw5yPzYgrlfo8/G//3EQ7tapvs2BCH+VSf4ncIVhEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795599120; c=relaxed/relaxed;
	bh=0t3yaiYq49eJNhyVmgpMO6uB/jPaQ0b3Gb0soo4gfAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGYJ4mSlTKZmIPUumolvHoQHs2TSZe5/tVeQ0breArRIIbxvDIJ8L/A2z6F+EGTBXWFWbhcyQ7WVhQtvxz4ZGr6zY2NheJVD+63EqCdQjMi8sRd9oeMNphKSwyrk/zn5u8AmZ48G5PEd38aPdjjgpy3ldMUBWDeTcu6Q6BD+qCHxts60A4mYE0BBTSHgk8ROKk3DXh8iKzrg+QOK5xzrwQs5tahcVtbNCsBqMCgde4IJQs9FvBpJQcn5t/sJCFbum27d+gvBhiybXIsdLrpeWzqFQE8ziBled75qtiDAmylBYzp+btEP+R+ofrXy2kVkgKHuHJsM/1efqG1yVb9/sw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sq8YyyCq; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::5f; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=sq8YyyCq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::5f; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-95.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jZDwF4hHqz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2026 20:31:55 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=jWng7U13BDQmuoHoZtAwtlO9p/HGoFdvP6Svn7/G2Lo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795599092; v=1; x=1796203892;
 b=sq8YyyCqCSynK6LYfT0t+IFE3WlevVXmrJK3E1O16fRUQXV0Jqa3OgXdJmls+i8EC2+TKlUp
 PX3La5vZufRwNgS+lbGtqnQVre8xrqEkdqWln2ntsWEa5+iOgv7quapCKHJcyo4nLMFeNIouS+E
 BS+Z3fniDkZ7PGNrfnphBSkg=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 16ae719c9c2b2084;
	Wed, 25 Nov 2026 09:31:32 +0000
X-Mizu-Trace-ID: 16ae719c9c2b2084
X-Migadu-Flow: FLOW_OUT
Message-ID: <837d7783-0300-4bc1-a78b-620084af08cc@linux.dev>
Date: Wed, 25 Nov 2026 17:31:21 +0800
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
To: Suren Baghdasaryan <surenb@google.com>,
 Uladzislau Rezki <urezki@gmail.com>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
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
 <0e30c5c2-b9d0-40ea-b7f9-af9a8854bd58@linux.dev>
 <CAJuCfpE7S3uTX2rqEkmYqhO6zuqTKtDH88w20m1_fMHF8L672Q@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpE7S3uTX2rqEkmYqhO6zuqTKtDH88w20m1_fMHF8L672Q@mail.gmail.com>
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

On 2026/11/24 00:13, Suren Baghdasaryan wrote:
> On Mon, Nov 23, 2026 at 3:32 AM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> Hi Suren
>>
>>
>> On 2026/11/22 12:13, Suren Baghdasaryan wrote:
>>> On Sun, Nov 15, 2026 at 11:14 PM Hao Ge <hao.ge@linux.dev> wrote:
>>>>
>>>> vmap_pages_range_batched() maps the range batch by batch. When a
>>>> batch fails, the batches before it are installed, and the failing
>>>> one may have installed some of its pages. mapped_end follows the
>>>> end of the last installed page, and the error path undoes
>>>> [addr, mapped_end), never past the point where the walk stopped.
>>>>
>>>> The KMSAN metadata is set up for the whole range up front, so it is
>>>> torn down as a whole when the mapping fails, like in
>>>> vmap_pages_range_noflush(). The only caller, vmap(), also calls
>>>> vunmap() on its error path; the double teardown only walks over PTEs
>>>> that are already cleared.
>>>
>>> As I mentioned before I think this patch should be merged with patch 7.
>>
>> Ack.
>>
>>>
>>>>
>>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>>> ---
>>>>  mm/vmalloc.c | 22 ++++++++++++++++------
>>>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>> index 28e65073624a..aa80bc273ec0 100644
>>>> --- a/mm/vmalloc.c
>>>> +++ b/mm/vmalloc.c
>>>> @@ -3748,13 +3748,14 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
>>>>         const unsigned int nr_pages = (end - addr) >> PAGE_SHIFT;
>>>>         unsigned int prev_shift = 0, batch_idx = 0, nr_mapped;
>>>>         unsigned long batch_start = addr, batch_end = addr;
>>>> +       unsigned long mapped_end = addr;
>>>>         int err;
>>>>
>>>>         err = kmsan_vmap_pages_range_noflush(addr, end, prot, pages,
>>>>                                              PAGE_SHIFT, GFP_KERNEL);
>>>>
>>>>         if (err)
>>>> -               goto out;
>>>> +               return err;
>>>>
>>>>         for (unsigned int i = 0; i < nr_pages; ) {
>>>>                 unsigned int shift = PAGE_SHIFT +
>>>> @@ -3764,9 +3765,10 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
>>>>                         prev_shift = shift;
>>>>
>>>>                 if (shift != prev_shift) {
>>>> -                       err = vmap_pages_range_noflush_walk(batch_start, batch_end,
>>>> -                                       prot, pages + batch_idx, prev_shift,
>>>> -                                       &nr_mapped);
>>>> +                       err = vmap_pages_range_noflush_walk(batch_start,
>>>> +                                       batch_end, prot, pages + batch_idx,
>>>> +                                       prev_shift, &nr_mapped);
>>>> +                       mapped_end = batch_start + (nr_mapped * PAGE_SIZE);
>>>>                         if (err)
>>>>                                 goto out;
>>>>                         prev_shift = shift;
>>>> @@ -3786,13 +3788,21 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
>>>>         }
>>>>
>>>>         /* Remaining */
>>>> -       if (batch_start < end)
>>>> +       if (batch_start < end) {
>>>>                 err = vmap_pages_range_noflush_walk(batch_start, end, prot,
>>>>                                 pages + batch_idx, prev_shift, &nr_mapped);
>>>> +               mapped_end = batch_start + (nr_mapped * PAGE_SIZE);
>>>> +       }
>>>>
>>>>  out:
>>>> -       if (!err)
>>>> +       if (err) {
>>>> +               /* Undo the part the batches installed before they failed. */
>>>> +               if (mapped_end > addr)
>>>> +                       __vunmap_range_noflush(addr, mapped_end, true);
>>>> +               kmsan_vunmap_range_noflush(addr, end, true);
>>>
>>> So, you are unmapping (addr, mapped_end) range but removing KMSAN
>>> metadata for the entire (addr, end) range. Is that intended?
>>
>> Yes, that is intended. The metadata for the whole range is set up
>> before the mapping starts, kmsan_vmap_pages_range_noflush() at the top
>> of vmap_pages_range_batched() installs the shadow and origin pages for
>> the entire [addr, end) in one go. So on failure the metadata is fully
>> installed and has to go as a whole, while the page tables only reached
>> mapped_end and are undone up to there.
>>
>> I know this looks somewhat awkward. The asymmetry comes from the metadata
>> having to be set up before the mapping starts, I don't see a way to avoid it.
>> Maybe add a comment explaining this?
> 
> Are there any side-effects like the one we found earlier with
> unmapping PTEs which we never installed?

I haven't found any so far. If I've missed a scenario, please
do let me know.

I remain unsure whether kmsan_vunmap_range_noflush() needs a
TLB flush - I already brought this up in the thread for
patch 2.

> I don't think a comment is needed as it's quite obvious.
>

OK.

Thanks again for your and Ulad'careful and patient review of this series.
I recognise this version is a bit messy - I had a lot going on at the time,
and I apologise for that.

I'll take that into account and keep improving.

Thanks
Best Regards
Hao

>>
>> WDYT?
>>
>> Thanks
>> Best Regards
>> Hao
>>
>>>
>>>> +       } else {
>>>>                 flush_cache_vmap(addr, end);
>>>> +       }
>>>>         return err;
>>>>  }
>>>>
>>>> --
>>>> 2.25.1
>>>>

