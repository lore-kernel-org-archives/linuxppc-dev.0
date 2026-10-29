Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC3A606A332
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Oct 2026 03:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=haRfZ/H1
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFVp72wSgz2yrC;
	Thu, 29 Oct 2026 14:58:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1329"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793246319;
	cv=none; b=HSCuujJSVfvlonN0Dj0pVDY+pV51dXbqBDJYUiaGbUTVFFOloXZsgPR2GM/fMSRfN0tHQPkY8Yz7k74vwo8s68WAZocOVPJW0TFqtHQmZpA5cLvO14CpeLi3hgJ4+FnWX5NEfwsgkitYPUgRWTUPnULN9cp7BRr6NNHhpPIu2l6Hk8jg1+e9VgyI1eSw/5mqpAXWtWzrk8HavmJSvUnWtYAoDwBWITMPrw3ef7M2RYcBJed092Zr9rZjHhikLnwqPvvt7j5q1S+Rjt+sp0g5Zqs9SCxI0wVI7S0YvmwXURWf12fo0pA/QpQbr4ClSValIa1TOwh+zidSoGsoa+Fmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793246319; c=relaxed/relaxed;
	bh=DH/fKpO0BoTPGL2h5tiHaOMY8UyYNemLu3Miwyi1WAU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=bs0gPIufXubRQj8B3MOhjetqtohFcWNyO29hmNi24cU2DiMh6DAeH3vYWNEKfU7xqpz/w+CWpgCi/fQZhHl741E6kWvKu6nnPO3G8qdzWhuPfHsJsg376CeO5bO9VsBNMo4XZHw3nC108n3f4OALVooe3VOsAuJwuuj+Yq3ZIWAdwXAtUqUaNk33XqeeOBsPRuk+IIAqJxYZYQGrN8vMq3zacHjoKq1y/xsdZTLKs2Rs4fC+s70m2VN4/FXSKDzZ67NzCEnFQH7b7kUtav4rZT6xvFu2zUVs1SIzcEqPqKFn/ChuOfUhyNtXYKLHAY6wRTbBmGNZx9EUOgowWn0rbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=haRfZ/H1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=haRfZ/H1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1329; helo=mail-dy1-x1329.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFVp52cxlz2xg9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2026 14:58:37 +1100 (AEDT)
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3105843eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Oct 2026 20:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793246315; x=1793851115; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DH/fKpO0BoTPGL2h5tiHaOMY8UyYNemLu3Miwyi1WAU=;
        b=haRfZ/H1CUsCZm/D/ie/fHchgPxtnOJoSWZDlkiDrEOsxC3mn/d7VZmwRJuEyPhxXe
         ydtnppm4I6iyrvDNviIrASZWdIwNWlrH5k0s1cDmwN3hofdVfOm3WHwo1eFDxWPRIbwQ
         e5OFwvhal+igLVdADB00FLouYl+rsQmZ3aRc+WTY6W6RieqZykZ+UnSHt8JiD0j83hDC
         Fc18HYkpaKm12UoUl/gmP7EUtb5HHOpVe3bkDmNVnpDK5H2jxYXfwxDTj4/1C8AY3nPj
         nwqUH3VY2mFUlcRuXxt5uvMuQMig3txacpFomYWHfuLztcZXELuFwjvQQAvMW1xu6yS3
         nVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793246315; x=1793851115;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DH/fKpO0BoTPGL2h5tiHaOMY8UyYNemLu3Miwyi1WAU=;
        b=YdopBpBgNuiv1aeSzjPZsmGDuR6ypLkiZoZHNZjzQ1fDRnH+2b1+D7SI8C+SpDj1mr
         QajdhqKnevHduOGGPMqgTNjXK4HBt+lMF54cXw3hQORiooa5bihqkKY7q4HpRC8cf3Lp
         SzzWGPaZy29W6lhoe0nYQ+4zdfCj0u9bkvP1uquLdzP06HyNYa8P+ajVSJAtDw6cq5Ee
         XUx/6I2W++AGEfi5Y5kmlzEvvcFDZhbzFheIY55tqNN+PqBcH2hp/BLVoDhriBgLuXD6
         EMkOEDFY8Eze+5q6TnrRl/EZABPuz7wIK4fpyxOXTOFo4Dt741/UgRlKaXMrppbaMCac
         p22Q==
X-Forwarded-Encrypted: i=1; AKwUvBxYdU58T7DboHQ8XhoN2s7xzj43E1IpH8qRZU2KtbE1xOETIiCbwJ1tvosdV0xuC79LwzksA+KFuA7LoAg=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYInJYuOc1uAioNjremr7FK7RdZxVESL9ftMo47Ivu6i5aRf3pRx
	y1Op2+yE3ZO+nuUZH+ULSpXm8eODaELYEdfJf73M1TZyu0wOqkPImFec
