Return-Path: <linuxppc-dev+bounces-24247-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCBDC4450B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 14 Jul 2026 15:16:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h02vZ1r4Tz2yMn;
	Wed, 15 Jul 2026 01:16:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784042186;
	cv=none; b=BcLbYRweqhHvNNtB0fZa8mq6sFGKiJ/oua4eg5PDcRL8RUUJOPEKwPdRVerYJJAJp5+9wYc8dRzO6ijWRYpnmhG920MHVSKK+FbWWoACmpJsMEOX9cQeOWzKZ9/EBSLDgv7aKv0oMAw6V/aviv5gWC8dJPlHB4ed8ptKciFvpiw1CiIKl+dIj6cZuJsdQFrEZ0KbAQTCX+f01QXtiL5yY6NiiBae4yimynp1uDIh+j7LQtYKGhz5VzU35KLGRhAuc0moSFp5UN2DnaujsOom8XxSKuEH+liCDYmVi+aKp5Wfs4El/SIMwByMslZUBRXyOeB7OfgCg9CulXTzL0lgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784042186; c=relaxed/relaxed;
	bh=fwuFYnIFntaeyFiFTCtuOmdD45sxN5bbxj7Gff2yTa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlFbYmHS/KiZmY8WD3YgfJR17jujAvrdes4u2fKy2cgafSEgYEL/MrpMIBKcMn1ITUYWIdRm1mUpGD3BLxKYCIL5RYw9Xtwn6QZEmWeA1lThdOKoFPAz5u+Qar8a+0oA01UDW52RJXIkyrKyNttFgmhQ+cpqo+Ijdu1w7NznfW0R1fULsK8am6RFUTICBRBhUKRItnRvvhCa8JbRmQ4LTMdBzposFP0YwJCMohtuXs8tlPSOGhFE+VsWffdT50TO2bfLcoumiXNntI/Rv7DodYPsriz9AebvqfPBdTYB/S8td3ktNHKJ8ODMKoiVuRZbOS2ZXQXqWJ6H+Odc6iMsgw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dhs4xIW4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=vishal.moola@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dhs4xIW4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=vishal.moola@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h02vX43kXz2xjN
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2026 01:16:23 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1170038a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2026 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784042182; x=1784646982; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fwuFYnIFntaeyFiFTCtuOmdD45sxN5bbxj7Gff2yTa4=;
        b=dhs4xIW4vDcRKfgXYlFLNmsQJPe+a9hGA4WyRKGie/5BkI0t8WbRQIdr0Dn6IKgrUV
         j+bexe4HSxUIUoHiZa/kPElDPngQ2h1zLVohV2CdB5v0oIjft3/Jkzf7sIy+7EqWSazT
         +tire7jL6MLbB2a5sPKlgluUIw4MFVGgPKEAIFnsFVPsYs75QMLCMD49ndSz5IRh42wY
         LgZNTD6gBYEDP0dxhVXx2hN3TPF6uG76mHhZZ7MNjRe+7mQ3CvA99W1/YSFCeSuGAdxQ
         9YS5e5ul/7oVc3zvvxGp0V5AoHg8jCPoc12tgpFqQXikODGBpn8j6ykIzUuNteo27Upb
         9rNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784042182; x=1784646982;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fwuFYnIFntaeyFiFTCtuOmdD45sxN5bbxj7Gff2yTa4=;
        b=cuiYjVAqnmvU/XhwdG8RKCMPqtXsaAiSyfqdWxPmyfD9mvatnV/CuVSZ58uRSEYLmD
         G2OwaWZo0fFFgEZ5sKHV58w8vBwQBgGMnNLh/zKIML+AVr0XGf97DFh4QYkUqnhcQBCT
         l7RyfRYcp1nE0HExPDHEdTOdeWMIeQh6IHobPOImOR69Zn0qpUtUBMN7530hUSSP+M6X
         Yb8VDtP4Y7cYAEM+9U2JQlA4y3yHGjYIqVRquy6UVpFzVizeWodQMx4+fSo9GIK4qg+A
         6Hl63qX05QbWj7wp3myXmr1V+XXSUgSNeNrflpulWWYNiVwgJvB1tdJLNYWnPjQm3agc
         4rsg==
X-Forwarded-Encrypted: i=1; AHgh+Ro4aoHi5MjGxuoFg5JF31kggbI36p16MR3OlevvGm1noJ6K4WeEWRHNkUNreP0o/9yKLNDrtf34FPGhlwo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YweP8KPpcclO40CmrIPQDL1ofVl2S8+/yAvpwtGzzKbDBVzclyd
	j5Y5FG3hG4T/Yqtr6WaBnH3F4iItpUGgaZa1qgkIu+hcb6GcAN4m5cD9
X-Gm-Gg: AfdE7cnEnY5qPRpFmQgXNmVgxig6e0CMVFlNACC1/KZWwF+5KQrW+ghFiVxZHL54+UR
	ax7RzKzrXzzJUyJvGPOsKwMqkS5d51vCvb1jFPVWID0++/SQqOm3KkFOrzJ16LiQ1rz6tcQ+c60
	XdVu+pg3XUBJhbg6p+3BVUkbvBAfHJ9EQnM5SHt7Drlrpjw6DF+0sleiQ9a+fyQtPICT3YKxIfC
	5DdfY0uf1lui12aBK7ML7AAKHSa1EO7AGt2dmQ5NdF3e2NraWCQeCUTwjaVos1N4qO2iolPnubQ
	kxTiqv0CCzeWLf4uWXEYWmzAukfI5b3FQzeVH4+krO/eaPu/irORJbj7Daysg36kR6VGdewou5S
	MYJIcb0YxdUL9OuXRSRu15yi0XTWUT31eBnFRohEiBTp5inGn2v5ZzDFZaKDwG8Q+jR2FxKVARK
	C8/MNZZYHTEcWxzi9VySNzXckWWlkOhvoJqOGshrLWaXSD
