Return-Path: <nadav.amit@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414zXd01TWzF4ww
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 04:52:45 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id c22-v6so8925pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 11:52:45 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [RFC PATCH 1/3] Revert "mm: always flush VMA ranges affected by
 zap_page_range"
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20180612071621.26775-2-npiggin@gmail.com>
Date: Tue, 12 Jun 2018 11:52:39 -0700
Cc: "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@techsingularity.net>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Message-Id: <71C88E21-25F8-4FA9-998F-8A0EC0FE0444@gmail.com>
References: <20180612071621.26775-1-npiggin@gmail.com>
 <20180612071621.26775-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

at 12:16 AM, Nicholas Piggin <npiggin@gmail.com> wrote:

> This reverts commit 4647706ebeee6e50f7b9f922b095f4ec94d581c3.
>=20
> Patch 99baac21e4585 ("mm: fix MADV_[FREE|DONTNEED] TLB flush miss
> problem") provides a superset of the TLB flush coverage of this
> commit, and even includes in the changelog "this patch supersedes
> 'mm: Always flush VMA ranges affected by zap_page_range v2'".
>=20
> Reverting this avoids double flushing the TLB range, and the less
> efficient flush_tlb_range() call (the mmu_gather API is more precise
> about what ranges it invalidates).
>=20
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> mm/memory.c | 14 +-------------
> 1 file changed, 1 insertion(+), 13 deletions(-)
>=20
> diff --git a/mm/memory.c b/mm/memory.c
> index 7206a634270b..9d472e00fc2d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1603,20 +1603,8 @@ void zap_page_range(struct vm_area_struct *vma, =
unsigned long start,
> 	tlb_gather_mmu(&tlb, mm, start, end);
> 	update_hiwater_rss(mm);
> 	mmu_notifier_invalidate_range_start(mm, start, end);
> -	for ( ; vma && vma->vm_start < end; vma =3D vma->vm_next) {
> +	for ( ; vma && vma->vm_start < end; vma =3D vma->vm_next)
> 		unmap_single_vma(&tlb, vma, start, end, NULL);
> -
> -		/*
> -		 * zap_page_range does not specify whether mmap_sem =
should be
> -		 * held for read or write. That allows parallel =
zap_page_range
> -		 * operations to unmap a PTE and defer a flush meaning =
that
> -		 * this call observes pte_none and fails to flush the =
TLB.
> -		 * Rather than adding a complex API, ensure that no =
stale
> -		 * TLB entries exist when this call returns.
> -		 */
> -		flush_tlb_range(vma, start, end);
> -	}
> -
> 	mmu_notifier_invalidate_range_end(mm, start, end);
> 	tlb_finish_mmu(&tlb, start, end);
> }

Yes, this was in my =E2=80=9Cto check when I have time=E2=80=9D todo =
list, especially since
the flush was from start to end, not even vma->vm_start to vma->vm_end.

The revert seems correct.

Reviewed-by: Nadav Amit <namit@vmware.com>
