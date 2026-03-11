Return-Path: <linuxppc-dev+bounces-18067-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AC1112584E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 11 Mar 2026 16:01:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fWFqY4pWHz3bf8;
	Thu, 12 Mar 2026 03:01:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::649"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773244905;
	cv=none; b=WOZeiU8yKE0gYf39CzPEt9fERBiXioY98IBnNiPqnwJ4eq8Sacbt2kcwp+F9sznlFTsY15aeBLGhcKtOQ+cgpriZ0LRav+cmxmS2cbU/z/t/BUiPeL+aHQknzsf5SuCrBKD9VmzuH5oFkfnS+fuRV4R2LpIBfFzpL4TKgM7Z2wW7WEqvoiJVL0lF6j35SBOt+n3a80/cAkn0t2kbxiSsztG4KagJbyiatO7a0esH+3ptCL9pwyQNnb5mv/kfIK99P7swvAE9mqobnNLc/AqSx+us7cvUvcqxGkm5YrRw+uZUR24EFiBZwajw5g0WI6oIvC+3vZ6NAJS06syyikM/hg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773244905; c=relaxed/relaxed;
	bh=FZ9wJHN98p2eqW+aluFwwdS4VIjV0bOaQ4w+79zBhNs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EQqSueDq5M6a62EovPoPCTD8th7oAVI0U/YyUCYGhp9oYYwy4HryVUc4Zf9uup1RDIJBNrhwtXdK6xVmwPrfZJCWICt2qzxcAHM5rG35VNsaNFQz4BPqXK1u/HhFRzHEsdJ+TEM5LEYieaEa3yx8abZ2S6VquZPdOiWtJGrj3R0brF4PSgpaS6P7rYkTo6ptvmZgth/AFt4MeyGRhOt6HgGIL3BNvJH2J4wrARXHfHc/o7fvdSFRAqqHrfEf3nG88sXxVvXot5DwrMv/3Xua8W3PovNr1g+mOCHhMaR/j9LbAa8EK5Q0H34V5xJ8frD5/CjzrpkWo8KwsrffG4v9gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=3deXfe43; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::649; helo=mail-ej1-x649.google.com; envelope-from=34pgxaqkkdce7if9boveidlldib.9ljifkrumm9-absifpqp.lwi78p.lod@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=3deXfe43;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--aliceryhl.bounces.google.com (client-ip=2a00:1450:4864:20::649; helo=mail-ej1-x649.google.com; envelope-from=34pgxaqkkdce7if9boveidlldib.9ljifkrumm9-absifpqp.lwi78p.lod@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fWFqW4B5jz2yFm
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2026 03:01:42 +1100 (AEDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-b8ff07df5e4so1253814466b.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2026 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773244899; x=1773849699; darn=lists.ozlabs.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ9wJHN98p2eqW+aluFwwdS4VIjV0bOaQ4w+79zBhNs=;
        b=3deXfe43m8ZrOBZt1I55Gplo9zQySbykXRXwddAUypDVVcO8jLyBcURcRLZlv3dUUz
         +l0cBSews7ljlNGu5u4R2de2gEgePIaWlEH7mOMykDd3NfVxy0IcxF27cnqPS4OL1YO6
         pui6msGl6K0ShaF/S/OueMFppxprywXkz+nyZwlRgZroXC7JMFbT60HrLO/c8Jp5wJEt
         R7KZUqglruOEbP/B+8XRAfo1e76KxzCqoMwrxvgcQtUEcK1CqMdkPMcKOsiICe69oG0+
         CPkEM8lCkmFLa1BfF+8XJg19mwJxPWKmHfRNMS4No8thTwdjXh6yM2IyvzraXrUlkuLZ
         huDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773244899; x=1773849699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FZ9wJHN98p2eqW+aluFwwdS4VIjV0bOaQ4w+79zBhNs=;
        b=i5LGhQSQw84PUB0i8b/JbhPl19myYTNBiU4KE1SLwsu69GUuCNx+vI4VKvzDMcoERg
         Fs5QHd6F7hKzIBT4S0JNnOT7IYyFzdUqZpgRUXg8eTaQB6WeL86nunMDagHT4aOUnBrk
         kb38dhCz/xF8zlDM1Ie66c3/ZTMAahP9PJ8gRGovY5TPDnDhY4DqTms6nPjKBduYIXzj
         ArfeentYeq59dMJMhsdoBFlDqq0NOWD0nB5XngeOV+EG9Tcv0N9DvNNfDoAuKAFao6Jm
         w2xvXRtaeR/sm9vjNZ5Bkfe8ok24EYZIg8FdChVNzIX+Re3QkAi/niWeYcsD9Ls5P+47
         Nv9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUS4mpo+fRwp0j4XSmF8Td/9Nmxc4Z4RFAv0YJ3JAEGS67AczTqlAqHEk/taboMc1tPQcXcXpEExDrkuN4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZjzmd5SESKBw8a5KR7Syfs2WFUlfEm+E72bWNcpf463qinmbj
	458VVbg8IRVxR68Jjwxg/MX55vjKtQGZoLLG2mYhe0LAtcAutXu32xC9WBSQ69UT1aJIghOtYP/
	hPq7kWZy2/0CNcUWvbQ==
X-Received: from wrbgw30.prod.google.com ([2002:a05:6000:40de:b0:439:ac29:98cb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d22:b0:b93:3792:4b03 with SMTP id a640c23a62f3a-b972e4f775amr187595066b.32.1773244898034;
 Wed, 11 Mar 2026 09:01:38 -0700 (PDT)
Date: Wed, 11 Mar 2026 16:01:36 +0000
In-Reply-To: <20260311120418.GU1687929@ziepe.ca>
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
Mime-Version: 1.0
References: <20260227200848.114019-1-david@kernel.org> <20260227200848.114019-17-david@kernel.org>
 <20260309142954.GM1687929@ziepe.ca> <61df6369-333c-430a-bd18-c5b1acae68ea@kernel.org>
 <abE4JYo223OxWCBQ@google.com> <20260311120418.GU1687929@ziepe.ca>
Message-ID: <abGR4GWMXC2tJyr8@google.com>
Subject: Re: [PATCH v1 16/16] mm/memory: support VM_MIXEDMAP in zap_special_vma_range()
From: Alice Ryhl <aliceryhl@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org, 
	"linux-mm @ kvack . org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Leon Romanovsky <leon@kernel.org>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 11, 2026 at 09:04:18AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 11, 2026 at 09:38:45AM +0000, Alice Ryhl wrote:
> > It doesn't really make sense to have multiple binder VMAs. What happens
> > with Rust Binder is that process A is receiving transactions and has the
> > VMA mapped once.
> 
> IIRC the problem is the kernel doesn't guarentee singleton VMAs,
> userspace can always clone them with fork or something. Did binder
> solve this somehow?

The Binder VMA is DONTCOPY, so it will not be present after fork.

> Since you can't assume there is only one VMA the locking becomes a
> mess to cover all the cases where userspace can trigger a VMA clone.
> 
> address space deals with this internally.
> 
> Thus, zap_special_vma_range() is extremely hard to use.

I mean, the hard part about the locking is keeping them in sync. Binder
just doesn't do that. Only the original VMA gets pages inserted or
zapped. If you create a second VMA, you just get a useless read-only VMA
that you can't do anything with.

Alice