X-Received: by 2002:a17:90b:2e8f:b0:380:8b14:d8e1 with SMTP id 98e67ed59e1d1-38dc7b3f8ccmr13234040a91.24.1784042181685;
        Tue, 14 Jul 2026 08:16:21 -0700 (PDT)
Received: from fedora ([2601:644:937c:6c90:6d4e:7b2d:4a39:fb0c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b4b97661sm49794403eec.7.2026.07.14.08.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 08:16:20 -0700 (PDT)
Date: Tue, 14 Jul 2026 08:16:16 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ning Sun <ning.sun@intel.com>, x86@kernel.org,
	tboot-devel@lists.sourceforge.net, Ard Biesheuvel <ardb@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	linux-efi@vger.kernel.org, Alistair Popple <apopple@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 14/22] mm: set page table page type when allocated
Message-ID: <alZSwAM4pwmMOeaD@fedora>
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>
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
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>

On Tue, Jul 14, 2026 at 03:04:03PM +0100, Kevin Brodsky wrote:
> As a step towards removing pagetable ctor/dtor calls for kernel
> mm's, move the page type updates from the ctor/dtor to
> pagetable_{alloc,free}.

Thanks for doing this patchset.

We should switch over from __folio_set_pgtable() to __SetPagePgtable()
in this patch. Ptdescs and folios should be treated as distinctly
independent of each other.

Eventually, we want to replace the memcg accounting as well, but
there's no existing API for that right now. Lets leave that as is for
now; this patchset is big enough already ;)

> __pagetable_ctor() is now empty so remove it;
> pagetable_{pud,p4d,pgd}_ctor() will be removed at a later stage.
> 
> The ctor is normally called after pagetable_alloc() (and dtor before
> pagetable_free()) so this patch should have no functional effect in
> most cases. Where calls to ctor/dtor are currently missing (e.g.
> x86's split_large_page()), this patch will ensure the page type is
> set correctly.
> 
> This patch is based on Matthew's earlier implementation linked
> below, with the difference that when freeing the page type is
> cleared in __pagetable_free(), meaning that the update is delayed
> until the pages are actually freed in the
> CONFIG_ASYNC_KERNEL_PGTABLE_FREE case. This shouldn't matter in
> practice.
> 
> Suggested-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Link: https://lore.kernel.org/r/20251113140448.1814860-4-willy@infradead.org
> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
> ---
>  include/linux/mm.h | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 361a0d7b74c5..94f0fb1c662a 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3684,6 +3684,7 @@ static inline struct ptdesc *pagetable_alloc_noprof(gfp_t gfp, unsigned int orde
>  	if (!page)
>  		return NULL;
>  
> +	__folio_set_pgtable(page_folio(page));
>  	lruvec_stat_add_folio(page_folio(page), NR_PAGETABLE);
>  
>  	return page_ptdesc(page);
> @@ -3694,6 +3695,7 @@ static inline void __pagetable_free(struct ptdesc *pt)
>  {
>  	struct page *page = ptdesc_page(pt);
>  
> +	__folio_clear_pgtable(page_folio(page));
>  	lruvec_stat_sub_folio(page_folio(page), NR_PAGETABLE);
>  
>  	__free_pages(page, compound_order(page));
> @@ -3799,19 +3801,9 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct ptdesc *ptdesc) {}
>  #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
>  
> -static inline void __pagetable_ctor(struct ptdesc *ptdesc)
> -{
> -	struct folio *folio = ptdesc_folio(ptdesc);
> -
> -	__folio_set_pgtable(folio);
> -}
> -
>  static inline void pagetable_dtor(struct ptdesc *ptdesc)
>  {
> -	struct folio *folio = ptdesc_folio(ptdesc);
> -
>  	ptlock_free(ptdesc);
> -	__folio_clear_pgtable(folio);
>  }
>  
>  static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
> @@ -3825,7 +3817,6 @@ static inline bool pagetable_pte_ctor(struct mm_struct *mm,
>  {
>  	if (!mm_is_kernel(mm) && !ptlock_init(ptdesc))
>  		return false;
> -	__pagetable_ctor(ptdesc);
>  	return true;
>  }
>  
> @@ -3917,7 +3908,6 @@ static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
>  	if (!mm_is_kernel(mm) && !pmd_ptlock_init(ptdesc))
>  		return false;
>  	ptdesc_pmd_pts_init(ptdesc);
> -	__pagetable_ctor(ptdesc);
>  	return true;
>  }
>  
> @@ -3942,17 +3932,14 @@ static inline spinlock_t *pud_lock(struct mm_struct *mm, pud_t *pud)
>  
>  static inline void pagetable_pud_ctor(struct ptdesc *ptdesc)
>  {
> -	__pagetable_ctor(ptdesc);
>  }
>  
>  static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
>  {
> -	__pagetable_ctor(ptdesc);
>  }
>  
>  static inline void pagetable_pgd_ctor(struct ptdesc *ptdesc)
>  {
> -	__pagetable_ctor(ptdesc);
>  }
>  
>  extern void __init pagecache_init(void);
> 
> -- 
> 2.51.2
> 

