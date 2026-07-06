Return-Path: <linuxppc-dev+bounces-23584-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0477C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 05:39:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gttTM0nPrz2yfS;
	Mon, 06 Jul 2026 15:39:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::b8"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783316359;
	cv=none; b=AeZPskZKLhdFHiGR1ogAis9lhQd27cFSUqbKKQ0aB7enOhpVwsn0VIGYu3r+iZV8ZgKx0luyCSa1o8b1oSQU84USPdR3vNcBPNZTNmcoTEoUHdtk6GnGqOqDFL54iV6HZnFrBTdznHuFGTAotqVQ33DWQCV3ccqlgCNxASs59Piaz4mtqBkaRYDSe7D/EXbMW/JYnkpUd0kR9pEbiibOctkluvoh4kTaMz+WszKh2TgalpLQP31rjHUvQHvh3M6mHGSUUYVXR4K5/6jZh7sVnN0Mc0S/WiuP6O0BrRsks/VeKCPShp73Qg/oQi962TX7EQulHajHLzvS3d30356pqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783316359; c=relaxed/relaxed;
	bh=pUAU5zbAPO0Js6yoKRIHKJlwUkpSoy0U+ADQkMAFvw4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TdpLfJpYMnyv5V/sV3mghl97JlP7YM3Zl1lA4l3Nw+kzCtDG0R6Y1GAjUDoHxGXvrqn3F7hQO/2t6KoBOAsBZCzPgDtAdEWjXyy60VBlM//7VJ/9aR//lPNlrsa926Ad8TLA7KdaRdH2AdaOFfUWeh4sMf8drhuIv2+Z5KB0z4RAdRx5XHN3PN+t7HWa3LZzXodFK2Xl+ZtFOiMWpaNjeqtTV+jLLq/CO4Lvxdt/tRP/5Xqs9kRbJO95Yhpx+TVbgftykHH3Fpm+1bUfKv2/GGi1n91HmuLCr1F8ANSuyuWWwpqfktKkHap5ePMKdGMjHG6LJwOwoxX0bd7miOFsmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ReOqUr2E; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::b8; helo=out-184.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ReOqUr2E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::b8; helo=out-184.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gttTH50Dsz2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 15:39:13 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783316328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pUAU5zbAPO0Js6yoKRIHKJlwUkpSoy0U+ADQkMAFvw4=;
	b=ReOqUr2ENps7GNtouB5b1kq70v6+GMA+MmHm4Lu4YoiIGaj08ODM4aUZ27AuI6XXzvyxq7
	hAlCU/HhLOoI89xWph7v0c5H5EQhaPUoGzux1IrgOXvxHWDJXc0zZaYyaDWGRsec874IAy
	SoEyYaa7fdTGn8n6VgHu24jYI0pKsgU=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v4] riscv: mm: Avoid spurious fault after hotplugging
 vmemmap
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <5fac578c-ff97-4721-96f3-8ba495f0556a@iscas.ac.cn>
Date: Mon, 6 Jul 2026 13:38:06 +0800
Cc: linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <214FC970-465A-4E45-98C0-17978D63DE89@linux.dev>
References: <20260630-mark-after-vmemmap-populate-v4-1-febbc15da028@iscas.ac.cn>
 <7B0CB4ED-C190-4F49-97EE-E1F14F08DED2@linux.dev>
 <5fac578c-ff97-4721-96f3-8ba495f0556a@iscas.ac.cn>
To: Vivian Wang <wangruikang@iscas.ac.cn>
X-Migadu-Flow: FLOW_OUT



