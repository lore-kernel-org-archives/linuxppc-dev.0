Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0DA606A31E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 22 Oct 2026 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAUOmnUw
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j9Q3v4vRXz2xwL;
	Thu, 22 Oct 2026 23:11:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792671083;
	cv=none; b=azNGpoWrSHtw5dWBvkSD4+EKnBhlAAK1avBe5l/svztgXgexT6A7erqqSpwQsKpzCg5sUWX9PaqVODBLevZJX1B9vzOMyu0Kgm8bYgWu15V9hhHEcuuzRp/y+dEIWVP/Fw1kfmxGWvhlcDYo6pqhqg50IiOrHhJ7umT7D0INtMvx+T2xV+xT/GpSYMfWduLy6bE3WgoNcEhK538Fzoe81P6v0H8stgYktN4ZdsxR8n3zh8Bmn+BYB7rzcovEyFOu3D1BlD0LPkDCn0ssbuD1gs98pHOssNs3ZQ+PL9F0gPR97TIEOnNaYkmm1z/Mfrd3f3aYrLD8XWIyry1hfrcf6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792671083; c=relaxed/relaxed;
	bh=R45se70P3EMmhMkKtYLGOoSJA2q332w3U9R9/qm3AvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP0ie9doamHHbLZhyVCNz44Sxogq2IO2FVPj74qB4XWjv1o1Kvf4QGcAIWnjopVnDydl8rKP1vz1O1LGQHOntuZ1C9Rc0o/+E+NqcP9pderVnqjq0y2USNw/avpD1JG1aUGte6/NZTuw1Mjolc29v1SiyO3Z0xdoHf7H2lIY/bOWbJKMRiQMkAzd7mlfOsbF7q3GDmVt/tDKCGI6vDS19uX1laC5kDqspI+kgtyPgU2nYlUtt6M44Sa6jp/KnwFSkyff97SThUfhpYHm8qjesHNIEmiKHpc02F/WOEbnAmDN0st7WXnTCFQduCso6YBAgb4xbTnoAkikbcihcYh+mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAUOmnUw; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAUOmnUw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j9Q3t1ykzz2xjv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2026 23:11:22 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5A77B60018;
	Thu, 22 Oct 2026 12:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5AD1F000C1;
	Thu, 22 Oct 2026 12:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792671079;
	bh=R45se70P3EMmhMkKtYLGOoSJA2q332w3U9R9/qm3AvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dAUOmnUwYmXnqjnb7xpvzxZUOGMYgicvXndxs7prGd8mnPM1HRCMzBTCy5Wqgajt0
	 7ydupNhuB0KEpvBHR5rfrH5IvHMKVlKDABORylIiEdm8FrF1lNL770+I6n0iaPeAVl
	 YC1M6XYdYp6OHunXm7cWdAcaU2dlpD3/998uXguRKcEj5GyZBrTEdi5TpuzW9WUY6V
	 uR+cGqMYiHlpxwrDQC84R50dPT0QbaRbkx4eFfEHe0Fx1GsqR0lASPJUmBltm4xaIO
	 vLuGnuxQA7/bhka5CHm5PNZw6Q7Lk2fsakVxVTvA/ssGxs5iP3VkeQW16AkZtzvLOY
	 hPwMuhCsUC5Uw==
Date: Thu, 22 Oct 2026 13:11:11 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Peter Xu <peterx@redhat.com>, 
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	=?utf-8?B?TG/Dr2M=?= Molinari <loic.molinari@collabora.com>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 1/4] mm/rmap: duplicate a PMD mapping as one in
 folio_dup_file_rmap_pmd()
Message-ID: <atn3SPG5MKpj2Unj@gremlin>
References: <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com>
 <20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-1-66f00b7a564c@virtuozzo.com>
 <atnEFyGRYGGf9shA@gremlin>
 <71101695-339d-4f8f-b9d8-dfadf7dbd0ed@virtuozzo.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71101695-339d-4f8f-b9d8-dfadf7dbd0ed@virtuozzo.com>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 12:44:40PM +0200, Konstantin Khorenko wrote:
> On 10/22/26 10:07, Lorenzo Stoakes (ARM) wrote:
> >> Fixes: d8ef5e311d7b ("mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()")
>
> > Was this a mistake in d8ef5e311d7b, or actually intentional for whatever reason?
> > If the latter this shouldn't be a fixes.
>
> commit d8ef5e311d7bfde54b60ab45026f206eff31b2d2
>
>     mm/rmap: convert page_dup_file_rmap() to folio_dup_file_rmap_[pte|ptes|pmd]()
>
> ...
> +static inline void folio_dup_file_rmap_ptes(struct folio *folio,
> +               struct page *page, int nr_pages)
> +{
> +       __folio_dup_file_rmap(folio, page, nr_pages, RMAP_LEVEL_PTE);
> +}
>
> ...
> +static inline void folio_dup_file_rmap_pmd(struct folio *folio,
> +               struct page *page)
> +{
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       __folio_dup_file_rmap(folio, page, HPAGE_PMD_NR, RMAP_LEVEL_PTE);
> +#else
> +       WARN_ON_ONCE(true);
> +#endif
> +}

OK so it was just wrong at the time :)

>
> Both functions were introduced in a single commit, i think it's a simple copy-paste issue.
>
> The helper never had a caller, so nobody could hit it. If you prefer, I
> can drop the Fixes tag and only mention d8ef5e311d7b in the changelog, as
> there is nothing to backport.

I mean, it seems like a bug to me? If there's no harm in backporting it I think you
should add Cc: stable@vger.kernel.org in that case actually.

--
Cheers, Lorenzo

