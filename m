Return-Path: <linuxppc-dev+bounces-29459-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95887CC6B27
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 07:30:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4NBy6mcqz2ynZ;
	Wed, 14 Oct 2026 18:30:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:203:375::fc"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791963002;
	cv=none; b=dQZp1fVXPdTZ+diG92TPLwrhAJsxejZiq5EWf5YxUFzfDJtwx6dwg4OgmETu35Ezrbe2I6WHPIr3fzeTUzxaauyiJNp2u2XMNXLtMuhnYxpTuOrJ9Mny1YGtepdc1nl8ncIZ8C+oY3Y1ZSnzk+lbNOZXw68ZP+Px4CjP4O4uWzrtOry4lPXpj1X9vPeGiKmer8PAsWjth+ZkwJjjCIiCQNyuo2Ge0LsdAoeZVjfV2ynwwxu7FVOGrbp4cGlqlz9PBMdveYsQVEFP+3GBjgr8lj9wh1x5dJkwEldky+3D2g3jorTWq+gGlVKVZx1aJ+OAiJtyDkSQen7U80vHDQWHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791963002; c=relaxed/relaxed;
	bh=sKdAh4DSPDajzvJegyN5GGao4FMUHTTyQLWPRHfK9UI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kz9TNBONdHI7PJLSHoTzR29FomCAhY9VXOVZlSMTY/7x07yAQjnzO32uMyYqRD0MKm8f5IC0Gq2axiW/uD4Cq2feAiwj6g9rs7Bckmq2MDWHzxRD6wgULfUFEiWfUTKKMpLTJJFEme26VHB7yah7WUGeyhtbJb7z0HfGid9JMsEjrfkQsi3/WEiZUPeApylI1IvhYmbAQtw8xrEHPKZIDSvmJimNrfjKwIDvWJOi8NH3i4dClsrEfiAp0CebJbv7wyt3zRhAQVR7LdvUAHbwPNJVLi/EmML/qe38ZBXlynMl90XzTTSuCGBvSMNP3kW1PtedjTdjgPmGJXBFR5K3VQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SBFV9XRV; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:203:375::fc; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SBFV9XRV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::fc; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-252.mta1.migadu.com [IPv6:2001:41d0:203:375::fc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4NBv5TKqz2yYd
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2026 18:29:59 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=KIpg8DK6yUzBXoPal9V2gzxOahvuwx1OXybBEt4rIgk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791962981; v=1; x=1792567781;
 b=SBFV9XRVzu5cfNcVjTL6/iN3TVt1tW5tz+3rSIMj0r6YVCMBRykNexaHafZKt9EjVUO8uG25
 xa2rCOQdoStUF+FM2UAIc0vVoeeJ9bDpENNtxpSopEhfCL5kKA5eanNGbd5/0fFyCR4Vv+FYQ4T
 ZyaoueHY2Hn+ItyZC21+gTTc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id d0234dd56ab13b63;
	Wed, 14 Oct 2026 07:28:15 +0000
X-Mizu-Trace-ID: d0234dd56ab13b63
X-Migadu-Flow: FLOW_OUT
Message-ID: <bdcf2425-c0cf-48df-96a8-7ee1d23125d7@linux.dev>
Date: Wed, 14 Oct 2026 15:29:08 +0800
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
Subject: Re: [RFC PATCH 2/4] mm/vmalloc: undo partial mappings inside the
 mapping functions
To: Uladzislau Rezki <urezki@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20261009063619.112313-1-hao.ge@linux.dev>
 <20261009063619.112313-3-hao.ge@linux.dev>
 <CAJuCfpE9VfgTw2ZNMJTEVh41H_R+1RY_MtzeMuZNCD3BFm-Piw@mail.gmail.com>
 <as5epHFQF4iE_VQK@pc636>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <as5epHFQF4iE_VQK@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Uladzislau and Suren

On 2026/10/14 00:39, Uladzislau Rezki wrote:
> On Tue, Oct 13, 2026 at 03:23:14PM +0400, Suren Baghdasaryan wrote:
>> On Fri, Oct 9, 2026 at 10:36 AM Hao Ge <hao.ge@linux.dev> wrote:
>>>
>>> __vmap_pages_range_noflush() and friends can install some PTEs before
>>> failing and leave them mapped, and the kernel callers do not agree on
>>> who cleans them up. pcpu_map_pages() and kmsan_ioremap_page_range()
>>> roll back what they mapped before the failure, while
>>> vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
>>> __vmalloc_area_node() rely on the mapping functions cleaning up and
>>> do not call anything like vunmap_range() themselves. When the same
>>> range is mapped again, the attempt hits the leftovers and fails, with
>>> a BUG() in vmap_pte_range() for huge mappings and a warning on the
>>> small-page path.
>>>
>>> After discussing with Suren and Ulad, we decided to put the rollback
>>> into the entry points of the vmap API rather than into every low-level
>>> helper. __vmap_pages_range_noflush() undoes the whole range it was
>>> asked to map when it fails, and vmap_page_range() undoes its range
>>> for the ioremap-style mappings.
>>>
>>> The rollback is __vunmap_range_noflush(), it only clears the PTEs,
>>> no TLB flush, nothing has touched these mappings.
>>> vmap_pages_range_noflush() drops the KMSAN metadata when the data
>>> mapping fails, and an empty range bails out with -EINVAL now, which
>>> used to BUG_ON() on the small-page path and map nothing at all on
>>> the huge-page one.
>>>
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Suggested-by: Uladyslau Rezki <urezki@gmail.com>
>>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>>> ---
>>>  mm/vmalloc.c | 44 ++++++++++++++++++++++++++++++++------------
>>>  1 file changed, 32 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index db669103dc66..e1b376f57dd2 100644
>>> --- a/mm/vmalloc.c
>>> +++ b/mm/vmalloc.c
>>> @@ -363,6 +363,9 @@ int vmap_page_range(unsigned long addr, unsigned long end,
>>>         if (!err)
>>>                 err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
>>>                                                ioremap_max_page_shift);
>>> +       if (err)
>>> +               __vunmap_range_noflush(addr, end);
>>> +
>>>         return err;
>>>  }
>>>
>>> @@ -683,27 +686,35 @@ int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>>>                 pgprot_t prot, struct page **pages, unsigned int page_shift)
>>>  {
>>>         unsigned int i, nr = (end - addr) >> PAGE_SHIFT;
>>> +       unsigned long start = addr;
>>> +       int err = 0;
>>> +
>>> +       if (WARN_ON_ONCE(addr >= end))
>>> +               return -EINVAL;
>>>
>>>         if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
>>>                 return -EINVAL;
>>>
>>>         if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC) ||
>>> -                       page_shift == PAGE_SHIFT)
>>> -               return vmap_small_pages_range_noflush(addr, end, prot, pages);
>>> -
>>> -       for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
>>> -               int err;
>>> -
>>> -               err = vmap_range_noflush(addr, addr + (1UL << page_shift),
>>> +                       page_shift == PAGE_SHIFT) {
>>> +               err = vmap_small_pages_range_noflush(addr, end, prot, pages);
>>> +       } else {
>>> +               for (i = 0; i < nr; i += 1U << (page_shift - PAGE_SHIFT)) {
>>> +                       err = vmap_range_noflush(addr, addr + (1UL << page_shift),
>>>                                         page_to_phys(pages[i]), prot,
>>>                                         page_shift);
>>> -               if (err)
>>> -                       return err;
>>> +                       if (err)
>>> +                               break;
>>>
>>> -               addr += 1UL << page_shift;
>>> +                       addr += 1UL << page_shift;
>>> +               }
>>>         }
>>>
>>> -       return 0;
>>> +       /* Undo the PTEs installed before the failure. */
>>> +       if (err)
>>> +               __vunmap_range_noflush(start, end);
>>
>> Would it be too complicated to track how much was actually mapped and
>> unmap only that portion?
>>
> I think it is possible to vunmap the range which is already unmapped.
> i.e. in this case it is better to no to track anything as soon as a
> mapping failure is a corner case. Also it is more reliable without
> extra track logic.

Thank you both.
I take note of Suren's concerns. The worst case is a single PMD where only
the first page was installed, __vunmap_range_noflush() then loops 512 times
to undo one PTE, plus 511 empty ones.

And tracking the exact progress would require vmap_pages_p4d/pud/pmd_range()
to report how far they got. That also puts counting instructions on the successful
mapping path, while the saving only pays off on the failure one.

So I agree with Ulad.

Thanks
Best Regards
Hao

> 
> --
> Uladzislau Rezki

