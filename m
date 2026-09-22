Return-Path: <linuxppc-dev+bounces-27897-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF560C982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 08:03:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hpszq06scz2ygK;
	Tue, 22 Sep 2026 18:03:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::1c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790064214;
	cv=none; b=lJoWK86txUW5s6qkQ0BJ0negvCp7M+ILD8JNPalt6yQcXKBc/JH868BJUsbXZL4QBXv5Yqix2GCmocuS8RzHRlp7pXLCaLo5rGMMdXFQKvpinaUDVsUy/S/GEimN8Gm/gv0OKLnaW4ivTo8WaP6qrd5lLcoOC/TXM/+0DbGom8mKlnaaj3/WbBjtZedVjBw+shFKl66mytbEtiz9bDB7AvPdvEKvemP3EksKk1DdKu7GqWXeWUJ2pX91k1zJm1zfKdlXqqK7l9EXNWAwTrWLEbzWHZLMkkd2jcJrASTOL6Z3SuMx3jDU070h2bwQohb4JahS8//4lJOwGJrtSKeDXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790064214; c=relaxed/relaxed;
	bh=k1M+H772M5pOa/gqHrDwzSK63jkXcdyYdqay93OmEAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UlqBoWsX+T6QSny0AwaX6/XuYKidBUVM3ckLtvDiXhZHnkmjJ+oj3ncXQIqBJ/t6oK8zFwhYH5PUrvzAkgDQVs1XEhvFwrvlg56250XiSC9CtNBAfWEgJh7Jhsb5T9xoYxbdkYPiigslPE7qfgV/6LE3KDzNIW9Jy8Y5eJAdjBqS8ODqpqTofSGFnKrvsdQntoD8FH1Xv4IpyB0XgARwiki/QgRGzFw0u4t6fdTEzS6Fni+zbG/K3GK+QUnaSTRr8E02IWxX/I6hezllmbVvpG4my3KbcYftsVkIiX1K867hCC7sSAe6x2xDtS+Vqc9W27MgGxVGN4hUlrIT/qny3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZvTATnpc; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::1c; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZvTATnpc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::1c; helo=mta0.migadu.com; envelope-from=qi.zheng@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-28.mta0.migadu.com [IPv6:2001:41d0:1004:224b::1c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hpszn44bcz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 18:03:13 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=EOuJmH4XWkfRTntzYM5OUcyHR52bdbnBGOL16e7ckho=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790064174; v=1; x=1790668974;
 b=ZvTATnpcs/aV2Gp6tFIYAKaMInDABpGmadf6B4ywmoM/dKY81t6WWonTc/xQIiiGzxDpISRp
 dWyIi2RfJ38BfXFUjGjShW2JP+fE1aLsyWEiC1zqhs5ysNLcLIJCzASqGJxIsNKhCMmc/UgBPQ8
 rYdiNHOj6E6NXUavHx+h5MoA=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 432c8cc7e60c9375;
	Tue, 22 Sep 2026 08:02:54 +0000
X-Mizu-Trace-ID: 432c8cc7e60c9375
X-Migadu-Flow: FLOW_OUT
Message-ID: <dad55fc6-56ff-4375-893b-938404238ca8@linux.dev>
Date: Tue, 22 Sep 2026 16:02:45 +0800
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
Subject: Re: [PATCH 2/6] mm/sparse-vmemmap: support device DAX in common
 vmemmap path
To: Muchun Song <songmuchun@bytedance.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev
References: <20260913083734.86802-1-songmuchun@bytedance.com>
 <20260913083734.86802-3-songmuchun@bytedance.com>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260913083734.86802-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/13/26 4:37 PM, Muchun Song wrote:
> The common vmemmap population path cannot yet handle optimized Device DAX
> mappings on its own. It uses pfn_to_zone() to find the shared tail page,
> but Device DAX populates its vmemmap at runtime before the ZONE_DEVICE span
> is initialized.
> 
> Teach the common path to use device_zone() for runtime optimized vmemmap
> population while retaining pfn_to_zone() for early boot. This allows the
> same path to support both early boot mappings and Device DAX.
> 
> The backing PFN supplied by the Device DAX-specific population path is no
> longer used, allowing the redundant lookup and population code to be
> removed later.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>   mm/sparse-vmemmap.c | 44 +++++++++++++++++++-------------------------
>   1 file changed, 19 insertions(+), 25 deletions(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 878d29a4e862..e83821768c12 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -208,18 +208,27 @@ static __meminit void *vmemmap_alloc_pte(unsigned long pfn, int node,
>   	struct page *page;
>   	const unsigned int order = pfn_to_section_compound_order(pfn);
>   
> -	/*
> -	 * Device DAX still relies on vmemmap_populate_compound_pages() for
> -	 * head/first-tail allocation and tail-page reuse.
> -	 */
>   	if (!vmemmap_optimizable_pfn(pfn))
>   		return vmemmap_alloc_block_buf(PAGE_SIZE, node, altmap);
>   
> -	zone = pfn_to_zone(pfn, node);
> +	/*
> +	 * At runtime (slab available), only ZONE_DEVICE pages trigger vmemmap
> +	 * optimization, so device_zone() suffices. Note that pfn_to_zone()
> +	 * cannot be used at runtime because the zone span is not set up now.
> +	 */
> +	zone = slab_is_available() ? device_zone(node) : pfn_to_zone(pfn, node);
>   	page = vmemmap_shared_tail_page(order, zone);
>   	if (!page)
>   		return NULL;
>   
> +	/*
> +	 * When a PTE entry is freed, a free_pages() call occurs. This get_page()
> +	 * pairs with put_page_testzero() on the freeing path. This can only occur
> +	 * when slab is available.
> +	 */
> +	if (slab_is_available())

Would it make sense to introduce a helper function that wraps
slab_is_available() for better readability? Also, it might be worth
adding a comment to the helper function as well.

At least for me, encountering this always causes a moment of confusion.

> +		get_page(page);
> +
>   	return page_address(page);
>   }
>   
> @@ -231,27 +240,12 @@ static pte_t * __meminit vmemmap_pte_populate(pmd_t *pmd, unsigned long addr, in
>   
>   	if (pte_none(ptep_get(pte))) {
>   		pte_t entry;
> +		void *p = vmemmap_alloc_pte(pfn, node, altmap);
>   
> -		if (ptpfn == (unsigned long)-1) {
> -			void *p = vmemmap_alloc_pte(pfn, node, altmap);
> -
> -			if (!p)
> -				return NULL;
> -			ptpfn = PHYS_PFN(__pa(p));
> -		} else {
> -			/*
> -			 * When a PTE/PMD entry is freed from the init_mm
> -			 * there's a free_pages() call to this page allocated
> -			 * above. Thus this get_page() is paired with the
> -			 * put_page_testzero() on the freeing path.
> -			 * This can only called by certain ZONE_DEVICE path,
> -			 * and through vmemmap_populate_compound_pages() when
> -			 * slab is available.
> -			 */
> -			if (slab_is_available())
> -				get_page(pfn_to_page(ptpfn));
> -		}
> -		entry = pfn_pte(ptpfn, PAGE_KERNEL);
> +		if (!p)
> +			return NULL;
> +
> +		entry = pfn_pte(PHYS_PFN(__pa(p)), PAGE_KERNEL);
>   		set_pte_at(&init_mm, addr, pte, entry);
>   	} else if (WARN_ON_ONCE(vmemmap_optimizable_pfn(pfn)))
>   		return NULL;


