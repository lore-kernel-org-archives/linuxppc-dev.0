Return-Path: <linuxppc-dev+bounces-21973-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D7DCD6E4A
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Jun 2026 12:24:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVn2R2yQlz2y1Y;
	Wed, 03 Jun 2026 22:24:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.185
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780489487;
	cv=none; b=mhAkflHQI1ym3ge3pGUDv1snM/CUD00TeaoWLw1Qyy9PxvdUl8u4G5SjF2BjCrttgx2OAWKHpY53gAto48ofkoTJfVH6M1Et7HuKfYZTbeBoh9H3286rTBPOFv5CIMNj1zcmdb3G78t5vvY81uA4o2vdaaz+dnFQMr1bkdkhOGRTtBGoS2WELbCPo8S8Vwidg+bQD/EFuEE6Eo8B+GCIvO5/JuKwlo7xd/I19wzsTyLivduki0bv+H5raMz0lWWJ5sD+zsD1gG4JZ+nWjk51uiO15vcl6V2KAJ0b2E3rClTDm6qjJ9mx9/6Y8JhNVTd6S4tmqb/gBzpOruo3WuoeIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780489487; c=relaxed/relaxed;
	bh=i81FGwAX/vixZ25Q3Ngd8ivvoVTv7aSnS7HWQVQ1K20=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfpVRpRH37WhZn+R7X8/GXrnBEjz21oSOWFkcB3vat1LUK9Al5/KsN95Msh8ax9+pRNNRLIMW6lJ0aSSRZUa7j4q8mAiaKveR7RDFmPtfb+Bh1zd585gGs4/s4564tBncI+4k0kbu2MXrudnIssJ7LXaIWpZJ4gTNJpvUw1kF2Uc1ayZLp00GQHPZhQ9cKF299A0ZHE8dh+fot2xZB2Yys0wikcyr1MsY7xjZ2cOkcyvd2aaCBn3BdBdXR10HS+L2sNJYUhvWq7YxfXhjOiNcB50ItlUrCrGWcHnG4DlYP1PE9JcOxrdM9skp3MsZ+Vu1j6b95VbvN70xRSGv/4/BQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HubuBb2q; dkim-atps=neutral; spf=pass (client-ip=91.218.175.185; helo=out-185.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=HubuBb2q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.185; helo=out-185.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVn2N0d0Gz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 22:24:42 +1000 (AEST)
Message-ID: <f9dd874a-b637-4740-9a63-8da66de323ca@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780489462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i81FGwAX/vixZ25Q3Ngd8ivvoVTv7aSnS7HWQVQ1K20=;
	b=HubuBb2qZb4N9mqtKd+HqBZxa//bXTQ7vqPh0cqo521lhCGrl2arQXZ0egrlgrhMVPjN1w
	58IEh2Vdv9FcCt9r5uDyBa3ErJYP6T7LGb5Df4WMvfpy1qfJaqgAjvA1opfVW8eeXtT4yb
	kc47gaP4MkVI9XYMHI853t/97ZI2r0w=
Date: Wed, 3 Jun 2026 20:24:09 +0800
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
Subject: Re: [PATCH v3 15/19] mm/hugetlb_vmemmap: Move bootmem HVO setup to
 early init
To: Usama Arif <usama.arif@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Mike Rapoport <rppt@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Muchun Song <songmuchun@bytedance.com>
References: <20260603120246.1572177-1-usama.arif@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260603120246.1572177-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/3 20:02, Usama Arif wrote:
> On Tue,  2 Jun 2026 18:10:35 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
>> Bootmem HugeTLB pages currently defer HVO setup to
>> hugetlb_vmemmap_init_late(), because the optimization needs zone
>> information.
>>
>> Now that zone initialization is available earlier, the bootmem HVO setup
>> can be done directly from hugetlb_vmemmap_init_early(). This lets
>> gigantic HugeTLB pages apply HVO as soon as they are allocated.
>>
>> Bootmem gigantic pages that span multiple zones are now filtered out
>> when they are allocated, so the remaining bootmem gigantic pages seen by
>> later hugetlb initialization are already zone-valid. As a result,
>> hugetlb_vmemmap_init_late() no longer needs to handle bootmem HVO setup.
>>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>>   mm/hugetlb_vmemmap.c | 67 +++++++++-----------------------------------
>>   1 file changed, 13 insertions(+), 54 deletions(-)
>>
>> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
>> index ea6af85bfec1..464578ee246e 100644
>> --- a/mm/hugetlb_vmemmap.c
>> +++ b/mm/hugetlb_vmemmap.c
>> @@ -745,6 +745,8 @@ static bool vmemmap_should_optimize_bootmem_page(struct huge_bootmem_page *m)
>>   	return true;
>>   }
>>   
>> +static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn);
>> +
>>   /*
>>    * Initialize memmap section for a gigantic page, HVO-style.
>>    */
>> @@ -752,6 +754,7 @@ void __init hugetlb_vmemmap_init_early(int nid)
>>   {
>>   	unsigned long psize, paddr, section_size;
>>   	unsigned long ns, i, pnum, pfn, nr_pages;
>> +	unsigned long start, end;
>>   	struct huge_bootmem_page *m = NULL;
>>   	void *map;
>>   
>> @@ -761,6 +764,8 @@ void __init hugetlb_vmemmap_init_early(int nid)
>>   	section_size = (1UL << PA_SECTION_SHIFT);
>>   
>>   	list_for_each_entry(m, &huge_boot_pages[nid], list) {
>> +		struct zone *zone;
>> +
>>   		if (!vmemmap_should_optimize_bootmem_page(m))
>>   			continue;
>>   
>> @@ -769,6 +774,14 @@ void __init hugetlb_vmemmap_init_early(int nid)
>>   		paddr = virt_to_phys(m);
>>   		pfn = PHYS_PFN(paddr);
>>   		map = pfn_to_page(pfn);
>> +		start = (unsigned long)map;
>> +		end = start + hugetlb_vmemmap_size(m->hstate);
>> +		zone = pfn_to_zone(nid, pfn);
>> +
>> +		if (vmemmap_populate_hvo(start, end, huge_page_order(m->hstate),
>> +					 zone, HUGETLB_VMEMMAP_RESERVE_SIZE))
>> +			panic("Failed to allocate memmap for HugeTLB page\n");
> The replaced hugetlb_vmemmap_init_late() path used to fall back to
> vmemmap_populate() if vmemmap_populate_hvo() returned an error and
> just lost the HVO optimization for that page.
>
> The new path panics on any non-zero return.  Is the panic intended,
> given that vmemmap_populate_hvo() returns -ENOMEM on allocation
> failure and HVO is normally treated as an optimization rather than a
> hard requirement?

This is intentional; see patch 6:

     mm/sparse: Panic on memmap and usemap allocation failure

We already panic on OOM anyway.

Muchun,
Thanks.

>
>> +		memmap_boot_pages_add(DIV_ROUND_UP(HUGETLB_VMEMMAP_RESERVE_SIZE, PAGE_SIZE));
>>   
>>   		pnum = pfn_to_section_nr(pfn);
>>   		ns = psize / section_size;
>> @@ -800,60 +813,6 @@ static struct zone *pfn_to_zone(unsigned nid, unsigned long pfn)
>>   
>>   void __init hugetlb_vmemmap_init_late(int nid)
>>   {
>> -	struct huge_bootmem_page *m, *tm;
>> -	unsigned long phys, nr_pages, start, end;
>> -	unsigned long pfn, nr_mmap;
>> -	struct zone *zone = NULL;
>> -	struct hstate *h;
>> -	void *map;
>> -
>> -	if (!READ_ONCE(vmemmap_optimize_enabled))
>> -		return;
>> -
>> -	list_for_each_entry_safe(m, tm, &huge_boot_pages[nid], list) {
>> -		if (!(m->flags & HUGE_BOOTMEM_HVO))
>> -			continue;
>> -
>> -		phys = virt_to_phys(m);
>> -		h = m->hstate;
>> -		pfn = PHYS_PFN(phys);
>> -		nr_pages = pages_per_huge_page(h);
>> -		map = pfn_to_page(pfn);
>> -		start = (unsigned long)map;
>> -		end = start + nr_pages * sizeof(struct page);
>> -
>> -		if (!hugetlb_bootmem_page_zones_valid(nid, m)) {
>> -			/*
>> -			 * Oops, the hugetlb page spans multiple zones.
>> -			 * Remove it from the list, and populate it normally.
>> -			 */
>> -			list_del(&m->list);
>> -
>> -			vmemmap_populate(start, end, nid, NULL);
>> -			nr_mmap = end - start;
>> -			memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
>> -
>> -			memblock_phys_free(phys, huge_page_size(h));
>> -			continue;
>> -		}
>> -
>> -		if (!zone || !zone_spans_pfn(zone, pfn))
>> -			zone = pfn_to_zone(nid, pfn);
>> -		if (WARN_ON_ONCE(!zone))
>> -			continue;
>> -
>> -		if (vmemmap_populate_hvo(start, end, huge_page_order(h), zone,
>> -					 HUGETLB_VMEMMAP_RESERVE_SIZE) < 0) {
>> -			/* Fallback if HVO population fails */
>> -			vmemmap_populate(start, end, nid, NULL);
>> -			nr_mmap = end - start;
>> -		} else {
>> -			m->flags |= HUGE_BOOTMEM_ZONES_VALID;
>> -			nr_mmap = HUGETLB_VMEMMAP_RESERVE_SIZE;
>> -		}
>> -
>> -		memmap_boot_pages_add(DIV_ROUND_UP(nr_mmap, PAGE_SIZE));
>> -	}
>>   }
>>   #endif
>>   
>> -- 
>> 2.54.0
>>
>>


