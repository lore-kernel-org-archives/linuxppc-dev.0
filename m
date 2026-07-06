Return-Path: <linuxppc-dev+bounces-23582-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5612FC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Jul 2026 05:12:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gtst93bFZz2yfS;
	Mon, 06 Jul 2026 15:12:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783314737;
	cv=none; b=RetmXWaO7hhzZ53ICq7VPrGUy65NvSAPj/LLQ7q6mAoW2jPNCHJY+G4Uf0qt+QmEsjOJZ20wa8XKZBLwHTLH6PsJxpqmkwYbaeKmIrCIGD3KIOOo+pjoWPkcUxvhQPTKh1NVAUv60W3D83yIjxhQZoILlZzts0fFlj9+HDBs5nmXg4VBVD0gltrACkvHSI9K/HkYjOYnH5OOOjGkHGCjXjVAVheCL1M36E9zY8oVp7f9SLOoh22HxhPqF26iyRZGEkZPbmQjvvZPZSBWGarKE9lCua2BOyco3Gv9s99bjnpDi94iqhoBlVxBcpwueSh64jwz9ev7axAKefTHSN1B2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783314737; c=relaxed/relaxed;
	bh=LiQzx+6th98Jx9m7YifvuMKucG9ElNNq678dGRx9yxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h5Pq2lC0ICjinqEkrdxopVOYZOINeig2oaDZehTkX+PX/eIyESLDB/ja9gCVhcV1EiWPEQGckjNQhZ/jtq+tUXiulpb4WqB3jeDsisIzVrvfdv0ftJDBZHWnjT4zjWiEbuzhcbhn5xTNUmN4+GMYYLC/T2JIa0lI585uP50dc3ML8WVxfY5LAsgFIpWmZi6R7wbewbQTYwJ6dJvEd07MnhBoVzjM7JJi6BxLm0fs8XXayYzdo2bzh4jDPZEIS2kuXCXGgIsJQEiG/6c0j2w1jdbWANkK1W3xZWBngKFLDXl4PmsusUMzlPNAifb5bSlOMdB15MKdYPYyJ9J/HrYApw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=wangruikang@iscas.ac.cn; receiver=lists.ozlabs.org) smtp.mailfrom=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=iscas.ac.cn (client-ip=159.226.251.21; helo=cstnet.cn; envelope-from=wangruikang@iscas.ac.cn; receiver=lists.ozlabs.org)
X-Greylist: delayed 448 seconds by postgrey-1.37 at boromir; Mon, 06 Jul 2026 15:12:16 AEST
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gtst81m4Jz2yVZ
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2026 15:12:15 +1000 (AEST)
Received: from [192.168.0.113] (unknown [123.118.218.239])
	by APP-01 (Coremail) with SMTP id qwCowAC3VM1AN0tqdg_qBA--.32811S2;
	Mon, 06 Jul 2026 13:04:00 +0800 (CST)
Message-ID: <5fac578c-ff97-4721-96f3-8ba495f0556a@iscas.ac.cn>
Date: Mon, 6 Jul 2026 13:04:00 +0800
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
Subject: Re: [PATCH v4] riscv: mm: Avoid spurious fault after hotplugging
 vmemmap
To: Muchun Song <muchun.song@linux.dev>, linuxppc-dev@lists.ozlabs.org
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alexandre Ghiti <alex@ghiti.fr>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
References: <20260630-mark-after-vmemmap-populate-v4-1-febbc15da028@iscas.ac.cn>
 <7B0CB4ED-C190-4F49-97EE-E1F14F08DED2@linux.dev>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <7B0CB4ED-C190-4F49-97EE-E1F14F08DED2@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAC3VM1AN0tqdg_qBA--.32811S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JF4UCw1DZF4xJF4kJr15twb_yoWxZw4kpF
	Wj9an8KFs8Jr1xuw4Ivw17Wrn3twnYga4xGw18K34rZwn8JFy7Wr9YgayYqry5XFWkuayI
	y3WYk345uwn8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
	MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYsSdPUUUUU==
X-Originating-IP: [123.118.218.239]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

[ powerpc maintainers: Thoughts on replacing the ptesync in
vmemmap_set_pmd() with a flush_cache_vmap() post-vmemmap-hotplug in the
generic code? ]