X-Gm-Gg: AYBFou0Sft7thVmgDtJ2+cLvG8t4/QaxJvdDfkqjVISECRgId/7UZS+kVllCWgzBcNY
	MqJFKGa7qG4ZqePAVMxd4L14v5Pe2SVUGZ9UYzjjo5lNwn+rvS2ChDfajnRMHXr2NUF1TkM1ukq
	YwXVhnetkhROMiFDMuD+CSpUznZN+zOVR3+yzZ0lwGy/gF0dNlC+iGUBZQX1b3OsQXIiYGx9O7d
	5i254GXFj8BPIeCvWts6Td4Tq2h8xgYTLzx4L/I3DAinRnIyDAzoEtHMzs9t/Y589XA36bhZs2z
	eIRMOSmE8xDnn+ZFxo4wwr8xafAZ3xYmUQ5kfViASoTELkkcG3VNufdNbtchhu6ixjOvwH/PN8B
	bo8F0OlDjwfEUfoU8I2ZE95TWkMHPNPflBJ0+jpeMREnzqXkPIDQrkBwEbFRvCN7syE0/AdMsjL
	IBWskhoQE8oTfn01/qoMaxOKwi6IEKw0UuOV86F7cZlbXcvAjZKRNTKwnuzNtj8DsrrUeeiC0AN
	tYHBDf74+o2PZN6Lu8gsraUnUdoqYoBlYEiCbbn5Q7sZmLAmefr5vy2vhGYwiUfFILgnXuF/7gy
	VSkF/nImYjKJjhppF5lYcgOWfVQ=
X-Received: by 2002:a05:701b:260d:b0:14d:c53a:f6a0 with SMTP id a92af1059eb24-1a6cd499523mr4859697c88.13.1793246314816;
        Wed, 28 Oct 2026 20:58:34 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75fdc1031sm11012363c88.19.2026.10.28.20.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 20:58:34 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy <chleroy@kernel.org>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, David Hildenbrand <david@kernel.org>, Pavithra <pavrampu@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/64s/radix: don't dedup vmemmap covered by an existing PMD leaf
In-Reply-To: <2C88EF3C-1E7D-4395-99C5-711FFB01469A@linux.dev>
Date: Thu, 29 Oct 2026 09:20:11 +0530
Message-ID: <ik2lw4gc.ritesh.list@gmail.com>
References: <97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com> <2C88EF3C-1E7D-4395-99C5-711FFB01469A@linux.dev>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
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

Muchun Song <muchun.song@linux.dev> writes:

> Hi Ritesh,
>
>> On Oct 27, 2026, at 11:22, Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:
>> 
>> radix__vmemmap_populate() is asked for one 16MB section, which is 16KB of
>> struct pages. With no altmap it rounds the request down to a PMD leaf.
>> That leaf describes 2GB of PFNs with 64KB pages (128MB with 4KB pages),
>> so it also covers sections that are not present yet. It cannot be freed
>> while any of those sections are still in use.
>> 
>> A devdax namespace that lands in the same window is marked for vmemmap dedup.
>> vmemmap_populate_compound_pages() treated the leaf as an existing huge mapping
>> and skipped it. The core then initializes only the head vmemmap page and assumes
>> the rest is the shared tail. Those remaining tail slots are real struct pages
>> still holding the page_init_poison() pattern and are not the shared tail pages.
>
> Right.
>
>> __init_single_page() warns on the zone mismatch and the following pageblock init
>> faults in __set_pfnblock_flags_mask().
>
> Yeah, the new adding warning is useful.
>
>> 
>> If the section's vmemmap is already a PMD leaf, clear its compound order
>
> I think it's enough to fix this issue.
>

Oh yes, right! since the page init is done later and the optimizable
order can be read from mem_section.

