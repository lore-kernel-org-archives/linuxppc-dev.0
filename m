Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B939606A327
	for <linuxppc-dev@archiver.kernel.org>; Thu, 12 Nov 2026 06:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xdv6OXXd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQ9Qk5vlRz2yKn;
	Thu, 12 Nov 2026 17:26:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.36
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794464814;
	cv=none; b=Ma2CZ9xjf0k+J0X7p53E6O36ijDEUwh8TqxLm4CfyFpI44qRxetGAqr1xMrNv5/m+V+2TSWksvLjEfY/YDr4lEhMTUHAbjxbEwWXKGVWVFhsJGfBIDJyV4oiP4slBncE/tCWTP0GhT1Cg/i/M0H5vaEaAev6oTLN1lcwdbYsh8NENPfQj8r8jfuwXaCFJvZKG6KWvfI9ZmVIgtRFoyTX7FQpDEcqcfIcwq3Bd0Ux1Wui/HWd6QYDYmdMats+ifVvyAVt6S9oMk1o/HGTChIAeOWvSroZP7oZx1rW77bNiqJ++uUEoY1uLJwSUAL2z+8noMnXQJJw656jA9n3E1ayzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794464814; c=relaxed/relaxed;
	bh=FzuBWSCpGeQukn6FXOSBWpNu0IM30YG8f/xbcMJEj9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxwCBq17ZTgcDKyzE+G08OzMzzB9LR5aTSzIrRTpQ0o2pxTLxs2evah6az2uSr7TAuLPrvWNPU6w8HMewY2lpyJzmd7Et21lif2AyusIcK12pmfn9lXBIVZJkxe0sc5ijlI5lpglJKGG1+KEs2qL+ZVCHXw0Fup26KiniZPOe7u6QoTw0jetkrYoCRXoDh4Ah/shOK8rmzaaQPVivmb7JXr+Y3tgawn0oclNirYi0o+ivzmOF2ic505Ped+bOTcVBt/6j4gfNpLFdKmfqUzo1aOIHo6nH53/W1FuqCfw2kJAN6f9VoT2bK8BwHTA3VhKtzlR/GNraYSr8xaBZJustg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xdv6OXXd; dkim-atps=neutral; spf=pass (client-ip=95.215.58.36; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xdv6OXXd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.36; helo=mta1.migadu.com; envelope-from=hao.ge@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-36.mta1.migadu.com [95.215.58.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jQ9Qf4vKMz2y8F
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2026 17:26:48 +1100 (AEDT)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=YSdVHcPOxp7Mxpr75S83EeGKEHU4uT3ofCAOXt4L8qg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794464790; v=1; x=1795069590;
 b=xdv6OXXdejomL8Jyz21uc0ZO1TWdK2t3WFcFLwxceXm+B0C0fNYTeZ7LwgHTkmy16OJ29GNk
 izgILyNfylss6MC2zDXOz4c+0rS0DOdEGwM0hqjnTrytoKxV3wbmWkq74DfSFK34no72/4fqXNT
 YodGPR3YUvWpYFCabU8JqSAg=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 8df4261c904f80f8;
	Thu, 12 Nov 2026 06:26:30 +0000
X-Mizu-Trace-ID: 8df4261c904f80f8
X-Migadu-Flow: FLOW_OUT
Message-ID: <73501214-76ff-4716-bb8e-f83fff26bfba@linux.dev>
Date: Thu, 12 Nov 2026 14:27:55 +0800
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
Subject: Re: [PATCH v4 7/9] mm/vmalloc: undo partial mappings inside the
 mapping functions
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
References: <20261110112546.261415-1-hao.ge@linux.dev>
 <20261110112546.261415-8-hao.ge@linux.dev>
 <CAJuCfpFHaahsCNkXCOn8ks65yj_bPy33cOLZ5BW=rtTOuedLqw@mail.gmail.com>
Content-Language: en-US
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <CAJuCfpFHaahsCNkXCOn8ks65yj_bPy33cOLZ5BW=rtTOuedLqw@mail.gmail.com>
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

Thanks for your review.

On 2026/11/12 09:15, Suren Baghdasaryan wrote:
> On Tue, Nov 10, 2026 at 11:25 AM Hao Ge <hao.ge@linux.dev> wrote:
>>
>> The vmap entry points may install some PTEs and then fail, leaving a
>> partial mapping behind.
>>
>> The callers do not agree on who cleans it up. pcpu_map_pages() and
>> kmsan_ioremap_page_range() roll back what they mapped, while
>> vm_module_tags_populate() and the __GFP_NOFAIL retry loop in
>> __vmalloc_area_node() expect a clean range from the mapping function.
>> For them the leftovers stay mapped, and the next attempt to map the
>> same range trips the WARN_ON(!pte_none()) in vmap_pages_pte_range().
>> A leftover huge pmd is even worse. During the retry, vmap_try_huge_pmd()
>> calls pmd_free_pte_page() on it, and the x86 implementation cannot
>> tell a leaf entry from a page table and frees the mapped page.
>>
>> After discussing with Suren and Ulad, we decided to put the rollback
>> into the entry points of the vmap API rather than into every
>> low-level helper. __vmap_pages_range_noflush() undoes the whole range
>> it was asked to map when it fails, and vmap_page_range() undoes its
>> range for the ioremap-style mappings.
>>
>> The rollback is __vunmap_range_noflush(), which only clears the PTEs.
>> No TLB flush is needed, nothing has touched the mapping yet.
>> vmap_pages_range_noflush() also drops the KMSAN metadata of the
>> failed mapping.
>>
>> The undo walk skips its cond_resched() when the caller's gfp mask
>> cannot block. __vmalloc() with GFP_ATOMIC or GFP_NOWAIT can run in
>> atomic context, where cond_resched() cannot schedule.
>> __vunmap_range_noflush() takes a can_resched argument for that, which
>> the sleepable callers pass as true.
>>
>> Suggested-by: Uladyslau Rezki <urezki@gmail.com>
>> Signed-off-by: Hao Ge <hao.ge@linux.dev>
>> ---
>>  include/linux/kmsan.h |  8 ++++--
>>  mm/kmsan/hooks.c      | 18 ++++++++-----
>>  mm/kmsan/shadow.c     |  7 ++---
>>  mm/vmalloc.c          | 61 +++++++++++++++++++++++++++++++++----------
>>  mm/vmalloc.h          |  6 +++--
>>  5 files changed, 72 insertions(+), 28 deletions(-)
>>
>> diff --git a/include/linux/kmsan.h b/include/linux/kmsan.h
>> index 7da9fd506b39..0016c032d1e7 100644
>> --- a/include/linux/kmsan.h
>> +++ b/include/linux/kmsan.h
>> @@ -150,11 +150,14 @@ int __must_check kmsan_vmap_pages_range_noflush(unsigned long start,
>>   * kmsan_vunmap_kernel_range_noflush() - Notify KMSAN about a vunmap.
>>   * @start: start of vunmapped range.
>>   * @end:   end of vunmapped range.
>> + * @can_resched: whether the unmap walk may call cond_resched(); pass
>> + * false from atomic context.
>>   *
>>   * KMSAN unmaps the contiguous metadata ranges created by
>>   * kmsan_map_kernel_range_noflush().
>>   */
>> -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end);
>> +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
>> +                               bool can_resched);
>>
>>  /**
>>   * kmsan_ioremap_page_range() - Notify KMSAN about a ioremap_page_range() call.
>> @@ -355,7 +358,8 @@ static inline int __must_check kmsan_vmap_pages_range_noflush(
>>  }
>>
>>  static inline void kmsan_vunmap_range_noflush(unsigned long start,
>> -                                             unsigned long end)
>> +                                             unsigned long end,
>> +                                             bool can_resched)
>>  {
>>  }
>>
>> diff --git a/mm/kmsan/hooks.c b/mm/kmsan/hooks.c
>> index 107f66841274..0cd1edaa1120 100644
>> --- a/mm/kmsan/hooks.c
>> +++ b/mm/kmsan/hooks.c
>> @@ -136,13 +136,16 @@ static unsigned long vmalloc_origin(unsigned long addr)
>>                                                  KMSAN_META_ORIGIN);
>>  }
>>
>> -void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end)
>> +void kmsan_vunmap_range_noflush(unsigned long start, unsigned long end,
>> +                               bool can_resched)
>>  {
>>         if (!kmsan_enabled)
>>                 return;
>>
>> -       __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end));
>> -       __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end));
>> +       __vunmap_range_noflush(vmalloc_shadow(start), vmalloc_shadow(end),
>> +                              can_resched);
>> +       __vunmap_range_noflush(vmalloc_origin(start), vmalloc_origin(end),
>> +                              can_resched);
>>         flush_cache_vmap(vmalloc_shadow(start), vmalloc_shadow(end));
>>         flush_cache_vmap(vmalloc_origin(start), vmalloc_origin(end));
>>  }
>> @@ -171,8 +174,9 @@ static void kmsan_iounmap_pages(unsigned long start, unsigned long end)
>>                 if (origin)
>>                         __free_pages(origin, KMSAN_IOREMAP_META_ORDER);
>>         }
>> -       __vunmap_range_noflush(shadow_start, shadow_end);
>> -       __vunmap_range_noflush(origin_start, origin_end);
>> +       /* ioremap metadata mappings are always GFP_KERNEL, so resched is safe. */
>> +       __vunmap_range_noflush(shadow_start, shadow_end, true);
>> +       __vunmap_range_noflush(origin_start, origin_end, true);
>>         flush_tlb_kernel_range(shadow_start, shadow_end);
>>         flush_tlb_kernel_range(origin_start, origin_end);
>>  }
>> @@ -207,7 +211,7 @@ int kmsan_ioremap_page_range(unsigned long start, unsigned long end,
>>                 mapped = __vmap_pages_range_noflush(
>>                         vmalloc_shadow(start + off),
>>                         vmalloc_shadow(start + off + PAGE_SIZE), prot, &shadow,
>> -                       PAGE_SHIFT);
>> +                       PAGE_SHIFT, gfp_mask);
>>                 if (mapped) {
>>                         err = mapped;
>>                         goto ret;
>> @@ -217,7 +221,7 @@ int kmsan_ioremap_page_range(unsigned long start, unsigned long end,
>>                 mapped = __vmap_pages_range_noflush(
>>                         vmalloc_origin(start + off),
>>                         vmalloc_origin(start + off + PAGE_SIZE), prot, &origin,
>> -                       PAGE_SHIFT);
>> +                       PAGE_SHIFT, gfp_mask);
>>                 if (mapped) {
>>                         err = mapped;
>>                         goto ret;
>> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
>> index 2166086d3dc3..452760a333e4 100644
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
>> @@ -255,12 +255,13 @@ int kmsan_vmap_pages_range_noflush(unsigned long start, unsigned long end,
>>         }
>>         kmsan_enter_runtime();
>>         mapped = __vmap_pages_range_noflush(origin_start, origin_end, prot,
>> -                                           o_pages, page_shift);
>> +                                           o_pages, page_shift, gfp_mask);
>>         kmsan_leave_runtime();
>>         if (mapped) {
>>                 /* Undo the shadow mapping set up above. */
>>                 kmsan_enter_runtime();
>> -               __vunmap_range_noflush(shadow_start, shadow_end);
>> +               __vunmap_range_noflush(shadow_start, shadow_end,
>> +                                      gfpflags_allow_blocking(gfp_mask));
>>                 kmsan_leave_runtime();
>>                 err = mapped;
>>                 goto ret;
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 3f98056f8c7e..d1986f68eab4 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -372,8 +372,12 @@ int vmap_page_range(unsigned long addr, unsigned long end,
>>         if (!err)
>>                 err = kmsan_ioremap_page_range(addr, end, phys_addr, prot,
>>                                                ioremap_max_page_shift);
>> -       if (!err)
>> +       if (err) {
>> +               /* Callers are ioremap and arch setup code, always sleepable. */
>> +               __vunmap_range_noflush(addr, end, true);
>> +       } else {
>>                 flush_cache_vmap(addr, end);
>> +       }
>>
>>         return err;
>>  }
>> @@ -429,7 +433,7 @@ static void vunmap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>>  }
>>
>>  static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>> -                            pgtbl_mod_mask *mask)
>> +                            pgtbl_mod_mask *mask, bool can_resched)
>>  {
>>         pmd_t *pmd;
>>         unsigned long next;
>> @@ -451,12 +455,14 @@ static void vunmap_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>>                         continue;
>>                 vunmap_pte_range(pmd, addr, next, mask);
>>
>> -               cond_resched();
>> +               /* The undo path may run in atomic context. */
>> +               if (can_resched)
>> +                       cond_resched();
>>         } while (pmd++, addr = next, addr != end);
>>  }
>>
>>  static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>> -                            pgtbl_mod_mask *mask)
>> +                            pgtbl_mod_mask *mask, bool can_resched)
>>  {
>>         pud_t *pud;
>>         unsigned long next;
>> @@ -476,12 +482,12 @@ static void vunmap_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>>                 }
>>                 if (pud_none_or_clear_bad(pud))
>>                         continue;
>> -               vunmap_pmd_range(pud, addr, next, mask);
>> +               vunmap_pmd_range(pud, addr, next, mask, can_resched);
>>         } while (pud++, addr = next, addr != end);
>>  }
>>
>>  static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>> -                            pgtbl_mod_mask *mask)
>> +                            pgtbl_mod_mask *mask, bool can_resched)
>>  {
>>         p4d_t *p4d;
>>         unsigned long next;
>> @@ -496,7 +502,7 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>>
>>                 if (p4d_none_or_clear_bad(p4d))
>>                         continue;
>> -               vunmap_pud_range(p4d, addr, next, mask);
>> +               vunmap_pud_range(p4d, addr, next, mask, can_resched);
>>         } while (p4d++, addr = next, addr != end);
>>  }
>>
>> @@ -512,7 +518,8 @@ static void vunmap_p4d_range(pgd_t *pgd, unsigned long addr, unsigned long end,
>>   *
>>   * This is an internal function only. Do not use outside mm/.
>>   */
>> -void __vunmap_range_noflush(unsigned long start, unsigned long end)
>> +void __vunmap_range_noflush(unsigned long start, unsigned long end,
>> +                           bool can_resched)
>>  {
>>         unsigned long next;
>>         pgd_t *pgd;
>> @@ -529,7 +536,7 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
>>                         mask |= PGTBL_PGD_MODIFIED;
>>                 if (pgd_none_or_clear_bad(pgd))
>>                         continue;
>> -               vunmap_p4d_range(pgd, addr, next, &mask);
>> +               vunmap_p4d_range(pgd, addr, next, &mask, can_resched);
>>         } while (pgd++, addr = next, addr != end);
>>
>>         if (mask & ARCH_PAGE_TABLE_SYNC_MASK)
>> @@ -538,8 +545,9 @@ void __vunmap_range_noflush(unsigned long start, unsigned long end)
>>
>>  void vunmap_range_noflush(unsigned long start, unsigned long end)
>>  {
>> -       kmsan_vunmap_range_noflush(start, end);
>> -       __vunmap_range_noflush(start, end);
>> +       /* The unmap paths are sleepable, keep the resched point. */
>> +       kmsan_vunmap_range_noflush(start, end, true);
>> +       __vunmap_range_noflush(start, end, true);
>>  }
>>
>>  /**
>> @@ -727,18 +735,32 @@ static int vmap_pages_range_noflush_walk(unsigned long addr, unsigned long end,
>>   * The caller is responsible for calling flush_cache_vmap() after this
>>   * function returns successfully and before the addresses are accessed.
>>   *
>> + * On failure the mapping is torn down before returning, so a retry
>> + * sees a clean range. When @gfp_mask cannot block, the teardown
>> + * skips cond_resched(), it may run in atomic context.
>> + *
>>   * This is an internal function only. Do not use outside mm/.
>>   */
>>  int __vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>> -               pgprot_t prot, struct page **pages, unsigned int page_shift)
>> +               pgprot_t prot, struct page **pages, unsigned int page_shift,
>> +               gfp_t gfp_mask)
>>  {
>> +       int err;
>> +
>>         if (WARN_ON_ONCE(page_shift < PAGE_SHIFT))
>>                 return -EINVAL;
>>
>>         if (!IS_ENABLED(CONFIG_HAVE_ARCH_HUGE_VMALLOC))
>>                 page_shift = PAGE_SHIFT;
>>
>> -       return vmap_pages_range_noflush_walk(addr, end, prot, pages, page_shift);
>> +       err = vmap_pages_range_noflush_walk(addr, end, prot, pages, page_shift);
>> +
>> +       /* Undo the PTEs installed before the failure. */
>> +       if (err)
>> +               __vunmap_range_noflush(addr, end,
>> +                                      gfpflags_allow_blocking(gfp_mask));
> 
> I remember we discussed this before that __vunmap_range_noflush() will
> be unmapping the entire range between addr and end instead of the
> range vmap_pages_range_noflush_walk() actially mapped and your reply
> was that this keeps things simple and avoids adding extra code in the
> common path when we do not fail. This was bothering me, so I looked a
> bit deeper and I think there is an issue with this approach.
> vmap_pages_pte_range() fails with -EBUSY if it encounters an already
> installed PTE. So, if this happens, we immediately bail out of mapping
> the range and will be unmapping the entire range, including these
> existing PTEs. I don't think that's ok.
>

You were right, I did not really think the -EBUSY case through.
when the walk trips over a PTE that is already there, everything
from that point on is somebody else's mapping, and the undo as
it stood would clear it. sorry for this.


> A fix might be quite simple. vmap_pages_range_noflush_walk() already
> counts how many pages we processed in nr variable. If we propagate
> that one level up then we could unmap only the range we actually
> mapped.

Right, thank you very much for helping sort this out. This makes
it a lot clearer.

Thanks
Best Regards
Hao

> 
>> +
>> +       return err;
>>  }
>>
>>  int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>> @@ -750,7 +772,18 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
>>
>>         if (ret)
>>                 return ret;
>> -       return __vmap_pages_range_noflush(addr, end, prot, pages, page_shift);
>> +
>> +       ret = __vmap_pages_range_noflush(addr, end, prot, pages, page_shift,
>> +                                        gfp_mask);
>> +       /*
>> +        * The page tables undo themselves on failure. Tear down the
>> +        * metadata that was fully set up before the mapping failed.
>> +        */
>> +       if (ret)
>> +               kmsan_vunmap_range_noflush(addr, end,
>> +                                          gfpflags_allow_blocking(gfp_mask));
>> +
>> +       return ret;
>>  }
>>
>>  static int __vmap_pages_range(unsigned long addr, unsigned long end,
>> diff --git a/mm/vmalloc.h b/mm/vmalloc.h
>> index d8372a4f65c4..9ea28845f713 100644
>> --- a/mm/vmalloc.h
>> +++ b/mm/vmalloc.h
>> @@ -40,10 +40,12 @@ void clear_vm_uninitialized_flag(struct vm_struct *vm);
>>
>>  int __must_check __vmap_pages_range_noflush(unsigned long addr,
>>                 unsigned long end, pgprot_t prot,
>> -               struct page **pages, unsigned int page_shift);
>> +               struct page **pages, unsigned int page_shift,
>> +               gfp_t gfp_mask);
>>
>>  void vunmap_range_noflush(unsigned long start, unsigned long end);
>>
>> -void __vunmap_range_noflush(unsigned long start, unsigned long end);
>> +void __vunmap_range_noflush(unsigned long start, unsigned long end,
>> +                           bool can_resched);
>>
>>  #endif /* __MM_VMALLOC_H */
>> --
>> 2.25.1
>>

