Return-Path: <linuxppc-dev+bounces-1038-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06564CD4F59
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Sep 2024 08:58:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WztYn4hW8z2ypV;
	Thu,  5 Sep 2024 18:58:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.178
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725526701;
	cv=none; b=PoCBZjq8CwplOECEENlp+FsWYqm7+mbfNQhmICBp/6qt6lPeNXHDR21QkXz6EFfRAcQCUD7jvskIS9EHsUs6Kq/aHnrlQvmhK80GGus2SQWSAsiEc0WoaLDzBRDBjRPHl802NQgkR9mdUy7GtwQBSvh77FY2OpnDtoOAtGdFi3CYqOZvvpf1NiuRl5X0guHQSWYV19ugpXOS6vuhwf88Geddd19XumH5yqW6cuZVV1wGsfOPZOXUHZFf14EMQddsICLNLOKHx9GzbqNC+eEfXj42piIY1iAWQa6Uhc9XHzu3EEdVPIsQPunbdJf3VfDhlRapq/brFIWLhNj6jsvz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725526701; c=relaxed/relaxed;
	bh=CZtqExsDOIYp5HqPgrPdq+CzPwDzSkiYY8yvT9Jxwhw=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type; b=SiDVPdC4gs+0IjyOZKFc+wcxOaxcBgg0ZVj4CZ05xWjCcS5b7zckuwQozVUFpwKkEbB6q+DoBojNKL6mQ18hmETGKFTbVt8IHsZ5ubdi6EHyihDCzFy6OhsCN5/f6P/3dOU+2FtBfEh6wXV9gv9o+NBo2Cw3bg3pVPFHVt6pgyqJLje0b9LRJjzCMixxNU4doCbDFkSgiZAFC3eGTojMonPQ7EXg6JSidhZ8ypTtNOk2CYg4jh9WRwgxEusBo+fdTThdQR3qfRaBQv/QlNd3/nfWIuNcyEdMcajkSZAmRsADuOYqxA0hSqYw+kbxThR+PNU30buauMTXv4A3OskbUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hHL2mCMb; dkim-atps=neutral; spf=pass (client-ip=91.218.175.178; helo=out-178.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hHL2mCMb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.178; helo=out-178.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WztYl4gCCz2yn4
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Sep 2024 18:58:17 +1000 (AEST)
Message-ID: <d8e2ef66-c345-43f0-9989-f20f16df34d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725526676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CZtqExsDOIYp5HqPgrPdq+CzPwDzSkiYY8yvT9Jxwhw=;
	b=hHL2mCMbuNK+Hs/O408hs/N7aassZHQuWT3l/9qpf3OwEqwDoq18fUNQy7T4vQkPAhr7Ip
	KhS7GNRdIL7YXvr4Kwk1nBVf05wbZgGwqSvv3B9YBaijU8YfoK9B1DhEgjDylQD3XI58dx
	j3oiLIpOO5R1TF/4CpCnFRK2Hn4WWvc=
Date: Thu, 5 Sep 2024 16:57:44 +0800
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 08/14] mm: copy_pte_range() use
 pte_offset_map_rw_nolock()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 david@redhat.com, hughd@google.com, willy@infradead.org, vbabka@kernel.org,
 akpm@linux-foundation.org, rppt@kernel.org, vishal.moola@gmail.com,
 peterx@redhat.com, ryan.roberts@arm.com, christophe.leroy2@cs-soprasteria.com
References: <20240904084022.32728-1-zhengqi.arch@bytedance.com>
 <20240904084022.32728-9-zhengqi.arch@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20240904084022.32728-9-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2024/9/4 16:40, Qi Zheng wrote:
> In copy_pte_range(), we may modify the src_pte entry after holding the
> src_ptl, so convert it to using pte_offset_map_rw_nolock(). Since we may
> free the PTE page in retract_page_tables() without holding the read lock
> of mmap_lock, so we still need to get pmdval and do pmd_same() check after
> the ptl is held.

See commit 3db82b9374ca92, copy_pte_range and retract_page_tables
are using vma->anon_vma to be exclusive.

retract_page_tables()                    copy_page_range()
     vma_interval_tree_foreach()              if (!vma_needs_copy())
         if (READ_ONCE(vma->anon_vma))            return 0;
             continue;                        copy_pte_range()

So I think mmap write lock here is also used for keeping ->anon_vma stable.
And we do not need pmd_same().

Muchun,
Thanks.
>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
> Hi Muchun, since the code has changed, I dropped your Reviewed-by tag here.
>
>   mm/memory.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 06674f94b7a4e..47974cc4bd7f2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1082,6 +1082,7 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>   	struct mm_struct *src_mm = src_vma->vm_mm;
>   	pte_t *orig_src_pte, *orig_dst_pte;
>   	pte_t *src_pte, *dst_pte;
> +	pmd_t pmdval;
>   	pte_t ptent;
>   	spinlock_t *src_ptl, *dst_ptl;
>   	int progress, max_nr, ret = 0;
> @@ -1107,13 +1108,28 @@ copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>   		ret = -ENOMEM;
>   		goto out;
>   	}
> -	src_pte = pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
> +
> +	/*
> +	 * Since we may free the PTE page in retract_page_tables() without
> +	 * holding the read lock of mmap_lock, so we still need to do a
> +	 * pmd_same() check after holding the PTL.
> +	 */
> +	src_pte = pte_offset_map_rw_nolock(src_mm, src_pmd, addr, &pmdval,
> +					   &src_ptl);
>   	if (!src_pte) {
>   		pte_unmap_unlock(dst_pte, dst_ptl);
>   		/* ret == 0 */
>   		goto out;
>   	}
>   	spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
> +
> +	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(src_pmd)))) {
> +		pte_unmap_unlock(src_pte, src_ptl);
> +		pte_unmap_unlock(dst_pte, dst_ptl);
> +		/* ret == 0 */
> +		goto out;
> +	}
> +
>   	orig_src_pte = src_pte;
>   	orig_dst_pte = dst_pte;
>   	arch_enter_lazy_mmu_mode();


