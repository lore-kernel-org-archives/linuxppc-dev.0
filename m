Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BEC606A32A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oR3Dklxi
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY2mj6Y95z2xwP;
	Mon, 23 Nov 2026 21:51:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::a2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795431077;
	cv=none; b=i0ZZ6/WWX2bgThOgoAAeiv+89KTGCU8jtj6UyrDuI3mp1ptMCWpJWm0n6k7SQNxAd3JYObQLoteNtehC9VoWr86gt2HRbHpZlyJ2COABT0TtE9pZVsdzc3AMsQzhon1jvpuglhWdk1ntZFUBVCUf69MXYPwuQWTFdRF/RzSaSkCyJIYDD7V6NUnvl+3mDYQRO9UZcuQ7qYP+2EdWwIlxJ8x1YXGltqye6EN7JwewWbkJyFPvW5ZXwAY2dMnf/gmDaXtz6AkbQsAltKmhrS3Bj5JXkdqJNhvtA8Z/bQn9dKYxG6aZt4U1XYbR7VRVp1LDIeZGxFJGZY7dffX76a1uWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795431077; c=relaxed/relaxed;
	bh=vhvizTOCvV4TIlk2GcF40P/D+TPRIEQFdThENdsfieo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caT+4fqFJr8hqA11Q4Stp9qprQJc9jecBK/D7eF9t+AVuBJA7RSlig2+ilzz7laqESM8oqaLEW8DKbFQ6wE8DvxBTsOkWXNxso5SvqFQsGsvU5J/1A54rN1b1t0bv+cyJ5+ifLY090eniZG9oxeF35F8tOLIEEycdgMyXpXA8GP/yS19GJ1PmHIZhv5i04mjPHqQmpB4QcObRX7Pd5tcrg9sXaxnF5cve4Vq51xsXNaLJGqP5Y+HVYulyAcaSvRT1BfXLhR9h0SottyZtg+JxFnVkR7suzCjogMrMDmeMLsjptYljdGy1kaG41d1eCM1fi475EHNOV3LLMuStRRl0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oR3Dklxi; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::a2; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oR3Dklxi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::a2; helo=mta0.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-162.mta0.migadu.com [IPv6:2001:41d0:1004:224b::a2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY2mf557jz2xLh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 21:51:11 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=viMFF8KDVrzt4/XX4zUzvKF7yd+58lRueswEeUuhWIA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795431048; v=1; x=1796035848;
 b=oR3DklxiA5CoSXAZwGsWaPrByW1kvROR7Kr3EoFwViPCxlgljJ+wob3xqCEsNUDPT8i4+ST3
 L7NIxTpQLucT7oY9wprkbBPdYbIZjVyg2v7V1n+r5GQj/tG3KRlrJvckZeMy4Jcr7lQV2yd5Ln4
 1fKa6HHBU/ZzBB6IKR2uZSHY=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 6aa3c8c191b175a9;
	Mon, 23 Nov 2026 10:50:35 +0000
X-Mizu-Trace-ID: 6aa3c8c191b175a9
X-Migadu-Flow: FLOW_OUT
Message-ID: <7fad5338-7e9e-4fcf-b369-20f80639a9e4@linux.dev>
Date: Mon, 23 Nov 2026 18:50:28 +0800
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
Subject: Re: [PATCH v5 07/11] mm/vmalloc: undo what
 __vmap_pages_range_noflush() mapped on failure
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
 <20261116071325.263682-8-hao.ge@linux.dev>
 <CAJuCfpFvA5oqop2tovy33fKydx7n8Sm=X-hE0sJxpcR1gg5hMA@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpFvA5oqop2tovy33fKydx7n8Sm=X-hE0sJxpcR1gg5hMA@mail.gmail.com>
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

On 2026/11/22 11:58, Suren Baghdasaryan wrote:
> On Sun, Nov 15, 2026 at 11:14 PM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> __vmap_pages_range_noflush() maps a struct page array and may fail
>> half way. The ptes installed so far stay behind, so a retry of the
>> same range, the __GFP_NOFAIL loop in __vmalloc_area_node() or the
>> module tags populate, trips the WARN_ON(!pte_none()) in
>> vmap_pages_pte_range() and fails with -EBUSY.
>>
>> vmap_pages_range_noflush_walk() now reports how many pages it
>> installed through its running index into the pages array, and
>> __vmap_pages_range_noflush() undoes [addr, addr + mapped_pages *
>> PAGE_SIZE) on failure. vmap_pages_pte_range() fails with -EBUSY
>> instead of installing over a pte that is already set, so the ptes
>> below that point are all ours, while a pte above it can only have
>> been put there by somebody else, for example when the caller's range
>> overlaps an existing mapping. Going further would clear ptes that
>> are not ours.
>>
>> This path can run with a non-blocking gfp mask, the undo passes
>> gfpflags_allow_blocking() as can_resched.
>>
>> Suggested-by: Suren Baghdasaryan <surenb@google.com>
>> Suggested-by: Uladzislau Rezki <urezki@gmail.com>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  mm/kmsan/hooks.c  |  4 ++--
>>  mm/kmsan/shadow.c |  4 ++--
>>  mm/vmalloc.c      | 36 +++++++++++++++++++++++++++++-------
>>  mm/vmalloc.h      |  3 ++-
>>  4 files changed, 35 insertions(+), 12 deletions(-)
>>
>> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
>> index 69008b085658..d830a4e649f1 100644
>> --- a/mm/kmsan/hooks.c
>> +++ b/mm/kmsan/hooks.c
>> @@ -208,7 +208,7 @@ int kmsan_ioremap_page_range(unsigned long start, unsigned long end,
>>                 mapped = __vmap_pages_range_noflush(
>>                         vmalloc_shadow(start + off),
>>                         vmalloc_shadow(start + off + PAGE_SIZE), prot, &shadow,
>> -                       PAGE_SHIFT);
>> +                       PAGE_SHIFT, gfp_mask);
>>                 if (mapped) {
>>                         err = mapped;
>>                         goto ret;
>> @@ -218,7 +218,7 @@ int kmsan_ioremap_page_range(unsigned long start, unsigned long end,
>>                 mapped = __vmap_pages_range_noflush(
>>                         vmalloc_origin(start + off),
>>                         vmalloc_origin(start + off + PAGE_SIZE), prot, &origin,
>> -                       PAGE_SHIFT);
>> +                       PAGE_SHIFT, gfp_mask);
>>                 if (mapped) {
>>                         err = mapped;
>>                         goto ret;
>> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
>> index 212449db34a1..452760a333e4 100644
>> --- a/mm/kmsan/shadow.c
>> +++ b/mm/kmsan/shadow.c
>> @@ -247,7 +247,7 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>>         origin_end = vmalloc_meta((void *)end, KMSAN_META_ORIGIN);
>>         kmsan_enter_runtime();
>>         mapped = __vmap_pages_range_noflush(shadow_start, shadow_end, prot,
>> -                                           s_pages, page_shift);
>> +                                           s_pages, page_shift, gfp_mask);
>>         kmsan_leave_runtime();
>>         if (mapped) {
>>                 err = mapped;
>> @@ -255,7 +255,7 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>>         }
>>         kmsan_enter_runtime();
>>         mapped = __vmap_pages_range_noflush(origin_start, origin_end, prot,
>> -                                           o_pages, page_shift);
>> +                                           o_pages, page_shift, gfp_mask);
>>         kmsan_leave_runtime();
>>         if (mapped) {
>>                 /* Undo the shadow mapping set up above. */
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 5c1eacc2a0ac..4f3c320a4849 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -725,7 +725,8 @@ static int vmap_pages_p4d_range(pgd_t *pgd, unsigned long addr,
>>   * may have contiguous chunks, as hinted by @shift.
>>   */
>>  static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
>> -               pgprot_t prot, struct page **pages, unsigned int shift)
>> +               pgprot_t prot, struct page **pages, unsigned int shift,
>> +               unsigned int *mapped_pages)
>>  {
>>         unsigned long start = addr;
>>         pgd_t *pgd;
>> @@ -748,6 +749,7 @@ static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
>>         if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
>>                 arch_sync_kernel_mappings(start, end);
>>
>> +       *mapped_pages = nr;
>>         return err;
>>  }
>>
>> @@ -758,18 +760,36 @@ static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
>>   * The caller is responsible for calling flush_cache_vmap() after this
>>   * function returns successfully and before the addresses are accessed.
>>   *
>> + * On failure the PTEs installed by this call are torn down before
>> + * returning, so a retry sees a clean range; PTEs that were already
>> + * there when the walk failed are left alone. When @gfp_mask cannot
>> + * block, the teardown skips cond_resched(), it may run in atomic
>> + * context.
>> + *
>>   * This is an internal function only. Do not use outside mm/.
>>   */
>>  int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>> -               pgprot_t prot, struct page **pages, unsigned int page_shift)
>> +               pgprot_t prot, struct page **pages, unsigned int page_shift,
>> +               gfp_t gfp_mask)
>>  {
>> +       int err;
>> +       unsigned int mapped_pages = 0;
>> +
>>         if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
>>                 return -EINVAL;
>>
>>         if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC))
>>                 page_shift = PAGE_SHIFT;
>>
>> -       return vmap_pages_range_noflush_walk(addr, end, prot, pages, page_shift);
>> +       err = vmap_pages_range_noflush_walk(addr, end, prot, pages, page_shift,
>> +                                           &mapped_pages);
>> +
>> +       /* Undo the PTEs installed before the failure. */
>> +       if (err && mapped_pages)
>> +               __vunmap_range_noflush(addr, addr + (mapped_pages * PAGE_SIZE),
>> +                                      gfpflags_allow_blocking(gfp_mask));
>> +
>> +       return err;
>>  }
>>
>>  int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>> @@ -781,7 +801,8 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>>
>>         if (ret)
>>                 return ret;
>> -       return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
>> +       return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift,
>> +                                         gfp_mask);
>>  }
>>
>>  static int __vmap_pages_range(unsigned long addr, unsigned long end,
>> @@ -3715,7 +3736,7 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
>>                 pgprot_t prot, struct page **pages)
>>  {
>>         const unsigned int nr_pages = (end - addr) >> PAGE_SHIFT;
>> -       unsigned int prev_shift = 0, batch_idx = 0;
>> +       unsigned int prev_shift = 0, batch_idx = 0, nr_mapped;
>>         unsigned long batch_start = addr, batch_end = addr;
>>         int err;
>>
>> @@ -3734,7 +3755,8 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
>>
>>                 if (shift != prev_shift) {
>>                         err = vmap_pages_range_noflush_walk(batch_start, batch_end,
>> -                                       prot, pages + batch_idx, prev_shift);
>> +                                       prot, pages + batch_idx, prev_shift,
>> +                                       &nr_mapped);
>>                         if (err)
>>                                 goto out;
>>                         prev_shift = shift;
>> @@ -3756,7 +3778,7 @@ static int vmap_pages_range_batched(unsigned long addr, unsigned long end,
>>         /* Remaining */
>>         if (batch_start < end)
>>                 err = vmap_pages_range_noflush_walk(batch_start, end, prot,
>> -                               pages + batch_idx, prev_shift);
>> +                               pages + batch_idx, prev_shift, &nr_mapped);
>>
>>  out:
>>         if (!err)
> 
> So, you are recording nr_mapped but not undoing
> vmap_pages_range_batched() partial mappings yet. You do that in patch
> #9. It's weird to fix one place but leave the other one until later. I
> would suggest merging patches 7 and 9 to have a complete fix.

Yes, that looks correct when revisiting these patches.

Thanks
Best Regards
Hao

> 
>> diff --git a/mm/vmalloc.h b/mm/vmalloc.h
>> index 4ec114a75f04..9ea28845f713 100644
>> --- a/mm/vmalloc.h
>> +++ b/mm/vmalloc.h
>> @@ -40,7 +40,8 @@ void clear_vm_uninitialized_flag(struct vm_struct *vm);
>>
>>  int __must_check __vmap_pages_range_noflush(unsigned long addr,
>>                 unsigned long end, pgprot_t prot,
>> -               struct page **pages, unsigned int page_shift);
>> +               struct page **pages, unsigned int page_shift,
>> +               gfp_t gfp_mask);
>>
>>  void vunmap_range_noflush(unsigned long start, unsigned long end);
>>
>> --
>> 2.25.1
>>

