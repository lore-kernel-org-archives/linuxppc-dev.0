Return-Path: <linuxppc-dev+bounces-18830-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF0810A88F7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 17:47:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhWSg1TdDz2yZc;
	Fri, 27 Mar 2026 04:47:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774547251;
	cv=none; b=hPi538A3n6XGM/P611KCUpgNJljpmkzja53uum5JRj9ZJ+gP3qDScSUKW8K6nNCgS02GR9kfdz9KiR2K2n89Sq5QoCjVi5zKx3U+DAum6lhyqYvXPkWxmltBJ+fWxZpn+yIBTRxbYxtLH6getzhvaYdh4gQqy6o9ky8eREnbb554ewDtqcoOhmJ9RyWZW1vRlSoT4Rfq5KA9TiCMAVNdOwypzT7XWVHNO2++MC2BCY3g/Gjd/xyhmSWlrHH+uJq4gjSE5Hy6OFgu41PrUavPgrJFQvmv/KnzVuce/gIcmBbRwby7hXpvRPXXUN1vtNmh9aoWNpVAfpW1NYP6uyv5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774547251; c=relaxed/relaxed;
	bh=ClNZmmt7/DuufbAG22btXQTihR3/iUKnZFS4OWdyu/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TeEGkqlFZNjQFDEvew63pBQhKyzPYV3l6A2ZeLOi6xwKET16VIMnmNYwoMW0khgL/Jts4Vo/xdK3tLGhVxyDLHWOHxEx04qkKLwr8XNLNbLimJxSDSiDsUoPhtUu1SaUWTKXozKpZYA5dF7pQhnBkj2BMB/ueWHWHzt1YKPOfvuAizyeLjERd5QQRjhVq7vL1IBjM78xeb2/5UHwQ3SySEdlTwsMf6VMqtXHF9fjHlAMgAPoREVLB5386wKSqniKFTXKDPcWYdKrJY//2VPfigOJKjYDiCvS6EN/JZ7e4UMIfKpTr9EL2X840/zQHH15RtHKb0fAHseS8n42aXzU3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WVhjgK8G; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WVhjgK8G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhWSf2Lnjz2yVL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 04:47:30 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 381FD60054;
	Thu, 26 Mar 2026 17:47:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB15C2BCB0;
	Thu, 26 Mar 2026 17:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774547247;
	bh=gjlcKSW1jg7hpudpA3j7TSDpTKC3ZH1jovemX67eUk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVhjgK8G+avnzkT9J4VCT5Ajwxv6Nw9lmhdBxKPu+G2YJKdOL14UdGqe50F4snrsC
	 NVH+vSXSNf1HHbcFR/+f2x9y41eI3bC6CK5CO2EGCT6m+5FeNcEK93Duev8ok+9hLh
	 rltr8Yn1nZgTgXAnHwz02Uom0SDFAYzzp8BUPSDFQcn/9p92NixbjGM6ByVbKiqJl9
	 l7MArtg/eUk3khx3v5Lz27EaZh5r5yPNSHtay3vvbl5y+Z0qPwyHIEiRtKXYW17sAU
	 6blLKMq7likwowCKZf94wRZoENiVNmvcVTbnzCe0GL/P4Ss4qa8lEN5FnbCpC1whtw
	 1O9wc36/6bl2g==
Date: Thu, 26 Mar 2026 17:47:25 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 5/6] mm: use vma_start_write_killable() in
 process_vma_walk_lock()
Message-ID: <7d558eaa-99d5-4421-9dac-ba17441691f9@lucifer.local>
References: <20260326080836.695207-1-surenb@google.com>
 <20260326080836.695207-6-surenb@google.com>
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
In-Reply-To: <20260326080836.695207-6-surenb@google.com>

On Thu, Mar 26, 2026 at 01:08:35AM -0700, Suren Baghdasaryan wrote:
> Replace vma_start_write() with vma_start_write_killable() when
> process_vma_walk_lock() is used with PGWALK_WRLOCK option.
> Adjust its direct and indirect users to check for a possible error
> and handle it. Ensure users handle EINTR correctly and do not ignore
> it.
>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

