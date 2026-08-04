Return-Path: <linuxppc-dev+bounces-25359-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CE9C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 11:15:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDrZM5Zc2z2y1Y;
	Tue, 04 Aug 2026 21:15:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785842155;
	cv=none; b=USowOz8W4Q323bzrMVXTxSDDDmyWIvrwf4zsZwk3A/504Q46iqsyCQjRoCqeeIqhw4Fh8Fi7t76GNg1+pwNKNep7tFE/75WSOmarXBYzE58DJEb+4vJwuvJEtG4UadvEjFuVGySDsVqsygrmQ3S8Kv7+3aKgTiGZ16kQKIF8zk+cOrqIWUHeWJxnvSsqLJVYoOYWTyW+1wjs9L1aWdQatHGu0JgNZqVXjnnhz/LzZPQp+v74NsExgMzLhIqBOCsGOcvPiixans4zKhYdX9RJhs4mX/DVPSMMuSTCsFhdJI513sxHh+tcZrC13rFgHGNIVo5Me4v1B0bLm5RZWEES3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785842155; c=relaxed/relaxed;
	bh=1BnYhgvMr/FHPkS0bNJFQoIeIyjuwgqHxPYj6YvNKVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8aX4Jps7dU6I5Ay6WzwieAah2DjM+GLxPYgW+ip0CjWN0p+TxAkIdd0oN6vuWMEaeHw0Uuj3qau3ErHWPknHP/LTNyMWfbZAeAc2IXGIP4lGjMgO2GhmmvFKkSWLvnUgdKN8XD1k4ngdKleyz3fd0ze3tcYTPPHVtuZhUVJEJly87hJzzlqOBuH+0RV0cYX/bwn0aXTTRQ4a6WpewR4eIkm39QV0CeEK6m+aLmwi94OTWncXWMt75W+7De+3ItEWNhJlOKI1oVs7ZgkQAe4CwicRO2yLgRwStbwyr1aqVl12DBMOU9+1PhGFZd8zLCgfQ3UoOZl5MEF8m6B2xf8wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCdqhtW0; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DCdqhtW0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDrZL6sbtz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 21:15:54 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 116CE60A73;
	Tue,  4 Aug 2026 11:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046C71F000E9;
	Tue,  4 Aug 2026 11:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785842152;
	bh=1BnYhgvMr/FHPkS0bNJFQoIeIyjuwgqHxPYj6YvNKVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DCdqhtW0GuGx813a1jz15OF/gAOcKlGQQMgstOkscJnbZ80cNSpXodL8obchTcvvY
	 KQN/nV7kGqJm+LgZAMxiWln9TvZ9vdXnXKBNn04G5L50+Jtsera2TdakLrWXQPjpRJ
	 x8VVNbIUYTfqBCCHJia88Qyqm/NaABhvVg7mu4+1dGtQVeVDCeexi1Iy6rImYBMNfi
	 yuvK2QUypp85rdG0Cu3jYFHIqsB3PJSA8ZplOmQs5oOP8mjC8gas04Nptnlq3h+Y8s
	 Y9VUnlv4cYWu2FTlz34/ZW1CV/hhjFHJB7a6P2rmFU++gl2FT7ktYhKgMqjMNRVXzR
	 yYKcYv6kfq3MQ==
Date: Tue, 4 Aug 2026 12:15:31 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kevin Brodsky <kevin.brodsky@arm.com>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] mm: constify generic pte_get*()
Message-ID: <anHJtpEpXWITllqk@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-6-pfalcato@suse.de>
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
In-Reply-To: <20260803164400.531199-6-pfalcato@suse.de>

On Mon, Aug 03, 2026 at 05:43:59PM +0100, Pedro Falcato wrote:
> None of the helpers need write access to the PTE. Constifying the param
> allows for const typesafety.

constity?

>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

LGTM, so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/linux/pgtable.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 8c093c119e5a..dc418553e57a 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -490,7 +490,7 @@ static inline int pudp_set_access_flags(struct vm_area_struct *vma,
>  #endif
>
>  #ifndef ptep_get
> -static inline pte_t ptep_get(pte_t *ptep)
> +static inline pte_t ptep_get(const pte_t *ptep)
>  {
>  	return READ_ONCE(*ptep);
>  }
> @@ -739,7 +739,7 @@ static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>   * present bit set *unless* it is 'l'. Because get_user_pages_fast() only
>   * operates on present ptes we're safe.
>   */
> -static inline pte_t ptep_get_lockless(pte_t *ptep)
> +static inline pte_t ptep_get_lockless(const pte_t *ptep)
>  {
>  	pte_t pte;
>
> @@ -777,7 +777,7 @@ static inline pmd_t pmdp_get_lockless(pmd_t *pmdp)
>   * We require that the PTE can be read atomically.
>   */
>  #ifndef ptep_get_lockless
> -static inline pte_t ptep_get_lockless(pte_t *ptep)
> +static inline pte_t ptep_get_lockless(const pte_t *ptep)
>  {
>  	return ptep_get(ptep);
>  }
> --
> 2.55.0
>

--
Cheers, Lorenzo

