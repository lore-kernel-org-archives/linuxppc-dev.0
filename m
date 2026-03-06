Return-Path: <linuxppc-dev+bounces-17816-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427F6F01832
	for <linuxppc-dev@archiver.kernel.org>; Fri,  6 Mar 2026 12:25:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fS5Gq5Sfbz3c9x;
	Fri, 06 Mar 2026 23:25:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772799480;
	cv=none; b=a4UuVxaB0oRS38I8oAh8Hw8gZYMUrntxPgJhdmQoAN3CcYwEyU2qeHZvJx3S8I47zDtRPBMkyTNXPkNWwYuCgudqtI1hWFObMfa1oGLwkPmTem1owXEcccQeX+SmVGNb9ODidKaYrP3/gqmoSRhv5SvE0lRnWQuMck9Gx0rfD9dYDLwWxjd3t3ntmzQNgp4kLgSkUqcZabg5u3QRhE74Pd1wYxxXb9s1Bhr/yiJYlER+WpynWWwuhHPpIsG1yla1zhYIEcXsHzld4XKc9CtSuObJWW6HUh5q2SgL+ENWenCRGXqa9/48INIFpm6KkUEswhNUmLuBoWYL6GIdrTe7pA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772799480; c=relaxed/relaxed;
	bh=rsecX7IfEkl6mg+kpO6NHs6lMEsEKwri/xBkvNiB/E4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3yPSJixM1baiHR4EQGgwXwh0Ee34yR3JAdwR3Rd9zBNOhmDiK3tHnABszn3WATKAQGHJYwy2RijjH8I+8Qjqehq+svrNb/jdC/80q7IfJyXTcfd6enG9muIz8KdIPWDMVd1XgzebqvMXqKH08qNcGGGTs5SveVrFKHelSrMBZQHCKKusMtTvw0ugtLeI6uH7P6Bbj+jwi/ZeXsYK0DWIUCnrzIvG8xDE9Jsr14eeGn7EnuyuM/FaTqvEO6GcbkxmXxr4ApsaNoxfzXYq6m9Q+KsW2SQiitw89yOL41fXOsCpuxvfcPs85lP4tGlBTDzcr1Tft4xXCisPaSZYMS3ow==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rCp0TEPy; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rCp0TEPy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fS55g6nMhz30T9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Mar 2026 23:17:59 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3D6E3404AF;
	Fri,  6 Mar 2026 12:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811D4C4CEF7;
	Fri,  6 Mar 2026 12:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772799478;
	bh=yyADghSRuv3g36SG1gTJ+zwspTahcSZlQ722wYwHmFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rCp0TEPyTOAJupRC28UvQbYXcao/G55MgmxFJIUwmwhQpuaPUpOT9IaUxiz4l5nEc
	 otvkysRzxPs3DwlOKdKiqY//hgQr7LqJ9BEez9xlbH2rOvQ6KR8wW1Te2DyXt5Y7C0
	 AdZO6ELl5OOGQXFL+vy+jJZnK0vGap6Hkyknjo+SAeXBT8O22MNov+m6lrTpzBgLZQ
	 EhmCORIlTz+NSzc9TcBguQTQ6X0MFO8+HpR8ALVK04Q+cBoY+dyiAu0NzOviSlR6nv
	 hBCmb0cqI2vr+citiZrZ/w8gPppkTAUyT1n6sGgxa1kceA0/E1psbkUc1vZ34fDFyh
	 JYwVuJUUBth/A==
Date: Fri, 6 Mar 2026 12:17:55 +0000
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
Subject: Re: [PATCH v1 07/16] mm/memory: rename unmap_single_vma() to
 __zap_vma_range()
Message-ID: <f03471b0-ec73-40d1-88bf-a977c0e8d201@lucifer.local>
References: <20260227200848.114019-1-david@kernel.org>
 <20260227200848.114019-8-david@kernel.org>
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
In-Reply-To: <20260227200848.114019-8-david@kernel.org>

On Fri, Feb 27, 2026 at 09:08:38PM +0100, David Hildenbrand (Arm) wrote:
> Let's rename it to better fit our new naming scheme.
>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Yesssss thank you! I hate[d] the rando 'sometimes zap sometimes unmap' naming
convention here.

LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  mm/memory.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 621f38ae1425..f0aaec57a66b 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2074,7 +2074,7 @@ static void unmap_page_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  }
>
>
> -static void unmap_single_vma(struct mmu_gather *tlb,
> +static void __zap_vma_range(struct mmu_gather *tlb,
>  		struct vm_area_struct *vma, unsigned long start_addr,
>  		unsigned long end_addr, struct zap_details *details)
>  {
> @@ -2177,7 +2177,7 @@ void unmap_vmas(struct mmu_gather *tlb, struct unmap_desc *unmap)
>  		unsigned long start = unmap->vma_start;
>  		unsigned long end = unmap->vma_end;
>  		hugetlb_zap_begin(vma, &start, &end);
> -		unmap_single_vma(tlb, vma, start, end, &details);
> +		__zap_vma_range(tlb, vma, start, end, &details);
>  		hugetlb_zap_end(vma, &details);
>  		vma = mas_find(unmap->mas, unmap->tree_end - 1);
>  	} while (vma);
> @@ -2213,7 +2213,7 @@ void zap_page_range_single_batched(struct mmu_gather *tlb,
>  	 * unmap 'address-end' not 'range.start-range.end' as range
>  	 * could have been expanded for hugetlb pmd sharing.
>  	 */
> -	unmap_single_vma(tlb, vma, address, end, details);
> +	__zap_vma_range(tlb, vma, address, end, details);
>  	mmu_notifier_invalidate_range_end(&range);
>  	if (is_vm_hugetlb_page(vma)) {
>  		/*
> --
> 2.43.0
>