On 7/6/26 11:00, Muchun Song wrote:
>> On Jun 30, 2026, at 15:51, Vivian Wang <wangruikang@iscas.ac.cn> wrote:
>>
>> section_activate() does not flush TLB after populating new vmemmap
>> pages. On most architectures, this is okay. However it is a problem on
>> RISC-V since there the TLB caching non-present entries is permitted,
>> which causes spurious faults on some hardwares.
>>
>> This seems to be most easily reproduced with DEBUG_VM=y and
>> PAGE_POISONING=y, which causes these newly mapped struct pages to be
>> poisoned i.e. written to immediately after mapping.
>>
>> Add a hook vmemmap_populate_finalize() in __populate_section_memmap()
>> after population, to allow architectures to handle such situations as
>> needed. Then implement it on RISC-V to arrange for the existing
>> exception handler code to deal with these faults if they happen.
>>
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>> ---
>> Changes in v4:
>> - Rebase on v7.2-rc1, drop dependencies
>> - (No code changes otherwise)
>> - (A concurrency fix for mark_new_valid_map was sent independently)
>>  https://lore.kernel.org/linux-riscv/20260629-riscv-mm-new-valid-map-ordering-v1-1-60d8c10c6292@iscas.ac.cn/
>> - Link to v3: https://patch.msgid.link/20260605-mark-after-vmemmap-populate-v3-1-a06001ac9264@iscas.ac.cn
>>
>> Changes in v3:
>> - Merged back into one patch (Mike)
>> - (No code changes otherwise.)
>> - Link to v2: https://patch.msgid.link/20260604-mark-after-vmemmap-populate-v2-0-ab6a7d03b434@iscas.ac.cn
>>
>> Changes in v2:
>> - Split patch in two, hook point and riscv hook 
>> - Explain hook necessity in patch 1 message (Mike)
>> - Make hook #define based (Mike)
>> - Call finalize hook only on populate success
>> - Link to v1: https://patch.msgid.link/20260525-mark-after-vmemmap-populate-v1-1-e698d859ba16@iscas.ac.cn
>> ---
>> arch/riscv/include/asm/pgtable.h | 4 ++++
>> arch/riscv/mm/init.c             | 6 ++++++
>> mm/sparse-vmemmap.c              | 8 ++++++++
>> 3 files changed, 18 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
>> index 5d5756bda82e..6b000c990ba7 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -1253,6 +1253,10 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>> #define TASK_SIZE FIXADDR_START
>> #endif
>>
>> +/* Needed on SPARSEMEM_VMEMMAP */
>> +#define vmemmap_populate_finalize vmemmap_populate_finalize
>> +void __meminit vmemmap_populate_finalize(void);
>> +
>> #else /* CONFIG_MMU */
>>
>> #define PAGE_SHARED __pgprot(0)
>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> index 5b1b3c88b4d1..800cb5c007d1 100644
>> --- a/arch/riscv/mm/init.c
>> +++ b/arch/riscv/mm/init.c
>> @@ -1372,6 +1372,12 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>> */
>> 	return vmemmap_populate_hugepages(start, end, node, altmap);
>> }
>> +
>> +void __meminit vmemmap_populate_finalize(void)
>> +{
>> + 	/* Avoid faults on cached non-present TLB entries. */
>> + 	mark_new_valid_map();
>> +}
>> #endif
>>
>> #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
>> index 99e2be39671b..290cafcfd723 100644
>> --- a/mm/sparse-vmemmap.c
>> +++ b/mm/sparse-vmemmap.c
>> @@ -544,6 +544,12 @@ static int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
>>
>> #endif
>>
>> +#ifndef vmemmap_populate_finalize
>> +static void __meminit vmemmap_populate_finalize(void)
>> +{
>> +}
>> +#endif
>> +
>> struct page * __meminit __populate_section_memmap(unsigned long pfn,
>> unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
>> struct dev_pagemap *pgmap)
>> @@ -564,6 +570,8 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
>> 	if (r < 0)
>> 		return NULL;
>>
>> + 	vmemmap_populate_finalize();
> Does the hook of flush_cache_vmap() work for you?  From the document of
> cachetlb.rst, it said: 
>
> 	6) ``void flush_cache_vmap(unsigned long start, unsigned long end)``
> 	   ``void flush_cache_vunmap(unsigned long start, unsigned long end)``
>
> 		Here in these two interfaces we are flushing a specific range
> 		of (kernel) virtual addresses from the cache. After running,
> 		there will be no entries in the cache for the kernel address
> 		space for virtual addresses in the range 'start' to 'end-1'.
>
> It seems that flush_cache_vmap() is supposed to be called after a new kernel
> mapping has been installed, but before this address range is accessed.

Good point. I had initially avoided flush_cache_vmap() because, to be
honest, it looked scary. But the combination of "have vmemmap" and "have
flush_cache_vmap()" is much less scary.

I'd need to drop the address range check in RISC-V's flush_cache_vmap(),
but might as well.

> Therefore, invoking flush_cache_vmap() here aligns perfectly with its interface
> definition. But how would this change impact other architectures? Currently,
> among architectures where CONFIG_SPARSEMEM=y, only RISC-V and PowerPC provide
> a concrete implementation for flush_cache_vmap().
>
> For PowerPC, the implementation is as follows:
>
> 	static inline void flush_cache_vmap(unsigned long start, unsigned long end)
> 	{
> 		asm volatile("ptesync" ::: "memory");
> 	}
>
> Here, flush_cache_vmap() is also intended to supply the ptesync instruction
> that the kernel address mapping lacks. However, flush_cache_vmap() is not
> called in the __populate_section_memmap() path. So, how does PowerPC ensure
> ptesync is executed there? The answer lies in the architecture-specific
> vmemmap_set_pmd(), which injects the necessary ptesync.
>
> If we choose to reuse flush_cache_vmap() in the generic path, it yields the
> following benefits:
>
> - Avoids architectural churn: We do not need to introduce a new hook
>   like vmemmap_populate_finalize().
> - Cleans up arch code: PowerPC can deprecate its custom vmemmap_set_pmd()
>   and migrate to the generic implementation.
>
> Let me know if this rationale makes sense, or if there are any hidden edge
> cases I might have overlooked regarding other architectures.
>
> Thanks,
> Muchun

At least on the face of it, it makes sense. The main thing is I don't
know much about powerpc. So I'm also hoping powerpc maintainers could
chime in. 

I also don't know how this would affect new archs, but if they need
flush_cache_vmap() they *probably* also want this treatment for vmemmap
hotplug? I guess we can deal with that when it happens.

Thanks,
Vivian "dramforever" Wang


