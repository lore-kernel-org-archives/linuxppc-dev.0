Return-Path: <linuxppc-dev+bounces-17852-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DF1FCC07C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 21:18:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fSK5l3j9gz3bf8;
	Sat, 07 Mar 2026 08:18:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772801007;
	cv=none; b=kMhgk/uMjeR+GYqF7UO5jP0T58JsiPZRJw0sTpVBJyyxKrSprM3gMQXewChvlN9bJONsdUci0U/6Th5mtCO8on6LltXDlQOVTzArhiQzP3oBgJfjkq4K1MtuK5dDUjouAOff48R/r7NXNt1oXpIA2TyZLG3Vjl8+8OjUeK2CBg/qnYTEKkUYuGg0q6BSQWKY/qk1n5vpSNjk9zF601ggR3hSKl/T9LlpPBN0G8SHEGL/82OT2REPA9NmayT0VhqhH9dTTigZ9irfzbsN12kwKVQjhvhAY9TqVwbbIE9m122zSNToIVZ9V5QFHFwpwR1yzXc1y+CifFerVtYswkDTaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772801007; c=relaxed/relaxed;
	bh=QWdPDMTwGM6a5JRcgYVSuAzDD6OQV73Y1dH59k1txJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMpfNgjL3/1z9hGx0xO2ccXPsPYhzHdnU+vmLpmVa2pc3mOERu7gfcbMtxXqsHQSVJM/YEWgCUIs1I0L3CakdAZjTmuen+UI23W8uSy7GZ65QEyUljCArAjhALpuEI9a7kIYrwBBVV5yndoYl70oeYLzssaWjHuNH/PFKcd/X30u7SA2RO/cAHutarizRlJP13v63nZvF3P37QAEFiSSYXcfqsLEllt03kygvoG2YGYQywPus2DFpk+CN5VhKQAGbS18Bwd4WKJ68g10kDWrZ+5oMb/GbpdaRfHvwAnIdX1rD65cmUopttvE48yBr+L7LZIP9ePhMZ2f0vKeu2HeuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p9mC0Dtb; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p9mC0Dtb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS5g25tx6z30T9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 23:43:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C43F340571;
	Fri,  6 Mar 2026 12:43:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149B7C4CEF7;
	Fri,  6 Mar 2026 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772801004;
	bh=laI5Gks8UKTtQyxqn7mx9nW4b8iCTs15iKu2otVUFHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9mC0Dtb5HP8pcPpgD7riizGZNEqblFXhyCBB7gyX3iYqVlML2IEu/E46TQAfJ6kB
	 5ES8F1tVf64ZhuAJ2vES+zOK4kRMzYtKhCjqesskIYnO8sAKVgRvaUWEnRMwLwSDQe
	 6ozGy1rqY43AQN4mamdsvpi0UFTEWG/1ua9kPc8CcoyCTro7l1nx6xbY3HJtSjDB33
	 HoXIf0/JjwlmXYcHIiJHIJDR1zTA/RgIid+TR7+6DmUz/5MSsmXaWj5qjtxVswmSpB
	 y7qIWK2NRTkB+QK0r3eC/5U81n1lw5TgFlHl0zqxfvXpiP2u3XAAAbXR9+cd9x48Kv
	 4L7tL1NMHpRqQ==
Date: Fri, 6 Mar 2026 12:43:21 +0000
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
Subject: Re: [PATCH v1 16/16] mm/memory: support VM_MIXEDMAP in
 zap_special_vma_range()
Message-ID: <f2a7bdf4-8db7-4101-b7c6-3f5d9c20e078@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-17-david@kernel.org>
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
In-Reply-To: <20260227200848.114019-17-david@kernel.org>

On Fri, Feb 27, 2026 at 09:08:47PM +0100, David Hildenbrand (Arm) wrote:
> There is demand for also zapping page table entries by drivers in
> VM_MIXEDMAP VMAs[1].
>
> Nothing really speaks against supporting VM_MIXEDMAP for driver use. We
> just don't want arbitrary drivers to zap in ordinary (non-special) VMAs.
>
> [1] https://lore.kernel.org/r/aYSKyr7StGpGKNqW@google.com

Dude, you have to start your indices with 0 what kind of programmer are
you? ;)

>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Agreed that there's no reason not to allow this, so LGTM and:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Thanks for this series overall, very nice cleanup and I was frustra^Whappy
to see that there was nothing major or really of note to comment on here, a
rare occurrence in review :)

> ---
>  mm/memory.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index f3b7b7e16138..3fe30dc2f179 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2239,13 +2239,13 @@ void zap_vma_range(struct vm_area_struct *vma, unsigned long address,
>   * @size: number of bytes to zap
>   *
>   * This function does nothing when the provided address range is not fully
> - * contained in @vma, or when the @vma is not VM_PFNMAP.
> + * contained in @vma, or when the @vma is not VM_PFNMAP or VM_MIXEDMAP.
>   */
>  void zap_special_vma_range(struct vm_area_struct *vma, unsigned long address,
>  		unsigned long size)
>  {
>  	if (!range_in_vma(vma, address, address + size) ||
> -	    		!(vma->vm_flags & VM_PFNMAP))
> +	   !(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)))
>  		return;
>
>  	zap_vma_range(vma, address, size);
> --
> 2.43.0
>

Cheers, Lorenzo

