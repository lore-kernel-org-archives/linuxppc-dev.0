Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4D9C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 11:06:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936EA21773
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 11:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936EA21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443dGj15MkzDqL2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 22:06:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443dDS0TZLzDqC7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 22:04:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 443dDR05njz9s5c;
 Tue, 19 Feb 2019 22:04:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc/mm: Handle mmap_min_addr correctly in
 get_unmapped_area callback
In-Reply-To: <20190215081647.24876-1-aneesh.kumar@linux.ibm.com>
References: <20190215081647.24876-1-aneesh.kumar@linux.ibm.com>
Date: Tue, 19 Feb 2019 22:04:49 +1100
Message-ID: <87k1hwavji.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> After we ALIGN up the address we need to make sure we didn't overflow
> and resulted in zero address. In that case, we need to make sure that
> the returned address is greater than mmap_min_addr.
>
> Also when doing top-down search the low_limit is not PAGE_SIZE but rather
> max(PAGE_SIZE, mmap_min_addr). This handle cases in which mmap_min_addr >
> PAGE_SIZE.
>
> This fixes selftest va_128TBswitch --run-hugetlb reporting failures when
> run as non root user for
>
> mmap(-1, MAP_HUGETLB)
> mmap(-1, MAP_HUGETLB)
>
> We also avoid the first mmap(-1, MAP_HUGETLB) returning NULL address as mmap address
> with this change

So we think this is not a security issue, because it only affects
whether we choose an address below mmap_min_addr, not whether we
actually allow that address to be mapped.

ie. there are existing capability checks to prevent a user mapping below
mmap_min_addr and those will still be honoured even without this fix.

However there is a bug in that a non-root user requesting address -1
will be given address 0 which will then fail, whereas they should have
been given something else that would have succeeded.

Did I get that all right?

> CC: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Seems like this should have a Fixes: tag?

cheers

> ---
>  arch/powerpc/mm/hugetlbpage-radix.c |  5 +++--
>  arch/powerpc/mm/slice.c             | 10 ++++++----
>  2 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
> index 2486bee0f93e..97c7a39ebc00 100644
> --- a/arch/powerpc/mm/hugetlbpage-radix.c
> +++ b/arch/powerpc/mm/hugetlbpage-radix.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/mm.h>
>  #include <linux/hugetlb.h>
> +#include <linux/security.h>
>  #include <asm/pgtable.h>
>  #include <asm/pgalloc.h>
>  #include <asm/cacheflush.h>
> @@ -73,7 +74,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  	if (addr) {
>  		addr = ALIGN(addr, huge_page_size(h));
>  		vma = find_vma(mm, addr);
> -		if (high_limit - len >= addr &&
> +		if (high_limit - len >= addr && addr >= mmap_min_addr &&
>  		    (!vma || addr + len <= vm_start_gap(vma)))
>  			return addr;
>  	}
> @@ -83,7 +84,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  	 */
>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> -	info.low_limit = PAGE_SIZE;
> +	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
>  	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
>  	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
>  	info.align_offset = 0;
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 06898c13901d..aec91dbcdc0b 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -32,6 +32,7 @@
>  #include <linux/export.h>
>  #include <linux/hugetlb.h>
>  #include <linux/sched/mm.h>
> +#include <linux/security.h>
>  #include <asm/mman.h>
>  #include <asm/mmu.h>
>  #include <asm/copro.h>
> @@ -377,6 +378,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
>  	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
>  	unsigned long addr, found, prev;
>  	struct vm_unmapped_area_info info;
> +	unsigned long min_addr = max(PAGE_SIZE, mmap_min_addr);
>  
>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
> @@ -393,7 +395,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
>  	if (high_limit > DEFAULT_MAP_WINDOW)
>  		addr += mm->context.slb_addr_limit - DEFAULT_MAP_WINDOW;
>  
> -	while (addr > PAGE_SIZE) {
> +	while (addr > min_addr) {
>  		info.high_limit = addr;
>  		if (!slice_scan_available(addr - 1, available, 0, &addr))
>  			continue;
> @@ -405,8 +407,8 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
>  		 * Check if we need to reduce the range, or if we can
>  		 * extend it to cover the previous available slice.
>  		 */
> -		if (addr < PAGE_SIZE)
> -			addr = PAGE_SIZE;
> +		if (addr < min_addr)
> +			addr = min_addr;
>  		else if (slice_scan_available(addr - 1, available, 0, &prev)) {
>  			addr = prev;
>  			goto prev_slice;
> @@ -528,7 +530,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  		addr = _ALIGN_UP(addr, page_size);
>  		slice_dbg(" aligned addr=%lx\n", addr);
>  		/* Ignore hint if it's too large or overlaps a VMA */
> -		if (addr > high_limit - len ||
> +		if (addr > high_limit - len || addr < mmap_min_addr ||
>  		    !slice_area_is_free(mm, addr, len))
>  			addr = 0;
>  	}
> -- 
> 2.20.1
