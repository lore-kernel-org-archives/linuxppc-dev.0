Return-Path: <linuxppc-dev+bounces-25362-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E311BC55184
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 11:22:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDrkF3BzCz2yPR;
	Tue, 04 Aug 2026 21:22:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785842565;
	cv=none; b=ezuy8/hWXIpA98EYo4/AwzTGkuIxnJX2XkVVb5koKrLchvI3lDc1CtydQjXUVV7CY7pW5gclGCwD0TkFV/4PSlwCBCpuI4SK5QzeEe3E8EEhIheFgKIpgYf/ezp1VxUa8PcswHAZOanaGshCHgKEAFoWLjFlTHJ1043RuqEkjeaLHDLnxqoUbzt6bbj6FRCc8OLNO8CHpz9Ti7TD+oHTUjNK9RCW3lBnmAXb/NX2QTLaa53NB2YYx27aZjax33kStu7qEN486TmzXp/evDmZbMmWNEZdZz07AdASQ54JCYXc8LF05H3uvkm6SwJEuoYoPf8eQMkz+GpbsLmm4PFolA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785842565; c=relaxed/relaxed;
	bh=O04AjETwdkKDFMoFDRH7HNAUs5os4iVo89vC02nF1dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3+s46C0rcObTBT2MMMEhzErOMpl48meT2F6cpOHAjqD0hQsyTbXo6CpKs8OfmAz9yrclrbmc+pyNV2/jTC01SSIV/KOkgnRXyrHUYP6Fv+gW/J28OdXou1NSuB7u7yzmR+7F2d6lTNTlzd8kwFJ0n0Lm9ztjmjS15LUByjmTX45vMLbTnet/+7nPBeIejwWDCNGzsWORMjnU93lR+DoFCZHuvFl/hxdkOKp49fII44QpHiJne51b/u9lewzMqpOOplgSczvE7SD2Xbh5+RuCiwohWIDsLOZfwHFOMSHJR6Zgwc5/+XW95sTzmR2Xl8e1a7RTbubOp6gmgNjz7Mn7g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mETS7jtQ; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mETS7jtQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDrkC2CJyz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Aug 2026 21:22:43 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CE257433CB;
	Tue,  4 Aug 2026 11:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355F71F000E9;
	Tue,  4 Aug 2026 11:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785842560;
	bh=O04AjETwdkKDFMoFDRH7HNAUs5os4iVo89vC02nF1dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mETS7jtQ9xPeY0vCfNmg+ddX8fuc7SUbBvCjaH6OSIVCtgc43e2hUnlX4GQ8hVnLp
	 6wlmwsuR15aWXkBkD3bqUj/JLgmtSQUiuVYLRHObbnTQtwRFxGwcIPHO6upxsRhNCF
	 jUEuDv791XD4yslZfyX2uYtLSp1XjxI5cxjjPoKEzOuV65mhd8zYxK82NG56Fm7N89
	 pbF71py3im6THBC+vOhEIjMCGSS1Bdv9a3qnU8xi2XXGG37cqRPZrOVpW7d9Jaxiaw
	 fCO4hp38sQlygOaBiDhDSQ8C1Ut9rDn89dHfwdAGdMgsWlhRkekX4aGc5i1XCMjSPs
	 4TId4Keo909Jw==
Date: Tue, 4 Aug 2026 12:22:19 +0100
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
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] mm: constify the pte_offset_map_ro_nolock()
 return value
Message-ID: <anHJ48Glq8EdHatd@lucifer>
References: <20260803164400.531199-1-pfalcato@suse.de>
 <20260803164400.531199-7-pfalcato@suse.de>
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
In-Reply-To: <20260803164400.531199-7-pfalcato@suse.de>

On Mon, Aug 03, 2026 at 05:44:00PM +0100, Pedro Falcato wrote:
> Constify the pte_t * retval from pte_offset_map_ro_nolock(), for which it is
> already pledged that accesses must be read-only. With it, convert the three
> treewide users to use const pte_t *.
>
> khugepaged passes the result right down to fault code (do_swap_page()). This
> leads to a complicated set of conditions that, in order to be correct, must
> not install anything into *vmf->pte. This is not trivial to work around in
> fault code, and as such just trivially cast to non-const pte_t* in the
> meantime.
>
> The other users are far more trivial and the conversion is equally
> trivially simple.

