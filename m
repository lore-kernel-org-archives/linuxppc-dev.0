Return-Path: <linuxppc-dev+bounces-19694-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E51F34C53
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 13:36:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvT285V7nz2ydn;
	Mon, 13 Apr 2026 23:36:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776087360;
	cv=none; b=e/v/yKBWK+UjG4qlzYGHsXbMd3XKGcm4GFUrkxqn1oTnCOytpjo6LiXH/ZEWMEN1/sbsrLlTGawSqkg/NOkR2ouWVVq73f6RFYSjMMp78XzZA095P5R7X1WqXfImAk3amwVhOim5v8XrECZ6v15xVm7RQZKn16SA4J6PTr5k2/hQpf/AHiklFM6s4qb6EgOc74h3Ptg2qoWYWbJ886HkQ07MH7DG6ot8e32zRIHrVXXKYcZmvrjbZmEIB900ABzfthVBrFMdGjB0Uengk+BQmG5cqZwqdoW4B+hSuPnbDDDbcErNYOd1PVtzd/xtmbf1Vr8uSKbOhKSIobT1FZWtpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776087360; c=relaxed/relaxed;
	bh=SrjpwvB83N2giVKGPFKhc5pvsj2/HjIz0wMXzQQvs+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcIi318OMcTuzMo87YIXSfZghVEFYcVA3nVEEwGQqIri8zeXDjh2migqSFchaIGipEL7kfzk6g5OSVjRVJR4HvRDy8I+aHjECwvpav8xkszQ9WT6Z0SGBUpi+R88FKRnQwZVmClmk3y+yFCc46STDsRaaqzw5hO2WhGt1mLgkaBr2qB05pFIWucCt1QzataXr90xDxEZxGIbLSQa1SRLrl/LM6a2XIEsgE5OgThtHwijlGrOD0QI1HQ0BWauYhBlR5jBdYRgx+RI7xfMqLI0L8lzw0B4fvSoGj4e/5aau/wsU43l9HwxvR/bBPFhciIT4nLVsFpVYPqy7nDkTALkQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O2V2Ka6m; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=O2V2Ka6m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvT2769ztz2yS9
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 23:35:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B5F6B437A4;
	Mon, 13 Apr 2026 13:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C5AC2BCAF;
	Mon, 13 Apr 2026 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776087357;
	bh=xRUAWLrLgzwCdGi7KEt4++j4ZklzOjG8GAiY3yBRcWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O2V2Ka6m8t7FhRSXO3t1Sodi7if2bOG/BstBJVrdrfAs77AHjkdBsdh1wcEstujtW
	 Pcv7UdqWAunyHp5xXBxNMQs9y3ZS1HBnJVMlWhs2SvQufE4uoI+Z5jzyqROACi9P5X
	 lx++2pz+0BMA4WBx7xBvVjRH9VAoWX+31ym0QCr7BSAWjYzt7FsN1Z0cXHpY+1FoKx
	 m2wGoVRnNcyNhZOoWASweYAR0GWveSxc0LiIsAHiSBZGyv3EkHwkJYrT6PMTSRyZTI
	 n7uFaRdKk6ZmwtE+nRnDTtrFJQh39d6c8O1NVYd/EON9R+VMcZpuOay6ljEbqe4Ebq
	 Fvdzgcgm2+j6A==
Date: Mon, 13 Apr 2026 16:35:48 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: Muchun Song <songmuchun@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Liam R Howlett <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/49] mm/sparse: fix vmemmap accounting imbalance on
 memory hotplug error
Message-ID: <adzxNAa7RnUDrykW@kernel.org>
References: <adzb5o9aWxFWphRK@kernel.org>
 <8AEA6BCE-570F-4095-ADCF-9699BDE0DD64@linux.dev>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8AEA6BCE-570F-4095-ADCF-9699BDE0DD64@linux.dev>

Hi Muchun,

On Mon, Apr 13, 2026 at 08:47:45PM +0800, Muchun Song wrote:
> > On Apr 13, 2026, at 20:05, Mike Rapoport <rppt@kernel.org> wrote:
> >>>>> 
> >>>>> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> >>>>> index 6eadb9d116e4..ee27d0c0efe2 100644
> >>>>> --- a/mm/sparse-vmemmap.c
> >>>>> +++ b/mm/sparse-vmemmap.c
> >>>>> @@ -822,11 +822,11 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >>>>> return pfn_to_page(pfn);
> >>>>> 
> >>>>> memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
> >>>>> + memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
> >>>> 
> >>>> This logically belongs to success path in populate_section_memmap(). If we
> >>>> update the counter there, we won't need to temporarily increase it at all.
> >>> 
> >>> Not strictly related to this patchset, but it seems, we can have a single
> >>> memmap_boot_pages_add() in memmap_alloc() rather than to update the counter
> >>> in memmap_alloc() callers.
> >> 
> >> It will indeed become simpler and is a good cleanup direction, but there
> >> is a slight change in semantics: the page tables used for vmemmap page
> >> mapping will also be counted in memmap_boot_pages_add(). This might not
> >> be an issue (after all, the size of the page tables is very small compared
> >> to struct pages, right?).
> >> 
> >> Additionally, I still lean toward making no changes to this patch, because
> >> this is a pure bugfix patch — of course, it is meant to facilitate backporting
> >> for those who need it. The cleanup would involve many more changes, so I
> >> prefer to do that in a separate patch. What do you think?
> > 
> > For this patch and easy backporting I still think that cleaner to have the
> > counter incremented in populate_section_memmap() rather immediately after
> > it.
> 
> Hi Mike,
> 
> Alright, let’s revisit your solution. After we’ve moved the counter into the 
> populate_section_memmap(), we still need to increase the counter temporarily
> (but in populate_section_memmap()) even if we fail to populate. That’s
> because section_deactivate() reduces the counter without exception, isn’t it?
> Just want to make sure we are on the same page on the meaning of “temporarily
> increase”.  Maybe you do not mean “temporarily” in this case.

I suggest to increase the counter only if we succeeded to populate:

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 6eadb9d116e4..247fd54f1003 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -656,7 +656,13 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
 {
-	return __populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
+	struct page *p = __populate_section_memmap(pfn, nr_pages, nid, altmap,
+						   pgmap);
+
+	if (p)
+		memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+
+	return p;
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
@@ -826,7 +832,6 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 
 	return memmap;
 }
 

Then we'll better follow "all or nothing" principle and won't have
exceptional cases in section_deactivate().

> Thanks,
> Muchun.

-- 
Sincerely yours,
Mike.