> ---
>  fs/proc/task_mmu.c | 12 ++++++------
>  mm/mempolicy.c     |  1 +
>  mm/pagewalk.c      | 22 +++++++++++++++-------
>  3 files changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e091931d7ca1..33e5094a7842 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1774,15 +1774,15 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  	struct vm_area_struct *vma;
>  	enum clear_refs_types type;
>  	int itype;
> -	int rv;
> +	int err;
>
>  	if (count > sizeof(buffer) - 1)
>  		count = sizeof(buffer) - 1;
>  	if (copy_from_user(buffer, buf, count))
>  		return -EFAULT;
> -	rv = kstrtoint(strstrip(buffer), 10, &itype);
> -	if (rv < 0)
> -		return rv;
> +	err = kstrtoint(strstrip(buffer), 10, &itype);
> +	if (err)
> +		return err;
>  	type = (enum clear_refs_types)itype;
>  	if (type < CLEAR_REFS_ALL || type >= CLEAR_REFS_LAST)
>  		return -EINVAL;
> @@ -1824,7 +1824,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  						0, mm, 0, -1UL);
>  			mmu_notifier_invalidate_range_start(&range);
>  		}
> -		walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
> +		err = walk_page_range(mm, 0, -1, &clear_refs_walk_ops, &cp);
>  		if (type == CLEAR_REFS_SOFT_DIRTY) {
>  			mmu_notifier_invalidate_range_end(&range);
>  			flush_tlb_mm(mm);
> @@ -1837,7 +1837,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
>  	}
>  	put_task_struct(task);
>
> -	return count;
> +	return err ? : count;
>  }
>
>  const struct file_operations proc_clear_refs_operations = {
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index c38a90487531..336753a4b2b2 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -969,6 +969,7 @@ static const struct mm_walk_ops queue_pages_lock_vma_walk_ops = {
>   *      (a hugetlbfs page or a transparent huge page being counted as 1).
>   * -EIO - a misplaced page found, when MPOL_MF_STRICT specified without MOVEs.
>   * -EFAULT - a hole in the memory range, when MPOL_MF_DISCONTIG_OK unspecified.
> + * -EINTR - walk got terminated due to pending fatal signal.
>   */
>  static long
>  queue_pages_range(struct mm_struct *mm, unsigned long start, unsigned long end,
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index 3ae2586ff45b..eca7bc711617 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -443,14 +443,13 @@ static inline void process_mm_walk_lock(struct mm_struct *mm,
>  		mmap_assert_write_locked(mm);
>  }
>
> -static inline void process_vma_walk_lock(struct vm_area_struct *vma,
> -					 enum page_walk_lock walk_lock)
> +static int process_vma_walk_lock(struct vm_area_struct *vma,
> +				 enum page_walk_lock walk_lock)
>  {
>  #ifdef CONFIG_PER_VMA_LOCK
>  	switch (walk_lock) {
>  	case PGWALK_WRLOCK:
> -		vma_start_write(vma);
> -		break;
> +		return vma_start_write_killable(vma);
>  	case PGWALK_WRLOCK_VERIFY:
>  		vma_assert_write_locked(vma);
>  		break;
> @@ -462,6 +461,7 @@ static inline void process_vma_walk_lock(struct vm_area_struct *vma,
>  		break;
>  	}
>  #endif
> +	return 0;
>  }
>
>  /*
> @@ -505,7 +505,9 @@ int walk_page_range_mm_unsafe(struct mm_struct *mm, unsigned long start,
>  			if (ops->pte_hole)
>  				err = ops->pte_hole(start, next, -1, &walk);
>  		} else { /* inside vma */
> -			process_vma_walk_lock(vma, ops->walk_lock);
> +			err = process_vma_walk_lock(vma, ops->walk_lock);
> +			if (err)
> +				break;
>  			walk.vma = vma;
>  			next = min(end, vma->vm_end);
>  			vma = find_vma(mm, vma->vm_end);
> @@ -722,6 +724,7 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
>  		.vma		= vma,
>  		.private	= private,
>  	};
> +	int err;
>
>  	if (start >= end || !walk.mm)
>  		return -EINVAL;
> @@ -729,7 +732,9 @@ int walk_page_range_vma_unsafe(struct vm_area_struct *vma, unsigned long start,
>  		return -EINVAL;
>
>  	process_mm_walk_lock(walk.mm, ops->walk_lock);
> -	process_vma_walk_lock(vma, ops->walk_lock);
> +	err = process_vma_walk_lock(vma, ops->walk_lock);
> +	if (err)
> +		return err;
>  	return __walk_page_range(start, end, &walk);
>  }
>
> @@ -752,6 +757,7 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>  		.vma		= vma,
>  		.private	= private,
>  	};
> +	int err;
>
>  	if (!walk.mm)
>  		return -EINVAL;
> @@ -759,7 +765,9 @@ int walk_page_vma(struct vm_area_struct *vma, const struct mm_walk_ops *ops,
>  		return -EINVAL;
>
>  	process_mm_walk_lock(walk.mm, ops->walk_lock);
> -	process_vma_walk_lock(vma, ops->walk_lock);
> +	err = process_vma_walk_lock(vma, ops->walk_lock);
> +	if (err)
> +		return err;
>  	return __walk_page_range(vma->vm_start, vma->vm_end, &walk);
>  }
>
> --
> 2.53.0.1018.g2bb0e51243-goog
>

