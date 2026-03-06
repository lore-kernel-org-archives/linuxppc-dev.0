Return-Path: <linuxppc-dev+bounces-17815-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63684F01832
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 12:25:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS5Gj5ptMz3c5f;
	Fri, 06 Mar 2026 23:25:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772799429;
	cv=none; b=WseB52Md3/8DzutXZQmYzGIZN+B7UMit1IH0uBY9orgONRq6AKjYVKAlnneTDwGeBNdu9WI1bMeM9pHkPfC64ip7g4Tr+86kepa3N73YVjLyS7zF+oypgAS98BiZIyNtG3AuQDoXjzcBQhkRztTsPx6WHwvj6FAzBDiubTDXjywoKDBOzdFYSeGC5rI7kLUMc+/GPca4uMpQ8v7yBHoQKF4XktFtCKJY9m9yFXVRLTCc96AImrGhag8QvJqBG/p4Vo8z5i/f836xNGH55E2IPB5I2SGh9ajjZ0TmI27Jq73k/C4xLmlWBMpDzJ+WPxKJUXe+Xk6mzW6L0jz/9E3HeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772799429; c=relaxed/relaxed;
	bh=BV8fC1T//HdeySruETzb+RJ8scMYDvmvtEN6cwp8Bkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aCwnJ5Hirevx1NRYVcqZEyGXYfL4xNB5rVUL1MfG3tin0MsmO9K/RpMeBhqjhOzOAl8z/CYiqBsbgkkgyDxuK9mVntgNAfv1Ub2C7+0lP6eAs+LHxsGH63RTp+6tzfU26BT+l23aw2yCRS1ADSzFFJZNrRMVBwjxLrQejL+RxqpPfZwLAuJoyEJIRZgYDkIdIqKG004z8wqc37fO+v2j6teSAFm0PyXiaaLa7yumnEqXRzQUVkLg9CuyjPE4+KSSiT0UZYnrEMhyqepy9tYnxEhZI7nZANypWI+T3xlA+BW7BOVLIXa89sCqRJWTrXC30u66L7A6buXYB0n2Ck9qiQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JE9hl+xg; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JE9hl+xg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS54h3bLSz30T9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 23:17:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 516C242A97;
	Fri,  6 Mar 2026 12:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9601AC4CEF7;
	Fri,  6 Mar 2026 12:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772799426;
	bh=E50Nei4wvO5acKQ5WAuR9y8yrxBw8Jw9n6m//WAfpNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JE9hl+xgT0bTGi+BM5jUSHSxJhmfXyDYuZyy882H8pwaPVW4rs91GqXsOlDdNYt5q
	 M4CYD21uXiIoE80aCpIXZWa8pvS6BpzRhby5F3zlbgDBohqfN8gLvqI1ZzEKj9Sq8O
	 1GA8U2yXsayzOcXwk/z9rDzRougLhaH2sFQZ/lImuHVanVDszwy6gcpcLHaEn0JF34
	 5MRb84nwU6hkVV8bxr42O43gDIOYuZx7PoAczRQyQjOzRXl+pydnhhFnDCu0OWdTD3
	 GeXNhxm0JknludP4ZgMHI0L5kkBWpm7KDg9wTx0PM6ikXJpjNR7e3ecgYQUbTFzh7m
	 tM4T4pFHUGsng==
Date: Fri, 6 Mar 2026 12:17:03 +0000
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
Subject: Re: [PATCH v1 06/16] mm/oom_kill: factor out zapping of VMA into
 zap_vma_for_reaping()
Message-ID: <d92e21ff-50cd-485b-8f48-621e8ae1b169@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-7-david@kernel.org>
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
In-Reply-To: <20260227200848.114019-7-david@kernel.org>

On Fri, Feb 27, 2026 at 09:08:37PM +0100, David Hildenbrand (Arm) wrote:
> Let's factor it out so we can turn unmap_page_range() into a static
> function instead, and so oom reaping has a clean interface to call.
>
> Note that hugetlb is not supported, because it would require a bunch of
> hugetlb-specific further actions (see zap_page_range_single_batched()).

