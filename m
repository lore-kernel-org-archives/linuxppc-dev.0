Return-Path: <linuxppc-dev+bounces-22670-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA61CD98DE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2026 22:31:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gfPxS51wlz2ySS;
	Tue, 16 Jun 2026 08:31:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781541796;
	cv=none; b=Dtu05TD+dUHi7PvuLUuoAhvYUvSd375mN76MCBhbdRdqab6MlmMCHNprR53MY7dSaMdF2+e7U9PnjWoi2to/wnlmEVBS/q/T2jrXmPmH+3faZDHdQs5M+wZjOScDN+spsVPZ2xVVI27mR3MJ7dJx7UOJJ8EdeWwyXBalTS2vn7vZKrMs8PwMvr1gU8ye1bxuHPuI9owvYgYP9VimnfHN3OCEht5+ch14QfBiYnCUFgjzkMa035bFpuYJt/OfwBmKYKZsQqdnG4Wx0VpFu3uy05eaeWRPzY6jvFRwic39JDHmAulgtp/o6jMWVwezdE2vXGfEbcjzc70UOcAGUqPozA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781541796; c=relaxed/relaxed;
	bh=88RkaO2p7eyI794czkPMVu+KIuNd6h2Ce0G8XbguOj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYBQwGTK2FZKk7JOq7/DlzKryCpEyb4QPc7g1473eBj4xyTBj0G4Q44W0lPwQKVZpF9wdueqjEBwCOFBXE5zwfJ4yrKWImLxIuUiPHmVZCuf+mThtfIyI9raRVsOrtCxslVLF4mKKxkNkXzAIwSXsxvKjwvsLA1i2kNbLocjpLldqwuR47TzQnWw1hAnAVTpglCtJPNrp2BG+SzcXYPqzCwnu6pETmiZ2mZSqKzzCyj17LWiyYp2ZLfvPeSZwxb2d0vDp2gM/Ng9W94QxyEMnTnZmIdz7szGYzY8uoeAEGo++eINsgF0QBKE+82kliFARfad+bsRkZZfnI0UyB2t9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=emtfNPNS; dkim-atps=neutral; spf=pass (client-ip=162.62.57.64; helo=out162-62-57-64.mail.qq.com; envelope-from=xiaowu.417@qq.com; receiver=lists.ozlabs.org) smtp.mailfrom=qq.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=emtfNPNS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=qq.com (client-ip=162.62.57.64; helo=out162-62-57-64.mail.qq.com; envelope-from=xiaowu.417@qq.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 372 seconds by postgrey-1.37 at boromir; Tue, 16 Jun 2026 02:43:12 AEST
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4gfGC46zFPz3bps
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2026 02:43:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1781541785; bh=88RkaO2p7eyI794czkPMVu+KIuNd6h2Ce0G8XbguOj4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=emtfNPNST5mBawuDTiCGVsr8whjhwBhTJ5dInV9XWmrtkpmBj9o2TOEJDOSYxdnEo
	 YYj7NCcwJZvce9Bq51obPBjieWjQM5eJDcM6mQWvh96ZxMofEbUBqSpeqSuwbS/rOG
	 x45kqbqkXzwaH8MB+/NSrSqMPXlcTaESLKhMaBsU=
Received: from [192.168.3.157] ([115.156.144.140])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 8D523424; Tue, 16 Jun 2026 00:35:21 +0800
X-QQ-mid: xmsmtpt1781541321tv1d6gxea
Message-ID: <tencent_5D21B8CE461994D9323FDEDA6441E4234407@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgQcDlRbWn1WDHT9RsUiLODzsMmDkuth3SXU7enl1Cz0cpGkadp4
	 dtJ9TIoIlmsv+VbrB0mj3JVtfxNNP8fJROFZ1SIHEk12R5/QYWP2tl7HBdab968l3iyj17p9+erT
	 /GzD9oisgYL2Tqqf8DeW/HtQR7gQmRHnrMy5tJdWHYHMff2a3ILp78HU+ZLeBl/K8FC7A7Jl+d3I
	 77/7zGwryiTG2dhRfR0ubCJcrTDv/i0hpeXq9MYRzK0b2KBlCGFEBGjSq/I3+18rBtAXMUCk7qDg
	 bucfiaR/+OxaahT3pXxGNqcw+NSgAHUBVWkflB6uFi2SYJjCg9IOr/2iB44SdL2YPyhZDxIM8ANG
	 FnaTTwcsAy20JgyczsoNYoFQRfFIFFNtuNqrinDAyKIjCTYmFbaYjOboeJVnsOxtiz5AktuB+Yp2
	 cFKTkbbNj5k9sh9XaUcbXXPTwsOzI9qYRtcMevSPZJM1x44xt3nUeO5+DQ1phzEcnZeUr1uqPR/E
	 4KYkc4ctDsOjOGKnPfDF6/9Di5grSeECDqUkrQ4JNBUDTsJxEUk3kKYNuS+AQoFowsM6qn+EjnxV
	 b2dTqPzsudSo0a6sD89jK+3PevK5J7eHU7AhL5LY2Wnfpsa85/o+qAkLT8ISricofWbCNrpajehr
	 i3YvSloL7OapMTPRvTsrcSuKCpfFpZ8m+j+A1Q68nLJTUn4o8D7KgQIjqodMZRqkMV45WSm/Ai/3
	 vW870bH0Gh5F8irIYk1GWHm9ZqOt65/P/dlNDXvHNT/PinUJIrmVkyfgLkr1IG1DilfIYcPRz2dR
	 ly/qpw+cO642+dBlFjdg2ER3yx3w+RoXyf3nAwnaBHHNenCzteFrOjE32Ko5UAA5Ae6Vurbl47ko
	 r/uebomp6YPlybogMdkMQJvGHshsqpMQ/fI7zgFsFp762mOleH+y1Avtv52GSh9QIt9PWeSAvLUj
	 G5jAN/1a+268rq7nyyVZGLuFm6FRzKFexHaZwouPmef48lo7DGUTe/gL5Kfzz5zTVdbtCGFJWyGO
	 kM3A0YyaD50PwQyxKXWByXOqdY2GeY+6e+54IZOQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-OQ-MSGID: <3ef0ecaa-3e0b-4583-8404-d552c62489db@qq.com>
Date: Tue, 16 Jun 2026 00:35:21 +0800
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
Subject: Re: [PATCH v4 07/19] mm/sparse: Move subsection_map_init() into
 sparse_init()
To: Muchun Song <songmuchun@bytedance.com>, Oscar Salvador
 <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Muchun Song <muchun.song@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Ritesh Harjani
 <ritesh.list@gmail.com>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Mike Kravetz <mike.kravetz@oracle.com>
References: <20260612035903.2468601-1-songmuchun@bytedance.com>
 <20260612035903.2468601-8-songmuchun@bytedance.com>
From: XIAO WU <xiaowu.417@qq.com>
In-Reply-To: <20260612035903.2468601-8-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Muchun,

Muchun Song <muchun.song@linux.dev> wrote:
 > mm/sparse: Move subsection_map_init() into sparse_init()
 >
 > This commit moves subsection_map_init() from free_area_init() into
 > sparse_init() so that sparse-specific setup stays together instead of 
being
 > split across the generic free_area_init() path.

This patch introduces a new `sparse_init_subsection_map()` that iterates
over all memblock ranges and calls `sparse_init_subsection_map_range()`:

 > +void __init sparse_init_subsection_map(void)
 > +{
 > +    int i, nid;
 > +    unsigned long start, end;
 > +
 > +    for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid)
 > +        sparse_init_subsection_map_range(start, end - start);

However, earlier in `sparse_init()`, `memblocks_present()` calls
`memory_present()`, which internally caps PFN ranges at
`max_sparsemem_pfn` via `mminit_validate_memmodel_limits()`. Sections
beyond this cap never have `ms->usage` allocated.

`for_each_mem_pfn_range()` returns the raw, uncapped memblock ranges.
If a range extends beyond `max_sparsemem_pfn`, then inside
`sparse_init_subsection_map_range()`:

     ms = __nr_to_section(nr);
     subsection_mask_set(ms->usage->subsection_map, pfn, pfns);

`ms->usage` is NULL because `sparse_init_early_section()` was never
called for this section, causing a NULL pointer dereference.

I was able to reproduce this on x86_64 with 4-level paging by booting
with `memmap=4G@0x400080000000` to place a memblock range beyond the
~64 TiB `max_sparsemem_pfn` limit.  The kernel crashes during early boot:

   node  -1: [mem 0x0000400080000000-0x000040017fffffff]
   ------------[ cut here ]------------
   WARNING: mm/sparse.c:142 at sparse_init+0x1ac/0x8a0
    ...
   PANIC: early exception 0x0d IP 
10:...sparse_init_subsection_map+0x12f/0x250
   RIP: 0010:sparse_init_subsection_map+0x12f/0x250
   Call Trace:
    sparse_init+0x69f/0x8a0
    mm_core_init_early+0x12fa/0x20c0
    start_kernel+0x89/0x4e0

The fix is a one-line NULL check in sparse_init_subsection_map_range():

--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -608,6 +608,8 @@ void __init sparse_init_subsection_map(unsigned long 
pfn,
          pfns = min(nr_pages, PAGES_PER_SECTION
                  - (pfn & ~PAGE_SECTION_MASK));
          ms = __nr_to_section(nr);
+        if (!ms->usage)
+            continue;
          subsection_mask_set(ms->usage->subsection_map, pfn, pfns);

On most systems `max_sparsemem_pfn` is large enough that this is never
hit, but on 32-bit or PAE configurations where the limit is much lower,
the mismatch between `for_each_mem_pfn_range()` and
`mminit_validate_memmodel_limits()` can trigger with reasonable memory
sizes.

Thanks,
Xiao



