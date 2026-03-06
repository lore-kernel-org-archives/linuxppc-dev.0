Return-Path: <linuxppc-dev+bounces-17848-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81444FCC07C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 21:18:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSK4q5N5Sz2xjQ;
	Sat, 07 Mar 2026 08:18:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772800285;
	cv=none; b=fuMwne8CrAqlOJ8QnWDn5ALUb1MZuTtAGATq7lxtJoRPPaQeRDJWnDCY1OWrzAKWjy/OwKMF3wknk0qkY5BGjGXsUfZL7frtf+imkGzPx5dGZamE/IikbAbi8qMT+6cPkB5bEPnV6CbeulF9Yr16Z/l38NYpn/F9NHYaf/WtK3gbe4cVkkif2ZvGpEJJVKXtc/q34guYwotrjqS0HslB7A/JcHJEunxhA24VGk5AG8QwzV7URe7KvP4fVY/LocfoXuMO4UkeG7Q0N99obUxJXnXnJXcqQhi12zhp5aNHCTR1G+TWTiB38k5PGbN2aYJCFGSdam1pmEkD6cX5SBrVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772800285; c=relaxed/relaxed;
	bh=BTF13s/d85AeKY0BUT+g0GhGGYmCw3CXQ9719Ls0ojY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPO6qHbWfoIDwXIvYScHMJC4QorWeUeEKMrmbcAt6YzKN0wchha2kKc4NtSOnsOy96+Q/Z1MyBZ9cmDPy0b0z0BFFRHkZWwue7H/YDp6Cy005W2Wg+w3CojTj9G2rbCb4mJNTfPhj63hAvE3lo7rKx6QxEgNBvceK1nvIG2NkGI1DDT3D1Xge0zLqllW2DgQw3pBE5kPOtdJFH7Ual0hl5qfYqeIGLGfiXJl9I9DT6WbGkdtQrcOWpWghv7oulycTEHl5pbOVMFkCe+hUIoDOH+XhYBm3Y1cTGRPt/n4yAxTwyled5qAyr3d2ZexzRZsw96HFKpGWo1aKvB33Xp67A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LvR/7HPf; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LvR/7HPf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS5P827f5z3bnJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 23:31:24 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 45BED60018;
	Fri,  6 Mar 2026 12:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF81C2BC86;
	Fri,  6 Mar 2026 12:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772800282;
	bh=LAJ3eHMG09TcFhgWs2EdIeu79xlpIcUA+/nV0cLjx24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LvR/7HPf6wcbcyYRLsw0NDSdEUL1xaUkAW3JmG67UyRk8nOpjrEr2b2NGZY1Rm0QK
	 rmjZWXs/kgIZrKXYtCLoe2wOfAeqwFjFcPcvt+uoLGfKG/Qo+cZY/KlECky/nu7yfe
	 VWWd7vd2jX7axW3zB4eXySNQkQ60kLA1VNARXlEtx0PgK1qc1mJkOGYLZPeIU1jkWi
	 k2zaxtrQMGavqzpX3B010TqicSFWti+U38spA0MblbRmX/eAooWrBcs3e2lHItMiNa
	 oY8qJI8Dwm7XxpAxiijBNODF9u6hWMWr4FWbAtfufjRBYMdKm2jnZp6E+SB/W5VYzM
	 3FhaTnLG18eEQ==
Date: Fri, 6 Mar 2026 12:31:18 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
	"linux-mm @ kvack . org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Alice Ryhl <aliceryhl@google.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Dimitri Sivanich <dimitri.sivanich@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v1 13/16] mm: rename zap_page_range_single_batched() to
 zap_vma_range_batched()
Message-ID: <c63bd1e9-52b0-42a3-a568-bfb0ac0afd5b@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-14-david@kernel.org>
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
In-Reply-To: <20260227200848.114019-14-david@kernel.org>

On Fri, Feb 27, 2026 at 09:08:44PM +0100, David Hildenbrand (Arm) wrote:
> Let's make the naming more consistent with our new naming scheme.
>
> While at it, polish the kerneldoc a bit.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/internal.h |  2 +-
>  mm/madvise.c  |  5 ++---
>  mm/memory.c   | 23 +++++++++++++----------
>  3 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index df9190f7db0e..15a1b3f0a6d1 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -536,7 +536,7 @@ static inline void sync_with_folio_pmd_zap(struct mm_struct *mm, pmd_t *pmdp)
>  }
>
>  struct zap_details;
> -void zap_page_range_single_batched(struct mmu_gather *tlb,
> +void zap_vma_range_batched(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, unsigned long addr,
>  		unsigned long size, struct zap_details *details);
>  int zap_vma_for_reaping(struct vm_area_struct *vma);
> diff --git a/mm/madvise.c b/mm/madvise.c
> index b51f216934f3..fb5fcdff2b66 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -855,9 +855,8 @@ static long madvise_dontneed_single_vma(struct madvise_behavior *madv_behavior)
>  		.reclaim_pt = true,
>  	};
>
> -	zap_page_range_single_batched(
> -			madv_behavior->tlb, madv_behavior->vma, range->start,
> -			range->end - range->start, &details);
> +	zap_vma_range_batched(madv_behavior->tlb, madv_behavior->vma,
> +			      range->start, range->end - range->start, &details);
>  	return 0;
>  }
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 1c0bcdfc73b7..e611e9af4e85 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2167,17 +2167,20 @@ void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
>  }
>
>  /**
> - * zap_page_range_single_batched - remove user pages in a given range
> + * zap_vma_range_batched - zap page table entries in a vma range
>   * @tlb: pointer to the caller's struct mmu_gather
> - * @vma: vm_area_struct holding the applicable pages
> - * @address: starting address of pages to remove
> - * @size: number of bytes to remove
> - * @details: details of shared cache invalidation
> + * @vma: the vma covering the range to zap
> + * @address: starting address of the range to zap
> + * @size: number of bytes to zap
> + * @details: details specifying zapping behavior
> + *
> + * @tlb must not be NULL. The provided address range must be fully
> + * contained within @vma. If @vma is for hugetlb, @tlb is flushed and
> + * re-initialized by this function.
>   *
> - * @tlb shouldn't be NULL.  The range must fit into one VMA.  If @vma is for
> - * hugetlb, @tlb is flushed and re-initialized by this function.
> + * If @details is NULL, this function will zap all page table entries.
>   */
> -void zap_page_range_single_batched(struct mmu_gather *tlb,
> +void zap_vma_range_batched(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, unsigned long address,
>  		unsigned long size, struct zap_details *details)
>  {
> @@ -2225,7 +2228,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
>  	struct mmu_gather tlb;
>
>  	tlb_gather_mmu(&tlb, vma->vm_mm);
> -	zap_page_range_single_batched(&tlb, vma, address, size, NULL);
> +	zap_vma_range_batched(&tlb, vma, address, size, NULL);
>  	tlb_finish_mmu(&tlb);
>  }
>
> @@ -4251,7 +4254,7 @@ static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
>  		size = (end_idx - start_idx) << PAGE_SHIFT;
>
>  		tlb_gather_mmu(&tlb, vma->vm_mm);
> -		zap_page_range_single_batched(&tlb, vma, start, size, details);
> +		zap_vma_range_batched(&tlb, vma, start, size, details);
>  		tlb_finish_mmu(&tlb);
>  	}
>  }
> --
> 2.43.0
>

