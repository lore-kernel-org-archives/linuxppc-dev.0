Return-Path: <linuxppc-dev+bounces-19673-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6BEEBFD25
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 09:35:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvMhZ16LFz2yrZ;
	Mon, 13 Apr 2026 19:35:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776072926;
	cv=none; b=Nu92tWq1LJwhHIjRLvkTtl4BinxiXLN/0SsXvQWBsnmZe2wh1+aYNuR43noHs0ZTlszuFSnChGahvvHd5TSKHztBlzI0SvYstMsW1oGuKeaEn8c7UpeV1B1YWwTNdvmeYgOQTp0pPzFtF14Y6N4T5vvjcqUkls62SLqWS6aotWbt/M2Ad2PHtw8n6NeC9wYOAnuHXfhDfyyE4PCxt+ezyZdWiOumaJ/Yz8eNGjGb2EEaUbspw9cjFZ/BY2CJvSvflk2kdyLw7gUEuOWHIzf8F12Q1UcC8DVFWnzWUQ4BWNrbnaAYrG4/V2LlSwVbUsE03/cLV8nNv1ddcxtI2yHjDA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776072926; c=relaxed/relaxed;
	bh=/Nk7xoozEJi1ro9tenFGPEU5Zl+FKKAQoJl63YSW/FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bpvSSDw/fMUSHU3Qp+UH9U7vAFwADZJJNuIZTLosOa+aAZq2LocmeymxgGWKUCBPKYQJMhZCbKzNsoUkoLCpc8Bdx6W38KowrBpcxicsJeocpk6Vz6iMH4mpCzFxAO+5yIVIkB9DUdKEqYqT876j8w7xbTp14RgXU5Zo33UasF7JDFdsVK8TogE7JwoQIAXbXRKWRXB8msIaM6vPtZas9OW/89Y9DoLlrV9RxLe4wQxnGqkMk5IOdlHL3NxIZHj7h4DemOUj6QnaxZutM+uJxIXu66dFGHeW5xGxpuj664wzv7yIEey27lh7dYSuTFnWeEl0eFTu29tjkDWONULoQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b715bc9u; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=b715bc9u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvMhX6k6lz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 19:35:24 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 93DD660180;
	Mon, 13 Apr 2026 09:35:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7F8C2BCAF;
	Mon, 13 Apr 2026 09:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776072922;
	bh=K0G+OC7cY44wL3XcPEIszFCe8WkP7B+tqb8dxqmAp5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b715bc9uzu+xDII7oSF3dk+qOb9Vy5kUF5WF9SZfGz2uUH5z4NP3CDsqIEMMddhYl
	 jxoIm1krczDBDHzTrZ8sq9L6EB7Kj3MunIE/1BZkIGy32ct9v6rhIhS1/19UuaqNg/
	 oZSbWBMPwojj5BDvW452xa6g1N+CJPZz2GqXarzFOG8oC3HIt913VTcVEi2Qn1HlO/
	 Gpv2w6oL7N7pmOn0pxC/E6tJNwY5SdVaGvyQs7z/ZZ7sW0ncwMSqrBuXZ3VjbjCCTj
	 QU1VAlcKKugE6apzNGFx0ZaNhz89VrBiv445k93tg26DA8flS5AOnZrZdQFboJd+ti
	 3ihwJIH1ISmoQ==
Date: Mon, 13 Apr 2026 12:35:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/49] mm/sparse: fix vmemmap accounting imbalance on
 memory hotplug error
Message-ID: <ady40BWw5WgQHf3z@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-2-songmuchun@bytedance.com>
 <ady1LQMN1xhPGcuT@kernel.org>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ady1LQMN1xhPGcuT@kernel.org>

On Mon, Apr 13, 2026 at 12:19:50PM +0300, Mike Rapoport wrote:
> On Sun, Apr 05, 2026 at 08:51:52PM +0800, Muchun Song wrote:
> > In section_activate(), if populate_section_memmap() fails, the error
> > handling path calls section_deactivate() to roll back the state. This
> > approach introduces an accounting imbalance.
> > 
> > Since the commit c3576889d87b ("mm: fix accounting of memmap pages"),
> > memmap pages are accounted for only after populate_section_memmap()
> > succeeds. However, section_deactivate() unconditionally decrements the
> > vmemmap account. Consequently, a failure in populate_section_memmap()
> > leads to a negative offset (underflow) in the system's vmemmap tracking.
> > 
> > We can fix this by ensuring that the vmemmap accounting is incremented
> > immediately before checking for the success of populate_section_memmap().
> > If populate_section_memmap() fails, the subsequent call to
> > section_deactivate() will decrement the accounting, perfectly offsetting
> > the increment and maintaining balance.
> > 
> > Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  mm/sparse-vmemmap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> > index 6eadb9d116e4..ee27d0c0efe2 100644
> > --- a/mm/sparse-vmemmap.c
> > +++ b/mm/sparse-vmemmap.c
> > @@ -822,11 +822,11 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
> >  		return pfn_to_page(pfn);
> >  
> >  	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
> > +	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
> 
> This logically belongs to success path in populate_section_memmap(). If we
> update the counter there, we won't need to temporarily increase it at all.
 
Not strictly related to this patchset, but it seems, we can have a single
memmap_boot_pages_add() in memmap_alloc() rather than to update the counter
in memmap_alloc() callers.

> >  	if (!memmap) {
> >  		section_deactivate(pfn, nr_pages, altmap);
> >  		return ERR_PTR(-ENOMEM);
> >  	}
> > -	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
> >  
> >  	return memmap;
> >  }
> > -- 
> > 2.20.1
> > 
> 
> -- 
> Sincerely yours,
> Mike.

-- 
Sincerely yours,
Mike.

