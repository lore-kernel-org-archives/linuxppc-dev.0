Return-Path: <linuxppc-dev+bounces-29567-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1243ECC6B33
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Oct 2026 15:48:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5CCc2btTz2xKQ;
	Fri, 16 Oct 2026 02:48:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792079308;
	cv=none; b=Wz9lvd+l6CgQVuRb4hS/HqHtePvin8bEDMmppOzahDxb3Sc1uspR/vjyNTQyjpfisYCMwbiMrjBjvdNCvb/MPvtZ63WFEcEtu4538YZsVBCLnC6hlC24BZODRc0hagOLE4qX6/2CY3fdqJIg+8MRfH4yEsluWz4GtPuJsRqeWvd0NVIoQwsk8bqLErPVk7p0MVVfSg4mwQU0to/ey+HBDlfyjqZ8+VFlL8H47q23l0PRJAAD1Q4fb0cU5+XvRgfQSO3HWXnX7hGPSgyiKFQBW2KJ7ADDcszazb0qEplSQ1IheeUPA6mkqoRWgDbqXml9QgsLoujlqeOI/GwJDg+CcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792079308; c=relaxed/relaxed;
	bh=KKYxbZUwVotNEVMIbNl0nivjJJ0OoZD4nTbemWC4y4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CR/Xq4S2BxugtXB1DMDGb0W7nHbP+9IrPTw+XNRecSKYCgTZeG7EJRAQ6C1Wr+yJ0s0MOzunG+eUzuOlMhFrBuCJl9fgOh5wKcgQR5hhEWJfiFGrDz2o/PAaAJga2OtCARcnttbuCrBz8y6dXP29grB/R3xCBXTAPIYzuilpmk4WEEfwDoLZv9M+1aY/h1eU0k0yxwNvnK1Fb0n1KojZGKuCxokD1POG4fzB7kpEnEzp5Tr5eDC3IiWQ9XvpG+IfKSixoxzSpu4l70Z8dQFK5gw3LeeG/u4SgOK24mRHNqZaOG0tvcyjPd5Uh479eETv98oWPZUGaueZbch9bCRWdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbmIPg3M; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NbmIPg3M;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=david@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5CCb2mmdz2xGr
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2026 02:48:27 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E5723601EF;
	Thu, 15 Oct 2026 15:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ACC11F000C4;
	Thu, 15 Oct 2026 15:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792079304;
	bh=KKYxbZUwVotNEVMIbNl0nivjJJ0OoZD4nTbemWC4y4M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NbmIPg3M1nE3t0SveamnjAch6hz4YUVyRo3Lmxk6mjby6t9kleTRe7gTyNUZe12ha
	 BjmbVMW7+w4ZZvddeg1U7zVqRhplVFB9wY/dJAqnr+R2ILmqliDeTcA3Ybs2idt/lV
	 OE89VnTiuroc9R8SkifPKah08UeOe2N0P2KB0Fn8gGFDdK5HfbExVOqzUwRgogXy6E
	 8QyG2sd+NB4s/CQZ6vfBb58ay703XtCQikPZg26WCfpxVlz3HYRClHZMYZhpiZkjOR
	 vPDpyuTg1N1+kr0dBXwFTuGczz3D1mza4v6BO2/XjwW7RkDNe2ii8ejQsMC3Dg0xHo
	 XshQYVliATdCw==
Message-ID: <79b299ac-a588-43e1-af46-e69d8b3e7aca@kernel.org>
Date: Thu, 15 Oct 2026 16:15:33 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] mm/huge_memory: deposit a page table for a special
 PMD copied by fork
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
 <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-2-85eaec8417f6@virtuozzo.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-2-85eaec8417f6@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 17:46, Konstantin Khorenko wrote:
> Where arch_needs_pgtable_deposit() is true, every huge PMD needs a
> deposited page table. ppc64 in hash mode keeps the hash slot array of
> the huge page in it, so vmf_insert_pfn_pmd() deposits one for each
> special PMD it maps.
> 
> copy_huge_pmd() copies a special PMD into the child without a table.
> The child then dereferences a NULL table:
> 
> - on the first hash fault on the PMD, in __hash_page_thp();
> - on the zap at munmap() or exit, in hash__pmdp_huge_get_and_clear().
> 
> Allocate a table before taking the page table locks and deposit it
> with the copy, as insert_pmd() does.
> 
> Fixes: d1503aa9ab805 ("powerpc/64s: Add support for huge pfnmaps")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com?part=1
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  mm/huge_memory.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index bf788bb231691..2380e4e877f82 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1961,6 +1961,11 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  	pmd = pmdp_get_lockless(src_pmd);
>  	if (unlikely(pmd_present(pmd) && pmd_special(pmd) &&
>  		     !is_huge_zero_pmd(pmd))) {
> +		if (arch_needs_pgtable_deposit()) {
> +			pgtable = pte_alloc_one(dst_mm);
> +			if (unlikely(!pgtable))
> +				goto out;
> +		}
>  		dst_ptl = pmd_lock(dst_mm, dst_pmd);
>  		src_ptl = pmd_lockptr(src_mm, src_pmd);
>  		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> @@ -1974,6 +1979,8 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		if (unlikely(pmd_none(pmd))) {
>  			spin_unlock(src_ptl);
>  			spin_unlock(dst_ptl);
> +			if (pgtable)
> +				pte_free(dst_mm, pgtable);
>  			return -EAGAIN;
>  		}
>  		/*
> @@ -1983,6 +1990,10 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>  		 * wrongly write to the backend MMIO.
>  		 */
>  		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
> +		if (pgtable) {
> +			mm_inc_nr_ptes(dst_mm);
> +			pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
> +		}
>  		goto set_pmd;

It's another sign that the pmd_special() is just entirely misplaced.

Let's get that sorted and it will just naturally fix the other case.

-- 
Cheers,

David

