Return-Path: <linuxppc-dev+bounces-19671-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B52DEBFD21
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Apr 2026 09:19:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fvMLf0KMnz2yrZ;
	Mon, 13 Apr 2026 19:19:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776071993;
	cv=none; b=oRO97YUU8GGe6R+PE9MxYFWLPFavccgyfqw0vQt9NmTyiz6c81a89L7iNm1I+igXHV1VpyhvoCq5vRq6y2osampw0miO5Bt2bw8fJttDrHPWPcuvx8dVCpP7qvcHPDEueX3ir90qGCgpPQ1sjurWiCABAIpRHMRt5uKCojdccU50MllvHFFFrR58/Lt/WxgMfHvHN4OULU1KUxGkZ+V0MsT//2c4qveYkytujn8zV2/xy5+q10CTaYgvacWuZkwUryPH2DUtdkdnCX3J/1FXZJ1TJVCDgUngB72CX1BQ11EiV5iKq65MyeJ4mEhDbrJHEHsMejTBpb903+96Cwk3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776071993; c=relaxed/relaxed;
	bh=CKxSA0n9kVvCKpIgcv8zNS+kU9VEMRkmxLm1MYSpV4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCnaT85yxmXOILIqbFEB1wOgD6T2L6pPTuiSHu8xoHGiyNWhERs0Eo04ZDx3mZ4Vpt40/ati4Xy7+f5R9uAg31HpKXChSa2xtxsr/YBTwNu8FFFsz67EeTRMYf5z5hxBjRPK692XXQWJAaOyeY90W1q/j8Di8KxJiwCtt7ENwfO03yl6fAGFB8+WR8X1sR6AqpZz3J8ciRDNBqOuCLLDMqDWlzUGGtgHGq088u41H2MePAf/Wk8uwdSWBumIqiyPIHTUxT4hScYNgYV6CYFOhG9LIyYpq0AmSdh/ReSyaAvOmQkLurkSXfv9Tl0ohcuyV33HIhnmk0Ux2r0UOWA4Fw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bNCjDuM+; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bNCjDuM+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fvMLc6lScz2yjV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2026 19:19:52 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 47B2C60180;
	Mon, 13 Apr 2026 09:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A895C2BCAF;
	Mon, 13 Apr 2026 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776071990;
	bh=2kr+EhMgMQkHVA7iNdaf14YX9cd4ab4OO+SsmIGEbRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bNCjDuM+e/DnQ3gdIUmaMsSzHbtpAX1fNz8FDMsrhCBz/Zx234Yd2VLPGUFxItza8
	 AGkMDnomVyAINuiid0nMJwgViqv6xnF0ti5KODcY4pyAGB0gvsbzVtAdAUc5GmMZbE
	 4k1neV8aNrD6Lpn60QOG7yrpG4PiWQyK1Ti9YnbZoMEYnDCKAVSCXhsDBQqsR3+UWr
	 pxPdV/KIztvfBFdZiRSYDKR4uD8+uS7NbfzM3NXA+lJTQGp1iZtA8VqoX2Of8xzSq1
	 Mtx68qhJuw2Bg363XiG/wIQEmy4oZ5Zp99fI74eCFh4iiBcHG3vA+W8vlfZZ4hwfwX
	 yQuDf3Qdn3Rwg==
Date: Mon, 13 Apr 2026 12:19:41 +0300
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
Message-ID: <ady1LQMN1xhPGcuT@kernel.org>
References: <20260405125240.2558577-1-songmuchun@bytedance.com>
 <20260405125240.2558577-2-songmuchun@bytedance.com>
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
In-Reply-To: <20260405125240.2558577-2-songmuchun@bytedance.com>

On Sun, Apr 05, 2026 at 08:51:52PM +0800, Muchun Song wrote:
> In section_activate(), if populate_section_memmap() fails, the error
> handling path calls section_deactivate() to roll back the state. This
> approach introduces an accounting imbalance.
> 
> Since the commit c3576889d87b ("mm: fix accounting of memmap pages"),
> memmap pages are accounted for only after populate_section_memmap()
> succeeds. However, section_deactivate() unconditionally decrements the
> vmemmap account. Consequently, a failure in populate_section_memmap()
> leads to a negative offset (underflow) in the system's vmemmap tracking.
> 
> We can fix this by ensuring that the vmemmap accounting is incremented
> immediately before checking for the success of populate_section_memmap().
> If populate_section_memmap() fails, the subsequent call to
> section_deactivate() will decrement the accounting, perfectly offsetting
> the increment and maintaining balance.
> 
> Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/sparse-vmemmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index 6eadb9d116e4..ee27d0c0efe2 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -822,11 +822,11 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
>  		return pfn_to_page(pfn);
>  
>  	memmap = populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
> +	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));

This logically belongs to success path in populate_section_memmap(). If we
update the counter there, we won't need to temporarily increase it at all.

>  	if (!memmap) {
>  		section_deactivate(pfn, nr_pages, altmap);
>  		return ERR_PTR(-ENOMEM);
>  	}
> -	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
>  
>  	return memmap;
>  }
> -- 
> 2.20.1
> 

-- 
Sincerely yours,
Mike.

