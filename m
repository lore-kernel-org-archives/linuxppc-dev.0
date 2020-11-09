Return-Path: <SRS0=+X3i=EP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7D1C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2020 11:39:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A0F206B6
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2020 11:39:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A0F206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CV8Cl4DMXzDqRg
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2020 22:39:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=vbabka@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CV85b73TpzDqPn
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Nov 2020 22:33:54 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2BA62ABF4;
 Mon,  9 Nov 2020 11:33:51 +0000 (UTC)
Subject: Re: [PATCH v5 1/5] mm: introduce debug_pagealloc_{map, unmap}_pages()
 helpers
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
References: <20201108065758.1815-1-rppt@kernel.org>
 <20201108065758.1815-2-rppt@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4bd5ae2b-4fc6-73dc-b83b-e71826990946@suse.cz>
Date: Mon, 9 Nov 2020 12:33:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201108065758.1815-2-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: David Hildenbrand <david@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, x86@kernel.org,
 Mike Rapoport <rppt@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Len Brown <len.brown@intel.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-pm@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 David Rientjes <rientjes@google.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Pekka Enberg <penberg@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/8/20 7:57 AM, Mike Rapoport wrote:
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1428,21 +1428,19 @@ static bool is_debug_pagealloc_cache(struct kmem_cache *cachep)
>   	return false;
>   }
>   
> -#ifdef CONFIG_DEBUG_PAGEALLOC
>   static void slab_kernel_map(struct kmem_cache *cachep, void *objp, int map)
>   {
>   	if (!is_debug_pagealloc_cache(cachep))
>   		return;

Hmm, I didn't notice earlier, sorry.
The is_debug_pagealloc_cache() above includes a debug_pagealloc_enabled_static() 
check, so it should be fine to use
__kernel_map_pages() directly below. Otherwise we generate two static key checks 
for the same key needlessly.

>   
> -	kernel_map_pages(virt_to_page(objp), cachep->size / PAGE_SIZE, map);
> +	if (map)
> +		debug_pagealloc_map_pages(virt_to_page(objp),
> +					  cachep->size / PAGE_SIZE);
> +	else
> +		debug_pagealloc_unmap_pages(virt_to_page(objp),
> +					    cachep->size / PAGE_SIZE);
>   }
>   
> -#else
> -static inline void slab_kernel_map(struct kmem_cache *cachep, void *objp,
> -				int map) {}
> -
> -#endif
> -
>   static void poison_obj(struct kmem_cache *cachep, void *addr, unsigned char val)
>   {
>   	int size = cachep->object_size;
> @@ -2062,7 +2060,7 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
>   
>   #if DEBUG
>   	/*
> -	 * If we're going to use the generic kernel_map_pages()
> +	 * If we're going to use the generic debug_pagealloc_map_pages()
>   	 * poisoning, then it's going to smash the contents of
>   	 * the redzone and userword anyhow, so switch them off.
>   	 */
> 