Ah finally more words! :)

>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

With comment updated as below and nits addressed, LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  arch/powerpc/mm/pgtable.c | 2 +-
>  include/linux/mm.h        | 4 ++--
>  include/linux/pgtable.h   | 2 +-
>  mm/filemap.c              | 2 +-
>  mm/khugepaged.c           | 2 +-
>  mm/pgtable-generic.c      | 4 ++--
>  6 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
> index a9be337be3e4..e29db41b6043 100644
> --- a/arch/powerpc/mm/pgtable.c
> +++ b/arch/powerpc/mm/pgtable.c
> @@ -390,7 +390,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
>  	p4d_t *p4d;
>  	pud_t *pud;
>  	pmd_t *pmd;
> -	pte_t *pte;
> +	const pte_t *pte;
>  	spinlock_t *ptl;
>
>  	if (mm == &init_mm)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 7fabe6c66b4b..acf5a5e31d34 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3885,8 +3885,8 @@ static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
>  pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
>  			   unsigned long addr, spinlock_t **ptlp);
>
> -pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> -				unsigned long addr, spinlock_t **ptlp);
> +const pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> +				      unsigned long addr, spinlock_t **ptlp);
>  pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
>  				unsigned long addr, pmd_t *pmdvalp,
>  				spinlock_t **ptlp);
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index dc418553e57a..dd51e722c535 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -112,7 +112,7 @@ static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
>  {
>  	return pte_offset_kernel(pmd, address);
>  }
> -static inline void pte_unmap(pte_t *pte)
> +static inline void pte_unmap(const pte_t *pte)

I was going to question this based on whether the contract holds for
CONFIG_HIGHPTE but actually:

#define pte_unmap(pte)	do {	\
	kunmap_local((pte));	\
	rcu_read_unlock();	\
} while (0)

#define kunmap_local(__addr)					\
do {								\
	BUILD_BUG_ON(__same_type((__addr), struct page *));	\
	__kunmap_local(__addr);					\
} while (0)

static inline void __kunmap_local(const void *vaddr) <-- const!
{
	kunmap_local_indexed(vaddr);
}

So nice (CONFIG_HIGHPTE is going to go away at some point though, right? I
hope... :)


>  {
>  	rcu_read_unlock();
>  }
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6afec636881f..af5d3fcd1b05 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3490,7 +3490,7 @@ static vm_fault_t filemap_fault_recheck_pte_none(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	vm_fault_t ret = 0;
> -	pte_t *ptep;
> +	const pte_t *ptep;
>
>  	/*
>  	 * We might have COW'ed a pagecache folio and might now have an mlocked
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index b237f6e7662a..09efac93a8c6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1170,7 +1170,7 @@ static enum scan_result __collapse_huge_page_swapin(struct mm_struct *mm,
>  			 * Here the ptl is only used to check pte_same() in
>  			 * do_swap_page(), so readonly version is enough.
>  			 */
> -			pte = pte_offset_map_ro_nolock(mm, pmd, addr, &ptl);
> +			pte = (pte_t *) pte_offset_map_ro_nolock(mm, pmd, addr, &ptl);

Hmm yeah this is nasty, but you explain why in the commit message. Could you
extend the comment to explain it?

>  			if (!pte) {
>  				mmap_read_unlock(mm);
>  				result = SCAN_NO_PTE_TABLE;
> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> index b91b1a98029c..2cfc6e608ef4 100644
> --- a/mm/pgtable-generic.c
> +++ b/mm/pgtable-generic.c
> @@ -308,8 +308,8 @@ pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
>  	return NULL;
>  }
>
> -pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
> -				unsigned long addr, spinlock_t **ptlp)
> +const pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,

Can pmd be const too?

> +				      unsigned long addr, spinlock_t **ptlp)
>  {
>  	pmd_t pmdval;
>  	pte_t *pte;
> --
> 2.55.0
>

--
Cheers, Lorenzo

