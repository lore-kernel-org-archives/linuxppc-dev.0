Return-Path: <linuxppc-dev+bounces-20836-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7051FCD4F24
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 May 2026 08:30:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gFmqL04mYz2xpt;
	Wed, 13 May 2026 18:30:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778661005;
	cv=none; b=cQRYNY/anH6LSLBcQLHmre4E3fa3fuh+U9D5xXR0CwX80jBnoxae2u72FDoSrEaEGEzIVrGaCRB8DYYktIUAo2M3on/OYhhk+KUcrjYAYvW4EN9jmxN6fx+gNW+YDKT2Dv6pGqwVUiovJaRJcdGl9zYyOd7YYINGL+eAMZPPkn5RUryiUgF6BSccN5MGp+w3hqKn1H5SggiSLZ0wimUMKn2UolYS477umD/z5ccI8/bz43oZlgYzMogHDj638cFwAH8GR6aS7594DEeF8rrzcep4H5bhzJzRxvvbby1BmnsYUa1YHfgfVB5fVL1qx3yrToqa6znotsiutJUdsww/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778661005; c=relaxed/relaxed;
	bh=vf96suFQXEXD9a3opxXVvFkf/BARBXVgqxdseIJzW9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn7zXJQR/CYGtS2YuLG5a0su3PJBBCasYijjNyYrhYvReeNxdDtVtvQox+0rkn1LuylGRfoKSHbW1ydlJonEAs4l5035FydWHPi1qotdzXhik7Bjv2kHtPbTA39fljWrzRi8cZmlGxGYLbamQ6amGObV/ADZmSj/tvFMuflNtEMekJ1evQCmSwxqkt8CpbMRuKQ9NFMmfWSiP0I5tRThBA2WwBKkXqUdjgkzAja1O81E8uC5dUX9p4nBt3ME9JTYwPq0CiYEWzar0ha1H/tYaKfJR0ovUkctTHm+RUwkICj5ub5UM2y1pFR603y1Kng6OPtN4enO0q1pixAxFzTKaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HO+oY0Nd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HO+oY0Nd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gFmqK14tMz2xn3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2026 18:30:05 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 8E7B843E06;
	Wed, 13 May 2026 08:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0E4C2BCC6;
	Wed, 13 May 2026 08:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778661002;
	bh=ZLaj6u3xCKR0/GZAQ0y6ABck1ESL0dcx2vChaLzZJY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HO+oY0NdOFVz+h7eHE/9LEv12adXbeAnP2ZzwsbhPOMLpmsuysp76rXaSbwEoZL4L
	 MkLN96NUUYoMbW03eInLeBbIKNo8oo9DpBzMo2tlwCEetIMxUxdBk5Qdyp/L4jlfEj
	 H8jWkt6I02G3VbRXauvYbcIrItP+m3HHf72TCU/IG7SrM5Jl4ZtI49zg/GaFvd2wvP
	 fvEmMwncOKALBUmcqhKw6iJFOj0ywjuDbKyylhVuILHn+GXQF56XuiBl+0tIKn7Uqe
	 AfCFABtT36jxPCYHKIvqJQxNUCCM4fphduLkt5+EYb64hjkhu/XR2k6yBvigrqqwx6
	 JOKHlZVyyb4eg==
Date: Wed, 13 May 2026 11:29:51 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/8] mm/bootmem_info: stop using PG_private
Message-ID: <agQ2fwPeMuEbnYeh@kernel.org>
References: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
 <20260511-bootmem_info_prep-v1-3-3fb0be6fc688@kernel.org>
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
In-Reply-To: <20260511-bootmem_info_prep-v1-3-3fb0be6fc688@kernel.org>

On Mon, May 11, 2026 at 04:05:31PM +0200, David Hildenbrand (Arm) wrote:
> Nobody checks PG_private for these pages, and we can happily use
> set_page_private() without setting PG_private. So let's just stop
> setting/clearing PG_private.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/bootmem_info.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/bootmem_info.c b/mm/bootmem_info.c
> index a0a1ecdec8d0..6e2aaab3dca9 100644
> --- a/mm/bootmem_info.c
> +++ b/mm/bootmem_info.c
> @@ -19,7 +19,6 @@ void get_page_bootmem(unsigned long info, struct page *page,
>  {
>  	BUG_ON(type > 0xf);
>  	BUG_ON(info > (ULONG_MAX >> 4));
> -	SetPagePrivate(page);
>  	set_page_private(page, info << 4 | type);
>  	page_ref_inc(page);
>  }
> @@ -32,7 +31,6 @@ void put_page_bootmem(struct page *page)
>  	       type > MEMORY_HOTPLUG_MAX_BOOTMEM_TYPE);
>  
>  	if (page_ref_dec_return(page) == 1) {
> -		ClearPagePrivate(page);
>  		set_page_private(page, 0);
>  		kmemleak_free_part_phys(PFN_PHYS(page_to_pfn(page)), PAGE_SIZE);
>  		free_reserved_page(page);
> 
> -- 
> 2.43.0
> 

-- 
Sincerely yours,
Mike.

