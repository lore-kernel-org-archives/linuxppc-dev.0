Return-Path: <linuxppc-dev+bounces-25356-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89F2C55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 11:11:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDrTK6xRnz2y1Y;
	Tue, 04 Aug 2026 21:11:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785841893;
	cv=none; b=BRWTCpcFIcEryjXp9ey5LsjK3E5PI71URADuzUx0yDHJOqswdD+j84qd3yBDkpOiUBDomLrHoL4ijQSKmMhQbW61AKNKxNt9fByRyXFyhTHXyB7g+C1Rm6Mu72xFSFkseHXLw/AZg+Q2V4pXmTvpJ9XwGCJrTTou+JsIn0OuWrs4fRZXsCtt3MaVVfTtx4TSyP2eskgg11ks5ve0vkkwf59VSbX13Rxq3P/AlUFnc1FRuDGRKX5skrfixExqqk7mmS7yKbyS8qC39glK0vNHARigCwRxgzIB8K5QkQFvcc3sNAarfn1HBxXOxnQQfp5n/KdoRw2Xvud/NaqEe+5MUA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785841893; c=relaxed/relaxed;
	bh=lPlMqpw1IDLRtYVeniRNxYTVPDHrNiexqffQCORp34g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqjUcJpc0ovNsqPZWo6PyOcYCb/fTcTHoh9hAbP09XvAPwMtX1wAWs3lI0FOIZJgKwXnxmGcbcwxxp0mA2wXjm9kWR4n2t1mKZAGxuJqdmHKU6uDf2jxMNCoisfdty7FTGUU+8h3g39ph4nBILS9VReLUeoQCxdRhd/G2yXktOYl+6ReTnIA9X3n0CtV3pDABWMUmERQ3icndZdh9TLP6EysdMsTvOe5AKYFBvrU4khIFWrXsMtgimjUfusH3RQM56SkhNvu7WBLpeZYfdkhdz3qWxMolj/1Y1BnjrY71PTNYwsd3uub2TDwqqdnOKhKX56TlNZ3FrnTtFzkcBjqaw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nR2VBNRV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nR2VBNRV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDrTJ5vcCz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 21:11:32 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1586060A71;
	Tue,  4 Aug 2026 11:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189511F00A3D;
	Tue,  4 Aug 2026 11:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785841889;
	bh=lPlMqpw1IDLRtYVeniRNxYTVPDHrNiexqffQCORp34g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nR2VBNRV0pk1/OgzMczs6p6psKwdhUOyZldMBZXdygQAo/uvz9Wm+fZryWyxvHs1N
	 tugMO3FuAf8iTrlmndYjOm/Bb/N2rPZdKEmFl846PR+iMA0btzcbh2c3EJcd8mHuuN
	 fdGFsBi04TbQFLPu9RVEjd22d+D6Cay6M2i7vOJMy6U9VB1zlCfalZJjnNA8BRXlsZ
	 cbAldKjKURmWlZZvTpkRiXIqqL4UOmUjNeH/t+yvRz0qMxgWP69xU+r6rms3nYh3Ei
	 EHdYt4bqTsBxaFdvBxzCK1DLNkVJdNj41y96psFb8DllhxnbvJ6lbCR59BEPua/jAx
	 QNUZ57jLN53YQ==
Date: Tue, 4 Aug 2026 12:11:08 +0100
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
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	John David Anglin <dave.anglin@bell.net>
Subject: Re: [PATCH v2 2/6] parisc: Drop own implementations for ptep_get()
 and ptep_test_and_clear_young()
Message-ID: <anHHyiHqYf3yLf2K@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-3-pfalcato@suse.de>
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
In-Reply-To: <20260803164400.531199-3-pfalcato@suse.de>

On Mon, Aug 03, 2026 at 05:43:56PM +0100, Pedro Falcato wrote:
> From: Helge Deller <deller@gmx.de>
>
> Switch to the generic implementations, which are identical.

You sure do like succinct commit messages :)

Maybe worth saying by dropping the __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG and
ptep_get defines you get the generic versions from include/pgtable.h which are
functionally identical.

(Being pedantic, they're not quite strictly identical as the
ptep_test_and_clear_young() generic function does some weird unnecessary
indirection with a local variable and the single {} is dropped etc.)

>
> Suggested-by: Usama Arif <usama.arif@linux.dev>
> Suggested-by: John David Anglin <dave.anglin@bell.net>
> Signed-off-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Nits above notwithstanding, LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/parisc/include/asm/pgtable.h | 20 --------------------
>  1 file changed, 20 deletions(-)
>
> diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
> index 467b8547ac8b..d92dee9fef3f 100644
> --- a/arch/parisc/include/asm/pgtable.h
> +++ b/arch/parisc/include/asm/pgtable.h
> @@ -432,25 +432,6 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>  	return pte;
>  }
>
> -static inline pte_t ptep_get(pte_t *ptep)
> -{
> -	return READ_ONCE(*ptep);
> -}
> -#define ptep_get ptep_get
> -
> -static inline bool ptep_test_and_clear_young(struct vm_area_struct *vma,
> -		unsigned long addr, pte_t *ptep)
> -{
> -	pte_t pte;
> -
> -	pte = ptep_get(ptep);
> -	if (!pte_young(pte)) {
> -		return false;
> -	}
> -	set_pte_at(vma->vm_mm, addr, ptep, pte_mkold(pte));
> -	return true;
> -}
> -
>  bool ptep_clear_flush_young(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
>  pte_t ptep_clear_flush(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep);
>
> @@ -491,7 +472,6 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addr,
>  #define HAVE_ARCH_UNMAPPED_AREA
>  #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
>
> -#define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>  #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
>  #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
> --
> 2.55.0
>

--
Cheers, Lorenzo

