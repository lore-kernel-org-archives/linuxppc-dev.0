Return-Path: <linuxppc-dev+bounces-17814-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D237BF0182F
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 12:25:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS5GF26Mfz3bnJ;
	Fri, 06 Mar 2026 23:25:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772799248;
	cv=none; b=V1UVYCWW7kvSxA8BBW+RJIdgNGoKm3MQDbabV7twz7iwBAP/SiyxfQyCBO8hIYdxJkXz3Ca1orhWDfXp9DMPtOatl9VqeCv0WWKOgWRHlDwXEudmGTwHNJd05wYxVXE7L/d54r7vj/H1vWy26z1mei2kTymRKYbn1ataDaEqBCvdkFU32f++q4nePlDw1HW8JhoYzJkrKeWIKn6OBvlFPfa46mBtwMEw7AP9hUyEUhpQuQ8CxuAybag7EUCL3az49Q+9MoNZGKWeL/Oy6eZDkEPyWgYgjUoMnPnos2RlZl1pplyvmqmIldhzczpNIDEkJestv4RDZh/hrT3N9yNt5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772799248; c=relaxed/relaxed;
	bh=73LzocOiKFmkpCrC2LXz/bgp2Wq8zbMaYA+a+8ryW6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6aMuHupiW0bz9KGhAVVYv7HHJaxMacmH49+a9OUiUo2sevfa79O0X3L3Z2S3OavfWm5tWpJbpS5d38GMqngqifk1IE21h0FwDQb4RUXxqqiods2M9iGhxH1xzTv4mQQHjNK28mSGkuS2T1MDFVyL26gVmfIfFOjIVn1NkDtogepKOBW96yeKqC+vm/vzuMXN4dlQrSR1hvNX9m+5UMMvHiGsAeqgubLNlDZqbE+PIVjdKI6jDh9YAk6zeizRcn1xDiQJUfiyYLFfNvAkJCVUoHYK3Zg8VsdG93i+fSFIex3Nvjpiqz0TqAx3XE/gUjiFFyNspZZIV+hmceOLzethA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dVqQGJSF; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dVqQGJSF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS51C6503z30T9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 23:14:07 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6715E6012A;
	Fri,  6 Mar 2026 12:14:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829DEC4CEF7;
	Fri,  6 Mar 2026 12:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772799245;
	bh=Aeql3Q18nbzOXyXxhu0vMzA3N0kdNt6Kxm9MrBYhJwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dVqQGJSFiWX+fDD/OWZvs6Gl8EvNWdkhGAwY0jgLtpsGAh+dBK4hjzKSY1SnoVxJU
	 Xn8o0QmPk7618RpV/ZP3BQon0ikZoZX/2Edj80XY9nHA/af8dILFPWfW54wd0CfK5J
	 NNDPt/dl+gpaSa6q1arnlJ6LaGOiSvQqHc8RpLx+kRVj9NJ49/AzP4n1GT/dB3EozG
	 MzrBFPGFBVBNv32TOIbQwG4bTmYYGJvCCLdYq7arv1NHHiBCMmGv2K2Sm+N0LRxzpC
	 aFvJFL0+ixqlChqXpUk4/1NsRYhl/5ShnknPXYh+3W2ihDb5KHKe+eLdNWM7yGCDkz
	 //0PKp6ZWU7fQ==
Date: Fri, 6 Mar 2026 12:14:02 +0000
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
Subject: Re: [PATCH v1 05/16] mm/oom_kill: use MMU_NOTIFY_CLEAR in
 __oom_reap_task_mm()
Message-ID: <8ad03e9e-b14a-4348-aea3-fefd5d2b163d@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-6-david@kernel.org>
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
In-Reply-To: <20260227200848.114019-6-david@kernel.org>

On Fri, Feb 27, 2026 at 09:08:36PM +0100, David Hildenbrand (Arm) wrote:
> In commit 7269f999934b ("mm/mmu_notifier: use correct mmu_notifier events
> for each invalidation") we converted all MMU_NOTIFY_UNMAP to
> MMU_NOTIFY_CLEAR, except the ones that actually perform munmap() or
> mremap() as documented.
>
> __oom_reap_task_mm() behaves much more like MADV_DONTNEED. So use
> MMU_NOTIFY_CLEAR as well.
>
> This is a preparation for further changes.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/oom_kill.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 5c6c95c169ee..0ba56fcd10d5 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -551,7 +551,7 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>  			struct mmu_notifier_range range;
>  			struct mmu_gather tlb;
>
> -			mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0,
> +			mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0,
>  						mm, vma->vm_start,
>  						vma->vm_end);
>  			tlb_gather_mmu(&tlb, mm);
> --
> 2.43.0
>