Ugh gawd. Hugetlb.

>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Seems reasonable, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/internal.h |  5 +----
>  mm/memory.c   | 36 ++++++++++++++++++++++++++++++++----
>  mm/oom_kill.c | 15 +--------------
>  3 files changed, 34 insertions(+), 22 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 39ab37bb0e1d..df9190f7db0e 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -536,13 +536,10 @@ static inline void sync_with_folio_pmd_zap(struct mm_struct *mm, pmd_t *pmdp)
>  }
>
>  struct zap_details;
> -void unmap_page_range(struct mmu_gather *tlb,
> -			     struct vm_area_struct *vma,
> -			     unsigned long addr, unsigned long end,
> -			     struct zap_details *details);
>  void zap_page_range_single_batched(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, unsigned long addr,
>  		unsigned long size, struct zap_details *details);
> +int zap_vma_for_reaping(struct vm_area_struct *vma);
>  int folio_unmap_invalidate(struct address_space *mapping, struct folio *folio,
>  			   gfp_t gfp);
>
> diff --git a/mm/memory.c b/mm/memory.c
> index e4154f03feac..621f38ae1425 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2054,10 +2054,9 @@ static inline unsigned long zap_p4d_range(struct mmu_gather *tlb,
>  	return addr;
>  }
>
> -void unmap_page_range(struct mmu_gather *tlb,
> -			     struct vm_area_struct *vma,
> -			     unsigned long addr, unsigned long end,
> -			     struct zap_details *details)
> +static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
> +		unsigned long addr, unsigned long end,
> +		struct zap_details *details)
>  {
>  	pgd_t *pgd;
>  	unsigned long next;
> @@ -2115,6 +2114,35 @@ static void unmap_single_vma(struct mmu_gather *tlb,
>  	}
>  }
>
> +/**
> + * zap_vma_for_reaping - zap all page table entries in the vma without blocking
> + * @vma: The vma to zap.
> + *
> + * Zap all page table entries in the vma without blocking for use by the oom
> + * killer. Hugetlb vmas are not supported.
> + *
> + * Returns: 0 on success, -EBUSY if we would have to block.
> + */
> +int zap_vma_for_reaping(struct vm_area_struct *vma)
> +{
> +	struct mmu_notifier_range range;
> +	struct mmu_gather tlb;
> +
> +	VM_WARN_ON_ONCE(is_vm_hugetlb_page(vma));
> +
> +	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma->vm_mm,
> +				vma->vm_start, vma->vm_end);
> +	tlb_gather_mmu(&tlb, vma->vm_mm);
> +	if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
> +		tlb_finish_mmu(&tlb);
> +		return -EBUSY;
> +	}
> +	unmap_page_range(&tlb, vma, range.start, range.end, NULL);
> +	mmu_notifier_invalidate_range_end(&range);
> +	tlb_finish_mmu(&tlb);
> +	return 0;
> +}
> +
>  /**
>   * unmap_vmas - unmap a range of memory covered by a list of vma's
>   * @tlb: address of the caller's struct mmu_gather
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 0ba56fcd10d5..54b7a8fe5136 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -548,21 +548,8 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  		 * count elevated without a good reason.
>  		 */
>  		if (vma_is_anonymous(vma) || !(vma->vm_flags & VM_SHARED)) {
> -			struct mmu_notifier_range range;
> -			struct mmu_gather tlb;
> -
> -			mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0,
> -						mm, vma->vm_start,
> -						vma->vm_end);
> -			tlb_gather_mmu(&tlb, mm);
> -			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
> -				tlb_finish_mmu(&tlb);
> +			if (zap_vma_for_reaping(vma))
>  				ret = false;
> -				continue;
> -			}
> -			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
> -			mmu_notifier_invalidate_range_end(&range);
> -			tlb_finish_mmu(&tlb);
>  		}
>  	}
>
> --
> 2.43.0
>