> On Jul 6, 2026, at 13:04, Vivian Wang <wangruikang@iscas.ac.cn> wrote:
>=20
> [ powerpc maintainers: Thoughts on replacing the ptesync in
> vmemmap_set_pmd() with a flush_cache_vmap() post-vmemmap-hotplug in =
the
> generic code? ]
>=20
> On 7/6/26 11:00, Muchun Song wrote:
>>> On Jun 30, 2026, at 15:51, Vivian Wang <wangruikang@iscas.ac.cn> =
wrote:
>>>=20
>>> section_activate() does not flush TLB after populating new vmemmap
>>> pages. On most architectures, this is okay. However it is a problem =
on
>>> RISC-V since there the TLB caching non-present entries is permitted,
>>> which causes spurious faults on some hardwares.
>>>=20
>>> This seems to be most easily reproduced with DEBUG_VM=3Dy and
>>> PAGE_POISONING=3Dy, which causes these newly mapped struct pages to =
be
>>> poisoned i.e. written to immediately after mapping.
>>>=20
>>> Add a hook vmemmap_populate_finalize() in =
__populate_section_memmap()
>>> after population, to allow architectures to handle such situations =
as
>>> needed. Then implement it on RISC-V to arrange for the existing
>>> exception handler code to deal with these faults if they happen.
>>>=20
>>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>>> ---
>>> Changes in v4:
>>> - Rebase on v7.2-rc1, drop dependencies
>>> - (No code changes otherwise)
>>> - (A concurrency fix for mark_new_valid_map was sent independently)
>>> =
https://lore.kernel.org/linux-riscv/20260629-riscv-mm-new-valid-map-orderi=
ng-v1-1-60d8c10c6292@iscas.ac.cn/
>>> - Link to v3: =
https://patch.msgid.link/20260605-mark-after-vmemmap-populate-v3-1-a06001a=
c9264@iscas.ac.cn
>>>=20
>>> Changes in v3:
>>> - Merged back into one patch (Mike)
>>> - (No code changes otherwise.)
>>> - Link to v2: =
https://patch.msgid.link/20260604-mark-after-vmemmap-populate-v2-0-ab6a7d0=
3b434@iscas.ac.cn
>>>=20
>>> Changes in v2:
>>> - Split patch in two, hook point and riscv hook=20
>>> - Explain hook necessity in patch 1 message (Mike)
>>> - Make hook #define based (Mike)
>>> - Call finalize hook only on populate success
>>> - Link to v1: =
https://patch.msgid.link/20260525-mark-after-vmemmap-populate-v1-1-e698d85=
9ba16@iscas.ac.cn
>>> ---
>>> arch/riscv/include/asm/pgtable.h | 4 ++++
>>> arch/riscv/mm/init.c             | 6 ++++++
>>> mm/sparse-vmemmap.c              | 8 ++++++++
>>> 3 files changed, 18 insertions(+)
>>>=20
>>> diff --git a/arch/riscv/include/asm/pgtable.h =
b/arch/riscv/include/asm/pgtable.h
>>> index 5d5756bda82e..6b000c990ba7 100644
>>> --- a/arch/riscv/include/asm/pgtable.h
>>> +++ b/arch/riscv/include/asm/pgtable.h
>>> @@ -1253,6 +1253,10 @@ static inline pte_t =
pte_swp_clear_exclusive(pte_t pte)
>>> #define TASK_SIZE FIXADDR_START
>>> #endif
>>>=20
>>> +/* Needed on SPARSEMEM_VMEMMAP */
>>> +#define vmemmap_populate_finalize vmemmap_populate_finalize
>>> +void __meminit vmemmap_populate_finalize(void);
>>> +
>>> #else /* CONFIG_MMU */
>>>=20
>>> #define PAGE_SHARED __pgprot(0)
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index 5b1b3c88b4d1..800cb5c007d1 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -1372,6 +1372,12 @@ int __meminit vmemmap_populate(unsigned long =
start, unsigned long end, int node,
>>> */
>>> return vmemmap_populate_hugepages(start, end, node, altmap);
>>> }
>>> +
>>> +void __meminit vmemmap_populate_finalize(void)
>>> +{
>>> +  /* Avoid faults on cached non-present TLB entries. */
>>> +  mark_new_valid_map();
>>> +}
>>> #endif
>>>=20
>>> #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>>> index 99e2be39671b..290cafcfd723 100644
>>> --- a/mm/sparse-vmemmap.c
>>> +++ b/mm/sparse-vmemmap.c
>>> @@ -544,6 +544,12 @@ static int __meminit =
vmemmap_populate_compound_pages(unsigned long start_pfn,
>>>=20
>>> #endif
>>>=20
>>> +#ifndef vmemmap_populate_finalize
>>> +static void __meminit vmemmap_populate_finalize(void)
>>> +{
>>> +}
>>> +#endif
>>> +
>>> struct page * __meminit __populate_section_memmap(unsigned long pfn,
>>> unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
>>> struct dev_pagemap *pgmap)
>>> @@ -564,6 +570,8 @@ struct page * __meminit =
__populate_section_memmap(unsigned long pfn,
>>> if (r < 0)
>>> return NULL;
>>>=20
>>> +  vmemmap_populate_finalize();
>> Does the hook of flush_cache_vmap() work for you?  =46rom the =
document of
>> cachetlb.rst, it said:=20
>>=20
>> 6) ``void flush_cache_vmap(unsigned long start, unsigned long end)``
>>    ``void flush_cache_vunmap(unsigned long start, unsigned long =
end)``
>>=20
>> Here in these two interfaces we are flushing a specific range
>> of (kernel) virtual addresses from the cache. After running,
>> there will be no entries in the cache for the kernel address
>> space for virtual addresses in the range 'start' to 'end-1'.
>>=20
>> It seems that flush_cache_vmap() is supposed to be called after a new =
kernel
>> mapping has been installed, but before this address range is =
accessed.
>=20
> Good point. I had initially avoided flush_cache_vmap() because, to be
> honest, it looked scary. But the combination of "have vmemmap" and =
"have
> flush_cache_vmap()" is much less scary.
>=20
> I'd need to drop the address range check in RISC-V's =
flush_cache_vmap(),
> but might as well.

No. Please a new check for vmemmap address range.

>=20
>> Therefore, invoking flush_cache_vmap() here aligns perfectly with its =
interface
>> definition. But how would this change impact other architectures? =
Currently,
>> among architectures where CONFIG_SPARSEMEM=3Dy, only RISC-V and =
PowerPC provide
>> a concrete implementation for flush_cache_vmap().
>>=20
>> For PowerPC, the implementation is as follows:
>>=20
>> static inline void flush_cache_vmap(unsigned long start, unsigned =
long end)
>> {
>> asm volatile("ptesync" ::: "memory");
>> }
>>=20
>> Here, flush_cache_vmap() is also intended to supply the ptesync =
instruction
>> that the kernel address mapping lacks. However, flush_cache_vmap() is =
not
>> called in the __populate_section_memmap() path. So, how does PowerPC =
ensure
>> ptesync is executed there? The answer lies in the =
architecture-specific
>> vmemmap_set_pmd(), which injects the necessary ptesync.
>>=20
>> If we choose to reuse flush_cache_vmap() in the generic path, it =
yields the
>> following benefits:
>>=20
>> - Avoids architectural churn: We do not need to introduce a new hook
>>  like vmemmap_populate_finalize().
>> - Cleans up arch code: PowerPC can deprecate its custom =
vmemmap_set_pmd()
>>  and migrate to the generic implementation.
>>=20
>> Let me know if this rationale makes sense, or if there are any hidden =
edge
>> cases I might have overlooked regarding other architectures.
>>=20
>> Thanks,
>> Muchun
>=20
> At least on the face of it, it makes sense. The main thing is I don't
> know much about powerpc. So I'm also hoping powerpc maintainers could
> chime in.=20

You do not need to know about powerpc since the change of powerpc is not
a part of this patch. It should be a separate code clean up for powerpc.

>=20
> I also don't know how this would affect new archs, but if they need
> flush_cache_vmap() they *probably* also want this treatment for =
vmemmap
> hotplug? I guess we can deal with that when it happens.
>=20
> Thanks,
> Vivian "dramforever" Wang