>> and reuse the leaf, so every struct page in the section is initialized.
>> The shared-tail layout needs base-page PTEs, so it cannot be built on top of
>> this leaf and dropping the leaf is not an option while the neighbouring range
>> is still using it. So, fail the compound populate if a leaf is still seen there.
>> 
>> <Call Trace>
>> ============
>> [    3.467060][    T1] WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4, CPU#0: swapper/0/1
>> <...>
>> [    3.477419][    T1] NIP [c000000000576b30] __init_single_page+0xd0/0xf4
>> [    3.477827][    T1] LR [c0000000005778b0] __init_zone_device_page+0x30/0xb8
>> [    3.478444][    T1] Call Trace:
>> [    3.478764][    T1]  0x10000 (unreliable)
>> [    3.479874][    T1]  memmap_init_zone_device+0x164/0x430
>> [    3.480392][    T1]  memremap_pages+0x43c/0x93c
>> [    3.480836][    T1]  devm_memremap_pages+0x3c/0xa4
>> [    3.481328][    T1]  dev_dax_probe+0x264/0x3d0
>> [    3.481817][    T1]  dax_bus_probe+0x140/0x1c8
>> [    3.482237][    T1]  really_probe+0x108/0x580
>> [    3.482681][    T1]  __driver_probe_device+0xcc/0x284
>> [    3.483186][    T1]  driver_probe_device+0x5c/0x108
>> [    3.483656][    T1]  __device_attach_driver+0x10c/0x1e8
>> [    3.484134][    T1]  bus_for_each_drv+0xc0/0x13c
>> <...>
>> [    3.499972][    T1] BUG: Kernel NULL pointer dereference on read at 0x00001400
>> [    3.500417][    T1] Faulting instruction address: 0xc0000000005f4ecc
>> [    3.500417][    T1] Faulting instruction address: 0xc0000000005f4ecc
>> cpu 0x0: Vector: 300 (Data Access) at [c000000006756b50]
>>    pc: c0000000005f4ecc: __set_pfnblock_flags_mask.constprop.0+0x34/0x160
>>    lr: c000000000577f38: memmap_init_zone_device+0x358/0x430
>>    pid   = 1, comm = swapper/0
>> enter ? for help
>>  memmap_init_zone_device+0x358/0x430
>>  memmap_init_zone_device+0x220/0x430 (unreliable)
>>  memremap_pages+0x43c/0x93c
>>  devm_memremap_pages+0x3c/0xa4
>>  dev_dax_probe+0x264/0x3d0
>>  dax_bus_probe+0x140/0x1c8
>>  really_probe+0x108/0x580
>> <...>
>> 
>> Fixes: bd0862382adb ("mm/sparse-vmemmap: drop Device DAX-specific population path")
>
> Actually, the right Fixes is:
>
> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
>
> On older kernels, these errors are silent. They trigger a kernel panic when the user
> actually uses Device DAX, rather than during the initialization phase. 
>
> So, for older kernels, we should guide them to backport the patch.
>
>> Reported-by: Pavithra <pavrampu@linux.ibm.com>
>> Assisted-by: LLM
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>> Fixes tag here is added since the fix is dependent upon the change mentioned in
>> "Fixes" tag. The Fixes commit-id is from mm-new branch. Although this could be
>> an older pre-existing issue, but got exposed after this patch series.
>
> I knew this issue, so I have a local commit to fix it as well. I'd like to share
> it with you, because it looks a little simple, does it work for you?
>
> powerpc/mm: fix uninitialized ZONE_DEVICE struct pages with PMDs
>
> PowerPC radix vmemmap population can reuse an existing PMD mapping while
> populating a device DAX range whose section is marked as HVO-enabled. The
> reused mapping is an ordinary vmemmap mapping: the redundant tail struct
> pages are not remapped to the shared tail page.
>
> Leaving the section marked as HVO-enabled makes later ZONE_DEVICE
> initialization treat the range as optimized and initialize only the struct
> pages that would be backed by a real HVO mapping. The remaining tail struct
> pages can then be left uninitialized even though they are still used as
> metadata for the device DAX compound page.
>

Here, feel free to use the call trace from my commit msg to show what goes
wrong w/o this fix.

> The Fixes target predates the section-based vmemmap optimization
> infrastructure, so older kernels do not have section state that can be
> marked non-HVO. Backports to such kernels need to handle the PMD-reuse
> case in powerpc radix code directly, for example by initializing the tail
> struct pages that core ZONE_DEVICE initialization would otherwise skip.
>
> Mark the section as non-HVO when reusing an existing PMD mapping, so the
> section's HVO state matches the actual vmemmap layout and all required
> struct pages are initialized.
>
> Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

yes, love this approach. Thanks for sharing the fix.

>
> diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
> index 72793ace1fb6..fc3a2d4b422d 100644
> --- a/arch/powerpc/mm/book3s64/radix_pgtable.c
> +++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
> @@ -1200,7 +1200,16 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
>  			return -ENOMEM;
>
>  		if (pmd_leaf(READ_ONCE(*pmd))) {
> -			/* existing huge mapping. Skip the range */
> +			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
> +			struct mem_section *ms = __pfn_to_section(addr_pfn);
> +
> +			/*
> +			 * Existing PMD mappings can cover the edges of a valid
> +			 * HVO populate range.  They are ordinary vmemmap mappings,
> +			 * so the current section must not be treated as HVO-backed
> +			 * when its struct pages are initialized later.
> +			 */
> +			section_set_order(ms, 0);

I think you meant "section_set_compound_order(ms, 0);"

yes, otherwise the patch looks good to me. Can you please post this
patch separately then? Feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

I have validated the fix with my custom reproducer and I see the issue
is fixed with this. Meanwhile, Pavithra (cc'd) is testing this and few
other patches of your series. Once her testing is finished, she can help
provide her Tested-by/feedback if any.

>  			next = pmd_addr_end(addr, end);
>  			continue;
>  		}

-ritesh

