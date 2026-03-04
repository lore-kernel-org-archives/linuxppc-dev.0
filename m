Return-Path: <linuxppc-dev+bounces-17728-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FA6EF8FF7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 15:27:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQxNg3HB0z3c1T;
	Thu, 05 Mar 2026 02:26:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772638019;
	cv=none; b=mLz7Y0ZEc2eLw7lCargVYpNH/dshiEgQxAnEtEFLiWz1ruy/+vZiB4F3WwRKJGPRaD+ZUIneO4Nn/v/vuW59yS63K0/qQmlhFV9QLu5ZdYhr4IiDGxiUHkXEqhkpZ2VEco6BVLPzAmV2NPXUg3LekwKLl5rmfL31Q0T8vccaxjySX5pW+GjTaTf1FQZO/3JYYxFK8UkPKzAISnh89cOGD7pQQZZ5lYOIhYGg8RQ8EiAq0A5HcgE2viVkwqi6eNaYAQAxlJZIWX+dpkDDY3wkUlBo5NpIWk4GJ+PUtTBZda8udsheh92Ll2XdRHUswgWEqWCgkaJLoDmP3EEbij4ZnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772638019; c=relaxed/relaxed;
	bh=Ki4y4qN2AdkPyZ54v2+iGGCcyOmkpCXMP9Qdm6JNI98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaSPydPf/xODParFGLMp3Bpvg51gUwuP70FZu9qmC9LeoMPtup53sfR9BlWy/rVCHsszQbZpLGd4LgdoZA6r9yeQg3/XHHm0l9kZ23eBWar0Z2KyWbcAldwRzkfTd4Ljvr1vVCwgrYw8zMxZe5dSDtHCe4TRQTa3c1ll1idQMitrypJhHEbu7e94tObHeh5F/oHltjrjpuJiPKM2Uszx+9E9LejkhOuKnKtJ8aruB97kPj+/X8oDW88P0p2MPQXA2LNaU8p+ZLDaMpZWyvEXWH4k5XNWSWFCqdElg0AfV02azq/vs8R+s9mS3Wh94Vtzm9Adyeg/bhriJC9r5+bfSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JNr/i9Ed; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=JNr/i9Ed;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=leon@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQxNf3lq0z3c1J
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 02:26:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E664E4326E;
	Wed,  4 Mar 2026 15:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FA02C4CEF7;
	Wed,  4 Mar 2026 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772638015;
	bh=NSxpkcBTxGbZfTOBI1Osn6FZchKIMqEBt4E59vgg9yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNr/i9Ed94o5FrVUAIdDA9j6qVGLnE5GzfbP/S1eQuij66w5wYafVkKmJfNrjW6BU
	 A1qHbzpoX84W2Y3/DU8fCgtDh/bFbsR95IXw4bDa1YKfx2KDTn+9gvVk47D5GtsPhr
	 S6XIEflAmCZI+kFJOhLUSAKMC159kKQKecuwzKR8DT3B4C+eY5YaSizaIDmG+RQ/bO
	 OTFLtGzokmtE74YQuVHwoAjC3QCWckhfGWfFxU5RuztAn9pH5xH57mKx5+7NOyf21j
	 vJcutnbWGpl00AJ4jYiuegaQaPdEVO7qzspdvmLlAaHDXjEVctpre1LGEdez5nx/iK
	 AUByHkfctYKUQ==
Date: Wed, 4 Mar 2026 17:26:52 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"linux-mm @ kvack . org" <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	David Rientjes <rientjes@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v1 15/16] mm: rename zap_vma_ptes() to
 zap_special_vma_range()
Message-ID: <20260304152652.GF12611@unreal>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-16-david@kernel.org>
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
In-Reply-To: <20260227200848.114019-16-david@kernel.org>

On Fri, Feb 27, 2026 at 09:08:46PM +0100, David Hildenbrand (Arm) wrote:
> zap_vma_ptes() is the only zapping function we export to modules.
> 
> It's essentially a wrapper around zap_vma_range(), however, with some
> safety checks:
> * That the passed range fits fully into the VMA
> * That it's only used for VM_PFNMAP
> 
> We might want to support VM_MIXEDMAP soon as well, so use the
> more-generic term "special vma", although "special" is a bit overloaded.
> Maybe we'll later just support any VM_SPECIAL flag.
> 
> While at it, improve the kerneldoc.
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c        |  2 +-
>  drivers/comedi/comedi_fops.c          |  2 +-
>  drivers/gpu/drm/i915/i915_mm.c        |  4 ++--
>  drivers/infiniband/core/uverbs_main.c |  6 +++---
>  drivers/misc/sgi-gru/grumain.c        |  2 +-
>  include/linux/mm.h                    |  2 +-
>  mm/memory.c                           | 16 +++++++---------
>  7 files changed, 16 insertions(+), 18 deletions(-)

Thanks,
Acked-by: Leon Romanovsky <leon@kernel.org> # drivers/infiniband

