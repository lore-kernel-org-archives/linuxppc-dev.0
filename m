Return-Path: <linuxppc-dev+bounces-17847-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2729FCC07C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 21:17:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSK4h2fs2z2xm5;
	Sat, 07 Mar 2026 08:17:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772800216;
	cv=none; b=cevq+NX8HjqflowA7BQJRMZIyP5i/Gcx5pbNGKZHfWwioqMy4AoS/pk1JLd+xe4bm+QXDwoLWKt/SE8D6EIjxBwOE2wW1ug8AdWPMK01+s6j/3Fjyzah81KP/C4qpqNKwugxAbiz3fgoM/5/yQlRr0iBEIa4nubO5wa0FcRAD6hrhmCswSvUAhc92Vl5uwI3n6wXG2hRpcwAX+wQEP/+dIAeOI3KmpxQXILlYwTDCeIJKgb0ILbQTbK/sBxIGmodBfN2Kn+fe6muX9e0CZ6raH0KvKLPoQMiwHOCvJN9qadiON697dPomMwvcHfo4BlHNpngJ7Zyb4YDMoXd2ES/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772800216; c=relaxed/relaxed;
	bh=x3u3PLujGP7HIMgiks7XBwFOh1HdWRmuG3DKugPgRFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TcsSsFDKKcRFfSPyM9EHyCFcRIJWWess5AvvAQOLpq5tHtnAS1x+hXsw5Q0fsdeEVlmOFIKrYztKTYaPh4K1+bfxV+EPSFpul4WGL6M/pxBc/lRpRttLDAUpFjHmz0L9bjlBlh82XHyo3LJCFg79OQ9MUxY5tk3UYtYOjE0/nH3W/pXd94BxS3pWX1wvFQ0p/N/lG9Q450zKanEFEi8s8TLKfWZReiqP99Yf4Zjek4lM3KsJeaOEOIM1/6eB7tAfxiV5g5JOvtPzXJsp9jGTqqO4ROL1lhM5o/H5+uMggv+gg1hH7JxWOAGjV5kc+jtgtpHM/SQDCa0XMyoUwQ+H5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RrOKh0OA; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RrOKh0OA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS5Mq4G6Xz3bnJ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 23:30:15 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6AF21440A6;
	Fri,  6 Mar 2026 12:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B33C3C4CEF7;
	Fri,  6 Mar 2026 12:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772800213;
	bh=Kftdd8omZX7VELmkL5LGQUFF+sQIeOHfzVU13moKjvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RrOKh0OAhxHMytB1jOn/jttu3GJlb3C3rXPB9TooAMKbyt3vUr89Pt0+i4u40IkqV
	 RX2hBvNB6H5hwNgpkw2833/q+m2pIU+tXLy6aT2UqxNKjA9gRXZUoAjf58JN5/E+WU
	 b+1XKEzPnARh8OeG9Vznq4eIhrMwfxCOh6yt4sHKclOXteR/4dXp5YR9O3YGnPPT2n
	 aDJp5EcMC6pPhjaUS4A5KpHj2GJduynNISMtMzESwpD0c6OWnPmGQWuaLB8H96xPbV
	 V8tWz99yS9NFw2rriHryb/Y2+I+FJmH4No3lieIJOsE5G/KrymQlZobYCswq94RN1W
	 nF2PinBdqWDrw==
Date: Fri, 6 Mar 2026 12:30:10 +0000
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
Subject: Re: [PATCH v1 12/16] mm: rename zap_vma_pages() to zap_vma()
Message-ID: <2f4ee3ee-549c-4c0f-980d-3853193776b6@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-13-david@kernel.org>
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
In-Reply-To: <20260227200848.114019-13-david@kernel.org>

On Fri, Feb 27, 2026 at 09:08:43PM +0100, David Hildenbrand (Arm) wrote:
> Let's rename it to an even simpler name. While at it, add some
> simplistic kernel doc.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  arch/powerpc/platforms/book3s/vas-api.c | 2 +-
>  arch/powerpc/platforms/pseries/vas.c    | 2 +-
>  include/linux/mm.h                      | 6 +++++-
>  lib/vdso/datastore.c                    | 2 +-
>  mm/page-writeback.c                     | 2 +-
>  5 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/platforms/book3s/vas-api.c b/arch/powerpc/platforms/book3s/vas-api.c
> index ea4ffa63f043..e96d79db69fe 100644
> --- a/arch/powerpc/platforms/book3s/vas-api.c
> +++ b/arch/powerpc/platforms/book3s/vas-api.c
> @@ -414,7 +414,7 @@ static vm_fault_t vas_mmap_fault(struct vm_fault *vmf)
>  	/*
>  	 * When the LPAR lost credits due to core removal or during
>  	 * migration, invalidate the existing mapping for the current
> -	 * paste addresses and set windows in-active (zap_vma_pages in
> +	 * paste addresses and set windows in-active (zap_vma() in
>  	 * reconfig_close_windows()).
>  	 * New mapping will be done later after migration or new credits
>  	 * available. So continue to receive faults if the user space
> diff --git a/arch/powerpc/platforms/pseries/vas.c b/arch/powerpc/platforms/pseries/vas.c
> index ceb0a8788c0a..fa05f04364fe 100644
> --- a/arch/powerpc/platforms/pseries/vas.c
> +++ b/arch/powerpc/platforms/pseries/vas.c
> @@ -807,7 +807,7 @@ static int reconfig_close_windows(struct vas_caps *vcap, int excess_creds,
>  		 * is done before the original mmap() and after the ioctl.
>  		 */
>  		if (vma)
> -			zap_vma_pages(vma);
> +			zap_vma(vma);
>
>  		mutex_unlock(&task_ref->mmap_mutex);
>  		mmap_write_unlock(task_ref->mm);
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4710f7c7495a..4bd1500b9630 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2837,7 +2837,11 @@ void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
>  		  unsigned long size);
>  void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
>  			   unsigned long size);
> -static inline void zap_vma_pages(struct vm_area_struct *vma)
> +/**
> + * zap_vma - zap all page table entries in a vma
> + * @vma: The vma to zap.
> + */
> +static inline void zap_vma(struct vm_area_struct *vma)
>  {
>  	zap_page_range_single(vma, vma->vm_start, vma->vm_end - vma->vm_start);
>  }
> diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
> index a565c30c71a0..222c143aebf7 100644
> --- a/lib/vdso/datastore.c
> +++ b/lib/vdso/datastore.c
> @@ -121,7 +121,7 @@ int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
>  	mmap_read_lock(mm);
>  	for_each_vma(vmi, vma) {
>  		if (vma_is_special_mapping(vma, &vdso_vvar_mapping))
> -			zap_vma_pages(vma);
> +			zap_vma(vma);
>  	}
>  	mmap_read_unlock(mm);
>
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 601a5e048d12..29f7567e5a71 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -2645,7 +2645,7 @@ void folio_account_cleaned(struct folio *folio, struct bdi_writeback *wb)
>   * while this function is in progress, although it may have been truncated
>   * before this function is called.  Most callers have the folio locked.
>   * A few have the folio blocked from truncation through other means (e.g.
> - * zap_vma_pages() has it mapped and is holding the page table lock).
> + * zap_vma() has it mapped and is holding the page table lock).
>   * When called from mark_buffer_dirty(), the filesystem should hold a
>   * reference to the buffer_head that is being marked dirty, which causes
>   * try_to_free_buffers() to fail.
> --
> 2.43.0
>

